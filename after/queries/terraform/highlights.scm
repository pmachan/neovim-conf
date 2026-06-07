; extends

; HCL block labels — variable "name", resource "type" "name", module "x", …
;
; The inherited hcl query paints the label's text and quotes as a generic
; @string (green). Once terraform-ls attaches it re-renders the label as plain
; text (the enumMember semantic token), so without this the label flashes green
; for the 1–2s before the LSP is ready. Capture the whole label string_lit as
; @variable (plain white in this theme) at a higher priority than @string, so
; treesitter shows it white from the first frame — matching the eventual LSP
; color. @none does NOT work here: it resolves to an empty highlight that sets
; no foreground, so the lower-priority green @string would still win.
;
; A string VALUE is nested under (expression (literal_value …)), never a direct
; child of (block), so it is not matched here and stays green.
((block
  (string_lit) @variable)
  (#set! "priority" 105))
