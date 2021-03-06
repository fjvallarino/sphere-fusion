;;; Copyright (c) 2012 by Álvaro Castro Castilla
;;; Test for Cairo with OpenGL

(##import-include core: base-macros)
(##import sdl2: sdl2 version: (debug))
(##import cairo: cairo version: (debug))
(##import opengl: gl version: (debug))
(##import-include "templates/opengl-cairo/common/src/gl-cairo.scm")

(define (main)
  ((fusion:create-simple-gl-cairo '(width: 1280 height: 752))
   (lambda (event world)
     (let ((type (SDL_Event-type event)))
       (cond
        ((= type SDL_QUIT)
         'exit)
        ((= type SDL_MOUSEBUTTONDOWN)
         (SDL_LogVerbose SDL_LOG_CATEGORY_APPLICATION "Button down")
         'new-world-modified-by-mouse-button-event)
        ((= type SDL_KEYDOWN)
         (SDL_LogVerbose SDL_LOG_CATEGORY_APPLICATION "Key down")
         (let* ((kevt (SDL_Event-key event))
                (key (SDL_Keysym-sym
                      (SDL_KeyboardEvent-keysym kevt))))
           (cond ((= key SDLK_ESCAPE)
                  'exit)
                 (else
                  (SDL_LogVerbose SDL_LOG_CATEGORY_APPLICATION (string-append "Key: " (number->string key)))
                  'new-world-modified-by-key-event))))
        ((= type SDL_WINDOWEVENT)
         (let* ((wevt (SDL_Event-window event))
                (event (SDL_WindowEvent-event wevt)))
           (cond
            ((= event SDL_WINDOWEVENT_SIZE_CHANGED)
             (SDL_LogVerbose SDL_LOG_CATEGORY_APPLICATION "Window Size Changed"))
            ((= event SDL_WINDOWEVENT_RESIZED)
             (SDL_LogVerbose SDL_LOG_CATEGORY_APPLICATION "Window Resized"))
            ((= event SDL_WINDOWEVENT_MINIMIZED)
             (SDL_LogVerbose SDL_LOG_CATEGORY_APPLICATION "Window Minimized"))
            ((= event SDL_WINDOWEVENT_RESTORED)
             (SDL_LogVerbose SDL_LOG_CATEGORY_APPLICATION "Window Restored"))))
         'new-world-modified-by-window-event)
        ((= type SDL_FINGERDOWN)
         (SDL_LogInfo SDL_LOG_CATEGORY_APPLICATION "FINGER DOWN!")
         'new-world-modified-by-finger-event)
        (else
         'new-world-modified-by-event))))
   (let ((posx 80.0))
     (lambda (cr time world)
       ;;(SDL_LogInfo SDL_LOG_CATEGORY_APPLICATION (object->string (SDL_GL_Extension_Supported "GL_EXT_texture_format_BGRA8888")))
       (cairo_set_source_rgba cr 1.0 1.0 1.0 1.0)
       (cairo_rectangle cr 0.0 0.0 500.0 500.0)
       (cairo_fill cr)
       (cairo_arc cr posx 80.0 150.0 0.0 6.28)
       (cairo_set_source_rgba cr 0.0 0.0 1.0 1.0)
       (cairo_fill cr)
       (cairo_select_font_face cr "Sans" CAIRO_FONT_SLANT_NORMAL CAIRO_FONT_WEIGHT_BOLD)
       (cairo_set_source_rgba cr 0.0 0.0 0.0 0.8)
       (cairo_set_font_size cr 16.0)
       (cairo_move_to cr 40.0 40.0)
       (cairo_show_text cr "Scheme Fusion test: Cairo / OpenGL")
       (cairo_fill cr)
       (set! posx (+ 1.0 posx))
       'new-world-modified-by-draw))
   'default-world))

(main)
