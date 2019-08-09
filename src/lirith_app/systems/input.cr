module LirithApp
  module Systems
    class Input < Lirith::Systems::Base
      @move_forward = false
      @move_backward = false
      @move_left = false
      @move_right = false

      @translate_left = false
      @translate_right = false

      def handle_key_press(key)
        case key
        when Lirith::Input::Keys::KeyGraveAccent; Lirith::Managers::System.trigger_event(Lirith::Events::Console::RequestCommand)
        when Lirith::Input::Keys::KeyEscape     ; Lirith::Managers::System.trigger_event(Lirith::Events::Application::Exit)
        when Lirith::Input::Keys::W             ; @move_forward = true
        when Lirith::Input::Keys::A             ; @move_left = true
        when Lirith::Input::Keys::S             ; @move_backward = true
        when Lirith::Input::Keys::D             ; @move_right = true

        when Lirith::Input::Keys::Q             ; @translate_left = true
        when Lirith::Input::Keys::E             ; @translate_right = true
        when Lirith::Input::Keys::R             ; randomize_mesh
        end

        Lirith.application.camera.update_view
      end

      def handle_key_release(key)
        case key
        when Lirith::Input::Keys::W             ; @move_forward = false
        when Lirith::Input::Keys::A             ; @move_left = false
        when Lirith::Input::Keys::S             ; @move_backward = false
        when Lirith::Input::Keys::D             ; @move_right = false

        when Lirith::Input::Keys::Q             ; @translate_left = false
        when Lirith::Input::Keys::E             ; @translate_right = false
        end
      end

      def randomize_mesh
        if Lirith.application.scene.children.first.is_a?(Lirith::Objects::Mesh)
          mesh = Lirith.application.scene.children.first

          mesh.vertices.first.position.x -= 1_f32
          mesh.needs_update = true
        end
      end

      def check_mouse
        Lirith.application.camera.quaternion.y += 0.01 if @translate_left
        Lirith.application.camera.quaternion.y -= 0.01 if @translate_right

        Lirith.application.camera.update_view if @translate_left || @translate_right

        true
      end

      def move
        Lirith.application.camera.translate_z -0.1 if @move_forward
        Lirith.application.camera.translate_z 0.1 if @move_backward

        Lirith.application.camera.translate_x -0.1 if @move_left
        Lirith.application.camera.translate_x 0.1 if @move_right

        Lirith.application.camera.update_view if @move_forward || @move_backward || @move_left || @move_right

        true
      end

      def handle_event(event)
        case event
        when Events::Render::StartPaint; check_mouse && move
        when Lirith::Events::Input::KeyPressed; handle_key_press(event.key)
        when Lirith::Events::Input::KeyReleased; handle_key_release(event.key)
        end
      end
    end
  end
end
