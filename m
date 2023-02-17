Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB10269B0B6
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Feb 2023 17:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjBQQVe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Feb 2023 11:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjBQQVC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Feb 2023 11:21:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48DC5FC7C
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Feb 2023 08:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676650752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cuB7x4yeuY8QBYR6htxKdH+Dn4QUn1FKGu0L8DYt9Fg=;
        b=XfBNVY+2VemACSuPZhUdd/WFjIUXUkC1YUDy/THFIWmaAALEoLyh6oqa6neflQd9YJueYF
        lRmg94XGWDKLA0FAw+pImiMoViDNKUYyR3H5aQ+dyxT6pIpGSH7nzTbEFR3q/NGcVCK1Zh
        o2UZKPLFXEQD3Ym2ozxu25YEhkvN9h8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-572-ZhJleZk_PJagTQhi8A-apQ-1; Fri, 17 Feb 2023 11:19:05 -0500
X-MC-Unique: ZhJleZk_PJagTQhi8A-apQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B43023814581;
        Fri, 17 Feb 2023 16:19:03 +0000 (UTC)
Received: from xps-13.local (unknown [10.39.193.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC98DC15BA0;
        Fri, 17 Feb 2023 16:19:02 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 17 Feb 2023 17:18:05 +0100
Subject: [PATCH 11/11] selftests: hid: import hid-tools usb-crash tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-import-hid-tools-tests-v1-11-d1c48590d0ee@redhat.com>
References: <20230217-import-hid-tools-tests-v1-0-d1c48590d0ee@redhat.com>
In-Reply-To: <20230217-import-hid-tools-tests-v1-0-d1c48590d0ee@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676650715; l=6172;
 i=benjamin.tissoires@redhat.com; s=20230215; h=from:subject:message-id;
 bh=9UDXPt2tM21JKTbYVa/JCBbuyLMC72VLNcGOr7GD/fU=;
 b=FtnlzDnQvd1h1EqJEOMQoin+hx/F4RYlmdGncS9cJPzE7rWxQZPzoV0yj2044vaIw2S1RqA/s
 Y2msgJf6yzYCaLSQ1mK/f+zb799px6BKJIFJ8RzoPUc15zt9ccEhiXl
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

This one gets skipped when run by vmtest.sh as we currently need to test
against actual kernel modules (.ko), not built-in to fetch the list
of supported devices.

[0] https://gitlab.freedesktop.org/libevdev/hid-tools

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 tools/testing/selftests/hid/Makefile               |   1 +
 tools/testing/selftests/hid/hid-usb_crash.sh       |   7 ++
 .../testing/selftests/hid/tests/test_usb_crash.py  | 103 +++++++++++++++++++++
 3 files changed, 111 insertions(+)

diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
index dcea4f1e9369..01c0491d64da 100644
--- a/tools/testing/selftests/hid/Makefile
+++ b/tools/testing/selftests/hid/Makefile
@@ -14,6 +14,7 @@ TEST_PROGS += hid-mouse.sh
 TEST_PROGS += hid-multitouch.sh
 TEST_PROGS += hid-sony.sh
 TEST_PROGS += hid-tablet.sh
+TEST_PROGS += hid-usb_crash.sh
 TEST_PROGS += hid-wacom.sh
 
 CXX ?= $(CROSS_COMPILE)g++
diff --git a/tools/testing/selftests/hid/hid-usb_crash.sh b/tools/testing/selftests/hid/hid-usb_crash.sh
new file mode 100755
index 000000000000..3f0debe7e8fd
--- /dev/null
+++ b/tools/testing/selftests/hid/hid-usb_crash.sh
@@ -0,0 +1,7 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Runs tests for the HID subsystem
+
+export TARGET=test_usb_crash.py
+
+bash ./run-hid-tools-tests.sh
diff --git a/tools/testing/selftests/hid/tests/test_usb_crash.py b/tools/testing/selftests/hid/tests/test_usb_crash.py
new file mode 100644
index 000000000000..e98bff9197c7
--- /dev/null
+++ b/tools/testing/selftests/hid/tests/test_usb_crash.py
@@ -0,0 +1,103 @@
+#!/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# -*- coding: utf-8 -*-
+#
+# Copyright (c) 2021 Benjamin Tissoires <benjamin.tissoires@gmail.com>
+# Copyright (c) 2021 Red Hat, Inc.
+#
+
+# This is to ensure we don't crash when emulating USB devices
+
+from . import base
+import pytest
+import logging
+
+logger = logging.getLogger("hidtools.test.usb")
+
+
+class USBDev(base.UHIDTestDevice):
+    # fmt: off
+    report_descriptor = [
+        0x05, 0x01,  # .Usage Page (Generic Desktop)        0
+        0x09, 0x02,  # .Usage (Mouse)                       2
+        0xa1, 0x01,  # .Collection (Application)            4
+        0x09, 0x02,  # ..Usage (Mouse)                      6
+        0xa1, 0x02,  # ..Collection (Logical)               8
+        0x09, 0x01,  # ...Usage (Pointer)                   10
+        0xa1, 0x00,  # ...Collection (Physical)             12
+        0x05, 0x09,  # ....Usage Page (Button)              14
+        0x19, 0x01,  # ....Usage Minimum (1)                16
+        0x29, 0x03,  # ....Usage Maximum (3)                18
+        0x15, 0x00,  # ....Logical Minimum (0)              20
+        0x25, 0x01,  # ....Logical Maximum (1)              22
+        0x75, 0x01,  # ....Report Size (1)                  24
+        0x95, 0x03,  # ....Report Count (3)                 26
+        0x81, 0x02,  # ....Input (Data,Var,Abs)             28
+        0x75, 0x05,  # ....Report Size (5)                  30
+        0x95, 0x01,  # ....Report Count (1)                 32
+        0x81, 0x03,  # ....Input (Cnst,Var,Abs)             34
+        0x05, 0x01,  # ....Usage Page (Generic Desktop)     36
+        0x09, 0x30,  # ....Usage (X)                        38
+        0x09, 0x31,  # ....Usage (Y)                        40
+        0x15, 0x81,  # ....Logical Minimum (-127)           42
+        0x25, 0x7f,  # ....Logical Maximum (127)            44
+        0x75, 0x08,  # ....Report Size (8)                  46
+        0x95, 0x02,  # ....Report Count (2)                 48
+        0x81, 0x06,  # ....Input (Data,Var,Rel)             50
+        0xc0,        # ...End Collection                    52
+        0xc0,        # ..End Collection                     53
+        0xc0,        # .End Collection                      54
+    ]
+    # fmt: on
+
+    def __init__(self, name=None, input_info=None):
+        super().__init__(
+            name, "Mouse", input_info=input_info, rdesc=USBDev.report_descriptor
+        )
+
+    # skip witing for udev events, it's likely that the report
+    # descriptor is wrong
+    def is_ready(self):
+        return True
+
+    # we don't have an evdev node here, so paper over
+    # the checks
+    def get_evdev(self, application=None):
+        return "OK"
+
+
+class TestUSBDevice(base.BaseTestCase.TestUhid):
+    """
+    Test class to test if an emulated USB device crashes
+    the kernel.
+    """
+
+    # conftest.py is generating the following fixture:
+    #
+    # @pytest.fixture(params=[('modulename', 1, 2)])
+    # def usbVidPid(self, request):
+    #     return request.param
+
+    @pytest.fixture()
+    def new_uhdev(self, usbVidPid, request):
+        self.module, self.vid, self.pid = usbVidPid
+        self._load_kernel_module(None, self.module)
+        return USBDev(input_info=(3, self.vid, self.pid))
+
+    def test_creation(self):
+        """
+        inject the USB dev through uhid and immediately see if there is a crash:
+
+        uhid can create a USB device with the BUS_USB bus, and some
+        drivers assume that they can then access USB related structures
+        when they are actually provided a uhid device. This leads to
+        a crash because those access result in a segmentation fault.
+
+        The kernel should not crash on any (random) user space correct
+        use of its API. So run through all available modules and declared
+        devices to see if we can generate a uhid device without a crash.
+
+        The test is empty as the fixture `check_taint` is doing the job (and
+        honestly, when the kernel crashes, the whole machine freezes).
+        """
+        assert True

-- 
2.39.1

