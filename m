Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0BE4D6632
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Mar 2022 17:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350437AbiCKQ1O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Mar 2022 11:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350320AbiCKQ0q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Mar 2022 11:26:46 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1BD1C4B19;
        Fri, 11 Mar 2022 08:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1647015910;
  x=1678551910;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SOwKI/JWlE04bP10q/tiaI9Kor0jtXpP5KU+ERCqxE8=;
  b=dUbUv7mWtf+c3LWzRTfbJkhMrEtDtCiaeRGU8CH1Yq/h6X9L3V6jZkIH
   y/odUFE3MUF94LzL7R86u1K9EQekBS3qdPQPQaDGHbVI9Frj5ndn53Yvm
   2Vz9JbadMPime4MsqhgBaRMIV3Z4fMFD0W5ldK1xZZLqyML2A3owB35s7
   wNV4nPftyCaSDUUI+mpyclSAGGCw2cO0xvabEFT3Ddl6eOC2yxGqGbNrA
   vGJ47m6s9yPXiV+JNsV/yi75+S/WaubAncWPAn2V2OhveumOrH78o0r5N
   sWTbFvWiPerWD4PWR1oUzZwhoo3kdLf6Kc9Ao0z9zaOw6CsvJ2FfetGkH
   Q==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <devicetree@vger.kernel.org>, <linux-um@lists.infradead.org>,
        <shuah@kernel.org>, <brendanhiggins@google.com>,
        <linux-kselftest@vger.kernel.org>, <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <a.zummo@towertech.it>,
        <alexandre.belloni@bootlin.com>, <linux-rtc@vger.kernel.org>,
        <corbet@lwn.net>, <linux-doc@vger.kernel.org>
Subject: [RFC v1 07/10] iio: light: opt3001: add roadtest
Date:   Fri, 11 Mar 2022 17:24:42 +0100
Message-ID: <20220311162445.346685-8-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220311162445.346685-1-vincent.whitchurch@axis.com>
References: <20220311162445.346685-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a regression test for the problem fixed by the following patch,
which would require specific environmental conditions to be able to be
reproduced and regression-tested on real hardware:

 iio: light: opt3001: Fixed timeout error when 0 lux
 https://lore.kernel.org/lkml/20210920125351.6569-1-valek@2n.cz/

No other aspects of the driver are tested.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 .../roadtest/roadtest/tests/iio/__init__.py   |  0
 .../roadtest/roadtest/tests/iio/config        |  1 +
 .../roadtest/tests/iio/light/__init__.py      |  0
 .../roadtest/roadtest/tests/iio/light/config  |  1 +
 .../roadtest/tests/iio/light/test_opt3001.py  | 95 +++++++++++++++++++
 5 files changed, 97 insertions(+)
 create mode 100644 tools/testing/roadtest/roadtest/tests/iio/__init__.py
 create mode 100644 tools/testing/roadtest/roadtest/tests/iio/config
 create mode 100644 tools/testing/roadtest/roadtest/tests/iio/light/__init__.py
 create mode 100644 tools/testing/roadtest/roadtest/tests/iio/light/config
 create mode 100644 tools/testing/roadtest/roadtest/tests/iio/light/test_opt3001.py

diff --git a/tools/testing/roadtest/roadtest/tests/iio/__init__.py b/tools/testing/roadtest/roadtest/tests/iio/__init__.py
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tools/testing/roadtest/roadtest/tests/iio/config b/tools/testing/roadtest/roadtest/tests/iio/config
new file mode 100644
index 000000000000..a08d9e23ce38
--- /dev/null
+++ b/tools/testing/roadtest/roadtest/tests/iio/config
@@ -0,0 +1 @@
+CONFIG_IIO=y
diff --git a/tools/testing/roadtest/roadtest/tests/iio/light/__init__.py b/tools/testing/roadtest/roadtest/tests/iio/light/__init__.py
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tools/testing/roadtest/roadtest/tests/iio/light/config b/tools/testing/roadtest/roadtest/tests/iio/light/config
new file mode 100644
index 000000000000..b9753f2d0728
--- /dev/null
+++ b/tools/testing/roadtest/roadtest/tests/iio/light/config
@@ -0,0 +1 @@
+CONFIG_OPT3001=m
diff --git a/tools/testing/roadtest/roadtest/tests/iio/light/test_opt3001.py b/tools/testing/roadtest/roadtest/tests/iio/light/test_opt3001.py
new file mode 100644
index 000000000000..abf20b8f3516
--- /dev/null
+++ b/tools/testing/roadtest/roadtest/tests/iio/light/test_opt3001.py
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright Axis Communications AB
+
+from typing import Any, Final
+
+from roadtest.backend.i2c import SMBusModel
+from roadtest.core.devicetree import DtFragment, DtVar
+from roadtest.core.hardware import Hardware
+from roadtest.core.modules import insmod, rmmod
+from roadtest.core.suite import UMLTestCase
+from roadtest.core.sysfs import I2CDriver, read_float
+
+REG_RESULT: Final = 0x00
+REG_CONFIGURATION: Final = 0x01
+REG_LOW_LIMIT: Final = 0x02
+REG_HIGH_LIMIT: Final = 0x03
+REG_MANUFACTURER_ID: Final = 0x7E
+REG_DEVICE_ID: Final = 0x7F
+
+REG_CONFIGURATION_CRF: Final = 1 << 7
+
+
+class OPT3001(SMBusModel):
+    def __init__(self, **kwargs: Any) -> None:
+        super().__init__(regbytes=2, byteorder="big", **kwargs)
+        # Reset values from datasheet
+        self.regs = {
+            REG_RESULT: 0x0000,
+            REG_CONFIGURATION: 0xC810,
+            REG_LOW_LIMIT: 0xC000,
+            REG_HIGH_LIMIT: 0xBFFF,
+            REG_MANUFACTURER_ID: 0x5449,
+            REG_DEVICE_ID: 0x3001,
+        }
+
+    def reg_read(self, addr: int) -> int:
+        val = self.regs[addr]
+
+        if addr == REG_CONFIGURATION:
+            # Always indicate that the conversion is ready.  This is good
+            # enough for our current purposes.
+            val |= REG_CONFIGURATION_CRF
+
+        return val
+
+    def reg_write(self, addr: int, val: int) -> None:
+        assert addr in self.regs
+        self.regs[addr] = val
+
+
+class TestOPT3001(UMLTestCase):
+    dts = DtFragment(
+        src="""
+&i2c {
+    light-sensor@$addr$ {
+        compatible = "ti,opt3001";
+        reg = <0x$addr$>;
+    };
+};
+        """,
+        variables={
+            "addr": DtVar.I2C_ADDR,
+        },
+    )
+
+    @classmethod
+    def setUpClass(cls) -> None:
+        insmod("opt3001")
+
+    @classmethod
+    def tearDownClass(cls) -> None:
+        rmmod("opt3001")
+
+    def setUp(self) -> None:
+        self.driver = I2CDriver("opt3001")
+        self.hw = Hardware("i2c")
+        self.hw.load_model(OPT3001)
+
+    def tearDown(self) -> None:
+        self.hw.close()
+
+    def test_illuminance(self) -> None:
+        data = [
+            # Some values from datasheet, and 0
+            (0b_0000_0000_0000_0000, 0),
+            (0b_0000_0000_0000_0001, 0.01),
+            (0b_0011_0100_0101_0110, 88.80),
+            (0b_0111_1000_1001_1010, 2818.56),
+        ]
+        with self.driver.bind(self.dts["addr"]) as dev:
+            luxfile = dev.path / "iio:device0/in_illuminance_input"
+
+            for regval, lux in data:
+                self.hw.reg_write(REG_RESULT, regval)
+                self.assertEqual(read_float(luxfile), lux)
-- 
2.34.1

