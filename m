Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31BA69B09C
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Feb 2023 17:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjBQQUV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Feb 2023 11:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjBQQUQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Feb 2023 11:20:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D996F7D6
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Feb 2023 08:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676650727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AYZS0Gn1WIPpf33ANhi5QjRrvUnicc/K3UlvygoHZRM=;
        b=Bp0fGB5DdHFIZcQ6wIBqtA+I6/isGA2+lviftY6e9jYAUxw2JGvdrCYtxYDdfAODTghCpZ
        N/mVhsdrQdM8wCX41Hi2Up3eVuTxGoqYH3Ho7+TeLalxEZgdDU5QY9lt5sgvvuxGrZ6y3c
        8+5N/nThbgKT0GAZ0iFSRbWIbb8QvXo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-OjVvDdLOOUK0W-ukcGR8og-1; Fri, 17 Feb 2023 11:18:44 -0500
X-MC-Unique: OjVvDdLOOUK0W-ukcGR8og-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B9193802314;
        Fri, 17 Feb 2023 16:18:43 +0000 (UTC)
Received: from xps-13.local (unknown [10.39.193.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 382C0C15BA0;
        Fri, 17 Feb 2023 16:18:41 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 17 Feb 2023 17:17:56 +0100
Subject: [PATCH 02/11] selftests: hid: import hid-tools hid-core tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-import-hid-tools-tests-v1-2-d1c48590d0ee@redhat.com>
References: <20230217-import-hid-tools-tests-v1-0-d1c48590d0ee@redhat.com>
In-Reply-To: <20230217-import-hid-tools-tests-v1-0-d1c48590d0ee@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Peter Hutterer <peter.hutterer@who-t.net>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676650715; l=27539;
 i=benjamin.tissoires@redhat.com; s=20230215; h=from:subject:message-id;
 bh=sTE4WyarvxEWCk6ipIR5lEt1QvYJr6fLEe7OoVWWw4Y=;
 b=M8pXL91bdk3H7DJmr8+nyGEfBl6WHxKWaeVW+5lJLeUxj+/5VtDLPU2zZlI7r+67H2YOv7EAC
 aDCahEPvy+DCNr/9VkFBBX447j5ddtXro2CC1w8ctC2TwMmskRsTbUC
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

I haven't imported all of hid-tools, the python module, but only the
tests related to the kernel. We can rely on pip to fetch the latest
hid-tools release, and then run the tests directly from the tree.

This should now be easier to request tests when something is not behaving
properly in the HID subsystem.

[0] https://gitlab.freedesktop.org/libevdev/hid-tools

Cc: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 tools/testing/selftests/hid/Makefile               |   2 +
 tools/testing/selftests/hid/hid-core.sh            |   7 +
 tools/testing/selftests/hid/run-hid-tools-tests.sh |  28 ++
 tools/testing/selftests/hid/tests/__init__.py      |   2 +
 tools/testing/selftests/hid/tests/base.py          | 345 +++++++++++++++++++++
 tools/testing/selftests/hid/tests/conftest.py      |  81 +++++
 tools/testing/selftests/hid/tests/test_hid_core.py | 154 +++++++++
 tools/testing/selftests/hid/vmtest.sh              |   2 +-
 8 files changed, 620 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
index 83e8f87d643a..bdcb36d80c8c 100644
--- a/tools/testing/selftests/hid/Makefile
+++ b/tools/testing/selftests/hid/Makefile
@@ -5,6 +5,8 @@ include ../../../build/Build.include
 include ../../../scripts/Makefile.arch
 include ../../../scripts/Makefile.include
 
+TEST_PROGS := hid-core.sh
+
 CXX ?= $(CROSS_COMPILE)g++
 
 HOSTPKG_CONFIG := pkg-config
diff --git a/tools/testing/selftests/hid/hid-core.sh b/tools/testing/selftests/hid/hid-core.sh
new file mode 100755
index 000000000000..5bbabc12c34f
--- /dev/null
+++ b/tools/testing/selftests/hid/hid-core.sh
@@ -0,0 +1,7 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Runs tests for the HID subsystem
+
+export TARGET=test_hid_core.py
+
+bash ./run-hid-tools-tests.sh
diff --git a/tools/testing/selftests/hid/run-hid-tools-tests.sh b/tools/testing/selftests/hid/run-hid-tools-tests.sh
new file mode 100755
index 000000000000..bdae8464da86
--- /dev/null
+++ b/tools/testing/selftests/hid/run-hid-tools-tests.sh
@@ -0,0 +1,28 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Runs tests for the HID subsystem
+
+if ! command -v python3 > /dev/null 2>&1; then
+	echo "hid-tools: [SKIP] python3 not installed"
+	exit 77
+fi
+
+if ! python3 -c "import pytest" > /dev/null 2>&1; then
+	echo "hid: [SKIP/ pytest module not installed"
+	exit 77
+fi
+
+if ! python3 -c "import pytest_tap" > /dev/null 2>&1; then
+	echo "hid: [SKIP/ pytest_tap module not installed"
+	exit 77
+fi
+
+if ! python3 -c "import hidtools" > /dev/null 2>&1; then
+	echo "hid: [SKIP/ hid-tools module not installed"
+	exit 77
+fi
+
+TARGET=${TARGET:=.}
+
+echo TAP version 13
+python3 -u -m pytest $PYTEST_XDIST ./tests/$TARGET --tap-stream --udevd
diff --git a/tools/testing/selftests/hid/tests/__init__.py b/tools/testing/selftests/hid/tests/__init__.py
new file mode 100644
index 000000000000..c940e9275252
--- /dev/null
+++ b/tools/testing/selftests/hid/tests/__init__.py
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+# Just to make sphinx-apidoc document this directory
diff --git a/tools/testing/selftests/hid/tests/base.py b/tools/testing/selftests/hid/tests/base.py
new file mode 100644
index 000000000000..1305cfc9646e
--- /dev/null
+++ b/tools/testing/selftests/hid/tests/base.py
@@ -0,0 +1,345 @@
+#!/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# -*- coding: utf-8 -*-
+#
+# Copyright (c) 2017 Benjamin Tissoires <benjamin.tissoires@gmail.com>
+# Copyright (c) 2017 Red Hat, Inc.
+
+import libevdev
+import os
+import pytest
+import time
+
+import logging
+
+from hidtools.device.base_device import BaseDevice, EvdevMatch, SysfsFile
+from pathlib import Path
+from typing import Final
+
+logger = logging.getLogger("hidtools.test.base")
+
+# application to matches
+application_matches: Final = {
+    # pyright: ignore
+    "Accelerometer": EvdevMatch(
+        req_properties=[
+            libevdev.INPUT_PROP_ACCELEROMETER,
+        ]
+    ),
+    "Game Pad": EvdevMatch(  # in systemd, this is a lot more complex, but that will do
+        requires=[
+            libevdev.EV_ABS.ABS_X,
+            libevdev.EV_ABS.ABS_Y,
+            libevdev.EV_ABS.ABS_RX,
+            libevdev.EV_ABS.ABS_RY,
+            libevdev.EV_KEY.BTN_START,
+        ],
+        excl_properties=[
+            libevdev.INPUT_PROP_ACCELEROMETER,
+        ],
+    ),
+    "Joystick": EvdevMatch(  # in systemd, this is a lot more complex, but that will do
+        requires=[
+            libevdev.EV_ABS.ABS_RX,
+            libevdev.EV_ABS.ABS_RY,
+            libevdev.EV_KEY.BTN_START,
+        ],
+        excl_properties=[
+            libevdev.INPUT_PROP_ACCELEROMETER,
+        ],
+    ),
+    "Key": EvdevMatch(
+        requires=[
+            libevdev.EV_KEY.KEY_A,
+        ],
+        excl_properties=[
+            libevdev.INPUT_PROP_ACCELEROMETER,
+            libevdev.INPUT_PROP_DIRECT,
+            libevdev.INPUT_PROP_POINTER,
+        ],
+    ),
+    "Mouse": EvdevMatch(
+        requires=[
+            libevdev.EV_REL.REL_X,
+            libevdev.EV_REL.REL_Y,
+            libevdev.EV_KEY.BTN_LEFT,
+        ],
+        excl_properties=[
+            libevdev.INPUT_PROP_ACCELEROMETER,
+        ],
+    ),
+    "Pad": EvdevMatch(
+        requires=[
+            libevdev.EV_KEY.BTN_0,
+        ],
+        excludes=[
+            libevdev.EV_KEY.BTN_TOOL_PEN,
+            libevdev.EV_KEY.BTN_TOUCH,
+            libevdev.EV_ABS.ABS_DISTANCE,
+        ],
+        excl_properties=[
+            libevdev.INPUT_PROP_ACCELEROMETER,
+        ],
+    ),
+    "Pen": EvdevMatch(
+        requires=[
+            libevdev.EV_KEY.BTN_STYLUS,
+            libevdev.EV_ABS.ABS_X,
+            libevdev.EV_ABS.ABS_Y,
+        ],
+        excl_properties=[
+            libevdev.INPUT_PROP_ACCELEROMETER,
+        ],
+    ),
+    "Stylus": EvdevMatch(
+        requires=[
+            libevdev.EV_KEY.BTN_STYLUS,
+            libevdev.EV_ABS.ABS_X,
+            libevdev.EV_ABS.ABS_Y,
+        ],
+        excl_properties=[
+            libevdev.INPUT_PROP_ACCELEROMETER,
+        ],
+    ),
+    "Touch Pad": EvdevMatch(
+        requires=[
+            libevdev.EV_KEY.BTN_LEFT,
+            libevdev.EV_ABS.ABS_X,
+            libevdev.EV_ABS.ABS_Y,
+        ],
+        excludes=[libevdev.EV_KEY.BTN_TOOL_PEN, libevdev.EV_KEY.BTN_STYLUS],
+        req_properties=[
+            libevdev.INPUT_PROP_POINTER,
+        ],
+        excl_properties=[
+            libevdev.INPUT_PROP_ACCELEROMETER,
+        ],
+    ),
+    "Touch Screen": EvdevMatch(
+        requires=[
+            libevdev.EV_KEY.BTN_TOUCH,
+            libevdev.EV_ABS.ABS_X,
+            libevdev.EV_ABS.ABS_Y,
+        ],
+        excludes=[libevdev.EV_KEY.BTN_TOOL_PEN, libevdev.EV_KEY.BTN_STYLUS],
+        req_properties=[
+            libevdev.INPUT_PROP_DIRECT,
+        ],
+        excl_properties=[
+            libevdev.INPUT_PROP_ACCELEROMETER,
+        ],
+    ),
+}
+
+
+class UHIDTestDevice(BaseDevice):
+    def __init__(self, name, application, rdesc_str=None, rdesc=None, input_info=None):
+        super().__init__(name, application, rdesc_str, rdesc, input_info)
+        self.application_matches = application_matches
+        if name is None:
+            name = f"uhid test {self.__class__.__name__}"
+        if not name.startswith("uhid test "):
+            name = "uhid test " + self.name
+        self.name = name
+
+
+class BaseTestCase:
+    class TestUhid(object):
+        syn_event = libevdev.InputEvent(libevdev.EV_SYN.SYN_REPORT)  # type: ignore
+        key_event = libevdev.InputEvent(libevdev.EV_KEY)  # type: ignore
+        abs_event = libevdev.InputEvent(libevdev.EV_ABS)  # type: ignore
+        rel_event = libevdev.InputEvent(libevdev.EV_REL)  # type: ignore
+        msc_event = libevdev.InputEvent(libevdev.EV_MSC.MSC_SCAN)  # type: ignore
+
+        # List of kernel modules to load before starting the test
+        # if any module is not available (not compiled), the test will skip.
+        # Each element is a tuple '(kernel driver name, kernel module)',
+        # for example ("playstation", "hid-playstation")
+        kernel_modules = []
+
+        def assertInputEventsIn(self, expected_events, effective_events):
+            effective_events = effective_events.copy()
+            for ev in expected_events:
+                assert ev in effective_events
+                effective_events.remove(ev)
+            return effective_events
+
+        def assertInputEvents(self, expected_events, effective_events):
+            remaining = self.assertInputEventsIn(expected_events, effective_events)
+            assert remaining == []
+
+        @classmethod
+        def debug_reports(cls, reports, uhdev=None, events=None):
+            data = [" ".join([f"{v:02x}" for v in r]) for r in reports]
+
+            if uhdev is not None:
+                human_data = [
+                    uhdev.parsed_rdesc.format_report(r, split_lines=True)
+                    for r in reports
+                ]
+                try:
+                    human_data = [
+                        f'\n\t       {" " * h.index("/")}'.join(h.split("\n"))
+                        for h in human_data
+                    ]
+                except ValueError:
+                    # '/' not found: not a numbered report
+                    human_data = ["\n\t      ".join(h.split("\n")) for h in human_data]
+                data = [f"{d}\n\t ====> {h}" for d, h in zip(data, human_data)]
+
+            reports = data
+
+            if len(reports) == 1:
+                print("sending 1 report:")
+            else:
+                print(f"sending {len(reports)} reports:")
+            for report in reports:
+                print("\t", report)
+
+            if events is not None:
+                print("events received:", events)
+
+        def create_device(self):
+            raise Exception("please reimplement me in subclasses")
+
+        def _load_kernel_module(self, kernel_driver, kernel_module):
+            sysfs_path = Path("/sys/bus/hid/drivers")
+            if kernel_driver is not None:
+                sysfs_path /= kernel_driver
+            else:
+                # special case for when testing all available modules:
+                # we don't know beforehand the name of the module from modinfo
+                sysfs_path = Path("/sys/module") / kernel_module.replace("-", "_")
+            if not sysfs_path.exists():
+                import subprocess
+
+                ret = subprocess.run(["/usr/sbin/modprobe", kernel_module])
+                if ret.returncode != 0:
+                    pytest.skip(
+                        f"module {kernel_module} could not be loaded, skipping the test"
+                    )
+
+        @pytest.fixture()
+        def load_kernel_module(self):
+            for kernel_driver, kernel_module in self.kernel_modules:
+                self._load_kernel_module(kernel_driver, kernel_module)
+            yield
+
+        @pytest.fixture()
+        def new_uhdev(self, load_kernel_module):
+            return self.create_device()
+
+        def assertName(self, uhdev):
+            evdev = uhdev.get_evdev()
+            assert uhdev.name in evdev.name
+
+        @pytest.fixture(autouse=True)
+        def context(self, new_uhdev, request):
+            try:
+                with HIDTestUdevRule.instance():
+                    with new_uhdev as self.uhdev:
+                        skip_cond = request.node.get_closest_marker("skip_if_uhdev")
+                        if skip_cond:
+                            test, message, *rest = skip_cond.args
+
+                            if test(self.uhdev):
+                                pytest.skip(message)
+
+                        self.uhdev.create_kernel_device()
+                        now = time.time()
+                        while not self.uhdev.is_ready() and time.time() - now < 5:
+                            self.uhdev.dispatch(1)
+                        if self.uhdev.get_evdev() is None:
+                            logger.warning(
+                                f"available list of input nodes: (default application is '{self.uhdev.application}')"
+                            )
+                            logger.warning(self.uhdev.input_nodes)
+                        yield
+                        self.uhdev = None
+            except PermissionError:
+                pytest.skip("Insufficient permissions, run me as root")
+
+        @pytest.fixture(autouse=True)
+        def check_taint(self):
+            # we are abusing SysfsFile here, it's in /proc, but meh
+            taint_file = SysfsFile("/proc/sys/kernel/tainted")
+            taint = taint_file.int_value
+
+            yield
+
+            assert taint_file.int_value == taint
+
+        def test_creation(self):
+            """Make sure the device gets processed by the kernel and creates
+            the expected application input node.
+
+            If this fail, there is something wrong in the device report
+            descriptors."""
+            uhdev = self.uhdev
+            assert uhdev is not None
+            assert uhdev.get_evdev() is not None
+            self.assertName(uhdev)
+            assert len(uhdev.next_sync_events()) == 0
+            assert uhdev.get_evdev() is not None
+
+
+class HIDTestUdevRule(object):
+    _instance = None
+    """
+    A context-manager compatible class that sets up our udev rules file and
+    deletes it on context exit.
+
+    This class is tailored to our test setup: it only sets up the udev rule
+    on the **second** context and it cleans it up again on the last context
+    removed. This matches the expected pytest setup: we enter a context for
+    the session once, then once for each test (the first of which will
+    trigger the udev rule) and once the last test exited and the session
+    exited, we clean up after ourselves.
+    """
+
+    def __init__(self):
+        self.refs = 0
+        self.rulesfile = None
+
+    def __enter__(self):
+        self.refs += 1
+        if self.refs == 2 and self.rulesfile is None:
+            self.create_udev_rule()
+            self.reload_udev_rules()
+
+    def __exit__(self, exc_type, exc_value, traceback):
+        self.refs -= 1
+        if self.refs == 0 and self.rulesfile:
+            os.remove(self.rulesfile.name)
+            self.reload_udev_rules()
+
+    def reload_udev_rules(self):
+        import subprocess
+
+        subprocess.run("udevadm control --reload-rules".split())
+        subprocess.run("systemd-hwdb update".split())
+
+    def create_udev_rule(self):
+        import tempfile
+
+        os.makedirs("/run/udev/rules.d", exist_ok=True)
+        with tempfile.NamedTemporaryFile(
+            prefix="91-uhid-test-device-REMOVEME-",
+            suffix=".rules",
+            mode="w+",
+            dir="/run/udev/rules.d",
+            delete=False,
+        ) as f:
+            f.write(
+                'KERNELS=="*input*", ATTRS{name}=="*uhid test *", ENV{LIBINPUT_IGNORE_DEVICE}="1"\n'
+            )
+            f.write(
+                'KERNELS=="*input*", ATTRS{name}=="*uhid test * System Multi Axis", ENV{ID_INPUT_TOUCHSCREEN}="", ENV{ID_INPUT_SYSTEM_MULTIAXIS}="1"\n'
+            )
+            self.rulesfile = f
+
+    @classmethod
+    def instance(cls):
+        if not cls._instance:
+            cls._instance = HIDTestUdevRule()
+        return cls._instance
diff --git a/tools/testing/selftests/hid/tests/conftest.py b/tools/testing/selftests/hid/tests/conftest.py
new file mode 100644
index 000000000000..1361ec981db6
--- /dev/null
+++ b/tools/testing/selftests/hid/tests/conftest.py
@@ -0,0 +1,81 @@
+#!/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# -*- coding: utf-8 -*-
+#
+# Copyright (c) 2017 Benjamin Tissoires <benjamin.tissoires@gmail.com>
+# Copyright (c) 2017 Red Hat, Inc.
+
+import platform
+import pytest
+import re
+import resource
+import subprocess
+from .base import HIDTestUdevRule
+from pathlib import Path
+
+
+# See the comment in HIDTestUdevRule, this doesn't set up but it will clean
+# up once the last test exited.
+@pytest.fixture(autouse=True, scope="session")
+def udev_rules_session_setup():
+    with HIDTestUdevRule.instance():
+        yield
+
+
+@pytest.fixture(autouse=True, scope="session")
+def setup_rlimit():
+    resource.setrlimit(resource.RLIMIT_CORE, (0, 0))
+
+
+@pytest.fixture(autouse=True, scope="session")
+def start_udevd(pytestconfig):
+    if pytestconfig.getoption("udevd"):
+        import subprocess
+
+        with subprocess.Popen("/usr/lib/systemd/systemd-udevd") as proc:
+            yield
+            proc.kill()
+    else:
+        yield
+
+
+def pytest_configure(config):
+    config.addinivalue_line(
+        "markers",
+        "skip_if_uhdev(condition, message): mark test to skip if the condition on the uhdev device is met",
+    )
+
+
+# Generate the list of modules and modaliases
+# for the tests that need to be parametrized with those
+def pytest_generate_tests(metafunc):
+    if "usbVidPid" in metafunc.fixturenames:
+        modules = (
+            Path("/lib/modules/")
+            / platform.uname().release
+            / "kernel"
+            / "drivers"
+            / "hid"
+        )
+
+        modalias_re = re.compile(r"alias:\s+hid:b0003g.*v([0-9a-fA-F]+)p([0-9a-fA-F]+)")
+
+        params = []
+        ids = []
+        for module in modules.glob("*.ko"):
+            p = subprocess.run(
+                ["modinfo", module], capture_output=True, check=True, encoding="utf-8"
+            )
+            for line in p.stdout.split("\n"):
+                m = modalias_re.match(line)
+                if m is not None:
+                    vid, pid = m.groups()
+                    vid = int(vid, 16)
+                    pid = int(pid, 16)
+                    params.append([module.name.replace(".ko", ""), vid, pid])
+                    ids.append(f"{module.name} {vid:04x}:{pid:04x}")
+        metafunc.parametrize("usbVidPid", params, ids=ids)
+
+
+def pytest_addoption(parser):
+    parser.addoption("--udevd", action="store_true", default=False)
diff --git a/tools/testing/selftests/hid/tests/test_hid_core.py b/tools/testing/selftests/hid/tests/test_hid_core.py
new file mode 100644
index 000000000000..9a7fe40020d2
--- /dev/null
+++ b/tools/testing/selftests/hid/tests/test_hid_core.py
@@ -0,0 +1,154 @@
+#!/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# -*- coding: utf-8 -*-
+#
+# Copyright (c) 2017 Benjamin Tissoires <benjamin.tissoires@gmail.com>
+# Copyright (c) 2017 Red Hat, Inc.
+#
+# This program is free software: you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+# This is for generic devices
+
+from . import base
+import logging
+
+logger = logging.getLogger("hidtools.test.hid")
+
+
+class TestCollectionOverflow(base.BaseTestCase.TestUhid):
+    """
+    Test class to test re-allocation of the HID collection stack in
+    hid-core.c.
+    """
+
+    def create_device(self):
+        # fmt: off
+        report_descriptor = [
+            0x05, 0x01,         # .Usage Page (Generic Desktop)
+            0x09, 0x02,         # .Usage (Mouse)
+            0xa1, 0x01,         # .Collection (Application)
+            0x09, 0x02,         # ..Usage (Mouse)
+            0xa1, 0x02,         # ..Collection (Logical)
+            0x09, 0x01,         # ...Usage (Pointer)
+            0xa1, 0x00,         # ...Collection (Physical)
+            0x05, 0x09,         # ....Usage Page (Button)
+            0x19, 0x01,         # ....Usage Minimum (1)
+            0x29, 0x03,         # ....Usage Maximum (3)
+            0x15, 0x00,         # ....Logical Minimum (0)
+            0x25, 0x01,         # ....Logical Maximum (1)
+            0x75, 0x01,         # ....Report Size (1)
+            0x95, 0x03,         # ....Report Count (3)
+            0x81, 0x02,         # ....Input (Data,Var,Abs)
+            0x75, 0x05,         # ....Report Size (5)
+            0x95, 0x01,         # ....Report Count (1)
+            0x81, 0x03,         # ....Input (Cnst,Var,Abs)
+            0xa1, 0x02,         # ....Collection (Logical)
+            0x09, 0x01,         # .....Usage (Pointer)
+            0xa1, 0x02,         # ....Collection (Logical)
+            0x09, 0x01,         # .....Usage (Pointer)
+            0xa1, 0x02,         # ....Collection (Logical)
+            0x09, 0x01,         # .....Usage (Pointer)
+            0xa1, 0x02,         # ....Collection (Logical)
+            0x09, 0x01,         # .....Usage (Pointer)
+            0xa1, 0x02,         # ....Collection (Logical)
+            0x09, 0x01,         # .....Usage (Pointer)
+            0xa1, 0x02,         # ....Collection (Logical)
+            0x09, 0x01,         # .....Usage (Pointer)
+            0xa1, 0x02,         # ....Collection (Logical)
+            0x09, 0x01,         # .....Usage (Pointer)
+            0xa1, 0x02,         # ....Collection (Logical)
+            0x09, 0x01,         # .....Usage (Pointer)
+            0xa1, 0x02,         # ....Collection (Logical)
+            0x09, 0x01,         # .....Usage (Pointer)
+            0xa1, 0x02,         # ....Collection (Logical)
+            0x09, 0x01,         # .....Usage (Pointer)
+            0xa1, 0x02,         # ....Collection (Logical)
+            0x09, 0x01,         # .....Usage (Pointer)
+            0xa1, 0x02,         # ....Collection (Logical)
+            0x09, 0x01,         # .....Usage (Pointer)
+            0xa1, 0x02,         # ....Collection (Logical)
+            0x09, 0x01,         # .....Usage (Pointer)
+            0xa1, 0x02,         # ....Collection (Logical)
+            0x09, 0x01,         # .....Usage (Pointer)
+            0xa1, 0x02,         # ....Collection (Logical)
+            0x09, 0x01,         # .....Usage (Pointer)
+            0xa1, 0x02,         # ....Collection (Logical)
+            0x09, 0x01,         # .....Usage (Pointer)
+            0xa1, 0x02,         # ....Collection (Logical)
+            0x09, 0x01,         # .....Usage (Pointer)
+            0x05, 0x01,         # .....Usage Page (Generic Desktop)
+            0x09, 0x30,         # .....Usage (X)
+            0x09, 0x31,         # .....Usage (Y)
+            0x15, 0x81,         # .....Logical Minimum (-127)
+            0x25, 0x7f,         # .....Logical Maximum (127)
+            0x75, 0x08,         # .....Report Size (8)
+            0x95, 0x02,         # .....Report Count (2)
+            0x81, 0x06,         # .....Input (Data,Var,Rel)
+            0xa1, 0x02,         # ...Collection (Logical)
+            0x85, 0x12,         # ....Report ID (18)
+            0x09, 0x48,         # ....Usage (Resolution Multiplier)
+            0x95, 0x01,         # ....Report Count (1)
+            0x75, 0x02,         # ....Report Size (2)
+            0x15, 0x00,         # ....Logical Minimum (0)
+            0x25, 0x01,         # ....Logical Maximum (1)
+            0x35, 0x01,         # ....Physical Minimum (1)
+            0x45, 0x0c,         # ....Physical Maximum (12)
+            0xb1, 0x02,         # ....Feature (Data,Var,Abs)
+            0x85, 0x1a,         # ....Report ID (26)
+            0x09, 0x38,         # ....Usage (Wheel)
+            0x35, 0x00,         # ....Physical Minimum (0)
+            0x45, 0x00,         # ....Physical Maximum (0)
+            0x95, 0x01,         # ....Report Count (1)
+            0x75, 0x10,         # ....Report Size (16)
+            0x16, 0x01, 0x80,   # ....Logical Minimum (-32767)
+            0x26, 0xff, 0x7f,   # ....Logical Maximum (32767)
+            0x81, 0x06,         # ....Input (Data,Var,Rel)
+            0xc0,               # ...End Collection
+            0xc0,               # ...End Collection
+            0xc0,               # ...End Collection
+            0xc0,               # ...End Collection
+            0xc0,               # ...End Collection
+            0xc0,               # ...End Collection
+            0xc0,               # ...End Collection
+            0xc0,               # ...End Collection
+            0xc0,               # ...End Collection
+            0xc0,               # ...End Collection
+            0xc0,               # ...End Collection
+            0xc0,               # ...End Collection
+            0xc0,               # ...End Collection
+            0xc0,               # ...End Collection
+            0xc0,               # ...End Collection
+            0xc0,               # ...End Collection
+            0xc0,               # ...End Collection
+            0xc0,               # ...End Collection
+            0xc0,               # ...End Collection
+            0xc0,               # ..End Collection
+            0xc0,               # .End Collection
+        ]
+        # fmt: on
+        return base.UHIDTestDevice(
+            name=None, rdesc=report_descriptor, application="Mouse"
+        )
+
+    def test_rdesc(self):
+        """
+        This test can only check for negatives. If the kernel crashes, you
+        know why. If this test passes, either the bug isn't present or just
+        didn't get triggered. No way to know.
+
+        For an explanation, see kernel patch
+            HID: core: replace the collection tree pointers with indices
+        """
+        pass
diff --git a/tools/testing/selftests/hid/vmtest.sh b/tools/testing/selftests/hid/vmtest.sh
index 6346b0620dba..681b906b4853 100755
--- a/tools/testing/selftests/hid/vmtest.sh
+++ b/tools/testing/selftests/hid/vmtest.sh
@@ -27,7 +27,7 @@ EXIT_STATUS_FILE="${LOG_FILE_BASE}.exit_status"
 CONTAINER_IMAGE="registry.freedesktop.org/libevdev/hid-tools/fedora/37:2023-02-17.1"
 
 TARGETS="${TARGETS:=$(basename ${SCRIPT_DIR})}"
-DEFAULT_COMMAND="make -C tools/testing/selftests TARGETS=${TARGETS} run_tests"
+DEFAULT_COMMAND="pip3 install hid-tools; make -C tools/testing/selftests TARGETS=${TARGETS} run_tests"
 
 usage()
 {

-- 
2.39.1

