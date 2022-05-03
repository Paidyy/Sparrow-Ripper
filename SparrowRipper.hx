package;

import bitmap.Types.Rectangle;
import bitmap.Bitmap;
import bitmap.IOUtil;
import bitmap.PNGBitmap;
import sys.FileSystem;
import sys.io.File;

class SparrowRipper {
	static public function main():Void {
		var beginningTime = Sys.time();
		var xml = Xml.parse(File.getContent(Sys.args()[0]));
		var imagePath:String = null;
        if (!FileSystem.exists("output/")) {
            FileSystem.createDirectory("output");
        }
        for (thing in xml) {
            try {
				if (thing.nodeName == "TextureAtlas") {
					imagePath = thing.get("imagePath");
                    for (node in thing) {
						try {
							var imgProperties:ImageProperties = {
								x: Std.parseInt(node.get("x")),
								y: Std.parseInt(node.get("y")),
								width: Std.parseInt(node.get("width")),
								height: Std.parseInt(node.get("height")),
								name: node.get("name")
							};
							var rectangl:Rectangle = {
								x: imgProperties.x,
								y: imgProperties.y,
								width: imgProperties.width,
								height: imgProperties.height
                            };
							var bitmap = PNGBitmap.create(IOUtil.readFile(imagePath));
							var animationImage:Bitmap = bitmap.copy(rectangl);
							IOUtil.writeBitmap("output/" + imgProperties.name + ".png", animationImage);
                        } 
                        catch (exc) { }
                    }
                }
            }
            catch (exc) { }
        }
		Sys.println("(Finished in " + (Sys.time() - beginningTime) + "s)");
	}
}

typedef ImageProperties = {
    var x:Int;
	var y:Int;
	var width:Int;
	var height:Int;
	var name:String;
}