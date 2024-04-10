Return-Path: <linux-kselftest+bounces-7593-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB7489FE5E
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 19:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B695F287A7A
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 17:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5518818413E;
	Wed, 10 Apr 2024 17:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adzndfOj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27962184109;
	Wed, 10 Apr 2024 17:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712769623; cv=none; b=RSSpnz4Uvy6YPJr0EUUqeKGunO9HfhCPUGsG6g7xtgzthiegyFFiL+M5OWmIdUxKuc3TqxZvOnep2AaqhTkXdxaxPB3R/oorNg2L/U8lTg9OGhBUmfFWJK42Q4oCDApslgkap0iNLN0H0+jsKy+FzZEhFczCdfZc8nBaZEkXSYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712769623; c=relaxed/simple;
	bh=mxxMt93t+tbjqpDOR0aHjBbFHk8sQKrIU806mhHGKC0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AIUD0FewApvPaJP9vHb2ZYf93KAadw25J7AjVD7UZjDDk7WPVNtAVzN4MQbjj0oBNkbQ81KM5rkMpUFL0ba46j9PaxsqSm5FSPPHI2QHGQZID0oVfYftipBALVdFQxe3Z8FIyfNDQ1PBAV1W0wQI4OLXQm0NYuohq7JW+mA/QGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adzndfOj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B5C0C433A6;
	Wed, 10 Apr 2024 17:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712769623;
	bh=mxxMt93t+tbjqpDOR0aHjBbFHk8sQKrIU806mhHGKC0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=adzndfOjx3n/9PiY9/wwEXUZDgMAur5AthIBEnvVuXjbrIFHUkKZTGso69skszqwz
	 PUiiuLRVVmzq9zWqzoDgOjWAOJounzWmZ2sLXAbVNwiHCI0imW9B6qCMvmQMMBWmdM
	 WDAeAYe9YRrddOB+EaLJBuwLmMknTvRh98GuZF9Qh74JTKUiaiVh33ZZourl8A2tRa
	 moJ9nNwnMelizIDJ7/uDX3WJzIGx3ZcFzp8qsc3hA2brW9gbRK/ewM9zdqxiRpdOXO
	 3Gm50MabP1LnWsWgKCL6kQscFd/RLk7vcyzhMu6CEkv2fbqnrTSjvXE9b+ebJk23n7
	 gQ7A98lRlQndg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 10 Apr 2024 19:19:36 +0200
Subject: [PATCH 16/18] selftests/hid: import base_gamepad.py from hid-tools
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-bpf_sources-v1-16-a8bf16033ef8@kernel.org>
References: <20240410-bpf_sources-v1-0-a8bf16033ef8@kernel.org>
In-Reply-To: <20240410-bpf_sources-v1-0-a8bf16033ef8@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712769589; l=8974;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=mxxMt93t+tbjqpDOR0aHjBbFHk8sQKrIU806mhHGKC0=;
 b=IGEWimU050ngC/R/h1dkR2nbCPfopOSBQ64DJrxLpGRKaN2rGxzpNZQNB3xUuw8NBssPxcM10
 PlYUSz0CzunD30mHFVZeMfkK8i6LX7uonc7IDrrjePBnTx1HOzhdKCo
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

We need to slightly change base_device.py for supporting HID-BPF,
so instead of monkey patching, let's just embed it in the kernel tree.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/tests/base_gamepad.py | 238 ++++++++++++++++++++++
 tools/testing/selftests/hid/tests/test_gamepad.py |   5 +-
 2 files changed, 242 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/hid/tests/base_gamepad.py b/tools/testing/selftests/hid/tests/base_gamepad.py
new file mode 100644
index 000000000000..ec74d75767a2
--- /dev/null
+++ b/tools/testing/selftests/hid/tests/base_gamepad.py
@@ -0,0 +1,238 @@
+# SPDX-License-Identifier: GPL-2.0
+import libevdev
+
+from .base_device import BaseDevice
+from hidtools.util import BusType
+
+
+class InvalidHIDCommunication(Exception):
+    pass
+
+
+class GamepadData(object):
+    pass
+
+
+class AxisMapping(object):
+    """Represents a mapping between a HID type
+    and an evdev event"""
+
+    def __init__(self, hid, evdev=None):
+        self.hid = hid.lower()
+
+        if evdev is None:
+            evdev = f"ABS_{hid.upper()}"
+
+        self.evdev = libevdev.evbit("EV_ABS", evdev)
+
+
+class BaseGamepad(BaseDevice):
+    buttons_map = {
+        1: "BTN_SOUTH",
+        2: "BTN_EAST",
+        3: "BTN_C",
+        4: "BTN_NORTH",
+        5: "BTN_WEST",
+        6: "BTN_Z",
+        7: "BTN_TL",
+        8: "BTN_TR",
+        9: "BTN_TL2",
+        10: "BTN_TR2",
+        11: "BTN_SELECT",
+        12: "BTN_START",
+        13: "BTN_MODE",
+        14: "BTN_THUMBL",
+        15: "BTN_THUMBR",
+    }
+
+    axes_map = {
+        "left_stick": {
+            "x": AxisMapping("x"),
+            "y": AxisMapping("y"),
+        },
+        "right_stick": {
+            "x": AxisMapping("z"),
+            "y": AxisMapping("Rz"),
+        },
+    }
+
+    def __init__(self, rdesc, application="Game Pad", name=None, input_info=None):
+        assert rdesc is not None
+        super().__init__(name, application, input_info=input_info, rdesc=rdesc)
+        self.buttons = (1, 2, 3)
+        self._buttons = {}
+        self.left = (127, 127)
+        self.right = (127, 127)
+        self.hat_switch = 15
+        assert self.parsed_rdesc is not None
+
+        self.fields = []
+        for r in self.parsed_rdesc.input_reports.values():
+            if r.application_name == self.application:
+                self.fields.extend([f.usage_name for f in r])
+
+    def store_axes(self, which, gamepad, data):
+        amap = self.axes_map[which]
+        x, y = data
+        setattr(gamepad, amap["x"].hid, x)
+        setattr(gamepad, amap["y"].hid, y)
+
+    def create_report(
+        self,
+        *,
+        left=(None, None),
+        right=(None, None),
+        hat_switch=None,
+        buttons=None,
+        reportID=None,
+        application="Game Pad",
+    ):
+        """
+        Return an input report for this device.
+
+        :param left: a tuple of absolute (x, y) value of the left joypad
+            where ``None`` is "leave unchanged"
+        :param right: a tuple of absolute (x, y) value of the right joypad
+            where ``None`` is "leave unchanged"
+        :param hat_switch: an absolute angular value of the hat switch
+            (expressed in 1/8 of circle, 0 being North, 2 East)
+            where ``None`` is "leave unchanged"
+        :param buttons: a dict of index/bool for the button states,
+            where ``None`` is "leave unchanged"
+        :param reportID: the numeric report ID for this report, if needed
+        :param application: the application used to report the values
+        """
+        if buttons is not None:
+            for i, b in buttons.items():
+                if i not in self.buttons:
+                    raise InvalidHIDCommunication(
+                        f"button {i} is not part of this {self.application}"
+                    )
+                if b is not None:
+                    self._buttons[i] = b
+
+        def replace_none_in_tuple(item, default):
+            if item is None:
+                item = (None, None)
+
+            if None in item:
+                if item[0] is None:
+                    item = (default[0], item[1])
+                if item[1] is None:
+                    item = (item[0], default[1])
+
+            return item
+
+        right = replace_none_in_tuple(right, self.right)
+        self.right = right
+        left = replace_none_in_tuple(left, self.left)
+        self.left = left
+
+        if hat_switch is None:
+            hat_switch = self.hat_switch
+        else:
+            self.hat_switch = hat_switch
+
+        reportID = reportID or self.default_reportID
+
+        gamepad = GamepadData()
+        for i, b in self._buttons.items():
+            gamepad.__setattr__(f"b{i}", int(b) if b is not None else 0)
+
+        self.store_axes("left_stick", gamepad, left)
+        self.store_axes("right_stick", gamepad, right)
+        gamepad.hatswitch = hat_switch  # type: ignore  ### gamepad is by default empty
+        return super().create_report(
+            gamepad, reportID=reportID, application=application
+        )
+
+    def event(
+        self, *, left=(None, None), right=(None, None), hat_switch=None, buttons=None
+    ):
+        """
+        Send an input event on the default report ID.
+
+        :param left: a tuple of absolute (x, y) value of the left joypad
+            where ``None`` is "leave unchanged"
+        :param right: a tuple of absolute (x, y) value of the right joypad
+            where ``None`` is "leave unchanged"
+        :param hat_switch: an absolute angular value of the hat switch
+            where ``None`` is "leave unchanged"
+        :param buttons: a dict of index/bool for the button states,
+            where ``None`` is "leave unchanged"
+        """
+        r = self.create_report(
+            left=left, right=right, hat_switch=hat_switch, buttons=buttons
+        )
+        self.call_input_event(r)
+        return [r]
+
+
+class JoystickGamepad(BaseGamepad):
+    buttons_map = {
+        1: "BTN_TRIGGER",
+        2: "BTN_THUMB",
+        3: "BTN_THUMB2",
+        4: "BTN_TOP",
+        5: "BTN_TOP2",
+        6: "BTN_PINKIE",
+        7: "BTN_BASE",
+        8: "BTN_BASE2",
+        9: "BTN_BASE3",
+        10: "BTN_BASE4",
+        11: "BTN_BASE5",
+        12: "BTN_BASE6",
+        13: "BTN_DEAD",
+    }
+
+    axes_map = {
+        "left_stick": {
+            "x": AxisMapping("x"),
+            "y": AxisMapping("y"),
+        },
+        "right_stick": {
+            "x": AxisMapping("rudder"),
+            "y": AxisMapping("throttle"),
+        },
+    }
+
+    def __init__(self, rdesc, application="Joystick", name=None, input_info=None):
+        super().__init__(rdesc, application, name, input_info)
+
+    def create_report(
+        self,
+        *,
+        left=(None, None),
+        right=(None, None),
+        hat_switch=None,
+        buttons=None,
+        reportID=None,
+        application=None,
+    ):
+        """
+        Return an input report for this device.
+
+        :param left: a tuple of absolute (x, y) value of the left joypad
+            where ``None`` is "leave unchanged"
+        :param right: a tuple of absolute (x, y) value of the right joypad
+            where ``None`` is "leave unchanged"
+        :param hat_switch: an absolute angular value of the hat switch
+            where ``None`` is "leave unchanged"
+        :param buttons: a dict of index/bool for the button states,
+            where ``None`` is "leave unchanged"
+        :param reportID: the numeric report ID for this report, if needed
+        :param application: the application for this report, if needed
+        """
+        if application is None:
+            application = "Joystick"
+        return super().create_report(
+            left=left,
+            right=right,
+            hat_switch=hat_switch,
+            buttons=buttons,
+            reportID=reportID,
+            application=application,
+        )
+
+    def store_right_joystick(self, gamepad, data):
+        gamepad.rudder, gamepad.throttle = data
diff --git a/tools/testing/selftests/hid/tests/test_gamepad.py b/tools/testing/selftests/hid/tests/test_gamepad.py
index 26c74040b796..900fff044348 100644
--- a/tools/testing/selftests/hid/tests/test_gamepad.py
+++ b/tools/testing/selftests/hid/tests/test_gamepad.py
@@ -10,7 +10,10 @@ from . import base
 import libevdev
 import pytest
 
-from hidtools.device.base_gamepad import AsusGamepad, SaitekGamepad
+from .base_gamepad import (
+    AsusGamepad,
+    SaitekGamepad,
+)
 
 import logging
 

-- 
2.44.0


