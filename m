Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DED469B0AE
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Feb 2023 17:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjBQQUr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Feb 2023 11:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjBQQU0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Feb 2023 11:20:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE1D714AD
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Feb 2023 08:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676650744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R9HEkc68kBrPCHNCKk7IRwO1iDwaVhXDPVzUp6kzZu0=;
        b=MKNzA/1+vPDekOhi/Rx4J+lEuhjD/9kvDQW8Pezn5WdAJj24BlX9+pem50az9crwud4nPJ
        GzS9a9WhhUW744p628mnl/5KdXDpJcou12QMTmTIGeFyJRJaXAezJdgJINLOsC7LamFAmZ
        yijavPIpXB3qECb44z1zIuEwrZ0OnEg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-vmaAm1xuMLSzPit785927A-1; Fri, 17 Feb 2023 11:19:01 -0500
X-MC-Unique: vmaAm1xuMLSzPit785927A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7431580280C;
        Fri, 17 Feb 2023 16:19:00 +0000 (UTC)
Received: from xps-13.local (unknown [10.39.193.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 17354C15BA0;
        Fri, 17 Feb 2023 16:18:58 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 17 Feb 2023 17:18:03 +0100
Subject: [PATCH 09/11] selftests: hid: import hid-tools hid-ite tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-import-hid-tools-tests-v1-9-d1c48590d0ee@redhat.com>
References: <20230217-import-hid-tools-tests-v1-0-d1c48590d0ee@redhat.com>
In-Reply-To: <20230217-import-hid-tools-tests-v1-0-d1c48590d0ee@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Roderick Colenbrander <roderick.colenbrander@sony.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676650715; l=12211;
 i=benjamin.tissoires@redhat.com; s=20230215; h=from:subject:message-id;
 bh=PfonMQY364bbGXn/80KOa2Wxjaq21ABYhUoRdpo2/JA=;
 b=2rp2ooqHnDsINSwedJWhRUKJfhA3kF/BnVTEYxabbYujgxC6hc0QUsmuzqGGeXgjOEQhGoEtu
 V9hX9FHEix7Bm+9NQkimCmDUv8WosYzRY+IBwog/rBqPfvisAKDS0me
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

Cc: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Roderick Colenbrander <roderick.colenbrander@sony.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 tools/testing/selftests/hid/Makefile               |   1 +
 tools/testing/selftests/hid/config                 |   1 +
 tools/testing/selftests/hid/hid-ite.sh             |   7 +
 .../selftests/hid/tests/test_ite_keyboard.py       | 166 +++++++++++++++++++++
 4 files changed, 175 insertions(+)

diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
index ce03c65bfba0..3ca696c44aab 100644
--- a/tools/testing/selftests/hid/Makefile
+++ b/tools/testing/selftests/hid/Makefile
@@ -8,6 +8,7 @@ include ../../../scripts/Makefile.include
 TEST_PROGS := hid-core.sh
 TEST_PROGS += hid-apple.sh
 TEST_PROGS += hid-gamepad.sh
+TEST_PROGS += hid-ite.sh
 TEST_PROGS += hid-keyboard.sh
 TEST_PROGS += hid-mouse.sh
 TEST_PROGS += hid-multitouch.sh
diff --git a/tools/testing/selftests/hid/config b/tools/testing/selftests/hid/config
index 52b527cc2260..f400b8d94e3c 100644
--- a/tools/testing/selftests/hid/config
+++ b/tools/testing/selftests/hid/config
@@ -22,5 +22,6 @@ CONFIG_UHID=y
 CONFIG_USB=y
 CONFIG_USB_HID=y
 CONFIG_HID_APPLE=y
+CONFIG_HID_ITE=y
 CONFIG_HID_MULTITOUCH=y
 CONFIG_HID_WACOM=y
diff --git a/tools/testing/selftests/hid/hid-ite.sh b/tools/testing/selftests/hid/hid-ite.sh
new file mode 100755
index 000000000000..52c5ccf42292
--- /dev/null
+++ b/tools/testing/selftests/hid/hid-ite.sh
@@ -0,0 +1,7 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Runs tests for the HID subsystem
+
+export TARGET=test_ite_keyboard.py
+
+bash ./run-hid-tools-tests.sh
diff --git a/tools/testing/selftests/hid/tests/test_ite_keyboard.py b/tools/testing/selftests/hid/tests/test_ite_keyboard.py
new file mode 100644
index 000000000000..38550c167bae
--- /dev/null
+++ b/tools/testing/selftests/hid/tests/test_ite_keyboard.py
@@ -0,0 +1,166 @@
+#!/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# -*- coding: utf-8 -*-
+#
+# Copyright (c) 2020 Benjamin Tissoires <benjamin.tissoires@gmail.com>
+# Copyright (c) 2020 Red Hat, Inc.
+#
+
+from .test_keyboard import ArrayKeyboard, TestArrayKeyboard
+from hidtools.util import BusType
+
+import libevdev
+import logging
+
+logger = logging.getLogger("hidtools.test.ite-keyboard")
+
+KERNEL_MODULE = ("itetech", "hid_ite")
+
+
+class KbdData(object):
+    pass
+
+
+# The ITE keyboards have an issue regarding the Wifi key:
+# nothing comes in when pressing the key, but we get a null
+# event on the key release.
+# This test covers this case.
+class ITEKeyboard(ArrayKeyboard):
+    # fmt: off
+    report_descriptor = [
+        0x06, 0x85, 0xff,              # Usage Page (Vendor Usage Page 0xff85)
+        0x09, 0x95,                    # Usage (Vendor Usage 0x95)           3
+        0xa1, 0x01,                    # Collection (Application)            5
+        0x85, 0x5a,                    # .Report ID (90)                     7
+        0x09, 0x01,                    # .Usage (Vendor Usage 0x01)          9
+        0x15, 0x00,                    # .Logical Minimum (0)                11
+        0x26, 0xff, 0x00,              # .Logical Maximum (255)              13
+        0x75, 0x08,                    # .Report Size (8)                    16
+        0x95, 0x10,                    # .Report Count (16)                  18
+        0xb1, 0x00,                    # .Feature (Data,Arr,Abs)             20
+        0xc0,                          # End Collection                      22
+        0x05, 0x01,                    # Usage Page (Generic Desktop)        23
+        0x09, 0x06,                    # Usage (Keyboard)                    25
+        0xa1, 0x01,                    # Collection (Application)            27
+        0x85, 0x01,                    # .Report ID (1)                      29
+        0x75, 0x01,                    # .Report Size (1)                    31
+        0x95, 0x08,                    # .Report Count (8)                   33
+        0x05, 0x07,                    # .Usage Page (Keyboard)              35
+        0x19, 0xe0,                    # .Usage Minimum (224)                37
+        0x29, 0xe7,                    # .Usage Maximum (231)                39
+        0x15, 0x00,                    # .Logical Minimum (0)                41
+        0x25, 0x01,                    # .Logical Maximum (1)                43
+        0x81, 0x02,                    # .Input (Data,Var,Abs)               45
+        0x95, 0x01,                    # .Report Count (1)                   47
+        0x75, 0x08,                    # .Report Size (8)                    49
+        0x81, 0x03,                    # .Input (Cnst,Var,Abs)               51
+        0x95, 0x05,                    # .Report Count (5)                   53
+        0x75, 0x01,                    # .Report Size (1)                    55
+        0x05, 0x08,                    # .Usage Page (LEDs)                  57
+        0x19, 0x01,                    # .Usage Minimum (1)                  59
+        0x29, 0x05,                    # .Usage Maximum (5)                  61
+        0x91, 0x02,                    # .Output (Data,Var,Abs)              63
+        0x95, 0x01,                    # .Report Count (1)                   65
+        0x75, 0x03,                    # .Report Size (3)                    67
+        0x91, 0x03,                    # .Output (Cnst,Var,Abs)              69
+        0x95, 0x06,                    # .Report Count (6)                   71
+        0x75, 0x08,                    # .Report Size (8)                    73
+        0x15, 0x00,                    # .Logical Minimum (0)                75
+        0x26, 0xff, 0x00,              # .Logical Maximum (255)              77
+        0x05, 0x07,                    # .Usage Page (Keyboard)              80
+        0x19, 0x00,                    # .Usage Minimum (0)                  82
+        0x2a, 0xff, 0x00,              # .Usage Maximum (255)                84
+        0x81, 0x00,                    # .Input (Data,Arr,Abs)               87
+        0xc0,                          # End Collection                      89
+        0x05, 0x0c,                    # Usage Page (Consumer Devices)       90
+        0x09, 0x01,                    # Usage (Consumer Control)            92
+        0xa1, 0x01,                    # Collection (Application)            94
+        0x85, 0x02,                    # .Report ID (2)                      96
+        0x19, 0x00,                    # .Usage Minimum (0)                  98
+        0x2a, 0x3c, 0x02,              # .Usage Maximum (572)                100
+        0x15, 0x00,                    # .Logical Minimum (0)                103
+        0x26, 0x3c, 0x02,              # .Logical Maximum (572)              105
+        0x75, 0x10,                    # .Report Size (16)                   108
+        0x95, 0x01,                    # .Report Count (1)                   110
+        0x81, 0x00,                    # .Input (Data,Arr,Abs)               112
+        0xc0,                          # End Collection                      114
+        0x05, 0x01,                    # Usage Page (Generic Desktop)        115
+        0x09, 0x0c,                    # Usage (Wireless Radio Controls)     117
+        0xa1, 0x01,                    # Collection (Application)            119
+        0x85, 0x03,                    # .Report ID (3)                      121
+        0x15, 0x00,                    # .Logical Minimum (0)                123
+        0x25, 0x01,                    # .Logical Maximum (1)                125
+        0x09, 0xc6,                    # .Usage (Wireless Radio Button)      127
+        0x95, 0x01,                    # .Report Count (1)                   129
+        0x75, 0x01,                    # .Report Size (1)                    131
+        0x81, 0x06,                    # .Input (Data,Var,Rel)               133
+        0x75, 0x07,                    # .Report Size (7)                    135
+        0x81, 0x03,                    # .Input (Cnst,Var,Abs)               137
+        0xc0,                          # End Collection                      139
+        0x05, 0x88,                    # Usage Page (Vendor Usage Page 0x88) 140
+        0x09, 0x01,                    # Usage (Vendor Usage 0x01)           142
+        0xa1, 0x01,                    # Collection (Application)            144
+        0x85, 0x04,                    # .Report ID (4)                      146
+        0x19, 0x00,                    # .Usage Minimum (0)                  148
+        0x2a, 0xff, 0xff,              # .Usage Maximum (65535)              150
+        0x15, 0x00,                    # .Logical Minimum (0)                153
+        0x26, 0xff, 0xff,              # .Logical Maximum (65535)            155
+        0x75, 0x08,                    # .Report Size (8)                    158
+        0x95, 0x02,                    # .Report Count (2)                   160
+        0x81, 0x02,                    # .Input (Data,Var,Abs)               162
+        0xc0,                          # End Collection                      164
+        0x05, 0x01,                    # Usage Page (Generic Desktop)        165
+        0x09, 0x80,                    # Usage (System Control)              167
+        0xa1, 0x01,                    # Collection (Application)            169
+        0x85, 0x05,                    # .Report ID (5)                      171
+        0x19, 0x81,                    # .Usage Minimum (129)                173
+        0x29, 0x83,                    # .Usage Maximum (131)                175
+        0x15, 0x00,                    # .Logical Minimum (0)                177
+        0x25, 0x01,                    # .Logical Maximum (1)                179
+        0x95, 0x08,                    # .Report Count (8)                   181
+        0x75, 0x01,                    # .Report Size (1)                    183
+        0x81, 0x02,                    # .Input (Data,Var,Abs)               185
+        0xc0,                          # End Collection                      187
+    ]
+    # fmt: on
+
+    def __init__(
+        self,
+        rdesc=report_descriptor,
+        name=None,
+        input_info=(BusType.USB, 0x06CB, 0x2968),
+    ):
+        super().__init__(rdesc, name, input_info)
+
+    def event(self, keys, reportID=None, application=None):
+        application = application or "Keyboard"
+        return super().event(keys, reportID, application)
+
+
+class TestITEKeyboard(TestArrayKeyboard):
+    kernel_modules = [KERNEL_MODULE]
+
+    def create_device(self):
+        return ITEKeyboard()
+
+    def test_wifi_key(self):
+        uhdev = self.uhdev
+        syn_event = self.syn_event
+
+        # the following sends a 'release' event on the Wifi key.
+        # the kernel is supposed to translate this into Wifi key
+        # down and up
+        r = [0x03, 0x00]
+        uhdev.call_input_event(r)
+        expected = [syn_event]
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_RFKILL, 1))
+        events = uhdev.next_sync_events()
+        self.debug_reports([r], uhdev, events)
+        self.assertInputEventsIn(expected, events)
+
+        expected = [syn_event]
+        expected.append(libevdev.InputEvent(libevdev.EV_KEY.KEY_RFKILL, 0))
+        # the kernel sends the two down/up key events in a batch, no need to
+        # call events = uhdev.next_sync_events()
+        self.debug_reports([], uhdev, events)
+        self.assertInputEventsIn(expected, events)

-- 
2.39.1

