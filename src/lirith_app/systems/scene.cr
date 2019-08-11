module LirithApp
  module Systems
    class Scene < Lirith::Systems::Base
      def initialize
        @model = Models::Cube.new
        loader = Lirith::Loaders::JsonLoader.new
        mesh = loader.load(File.open("./src/lirith_app/models/cube.json"))
        Lirith.application.scene.children << mesh

        mesh2 = mesh.clone
        # mesh2 = loader.load(File.open("./src/lirith_app/models/cube.json"))
        mesh2.position.x -= 2
        mesh2.update_view
        Lirith.application.scene.children << mesh2

        mesh3 = loader.load(File.open("./src/lirith_app/models/cube.json"))
        mesh3.position.x += 2
        mesh3.update_view
        Lirith.application.scene.children << mesh3

        plane = Lirith::Objects::Plane.create(2, 2, 2, 2)
        plane.rotate_x Lirith::Math.deg2rad(90.0)
        plane.translate_z 0.1
        plane.update_view
        Lirith.application.scene.children << plane
      end

      def handle_event(event)
        # case event
        # when Events::Render::Started; load_model
        # end
      end
    end
  end
end
