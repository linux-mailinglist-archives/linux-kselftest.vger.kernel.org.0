Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383D869B0AD
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Feb 2023 17:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjBQQUr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Feb 2023 11:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjBQQUa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Feb 2023 11:20:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002F26FF05
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Feb 2023 08:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676650744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HVsOUldtjpJvVyw0Csw/egkP/31uwH/LRh0j7R/R6EY=;
        b=ajvihv6s950aJkc5KDs7iC0GFleXXRoiz1TKbA6V04NKzWVx+ADoaXTlwrmQKjiv7M5989
        la81Pb6ZzJdFuBL9kl/Qso4kHLtakbfqJ2l4tfJu4XMHqbNPBbkQXbWyV6WIJxcbAlg/0d
        M9pXIzHXzEb1d87vFPCckodyAVCxMXM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-qDSt2WXuOr6KDHyTqBu6FQ-1; Fri, 17 Feb 2023 11:19:03 -0500
X-MC-Unique: qDSt2WXuOr6KDHyTqBu6FQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F0793C025C4;
        Fri, 17 Feb 2023 16:19:02 +0000 (UTC)
Received: from xps-13.local (unknown [10.39.193.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ECDADC15BA0;
        Fri, 17 Feb 2023 16:19:00 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 17 Feb 2023 17:18:04 +0100
Subject: [PATCH 10/11] selftests: hid: import hid-tools hid-sony and
 hid-playstation tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-import-hid-tools-tests-v1-10-d1c48590d0ee@redhat.com>
References: <20230217-import-hid-tools-tests-v1-0-d1c48590d0ee@redhat.com>
In-Reply-To: <20230217-import-hid-tools-tests-v1-0-d1c48590d0ee@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Roderick Colenbrander <roderick.colenbrander@sony.com>,
        Jose Torreguitar <jtguitar@google.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676650715; l=13986;
 i=benjamin.tissoires@redhat.com; s=20230215; h=from:subject:message-id;
 bh=tFgoHCJsykqT5eoFuiHk5bbXNKEXLpiSTqTgdIQzyV4=;
 b=izyDrJ6JP9r/c463+7YgXbEpicHNskk+j3rxG5oqOfOajMSSLXPLcSacwx/CM9uj7BLMVyJ0A
 gYGA1TCbrXcCVY2crK7SGzaINTZfX/yBva+vkdJZizs62Knc5KE6g4u
X-Developer-Key: i=benjamin.tissoires@redhat.com; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

These tests have been developed in the hid-tools[0] tree for a while.
Now that we have  a proper selftests/hid kernel entry and that the tests
are more reliable, it is time to directly include those in the kernel
tree.

[0] https://gitlab.freedesktop.org/libevdev/hid-tools

Cc: Roderick Colenbrander <roderick.colenbrander@sony.com>
Cc: Jose Torreguitar <jtguitar@google.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 tools/testing/selftests/hid/Makefile           |   1 +
 tools/testing/selftests/hid/config             |   5 +
 tools/testing/selftests/hid/hid-sony.sh        |   7 +
 tools/testing/selftests/hid/tests/test_sony.py | 282 +++++++++++++++++++++++++
 4 files changed, 295 insertions(+)

diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
index 3ca696c44aab..dcea4f1e9369 100644
--- a/tools/testing/selftests/hid/Makefile
+++ b/tools/testing/selftests/hid/Makefile
@@ -12,6 +12,7 @@ TEST_PROGS += hid-ite.sh
 TEST_PROGS += hid-keyboard.sh
 TEST_PROGS += hid-mouse.sh
 TEST_PROGS += hid-multitouch.sh
+TEST_PROGS += hid-sony.sh
 TEST_PROGS += hid-tablet.sh
 TEST_PROGS += hid-wacom.sh
 
diff --git a/tools/testing/selftests/hid/config b/tools/testing/selftests/hid/config
index f400b8d94e3c..442a5ea16325 100644
--- a/tools/testing/selftests/hid/config
+++ b/tools/testing/selftests/hid/config
@@ -19,9 +19,14 @@ CONFIG_HIDRAW=y
 CONFIG_HID=y
 CONFIG_INPUT_EVDEV=y
 CONFIG_UHID=y
+CONFIG_LEDS_CLASS_MULTICOLOR=y
 CONFIG_USB=y
 CONFIG_USB_HID=y
 CONFIG_HID_APPLE=y
 CONFIG_HID_ITE=y
 CONFIG_HID_MULTITOUCH=y
+CONFIG_HID_PLAYSTATION=y
+CONFIG_PLAYSTATION_FF=y
+CONFIG_HID_SONY=y
+CONFIG_SONY_FF=y
 CONFIG_HID_WACOM=y
diff --git a/tools/testing/selftests/hid/hid-sony.sh b/tools/testing/selftests/hid/hid-sony.sh
new file mode 100755
index 000000000000..c863c442686e
--- /dev/null
+++ b/tools/testing/selftests/hid/hid-sony.sh
@@ -0,0 +1,7 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Runs tests for the HID subsystem
+
+export TARGET=test_sony.py
+
+bash ./run-hid-tools-tests.sh
diff --git a/tools/testing/selftests/hid/tests/test_sony.py b/tools/testing/selftests/hid/tests/test_sony.py
new file mode 100644
index 000000000000..c80f50ed29d3
--- /dev/null
+++ b/tools/testing/selftests/hid/tests/test_sony.py
@@ -0,0 +1,282 @@
+#!/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# -*- coding: utf-8 -*-
+#
+# Copyright (c) 2020 Benjamin Tissoires <benjamin.tissoires@gmail.com>
+# Copyright (c) 2020 Red Hat, Inc.
+#
+
+from .base import application_matches
+from .test_gamepad import BaseTest
+from hidtools.device.sony_gamepad import (
+    PS3Controller,
+    PS4ControllerBluetooth,
+    PS4ControllerUSB,
+    PS5ControllerBluetooth,
+    PS5ControllerUSB,
+    PSTouchPoint,
+)
+from hidtools.util import BusType
+
+import libevdev
+import logging
+import pytest
+
+logger = logging.getLogger("hidtools.test.sony")
+
+PS3_MODULE = ("sony", "hid_sony")
+PS4_MODULE = ("playstation", "hid_playstation")
+PS5_MODULE = ("playstation", "hid_playstation")
+
+
+class SonyBaseTest:
+    class SonyTest(BaseTest.TestGamepad):
+        pass
+
+    class SonyPS4ControllerTest(SonyTest):
+        kernel_modules = [PS4_MODULE]
+
+        def test_accelerometer(self):
+            uhdev = self.uhdev
+            evdev = uhdev.get_evdev("Accelerometer")
+
+            for x in range(-32000, 32000, 4000):
+                r = uhdev.event(accel=(x, None, None))
+                events = uhdev.next_sync_events("Accelerometer")
+                self.debug_reports(r, uhdev, events)
+
+                assert libevdev.InputEvent(libevdev.EV_ABS.ABS_X) in events
+                value = evdev.value[libevdev.EV_ABS.ABS_X]
+                # Check against range due to small loss in precision due
+                # to inverse calibration, followed by calibration by hid-sony.
+                assert x - 1 <= value <= x + 1
+
+            for y in range(-32000, 32000, 4000):
+                r = uhdev.event(accel=(None, y, None))
+                events = uhdev.next_sync_events("Accelerometer")
+                self.debug_reports(r, uhdev, events)
+
+                assert libevdev.InputEvent(libevdev.EV_ABS.ABS_Y) in events
+                value = evdev.value[libevdev.EV_ABS.ABS_Y]
+                assert y - 1 <= value <= y + 1
+
+            for z in range(-32000, 32000, 4000):
+                r = uhdev.event(accel=(None, None, z))
+                events = uhdev.next_sync_events("Accelerometer")
+                self.debug_reports(r, uhdev, events)
+
+                assert libevdev.InputEvent(libevdev.EV_ABS.ABS_Z) in events
+                value = evdev.value[libevdev.EV_ABS.ABS_Z]
+                assert z - 1 <= value <= z + 1
+
+        def test_gyroscope(self):
+            uhdev = self.uhdev
+            evdev = uhdev.get_evdev("Accelerometer")
+
+            for rx in range(-2000000, 2000000, 200000):
+                r = uhdev.event(gyro=(rx, None, None))
+                events = uhdev.next_sync_events("Accelerometer")
+                self.debug_reports(r, uhdev, events)
+
+                assert libevdev.InputEvent(libevdev.EV_ABS.ABS_RX) in events
+                value = evdev.value[libevdev.EV_ABS.ABS_RX]
+                # Sensor internal value is 16-bit, but calibrated is 22-bit, so
+                # 6-bit (64) difference, so allow a range of +/- 64.
+                assert rx - 64 <= value <= rx + 64
+
+            for ry in range(-2000000, 2000000, 200000):
+                r = uhdev.event(gyro=(None, ry, None))
+                events = uhdev.next_sync_events("Accelerometer")
+                self.debug_reports(r, uhdev, events)
+
+                assert libevdev.InputEvent(libevdev.EV_ABS.ABS_RY) in events
+                value = evdev.value[libevdev.EV_ABS.ABS_RY]
+                assert ry - 64 <= value <= ry + 64
+
+            for rz in range(-2000000, 2000000, 200000):
+                r = uhdev.event(gyro=(None, None, rz))
+                events = uhdev.next_sync_events("Accelerometer")
+                self.debug_reports(r, uhdev, events)
+
+                assert libevdev.InputEvent(libevdev.EV_ABS.ABS_RZ) in events
+                value = evdev.value[libevdev.EV_ABS.ABS_RZ]
+                assert rz - 64 <= value <= rz + 64
+
+        def test_battery(self):
+            uhdev = self.uhdev
+
+            assert uhdev.power_supply_class is not None
+
+            # DS4 capacity levels are in increments of 10.
+            # Battery is never below 5%.
+            for i in range(5, 105, 10):
+                uhdev.battery.capacity = i
+                uhdev.event()
+                assert uhdev.power_supply_class.capacity == i
+
+            # Discharging tests only make sense for BlueTooth.
+            if uhdev.bus == BusType.BLUETOOTH:
+                uhdev.battery.cable_connected = False
+                uhdev.battery.capacity = 45
+                uhdev.event()
+                assert uhdev.power_supply_class.status == "Discharging"
+
+            uhdev.battery.cable_connected = True
+            uhdev.battery.capacity = 5
+            uhdev.event()
+            assert uhdev.power_supply_class.status == "Charging"
+
+            uhdev.battery.capacity = 100
+            uhdev.event()
+            assert uhdev.power_supply_class.status == "Charging"
+
+            uhdev.battery.full = True
+            uhdev.event()
+            assert uhdev.power_supply_class.status == "Full"
+
+        def test_mt_single_touch(self):
+            """send a single touch in the first slot of the device,
+            and release it."""
+            uhdev = self.uhdev
+            evdev = uhdev.get_evdev("Touch Pad")
+
+            t0 = PSTouchPoint(1, 50, 100)
+            r = uhdev.event(touch=[t0])
+            events = uhdev.next_sync_events("Touch Pad")
+            self.debug_reports(r, uhdev, events)
+
+            assert libevdev.InputEvent(libevdev.EV_KEY.BTN_TOUCH, 1) in events
+            assert evdev.slots[0][libevdev.EV_ABS.ABS_MT_TRACKING_ID] == 0
+            assert evdev.slots[0][libevdev.EV_ABS.ABS_MT_POSITION_X] == 50
+            assert evdev.slots[0][libevdev.EV_ABS.ABS_MT_POSITION_Y] == 100
+
+            t0.tipswitch = False
+            r = uhdev.event(touch=[t0])
+            events = uhdev.next_sync_events("Touch Pad")
+            self.debug_reports(r, uhdev, events)
+            assert libevdev.InputEvent(libevdev.EV_KEY.BTN_TOUCH, 0) in events
+            assert evdev.slots[0][libevdev.EV_ABS.ABS_MT_TRACKING_ID] == -1
+
+        def test_mt_dual_touch(self):
+            """Send 2 touches in the first 2 slots.
+            Make sure the kernel sees this as a dual touch.
+            Release and check
+
+            Note: PTP will send here BTN_DOUBLETAP emulation"""
+            uhdev = self.uhdev
+            evdev = uhdev.get_evdev("Touch Pad")
+
+            t0 = PSTouchPoint(1, 50, 100)
+            t1 = PSTouchPoint(2, 150, 200)
+
+            r = uhdev.event(touch=[t0])
+            events = uhdev.next_sync_events("Touch Pad")
+            self.debug_reports(r, uhdev, events)
+
+            assert libevdev.InputEvent(libevdev.EV_KEY.BTN_TOUCH, 1) in events
+            assert evdev.value[libevdev.EV_KEY.BTN_TOUCH] == 1
+            assert evdev.slots[0][libevdev.EV_ABS.ABS_MT_TRACKING_ID] == 0
+            assert evdev.slots[0][libevdev.EV_ABS.ABS_MT_POSITION_X] == 50
+            assert evdev.slots[0][libevdev.EV_ABS.ABS_MT_POSITION_Y] == 100
+            assert evdev.slots[1][libevdev.EV_ABS.ABS_MT_TRACKING_ID] == -1
+
+            r = uhdev.event(touch=[t0, t1])
+            events = uhdev.next_sync_events("Touch Pad")
+            self.debug_reports(r, uhdev, events)
+            assert libevdev.InputEvent(libevdev.EV_KEY.BTN_TOUCH) not in events
+            assert evdev.value[libevdev.EV_KEY.BTN_TOUCH] == 1
+            assert (
+                libevdev.InputEvent(libevdev.EV_ABS.ABS_MT_POSITION_X, 5) not in events
+            )
+            assert (
+                libevdev.InputEvent(libevdev.EV_ABS.ABS_MT_POSITION_Y, 10) not in events
+            )
+            assert evdev.slots[0][libevdev.EV_ABS.ABS_MT_TRACKING_ID] == 0
+            assert evdev.slots[0][libevdev.EV_ABS.ABS_MT_POSITION_X] == 50
+            assert evdev.slots[0][libevdev.EV_ABS.ABS_MT_POSITION_Y] == 100
+            assert evdev.slots[1][libevdev.EV_ABS.ABS_MT_TRACKING_ID] == 1
+            assert evdev.slots[1][libevdev.EV_ABS.ABS_MT_POSITION_X] == 150
+            assert evdev.slots[1][libevdev.EV_ABS.ABS_MT_POSITION_Y] == 200
+
+            t0.tipswitch = False
+            r = uhdev.event(touch=[t0, t1])
+            events = uhdev.next_sync_events("Touch Pad")
+            self.debug_reports(r, uhdev, events)
+            assert evdev.slots[0][libevdev.EV_ABS.ABS_MT_TRACKING_ID] == -1
+            assert evdev.slots[1][libevdev.EV_ABS.ABS_MT_TRACKING_ID] == 1
+            assert libevdev.InputEvent(libevdev.EV_ABS.ABS_MT_POSITION_X) not in events
+            assert libevdev.InputEvent(libevdev.EV_ABS.ABS_MT_POSITION_Y) not in events
+
+            t1.tipswitch = False
+            r = uhdev.event(touch=[t1])
+
+            events = uhdev.next_sync_events("Touch Pad")
+            self.debug_reports(r, uhdev, events)
+            assert evdev.slots[0][libevdev.EV_ABS.ABS_MT_TRACKING_ID] == -1
+            assert evdev.slots[1][libevdev.EV_ABS.ABS_MT_TRACKING_ID] == -1
+
+
+class TestPS3Controller(SonyBaseTest.SonyTest):
+    kernel_modules = [PS3_MODULE]
+
+    def create_device(self):
+        controller = PS3Controller()
+        controller.application_matches = application_matches
+        return controller
+
+    @pytest.fixture(autouse=True)
+    def start_controller(self):
+        # emulate a 'PS' button press to tell the kernel we are ready to accept events
+        self.assert_button(17)
+
+        # drain any remaining udev events
+        while self.uhdev.dispatch(10):
+            pass
+
+        def test_led(self):
+            for k, v in self.uhdev.led_classes.items():
+                # the kernel might have set a LED for us
+                logger.info(f"{k}: {v.brightness}")
+
+                idx = int(k[-1]) - 1
+                assert self.uhdev.hw_leds.get_led(idx)[0] == bool(v.brightness)
+
+                v.brightness = 0
+                self.uhdev.dispatch(10)
+                assert self.uhdev.hw_leds.get_led(idx)[0] is False
+
+                v.brightness = v.max_brightness
+                self.uhdev.dispatch(10)
+                assert self.uhdev.hw_leds.get_led(idx)[0]
+
+
+class TestPS4ControllerBluetooth(SonyBaseTest.SonyPS4ControllerTest):
+    def create_device(self):
+        controller = PS4ControllerBluetooth()
+        controller.application_matches = application_matches
+        return controller
+
+
+class TestPS4ControllerUSB(SonyBaseTest.SonyPS4ControllerTest):
+    def create_device(self):
+        controller = PS4ControllerUSB()
+        controller.application_matches = application_matches
+        return controller
+
+
+class TestPS5ControllerBluetooth(SonyBaseTest.SonyPS4ControllerTest):
+    kernel_modules = [PS5_MODULE]
+
+    def create_device(self):
+        controller = PS5ControllerBluetooth()
+        controller.application_matches = application_matches
+        return controller
+
+
+class TestPS5ControllerUSB(SonyBaseTest.SonyPS4ControllerTest):
+    kernel_modules = [PS5_MODULE]
+
+    def create_device(self):
+        controller = PS5ControllerUSB()
+        controller.application_matches = application_matches
+        return controller

-- 
2.39.1

