Return-Path: <linux-kselftest+bounces-7587-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE38A89FE45
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 19:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83ADE282E57
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 17:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E27181BAE;
	Wed, 10 Apr 2024 17:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzJ6zl55"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E211617F364;
	Wed, 10 Apr 2024 17:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712769612; cv=none; b=k5Tu2VWbQ13fkNaanwAkZWJ6CjnsOWHvU4C9VMocEoXf0YvpFsvcRH+o1ix7KbRKIckzDNL41u+53yoKEcuoLnEPAX6zUEPz3ExWh9KXZ/tIBIfoHjor0dJ1YwhbuRrrimw518fozV3MuL5GWtI6toKQrhjSzBFi/YYIU1rVDzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712769612; c=relaxed/simple;
	bh=tGBczePhn37Kh4qeM8bEbGdlkh7q8qxu7ZwCZb/3SjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OuZsWOiB3IXcEcqyI7k2i3hTAXDfj8erpTnzDseh343waoMnEcLXSJIWdCuFxeEQZOrOgkudlRMkcYAnVPdDvoQa97TaJlRXmHqOJYAUZWQq8jCKxMQHFLRymx64LaSYO6s/RcUKB6CBFVpBaVZ6iGB1X/4rY4KYVtZe7WyIl4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzJ6zl55; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6618BC43394;
	Wed, 10 Apr 2024 17:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712769611;
	bh=tGBczePhn37Kh4qeM8bEbGdlkh7q8qxu7ZwCZb/3SjU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NzJ6zl55oQwDLEBL6ZCE9O9H3Hij6Rux2USnRyGN/rcA+P4DnR4T4/OvyuqMUYUu7
	 iEO1DvpZIaxvzLnJwiS9mtmmFIElpcXiM1bObE69uvVyWx23uU1gqt9UvhikuR7S/T
	 jSsSkzWTwfo6Ye9DhIY5X5kAQA8GbW4DluSEIGx2oIIbAupKPQgInby78tvTkm5ppq
	 SFBRRNRVJBSFnZv3kNDz4OE/TyJHTjlr1wog71csx00kxXTAgQmNGG019k9u7eC9qo
	 VxPfwk1718JCPjuQDW+AHEalbdoPU67lVqt3wszo73nSGzzZCkl4ap3pRojWg75DW6
	 N1cNVfEGTdCwA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 10 Apr 2024 19:19:30 +0200
Subject: [PATCH 10/18] selftests/hid: import base_device.py from hid-tools
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-bpf_sources-v1-10-a8bf16033ef8@kernel.org>
References: <20240410-bpf_sources-v1-0-a8bf16033ef8@kernel.org>
In-Reply-To: <20240410-bpf_sources-v1-0-a8bf16033ef8@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712769589; l=14895;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=tGBczePhn37Kh4qeM8bEbGdlkh7q8qxu7ZwCZb/3SjU=;
 b=nMQEVObN6AkPLSEIwzXfkNTHeBNuxscPqdAPhqaS2WkMJbBQP+JXlSq8d1/GOGTJ+erRgnt/G
 26TLMZsg4loDmmj/9fkHpxUCjjx1Rd+CwdOnaSGd1E2vcGTd+RGM0pf
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

We need to slightly change base_device.py for supporting HID-BPF,
so instead of monkey patching, let's just embed it in the kernel tree.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/tests/base.py        |   2 +-
 tools/testing/selftests/hid/tests/base_device.py | 412 +++++++++++++++++++++++
 2 files changed, 413 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/hid/tests/base.py b/tools/testing/selftests/hid/tests/base.py
index 51433063b227..6bb5b887baaf 100644
--- a/tools/testing/selftests/hid/tests/base.py
+++ b/tools/testing/selftests/hid/tests/base.py
@@ -12,7 +12,7 @@ import time
 
 import logging
 
-from hidtools.device.base_device import BaseDevice, EvdevMatch, SysfsFile
+from .base_device import BaseDevice, EvdevMatch, SysfsFile
 from pathlib import Path
 from typing import Final, List, Tuple
 
diff --git a/tools/testing/selftests/hid/tests/base_device.py b/tools/testing/selftests/hid/tests/base_device.py
new file mode 100644
index 000000000000..092c7c4e62ef
--- /dev/null
+++ b/tools/testing/selftests/hid/tests/base_device.py
@@ -0,0 +1,412 @@
+#!/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# -*- coding: utf-8 -*-
+#
+# Copyright (c) 2017 Benjamin Tissoires <benjamin.tissoires@gmail.com>
+# Copyright (c) 2017 Red Hat, Inc.
+#
+# This program is free software: you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+
+import fcntl
+import functools
+import libevdev
+import os
+
+try:
+    import pyudev
+except ImportError:
+    raise ImportError("UHID is not supported due to missing pyudev dependency")
+
+import logging
+
+import hidtools.hid as hid
+from hidtools.uhid import UHIDDevice
+from hidtools.util import BusType
+
+from pathlib import Path
+from typing import Any, ClassVar, Dict, List, Optional, Type, Union
+
+logger = logging.getLogger("hidtools.device.base_device")
+
+
+class SysfsFile(object):
+    def __init__(self, path):
+        self.path = path
+
+    def __set_value(self, value):
+        with open(self.path, "w") as f:
+            return f.write(f"{value}\n")
+
+    def __get_value(self):
+        with open(self.path) as f:
+            return f.read().strip()
+
+    @property
+    def int_value(self) -> int:
+        return int(self.__get_value())
+
+    @int_value.setter
+    def int_value(self, v: int) -> None:
+        self.__set_value(v)
+
+    @property
+    def str_value(self) -> str:
+        return self.__get_value()
+
+    @str_value.setter
+    def str_value(self, v: str) -> None:
+        self.__set_value(v)
+
+
+class LED(object):
+    def __init__(self, sys_path):
+        self.max_brightness = SysfsFile(sys_path / "max_brightness").int_value
+        self.__brightness = SysfsFile(sys_path / "brightness")
+
+    @property
+    def brightness(self) -> int:
+        return self.__brightness.int_value
+
+    @brightness.setter
+    def brightness(self, value: int) -> None:
+        self.__brightness.int_value = value
+
+
+class PowerSupply(object):
+    """Represents Linux power_supply_class sysfs nodes."""
+
+    def __init__(self, sys_path):
+        self._capacity = SysfsFile(sys_path / "capacity")
+        self._status = SysfsFile(sys_path / "status")
+        self._type = SysfsFile(sys_path / "type")
+
+    @property
+    def capacity(self) -> int:
+        return self._capacity.int_value
+
+    @property
+    def status(self) -> str:
+        return self._status.str_value
+
+    @property
+    def type(self) -> str:
+        return self._type.str_value
+
+
+class HIDIsReady(object):
+    """
+    Companion class that binds to a kernel mechanism
+    and that allows to know when a uhid device is ready or not.
+
+    See :meth:`is_ready` for details.
+    """
+
+    def __init__(self: "HIDIsReady", uhid: UHIDDevice) -> None:
+        self.uhid = uhid
+
+    def is_ready(self: "HIDIsReady") -> bool:
+        """
+        Overwrite in subclasses: should return True or False whether
+        the attached uhid device is ready or not.
+        """
+        return False
+
+
+class UdevHIDIsReady(HIDIsReady):
+    _pyudev_context: ClassVar[Optional[pyudev.Context]] = None
+    _pyudev_monitor: ClassVar[Optional[pyudev.Monitor]] = None
+    _uhid_devices: ClassVar[Dict[int, bool]] = {}
+
+    def __init__(self: "UdevHIDIsReady", uhid: UHIDDevice) -> None:
+        super().__init__(uhid)
+        self._init_pyudev()
+
+    @classmethod
+    def _init_pyudev(cls: Type["UdevHIDIsReady"]) -> None:
+        if cls._pyudev_context is None:
+            cls._pyudev_context = pyudev.Context()
+            cls._pyudev_monitor = pyudev.Monitor.from_netlink(cls._pyudev_context)
+            cls._pyudev_monitor.filter_by("hid")
+            cls._pyudev_monitor.start()
+
+            UHIDDevice._append_fd_to_poll(
+                cls._pyudev_monitor.fileno(), cls._cls_udev_event_callback
+            )
+
+    @classmethod
+    def _cls_udev_event_callback(cls: Type["UdevHIDIsReady"]) -> None:
+        if cls._pyudev_monitor is None:
+            return
+        event: pyudev.Device
+        for event in iter(functools.partial(cls._pyudev_monitor.poll, 0.02), None):
+            if event.action not in ["bind", "remove"]:
+                return
+
+            logger.debug(f"udev event: {event.action} -> {event}")
+
+            id = int(event.sys_path.strip().split(".")[-1], 16)
+
+            cls._uhid_devices[id] = event.action == "bind"
+
+    def is_ready(self: "UdevHIDIsReady") -> bool:
+        try:
+            return self._uhid_devices[self.uhid.hid_id]
+        except KeyError:
+            return False
+
+
+class EvdevMatch(object):
+    def __init__(
+        self: "EvdevMatch",
+        *,
+        requires: List[Any] = [],
+        excludes: List[Any] = [],
+        req_properties: List[Any] = [],
+        excl_properties: List[Any] = [],
+    ) -> None:
+        self.requires = requires
+        self.excludes = excludes
+        self.req_properties = req_properties
+        self.excl_properties = excl_properties
+
+    def is_a_match(self: "EvdevMatch", evdev: libevdev.Device) -> bool:
+        for m in self.requires:
+            if not evdev.has(m):
+                return False
+        for m in self.excludes:
+            if evdev.has(m):
+                return False
+        for p in self.req_properties:
+            if not evdev.has_property(p):
+                return False
+        for p in self.excl_properties:
+            if evdev.has_property(p):
+                return False
+        return True
+
+
+class EvdevDevice(object):
+    """
+    Represents an Evdev node and its properties.
+    This is a stub for the libevdev devices, as they are relying on
+    uevent to get the data, saving us some ioctls to fetch the names
+    and properties.
+    """
+
+    def __init__(self: "EvdevDevice", sysfs: Path) -> None:
+        self.sysfs = sysfs
+        self.event_node: Any = None
+        self.libevdev: Optional[libevdev.Device] = None
+
+        self.uevents = {}
+        # all of the interesting properties are stored in the input uevent, so in the parent
+        # so convert the uevent file of the parent input node into a dict
+        with open(sysfs.parent / "uevent") as f:
+            for line in f.readlines():
+                key, value = line.strip().split("=")
+                self.uevents[key] = value.strip('"')
+
+        # we open all evdev nodes in order to not miss any event
+        self.open()
+
+    @property
+    def name(self: "EvdevDevice") -> str:
+        assert "NAME" in self.uevents
+
+        return self.uevents["NAME"]
+
+    @property
+    def evdev(self: "EvdevDevice") -> Path:
+        return Path("/dev/input") / self.sysfs.name
+
+    def matches_application(
+        self: "EvdevDevice", application: str, matches: Dict[str, EvdevMatch]
+    ) -> bool:
+        if self.libevdev is None:
+            return False
+
+        if application in matches:
+            return matches[application].is_a_match(self.libevdev)
+
+        logger.error(
+            f"application '{application}' is unknown, please update/fix hid-tools"
+        )
+        assert False  # hid-tools likely needs an update
+
+    def open(self: "EvdevDevice") -> libevdev.Device:
+        self.event_node = open(self.evdev, "rb")
+        self.libevdev = libevdev.Device(self.event_node)
+
+        assert self.libevdev.fd is not None
+
+        fd = self.libevdev.fd.fileno()
+        flag = fcntl.fcntl(fd, fcntl.F_GETFD)
+        fcntl.fcntl(fd, fcntl.F_SETFL, flag | os.O_NONBLOCK)
+
+        return self.libevdev
+
+    def close(self: "EvdevDevice") -> None:
+        if self.libevdev is not None and self.libevdev.fd is not None:
+            self.libevdev.fd.close()
+            self.libevdev = None
+        if self.event_node is not None:
+            self.event_node.close()
+            self.event_node = None
+
+
+class BaseDevice(UHIDDevice):
+    # default _application_matches that matches nothing. This needs
+    # to be set in the subclasses to have get_evdev() working
+    _application_matches: Dict[str, EvdevMatch] = {}
+
+    def __init__(
+        self,
+        name,
+        application,
+        rdesc_str: Optional[str] = None,
+        rdesc: Optional[Union[hid.ReportDescriptor, str, bytes]] = None,
+        input_info=None,
+    ) -> None:
+        self._kernel_is_ready: HIDIsReady = UdevHIDIsReady(self)
+        if rdesc_str is None and rdesc is None:
+            raise Exception("Please provide at least a rdesc or rdesc_str")
+        super().__init__()
+        if name is None:
+            name = f"uhid gamepad test {self.__class__.__name__}"
+        if input_info is None:
+            input_info = (BusType.USB, 1, 2)
+        self.name = name
+        self.info = input_info
+        self.default_reportID = None
+        self.opened = False
+        self.started = False
+        self.application = application
+        self._input_nodes: Optional[list[EvdevDevice]] = None
+        if rdesc is None:
+            assert rdesc_str is not None
+            self.rdesc = hid.ReportDescriptor.from_human_descr(rdesc_str)  # type: ignore
+        else:
+            self.rdesc = rdesc  # type: ignore
+
+    @property
+    def power_supply_class(self: "BaseDevice") -> Optional[PowerSupply]:
+        ps = self.walk_sysfs("power_supply", "power_supply/*")
+        if ps is None or len(ps) < 1:
+            return None
+
+        return PowerSupply(ps[0])
+
+    @property
+    def led_classes(self: "BaseDevice") -> List[LED]:
+        leds = self.walk_sysfs("led", "**/max_brightness")
+        if leds is None:
+            return []
+
+        return [LED(led.parent) for led in leds]
+
+    @property
+    def kernel_is_ready(self: "BaseDevice") -> bool:
+        return self._kernel_is_ready.is_ready() and self.started
+
+    @property
+    def input_nodes(self: "BaseDevice") -> List[EvdevDevice]:
+        if self._input_nodes is not None:
+            return self._input_nodes
+
+        if not self.kernel_is_ready or not self.started:
+            return []
+
+        self._input_nodes = [
+            EvdevDevice(path)
+            for path in self.walk_sysfs("input", "input/input*/event*")
+        ]
+        return self._input_nodes
+
+    def match_evdev_rule(self, application, evdev):
+        """Replace this in subclasses if the device has multiple reports
+        of the same type and we need to filter based on the actual evdev
+        node.
+
+        returning True will append the corresponding report to
+        `self.input_nodes[type]`
+        returning False  will ignore this report / type combination
+        for the device.
+        """
+        return True
+
+    def open(self):
+        self.opened = True
+
+    def _close_all_opened_evdev(self):
+        if self._input_nodes is not None:
+            for e in self._input_nodes:
+                e.close()
+
+    def __del__(self):
+        self._close_all_opened_evdev()
+
+    def close(self):
+        self.opened = False
+
+    def start(self, flags):
+        self.started = True
+
+    def stop(self):
+        self.started = False
+        self._close_all_opened_evdev()
+
+    def next_sync_events(self, application=None):
+        evdev = self.get_evdev(application)
+        if evdev is not None:
+            return list(evdev.events())
+        return []
+
+    @property
+    def application_matches(self: "BaseDevice") -> Dict[str, EvdevMatch]:
+        return self._application_matches
+
+    @application_matches.setter
+    def application_matches(self: "BaseDevice", data: Dict[str, EvdevMatch]) -> None:
+        self._application_matches = data
+
+    def get_evdev(self, application=None):
+        if application is None:
+            application = self.application
+
+        if len(self.input_nodes) == 0:
+            return None
+
+        assert self._input_nodes is not None
+
+        if len(self._input_nodes) == 1:
+            evdev = self._input_nodes[0]
+            if self.match_evdev_rule(application, evdev.libevdev):
+                return evdev.libevdev
+        else:
+            for _evdev in self._input_nodes:
+                if _evdev.matches_application(application, self.application_matches):
+                    if self.match_evdev_rule(application, _evdev.libevdev):
+                        return _evdev.libevdev
+
+    def is_ready(self):
+        """Returns whether a UHID device is ready. Can be overwritten in
+        subclasses to add extra conditions on when to consider a UHID
+        device ready. This can be:
+
+        - we need to wait on different types of input devices to be ready
+          (Touch Screen and Pen for example)
+        - we need to have at least 4 LEDs present
+          (len(self.uhdev.leds_classes) == 4)
+        - or any other combinations"""
+        return self.kernel_is_ready

-- 
2.44.0


