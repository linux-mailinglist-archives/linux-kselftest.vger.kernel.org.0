Return-Path: <linux-kselftest+bounces-7462-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6241489D0EC
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 05:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 864BA1C20D16
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 03:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AE154794;
	Tue,  9 Apr 2024 03:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYhPB++W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B247757F2;
	Tue,  9 Apr 2024 03:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712632620; cv=none; b=rqxVug048fLLszvtRhpx+htkA25kLxBBQtKDN53jcwPGmlCiUGbgI2mlXkUZvp6FzE85bbwQzCBI2ftM/65HGnKAIPAWsi5XF2E7dtKCVC3rd0Uy8XGoZAdd/d38raCXbpb1fOzyALKcQFkR2LvW+HYDMAmdyrR5gKQMJ++uV5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712632620; c=relaxed/simple;
	bh=Z/Z8IlwKg0DOKmCaX2DcqO+CWrYkrLbpU61AvW66MnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3Z7OQEYhLIIIX8/ztJFkGuSWU9LEcdh1LlHse9iiblLn5hIPMhtc73NZ1yma0ISaZv0FIMwbNSz+6J4NsPZ6k9zcAkEoBWFHXfEJBrXHIqPJZmGxprzBaVN+eZZGV/ZgoBFbepfxURtJHF6vK8WJlSXZyiXpHknTNsdGy3KKPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYhPB++W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358E5C43390;
	Tue,  9 Apr 2024 03:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712632619;
	bh=Z/Z8IlwKg0DOKmCaX2DcqO+CWrYkrLbpU61AvW66MnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WYhPB++WZu/LPm/IFraHVcou/Jgwm5/v7dVc/6pVrA48aVoK3jpA1ccTfnvOf0yOB
	 9k2zBJjR+s8yPDPdED8tkrjAh7MutSp9xYHa78Fn/ZJ9a4lLVEa8D7eBB/rWB7wYnt
	 jehETlHI582imUFHtzSCROkmD3W0wf82jSiwkV66uO5fUrB5dvKB1kQ4+pyUUggPpB
	 0xLhbAKaUFSTnqwZgGOuyyCyAWfjOxQhULkTepGL+QxMg3+LglAU+oyzIPmL8Ek+ir
	 PW+c8vKieLbWyC+pPFttD8sqjSYO8hjOqrGBkWaadknnzKV4lJBBlcB3LLCdo4DJIN
	 zDgudzdWWLMIA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	bpf@vger.kernel.org,
	andrii@kernel.org,
	mykolal@fb.com,
	eddyz87@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 4/4] selftests: net: reuse common code in bpf_offload
Date: Mon,  8 Apr 2024 20:15:49 -0700
Message-ID: <20240409031549.3531084-5-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409031549.3531084-1-kuba@kernel.org>
References: <20240409031549.3531084-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

net/lib/py/nsim.py already contains the most useful parts
of the netdevsim wrapper classes. Reuse them.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/bpf_offload.py | 120 +++++----------------
 tools/testing/selftests/net/lib/py/nsim.py |   9 +-
 2 files changed, 35 insertions(+), 94 deletions(-)

diff --git a/tools/testing/selftests/net/bpf_offload.py b/tools/testing/selftests/net/bpf_offload.py
index 76b53ac2c8c6..3efe44f6e92a 100755
--- a/tools/testing/selftests/net/bpf_offload.py
+++ b/tools/testing/selftests/net/bpf_offload.py
@@ -29,6 +29,9 @@ import subprocess
 import time
 import traceback
 
+from lib.py import NetdevSim, NetdevSimDev
+
+
 logfile = None
 log_level = 1
 skip_extack = False
@@ -145,8 +148,10 @@ netns = [] # net namespaces to be removed
     if JSON:
         params += "%s " % (flags["json"])
 
-    if ns != "":
+    if ns:
         ns = "ip netns exec %s " % (ns)
+    elif ns is None:
+        ns = ""
 
     if include_stderr:
         ret, stdout, stderr = cmd(ns + name + " " + params + args,
@@ -334,72 +339,16 @@ def bpftool_prog_load(sample, file_name, maps=[], prog_type="xdp", dev=None,
 
         return dfs
 
-class NetdevSimDev:
+class BpfNetdevSimDev(NetdevSimDev):
     """
     Class for netdevsim bus device and its attributes.
     """
-    @staticmethod
-    def ctrl_write(path, val):
-        fullpath = os.path.join("/sys/bus/netdevsim/", path)
-        try:
-            with open(fullpath, "w") as f:
-                f.write(val)
-        except OSError as e:
-            log("WRITE %s: %r" % (fullpath, val), -e.errno)
-            raise e
-        log("WRITE %s: %r" % (fullpath, val), 0)
-
-    def __init__(self, port_count=1):
-        addr = 0
-        while True:
-            try:
-                self.ctrl_write("new_device", "%u %u" % (addr, port_count))
-            except OSError as e:
-                if e.errno == errno.ENOSPC:
-                    addr += 1
-                    continue
-                raise e
-            break
-        self.addr = addr
-
-        # As probe of netdevsim device might happen from a workqueue,
-        # so wait here until all netdevs appear.
-        self.wait_for_netdevs(port_count)
-
-        ret, out = cmd("udevadm settle", fail=False)
-        if ret:
-            raise Exception("udevadm settle failed")
-        ifnames = self.get_ifnames()
-
+    def __init__(self, port_count=1, ns=None):
+        super().__init__(port_count, ns=ns)
         devs.append(self)
-        self.dfs_dir = "/sys/kernel/debug/netdevsim/netdevsim%u/" % addr
 
-        self.nsims = []
-        for port_index in range(port_count):
-            self.nsims.append(NetdevSim(self, port_index, ifnames[port_index]))
-
-    def get_ifnames(self):
-        ifnames = []
-        listdir = os.listdir("/sys/bus/netdevsim/devices/netdevsim%u/net/" % self.addr)
-        for ifname in listdir:
-            ifnames.append(ifname)
-        ifnames.sort()
-        return ifnames
-
-    def wait_for_netdevs(self, port_count):
-        timeout = 5
-        timeout_start = time.time()
-
-        while True:
-            try:
-                ifnames = self.get_ifnames()
-            except FileNotFoundError as e:
-                ifnames = []
-            if len(ifnames) == port_count:
-                break
-            if time.time() < timeout_start + timeout:
-                continue
-            raise Exception("netdevices did not appear within timeout")
+    def _make_port(self, port_index, ifname):
+        return BpfNetdevSim(self, port_index, ifname, self.ns)
 
     def dfs_num_bound_progs(self):
         path = os.path.join(self.dfs_dir, "bpf_bound_progs")
@@ -415,33 +364,20 @@ def bpftool_prog_load(sample, file_name, maps=[], prog_type="xdp", dev=None,
         return progs
 
     def remove(self):
-        self.ctrl_write("del_device", "%u" % (self.addr, ))
+        super().remove()
         devs.remove(self)
 
-    def remove_nsim(self, nsim):
-        self.nsims.remove(nsim)
-        self.ctrl_write("devices/netdevsim%u/del_port" % (self.addr, ),
-                        "%u" % (nsim.port_index, ))
 
-class NetdevSim:
+class BpfNetdevSim(NetdevSim):
     """
     Class for netdevsim netdevice and its attributes.
     """
 
-    def __init__(self, nsimdev, port_index, ifname):
-        # In case udev renamed the netdev to according to new schema,
-        # check if the name matches the port_index.
-        nsimnamere = re.compile("eni\d+np(\d+)")
-        match = nsimnamere.match(ifname)
-        if match and int(match.groups()[0]) != port_index + 1:
-            raise Exception("netdevice name mismatches the expected one")
+    def __init__(self, nsimdev, port_index, ifname, ns=None):
+        super().__init__(nsimdev, port_index, ifname, ns=ns)
 
-        self.nsimdev = nsimdev
-        self.port_index = port_index
-        self.ns = ""
         self.dfs_dir = "%s/ports/%u/" % (nsimdev.dfs_dir, port_index)
         self.dfs_refresh()
-        _, [self.dev] = ip("link show dev %s" % ifname)
 
     def __getitem__(self, key):
         return self.dev[key]
@@ -468,7 +404,7 @@ def bpftool_prog_load(sample, file_name, maps=[], prog_type="xdp", dev=None,
         raise Exception("Time out waiting for program counts to stabilize want %d/%d, have %d bound, %d loaded" % (bound, total, nbound, nprogs))
 
     def set_ns(self, ns):
-        name = "1" if ns == "" else ns
+        name = ns if ns else "1"
         ip("link set dev %s netns %s" % (self.dev["ifname"], name), ns=self.ns)
         self.ns = ns
 
@@ -744,7 +680,7 @@ def bpftool_prog_load(sample, file_name, maps=[], prog_type="xdp", dev=None,
     start_test("Test multi-attachment XDP - device remove...")
     simdev.remove()
 
-    simdev = NetdevSimDev()
+    simdev = BpfNetdevSimDev()
     sim, = simdev.nsims
     sim.set_ethtool_tc_offloads(True)
     return [simdev, sim]
@@ -809,13 +745,13 @@ netns = []
     bytecode = bpf_bytecode("1,6 0 0 4294967295,")
 
     start_test("Test destruction of generic XDP...")
-    simdev = NetdevSimDev()
+    simdev = BpfNetdevSimDev()
     sim, = simdev.nsims
     sim.set_xdp(obj, "generic")
     simdev.remove()
     bpftool_prog_list_wait(expected=0)
 
-    simdev = NetdevSimDev()
+    simdev = BpfNetdevSimDev()
     sim, = simdev.nsims
     sim.tc_add_ingress()
 
@@ -967,7 +903,7 @@ netns = []
     simdev.remove()
     bpftool_prog_list_wait(expected=0)
 
-    simdev = NetdevSimDev()
+    simdev = BpfNetdevSimDev()
     sim, = simdev.nsims
     sim.set_ethtool_tc_offloads(True)
 
@@ -976,7 +912,7 @@ netns = []
     simdev.remove()
     bpftool_prog_list_wait(expected=0)
 
-    simdev = NetdevSimDev()
+    simdev = BpfNetdevSimDev()
     sim, = simdev.nsims
     sim.set_ethtool_tc_offloads(True)
 
@@ -1080,7 +1016,7 @@ netns = []
     bpftool_prog_list_wait(expected=0)
 
     start_test("Test attempt to use a program for a wrong device...")
-    simdev2 = NetdevSimDev()
+    simdev2 = BpfNetdevSimDev()
     sim2, = simdev2.nsims
     sim2.set_xdp(obj, "offload")
     pin_file, pinned = pin_prog("/sys/fs/bpf/tmp")
@@ -1169,7 +1105,7 @@ netns = []
     clean_up()
     bpftool_prog_list_wait(expected=0)
 
-    simdev = NetdevSimDev()
+    simdev = BpfNetdevSimDev()
     sim, = simdev.nsims
     map_obj = bpf_obj("sample_map_ret0.bpf.o")
     start_test("Test loading program with maps...")
@@ -1201,7 +1137,7 @@ netns = []
     clean_up()
     bpftool_prog_list_wait(expected=0)
 
-    simdev = NetdevSimDev()
+    simdev = BpfNetdevSimDev()
     sim, = simdev.nsims
 
     start_test("Test map update (no flags)...")
@@ -1285,14 +1221,14 @@ netns = []
     bpftool_map_list_wait(expected=0)
     simdev.remove()
 
-    simdev = NetdevSimDev()
+    simdev = BpfNetdevSimDev()
     sim, = simdev.nsims
     sim.set_xdp(map_obj, "offload", JSON=False) # map fixup msg breaks JSON
     simdev.remove()
     bpftool_map_list_wait(expected=0)
 
     start_test("Test map creation fail path...")
-    simdev = NetdevSimDev()
+    simdev = BpfNetdevSimDev()
     sim, = simdev.nsims
     sim.dfs["bpf_map_accept"] = "N"
     ret, _ = sim.set_xdp(map_obj, "offload", JSON=False, fail=False)
@@ -1302,9 +1238,9 @@ netns = []
     simdev.remove()
 
     start_test("Test multi-dev ASIC program reuse...")
-    simdevA = NetdevSimDev()
+    simdevA = BpfNetdevSimDev()
     simA, = simdevA.nsims
-    simdevB = NetdevSimDev(3)
+    simdevB = BpfNetdevSimDev(3)
     simB1, simB2, simB3 = simdevB.nsims
     sims = (simA, simB1, simB2, simB3)
     simB = (simB1, simB2, simB3)
diff --git a/tools/testing/selftests/net/lib/py/nsim.py b/tools/testing/selftests/net/lib/py/nsim.py
index b2d696e12805..97457aca7e08 100644
--- a/tools/testing/selftests/net/lib/py/nsim.py
+++ b/tools/testing/selftests/net/lib/py/nsim.py
@@ -21,8 +21,11 @@ from .utils import cmd, ip
         if match and int(match.groups()[0]) != port_index + 1:
             raise Exception("netdevice name mismatches the expected one")
 
+        self.ifname = ifname
         self.nsimdev = nsimdev
         self.port_index = port_index
+        self.ns = ns
+        self.dfs_dir = "%s/ports/%u/" % (nsimdev.dfs_dir, port_index)
         ret = ip("-j link show dev %s" % ifname, ns=ns)
         self.dev = json.loads(ret.stdout)[0]
 
@@ -79,8 +82,10 @@ from .utils import cmd, ip
 
         self.nsims = []
         for port_index in range(port_count):
-            self.nsims.append(NetdevSim(self, port_index, ifnames[port_index],
-                                        ns=ns))
+            self.nsims.append(self._make_port(port_index, ifnames[port_index]))
+
+    def _make_port(self, port_index, ifname):
+        return NetdevSim(self, port_index, ifname, self.ns)
 
     def get_ifnames(self):
         ifnames = []
-- 
2.44.0


