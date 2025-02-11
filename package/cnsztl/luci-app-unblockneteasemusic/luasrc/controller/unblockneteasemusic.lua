-- This is a free software, use it under GNU General Public License v3.0.
-- Created By [CTCGFW]Project OpenWRT
-- https://github.com/project-openwrt

module("luci.controller.unblockneteasemusic", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/unblockneteasemusic") then
		return
	end

	entry({"admin", "services", "unblockneteasemusic"},firstchild(), _("解除网易云音乐播放限制"), 50).dependent = false
	
	entry({"admin", "services", "unblockneteasemusic", "general"},cbi("unblockneteasemusic"), _("Base Setting"), 1)
	entry({"admin", "services", "unblockneteasemusic", "log"},form("unblockneteasemusiclog"), _("Log"), 2)
  
	entry({"admin", "services", "unblockneteasemusic", "status"},call("act_status")).leaf=true
end

function act_status()
  local e={}
  e.running=luci.sys.call("ps |grep unblockneteasemusic |grep app.js |grep -v grep >/dev/null")==0
  luci.http.prepare_content("application/json")
  luci.http.write_json(e)
end
