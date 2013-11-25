/*
 Copyright 2013 (C) Raster Software Vigo (Sergio Costas)

 This file is part of AutoVala

 AutoVala is free software; you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation; either version 3 of the License, or
 (at your option) any later version.

 AutoVala is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>. */

using GLib;
//using GIO;

namespace AutoVala {

	/**
	 * Represents a generic file of the project, with its path, filename, compilation condition...
	 * This class must be inherited by several subclasses, one for each kind of file allowed in AutoVala
	 */

	class ElementPixmap : ElementBase {

		public ElementPixmap() {
			this._type = ConfigType.PIXMAP;
		}

		public override bool configureLine(string line, bool automatic, string? condition, bool invertCondition) {

			// The line starts with 'pixmap: '
			var data=line.substring(8).strip();

			return this.configureElement(data,null,null,automatic,condition,invertCondition);
		}

		public override bool generateCMake(DataOutputStream dataStream, ConfigType type) {

			// only process this file if it is of the desired type
			if (type!=this.eType) {
				return false;
			}
			try {
				dataStream.put_string("install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/"+this.file+" DESTINATION share/"+ElementBase.globalData.projectName+"/ )\n");
			} catch (Error e) {
				ElementBase.globalData.addError(_("Failed to add pixmap %s").printf(this.fullPath));
				return true;
			}
			return false;
		}

		public override bool storeConfig(DataOutputStream dataStream, ConfigType type) {

			// only process this file if it is of the desired type
			if (type!=this.eType) {
				return false;
			}

			try {
				if (this.automatic) {
					dataStream.put_string("*");
				}
				dataStream.put_string("pixmap: %s\n".printf(this.fullPath));
			} catch (Error e) {
				ElementBase.globalData.addError(_("Failed to store 'pixmap: %s' at config").printf(this.fullPath));
				return true;
			}
			return false;
		}
	}
}
