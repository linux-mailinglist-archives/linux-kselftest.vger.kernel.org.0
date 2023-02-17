Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D9F69B09E
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Feb 2023 17:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjBQQUW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Feb 2023 11:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjBQQUS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Feb 2023 11:20:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8398E14993
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Feb 2023 08:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676650730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MMnn0z4iV4PJ/axzkiucRlAm/k7ZZcvfPJCs1gXrpHQ=;
        b=Xzzlx0lexSXlHCl8bceH5IzBi58YWSCu1pDbdSV1BotNQJuagGSkjjBWrNzFOnk3pmxjXG
        XcOzm5Kq2Pbbmq3CPtqiwtXZVYEv5925NQTSlrHjTuOu/Q3T34DJYcxZVRlMwp4oxW1yv9
        MHLVCTSs0kas90fGoAsOjJqxvH5Yw5k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-468-SEijkpmEPBKIXmMe_8uLOQ-1; Fri, 17 Feb 2023 11:18:48 -0500
X-MC-Unique: SEijkpmEPBKIXmMe_8uLOQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BED57101B42B;
        Fri, 17 Feb 2023 16:18:47 +0000 (UTC)
Received: from xps-13.local (unknown [10.39.193.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 41AE4C15BA0;
        Fri, 17 Feb 2023 16:18:46 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 17 Feb 2023 17:17:58 +0100
Subject: [PATCH 04/11] selftests: hid: import hid-tools hid-keyboards tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-import-hid-tools-tests-v1-4-d1c48590d0ee@redhat.com>
References: <20230217-import-hid-tools-tests-v1-0-d1c48590d0ee@redhat.com>
In-Reply-To: <20230217-import-hid-tools-tests-v1-0-d1c48590d0ee@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Roderick Colenbrander <roderick.colenbrander@sony.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676650715; l=22934;
 i=benjamin.tissoires@redhat.com; s=20230215; h=from:subject:message-id;
 bh=KK0MRAuOIROX7h7CQ9r1zTW58y1MCSjT9UIs2lXhrSA=;
 b=TVrsHjtNufCb2nH8HJ/tp2S+aor6TkZvtTks2mY7hamMf61BoYyfr+JuU17B7QIM1KoCX2pJ0
 PwfzALIs66xAatBUYjGSvzAv43wjh/l+6vujP2of5np/7LYGG40tNdl
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

Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Roderick Colenbrander <roderick.colenbrander@sony.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 tools/testing/selftests/hid/Makefile               |   1 +
 tools/testing/selftests/hid/hid-keyboard.sh        |   7 +
 tools/testing/selftests/hid/tests/test_keyboard.py | 485 +++++++++++++++++++++
 3 files changed, 493 insertions(+)

diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
index d16a22477140..181a594ffe92 100644
--- a/tools/testing/selftests/hid/Makefile
+++ b/tools/testing/selftests/hid/Makefile
@@ -7,6 +7,7 @@ include ../../../scripts/Makefile.include
 
 TEST_PROGS := hid-core.sh
 TEST_PROGS += hid-gamepad.sh
+TEST_PROGS += hid-keyboard.sh
 
 CXX ?= $(CROSS_COMPILE)g++
 
diff --git a/tools/testing/selftests/hid/hid-keyboard.sh b/tools/testing/selftests/hid/hid-keyboard.sh
new file mode 100755
index 000000000000..55368f17d1d5
--- /dev/null
+++ b/tools/testing/selftests/hid/hid-keyboard.sh
@@ -0,0 +1,7 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Runs tests for the HID subsystem
+
+export TARGET=test_keyboard.py
+
+bash ./run-hid-tools-tests.sh
diff --git a/tools/testing/selftests/hid/tests/test_keyboard.py b/tools/testing/selftests/hid/tests/test_keyboard.py
new file mode 100644
index 000000000000..b3b2bdbf63b7
--- /dev/null
+++ b/tools/testing/selftests/hid/tests/test_keyboard.py
@@ -0,0 +1,485 @@
+#!/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# -*- coding: utf-8 -*-
+#
+# Copyright (c) 2018 Benjamin Tissoires <benjamin.tissoires@gmail.com>
+# Copyright (c) 2018 Red Hat, Inc.
+#
+
+from . import base
+import hidtools.hid
+import libevdev
+import logging
+
+logger = logging.getLogger("hidtools.test.keyboard")
+
+
+class InvalidHIDCommunication(Exception):
+    pass
+
+
+class KeyboardData(object):
+    pass
+
+
+class BaseKeyboard(base.UHIDTestDevice):
+    def __init__(self, rdesc, name=None, input_info=None):
+        assert rdesc is not None
+        super().__init__(name, "Key", input_info=input_info, rdesc=rdesc)
+        self.keystates = {}
+
+    def _update_key_state(self, keys):
+        """
+        Update the internal state of keys with the new state given.
+
+        :param key: a tuple of chars for the currently pressed keys.
+        """
+        # First remove the already released keys
+        unused_keys = [k for k, v in self.keystates.items() if not v]
+        for key in unused_keys:
+            del self.keystates[key]
+
+        # self.keystates contains now the list of currently pressed keys,
+        # release them...
+        for key in self.keystates.keys():
+            self.keystates[key] = False
+
+        # ...and press those that are in parameter
+        for key in keys:
+            self.keystates[key] = True
+
+    def _create_report_data(self):
+        keyboard = KeyboardData()
+        for key, value in self.keystates.items():
+            key = key.replace(" ", "").lower()
+            setattr(keyboard, key, value)
+        return keyboard
+
+    def create_array_report(self, keys, reportID=None, application=None):
+        """
+        Return an input report for this device.
+
+        :param keys: a tuple of chars for the pressed keys. The class maintains
+            the list of currently pressed keys, so to release a key, the caller
+            needs to call again this function without the key in this tuple.
+        :param reportID: the numeric report ID for this report, if needed
+        """
+        self._update_key_state(keys)
+        reportID = reportID or self.default_reportID
+
+        keyboard = self._create_report_data()
+        return self.create_report(keyboard, reportID=reportID, application=application)
+
+    def event(self, keys, reportID=None, application=None):
+        """
+        Send an input event on the default report ID.
+
+        :param keys: a tuple of chars for the pressed keys. The class maintains
+            the list of currently pressed keys, so to release a key, the caller
+            needs to call again this function without the key in this tuple.
+        """
+        r = self.create_array_report(keys, reportID, application)
+        self.call_input_event(r)
+        return [r]
+
+
+class PlainKeyboard(BaseKeyboard):
+    # fmt: off
+    report_descriptor = [
+        0x05, 0x01,                    # Usage Page (Generic Desktop)
+        0x09, 0x06,                    # Usage (Keyboard)
+        0xa1, 0x01,                    # Collection (Application)
+        0x85, 0x01,                    # .Report ID (1)
+        0x05, 0x07,                    # .Usage Page (Keyboard)
+        0x19, 0xe0,                    # .Usage Minimum (224)
+        0x29, 0xe7,                    # .Usage Maximum (231)
+        0x15, 0x00,                    # .Logical Minimum (0)
+        0x25, 0x01,                    # .Logical Maximum (1)
+        0x75, 0x01,                    # .Report Size (1)
+        0x95, 0x08,                    # .Report Count (8)
+        0x81, 0x02,                    # .Input (Data,Var,Abs)
+        0x19, 0x00,                    # .Usage Minimum (0)
+        0x29, 0x97,                    # .Usage Maximum (151)
+        0x15, 0x00,                    # .Logical Minimum (0)
+        0x25, 0x01,                    # .Logical Maximum (1)
+        0x75, 0x01,                    # .Report Size (1)
+        0x95, 0x98,                    # .Report Count (152)
+        0x81, 0x02,                    # .Input (Data,Var,Abs)
+        0xc0,                          # End Collection
+    ]
+    # fmt: on
+
+    def __init__(self, rdesc=report_descriptor, name=None, input_info=None):
+        super().__init__(rdesc, name, input_info)
+        self.default_reportID = 1
+
+
+class ArrayKeyboard(BaseKeyboard):
+    # fmt: off
+    report_descriptor = [
+        0x05, 0x01,                    # Usage Page (Generic Desktop)
+        0x09, 0x06,                    # Usage (Keyboard)
+        0xa1, 0x01,                    # Collection (Application)
+        0x05, 0x07,                    # .Usage Page (Keyboard)
+        0x19, 0xe0,                    # .Usage Minimum (224)
+        0x29, 0xe7,                    # .Usage Maximum (231)
+        0x15, 0x00,                    # .Logical Minimum (0)
+        0x25, 0x01,                    # .Logical Maximum (1)
+        0x75, 0x01,                    # .Report Size (1)
+        0x95, 0x08,                    # .Report Count (8)
+        0x81, 0x02,                    # .Input (Data,Var,Abs)
+        0x95, 0x06,                    # .Report Count (6)
+        0x75, 0x08,                    # .Report Size (8)
+        0x15, 0x00,                    # .Logical Minimum (0)
+        0x26, 0xa4, 0x00,              # .Logical Maximum (164)
+        0x05, 0x07,                    # .Usage Page (Keyboard)
+        0x19, 0x00,                    # .Usage Minimum (0)
+        0x29, 0xa4,                    # .Usage Maximum (164)
+        0x81, 0x00,                    # .Input (Data,Arr,Abs)
+        0xc0,                          # End Collection
+    ]
+    # fmt: on
+
+    def __init__(self, rdesc=report_descriptor, name=None, input_info=None):
+        super().__init__(rdesc, name, input_info)
+
+    def _create_report_data(self):
+        data = KeyboardData()
+        array = []
+
+        hut = hidtools.hut.HUT
+
+        # strip modifiers from the array
+        for k, v in self.keystates.items():
+            # we ignore depressed keys
+            if not v:
+                continue
+
+            usage = hut[0x07].from_name[k].usage
+            if usage >= 224 and usage <= 231:
+                # modifier
+                setattr(data, k.lower(), 1)
+            else:
+                array.append(k)
+
+        # if array length is bigger than 6, report ErrorRollOver
+        if len(array) > 6:
+            array = ["ErrorRollOver"] * 6
+
+        data.keyboard = array
+        return data
+
+
+class LEDKeyboard(ArrayKeyboard):
+    # fmt: off
+    report_descriptor = [
+        0x05, 0x01,                    # Usage Page (Generic Desktop)
+        0x09, 0x06,                    # Usage (Keyboard)
+        0xa1, 0x01,                    # Collection (Application)
+        0x05, 0x07,                    # .Usage Page (Keyboard)
+        0x19, 0xe0,                    # .Usage Minimum (224)
+        0x29, 0xe7,                    # .Usage Maximum (231)
+        0x15, 0x00,                    # .Logical Minimum (0)
+        0x25, 0x01,                    # .Logical Maximum (1)
+        0x75, 0x01,                    # .Report Size (1)
+        0x95, 0x08,                    # .Report Count (8)
+        0x81, 0x02,                    # .Input (Data,Var,Abs)
+        0x95, 0x01,                    # .Report Count (1)
+        0x75, 0x08,                    # .Report Size (8)
+        0x81, 0x01,                    # .Input (Cnst,Arr,Abs)
+        0x95, 0x05,                    # .Report Count (5)
+        0x75, 0x01,                    # .Report Size (1)
+        0x05, 0x08,                    # .Usage Page (LEDs)
+        0x19, 0x01,                    # .Usage Minimum (1)
+        0x29, 0x05,                    # .Usage Maximum (5)
+        0x91, 0x02,                    # .Output (Data,Var,Abs)
+        0x95, 0x01,                    # .Report Count (1)
+        0x75, 0x03,                    # .Report Size (3)
+        0x91, 0x01,                    # .Output (Cnst,Arr,Abs)
+        0x95, 0x06,                    # .Report Count (6)
+        0x75, 0x08,                    # .Report Size (8)
+        0x15, 0x00,                    # .Logical Minimum (0)
+        0x26, 0xa4, 0x00,              # .Logical Maximum (164)
+        0x05, 0x07,                    # .Usage Page (Keyboard)
+        0x19, 0x00,                    # .Usage Minimum (0)
+        0x29, 0xa4,                    # .Usage Maximum (164)
+        0x81, 0x00,                    # .Input (Data,Arr,Abs)
+        0xc0,                          # End Collection
+    ]
+    # fmt: on
+
+    def __init__(self, rdesc=report_descriptor, name=None, input_info=None):
+        super().__init__(rdesc, name, input_info)
+
+
+# Some Primax manufactured keyboards set the Usage Page after having defined
+# some local Usages. It relies on the fact that the specification states that
+# Usages are to be concatenated with Usage Pages upon finding a Main item (see
+# 6.2.2.8). This test covers this case.
+class PrimaxKeyboard(ArrayKeyboard):
+    # fmt: off
+    report_descriptor = [
+        0x05, 0x01,                    # Usage Page (Generic Desktop)
+        0x09, 0x06,                    # Usage (Keyboard)
+        0xA1, 0x01,                    # Collection (Application)
+        0x05, 0x07,                    # .Usage Page (Keyboard)
+        0x19, 0xE0,                    # .Usage Minimum (224)
+        0x29, 0xE7,                    # .Usage Maximum (231)
+        0x15, 0x00,                    # .Logical Minimum (0)
+        0x25, 0x01,                    # .Logical Maximum (1)
+        0x75, 0x01,                    # .Report Size (1)
+        0x95, 0x08,                    # .Report Count (8)
+        0x81, 0x02,                    # .Input (Data,Var,Abs)
+        0x75, 0x08,                    # .Report Size (8)
+        0x95, 0x01,                    # .Report Count (1)
+        0x81, 0x01,                    # .Input (Data,Var,Abs)
+        0x05, 0x08,                    # .Usage Page (LEDs)
+        0x19, 0x01,                    # .Usage Minimum (1)
+        0x29, 0x03,                    # .Usage Maximum (3)
+        0x75, 0x01,                    # .Report Size (1)
+        0x95, 0x03,                    # .Report Count (3)
+        0x91, 0x02,                    # .Output (Data,Var,Abs)
+        0x95, 0x01,                    # .Report Count (1)
+        0x75, 0x05,                    # .Report Size (5)
+        0x91, 0x01,                    # .Output (Constant)
+        0x15, 0x00,                    # .Logical Minimum (0)
+        0x26, 0xFF, 0x00,              # .Logical Maximum (255)
+        0x19, 0x00,                    # .Usage Minimum (0)
+        0x2A, 0xFF, 0x00,              # .Usage Maximum (255)
+        0x05, 0x07,                    # .Usage Page (Keyboard)
+        0x75, 0x08,                    # .Report Size (8)
+        0x95, 0x06,                    # .Report Count (6)
+        0x81, 0x00,                    # .Input (Data,Arr,Abs)
+        0xC0,                          # End Collection
+    ]
+    # fmt: on
+
+    def __init__(self, rdesc=report_descriptor, name=None, input_info=None):
+        super().__init__(rdesc, name, input_info)
+
+
+class BaseTest:
+    class TestKeyboard(base.BaseTestCase.TestUhid):
+        def test_single_key(self):
+            """check for key reliability."""
+            uhdev = self.uhdev
+            evdev = uhdev.get_evdev()
+            syn_event = self.syn_event
+
+            r = uhdev.event(["a and A"])
+            expected = [syn_event]
+            expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_A, 1))
+            events = uhdev.next_sync_events()
+            self.debug_reports(r, uhdev, events)
+            self.assertInputEventsIn(expected, events)
+            assert evdev.value[libevdev.EV_KEY.KEY_A] == 1
+
+            r = uhdev.event([])
+            expected = [syn_event]
+            expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_A, 0))
+            events = uhdev.next_sync_events()
+            self.debug_reports(r, uhdev, events)
+            self.assertInputEventsIn(expected, events)
+            assert evdev.value[libevdev.EV_KEY.KEY_A] == 0
+
+        def test_two_keys(self):
+            uhdev = self.uhdev
+            evdev = uhdev.get_evdev()
+            syn_event = self.syn_event
+
+            r = uhdev.event(["a and A", "q and Q"])
+            expected = [syn_event]
+            expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_A, 1))
+            expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_Q, 1))
+            events = uhdev.next_sync_events()
+            self.debug_reports(r, uhdev, events)
+            self.assertInputEventsIn(expected, events)
+            assert evdev.value[libevdev.EV_KEY.KEY_A] == 1
+
+            r = uhdev.event([])
+            expected = [syn_event]
+            expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_A, 0))
+            expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_Q, 0))
+            events = uhdev.next_sync_events()
+            self.debug_reports(r, uhdev, events)
+            self.assertInputEventsIn(expected, events)
+            assert evdev.value[libevdev.EV_KEY.KEY_A] == 0
+            assert evdev.value[libevdev.EV_KEY.KEY_Q] == 0
+
+            r = uhdev.event(["c and C"])
+            expected = [syn_event]
+            expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_C, 1))
+            events = uhdev.next_sync_events()
+            self.debug_reports(r, uhdev, events)
+            self.assertInputEventsIn(expected, events)
+            assert evdev.value[libevdev.EV_KEY.KEY_C] == 1
+
+            r = uhdev.event(["c and C", "Spacebar"])
+            expected = [syn_event]
+            expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_SPACE, 1))
+            events = uhdev.next_sync_events()
+            self.debug_reports(r, uhdev, events)
+            assert libevdev.InputEvent(libevdev.EV_KEY.KEY_C) not in events
+            self.assertInputEventsIn(expected, events)
+            assert evdev.value[libevdev.EV_KEY.KEY_C] == 1
+            assert evdev.value[libevdev.EV_KEY.KEY_SPACE] == 1
+
+            r = uhdev.event(["Spacebar"])
+            expected = [syn_event]
+            expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_C, 0))
+            events = uhdev.next_sync_events()
+            self.debug_reports(r, uhdev, events)
+            assert libevdev.InputEvent(libevdev.EV_KEY.KEY_SPACE) not in events
+            self.assertInputEventsIn(expected, events)
+            assert evdev.value[libevdev.EV_KEY.KEY_C] == 0
+            assert evdev.value[libevdev.EV_KEY.KEY_SPACE] == 1
+
+            r = uhdev.event([])
+            expected = [syn_event]
+            expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_SPACE, 0))
+            events = uhdev.next_sync_events()
+            self.debug_reports(r, uhdev, events)
+            self.assertInputEventsIn(expected, events)
+            assert evdev.value[libevdev.EV_KEY.KEY_SPACE] == 0
+
+        def test_modifiers(self):
+            # ctrl-alt-del would be very nice :)
+            uhdev = self.uhdev
+            syn_event = self.syn_event
+
+            r = uhdev.event(["LeftControl", "LeftShift", "= and +"])
+            expected = [syn_event]
+            expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_LEFTCTRL, 1))
+            expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_LEFTSHIFT, 1))
+            expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_EQUAL, 1))
+            events = uhdev.next_sync_events()
+            self.debug_reports(r, uhdev, events)
+            self.assertInputEventsIn(expected, events)
+
+
+class TestPlainKeyboard(BaseTest.TestKeyboard):
+    def create_device(self):
+        return PlainKeyboard()
+
+    def test_10_keys(self):
+        uhdev = self.uhdev
+        syn_event = self.syn_event
+
+        r = uhdev.event(
+            [
+                "1 and !",
+                "2 and @",
+                "3 and #",
+                "4 and $",
+                "5 and %",
+                "6 and ^",
+                "7 and &",
+                "8 and *",
+                "9 and (",
+                "0 and )",
+            ]
+        )
+        expected = [syn_event]
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_0, 1))
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_1, 1))
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_2, 1))
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_3, 1))
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_4, 1))
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_5, 1))
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_6, 1))
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_7, 1))
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_8, 1))
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_9, 1))
+        events = uhdev.next_sync_events()
+        self.debug_reports(r, uhdev, events)
+        self.assertInputEventsIn(expected, events)
+
+        r = uhdev.event([])
+        expected = [syn_event]
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_0, 0))
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_1, 0))
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_2, 0))
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_3, 0))
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_4, 0))
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_5, 0))
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_6, 0))
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_7, 0))
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_8, 0))
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_9, 0))
+        events = uhdev.next_sync_events()
+        self.debug_reports(r, uhdev, events)
+        self.assertInputEventsIn(expected, events)
+
+
+class TestArrayKeyboard(BaseTest.TestKeyboard):
+    def create_device(self):
+        return ArrayKeyboard()
+
+    def test_10_keys(self):
+        uhdev = self.uhdev
+        syn_event = self.syn_event
+
+        r = uhdev.event(
+            [
+                "1 and !",
+                "2 and @",
+                "3 and #",
+                "4 and $",
+                "5 and %",
+                "6 and ^",
+            ]
+        )
+        expected = [syn_event]
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_1, 1))
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_2, 1))
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_3, 1))
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_4, 1))
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_5, 1))
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_6, 1))
+        events = uhdev.next_sync_events()
+
+        self.debug_reports(r, uhdev, events)
+        self.assertInputEventsIn(expected, events)
+
+        # ErrRollOver
+        r = uhdev.event(
+            [
+                "1 and !",
+                "2 and @",
+                "3 and #",
+                "4 and $",
+                "5 and %",
+                "6 and ^",
+                "7 and &",
+                "8 and *",
+                "9 and (",
+                "0 and )",
+            ]
+        )
+        events = uhdev.next_sync_events()
+
+        self.debug_reports(r, uhdev, events)
+
+        assert len(events) == 0
+
+        r = uhdev.event([])
+        expected = [syn_event]
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_1, 0))
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_2, 0))
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_3, 0))
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_4, 0))
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_5, 0))
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_6, 0))
+        events = uhdev.next_sync_events()
+        self.debug_reports(r, uhdev, events)
+        self.assertInputEventsIn(expected, events)
+
+
+class TestLEDKeyboard(BaseTest.TestKeyboard):
+    def create_device(self):
+        return LEDKeyboard()
+
+
+class TestPrimaxKeyboard(BaseTest.TestKeyboard):
+    def create_device(self):
+        return PrimaxKeyboard()

-- 
2.39.1

