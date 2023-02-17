Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7277169B0A0
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Feb 2023 17:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjBQQUi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Feb 2023 11:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjBQQUT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Feb 2023 11:20:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC197291C
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Feb 2023 08:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676650742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5rVpYXrca9+Iqt65tdSPetVuX0vl1nKf85t3g3FCKQw=;
        b=YPryQJGwxRjIbI9hL2yxKLruTOBb4vqR5cXQpjWVMJz0zHWVTlHisaGwICnmPuhSZbTvF5
        czM5oI3M7/waC5JXx2YcFgZ1sYzIqzBDlGNsTudd91TLcg9CaPnuFiOUmRwXnu5Nd6oOfU
        hpFfRFt77/1dHvAPy3Iz6L+fbQWDq1Y=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-bcfot1hVOBCMNrA3rrj2Zw-1; Fri, 17 Feb 2023 11:18:59 -0500
X-MC-Unique: bcfot1hVOBCMNrA3rrj2Zw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D1D201C05AD6;
        Fri, 17 Feb 2023 16:18:58 +0000 (UTC)
Received: from xps-13.local (unknown [10.39.193.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2BE8BC15BAD;
        Fri, 17 Feb 2023 16:18:57 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 17 Feb 2023 17:18:02 +0100
Subject: [PATCH 08/11] selftests: hid: import hid-tools hid-apple tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-import-hid-tools-tests-v1-8-d1c48590d0ee@redhat.com>
References: <20230217-import-hid-tools-tests-v1-0-d1c48590d0ee@redhat.com>
In-Reply-To: <20230217-import-hid-tools-tests-v1-0-d1c48590d0ee@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Roderick Colenbrander <roderick.colenbrander@sony.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676650715; l=22118;
 i=benjamin.tissoires@redhat.com; s=20230215; h=from:subject:message-id;
 bh=5ZVcKqFaYfb3/FDPoi1Mg/fv8p5nkBwksf68dW3d4Ek=;
 b=WW9mqLRSg4J6HCZkfDLHcEK+VH+QIttfqvwRTKkVYpOOBT4zb0zDr0m+hX0FN12WylcEq2hmQ
 3d0DtMfh3W4CmJWOjzId27WNzZ8IiarkeJLczryhdJYo8kgBb3MDZWh
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

Cc: Roderick Colenbrander <roderick.colenbrander@sony.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 tools/testing/selftests/hid/Makefile               |   1 +
 tools/testing/selftests/hid/config                 |   1 +
 tools/testing/selftests/hid/hid-apple.sh           |   7 +
 .../selftests/hid/tests/test_apple_keyboard.py     | 440 +++++++++++++++++++++
 4 files changed, 449 insertions(+)

diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
index 4f11e865bbb3..ce03c65bfba0 100644
--- a/tools/testing/selftests/hid/Makefile
+++ b/tools/testing/selftests/hid/Makefile
@@ -6,6 +6,7 @@ include ../../../scripts/Makefile.arch
 include ../../../scripts/Makefile.include
 
 TEST_PROGS := hid-core.sh
+TEST_PROGS += hid-apple.sh
 TEST_PROGS += hid-gamepad.sh
 TEST_PROGS += hid-keyboard.sh
 TEST_PROGS += hid-mouse.sh
diff --git a/tools/testing/selftests/hid/config b/tools/testing/selftests/hid/config
index 266fbd84ae9c..52b527cc2260 100644
--- a/tools/testing/selftests/hid/config
+++ b/tools/testing/selftests/hid/config
@@ -21,5 +21,6 @@ CONFIG_INPUT_EVDEV=y
 CONFIG_UHID=y
 CONFIG_USB=y
 CONFIG_USB_HID=y
+CONFIG_HID_APPLE=y
 CONFIG_HID_MULTITOUCH=y
 CONFIG_HID_WACOM=y
diff --git a/tools/testing/selftests/hid/hid-apple.sh b/tools/testing/selftests/hid/hid-apple.sh
new file mode 100755
index 000000000000..656f2d5ae5a9
--- /dev/null
+++ b/tools/testing/selftests/hid/hid-apple.sh
@@ -0,0 +1,7 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Runs tests for the HID subsystem
+
+export TARGET=test_apple_keyboard.py
+
+bash ./run-hid-tools-tests.sh
diff --git a/tools/testing/selftests/hid/tests/test_apple_keyboard.py b/tools/testing/selftests/hid/tests/test_apple_keyboard.py
new file mode 100644
index 000000000000..f81071d46166
--- /dev/null
+++ b/tools/testing/selftests/hid/tests/test_apple_keyboard.py
@@ -0,0 +1,440 @@
+#!/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# -*- coding: utf-8 -*-
+#
+# Copyright (c) 2019 Benjamin Tissoires <benjamin.tissoires@gmail.com>
+# Copyright (c) 2019 Red Hat, Inc.
+#
+
+from .test_keyboard import ArrayKeyboard, TestArrayKeyboard
+from hidtools.util import BusType
+
+import libevdev
+import logging
+
+logger = logging.getLogger("hidtools.test.apple-keyboard")
+
+KERNEL_MODULE = ("apple", "hid-apple")
+
+
+class KbdData(object):
+    pass
+
+
+class AppleKeyboard(ArrayKeyboard):
+    # fmt: off
+    report_descriptor = [
+        0x05, 0x01,         # Usage Page (Generic Desktop)
+        0x09, 0x06,         # Usage (Keyboard)
+        0xa1, 0x01,         # Collection (Application)
+        0x85, 0x01,         # .Report ID (1)
+        0x05, 0x07,         # .Usage Page (Keyboard)
+        0x19, 0xe0,         # .Usage Minimum (224)
+        0x29, 0xe7,         # .Usage Maximum (231)
+        0x15, 0x00,         # .Logical Minimum (0)
+        0x25, 0x01,         # .Logical Maximum (1)
+        0x75, 0x01,         # .Report Size (1)
+        0x95, 0x08,         # .Report Count (8)
+        0x81, 0x02,         # .Input (Data,Var,Abs)
+        0x75, 0x08,         # .Report Size (8)
+        0x95, 0x01,         # .Report Count (1)
+        0x81, 0x01,         # .Input (Cnst,Arr,Abs)
+        0x75, 0x01,         # .Report Size (1)
+        0x95, 0x05,         # .Report Count (5)
+        0x05, 0x08,         # .Usage Page (LEDs)
+        0x19, 0x01,         # .Usage Minimum (1)
+        0x29, 0x05,         # .Usage Maximum (5)
+        0x91, 0x02,         # .Output (Data,Var,Abs)
+        0x75, 0x03,         # .Report Size (3)
+        0x95, 0x01,         # .Report Count (1)
+        0x91, 0x01,         # .Output (Cnst,Arr,Abs)
+        0x75, 0x08,         # .Report Size (8)
+        0x95, 0x06,         # .Report Count (6)
+        0x15, 0x00,         # .Logical Minimum (0)
+        0x26, 0xff, 0x00,   # .Logical Maximum (255)
+        0x05, 0x07,         # .Usage Page (Keyboard)
+        0x19, 0x00,         # .Usage Minimum (0)
+        0x2a, 0xff, 0x00,   # .Usage Maximum (255)
+        0x81, 0x00,         # .Input (Data,Arr,Abs)
+        0xc0,               # End Collection
+        0x05, 0x0c,         # Usage Page (Consumer Devices)
+        0x09, 0x01,         # Usage (Consumer Control)
+        0xa1, 0x01,         # Collection (Application)
+        0x85, 0x47,         # .Report ID (71)
+        0x05, 0x01,         # .Usage Page (Generic Desktop)
+        0x09, 0x06,         # .Usage (Keyboard)
+        0xa1, 0x02,         # .Collection (Logical)
+        0x05, 0x06,         # ..Usage Page (Generic Device Controls)
+        0x09, 0x20,         # ..Usage (Battery Strength)
+        0x15, 0x00,         # ..Logical Minimum (0)
+        0x26, 0xff, 0x00,   # ..Logical Maximum (255)
+        0x75, 0x08,         # ..Report Size (8)
+        0x95, 0x01,         # ..Report Count (1)
+        0x81, 0x02,         # ..Input (Data,Var,Abs)
+        0xc0,               # .End Collection
+        0xc0,               # End Collection
+        0x05, 0x0c,         # Usage Page (Consumer Devices)
+        0x09, 0x01,         # Usage (Consumer Control)
+        0xa1, 0x01,         # Collection (Application)
+        0x85, 0x11,         # .Report ID (17)
+        0x15, 0x00,         # .Logical Minimum (0)
+        0x25, 0x01,         # .Logical Maximum (1)
+        0x75, 0x01,         # .Report Size (1)
+        0x95, 0x03,         # .Report Count (3)
+        0x81, 0x01,         # .Input (Cnst,Arr,Abs)
+        0x75, 0x01,         # .Report Size (1)
+        0x95, 0x01,         # .Report Count (1)
+        0x05, 0x0c,         # .Usage Page (Consumer Devices)
+        0x09, 0xb8,         # .Usage (Eject)
+        0x81, 0x02,         # .Input (Data,Var,Abs)
+        0x06, 0xff, 0x00,   # .Usage Page (Vendor Usage Page 0xff)
+        0x09, 0x03,         # .Usage (Vendor Usage 0x03)
+        0x81, 0x02,         # .Input (Data,Var,Abs)
+        0x75, 0x01,         # .Report Size (1)
+        0x95, 0x03,         # .Report Count (3)
+        0x81, 0x01,         # .Input (Cnst,Arr,Abs)
+        0x05, 0x0c,         # .Usage Page (Consumer Devices)
+        0x85, 0x12,         # .Report ID (18)
+        0x15, 0x00,         # .Logical Minimum (0)
+        0x25, 0x01,         # .Logical Maximum (1)
+        0x75, 0x01,         # .Report Size (1)
+        0x95, 0x01,         # .Report Count (1)
+        0x09, 0xcd,         # .Usage (Play/Pause)
+        0x81, 0x02,         # .Input (Data,Var,Abs)
+        0x09, 0xb3,         # .Usage (Fast Forward)
+        0x81, 0x02,         # .Input (Data,Var,Abs)
+        0x09, 0xb4,         # .Usage (Rewind)
+        0x81, 0x02,         # .Input (Data,Var,Abs)
+        0x09, 0xb5,         # .Usage (Scan Next Track)
+        0x81, 0x02,         # .Input (Data,Var,Abs)
+        0x09, 0xb6,         # .Usage (Scan Previous Track)
+        0x81, 0x02,         # .Input (Data,Var,Abs)
+        0x81, 0x01,         # .Input (Cnst,Arr,Abs)
+        0x81, 0x01,         # .Input (Cnst,Arr,Abs)
+        0x81, 0x01,         # .Input (Cnst,Arr,Abs)
+        0x85, 0x13,         # .Report ID (19)
+        0x15, 0x00,         # .Logical Minimum (0)
+        0x25, 0x01,         # .Logical Maximum (1)
+        0x75, 0x01,         # .Report Size (1)
+        0x95, 0x01,         # .Report Count (1)
+        0x06, 0x01, 0xff,   # .Usage Page (Vendor Usage Page 0xff01)
+        0x09, 0x0a,         # .Usage (Vendor Usage 0x0a)
+        0x81, 0x02,         # .Input (Data,Var,Abs)
+        0x06, 0x01, 0xff,   # .Usage Page (Vendor Usage Page 0xff01)
+        0x09, 0x0c,         # .Usage (Vendor Usage 0x0c)
+        0x81, 0x22,         # .Input (Data,Var,Abs,NoPref)
+        0x75, 0x01,         # .Report Size (1)
+        0x95, 0x06,         # .Report Count (6)
+        0x81, 0x01,         # .Input (Cnst,Arr,Abs)
+        0x85, 0x09,         # .Report ID (9)
+        0x09, 0x0b,         # .Usage (Vendor Usage 0x0b)
+        0x75, 0x08,         # .Report Size (8)
+        0x95, 0x01,         # .Report Count (1)
+        0xb1, 0x02,         # .Feature (Data,Var,Abs)
+        0x75, 0x08,         # .Report Size (8)
+        0x95, 0x02,         # .Report Count (2)
+        0xb1, 0x01,         # .Feature (Cnst,Arr,Abs)
+        0xc0,               # End Collection
+    ]
+    # fmt: on
+
+    def __init__(
+        self,
+        rdesc=report_descriptor,
+        name="Apple Wireless Keyboard",
+        input_info=(BusType.BLUETOOTH, 0x05AC, 0x0256),
+    ):
+        super().__init__(rdesc, name, input_info)
+        self.default_reportID = 1
+
+    def send_fn_state(self, state):
+        data = KbdData()
+        setattr(data, "0xff0003", state)
+        r = self.create_report(data, reportID=17)
+        self.call_input_event(r)
+        return [r]
+
+
+class TestAppleKeyboard(TestArrayKeyboard):
+    kernel_modules = [KERNEL_MODULE]
+
+    def create_device(self):
+        return AppleKeyboard()
+
+    def test_single_function_key(self):
+        """check for function key reliability."""
+        uhdev = self.uhdev
+        evdev = uhdev.get_evdev()
+        syn_event = self.syn_event
+
+        r = uhdev.event(["F4"])
+        expected = [syn_event]
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_ALL_APPLICATIONS, 1))
+        events = uhdev.next_sync_events()
+        self.debug_reports(r, uhdev, events)
+        self.assertInputEventsIn(expected, events)
+        assert evdev.value[libevdev.EV_KEY.KEY_ALL_APPLICATIONS] == 1
+        assert evdev.value[libevdev.EV_KEY.KEY_FN] == 0
+
+        r = uhdev.event([])
+        expected = [syn_event]
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_ALL_APPLICATIONS, 0))
+        events = uhdev.next_sync_events()
+        self.debug_reports(r, uhdev, events)
+        self.assertInputEventsIn(expected, events)
+        assert evdev.value[libevdev.EV_KEY.KEY_ALL_APPLICATIONS] == 0
+
+    def test_single_fn_function_key(self):
+        """check for function key reliability with the fn key."""
+        uhdev = self.uhdev
+        evdev = uhdev.get_evdev()
+        syn_event = self.syn_event
+
+        r = uhdev.send_fn_state(1)
+        r.extend(uhdev.event(["F4"]))
+        expected = [syn_event]
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_F4, 1))
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_FN, 1))
+        events = uhdev.next_sync_events()
+        self.debug_reports(r, uhdev, events)
+        self.assertInputEventsIn(expected, events)
+        assert evdev.value[libevdev.EV_KEY.KEY_F4] == 1
+
+        r = uhdev.event([])
+        expected = [syn_event]
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_F4, 0))
+        events = uhdev.next_sync_events()
+        self.debug_reports(r, uhdev, events)
+        self.assertInputEventsIn(expected, events)
+        assert evdev.value[libevdev.EV_KEY.KEY_F4] == 0
+        assert evdev.value[libevdev.EV_KEY.KEY_FN] == 1
+
+        r = uhdev.send_fn_state(0)
+        expected = [syn_event]
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_FN, 0))
+        events = uhdev.next_sync_events()
+        self.debug_reports(r, uhdev, events)
+        self.assertInputEventsIn(expected, events)
+
+    def test_single_fn_function_key_release_first(self):
+        """check for function key reliability with the fn key."""
+        uhdev = self.uhdev
+        evdev = uhdev.get_evdev()
+        syn_event = self.syn_event
+
+        r = uhdev.send_fn_state(1)
+        r.extend(uhdev.event(["F4"]))
+        expected = [syn_event]
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_F4, 1))
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_FN, 1))
+        events = uhdev.next_sync_events()
+        self.debug_reports(r, uhdev, events)
+        self.assertInputEventsIn(expected, events)
+        assert evdev.value[libevdev.EV_KEY.KEY_F4] == 1
+
+        r = uhdev.send_fn_state(0)
+        expected = [syn_event]
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_FN, 0))
+        events = uhdev.next_sync_events()
+        self.debug_reports(r, uhdev, events)
+        self.assertInputEventsIn(expected, events)
+
+        r = uhdev.event([])
+        expected = [syn_event]
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_F4, 0))
+        events = uhdev.next_sync_events()
+        self.debug_reports(r, uhdev, events)
+        self.assertInputEventsIn(expected, events)
+        assert evdev.value[libevdev.EV_KEY.KEY_F4] == 0
+
+    def test_single_fn_function_key_inverted(self):
+        """check for function key reliability with the fn key."""
+        uhdev = self.uhdev
+        evdev = uhdev.get_evdev()
+        syn_event = self.syn_event
+
+        r = uhdev.event(["F4"])
+        r.extend(uhdev.send_fn_state(1))
+        expected = [syn_event]
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_ALL_APPLICATIONS, 1))
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_FN, 1))
+        events = uhdev.next_sync_events()
+        self.debug_reports(r, uhdev, events)
+        self.assertInputEventsIn(expected, events)
+        assert evdev.value[libevdev.EV_KEY.KEY_ALL_APPLICATIONS] == 1
+
+        r = uhdev.event([])
+        expected = [syn_event]
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_ALL_APPLICATIONS, 0))
+        events = uhdev.next_sync_events()
+        self.debug_reports(r, uhdev, events)
+        self.assertInputEventsIn(expected, events)
+        assert evdev.value[libevdev.EV_KEY.KEY_ALL_APPLICATIONS] == 0
+        assert evdev.value[libevdev.EV_KEY.KEY_FN] == 1
+
+        r = uhdev.send_fn_state(0)
+        expected = [syn_event]
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_FN, 0))
+        events = uhdev.next_sync_events()
+        self.debug_reports(r, uhdev, events)
+        self.assertInputEventsIn(expected, events)
+
+    def test_multiple_fn_function_key_release_first(self):
+        """check for function key reliability with the fn key."""
+        uhdev = self.uhdev
+        evdev = uhdev.get_evdev()
+        syn_event = self.syn_event
+
+        r = uhdev.send_fn_state(1)
+        r.extend(uhdev.event(["F4"]))
+        r.extend(uhdev.event(["F4", "F6"]))
+        expected = [syn_event]
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_F4, 1))
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_F6, 1))
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_FN, 1))
+        events = uhdev.next_sync_events()
+        self.debug_reports(r, uhdev, events)
+        self.assertInputEventsIn(expected, events)
+        assert evdev.value[libevdev.EV_KEY.KEY_F4] == 1
+        assert evdev.value[libevdev.EV_KEY.KEY_F6] == 1
+        assert evdev.value[libevdev.EV_KEY.KEY_FN] == 1
+
+        r = uhdev.event(["F6"])
+        expected = [syn_event]
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_F4, 0))
+        events = uhdev.next_sync_events()
+        self.debug_reports(r, uhdev, events)
+        self.assertInputEventsIn(expected, events)
+        assert evdev.value[libevdev.EV_KEY.KEY_F4] == 0
+        assert evdev.value[libevdev.EV_KEY.KEY_F6] == 1
+        assert evdev.value[libevdev.EV_KEY.KEY_FN] == 1
+
+        r = uhdev.send_fn_state(0)
+        expected = [syn_event]
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_FN, 0))
+        events = uhdev.next_sync_events()
+        self.debug_reports(r, uhdev, events)
+        self.assertInputEventsIn(expected, events)
+        assert evdev.value[libevdev.EV_KEY.KEY_F4] == 0
+        assert evdev.value[libevdev.EV_KEY.KEY_F6] == 1
+        assert evdev.value[libevdev.EV_KEY.KEY_FN] == 0
+
+        r = uhdev.event([])
+        expected = [syn_event]
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_F6, 0))
+        events = uhdev.next_sync_events()
+        self.debug_reports(r, uhdev, events)
+        self.assertInputEventsIn(expected, events)
+        assert evdev.value[libevdev.EV_KEY.KEY_F4] == 0
+        assert evdev.value[libevdev.EV_KEY.KEY_F6] == 0
+        assert evdev.value[libevdev.EV_KEY.KEY_FN] == 0
+
+    def test_multiple_fn_function_key_release_between(self):
+        """check for function key reliability with the fn key."""
+        uhdev = self.uhdev
+        evdev = uhdev.get_evdev()
+        syn_event = self.syn_event
+
+        # press F4
+        r = uhdev.event(["F4"])
+        expected = [syn_event]
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_ALL_APPLICATIONS, 1))
+        events = uhdev.next_sync_events()
+        self.debug_reports(r, uhdev, events)
+        self.assertInputEventsIn(expected, events)
+        assert evdev.value[libevdev.EV_KEY.KEY_F4] == 0
+        assert evdev.value[libevdev.EV_KEY.KEY_ALL_APPLICATIONS] == 1
+        assert evdev.value[libevdev.EV_KEY.KEY_F6] == 0
+        assert evdev.value[libevdev.EV_KEY.KEY_KBDILLUMUP] == 0
+        assert evdev.value[libevdev.EV_KEY.KEY_FN] == 0
+
+        # press Fn key
+        r = uhdev.send_fn_state(1)
+        expected = [syn_event]
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_FN, 1))
+        events = uhdev.next_sync_events()
+        self.debug_reports(r, uhdev, events)
+        self.assertInputEventsIn(expected, events)
+        assert evdev.value[libevdev.EV_KEY.KEY_F4] == 0
+        assert evdev.value[libevdev.EV_KEY.KEY_ALL_APPLICATIONS] == 1
+        assert evdev.value[libevdev.EV_KEY.KEY_F6] == 0
+        assert evdev.value[libevdev.EV_KEY.KEY_KBDILLUMUP] == 0
+        assert evdev.value[libevdev.EV_KEY.KEY_FN] == 1
+
+        # keep F4 and press F6
+        r = uhdev.event(["F4", "F6"])
+        expected = [syn_event]
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_F6, 1))
+        events = uhdev.next_sync_events()
+        self.debug_reports(r, uhdev, events)
+        self.assertInputEventsIn(expected, events)
+        assert evdev.value[libevdev.EV_KEY.KEY_F4] == 0
+        assert evdev.value[libevdev.EV_KEY.KEY_ALL_APPLICATIONS] == 1
+        assert evdev.value[libevdev.EV_KEY.KEY_F6] == 1
+        assert evdev.value[libevdev.EV_KEY.KEY_KBDILLUMUP] == 0
+        assert evdev.value[libevdev.EV_KEY.KEY_FN] == 1
+
+        # keep F4 and F6
+        r = uhdev.event(["F4", "F6"])
+        expected = []
+        events = uhdev.next_sync_events()
+        self.debug_reports(r, uhdev, events)
+        self.assertInputEventsIn(expected, events)
+        assert evdev.value[libevdev.EV_KEY.KEY_F4] == 0
+        assert evdev.value[libevdev.EV_KEY.KEY_ALL_APPLICATIONS] == 1
+        assert evdev.value[libevdev.EV_KEY.KEY_F6] == 1
+        assert evdev.value[libevdev.EV_KEY.KEY_KBDILLUMUP] == 0
+        assert evdev.value[libevdev.EV_KEY.KEY_FN] == 1
+
+        # release Fn key and all keys
+        r = uhdev.send_fn_state(0)
+        r.extend(uhdev.event([]))
+        expected = [syn_event]
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_ALL_APPLICATIONS, 0))
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_F6, 0))
+        events = uhdev.next_sync_events()
+        self.debug_reports(r, uhdev, events)
+        self.assertInputEventsIn(expected, events)
+        assert evdev.value[libevdev.EV_KEY.KEY_F4] == 0
+        assert evdev.value[libevdev.EV_KEY.KEY_ALL_APPLICATIONS] == 0
+        assert evdev.value[libevdev.EV_KEY.KEY_F6] == 0
+        assert evdev.value[libevdev.EV_KEY.KEY_KBDILLUMUP] == 0
+        assert evdev.value[libevdev.EV_KEY.KEY_FN] == 0
+
+    def test_single_pageup_key_release_first(self):
+        """check for function key reliability with the [page] up key."""
+        uhdev = self.uhdev
+        evdev = uhdev.get_evdev()
+        syn_event = self.syn_event
+
+        r = uhdev.send_fn_state(1)
+        r.extend(uhdev.event(["UpArrow"]))
+        expected = [syn_event]
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_PAGEUP, 1))
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_FN, 1))
+        events = uhdev.next_sync_events()
+        self.debug_reports(r, uhdev, events)
+        self.assertInputEventsIn(expected, events)
+        assert evdev.value[libevdev.EV_KEY.KEY_PAGEUP] == 1
+        assert evdev.value[libevdev.EV_KEY.KEY_UP] == 0
+        assert evdev.value[libevdev.EV_KEY.KEY_FN] == 1
+
+        r = uhdev.send_fn_state(0)
+        expected = [syn_event]
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_FN, 0))
+        events = uhdev.next_sync_events()
+        self.debug_reports(r, uhdev, events)
+        self.assertInputEventsIn(expected, events)
+        assert evdev.value[libevdev.EV_KEY.KEY_PAGEUP] == 1
+        assert evdev.value[libevdev.EV_KEY.KEY_UP] == 0
+        assert evdev.value[libevdev.EV_KEY.KEY_FN] == 0
+
+        r = uhdev.event([])
+        expected = [syn_event]
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_PAGEUP, 0))
+        events = uhdev.next_sync_events()
+        self.debug_reports(r, uhdev, events)
+        self.assertInputEventsIn(expected, events)
+        assert evdev.value[libevdev.EV_KEY.KEY_PAGEUP] == 0
+        assert evdev.value[libevdev.EV_KEY.KEY_UP] == 0
+        assert evdev.value[libevdev.EV_KEY.KEY_FN] == 0

-- 
2.39.1

