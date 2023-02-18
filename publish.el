(require 'ox-html)
(require 'ox-latex)
(require 'ox-publish)

(setq user-full-name "Alexander Neville")

(setq
      org-export-headline-levels 3
      org-export-with-archived-trees nil
      org-export-exclude-tags nil
      org-export-default-language nil
      org-export-preserve-breaks nil
      org-export-with-section-numbers nil
      org-export-select-tags nil
      org-export-with-author nil
      ;; org-export-with-broken-links nil
      org-export-with-clocks nil
      org-export-with-creator nil
      org-export-with-date nil
      org-export-with-drawers nil
      org-export-with-email nil
      ;; org-export-with-emphasize nil
      org-export-with-fixed-width nil
      org-export-with-footnotes nil
      ;; org-export-with-latex nil
      org-export-with-planning nil
      org-export-with-priority nil
      org-export-with-properties nil
      org-export-with-special-strings nil
      org-export-with-sub-superscripts '{}
      ;; org-export-with-tables nil
      org-export-with-tags nil
      org-export-with-tasks nil
      org-export-with-timestamps nil
      org-export-with-title nil
      org-export-with-toc nil
      org-export-with-todo-keywords nil
)

(setq
chapter-redef
"\\patchcmd{\\chapter}{\\thispagestyle{plain}}{\\thispagestyle{fancy}}{}{}
\\makeatletter
\\def\\@makechapterhead#1{
  \\vspace*{50\\p@}
  {\\parindent \\z@ \\raggedright \\normalfont
    \\ifnum \\c@secnumdepth >\\m@ne
        \\huge\\bfseries \\@chapapp\\space \\thechapter
        \\Huge\\bfseries \\thechapter.\\space%
        \\par\\nobreak
        \\vskip 20\\p@
    \\fi
    \\interlinepenalty\\@M
    \\Huge \\bfseries #1\\par\\nobreak
    \\vskip 40\\p@
  }}
\\makeatother\n"
report-fancyheader-def
"\\usepackage{fancyhdr}
\\pagestyle{fancy}
\\renewcommand{\\sectionmark}[1]{\\markright{\\thesection~- ~#1}}
\\renewcommand{\\chaptermark}[1]{\\markboth{\\chaptername~\\thechapter. \\textit{#1}}{}}
\\fancyhf{}
\\rfoot{page \\textbf{\\thepage}}
\\lfoot{\\nouppercase{\\leftmark}}
\\renewcommand{\\headrulewidth}{0pt}
\\renewcommand{\\footrulewidth}{0.4pt}\n"
article-fancyheader-def
"\\usepackage{fancyhdr}
\\pagestyle{fancy}
\\fancyhf{}
\\rfoot{page \\textbf{\\thepage}}
\\lfoot{\\nouppercase{\\leftmark}}
\\renewcommand{\\headrulewidth}{0pt}
\\renewcommand{\\footrulewidth}{0.4pt}\n"
common-head
"\\usepackage{svg}
\\svgsetup{inkscapelatex=false}
\\usepackage{blindtext}
\\usepackage{tcolorbox}
\\usepackage{etoolbox}
\\hypersetup{hidelinks}
\\usemintedstyle{bw}
\\setminted{autogobble=true, breaklines=true, breakbytokenanywhere=true, fontsize=\\small, xleftmargin=1cm, xrightmargin=1cm}
\\usepackage[indent=0.5cm]{parskip}
\\usepackage[a4paper, includefoot, margin=2.54cm]{geometry}\n"
default-head-setup
"\\usepackage[utf8]{inputenc}
\\usepackage{libertine}
\\usepackage{libertinust1math}
\\usepackage[T1]{fontenc}
\\usepackage{graphicx}
\\usepackage{longtable}
\\usepackage{wrapfig}
\\usepackage{rotating}
\\usepackage[normalem]{ulem}
\\usepackage{amsmath}
\\usepackage{amssymb}
\\usepackage{capt-of}
\\usepackage{hyperref}
\\usepackage{minted}\n"
)

(setq long-report   '(("\\part{%s}" . "\\part*{%s}")
		      ("\\chapter{%s}" . "\\chapter*{%s}")
		      ("\\section{%s}" . "\\section*{%s}")
		      ("\\subsection{%s}" . "\\subsection*{%s}")
		      ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
      short-report  '(("\\chapter{%s}" . "\\chapter*{%s}")
		      ("\\section{%s}" . "\\section*{%s}")
		      ("\\subsection{%s}" . "\\subsection*{%s}")
		      ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
      custom-article '(("\\section{%s}" . "\\section*{%s}")
		      ("\\subsection{%s}" . "\\subsection*{%s}")
		      ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))

(setq report-common-header-string (concat "\\documentclass{report}\n[NO-DEFAULT-PACKAGES]\n[NO-PACKAGES]\n" default-head-setup chapter-redef common-head report-fancyheader-def "[EXTRA]"))
(add-to-list 'short-report report-common-header-string)
(add-to-list 'long-report report-common-header-string)
(add-to-list 'custom-article (concat "\\documentclass{article}\n[NO-DEFAULT-PACKAGES]\n[NO-PACKAGES]\n" default-head-setup common-head article-fancyheader-def "[EXTRA]"))
(add-to-list 'short-report "short-report")
(add-to-list 'long-report "long-report")
(add-to-list 'custom-article "custom-article")

(with-eval-after-load 'ox-latex
    (add-to-list 'org-latex-classes long-report)
    (add-to-list 'org-latex-classes short-report)
    (add-to-list 'org-latex-classes custom-article))

(setq org-latex-listings 'minted
      org-export-in-background t
      org-latex-compiler "pdflatex"
      org-latex-pdf-process '("latexmk -f -pdf -%latex -shell-escape -interaction=nonstopmode -output-directory=%o %f"))

(setq org-html-mathjax-options 
      '((path "https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.0/MathJax.js?config=TeX-AMS_HTML")
        (scale "100")
        (align "center")
        (font "STIX-Web")
        (linebreaks "false")
        (autonumber "AMS")
        (indent "0em")
        (multlinewidth "85%")
        (tagindent ".8em")
        (tagside "right")))

(setq org-html-self-link-headlines t
      org-html-metadata-timestamp-format "%H:%M:%S %d/%m/%Y"
      org-html-creator-string "<a href=\"https://www.gnu.org/software/emacs/\">Emacs</a> 28.2 + <a href=\"https://orgmode.org\">Org mode</a> 9.5.5")

(setq org-html-head-extra
"
<link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet'>
<link href='https://fonts.googleapis.com/css?family=Roboto Mono' rel='stylesheet'>
<link href=\"/res/light.css\" rel=\"stylesheet\" id=\"light-stylesheet\" />
<link
  href=\"/res/dark.css\"
  rel=\"stylesheet alternate\"
  id=\"dark-stylesheet\"
/>
<link href=\"/res/style.css\" rel=\"stylesheet\" />
<link rel=\"icon\" href=\"/res/site_logo.svg\" />
<script src=\"/res/script.js\" defer></script>
")

(setq org-html-preamble
      "<div class=\"header\">
  <div class=\"main-header-line\">
    <div class=\"justify-items content-width\">
      <div class=\"justify-items site-banner\">
        <div id=\"site_icon_container\">
            <object
            id=\"site_icon\"
            data=\"/res/site_logo.svg\"
            type=\"image/svg+xml\"
            height=\"30px\"
            ></object>
        </div>
        <a href=\"/\">alexneville.co.uk</a>
      </div>
      <div class=\"page-controls\">
        <button id=\"theme_switch_button\" type=\"button\">
          <object
            id=\"theme_switch_icon\"
            data=\"/res/theme_switch_light.svg\"
            type=\"image/svg+xml\"
            height=\"100%%\"
          ></object>
        </button>
        <button id=\"page_start_button\" type=\"button\">
          <object
            id=\"page_start_icon\"
            data=\"/res/up_triangle_light.svg\"
            type=\"image/svg+xml\"
            height=\"100%%\"
          ></object>
        </button>
        <button id=\"menu_button\" type=\"button\">
          <object
            id=\"menu_icon\"
            data=\"/res/menu_icon_light.svg\"
            type=\"image/svg+xml\"
            height=\"100%%\"
          ></object>
        </button>
      </div>
    </div>
  </div>
  <div id=\"dropdown\">
    <div class=\"content-width\">
      <ul>
        <li><a href=\"/index.html\">Home</a></li>
        <li><a href=\"/license.html\">License</a></li>
        <li><a href=\"/blog/\">Blog</a></li>
      </ul>
    </div>
  </div>
  <div class=\"breadcrumb-line\">
    <div id=\"breadcrumbs\" class=\"content-width\">
      <a href=\"/index.html\">~/</a>
    </div>
  </div>
</div>
")

(setq org-html-postamble
      "<div class=\"footer\">
  <div class=\"content-width\">
    <p>Copyright &copy 2023 Alexander Neville. Original content is distributed under copyleft terms (CC BY-SA / GNU GPL), per the <a href=\"/license.html\">content license</a>.</p>
    <p>Made with %c @ (%T), <a href=\"https://github.com/alexanderneville/website\">view source</a>.</p>
  </div>
</div>
"
      )

(setq org-publish-project-alist
      '(
        ("main_html"
         :recursive nil
         :base-directory "./src"
         :publishing-directory "./out/html"
         :base-extension "org"
         :publishing-function org-html-publish-to-html
         ;; options
         :headline-levels 5
         :section-numbers nil
         :with-author t
         :with-creator nil
         :with-date nil
         :with-timestamps nil
         :with-title nil
         :with-author nil
         :with-date nil
         :with-toc nil
         :with-todo-keywords nil
         :html-head-include-default-style nil
         :html-head-include-scripts nil
         )

        ("blog_html"
         :recursive t
         :base-directory "./src/blog"
         :publishing-directory "./out/html/blog"
         :base-extension "org"
         :publishing-function org-html-publish-to-html
         :headline-levels 5
         :section-numbers nil
         :with-author nil
         :with-creator nil
         :with-date nil
         :with-timestamps nil
         :with-title t
         :with-toc 1
         :with-todo-keywords nil
         :html-head-include-default-style nil
         :html-head-include-scripts nil
         :exclude "tables/"
         )

        ("main_html_resources"
         :recursive t
         :base-directory "./src/res"
         :publishing-directory "./out/html/res"
         :base-extension "pdf\\|jpg\\|gif\\|png\\|svg\\|css\\|js"
         :publishing-function org-publish-attachment)

        ("blog_html_resources"
         :recursive t
         :base-directory "./src/blog/res"
         :publishing-directory "./out/html/blog/res"
         :base-extension "pdf\\|jpg\\|gif\\|png\\|svg\\|css\\|js"
         :publishing-function org-publish-attachment)
        
        ))

(org-publish-all t)
