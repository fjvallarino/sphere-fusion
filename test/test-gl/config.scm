(sphere: "test-gl")
(paths:
 (fusion: "/data/projects/scheme-fusion"))
(dependencies:
 (main
  (include
   (opengl: gl-es#))
  (load
   (opengl: gl-es)))
 ((= main version: (debug))
  (include
   (opengl: gl-es#))
  (load
   (opengl: gl-es version: (debug)))))