require "lirith"
require "./lirith_app/events"
require "./lirith_app/systems"
require "./lirith_app/version"

module LirithApp
  class Application < Lirith::Application
    def setup
      Lirith::Managers::System.instance.register(Lirith::Systems::Console.new([
        LirithApp::Events::Render::EndPaint,
        LirithApp::Events::Render::StartPaint,
        LirithApp::Events::Render::FinalizePaint,
        LirithApp::Events::Render::Finalized,
        Lirith::Events::Input::KeyPressed,
        Lirith::Events::Input::KeyReleased,
      ]))
      Lirith::Managers::System.instance.register(Systems::Window.new)
      Lirith::Managers::System.instance.register(Systems::Input.new)
      Lirith::Managers::System.instance.register(Systems::Render.new)
      Lirith::Managers::System.instance.register(Systems::Clock.new)
      Lirith::Managers::System.instance.register(Systems::Scene.new)
    end
  end
end

LirithApp::Application.new
