Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40174D6649
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Mar 2022 17:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348529AbiCKQ3M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Mar 2022 11:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350488AbiCKQ1v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Mar 2022 11:27:51 -0500
X-Greylist: delayed 65 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Mar 2022 08:25:57 PST
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4B31D4523;
        Fri, 11 Mar 2022 08:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1647015959;
  x=1678551959;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WEyVVHDFtozxXKM8qFJKp+Cn8U7LcuaL3JvjOEc4jok=;
  b=lA4Gs99IfeCSvaoS3iImpUYT8koA+IFQwxt1xtpqLGA6Y/D95MrVkoEN
   yafWdZkm6dULiwavLwbsFk2/FHJOLVE5zjpRfSorjl1yLYRzL7qQrbXPD
   ezDC9akA+zdti5yqRF5coyUoXl6Swmion+WC88zuIpeNCiLtwyzNjzH+2
   NMD9zWhNNJDZIbB8ig2HpNgx4E1cBFh0m/1fhYsI2GkY2TXuhf5Ebl+N1
   GYhSAePIerIW+5MqBIUp29/498d6omFJiBE7jv/ju87UQjA0hg1luM+HU
   KaDoC9RVQX+nfqSPkFvgSBvPkBEYfZLA6/BLA82rEoJKjrjU3rX71TyY+
   w==;
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
Subject: [RFC v1 03/10] roadtest: add framework
Date:   Fri, 11 Mar 2022 17:24:38 +0100
Message-ID: <20220311162445.346685-4-vincent.whitchurch@axis.com>
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

Add the bulk of the roadtest framework.  Apart from one init shell
script, this is written in Python and includes three closely-related
parts:

 - The test runner which is invoked from the command line by the user
   and which starts the backend and sends the test jobs and results
   to/from UML.

 - Test support code which is used by the actual driver tests run inside
   UML and which interact with the backend via a file-based asynchronous
   communication method.

 - The backend which is run by the Python interpreter embedded in the C
   backend.  This part runs the hardware models and is controlled by the
   tests and the driver (via virtio in the C backend).

Some unit tests for the framework itself are included and these will be
automatically run whenever the driver tests are run.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 tools/testing/roadtest/init.sh                |  19 ++
 tools/testing/roadtest/roadtest/__init__.py   |   2 +
 .../roadtest/roadtest/backend/__init__.py     |   0
 .../roadtest/roadtest/backend/backend.py      |  32 ++
 .../testing/roadtest/roadtest/backend/gpio.py | 111 +++++++
 .../testing/roadtest/roadtest/backend/i2c.py  | 123 ++++++++
 .../testing/roadtest/roadtest/backend/main.py |  13 +
 .../testing/roadtest/roadtest/backend/mock.py |  20 ++
 .../roadtest/roadtest/backend/test_gpio.py    |  98 ++++++
 .../roadtest/roadtest/backend/test_i2c.py     |  84 +++++
 .../testing/roadtest/roadtest/cmd/__init__.py |   0
 tools/testing/roadtest/roadtest/cmd/main.py   | 146 +++++++++
 tools/testing/roadtest/roadtest/cmd/remote.py |  48 +++
 .../roadtest/roadtest/core/__init__.py        |   0
 .../testing/roadtest/roadtest/core/control.py |  52 ++++
 .../roadtest/roadtest/core/devicetree.py      | 155 ++++++++++
 .../roadtest/roadtest/core/hardware.py        |  94 ++++++
 tools/testing/roadtest/roadtest/core/log.py   |  42 +++
 .../testing/roadtest/roadtest/core/modules.py |  38 +++
 .../testing/roadtest/roadtest/core/opslog.py  |  35 +++
 tools/testing/roadtest/roadtest/core/proxy.py |  48 +++
 tools/testing/roadtest/roadtest/core/suite.py | 286 ++++++++++++++++++
 tools/testing/roadtest/roadtest/core/sysfs.py |  77 +++++
 .../roadtest/roadtest/core/test_control.py    |  35 +++
 .../roadtest/roadtest/core/test_devicetree.py |  31 ++
 .../roadtest/roadtest/core/test_hardware.py   |  41 +++
 .../roadtest/roadtest/core/test_log.py        |  54 ++++
 .../roadtest/roadtest/core/test_opslog.py     |  27 ++
 .../roadtest/roadtest/tests/__init__.py       |   0
 29 files changed, 1711 insertions(+)
 create mode 100755 tools/testing/roadtest/init.sh
 create mode 100644 tools/testing/roadtest/roadtest/__init__.py
 create mode 100644 tools/testing/roadtest/roadtest/backend/__init__.py
 create mode 100644 tools/testing/roadtest/roadtest/backend/backend.py
 create mode 100644 tools/testing/roadtest/roadtest/backend/gpio.py
 create mode 100644 tools/testing/roadtest/roadtest/backend/i2c.py
 create mode 100644 tools/testing/roadtest/roadtest/backend/main.py
 create mode 100644 tools/testing/roadtest/roadtest/backend/mock.py
 create mode 100644 tools/testing/roadtest/roadtest/backend/test_gpio.py
 create mode 100644 tools/testing/roadtest/roadtest/backend/test_i2c.py
 create mode 100644 tools/testing/roadtest/roadtest/cmd/__init__.py
 create mode 100644 tools/testing/roadtest/roadtest/cmd/main.py
 create mode 100644 tools/testing/roadtest/roadtest/cmd/remote.py
 create mode 100644 tools/testing/roadtest/roadtest/core/__init__.py
 create mode 100644 tools/testing/roadtest/roadtest/core/control.py
 create mode 100644 tools/testing/roadtest/roadtest/core/devicetree.py
 create mode 100644 tools/testing/roadtest/roadtest/core/hardware.py
 create mode 100644 tools/testing/roadtest/roadtest/core/log.py
 create mode 100644 tools/testing/roadtest/roadtest/core/modules.py
 create mode 100644 tools/testing/roadtest/roadtest/core/opslog.py
 create mode 100644 tools/testing/roadtest/roadtest/core/proxy.py
 create mode 100644 tools/testing/roadtest/roadtest/core/suite.py
 create mode 100644 tools/testing/roadtest/roadtest/core/sysfs.py
 create mode 100644 tools/testing/roadtest/roadtest/core/test_control.py
 create mode 100644 tools/testing/roadtest/roadtest/core/test_devicetree.py
 create mode 100644 tools/testing/roadtest/roadtest/core/test_hardware.py
 create mode 100644 tools/testing/roadtest/roadtest/core/test_log.py
 create mode 100644 tools/testing/roadtest/roadtest/core/test_opslog.py
 create mode 100644 tools/testing/roadtest/roadtest/tests/__init__.py

diff --git a/tools/testing/roadtest/init.sh b/tools/testing/roadtest/init.sh
new file mode 100755
index 000000000000..c5fb28478aa3
--- /dev/null
+++ b/tools/testing/roadtest/init.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-only
+
+mount -t proc proc /proc
+echo 8 > /proc/sys/kernel/printk
+mount -t sysfs nodev /sys
+mount -t debugfs nodev /sys/kernel/debug
+
+echo 0 > /sys/bus/i2c/drivers_autoprobe
+echo 0 > /sys/bus/platform/drivers_autoprobe
+
+python3 -m roadtest.cmd.remote
+status=$?
+[ "${ROADTEST_SHELL}" = "1" ] || {
+    # rsync doesn't handle these zero-sized files correctly.
+    cp -ra --no-preserve=ownership /sys/kernel/debug/gcov ${ROADTEST_WORK_DIR}/gcov
+    echo o > /proc/sysrq-trigger
+}
+exec setsid sh -c 'exec bash </dev/tty0 >/dev/tty0 2>&1'
diff --git a/tools/testing/roadtest/roadtest/__init__.py b/tools/testing/roadtest/roadtest/__init__.py
new file mode 100644
index 000000000000..dac3ce6976e5
--- /dev/null
+++ b/tools/testing/roadtest/roadtest/__init__.py
@@ -0,0 +1,2 @@
+ENV_WORK_DIR = "ROADTEST_WORK_DIR"
+ENV_BUILD_DIR = "ROADTEST_BUILD_DIR"
diff --git a/tools/testing/roadtest/roadtest/backend/__init__.py b/tools/testing/roadtest/roadtest/backend/__init__.py
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tools/testing/roadtest/roadtest/backend/backend.py b/tools/testing/roadtest/roadtest/backend/backend.py
new file mode 100644
index 000000000000..bfd19fc363c2
--- /dev/null
+++ b/tools/testing/roadtest/roadtest/backend/backend.py
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright Axis Communications AB
+
+import logging
+import os
+from pathlib import Path
+
+from roadtest import ENV_WORK_DIR
+from roadtest.core.control import ControlReader
+
+from . import gpio, i2c, mock
+
+logger = logging.getLogger(__name__)
+
+try:
+    import cbackend  # type: ignore[import]
+except ModuleNotFoundError:
+    # In unit tests
+    cbackend = None
+
+
+class Backend:
+    def __init__(self) -> None:
+        work = Path(os.environ[ENV_WORK_DIR])
+        self.control = ControlReader(work_dir=work)
+        self.c = cbackend
+        self.i2c = i2c.I2CBackend(self)
+        self.gpio = gpio.GpioBackend(self)
+        self.mock = mock.MockBackend(work)
+
+    def process_control(self) -> None:
+        self.control.process({"backend": self})
diff --git a/tools/testing/roadtest/roadtest/backend/gpio.py b/tools/testing/roadtest/roadtest/backend/gpio.py
new file mode 100644
index 000000000000..2eaf52b31c72
--- /dev/null
+++ b/tools/testing/roadtest/roadtest/backend/gpio.py
@@ -0,0 +1,111 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright Axis Communications AB
+
+import logging
+import typing
+from typing import Optional
+
+if typing.TYPE_CHECKING:
+    # Avoid circular imports
+    from .backend import Backend
+
+logger = logging.getLogger(__name__)
+
+
+class Gpio:
+    IRQ_TYPE_NONE = 0x00
+    IRQ_TYPE_EDGE_RISING = 0x01
+    IRQ_TYPE_EDGE_FALLING = 0x02
+    IRQ_TYPE_EDGE_BOTH = 0x03
+    IRQ_TYPE_LEVEL_HIGH = 0x04
+    IRQ_TYPE_LEVEL_LOW = 0x08
+
+    def __init__(self, backend: "Backend", pin: int):
+        self.backend = backend
+        self.pin = pin
+        self.state = False
+        self.irq_type = Gpio.IRQ_TYPE_NONE
+        self.masked = True
+        self.edge_irq_latched = False
+
+    def _level_irq_active(self) -> bool:
+        if self.irq_type == Gpio.IRQ_TYPE_LEVEL_HIGH:
+            return self.state
+        elif self.irq_type == Gpio.IRQ_TYPE_LEVEL_LOW:
+            return not self.state
+
+        return False
+
+    def _latch_edge_irq(self, old: bool, new: bool) -> bool:
+        if old != new:
+            logger.debug(f"{self}: latch_edge_irq {self.irq_type} {old} -> {new}")
+
+        if self.irq_type == Gpio.IRQ_TYPE_EDGE_RISING:
+            return not old and new
+        elif self.irq_type == Gpio.IRQ_TYPE_EDGE_FALLING:
+            return old and not new
+        elif self.irq_type == Gpio.IRQ_TYPE_EDGE_BOTH:
+            return old != new
+
+        return False
+
+    def _check_irq(self) -> None:
+        if self.irq_type == Gpio.IRQ_TYPE_NONE or self.masked:
+            return
+        if not self.edge_irq_latched and not self._level_irq_active():
+            return
+
+        self.masked = True
+        self.edge_irq_latched = False
+
+        logger.debug(f"{self}: trigger irq")
+        self.backend.c.trigger_gpio_irq(self.pin)
+
+    def set_irq_type(self, irq_type: int) -> None:
+        logger.debug(f"{self}: set_irq_type {irq_type}")
+        if irq_type == Gpio.IRQ_TYPE_NONE:
+            self.masked = True
+
+        self.irq_type = irq_type
+        self.edge_irq_latched = False
+        self._check_irq()
+
+    def unmask(self) -> None:
+        logger.debug(f"{self}: unmask")
+        self.masked = False
+        self._check_irq()
+
+    def set(self, val: int) -> None:
+        old = self.state
+        new = bool(val)
+
+        if old != new:
+            logger.debug(f"{self}: gpio set {old} -> {new}")
+
+        self.state = new
+        if self._latch_edge_irq(old, new):
+            logger.debug(f"{self}: latching edge")
+            self.edge_irq_latched = True
+
+        self._check_irq()
+
+    def __str__(self) -> str:
+        return f"Gpio({self.pin})"
+
+
+class GpioBackend:
+    def __init__(self, backend: "Backend") -> None:
+        self.backend = backend
+        self.gpios = [Gpio(backend, pin) for pin in range(64)]
+
+    def set(self, pin: Optional[int], val: bool) -> None:
+        if pin is None:
+            return
+
+        self.gpios[pin].set(val)
+
+    def set_irq_type(self, pin: int, irq_type: int) -> None:
+        self.gpios[pin].set_irq_type(irq_type)
+
+    def unmask(self, pin: int) -> None:
+        self.gpios[pin].unmask()
diff --git a/tools/testing/roadtest/roadtest/backend/i2c.py b/tools/testing/roadtest/roadtest/backend/i2c.py
new file mode 100644
index 000000000000..b877c2b76851
--- /dev/null
+++ b/tools/testing/roadtest/roadtest/backend/i2c.py
@@ -0,0 +1,123 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright Axis Communications AB
+
+import abc
+import importlib
+import logging
+import typing
+from typing import Any, Literal, Optional
+
+if typing.TYPE_CHECKING:
+    # Avoid circular imports
+    from .backend import Backend
+
+logger = logging.getLogger(__name__)
+
+
+class I2CBackend:
+    def __init__(self, backend: "Backend") -> None:
+        self.model: Optional[I2CModel] = None
+        self.backend = backend
+
+    def load_model(self, modname: str, clsname: str, *args: Any, **kwargs: Any) -> None:
+        mod = importlib.import_module(modname)
+        cls = getattr(mod, clsname)
+        self.model = cls(*args, **kwargs, backend=self.backend)
+
+    def unload_model(self) -> None:
+        self.model = None
+
+    def read(self, length: int) -> bytes:
+        if not self.model:
+            raise Exception("No I2C model loaded")
+
+        return self.model.read(length)
+
+    def write(self, data: bytes) -> None:
+        if not self.model:
+            raise Exception("No I2C model loaded")
+
+        self.model.write(data)
+
+    def __getattr__(self, name: str) -> Any:
+        return getattr(self.model, name)
+
+
+class I2CModel(abc.ABC):
+    def __init__(self, backend: "Backend") -> None:
+        self.backend = backend
+
+    @abc.abstractmethod
+    def read(self, length: int) -> bytes:
+        return bytes(length)
+
+    @abc.abstractmethod
+    def write(self, data: bytes) -> None:
+        pass
+
+
+class SMBusModel(I2CModel):
+    def __init__(
+        self,
+        regbytes: int,
+        byteorder: Literal["little", "big"] = "little",
+        *args: Any,
+        **kwargs: Any,
+    ) -> None:
+        super().__init__(*args, **kwargs)
+        self.reg_addr = 0x0
+        self.regbytes = regbytes
+        self.byteorder = byteorder
+
+    @abc.abstractmethod
+    def reg_read(self, addr: int) -> int:
+        return 0
+
+    @abc.abstractmethod
+    def reg_write(self, addr: int, val: int) -> None:
+        pass
+
+    def val_to_bytes(self, val: int) -> bytes:
+        return val.to_bytes(self.regbytes, self.byteorder)
+
+    def bytes_to_val(self, data: bytes) -> int:
+        return int.from_bytes(data, self.byteorder)
+
+    def read(self, length: int) -> bytes:
+        data = bytearray()
+        for idx in range(0, length, self.regbytes):
+            addr = self.reg_addr + idx
+            val = self.reg_read(addr)
+            logger.debug(f"SMBus read {addr=:#02x} {val=:#02x}")
+            data += self.val_to_bytes(val)
+        return bytes(data)
+
+    def write(self, data: bytes) -> None:
+        self.reg_addr = data[0]
+
+        if len(data) > 1:
+            length = len(data) - 1
+            data = data[1:]
+            assert length % self.regbytes == 0
+            for idx in range(0, length, self.regbytes):
+                val = self.bytes_to_val(data[idx : (idx + self.regbytes)])
+                addr = self.reg_addr + idx
+                self.backend.mock.reg_write(addr, val)
+                self.reg_write(addr, val)
+                logger.debug(f"SMBus write {addr=:#02x} {val=:#02x}")
+        elif len(data) == 1:
+            pass
+
+
+class SimpleSMBusModel(SMBusModel):
+    def __init__(self, regs: dict[int, int], **kwargs: Any) -> None:
+        super().__init__(**kwargs)
+        self.regs = regs
+
+    def reg_read(self, addr: int) -> int:
+        val = self.regs[addr]
+        return val
+
+    def reg_write(self, addr: int, val: int) -> None:
+        assert addr in self.regs
+        self.regs[addr] = val
diff --git a/tools/testing/roadtest/roadtest/backend/main.py b/tools/testing/roadtest/roadtest/backend/main.py
new file mode 100644
index 000000000000..25be86ded9ea
--- /dev/null
+++ b/tools/testing/roadtest/roadtest/backend/main.py
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright Axis Communications AB
+
+import logging
+
+import roadtest.backend.backend
+
+logging.basicConfig(
+    format="%(asctime)s - %(levelname)s - %(name)s: %(message)s", level=logging.DEBUG
+)
+
+backend = roadtest.backend.backend.Backend()
+backend.process_control()
diff --git a/tools/testing/roadtest/roadtest/backend/mock.py b/tools/testing/roadtest/roadtest/backend/mock.py
new file mode 100644
index 000000000000..8ce33a6bc0f1
--- /dev/null
+++ b/tools/testing/roadtest/roadtest/backend/mock.py
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright Axis Communications AB
+
+import functools
+from pathlib import Path
+from typing import Any, Callable
+
+from roadtest.core.opslog import OpsLogWriter
+
+
+class MockBackend:
+    def __init__(self, work: Path) -> None:
+        self.opslog = OpsLogWriter(work)
+
+    @functools.cache
+    def __getattr__(self, name: str) -> Callable:
+        def func(*args: Any, **kwargs: Any) -> None:
+            self.opslog.write(f"mock.{name}(*{str(args)}, **{str(kwargs)})")
+
+        return func
diff --git a/tools/testing/roadtest/roadtest/backend/test_gpio.py b/tools/testing/roadtest/roadtest/backend/test_gpio.py
new file mode 100644
index 000000000000..feffe4fb9625
--- /dev/null
+++ b/tools/testing/roadtest/roadtest/backend/test_gpio.py
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright Axis Communications AB
+
+import unittest
+from unittest.mock import MagicMock
+
+from .gpio import Gpio
+
+
+class TestGpio(unittest.TestCase):
+    def test_irq_low(self) -> None:
+        m = MagicMock()
+        gpio = Gpio(backend=m, pin=1)
+
+        gpio.set_irq_type(Gpio.IRQ_TYPE_LEVEL_LOW)
+        m.c.trigger_gpio_irq.assert_not_called()
+
+        gpio.unmask()
+        m.c.trigger_gpio_irq.assert_called_once_with(1)
+        m.c.trigger_gpio_irq.reset_mock()
+
+        gpio.set(True)
+        gpio.unmask()
+        m.c.trigger_gpio_irq.assert_not_called()
+
+    def test_irq_high(self) -> None:
+        m = MagicMock()
+        gpio = Gpio(backend=m, pin=2)
+
+        gpio.set_irq_type(Gpio.IRQ_TYPE_LEVEL_HIGH)
+        gpio.unmask()
+
+        m.c.trigger_gpio_irq.assert_not_called()
+
+        gpio.set(True)
+        m.c.trigger_gpio_irq.assert_called_once_with(2)
+        m.c.trigger_gpio_irq.reset_mock()
+
+        gpio.set(False)
+        gpio.unmask()
+        m.c.trigger_gpio_irq.assert_not_called()
+
+    def test_irq_rising(self) -> None:
+        m = MagicMock()
+        gpio = Gpio(backend=m, pin=63)
+
+        gpio.set_irq_type(Gpio.IRQ_TYPE_EDGE_RISING)
+        gpio.set(False)
+        gpio.set(True)
+
+        m.c.trigger_gpio_irq.assert_not_called()
+        gpio.unmask()
+        m.c.trigger_gpio_irq.assert_called_once_with(63)
+        m.c.trigger_gpio_irq.reset_mock()
+
+        gpio.set(False)
+        gpio.set(True)
+
+        gpio.unmask()
+        m.c.trigger_gpio_irq.assert_called_once()
+
+    def test_irq_falling(self) -> None:
+        m = MagicMock()
+        gpio = Gpio(backend=m, pin=0)
+
+        gpio.set_irq_type(Gpio.IRQ_TYPE_EDGE_FALLING)
+        gpio.unmask()
+        gpio.set(False)
+        gpio.set(True)
+        m.c.trigger_gpio_irq.assert_not_called()
+
+        gpio.set(False)
+        m.c.trigger_gpio_irq.assert_called_once_with(0)
+        m.c.trigger_gpio_irq.reset_mock()
+
+        gpio.set(True)
+        gpio.set(False)
+        gpio.set(True)
+        gpio.unmask()
+        m.c.trigger_gpio_irq.assert_called_once()
+
+    def test_irq_both(self) -> None:
+        m = MagicMock()
+        gpio = Gpio(backend=m, pin=32)
+
+        gpio.set_irq_type(Gpio.IRQ_TYPE_EDGE_BOTH)
+        gpio.unmask()
+        gpio.set(False)
+        gpio.set(True)
+        m.c.trigger_gpio_irq.assert_called_once_with(32)
+
+        gpio.set(False)
+        m.c.trigger_gpio_irq.assert_called_once_with(32)
+        m.c.trigger_gpio_irq.reset_mock()
+
+        gpio.set(True)
+        gpio.unmask()
+        m.c.trigger_gpio_irq.assert_called_once_with(32)
diff --git a/tools/testing/roadtest/roadtest/backend/test_i2c.py b/tools/testing/roadtest/roadtest/backend/test_i2c.py
new file mode 100644
index 000000000000..eda4e1a4b80f
--- /dev/null
+++ b/tools/testing/roadtest/roadtest/backend/test_i2c.py
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright Axis Communications AB
+
+import unittest
+from typing import Any
+from unittest.mock import MagicMock
+
+from .i2c import SimpleSMBusModel, SMBusModel
+
+
+class DummyModel(SMBusModel):
+    def __init__(self, *args: Any, **kwargs: Any) -> None:
+        super().__init__(*args, **kwargs)
+        self.regs: dict[int, int] = {}
+
+    def reg_read(self, addr: int) -> int:
+        return self.regs[addr]
+
+    def reg_write(self, addr: int, val: int) -> None:
+        self.regs[addr] = val
+
+
+class TestSMBusModel(unittest.TestCase):
+    def test_1(self) -> None:
+        m = DummyModel(regbytes=1, backend=MagicMock())
+
+        m.write(bytes([0x12, 0x34]))
+        m.write(bytes([0x13, 0xAB, 0xCD]))
+
+        self.assertEqual(m.regs[0x12], 0x34)
+        self.assertEqual(m.regs[0x13], 0xAB)
+        self.assertEqual(m.regs[0x14], 0xCD)
+
+        m.write(bytes([0x12]))
+        self.assertEqual(m.read(1), bytes([0x34]))
+
+        m.write(bytes([0x12]))
+        self.assertEqual(m.read(3), bytes([0x34, 0xAB, 0xCD]))
+
+    def test_2big(self) -> None:
+        m = DummyModel(regbytes=2, byteorder="big", backend=MagicMock())
+
+        m.write(bytes([0x12, 0x34, 0x56, 0xAB, 0xCD]))
+        self.assertEqual(m.regs[0x12], 0x3456)
+        self.assertEqual(m.regs[0x14], 0xABCD)
+
+        m.write(bytes([0x12]))
+        self.assertEqual(m.read(2), bytes([0x34, 0x56]))
+
+        m.write(bytes([0x14]))
+        self.assertEqual(m.read(2), bytes([0xAB, 0xCD]))
+
+        m.write(bytes([0x12]))
+        self.assertEqual(m.read(4), bytes([0x34, 0x56, 0xAB, 0xCD]))
+
+    def test_2little(self) -> None:
+        m = DummyModel(regbytes=2, byteorder="little", backend=MagicMock())
+
+        m.write(bytes([0x12, 0x34, 0x56, 0xAB, 0xCD]))
+        self.assertEqual(m.regs[0x12], 0x5634)
+        self.assertEqual(m.regs[0x14], 0xCDAB)
+
+        m.write(bytes([0x12]))
+        self.assertEqual(m.read(2), bytes([0x34, 0x56]))
+
+
+class TestSimpleSMBusModel(unittest.TestCase):
+    def test_simple(self) -> None:
+        m = SimpleSMBusModel(
+            regs={0x01: 0x12, 0x02: 0x34},
+            regbytes=1,
+            backend=MagicMock(),
+        )
+        self.assertEqual(m.reg_read(0x01), 0x12)
+        self.assertEqual(m.reg_read(0x02), 0x34)
+
+        m.reg_write(0x01, 0x56)
+        self.assertEqual(m.reg_read(0x01), 0x56)
+        self.assertEqual(m.reg_read(0x02), 0x34)
+
+        with self.assertRaises(Exception):
+            m.reg_write(0x03, 0x00)
+        with self.assertRaises(Exception):
+            m.reg_read(0x03)
diff --git a/tools/testing/roadtest/roadtest/cmd/__init__.py b/tools/testing/roadtest/roadtest/cmd/__init__.py
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tools/testing/roadtest/roadtest/cmd/main.py b/tools/testing/roadtest/roadtest/cmd/main.py
new file mode 100644
index 000000000000..634c27fe795c
--- /dev/null
+++ b/tools/testing/roadtest/roadtest/cmd/main.py
@@ -0,0 +1,146 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright Axis Communications AB
+
+import argparse
+import fnmatch
+import sys
+import unittest
+from typing import Optional
+from unittest.suite import TestSuite
+
+assert sys.version_info >= (3, 9), "Python version is too old"
+
+from roadtest.core.suite import UMLSuite, UMLTestCase
+
+
+def make_umlsuite(args: argparse.Namespace) -> UMLSuite:
+    return UMLSuite(
+        timeout=args.timeout,
+        workdir=args.work_dir,
+        builddir=args.build_dir,
+        ksrcdir=args.ksrc_dir,
+        uml_args_pre=args.uml_prepend,
+        uml_args_post=args.uml_append,
+        shell=args.shell,
+    )
+
+
+def main() -> None:
+    parser = argparse.ArgumentParser()
+    parser.add_argument(
+        "--timeout",
+        type=int,
+        default=60,
+        help="Timeout (in seconds) for each UML run, 0 to disable",
+    )
+    parser.add_argument("--work-dir", type=str, help="Work directory for UML runs")
+    parser.add_argument("--build-dir", type=str, required=True)
+    parser.add_argument("--ksrc-dir", type=str, required=True)
+    parser.add_argument(
+        "--uml-prepend",
+        nargs="*",
+        default=[],
+        help="Extra arguments to prepend to the UML command (example: gdbserver :1234)",
+    )
+    parser.add_argument(
+        "--uml-append",
+        nargs="*",
+        default=[],
+        help="Extra arguments to append to the UML command (example: trace_event=i2c:* tp_printk)",
+    )
+    parser.add_argument(
+        "--filter",
+        nargs="+",
+        default=[],
+    )
+    parser.add_argument("--shell", action="store_true")
+    parser.add_argument("test", nargs="?", default="roadtest")
+    args = parser.parse_args()
+
+    if args.shell:
+        args.timeout = 0
+
+        if not any(p.startswith("con=") for p in args.uml_append):
+            print(
+                "Error: --shell used but no con= UML argument specified",
+                file=sys.stderr,
+            )
+            sys.exit(1)
+
+    test = args.test
+    test = test.replace("/", ".")
+    test = test.removesuffix(".py")
+    test = test.removesuffix(".")
+
+    loader = unittest.defaultTestLoader
+    suitegroups = loader.discover(test)
+
+    args.filter = [f"*{f}*" for f in args.filter]
+
+    # Backend tests and the like don't need to be run inside UML.
+    localsuite = None
+
+    # For simplicity, we currently run all target tests in one UML instance
+    # since python in UML is slow to start up.  This can be revisited if we
+    # want to run several UML instances in parallel.
+    deftargetsuite = None
+    targetsuites = []
+
+    for suites in suitegroups:
+        # unittest can in arbitrarily nest and mix TestCases
+        # and TestSuites, but we expect a fixed hierarchy.
+        assert isinstance(suites, unittest.TestSuite)
+
+        for suite in suites:
+            # assert not isinstance(suite, unittest.TestCase)
+
+            # If the import of a test fails, then suite is a
+            # unittest.loader._FailedTest instead of a suite
+            if not isinstance(suite, unittest.TestSuite):
+                suite = [suite]  # type: ignore[assignment]
+
+            # Suite at this level contains one TestCase for each
+            # test method in a particular test class.
+            #
+            # All the test functions for one particular test class
+            # can only be run either in UML or locally, not mixed.
+            destsuite: Optional[TestSuite] = None
+
+            for t in suite:  # type: ignore[union-attr]
+                # We don't support suites nested at this level.
+                assert isinstance(t, unittest.TestCase)
+
+                id = t.id()
+                if args.filter and not any(fnmatch.fnmatch(id, f) for f in args.filter):
+                    continue
+
+                if isinstance(t, UMLTestCase):
+                    if t.run_separately:
+                        if not destsuite:
+                            destsuite = make_umlsuite(args)
+                            targetsuites.append(destsuite)
+                    else:
+                        if not deftargetsuite:
+                            deftargetsuite = make_umlsuite(args)
+                            targetsuites.append(deftargetsuite)
+
+                        destsuite = deftargetsuite
+                else:
+                    if not localsuite:
+                        localsuite = TestSuite()
+                    destsuite = localsuite
+
+                if destsuite:
+                    destsuite.addTest(t)
+
+    tests = unittest.TestSuite()
+    if localsuite:
+        tests.addTest(localsuite)
+    tests.addTests(targetsuites)
+
+    result = unittest.TextTestRunner(verbosity=2).run(tests)
+    sys.exit(not result.wasSuccessful())
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/roadtest/roadtest/cmd/remote.py b/tools/testing/roadtest/roadtest/cmd/remote.py
new file mode 100644
index 000000000000..29c3c6d35c65
--- /dev/null
+++ b/tools/testing/roadtest/roadtest/cmd/remote.py
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright Axis Communications AB
+
+import importlib
+import json
+import os
+from pathlib import Path
+from typing import cast
+from unittest import TestSuite, TextTestRunner
+
+from roadtest import ENV_WORK_DIR
+from roadtest.core import proxy
+
+
+def main() -> None:
+    workdir = Path(os.environ[ENV_WORK_DIR])
+    with open(workdir / "tests.json") as f:
+        testinfos = json.load(f)
+
+    suite = TestSuite()
+    for info in testinfos:
+        id = info["id"]
+        *modparts, clsname, method = id.split(".")
+
+        fullname = ".".join(modparts)
+        mod = importlib.import_module(fullname)
+
+        cls = getattr(mod, clsname)
+        test = cls(methodName=method)
+
+        values = info["values"]
+        if values:
+            test.dts.values = values
+
+        suite.addTest(test)
+
+    runner = TextTestRunner(
+        verbosity=0, buffer=False, resultclass=proxy.ProxyTextTestResult
+    )
+    result = cast(proxy.ProxyTextTestResult, runner.run(suite))
+
+    proxyresult = result.to_proxy()
+    with open(workdir / "results.json", "w") as f:
+        json.dump(proxyresult, f)
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/roadtest/roadtest/core/__init__.py b/tools/testing/roadtest/roadtest/core/__init__.py
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tools/testing/roadtest/roadtest/core/control.py b/tools/testing/roadtest/roadtest/core/control.py
new file mode 100644
index 000000000000..cd74861099b9
--- /dev/null
+++ b/tools/testing/roadtest/roadtest/core/control.py
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright Axis Communications AB
+
+import logging
+import os
+from pathlib import Path
+from typing import Optional
+
+from roadtest import ENV_WORK_DIR
+
+CONTROL_FILE = "control.txt"
+
+logger = logging.getLogger(__name__)
+
+
+class ControlReader:
+    def __init__(self, work_dir: Optional[Path] = None) -> None:
+        if not work_dir:
+            work_dir = Path(os.environ[ENV_WORK_DIR])
+
+        path = work_dir / CONTROL_FILE
+        path.unlink(missing_ok=True)
+        path.write_text("")
+
+        self.file = path.open("r")
+
+    def process(self, vars: dict) -> None:
+        for line in self.file.readlines():
+            cmd = line.rstrip()
+
+            if cmd.startswith("# "):
+                logger.info(line[2:].rstrip())
+                continue
+
+            logger.debug(cmd)
+            eval(cmd, vars)
+
+
+class ControlWriter:
+    def __init__(self, work_dir: Optional[Path] = None) -> None:
+        if not work_dir:
+            work_dir = Path(os.environ[ENV_WORK_DIR])
+        self.file = (work_dir / CONTROL_FILE).open("a", buffering=1)
+
+    def write_cmd(self, line: str) -> None:
+        self.file.write(line + "\n")
+
+    def write_log(self, line: str) -> None:
+        self.file.write(f"# {line}\n")
+
+    def close(self) -> None:
+        self.file.close()
diff --git a/tools/testing/roadtest/roadtest/core/devicetree.py b/tools/testing/roadtest/roadtest/core/devicetree.py
new file mode 100644
index 000000000000..40876738fb39
--- /dev/null
+++ b/tools/testing/roadtest/roadtest/core/devicetree.py
@@ -0,0 +1,155 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright Axis Communications AB
+
+import enum
+import subprocess
+from pathlib import Path
+from typing import Any, Optional
+
+HEADER = """
+/dts-v1/;
+
+/ {
+    #address-cells = <2>;
+    #size-cells = <2>;
+
+    virtio@0 {
+        compatible = "virtio,uml";
+        socket-path = "WORK/gpio.sock";
+        virtio-device-id = <0x29>;
+
+        gpio: gpio {
+            compatible = "virtio,device29";
+
+            gpio-controller;
+            #gpio-cells = <2>;
+
+            interrupt-controller;
+            #interrupt-cells = <2>;
+        };
+    };
+
+    virtio@1 {
+        compatible = "virtio,uml";
+        socket-path = "WORK/i2c.sock";
+        virtio-device-id = <0x22>;
+
+        i2c: i2c {
+            compatible = "virtio,device22";
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+        };
+    };
+
+    // See Hardware.kick()
+    leds {
+        compatible = "gpio-leds";
+        led0 {
+            gpios = <&gpio 0 0>;
+        };
+    };
+};
+"""
+
+
+class DtVar(enum.Enum):
+    I2C_ADDR = 0
+    GPIO_PIN = 1
+
+
+class DtFragment:
+    def __init__(self, src: str, variables: Optional[dict[str, DtVar]] = None) -> None:
+        self.src = src
+        if not variables:
+            variables = {}
+        self.variables = variables
+        self.values: dict[str, int] = {}
+
+    def apply(self, values: dict[str, Any]) -> str:
+        src = self.src
+
+        for var in self.variables.keys():
+            typ = self.variables[var]
+            val = values[var]
+
+            if typ == DtVar.I2C_ADDR:
+                str = f"{val:02x}"
+            elif typ == DtVar.GPIO_PIN:
+                str = f"{val:d}"
+
+            src = src.replace(f"${var}$", str)
+
+        self.values = values
+        return src
+
+    def __getitem__(self, key: str) -> Any:
+        return self.values[key]
+
+
+class Devicetree:
+    def __init__(self, workdir: Path, ksrcdir: Path) -> None:
+        self.workdir: Path = workdir
+        self.ksrcdir: Path = ksrcdir
+        self.next_i2c_addr: int = 0x1
+        # 0 is used for gpio-leds for Hardware.kick()
+        self.next_gpio_pin: int = 1
+        self.src: str = ""
+
+    def assemble(self, fragments: list[DtFragment]) -> None:
+        parts = []
+        for fragment in fragments:
+            if fragment.values:
+                # Multiple test functions from the same class will use
+                # the same class instance
+                continue
+
+            values = {}
+
+            for var, type in fragment.variables.items():
+                if type == DtVar.I2C_ADDR:
+                    values[var] = self.next_i2c_addr
+                    self.next_i2c_addr += 1
+                elif type == DtVar.GPIO_PIN:
+                    values[var] = self.next_gpio_pin
+                    self.next_gpio_pin += 1
+
+            parts.append(fragment.apply(values))
+
+        self.src = "\n".join(parts)
+
+    def compile(self, dtb: str) -> None:
+        dts = self.workdir / "test.dts"
+
+        try:
+            subprocess.run(
+                [
+                    "gcc",
+                    "-E",
+                    "-nostdinc",
+                    f"-I{self.ksrcdir}/scripts/dtc/include-prefixes",
+                    "-undef",
+                    "-D__DTS__",
+                    "-x",
+                    "assembler-with-cpp",
+                    "-o",
+                    dts,
+                    "-",
+                ],
+                input=self.src,
+                text=True,
+                check=True,
+                capture_output=True,
+            )
+
+            full = HEADER.replace("WORK", str(self.workdir)) + dts.read_text()
+            dts.write_text(full)
+
+            subprocess.run(
+                ["dtc", "-I", "dts", "-O", "dtb", dts, "-o", self.workdir / dtb],
+                check=True,
+                capture_output=True,
+                text=True,
+            )
+        except subprocess.CalledProcessError as e:
+            raise Exception(f"{e.stderr}")
diff --git a/tools/testing/roadtest/roadtest/core/hardware.py b/tools/testing/roadtest/roadtest/core/hardware.py
new file mode 100644
index 000000000000..ae81a531d2a2
--- /dev/null
+++ b/tools/testing/roadtest/roadtest/core/hardware.py
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright Axis Communications AB
+
+import contextlib
+import functools
+import os
+from pathlib import Path
+from typing import Any, Callable, Optional, Type, cast
+from unittest import TestCase
+from unittest.mock import MagicMock, call
+
+from roadtest import ENV_WORK_DIR
+
+from .control import ControlWriter
+from .opslog import OpsLogReader
+from .sysfs import write_int
+
+
+class HwMock(MagicMock):
+    def assert_reg_write_once(self, test: TestCase, reg: int, value: int) -> None:
+        test.assertEqual(
+            [c for c in self.mock_calls if c.args[0] == reg],
+            [call.reg_write(reg, value)],
+        )
+
+    def assert_last_reg_write(self, test: TestCase, reg: int, value: int) -> None:
+        test.assertEqual(
+            [c for c in self.mock_calls if c.args[0] == reg][-1:],
+            [call.reg_write(reg, value)],
+        )
+
+    def get_last_reg_write(self, reg: int) -> int:
+        return cast(int, [c for c in self.mock_calls if c.args[0] == reg][-1].args[1])
+
+
+class Hardware(contextlib.AbstractContextManager):
+    def __init__(self, bus: str, work: Optional[Path] = None) -> None:
+        if not work:
+            work = Path(os.environ[ENV_WORK_DIR])
+
+        self.bus = bus
+        self.mock = HwMock()
+        self.control = ControlWriter(work)
+        self.opslog = OpsLogReader(work)
+        self.loaded_model = False
+
+        # Ignore old entries
+        self.opslog.read_next()
+
+    def _call(self, method: str, *args: Any, **kwargs: Any) -> None:
+        self.control.write_cmd(
+            f"backend.{self.bus}.{method}(*{str(args)}, **{str(kwargs)})"
+        )
+
+    def kick(self) -> None:
+        # Control writes are only applied when the backend gets something
+        # to process, usually because the driver tried to access the device.
+        # But in some cases, such as when the driver is waiting for a
+        # sequence of interrupts, the test code needs the control write to take
+        # effect immediately.  For this, we just need to kick the backend
+        # into processing its control queue.
+        #
+        # We (ab)use gpio-leds for this.  devicetree.py sets up the device.
+        write_int(Path("/sys/class/leds/led0/brightness"), 0)
+
+    def load_model(self, cls: Type[Any], *args: Any, **kwargs: Any) -> "Hardware":
+        self._call("load_model", cls.__module__, cls.__name__, *args, **kwargs)
+        self.loaded_model = True
+        return self
+
+    def __enter__(self) -> "Hardware":
+        return self
+
+    def __exit__(self, *_: Any) -> None:
+        self.close()
+
+    @functools.cache
+    def __getattr__(self, name: str) -> Callable:
+        def func(*args: Any, **kwargs: Any) -> None:
+            self._call(name, *args, **kwargs)
+
+        return func
+
+    def close(self) -> None:
+        if self.loaded_model:
+            self._call("unload_model")
+        self.control.close()
+
+    def update_mock(self) -> HwMock:
+        opslog = self.opslog.read_next()
+        for line in opslog:
+            eval(line, {"mock": self.mock})
+
+        return self.mock
diff --git a/tools/testing/roadtest/roadtest/core/log.py b/tools/testing/roadtest/roadtest/core/log.py
new file mode 100644
index 000000000000..7d73e40eb2d8
--- /dev/null
+++ b/tools/testing/roadtest/roadtest/core/log.py
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright Axis Communications AB
+
+from pathlib import Path
+
+
+class LogParser:
+    DNF_MESSAGE = "<Test did not finish cleanly>"
+
+    def __init__(self, file: Path):
+        try:
+            raw = file.read_text()
+            lines = raw.splitlines()
+        except FileNotFoundError:
+            lines = []
+            raw = ""
+
+        self.raw = raw
+        self.lines = lines
+
+    def has_any(self) -> bool:
+        return "START<" in self.raw
+
+    def get_testcase_log(self, id: str) -> list[str]:
+        startmarker = f"START<{id}>"
+        stopmarker = f"STOP<{id}>"
+
+        try:
+            startpos = next(
+                i for i, line in enumerate(self.lines) if startmarker in line
+            )
+        except StopIteration:
+            return []
+
+        try:
+            stoppos = next(
+                i for i, line in enumerate(self.lines[startpos:]) if stopmarker in line
+            )
+        except StopIteration:
+            return self.lines[startpos + 1 :] + [LogParser.DNF_MESSAGE]
+
+        return self.lines[startpos + 1 : startpos + stoppos]
diff --git a/tools/testing/roadtest/roadtest/core/modules.py b/tools/testing/roadtest/roadtest/core/modules.py
new file mode 100644
index 000000000000..5bd2d92a322b
--- /dev/null
+++ b/tools/testing/roadtest/roadtest/core/modules.py
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright Axis Communications AB
+
+import os
+import subprocess
+from pathlib import Path
+from typing import Any
+
+from roadtest import ENV_BUILD_DIR
+
+
+def modprobe(modname: str, remove: bool = False) -> None:
+    moddir = Path(os.environ[ENV_BUILD_DIR]) / "modules"
+    args = []
+    if remove:
+        args.append("--remove")
+    args += [f"--dirname={moddir}", modname]
+    subprocess.check_output(["/sbin/modprobe"] + args)
+
+
+def insmod(modname: str) -> None:
+    modprobe(modname)
+
+
+def rmmod(modname: str) -> None:
+    subprocess.check_output(["/sbin/rmmod", modname])
+
+
+class Module:
+    def __init__(self, name: str) -> None:
+        self.name = name
+
+    def __enter__(self) -> "Module":
+        modprobe(self.name)
+        return self
+
+    def __exit__(self, *_: Any) -> None:
+        rmmod(self.name)
diff --git a/tools/testing/roadtest/roadtest/core/opslog.py b/tools/testing/roadtest/roadtest/core/opslog.py
new file mode 100644
index 000000000000..83bb4f525d03
--- /dev/null
+++ b/tools/testing/roadtest/roadtest/core/opslog.py
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright Axis Communications AB
+
+import os
+from pathlib import Path
+
+OPSLOG_FILE = "opslog.txt"
+
+
+class OpsLogWriter:
+    def __init__(self, work: Path) -> None:
+        path = work / OPSLOG_FILE
+        path.unlink(missing_ok=True)
+        self.file = open(path, "a", buffering=1)
+
+    def write(self, line: str) -> None:
+        self.file.write(line + "\n")
+
+
+class OpsLogReader:
+    def __init__(self, work: Path) -> None:
+        self.path = work / OPSLOG_FILE
+        self.opslogpos = 0
+
+    def read_next(self) -> list[str]:
+        # There is a problem in hostfs (see Hostfs Caveats) which means
+        # that reads from UML on a file which is extended on the host don't see
+        # the new data unless we open and close the file, so we can't open once
+        # and use readlines().
+        with open(self.path, "r") as f:
+            os.lseek(f.fileno(), self.opslogpos, os.SEEK_SET)
+            opslog = [line.rstrip() for line in f.readlines()]
+            self.opslogpos = os.lseek(f.fileno(), 0, os.SEEK_CUR)
+
+        return opslog
diff --git a/tools/testing/roadtest/roadtest/core/proxy.py b/tools/testing/roadtest/roadtest/core/proxy.py
new file mode 100644
index 000000000000..36089e21d7d5
--- /dev/null
+++ b/tools/testing/roadtest/roadtest/core/proxy.py
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright Axis Communications AB
+
+from typing import Any
+from unittest import TestCase, TextTestResult
+
+from . import control
+
+
+class ProxyTextTestResult(TextTestResult):
+    def __init__(self, stream: Any, descriptions: Any, verbosity: Any) -> None:
+        super().__init__(stream, descriptions, verbosity)
+        self.successes: list[tuple[TestCase, str]] = []
+
+        # Print via kmsg to avoid getting cut off by other kernel prints.
+        self.kmsg = open("/dev/kmsg", "w", buffering=1)
+        self.control = control.ControlWriter()
+
+    def addSuccess(self, test: TestCase) -> None:
+        super().addSuccess(test)
+        self.successes.append((test, ""))
+
+    def _log(self, test: TestCase, action: str) -> None:
+        line = f"{action}<{test.id()}>"
+        self.kmsg.write(line + "\n")
+        self.control.write_log(line)
+
+    def startTest(self, test: TestCase) -> None:
+        self._log(test, "START")
+        super().startTest(test)
+
+    def stopTest(self, test: TestCase) -> None:
+        super().stopTest(test)
+        self._log(test, "STOP")
+
+    def _replace_id(self, reslist: list[tuple[TestCase, str]]) -> list[tuple[str, str]]:
+        return [(case.id(), tb) for case, tb in reslist]
+
+    def to_proxy(self) -> dict[str, Any]:
+        return {
+            "testsRun": self.testsRun,
+            "wasSuccessful": self.wasSuccessful(),
+            "successes": self._replace_id(self.successes),
+            "errors": self._replace_id(self.errors),
+            "failures": self._replace_id(self.failures),
+            "skipped": self._replace_id(self.skipped),
+            "unexpectedSuccesses": [t.id() for t in self.unexpectedSuccesses],
+        }
diff --git a/tools/testing/roadtest/roadtest/core/suite.py b/tools/testing/roadtest/roadtest/core/suite.py
new file mode 100644
index 000000000000..e99a60b4faba
--- /dev/null
+++ b/tools/testing/roadtest/roadtest/core/suite.py
@@ -0,0 +1,286 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright Axis Communications AB
+
+import json
+import os
+import shlex
+import signal
+import subprocess
+import textwrap
+import unittest
+from pathlib import Path
+from typing import Any, ClassVar, Optional, Tuple, cast
+from unittest import TestResult
+
+from roadtest import ENV_BUILD_DIR, ENV_WORK_DIR
+
+from . import devicetree
+from .log import LogParser
+
+
+class UMLTestCase(unittest.TestCase):
+    run_separately: ClassVar[bool] = False
+    dts: ClassVar[Optional[devicetree.DtFragment]] = None
+
+
+class UMLSuite(unittest.TestSuite):
+    def __init__(
+        self,
+        timeout: int,
+        workdir: str,
+        builddir: str,
+        ksrcdir: str,
+        uml_args_pre: list[str],
+        uml_args_post: list[str],
+        shell: bool,
+        *args: Any,
+        **kwargs: Any,
+    ) -> None:
+        super().__init__(*args, **kwargs)
+
+        self.timeout = timeout
+        self.workdir = Path(workdir).resolve()
+        self.builddir = Path(builddir)
+        self.ksrcdir = Path(ksrcdir)
+        self.uml_args_pre = uml_args_pre
+        self.uml_args_post = uml_args_post
+        self.shell = shell
+
+        self.backendlog = self.workdir / "backend.txt"
+        self.umllog = self.workdir / "uml.txt"
+
+        # Used from the roadtest.cmd.remote running inside UML
+        self.testfile = self.workdir / "tests.json"
+        self.resultfile = self.workdir / "results.json"
+
+    def run(
+        self, result: unittest.TestResult, debug: bool = False
+    ) -> unittest.TestResult:
+        pwd = os.getcwd()
+
+        os.makedirs(self.workdir, exist_ok=True)
+        workdir = self.workdir
+
+        tests = cast(list[UMLTestCase], list(self))
+
+        os.environ[ENV_WORK_DIR] = str(workdir)
+        os.environ[ENV_BUILD_DIR] = str(self.builddir)
+
+        dt = devicetree.Devicetree(workdir=workdir, ksrcdir=self.ksrcdir)
+        dt.assemble([test.dts for test in tests if test.dts])
+        dt.compile("test.dtb")
+
+        testinfos = []
+        ids = []
+        for t in tests:
+            id = t.id()
+            # This fixup is needed when discover is done starting from "roadtest"
+            if not id.startswith("roadtest."):
+                id = f"roadtest.{id}"
+            ids.append(id)
+
+            testinfos.append({"id": id, "values": t.dts.values if t.dts else {}})
+
+        with self.testfile.open("w") as f:
+            json.dump(testinfos, f)
+
+        uml_args = [
+            str(self.builddir / "vmlinux"),
+            f"PYTHONPATH={pwd}",
+            f"{ENV_WORK_DIR}={workdir}",
+            f"{ENV_BUILD_DIR}={self.builddir}",
+            # Should be enough for anybody?
+            "mem=64M",
+            "dtb=test.dtb",
+            "rootfstype=hostfs",
+            "rw",
+            f"init={pwd}/init.sh",
+            f"uml_dir={workdir}",
+            "umid=uml",
+            # ProxyTextTestResult writes to /dev/kmsg
+            "printk.devkmsg=on",
+            "slub_debug",
+            # For ease of debugging
+            "no_hash_pointers",
+        ]
+
+        if self.shell:
+            # See init.sh
+            uml_args += ["ROADTEST_SHELL=1"]
+        else:
+            # Set by slub_debug
+            TAINT_BAD_PAGE = 1 << 5
+            uml_args += [
+                # init.sh increases the loglevel after bootup.
+                "quiet",
+                "panic_on_warn=1",
+                f"panic_on_taint={TAINT_BAD_PAGE}",
+                "oops=panic",
+                # Speeds up delays, but as a consequence also causes
+                # 100% CPU consumption at an idle shell prompt.
+                "time-travel",
+            ]
+
+        main_script = (Path(__file__).parent / "../backend/main.py").resolve()
+
+        args = (
+            [
+                str(self.builddir / "roadtest-backend"),
+                # The socket locations are also present in the devicetree.
+                f"--gpio-socket={workdir}/gpio.sock",
+                f"--i2c-socket={workdir}/i2c.sock",
+                f"--main-script={main_script}",
+                "--",
+            ]
+            + self.uml_args_pre
+            + uml_args
+            + self.uml_args_post
+        )
+
+        print(
+            "Running backend/UML with: {}".format(
+                " ".join([shlex.quote(a) for a in args])
+            )
+        )
+
+        # Truncate instead of deleting so that tail -f can be used to monitor
+        # the log across runs.
+        self.backendlog.write_text("")
+        self.umllog.write_text("")
+        self.resultfile.unlink(missing_ok=True)
+
+        umlpidfile = workdir / "uml/pid"
+        umlpidfile.unlink(missing_ok=True)
+
+        newenv = dict(os.environ, PYTHONPATH=pwd)
+
+        try:
+            process = None
+            with self.backendlog.open("w") as f:
+                process = subprocess.Popen(
+                    args,
+                    env=newenv,
+                    stdin=subprocess.PIPE,
+                    stdout=f,
+                    stderr=subprocess.STDOUT,
+                    text=True,
+                    preexec_fn=os.setsid,
+                )
+                process.wait(self.timeout if self.timeout else None)
+        except subprocess.TimeoutExpired:
+            pass
+        finally:
+            try:
+                if process:
+                    os.killpg(process.pid, signal.SIGKILL)
+            except ProcessLookupError:
+                pass
+            try:
+                pid = int(umlpidfile.read_text())
+                os.killpg(pid, signal.SIGKILL)
+            except (FileNotFoundError, ProcessLookupError):
+                pass
+
+        if process and process.returncode is not None and process.returncode != 0:
+            with self.backendlog.open("a") as f:
+                f.write(f"<Backend exited with error code {process.returncode}>\n")
+
+        try:
+            with self.resultfile.open("r") as f:
+                proxy = json.load(f)
+        except FileNotFoundError:
+            # UML crashed, timed out, etc
+            proxy = None
+
+        return self._convert_results(proxy, tests, result)
+
+    def _parse_status(self, id: str, proxy: dict) -> Tuple[str, str]:
+        if not proxy:
+            return "ERROR", "No result.  UML or backend crashed?\n"
+
+        try:
+            _, tb = next(e for e in proxy["successes"] if e[0] == id)
+            return "ok", ""
+        except StopIteration:
+            pass
+
+        try:
+            _, tb = next(e for e in proxy["errors"] if e[0] == id)
+            return "ERROR", tb
+        except StopIteration:
+            pass
+
+        try:
+            _, tb = next(e for e in proxy["failures"] if e[0] == id)
+            return "FAIL", tb
+        except StopIteration:
+            pass
+
+        # setupClass, etc
+        if proxy["errors"]:
+            _, tb = proxy["errors"][0]
+            return "ERROR", tb
+
+        raise Exception("Unable to parse status")
+
+    def _get_log(
+        self, name: str, parser: LogParser, id: str, full_if_none: bool
+    ) -> Optional[str]:
+        testloglines = parser.get_testcase_log(id)
+        tb = None
+        if testloglines:
+            tb = "\n".join([f"{name} log:"] + [" " + line for line in testloglines])
+        elif full_if_none and not parser.has_any():
+            if parser.raw:
+                tb = "\n".join(
+                    [f"Full {name} log:", textwrap.indent(parser.raw, " ").rstrip()]
+                )
+            else:
+                tb = f"\nNo {name} log found."
+
+        return tb
+
+    def _convert_results(
+        self,
+        proxy: dict,
+        tests: list[UMLTestCase],
+        result: TestResult,
+    ) -> TestResult:
+        umllog = LogParser(self.umllog)
+        backendlog = LogParser(self.backendlog)
+
+        first_fail = True
+        for test in tests:
+            assert isinstance(test, unittest.TestCase)
+
+            id = test.id()
+            if not id.startswith("roadtest."):
+                id = f"roadtest.{id}"
+
+            status, tb = self._parse_status(id, proxy)
+            if status != "ok":
+                parts = []
+
+                backendtb = self._get_log("Backend", backendlog, id, first_fail)
+                if backendtb:
+                    parts.append(backendtb)
+
+                umltb = self._get_log("UML", umllog, id, first_fail)
+                if umltb:
+                    parts.append(umltb)
+
+                # In the case of no START/STOP markers at all in the logs, we include
+                # the full logs, but only do it in the first failing test case to
+                # reduce noise.
+                first_fail = False
+                tb = "\n\n".join(parts + [tb])
+
+            if status == "ERROR":
+                result.errors.append((test, tb))
+            elif status == "FAIL":
+                result.failures.append((test, tb))
+
+            print(f"{test} ... {status}")
+            result.testsRun += 1
+
+        return result
diff --git a/tools/testing/roadtest/roadtest/core/sysfs.py b/tools/testing/roadtest/roadtest/core/sysfs.py
new file mode 100644
index 000000000000..64228978718e
--- /dev/null
+++ b/tools/testing/roadtest/roadtest/core/sysfs.py
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright Axis Communications AB
+
+import contextlib
+from pathlib import Path
+from typing import Iterator
+
+
+# Path.write_text() is inappropriate since Python calls write(2)
+# a second time if the first one returns an error, if the file
+# was opened as text.
+def write_str(path: Path, val: str) -> None:
+    path.write_bytes(val.encode())
+
+
+def write_int(path: Path, val: int) -> None:
+    write_str(path, str(val))
+
+
+def write_float(path: Path, val: float) -> None:
+    write_str(path, str(val))
+
+
+def read_str(path: Path) -> str:
+    return path.read_text().rstrip()
+
+
+def read_int(path: Path) -> int:
+    return int(read_str(path))
+
+
+def read_float(path: Path) -> float:
+    return float(read_str(path))
+
+
+class I2CDevice:
+    def __init__(self, addr: int, bus: int = 0) -> None:
+        self.id = f"{bus}-{addr:04x}"
+        self.path = Path(f"/sys/bus/i2c/devices/{self.id}")
+
+
+class PlatformDevice:
+    def __init__(self, name: str) -> None:
+        self.id = name
+        self.path = Path(f"/sys/bus/platform/devices/{self.id}")
+
+
+class I2CDriver:
+    def __init__(self, driver: str) -> None:
+        self.driver = driver
+        self.path = Path(f"/sys/bus/i2c/drivers/{driver}")
+
+    @contextlib.contextmanager
+    def bind(self, addr: int, bus: int = 0) -> Iterator[I2CDevice]:
+        dev = I2CDevice(addr, bus)
+        write_str(self.path / "bind", dev.id)
+
+        try:
+            yield dev
+        finally:
+            write_str(self.path / "unbind", dev.id)
+
+
+class PlatformDriver:
+    def __init__(self, driver: str) -> None:
+        self.driver = driver
+        self.path = Path(f"/sys/bus/platform/drivers/{driver}")
+
+    @contextlib.contextmanager
+    def bind(self, addr: str) -> Iterator[PlatformDevice]:
+        dev = PlatformDevice(addr)
+        write_str(self.path / "bind", dev.id)
+
+        try:
+            yield dev
+        finally:
+            write_str(self.path / "unbind", dev.id)
diff --git a/tools/testing/roadtest/roadtest/core/test_control.py b/tools/testing/roadtest/roadtest/core/test_control.py
new file mode 100644
index 000000000000..a8cf9105eb52
--- /dev/null
+++ b/tools/testing/roadtest/roadtest/core/test_control.py
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright Axis Communications AB
+
+from pathlib import Path
+from tempfile import TemporaryDirectory
+from unittest import TestCase
+
+from .control import ControlReader, ControlWriter
+
+
+class TestControl(TestCase):
+    def test_control(self) -> None:
+        with TemporaryDirectory() as tmpdir:
+            work = Path(tmpdir)
+            reader = ControlReader(work)
+            writer = ControlWriter(work)
+
+            values = []
+
+            def append(new: int) -> None:
+                nonlocal values
+                values.append(new)
+
+            vars = {"append": append}
+            writer.write_cmd("append(1)")
+
+            reader.process(vars)
+            self.assertEqual(values, [1])
+
+            writer.write_cmd("append(2)")
+            writer.write_log("append(4)")
+            writer.write_cmd("append(3)")
+
+            reader.process(vars)
+            self.assertEqual(values, [1, 2, 3])
diff --git a/tools/testing/roadtest/roadtest/core/test_devicetree.py b/tools/testing/roadtest/roadtest/core/test_devicetree.py
new file mode 100644
index 000000000000..db61fd24b39a
--- /dev/null
+++ b/tools/testing/roadtest/roadtest/core/test_devicetree.py
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright Axis Communications AB
+
+import tempfile
+import unittest
+from pathlib import Path
+
+from . import devicetree
+
+
+class TestDevicetree(unittest.TestCase):
+    def test_compile(self) -> None:
+        with tempfile.TemporaryDirectory() as tmp:
+            tmpdir = Path(tmp)
+            # We don't have the ksrcdir so we can't test if includes work.
+            dt = devicetree.Devicetree(tmpdir, tmpdir)
+
+            dt.assemble(
+                [
+                    devicetree.DtFragment(
+                        src="""
+&i2c {
+    foo = <1>;
+};
+            """
+                    )
+                ]
+            )
+            dt.compile("test.dtb")
+            dtb = tmpdir / "test.dtb"
+            self.assertTrue((dtb).exists())
diff --git a/tools/testing/roadtest/roadtest/core/test_hardware.py b/tools/testing/roadtest/roadtest/core/test_hardware.py
new file mode 100644
index 000000000000..eb09b317e258
--- /dev/null
+++ b/tools/testing/roadtest/roadtest/core/test_hardware.py
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright Axis Communications AB
+
+from pathlib import Path
+from tempfile import TemporaryDirectory
+from unittest import TestCase
+
+from roadtest.backend.mock import MockBackend
+
+from .hardware import Hardware
+
+
+class TestHardware(TestCase):
+    def test_mock(self) -> None:
+        with TemporaryDirectory() as tmpdir:
+            work = Path(tmpdir)
+
+            backend = MockBackend(work)
+            hw = Hardware(bus="dummy", work=work)
+
+            backend.reg_write(0x1, 0xDEAD)
+            backend.reg_write(0x2, 0xBEEF)
+            mock = hw.update_mock()
+            mock.assert_reg_write_once(self, 0x1, 0xDEAD)
+
+            backend.reg_write(0x1, 0xCAFE)
+            mock = hw.update_mock()
+            with self.assertRaises(AssertionError):
+                mock.assert_reg_write_once(self, 0x1, 0xDEAD)
+
+            mock.assert_last_reg_write(self, 0x1, 0xCAFE)
+
+            self.assertEqual(mock.get_last_reg_write(0x1), 0xCAFE)
+            self.assertEqual(mock.get_last_reg_write(0x2), 0xBEEF)
+
+            with self.assertRaises(IndexError):
+                self.assertEqual(mock.get_last_reg_write(0x3), 0x0)
+
+            mock.reset_mock()
+            with self.assertRaises(AssertionError):
+                mock.assert_last_reg_write(self, 0x2, 0xBEEF)
diff --git a/tools/testing/roadtest/roadtest/core/test_log.py b/tools/testing/roadtest/roadtest/core/test_log.py
new file mode 100644
index 000000000000..6988ff4419db
--- /dev/null
+++ b/tools/testing/roadtest/roadtest/core/test_log.py
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright Axis Communications AB
+
+from pathlib import Path
+from tempfile import NamedTemporaryFile
+from unittest import TestCase
+
+from .log import LogParser
+
+
+class TestLog(TestCase):
+    def test_parser(self) -> None:
+        with NamedTemporaryFile() as tmpfile:
+            path = Path(tmpfile.name)
+
+            path.write_text(
+                """
+xyz START<finished>
+finished1
+finished2
+STOP<finished>
+START<empty>
+STOP<empty>
+START<foo> monkey STOP<foo>
+START<unfinished>
+unfinished1
+unfinished2"""
+            )
+
+            parser = LogParser(path)
+            self.assertEqual(
+                parser.get_testcase_log("finished"), ["finished1", "finished2"]
+            )
+
+            self.assertEqual(
+                parser.get_testcase_log("unfinished"),
+                ["unfinished1", "unfinished2", LogParser.DNF_MESSAGE],
+            )
+
+            self.assertEqual(
+                parser.get_testcase_log("notpresent"),
+                [],
+            )
+
+            self.assertEqual(
+                parser.get_testcase_log("enpty"),
+                [],
+            )
+
+            # Shouldn't happen since we print from the kernel?
+            self.assertEqual(
+                parser.get_testcase_log("foo"),
+                [],
+            )
diff --git a/tools/testing/roadtest/roadtest/core/test_opslog.py b/tools/testing/roadtest/roadtest/core/test_opslog.py
new file mode 100644
index 000000000000..bd594c587032
--- /dev/null
+++ b/tools/testing/roadtest/roadtest/core/test_opslog.py
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright Axis Communications AB
+
+from pathlib import Path
+from tempfile import TemporaryDirectory
+from unittest import TestCase
+
+from .opslog import OpsLogReader, OpsLogWriter
+
+
+class TestOpsLOg(TestCase):
+    def test_opslog(self) -> None:
+        with TemporaryDirectory() as tmpdir:
+            work = Path(tmpdir)
+            writer = OpsLogWriter(work)
+            reader = OpsLogReader(work)
+
+            self.assertEqual(reader.read_next(), [])
+
+            writer.write("1")
+            writer.write("2")
+
+            self.assertEqual(reader.read_next(), ["1", "2"])
+            self.assertEqual(reader.read_next(), [])
+
+            writer.write("3")
+            self.assertEqual(reader.read_next(), ["3"])
diff --git a/tools/testing/roadtest/roadtest/tests/__init__.py b/tools/testing/roadtest/roadtest/tests/__init__.py
new file mode 100644
index 000000000000..e69de29bb2d1
-- 
2.34.1

