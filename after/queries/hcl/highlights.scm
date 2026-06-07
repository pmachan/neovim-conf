; extends

; HCL block labels — see after/queries/terraform/highlights.scm for the full
; rationale. The terraform parser inherits these hcl rules; this copy covers
; plain .hcl / .tftest.hcl files (filetype/parser "hcl") so their block labels
; render as plain white text instead of flashing green before the LSP attaches.
((block
  (string_lit) @variable)
  (#set! "priority" 105))
