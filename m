Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A404D6648
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Mar 2022 17:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346315AbiCKQ3L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Mar 2022 11:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350513AbiCKQ1x (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Mar 2022 11:27:53 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01271D4522;
        Fri, 11 Mar 2022 08:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1647015967;
  x=1678551967;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sxaJ4mG3Y2RIBWG3Mim/tcF1834/P18PDxXFWE4XQiY=;
  b=EbGqWLWlN+xsLiCco4wKJCrDnxQ7PvggacA0QXfV97tmvtdHg7mDoc9F
   S+fGzsQt4jFf6+Bks0JSndq+i5fW70DIVR22bm+PxAPAXabzi1OT0BzAa
   AYM57O8DwrfCrRitR2QQ8/7cuicsAe1Dnq9Suk/BFiY1qGUz+H38rnRc2
   CfRj7sJEhkLW2NcuywbdLRmN8xDh27apgE1BffN1ALxTaxCB35bJv4dzO
   fB42JTTSKJSm+eO6LbjEfSeMAPCt6b5YWxEl4fuPwuigJE+eJIMzwaNlD
   Dx/hGsnP/eMB6zFGMHf89FMdK4a9abnR3CZ4/ersUwBVDypAMc/IffEpZ
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
Subject: [RFC v1 09/10] regulator: tps62864: add roadtest
Date:   Fri, 11 Mar 2022 17:24:44 +0100
Message-ID: <20220311162445.346685-10-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220311162445.346685-1-vincent.whitchurch@axis.com>
References: <20220311162445.346685-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a roadtest for the recently-added tps62864 regulator driver.  It
tests voltage setting, mode setting, as well as devicetree mode
translation.  It uses the recently-added devicetree support in
regulator-virtual-consumer.

All the variants supported by the driver have identical register
interfaces so only one test/model is added.

It requires the following patches which are, as of writing, not in
mainline:

 - regulator: Add support for TPS6286x
   https://lore.kernel.org/lkml/20220204155241.576342-3-vincent.whitchurch@axis.com/

 - regulator: virtual: add devicetree support
   https://lore.kernel.org/lkml/20220301111831.3742383-4-vincent.whitchurch@axis.com/

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 .../roadtest/tests/regulator/__init__.py      |   0
 .../roadtest/roadtest/tests/regulator/config  |   4 +
 .../roadtest/tests/regulator/test_tps62864.py | 187 ++++++++++++++++++
 3 files changed, 191 insertions(+)
 create mode 100644 tools/testing/roadtest/roadtest/tests/regulator/__init__.py
 create mode 100644 tools/testing/roadtest/roadtest/tests/regulator/config
 create mode 100644 tools/testing/roadtest/roadtest/tests/regulator/test_tps62864.py

diff --git a/tools/testing/roadtest/roadtest/tests/regulator/__init__.py b/tools/testing/roadtest/roadtest/tests/regulator/__init__.py
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tools/testing/roadtest/roadtest/tests/regulator/config b/tools/testing/roadtest/roadtest/tests/regulator/config
new file mode 100644
index 000000000000..b2b503947e70
--- /dev/null
+++ b/tools/testing/roadtest/roadtest/tests/regulator/config
@@ -0,0 +1,4 @@
+CONFIG_REGULATOR=y
+CONFIG_REGULATOR_DEBUG=y
+CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
+CONFIG_REGULATOR_TPS6286X=m
diff --git a/tools/testing/roadtest/roadtest/tests/regulator/test_tps62864.py b/tools/testing/roadtest/roadtest/tests/regulator/test_tps62864.py
new file mode 100644
index 000000000000..f7db4293d840
--- /dev/null
+++ b/tools/testing/roadtest/roadtest/tests/regulator/test_tps62864.py
@@ -0,0 +1,187 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright Axis Communications AB
+
+from typing import Any, Final
+
+from roadtest.backend.i2c import SimpleSMBusModel
+from roadtest.core.devicetree import DtFragment, DtVar
+from roadtest.core.hardware import Hardware
+from roadtest.core.modules import insmod, rmmod
+from roadtest.core.suite import UMLTestCase
+from roadtest.core.sysfs import (
+    I2CDriver,
+    PlatformDriver,
+    read_str,
+    write_int,
+    write_str,
+)
+
+REG_VOUT1: Final = 0x01
+REG_VOUT2: Final = 0x02
+REG_CONTROL: Final = 0x03
+REG_STATUS: Final = 0x05
+
+
+class TPS62864(SimpleSMBusModel):
+    def __init__(self, **kwargs: Any) -> None:
+        super().__init__(
+            # From datasheet section 8.6 Register map
+            # XXX does not match reality -- recheck
+            regs={
+                REG_VOUT1: 0x64,
+                REG_VOUT2: 0x64,
+                REG_CONTROL: 0x00,
+                REG_STATUS: 0x00,
+            },
+            regbytes=1,
+            **kwargs,
+        )
+
+
+class TestTPS62864(UMLTestCase):
+    dts = DtFragment(
+        src="""
+#include <dt-bindings/regulator/ti,tps62864.h>
+
+&i2c {
+    regulator@$normal$ {
+        compatible = "ti,tps62864";
+        reg = <0x$normal$>;
+
+        regulators {
+            tps62864_normal: SW {
+                regulator-name = "+0.85V";
+                regulator-min-microvolt = <400000>;
+                regulator-max-microvolt = <1675000>;
+                regulator-allowed-modes = <TPS62864_MODE_NORMAL TPS62864_MODE_FPWM>;
+            };
+        };
+    };
+
+    regulator@$fpwm$ {
+        compatible = "ti,tps62864";
+        reg = <0x$fpwm$>;
+
+        regulators {
+            tps62864_fpwm: SW {
+                regulator-name = "+0.85V";
+                regulator-min-microvolt = <400000>;
+                regulator-max-microvolt = <1675000>;
+                regulator-initial-mode = <TPS62864_MODE_FPWM>;
+            };
+        };
+    };
+};
+
+/ {
+    tps62864_normal_consumer {
+        compatible = "regulator-virtual-consumer";
+        default-supply = <&tps62864_normal>;
+    };
+
+    tps62864_fpwm_consumer {
+        compatible = "regulator-virtual-consumer";
+        default-supply = <&tps62864_fpwm>;
+    };
+};
+        """,
+        variables={
+            "normal": DtVar.I2C_ADDR,
+            "fpwm": DtVar.I2C_ADDR,
+        },
+    )
+
+    @classmethod
+    def setUpClass(cls) -> None:
+        insmod("tps6286x-regulator")
+
+    @classmethod
+    def tearDownClass(cls) -> None:
+        rmmod("tps6286x-regulator")
+
+    def setUp(self) -> None:
+        self.driver = I2CDriver("tps6286x")
+        self.hw = Hardware("i2c")
+        self.hw.load_model(TPS62864)
+
+    def tearDown(self) -> None:
+        self.hw.close()
+
+    def test_voltage(self) -> None:
+        with (
+            self.driver.bind(self.dts["normal"]),
+            PlatformDriver("reg-virt-consumer").bind(
+                "tps62864_normal_consumer"
+            ) as consumerdev,
+        ):
+            maxfile = consumerdev.path / "max_microvolts"
+            minfile = consumerdev.path / "min_microvolts"
+
+            write_int(maxfile, 1675000)
+            write_int(minfile, 800000)
+
+            mock = self.hw.update_mock()
+            mock.assert_reg_write_once(self, REG_CONTROL, 1 << 5)
+            mock.assert_reg_write_once(self, REG_VOUT1, 0x50)
+            mock.reset_mock()
+
+            mV = 1000
+            data = [
+                (400 * mV, 0x00),
+                (900 * mV, 0x64),
+                (1675 * mV, 0xFF),
+            ]
+
+            for voltage, val in data:
+                write_int(minfile, voltage)
+                mock = self.hw.update_mock()
+                mock.assert_reg_write_once(self, REG_VOUT1, val)
+                mock.reset_mock()
+
+            write_int(minfile, 0)
+            mock = self.hw.update_mock()
+            mock.assert_reg_write_once(self, REG_CONTROL, 0)
+            mock.reset_mock()
+
+    def test_modes(self) -> None:
+        with (
+            self.driver.bind(self.dts["normal"]),
+            PlatformDriver("reg-virt-consumer").bind(
+                "tps62864_normal_consumer"
+            ) as consumerdev,
+        ):
+            modefile = consumerdev.path / "mode"
+            write_str(modefile, "fast")
+
+            mock = self.hw.update_mock()
+            mock.assert_reg_write_once(self, REG_CONTROL, 1 << 4)
+            mock.reset_mock()
+
+            write_str(modefile, "normal")
+            mock = self.hw.update_mock()
+            mock.assert_reg_write_once(self, REG_CONTROL, 0)
+            mock.reset_mock()
+
+    def test_dt_force_pwm(self) -> None:
+        with (
+            self.driver.bind(self.dts["fpwm"]),
+            PlatformDriver("reg-virt-consumer").bind(
+                "tps62864_fpwm_consumer"
+            ) as consumerdev,
+        ):
+            mock = self.hw.update_mock()
+            mock.assert_reg_write_once(self, REG_CONTROL, 1 << 4)
+            mock.reset_mock()
+
+            modefile = consumerdev.path / "mode"
+            self.assertEquals(read_str(modefile), "fast")
+
+            maxfile = consumerdev.path / "max_microvolts"
+            minfile = consumerdev.path / "min_microvolts"
+
+            write_int(maxfile, 1675000)
+            write_int(minfile, 800000)
+
+            mock = self.hw.update_mock()
+            mock.assert_reg_write_once(self, REG_CONTROL, 1 << 5 | 1 << 4)
+            mock.reset_mock()
-- 
2.34.1

