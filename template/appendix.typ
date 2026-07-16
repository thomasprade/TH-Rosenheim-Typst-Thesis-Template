// Appendix — demonstrates the built-in generative-AI-usage declaration.
// Passed to `thro` via `appendix: include "appendix.typ"` in main.typ.
// Every `ai-declaration(...)` call becomes one lettered appendix chapter (A, B, …).
// You can of course add your own appendix chapters here with normal `= Heading`s.

#import "@local/thro:0.1.0": ai-declaration

// The original template ships both a German and an English version. Keep the one
// matching your thesis language and delete the other (or keep both, as here).
#ai-declaration(language: "de")
#ai-declaration(language: "en")
