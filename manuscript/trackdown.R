readRenviron("~/.Renviron")

library(trackdown)

upload_file("manuscript/zcurve.qmd",
            shared_drive = NULL)

update_file("manuscript/zcurve.qmd",
            hide_code=TRUE,
            path_output="manuscript/zcurve.docx")
2