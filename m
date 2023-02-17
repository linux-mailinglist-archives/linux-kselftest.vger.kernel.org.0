Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC86769B096
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Feb 2023 17:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjBQQUV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Feb 2023 11:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjBQQUR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Feb 2023 11:20:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2627E714A3
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Feb 2023 08:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676650728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t7mJsdBsB0TbJqoqY9x4ZhylWOnsPAyIa0tLN+Q45Uo=;
        b=YvSsEgLjQ2WotaKrBkg++VH2Bl8rq9/LgaX4TbiIup4Mi9aBi8DUChbmjpkwySs8KjEwOP
        leaVAbaI0+mIHgo8TD/R0HIXF2EB0W5x/RFCAzRJcFai3l8J4AsH8no63b/knW4Vm2Cgzm
        2w9dpztKne5JKSyvV8Sp6tT2jYmQvQw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-513-VWDTAFVkMWmjTOGFTrdV5Q-1; Fri, 17 Feb 2023 11:18:46 -0500
X-MC-Unique: VWDTAFVkMWmjTOGFTrdV5Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3FB41C05AD5;
        Fri, 17 Feb 2023 16:18:45 +0000 (UTC)
Received: from xps-13.local (unknown [10.39.193.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F2DE4C15BA0;
        Fri, 17 Feb 2023 16:18:43 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 17 Feb 2023 17:17:57 +0100
Subject: [PATCH 03/11] selftests: hid: import hid-tools hid-gamepad tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-import-hid-tools-tests-v1-3-d1c48590d0ee@redhat.com>
References: <20230217-import-hid-tools-tests-v1-0-d1c48590d0ee@redhat.com>
In-Reply-To: <20230217-import-hid-tools-tests-v1-0-d1c48590d0ee@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Candle Sun <candle.sun@unisoc.com>,
        Jose Torreguitar <jtguitar@google.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Roderick Colenbrander <roderick.colenbrander@sony.com>,
        Silvan Jegen <s.jegen@gmail.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676650715; l=9948;
 i=benjamin.tissoires@redhat.com; s=20230215; h=from:subject:message-id;
 bh=Sra9Q171hmNz0YtouUS6HVzlBGBdWXuPKzRZhAglX/Y=;
 b=xBpkb7spzYZSEqFqf+/K7Q51tPImKljgdFxsbb71xzB0IgERTWBf2C2tSTM59mJJfkGUzyqH4
 bxPE163PDUQCMqmYhyhtTwU+qZFi6Tx7591YpIW+GnPoPmOXkbbOtvT
X-Developer-Key: i=benjamin.tissoires@redhat.com; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
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

Cc: Candle Sun <candle.sun@unisoc.com>
Cc: Jose Torreguitar <jtguitar@google.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Roderick Colenbrander <roderick.colenbrander@sony.com>
Cc: Silvan Jegen <s.jegen@gmail.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 tools/testing/selftests/hid/Makefile              |   1 +
 tools/testing/selftests/hid/hid-gamepad.sh        |   7 +
 tools/testing/selftests/hid/tests/test_gamepad.py | 209 ++++++++++++++++++++++
 3 files changed, 217 insertions(+)

diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
index bdcb36d80c8c..d16a22477140 100644
--- a/tools/testing/selftests/hid/Makefile
+++ b/tools/testing/selftests/hid/Makefile
@@ -6,6 +6,7 @@ include ../../../scripts/Makefile.arch
 include ../../../scripts/Makefile.include
 
 TEST_PROGS := hid-core.sh
+TEST_PROGS += hid-gamepad.sh
 
 CXX ?= $(CROSS_COMPILE)g++
 
diff --git a/tools/testing/selftests/hid/hid-gamepad.sh b/tools/testing/selftests/hid/hid-gamepad.sh
new file mode 100755
index 000000000000..1ba00c0ca95f
--- /dev/null
+++ b/tools/testing/selftests/hid/hid-gamepad.sh
@@ -0,0 +1,7 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Runs tests for the HID subsystem
+
+export TARGET=test_gamepad.py
+
+bash ./run-hid-tools-tests.sh
diff --git a/tools/testing/selftests/hid/tests/test_gamepad.py b/tools/testing/selftests/hid/tests/test_gamepad.py
new file mode 100644
index 000000000000..26c74040b796
--- /dev/null
+++ b/tools/testing/selftests/hid/tests/test_gamepad.py
@@ -0,0 +1,209 @@
+#!/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# -*- coding: utf-8 -*-
+#
+# Copyright (c) 2019 Benjamin Tissoires <benjamin.tissoires@gmail.com>
+# Copyright (c) 2019 Red Hat, Inc.
+#
+
+from . import base
+import libevdev
+import pytest
+
+from hidtools.device.base_gamepad import AsusGamepad, SaitekGamepad
+
+import logging
+
+logger = logging.getLogger("hidtools.test.gamepad")
+
+
+class BaseTest:
+    class TestGamepad(base.BaseTestCase.TestUhid):
+        @pytest.fixture(autouse=True)
+        def send_initial_state(self):
+            """send an empty report to initialize the axes"""
+            uhdev = self.uhdev
+
+            r = uhdev.event()
+            events = uhdev.next_sync_events()
+            self.debug_reports(r, uhdev, events)
+
+        def assert_button(self, button):
+            uhdev = self.uhdev
+            evdev = uhdev.get_evdev()
+            syn_event = self.syn_event
+
+            buttons = {}
+            key = libevdev.evbit(uhdev.buttons_map[button])
+
+            buttons[button] = True
+            r = uhdev.event(buttons=buttons)
+            expected_event = libevdev.InputEvent(key, 1)
+            events = uhdev.next_sync_events()
+            self.debug_reports(r, uhdev, events)
+            self.assertInputEventsIn((syn_event, expected_event), events)
+            assert evdev.value[key] == 1
+
+            buttons[button] = False
+            r = uhdev.event(buttons=buttons)
+            expected_event = libevdev.InputEvent(key, 0)
+            events = uhdev.next_sync_events()
+            self.debug_reports(r, uhdev, events)
+            self.assertInputEventsIn((syn_event, expected_event), events)
+            assert evdev.value[key] == 0
+
+        def test_buttons(self):
+            """check for button reliability."""
+            uhdev = self.uhdev
+
+            for b in uhdev.buttons:
+                self.assert_button(b)
+
+        def test_dual_buttons(self):
+            """check for button reliability when pressing 2 buttons"""
+            uhdev = self.uhdev
+            evdev = uhdev.get_evdev()
+            syn_event = self.syn_event
+
+            # can change intended b1 b2 values
+            b1 = uhdev.buttons[0]
+            key1 = libevdev.evbit(uhdev.buttons_map[b1])
+            b2 = uhdev.buttons[1]
+            key2 = libevdev.evbit(uhdev.buttons_map[b2])
+
+            buttons = {b1: True, b2: True}
+            r = uhdev.event(buttons=buttons)
+            expected_event0 = libevdev.InputEvent(key1, 1)
+            expected_event1 = libevdev.InputEvent(key2, 1)
+            events = uhdev.next_sync_events()
+            self.debug_reports(r, uhdev, events)
+            self.assertInputEventsIn(
+                (syn_event, expected_event0, expected_event1), events
+            )
+            assert evdev.value[key1] == 1
+            assert evdev.value[key2] == 1
+
+            buttons = {b1: False, b2: None}
+            r = uhdev.event(buttons=buttons)
+            expected_event = libevdev.InputEvent(key1, 0)
+            events = uhdev.next_sync_events()
+            self.debug_reports(r, uhdev, events)
+            self.assertInputEventsIn((syn_event, expected_event), events)
+            assert evdev.value[key1] == 0
+            assert evdev.value[key2] == 1
+
+            buttons = {b1: None, b2: False}
+            r = uhdev.event(buttons=buttons)
+            expected_event = libevdev.InputEvent(key2, 0)
+            events = uhdev.next_sync_events()
+            self.debug_reports(r, uhdev, events)
+            self.assertInputEventsIn((syn_event, expected_event), events)
+            assert evdev.value[key1] == 0
+            assert evdev.value[key2] == 0
+
+        def _get_libevdev_abs_events(self, which):
+            """Returns which ABS_* evdev axes are expected for the given stick"""
+            abs_map = self.uhdev.axes_map[which]
+
+            x = abs_map["x"].evdev
+            y = abs_map["y"].evdev
+
+            assert x
+            assert y
+
+            return x, y
+
+        def _test_joystick_press(self, which, data):
+            uhdev = self.uhdev
+
+            libevdev_axes = self._get_libevdev_abs_events(which)
+
+            r = None
+            if which == "left_stick":
+                r = uhdev.event(left=data)
+            else:
+                r = uhdev.event(right=data)
+            events = uhdev.next_sync_events()
+            self.debug_reports(r, uhdev, events)
+
+            for i, d in enumerate(data):
+                if d is not None and d != 127:
+                    assert libevdev.InputEvent(libevdev_axes[i], d) in events
+                else:
+                    assert libevdev.InputEvent(libevdev_axes[i]) not in events
+
+        def test_left_joystick_press_left(self):
+            """check for the left joystick reliability"""
+            self._test_joystick_press("left_stick", (63, None))
+            self._test_joystick_press("left_stick", (0, 127))
+
+        def test_left_joystick_press_right(self):
+            """check for the left joystick reliability"""
+            self._test_joystick_press("left_stick", (191, 127))
+            self._test_joystick_press("left_stick", (255, None))
+
+        def test_left_joystick_press_up(self):
+            """check for the left joystick reliability"""
+            self._test_joystick_press("left_stick", (None, 63))
+            self._test_joystick_press("left_stick", (127, 0))
+
+        def test_left_joystick_press_down(self):
+            """check for the left joystick reliability"""
+            self._test_joystick_press("left_stick", (127, 191))
+            self._test_joystick_press("left_stick", (None, 255))
+
+        def test_right_joystick_press_left(self):
+            """check for the right joystick reliability"""
+            self._test_joystick_press("right_stick", (63, None))
+            self._test_joystick_press("right_stick", (0, 127))
+
+        def test_right_joystick_press_right(self):
+            """check for the right joystick reliability"""
+            self._test_joystick_press("right_stick", (191, 127))
+            self._test_joystick_press("right_stick", (255, None))
+
+        def test_right_joystick_press_up(self):
+            """check for the right joystick reliability"""
+            self._test_joystick_press("right_stick", (None, 63))
+            self._test_joystick_press("right_stick", (127, 0))
+
+        def test_right_joystick_press_down(self):
+            """check for the right joystick reliability"""
+            self._test_joystick_press("right_stick", (127, 191))
+            self._test_joystick_press("right_stick", (None, 255))
+
+        @pytest.mark.skip_if_uhdev(
+            lambda uhdev: "Hat switch" not in uhdev.fields,
+            "Device not compatible, missing Hat switch usage",
+        )
+        @pytest.mark.parametrize(
+            "hat_value,expected_evdev,evdev_value",
+            [
+                (0, "ABS_HAT0Y", -1),
+                (2, "ABS_HAT0X", 1),
+                (4, "ABS_HAT0Y", 1),
+                (6, "ABS_HAT0X", -1),
+            ],
+        )
+        def test_hat_switch(self, hat_value, expected_evdev, evdev_value):
+            uhdev = self.uhdev
+
+            r = uhdev.event(hat_switch=hat_value)
+            events = uhdev.next_sync_events()
+            self.debug_reports(r, uhdev, events)
+            assert (
+                libevdev.InputEvent(
+                    libevdev.evbit("EV_ABS", expected_evdev), evdev_value
+                )
+                in events
+            )
+
+
+class TestSaitekGamepad(BaseTest.TestGamepad):
+    def create_device(self):
+        return SaitekGamepad()
+
+
+class TestAsusGamepad(BaseTest.TestGamepad):
+    def create_device(self):
+        return AsusGamepad()

-- 
2.39.1

