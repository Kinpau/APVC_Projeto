#let code(
  line-spacing: 5pt,
  line-offset: 5pt,
  numbering: true,
  inset: 5pt,
  radius: 3pt,
  number-align: left,
  stroke: 1pt + luma(180),
  fill: luma(250),
  text-style: (),
  width: 100%,
  lines: auto,
  lang: none,
  lang-box: (
    gutter: 5pt,
    radius: 3pt,
    outset: 1.75pt,
    fill: rgb("#ffbfbf"),
    stroke: 1pt + rgb("#ff8a8a") 
  ),
  lang-box-contents: none,
  source
) = {
  if(lang-box-contents == none) {
    lang-box-contents = text(size: 1.25em, raw(lang))
  }
  show raw.line: set text(..text-style)
  show raw: set text(..text-style)
  
  set par(justify: false, leading: line-spacing)
  
  let label-regex = regex("<((\w|_|-)+)>[ \t\r\f]*(\n|$)")

  let labels = source
    .text
    .split("\n")
    .map(line => {
      let match = line.match(label-regex)
  
      if match != none {
        match.captures.at(0)
      } else {
        none
      }
    })

  // We need to have different lines use different tables to allow for the text after the lang-box to go in its horizontal space.
  // This means we need to calculate a size for the number column. This requires AOT knowledge of the maximum number horizontal space.
  let number-style(number) = text(
    fill: stroke.paint,
    size: 1.25em,
    raw(str(number))
  )

  let unlabelled-source = source.text.replace(
    label-regex,
    "\n"
  )

  show raw.where(block: true): it => style(styles => {
    let lines = lines

    if lines == auto {
      lines = (auto, auto)
    }

    if lines.at(0) == auto {
      lines.at(0) = 1
    }

    if lines.at(1) == auto {
      lines.at(1) = it.lines.len()
    }

    lines = (lines.at(0) - 1, lines.at(1))

    let maximum-number-length = measure(number-style(lines.at(1)), styles).width

    block(
      inset: inset,
      radius: radius,
      stroke: stroke,
      fill: fill,
      width: width,
      {
        stack(
          dir: ttb,
          spacing: line-spacing,
          ..it
            .lines
            .slice(..lines)
            .map(line => table(
              stroke: none,
              inset: 0pt,
              columns: (maximum-number-length, 1fr, auto),
              column-gutter: (line-offset, if line.number - 1 == lines.at(0) { lang-box.gutter } else { 0pt }),
              align: (number-align, left, top + right),
              if numbering {
                text(
                  fill: stroke.paint,
                  size: 1.25em,
                  raw(str(line.number))
                )
              },
              {
                let line-label = labels.at(line.number - 1)
                
                if line-label != none {
                  show figure: it => it.body
                  
                  counter(figure.where(kind: "sourcerer")).update(line.number - 1)
                  [
                    #figure(supplement: "Line", kind: "sourcerer", outlined: false, line)
                    #label(line-label)
                  ]
                } else {
                  line
                }
              },
              if line.number - 1 == lines.at(0) and lang != none {
                rect(
                  fill: lang-box.fill,
                  stroke: lang-box.stroke,
                  inset: 0pt,
                  outset: lang-box.outset,
                  radius: radius,
                  lang-box-contents,
                  
                )
              }
            ))
            .flatten()
        )
      }
    )
  })

  raw(block: true, lang: source.lang, unlabelled-source)
}