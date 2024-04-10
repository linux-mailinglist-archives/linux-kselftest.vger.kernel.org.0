Return-Path: <linux-kselftest+bounces-7588-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 494D189FE49
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 19:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F41F62886D7
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 17:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A58181CF9;
	Wed, 10 Apr 2024 17:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvZQwBuD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A79D181CF0;
	Wed, 10 Apr 2024 17:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712769614; cv=none; b=bgrONlMpNDrb/tMe+/MKWJdnQgW6W97mIJ0/HL3kVQqx1Ei3Ra5B4wUkWuw7ywx8QXV45b+vx/++UrBbyvNJhv+bZps6bszpLU2eQbUOkYzcINt50C2bHhD0na+FynjcwsbYkSmupJ+HnCZN3oR3a07IwHfCcLFfyF7G3WIbbP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712769614; c=relaxed/simple;
	bh=EOIizNLnkrY/J+JKl/T90/FYWOCABytkMjMBAXGvkVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e/HyNg421Eh/FC5KXFWd7IuwxtEYJH1/E8rRnnyq6tECPFZYmmPt8FqLotL8OhE96piYaA8256CIsRf3yRSM9OLjUrhJTBovbgOanlTIGIlb7PFYq6guhJolfA5FqfR6Mdwb2pyowtfWKDjXatfqckoNr1+ijaTYewQ9VNkBbmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvZQwBuD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5EDC433F1;
	Wed, 10 Apr 2024 17:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712769613;
	bh=EOIizNLnkrY/J+JKl/T90/FYWOCABytkMjMBAXGvkVE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CvZQwBuDP30grfPqtDESmCOdJ8VipV8vkT5brexm+dr2JVxnD7dtVXz44YO54fL/X
	 CDTDPpuuolWdbPcTyNCc5ALYA4DWGfBdyVBxib3il1tZ7V0vnfdPDL7QfnJnD2gPoT
	 a5JIyn7BMNd67E+coSl9DK7xPz1wUZ3py39vrOP98IltV+6462PvBMkCcf0iPI6Gqw
	 RTn/fFBpJGMgK1Q2u4iKZ3VIANDYc5B6EELdyJuuP4xKyKb3VdwcSnSb6B7COpaBGs
	 EStC4f2jXKA+j07H72Th6ez7YRLOsjE8sXDg8qDfS1+EjQiHUMPx2tIWaM24HuU5lZ
	 2oCDKwTMaH/xQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 10 Apr 2024 19:19:31 +0200
Subject: [PATCH 11/18] selftests/hid: add support for HID-BPF pre-loading
 before starting a test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-bpf_sources-v1-11-a8bf16033ef8@kernel.org>
References: <20240410-bpf_sources-v1-0-a8bf16033ef8@kernel.org>
In-Reply-To: <20240410-bpf_sources-v1-0-a8bf16033ef8@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712769589; l=9498;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=EOIizNLnkrY/J+JKl/T90/FYWOCABytkMjMBAXGvkVE=;
 b=1oZC2CkDrTDR3PTLCwY69V47Vla8iHNrcSJMlCySOBPfdDFaJEoZW8ZSHeSHhC5+/4F03nRUj
 AKXnrRVBSo7DwpxQ4gbnERQCI9W4cUTarSgZKJ6KfWw3AQzDBWl3siu
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

few required changes:
- we need to count how many times a udev 'bind' event happens
- we need to tell `udev-hid-bpf` to not automatically attach the
  provided HID-BPF objects
- we need to manually attach the ones from the kernel tree, and wait
  for the second udev 'bind' event to happen

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/tests/base.py        | 85 +++++++++++++++++++++---
 tools/testing/selftests/hid/tests/base_device.py | 23 +++++--
 2 files changed, 93 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/hid/tests/base.py b/tools/testing/selftests/hid/tests/base.py
index 6bb5b887baaf..2d006c0f5fcd 100644
--- a/tools/testing/selftests/hid/tests/base.py
+++ b/tools/testing/selftests/hid/tests/base.py
@@ -8,6 +8,7 @@
 import libevdev
 import os
 import pytest
+import subprocess
 import time
 
 import logging
@@ -157,6 +158,17 @@ class BaseTestCase:
         # for example ("playstation", "hid-playstation")
         kernel_modules: List[Tuple[str, str]] = []
 
+        # List of in kernel HID-BPF object files to load
+        # before starting the test
+        # Any existing pre-loaded HID-BPF module will be removed
+        # before the ones in this list will be manually loaded.
+        # Each Element is a tuple '(hid_bpf_object, rdesc_fixup_present)',
+        # for example '("xppen-ArtistPro16Gen2.bpf.o", True)'
+        # If 'rdesc_fixup_present' is True, the test needs to wait
+        # for one unbind and rebind before it can be sure the kernel is
+        # ready
+        hid_bpfs: List[Tuple[str, bool]] = []
+
         def assertInputEventsIn(self, expected_events, effective_events):
             effective_events = effective_events.copy()
             for ev in expected_events:
@@ -211,8 +223,6 @@ class BaseTestCase:
                 # we don't know beforehand the name of the module from modinfo
                 sysfs_path = Path("/sys/module") / kernel_module.replace("-", "_")
             if not sysfs_path.exists():
-                import subprocess
-
                 ret = subprocess.run(["/usr/sbin/modprobe", kernel_module])
                 if ret.returncode != 0:
                     pytest.skip(
@@ -225,6 +235,60 @@ class BaseTestCase:
                 self._load_kernel_module(kernel_driver, kernel_module)
             yield
 
+        def load_hid_bpfs(self):
+            script_dir = Path(os.path.dirname(os.path.realpath(__file__)))
+            root_dir = (script_dir / "../../../../..").resolve()
+            bpf_dir = root_dir / "drivers/hid/bpf/progs"
+
+            wait = False
+            for _, rdesc_fixup in self.hid_bpfs:
+                if rdesc_fixup:
+                    wait = True
+
+            for hid_bpf, _ in self.hid_bpfs:
+                # We need to start `udev-hid-bpf` in the background
+                # and dispatch uhid events in case the kernel needs
+                # to fetch features on the device
+                process = subprocess.Popen(
+                    [
+                        "udev-hid-bpf",
+                        "--verbose",
+                        "add",
+                        str(self.uhdev.sys_path),
+                        str(bpf_dir / hid_bpf),
+                    ],
+                )
+                while process.poll() is None:
+                    self.uhdev.dispatch(1)
+
+                if process.poll() != 0:
+                    pytest.fail(
+                        f"Couldn't insert hid-bpf program '{hid_bpf}', marking the test as failed"
+                    )
+
+            if wait:
+                # the HID-BPF program exports a rdesc fixup, so it needs to be
+                # unbound by the kernel and then rebound.
+                # Ensure we get the bound event exactly 2 times (one for the normal
+                # uhid loading, and then the reload from HID-BPF)
+                now = time.time()
+                while self.uhdev.kernel_ready_count < 2 and time.time() - now < 2:
+                    self.uhdev.dispatch(1)
+
+                if self.uhdev.kernel_ready_count < 2:
+                    pytest.fail(
+                        f"Couldn't insert hid-bpf programs, marking the test as failed"
+                    )
+
+        def unload_hid_bpfs(self):
+            ret = subprocess.run(
+                ["udev-hid-bpf", "--verbose", "remove", str(self.uhdev.sys_path)],
+            )
+            if ret.returncode != 0:
+                pytest.fail(
+                    f"Couldn't unload hid-bpf programs, marking the test as failed"
+                )
+
         @pytest.fixture()
         def new_uhdev(self, load_kernel_module):
             return self.create_device()
@@ -248,12 +312,18 @@ class BaseTestCase:
                         now = time.time()
                         while not self.uhdev.is_ready() and time.time() - now < 5:
                             self.uhdev.dispatch(1)
+
+                        if self.hid_bpfs:
+                            self.load_hid_bpfs()
+
                         if self.uhdev.get_evdev() is None:
                             logger.warning(
                                 f"available list of input nodes: (default application is '{self.uhdev.application}')"
                             )
                             logger.warning(self.uhdev.input_nodes)
                         yield
+                        if self.hid_bpfs:
+                            self.unload_hid_bpfs()
                         self.uhdev = None
             except PermissionError:
                 pytest.skip("Insufficient permissions, run me as root")
@@ -313,8 +383,6 @@ class HIDTestUdevRule(object):
             self.reload_udev_rules()
 
     def reload_udev_rules(self):
-        import subprocess
-
         subprocess.run("udevadm control --reload-rules".split())
         subprocess.run("systemd-hwdb update".split())
 
@@ -330,10 +398,11 @@ class HIDTestUdevRule(object):
             delete=False,
         ) as f:
             f.write(
-                'KERNELS=="*input*", ATTRS{name}=="*uhid test *", ENV{LIBINPUT_IGNORE_DEVICE}="1"\n'
-            )
-            f.write(
-                'KERNELS=="*input*", ATTRS{name}=="*uhid test * System Multi Axis", ENV{ID_INPUT_TOUCHSCREEN}="", ENV{ID_INPUT_SYSTEM_MULTIAXIS}="1"\n'
+                """
+KERNELS=="*input*", ATTRS{name}=="*uhid test *", ENV{LIBINPUT_IGNORE_DEVICE}="1"
+KERNELS=="*hid*", ENV{HID_NAME}=="*uhid test *", ENV{HID_BPF_IGNORE_DEVICE}="1"
+KERNELS=="*input*", ATTRS{name}=="*uhid test * System Multi Axis", ENV{ID_INPUT_TOUCHSCREEN}="", ENV{ID_INPUT_SYSTEM_MULTIAXIS}="1"
+"""
             )
             self.rulesfile = f
 
diff --git a/tools/testing/selftests/hid/tests/base_device.py b/tools/testing/selftests/hid/tests/base_device.py
index 092c7c4e62ef..e0515be97f83 100644
--- a/tools/testing/selftests/hid/tests/base_device.py
+++ b/tools/testing/selftests/hid/tests/base_device.py
@@ -35,7 +35,7 @@ from hidtools.uhid import UHIDDevice
 from hidtools.util import BusType
 
 from pathlib import Path
-from typing import Any, ClassVar, Dict, List, Optional, Type, Union
+from typing import Any, ClassVar, Dict, List, Optional, Tuple, Type, Union
 
 logger = logging.getLogger("hidtools.device.base_device")
 
@@ -126,7 +126,7 @@ class HIDIsReady(object):
 class UdevHIDIsReady(HIDIsReady):
     _pyudev_context: ClassVar[Optional[pyudev.Context]] = None
     _pyudev_monitor: ClassVar[Optional[pyudev.Monitor]] = None
-    _uhid_devices: ClassVar[Dict[int, bool]] = {}
+    _uhid_devices: ClassVar[Dict[int, Tuple[bool, int]]] = {}
 
     def __init__(self: "UdevHIDIsReady", uhid: UHIDDevice) -> None:
         super().__init__(uhid)
@@ -150,20 +150,25 @@ class UdevHIDIsReady(HIDIsReady):
             return
         event: pyudev.Device
         for event in iter(functools.partial(cls._pyudev_monitor.poll, 0.02), None):
-            if event.action not in ["bind", "remove"]:
+            if event.action not in ["bind", "remove", "unbind"]:
                 return
 
             logger.debug(f"udev event: {event.action} -> {event}")
 
             id = int(event.sys_path.strip().split(".")[-1], 16)
 
-            cls._uhid_devices[id] = event.action == "bind"
+            device_ready, count = cls._uhid_devices.get(id, (False, 0))
 
-    def is_ready(self: "UdevHIDIsReady") -> bool:
+            ready = event.action == "bind"
+            if not device_ready and ready:
+                count += 1
+            cls._uhid_devices[id] = (ready, count)
+
+    def is_ready(self: "UdevHIDIsReady") -> Tuple[bool, int]:
         try:
             return self._uhid_devices[self.uhid.hid_id]
         except KeyError:
-            return False
+            return (False, 0)
 
 
 class EvdevMatch(object):
@@ -317,7 +322,11 @@ class BaseDevice(UHIDDevice):
 
     @property
     def kernel_is_ready(self: "BaseDevice") -> bool:
-        return self._kernel_is_ready.is_ready() and self.started
+        return self._kernel_is_ready.is_ready()[0] and self.started
+
+    @property
+    def kernel_ready_count(self: "BaseDevice") -> int:
+        return self._kernel_is_ready.is_ready()[1]
 
     @property
     def input_nodes(self: "BaseDevice") -> List[EvdevDevice]:

-- 
2.44.0


