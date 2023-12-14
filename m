Return-Path: <linux-kselftest+bounces-1899-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46556812AB2
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 09:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8A861F21935
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 08:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4059B2421B;
	Thu, 14 Dec 2023 08:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j07L2V9C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90ACA10C
	for <linux-kselftest@vger.kernel.org>; Thu, 14 Dec 2023 00:49:40 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-dbcda5ef8daso1200834276.3
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Dec 2023 00:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702543780; x=1703148580; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e9PX0PXS1f3f3pBJoG7zI47BnYzw6Hhl3FOBvIaiIQI=;
        b=j07L2V9CFesI/ZQNRFsyu7TuDCUGjVwzhvoXlwceuKmAQlYW4o1L1MYpn0SoMFhmfu
         UgLmsdxV5tYeTyi2Z+/wBCSVUB4BrRJiSG6a3oTlw4+f3lRLuHW05ijflJLLzN6UVMI4
         Ke4MXlMnbIGoKfhTWVj070cUD08/NnIEFP7eBA1abXMFFm7xrlPdtkk/rLnu2Pvd/C4t
         77HAJDPmB/PVWDRBOayZ9jKtH+LpfFJN+dTXxm4ucr7AgQhqXq+yq4XY31TpCaKjkpDK
         C/caAybYgrc8Ks8xEUdsDdeCnLeDsnCHNpL/zZkJrmOWIMN75OBJnEIZnpiLApq5OjT9
         3Zow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702543780; x=1703148580;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e9PX0PXS1f3f3pBJoG7zI47BnYzw6Hhl3FOBvIaiIQI=;
        b=ExQninsSDDor+URgoH9a3QpebTWUIYuQCMfSo62Q0zD/AcE0eydB4xH4ot0PhH227Z
         fUOmqYS6QdNiTr8cHaA5UXuclw6pVu8pelwsnOetoSb2kjq6m8vXd5fp8r357JGY0AqA
         knuk3CwZhnZiCmxNDZTNV8q/wh/j1NRy8y7gcJLZE8ipQvxjhLUyYK/O5iCntD0JK+oB
         KhgelhC9S5pB/xRPcFwqTLxEgBnXXLEqbx45025Sc+htA7atWC5X91m0/LAfCmIDSDy5
         UHrsjqEEc+2sy9mjbtbVHBSfSsTd2mzCjq2M0Lw/Uh/J7BQxfkRIi7EFRZ59cNKIfkCU
         f71A==
X-Gm-Message-State: AOJu0Yzabf0a+Np+NkQRtcMeT86yjuL094Lirue514r3q92qC4ncdn9a
	RXGhw8O0nk1c6a+V02JVZoYBx30D7TpxAw==
X-Google-Smtp-Source: AGHT+IGPvbM7ZCxSTC/usHIx7dnwaRoShNPCjJvY27zWhfOR9WcwdStSrGbpARcLLNfCDqpdkssHR/tKb+aGlw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:5f50:0:b0:dbc:e825:2d2f with SMTP id
 h16-20020a255f50000000b00dbce8252d2fmr4766ybm.0.1702543779746; Thu, 14 Dec
 2023 00:49:39 -0800 (PST)
Date: Thu, 14 Dec 2023 16:49:15 +0800
In-Reply-To: <20231214-kunit_bus-v3-0-7e9a287d3048@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231214-kunit_bus-v3-0-7e9a287d3048@google.com>
X-Mailer: b4 0.13-dev-099c9
Message-ID: <20231214-kunit_bus-v3-1-7e9a287d3048@google.com>
Subject: [PATCH v3 1/5] kunit: Add APIs for managing devices
From: davidgow@google.com
To: Rae Moar <rmoar@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Stephen Boyd <sboyd@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Maxime Ripard <mripard@kernel.org>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-sound@vger.kernel.org, 
	David Gow <davidgow@google.com>, Maxime Ripard <mripard@kernel.org>
Content-Type: text/plain; charset="utf-8"

Tests for drivers often require a struct device to pass to other
functions. While it's possible to create these with
root_device_register(), or to use something like a platform device, this
is both a misuse of those APIs, and can be difficult to clean up after,
for example, a failed assertion.

Add some KUnit-specific functions for registering and unregistering a
struct device:
- kunit_device_register()
- kunit_device_register_with_driver()
- kunit_device_unregister()

These helpers allocate a on a 'kunit' bus which will either probe the
driver passed in (kunit_device_register_with_driver), or will create a
stub driver (kunit_device_register) which is cleaned up on test shutdown.

Devices are automatically unregistered on test shutdown, but can be
manually unregistered earlier with kunit_device_unregister() in order
to, for example, test device release code.

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: David Gow <davidgow@google.com>
---
 Documentation/dev-tools/kunit/api/resource.rst |   9 ++
 Documentation/dev-tools/kunit/usage.rst        |  50 +++++++
 include/kunit/device.h                         |  80 +++++++++++
 lib/kunit/Makefile                             |   3 +-
 lib/kunit/device-impl.h                        |  17 +++
 lib/kunit/device.c                             | 181 +++++++++++++++++++++++++
 lib/kunit/kunit-test.c                         | 134 +++++++++++++++++-
 lib/kunit/test.c                               |   3 +
 8 files changed, 475 insertions(+), 2 deletions(-)

diff --git a/Documentation/dev-tools/kunit/api/resource.rst b/Documentation/dev-tools/kunit/api/resource.rst
index 0a94f831259e..ec6002a6b0db 100644
--- a/Documentation/dev-tools/kunit/api/resource.rst
+++ b/Documentation/dev-tools/kunit/api/resource.rst
@@ -11,3 +11,12 @@ state on a per-test basis, register custom cleanup actions, and more.
 
 .. kernel-doc:: include/kunit/resource.h
    :internal:
+
+Managed Devices
+---------------
+
+Functions for using KUnit-managed struct device and struct device_driver.
+Include ``kunit/device.h`` to use these.
+
+.. kernel-doc:: include/kunit/device.h
+   :internal:
diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 9db12e91668e..53c6f7dc8a42 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -797,3 +797,53 @@ structures as shown below:
 KUnit is not enabled, or if no test is running in the current task, it will do
 nothing. This compiles down to either a no-op or a static key check, so will
 have a negligible performance impact when no test is running.
+
+Managing Fake Devices and Drivers
+---------------------------------
+
+When testing drivers or code which interacts with drivers, many functions will
+require a ``struct device`` or ``struct device_driver``. In many cases, setting
+up a real device is not required to test any given function, so a fake device
+can be used instead.
+
+KUnit provides helper functions to create and manage these fake devices, which
+are internally of type ``struct kunit_device``, and are attached to a special
+``kunit_bus``. These devices support managed device resources (devres), as
+described in Documentation/driver-api/driver-model/devres.rst
+
+To create a KUnit-managed ``struct device_driver``, use ``kunit_driver_create()``,
+which will create a driver with the given name, on the ``kunit_bus``. This driver
+will automatically be destroyed when the corresponding test finishes, but can also
+be manually destroyed with ``driver_unregister()``.
+
+To create a fake device, use the ``kunit_device_register()``, which will create
+and register a device, using a new KUnit-managed driver created with ``kunit_driver_create()``.
+To provide a specific, non-KUnit-managed driver, use ``kunit_device_register_with_driver()``
+instead. Like with managed drivers, KUnit-managed fake devices are automatically
+cleaned up when the test finishes, but can be manually cleaned up early with
+``kunit_device_unregister()``.
+
+The KUnit devices should be used in preference to ``root_device_register()``, and
+instead of ``platform_device_register()`` in cases where the device is not otherwise
+a platform device.
+
+For example:
+
+.. code-block:: c
+
+	#include <kunit/device.h>
+
+	static void test_my_device(struct kunit *test)
+	{
+		struct device *fake_device;
+		const char *dev_managed_string;
+
+		// Create a fake device.
+		fake_device = kunit_device_register(test, "my_device");
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fake_device)
+
+		// Pass it to functions which need a device.
+		dev_managed_string = devm_kstrdup(fake_device, "Hello, World!");
+
+		// Everything is cleaned up automatically when the test ends.
+	}
\ No newline at end of file
diff --git a/include/kunit/device.h b/include/kunit/device.h
new file mode 100644
index 000000000000..2450110ad64e
--- /dev/null
+++ b/include/kunit/device.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * KUnit basic device implementation
+ *
+ * Helpers for creating and managing fake devices for KUnit tests.
+ *
+ * Copyright (C) 2023, Google LLC.
+ * Author: David Gow <davidgow@google.com>
+ */
+
+#ifndef _KUNIT_DEVICE_H
+#define _KUNIT_DEVICE_H
+
+#if IS_ENABLED(CONFIG_KUNIT)
+
+#include <kunit/test.h>
+
+struct device;
+struct device_driver;
+
+/**
+ * kunit_driver_create() - Create a struct device_driver attached to the kunit_bus
+ * @test: The test context object.
+ * @name: The name to give the created driver.
+ *
+ * Creates a struct device_driver attached to the kunit_bus, with the name @name.
+ * This driver will automatically be cleaned up on test exit.
+ *
+ * Return: a stub struct device_driver, managed by KUnit, with the name @name.
+ */
+struct device_driver *kunit_driver_create(struct kunit *test, const char *name);
+
+/**
+ * kunit_device_register() - Create a struct device for use in KUnit tests
+ * @test: The test context object.
+ * @name: The name to give the created device.
+ *
+ * Creates a struct kunit_device (which is a struct device) with the given name,
+ * and a corresponding driver. The device and driver will be cleaned up on test
+ * exit, or when kunit_device_unregister is called. See also
+ * kunit_device_register_with_driver, if you wish to provide your own
+ * struct device_driver.
+ *
+ * Return: a pointer to a struct device which will be cleaned up when the test
+ * exits, or an error pointer if the device could not be allocated or registered.
+ */
+struct device *kunit_device_register(struct kunit *test, const char *name);
+
+/**
+ * kunit_device_register_with_driver() - Create a struct device for use in KUnit tests
+ * @test: The test context object.
+ * @name: The name to give the created device.
+ * @drv: The struct device_driver to associate with the device.
+ *
+ * Creates a struct kunit_device (which is a struct device) with the given
+ * name, and driver. The device will be cleaned up on test exit, or when
+ * kunit_device_unregister is called. See also kunit_device_register, if you
+ * wish KUnit to create and manage a driver for you.
+ *
+ * Return: a pointer to a struct device which will be cleaned up when the test
+ * exits, or an error pointer if the device could not be allocated or registered.
+ */
+struct device *kunit_device_register_with_driver(struct kunit *test,
+						 const char *name,
+						 const struct device_driver *drv);
+
+/**
+ * kunit_device_unregister() - Unregister a KUnit-managed device
+ * @test: The test context object which created the device
+ * @dev: The device.
+ *
+ * Unregisters and destroys a struct device which was created with
+ * kunit_device_register or kunit_device_register_with_driver. If KUnit created
+ * a driver, cleans it up as well.
+ */
+void kunit_device_unregister(struct kunit *test, struct device *dev);
+
+#endif
+
+#endif
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 46f75f23dfe4..309659a32a78 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -7,7 +7,8 @@ kunit-objs +=				test.o \
 					assert.o \
 					try-catch.o \
 					executor.o \
-					attributes.o
+					attributes.o \
+					device.o
 
 ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
 kunit-objs +=				debugfs.o
diff --git a/lib/kunit/device-impl.h b/lib/kunit/device-impl.h
new file mode 100644
index 000000000000..54bd55836405
--- /dev/null
+++ b/lib/kunit/device-impl.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * KUnit internal header for device helpers
+ *
+ * Header for KUnit-internal driver / bus management.
+ *
+ * Copyright (C) 2023, Google LLC.
+ * Author: David Gow <davidgow@google.com>
+ */
+
+#ifndef _KUNIT_DEVICE_IMPL_H
+#define _KUNIT_DEVICE_IMPL_H
+
+// For internal use only -- registers the kunit_bus.
+int kunit_bus_init(void);
+
+#endif //_KUNIT_DEVICE_IMPL_H
diff --git a/lib/kunit/device.c b/lib/kunit/device.c
new file mode 100644
index 000000000000..1db4305b615a
--- /dev/null
+++ b/lib/kunit/device.c
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit-managed device implementation
+ *
+ * Implementation of struct kunit_device helpers for fake devices whose
+ * lifecycle is managed by KUnit.
+ *
+ * Copyright (C) 2023, Google LLC.
+ * Author: David Gow <davidgow@google.com>
+ */
+
+#include <linux/device.h>
+
+#include <kunit/test.h>
+#include <kunit/device.h>
+#include <kunit/resource.h>
+
+#include "device-impl.h"
+
+/* Wrappers for use with kunit_add_action() */
+KUNIT_DEFINE_ACTION_WRAPPER(device_unregister_wrapper, device_unregister, struct device *);
+KUNIT_DEFINE_ACTION_WRAPPER(driver_unregister_wrapper, driver_unregister, struct device_driver *);
+
+/* The root device for the KUnit bus, parent of all kunit_devices. */
+static struct device *kunit_bus_device;
+
+/* A device owned by a KUnit test. */
+struct kunit_device {
+	struct device dev;
+	/* The KUnit test which owns this device. */
+	struct kunit *owner;
+	/* If the driver is managed by KUnit and unique to this device. */
+	const struct device_driver *driver;
+};
+
+#define to_kunit_device(d) container_of_const(d, struct kunit_device, dev)
+
+static struct bus_type kunit_bus_type = {
+	.name		= "kunit",
+};
+
+/* Register the 'kunit_bus' used for fake devices. */
+int kunit_bus_init(void)
+{
+	int error;
+
+	kunit_bus_device = root_device_register("kunit");
+	if (!kunit_bus_device)
+		return -ENOMEM;
+
+	error = bus_register(&kunit_bus_type);
+	if (error)
+		bus_unregister(&kunit_bus_type);
+	return error;
+}
+
+/* Release a 'fake' KUnit device. */
+static void kunit_device_release(struct device *d)
+{
+	kfree(to_kunit_device(d));
+}
+
+/**
+ * Create and register a KUnit-managed struct device_driver on the kunit_bus.
+ * Returns an error pointer on failure.
+ */
+struct device_driver *kunit_driver_create(struct kunit *test, const char *name)
+{
+	struct device_driver *driver;
+	int err = -ENOMEM;
+
+	driver = kunit_kzalloc(test, sizeof(*driver), GFP_KERNEL);
+
+	if (!driver)
+		return ERR_PTR(err);
+
+	driver->name = name;
+	driver->bus = &kunit_bus_type;
+	driver->owner = THIS_MODULE;
+
+	err = driver_register(driver);
+	if (err) {
+		kunit_kfree(test, driver);
+		return ERR_PTR(err);
+	}
+
+	kunit_add_action(test, driver_unregister_wrapper, driver);
+	return driver;
+}
+EXPORT_SYMBOL_GPL(kunit_driver_create);
+
+/* Helper which creates a kunit_device, attaches it to the kunit_bus*/
+static struct kunit_device *kunit_device_register_internal(struct kunit *test,
+							   const char *name,
+							   const struct device_driver *drv)
+{
+	struct kunit_device *kunit_dev;
+	int err = -ENOMEM;
+
+	kunit_dev = kzalloc(sizeof(*kunit_dev), GFP_KERNEL);
+	if (!kunit_dev)
+		return ERR_PTR(err);
+
+	kunit_dev->owner = test;
+
+	err = dev_set_name(&kunit_dev->dev, "%s.%s", test->name, name);
+	if (err) {
+		kfree(kunit_dev);
+		return ERR_PTR(err);
+	}
+
+	kunit_dev->dev.release = kunit_device_release;
+	kunit_dev->dev.bus = &kunit_bus_type;
+	kunit_dev->dev.parent = kunit_bus_device;
+
+	err = device_register(&kunit_dev->dev);
+	if (err) {
+		put_device(&kunit_dev->dev);
+		return ERR_PTR(err);
+	}
+
+	kunit_add_action(test, device_unregister_wrapper, &kunit_dev->dev);
+
+	return kunit_dev;
+}
+
+/**
+ * Create and register a new KUnit-managed device, using the user-supplied device_driver.
+ * On failure, returns an error pointer.
+ */
+struct device *kunit_device_register_with_driver(struct kunit *test,
+						 const char *name,
+						 const struct device_driver *drv)
+{
+	struct kunit_device *kunit_dev = kunit_device_register_internal(test, name, drv);
+
+	if (IS_ERR_OR_NULL(kunit_dev))
+		return ERR_CAST(kunit_dev);
+
+	return &kunit_dev->dev;
+}
+EXPORT_SYMBOL_GPL(kunit_device_register_with_driver);
+
+/**
+ * Create and register a new KUnit-managed device, including a matching device_driver.
+ * On failure, returns an error pointer.
+ */
+struct device *kunit_device_register(struct kunit *test, const char *name)
+{
+	struct device_driver *drv;
+	struct kunit_device *dev;
+
+	drv = kunit_driver_create(test, name);
+	if (IS_ERR(drv))
+		return ERR_CAST(drv);
+
+	dev = kunit_device_register_internal(test, name, drv);
+	if (IS_ERR(dev)) {
+		kunit_release_action(test, driver_unregister_wrapper, (void *)drv);
+		return ERR_CAST(dev);
+	}
+
+	/* Request the driver be freed. */
+	dev->driver = drv;
+
+
+	return &dev->dev;
+}
+EXPORT_SYMBOL_GPL(kunit_device_register);
+
+/* Unregisters a KUnit-managed device early (including the driver, if automatically created). */
+void kunit_device_unregister(struct kunit *test, struct device *dev)
+{
+	const struct device_driver *driver = to_kunit_device(dev)->driver;
+
+	kunit_release_action(test, device_unregister_wrapper, dev);
+	if (driver)
+		kunit_release_action(test, driver_unregister_wrapper, (void *)driver);
+}
+EXPORT_SYMBOL_GPL(kunit_device_unregister);
+
diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index ee6927c60979..c4259d910356 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -5,9 +5,13 @@
  * Copyright (C) 2019, Google LLC.
  * Author: Brendan Higgins <brendanhiggins@google.com>
  */
+#include "linux/gfp_types.h"
 #include <kunit/test.h>
 #include <kunit/test-bug.h>
 
+#include <linux/device.h>
+#include <kunit/device.h>
+
 #include "string-stream.h"
 #include "try-catch-impl.h"
 
@@ -687,6 +691,134 @@ static struct kunit_case kunit_current_test_cases[] = {
 	{}
 };
 
+static void test_dev_action(void *priv)
+{
+	*(void **)priv = (void *)1;
+}
+
+static void kunit_device_test(struct kunit *test)
+{
+	struct device *test_device;
+	long action_was_run = 0;
+
+	test_device = kunit_device_register(test, "my_device");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, test_device);
+
+	// Add an action to verify cleanup.
+	devm_add_action(test_device, test_dev_action, &action_was_run);
+
+	KUNIT_EXPECT_EQ(test, action_was_run, 0);
+
+	kunit_device_unregister(test, test_device);
+
+	KUNIT_EXPECT_EQ(test, action_was_run, 1);
+}
+
+static void kunit_device_cleanup_test(struct kunit *test)
+{
+	struct device *test_device;
+	long action_was_run = 0;
+
+	test_device = kunit_device_register(test, "my_device");
+	KUNIT_ASSERT_NOT_NULL(test, test_device);
+
+	/* Add an action to verify cleanup. */
+	devm_add_action(test_device, test_dev_action, &action_was_run);
+
+	KUNIT_EXPECT_EQ(test, action_was_run, 0);
+
+	/* Force KUnit to run cleanup early. */
+	kunit_cleanup(test);
+
+	KUNIT_EXPECT_EQ(test, action_was_run, 1);
+}
+
+struct driver_test_state {
+	bool driver_device_probed;
+	bool driver_device_removed;
+	long action_was_run;
+};
+
+static int driver_probe_hook(struct device *dev)
+{
+	struct kunit *test = kunit_get_current_test();
+	struct driver_test_state *state = (struct driver_test_state *)test->priv;
+
+	state->driver_device_probed = true;
+	return 0;
+}
+
+static int driver_remove_hook(struct device *dev)
+{
+	struct kunit *test = kunit_get_current_test();
+	struct driver_test_state *state = (struct driver_test_state *)test->priv;
+
+	state->driver_device_removed = true;
+	return 0;
+}
+
+static void kunit_device_driver_test(struct kunit *test)
+{
+	struct device_driver *test_driver;
+	struct device *test_device;
+	struct driver_test_state *test_state = kunit_kzalloc(test, sizeof(*test_state), GFP_KERNEL);
+
+	test->priv = test_state;
+	test_driver = kunit_driver_create(test, "my_driver");
+
+	// This can fail with an error pointer.
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, test_driver);
+
+	test_driver->probe = driver_probe_hook;
+	test_driver->remove = driver_remove_hook;
+
+	test_device = kunit_device_register_with_driver(test, "my_device", test_driver);
+
+	// This can fail with an error pointer.
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, test_device);
+
+	// Make sure the probe function was called.
+	KUNIT_ASSERT_TRUE(test, test_state->driver_device_probed);
+
+	// Add an action to verify cleanup.
+	devm_add_action(test_device, test_dev_action, &test_state->action_was_run);
+
+	KUNIT_EXPECT_EQ(test, test_state->action_was_run, 0);
+
+	kunit_device_unregister(test, test_device);
+	test_device = NULL;
+
+	// Make sure the remove hook was called.
+	KUNIT_ASSERT_TRUE(test, test_state->driver_device_removed);
+
+	// We're going to test this again.
+	test_state->driver_device_probed = false;
+
+	// The driver should not automatically be destroyed by
+	// kunit_device_unregister, so we can re-use it.
+	test_device = kunit_device_register_with_driver(test, "my_device", test_driver);
+
+	// This can fail with an error pointer.
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, test_device);
+
+	// Probe was called again.
+	KUNIT_ASSERT_TRUE(test, test_state->driver_device_probed);
+
+	// Everything is automatically freed here.
+}
+
+static struct kunit_case kunit_device_test_cases[] = {
+	KUNIT_CASE(kunit_device_test),
+	KUNIT_CASE(kunit_device_cleanup_test),
+	KUNIT_CASE(kunit_device_driver_test),
+	{}
+};
+
+static struct kunit_suite kunit_device_test_suite = {
+	.name = "kunit_device",
+	.test_cases = kunit_device_test_cases,
+};
+
 static struct kunit_suite kunit_current_test_suite = {
 	.name = "kunit_current",
 	.test_cases = kunit_current_test_cases,
@@ -694,6 +826,6 @@ static struct kunit_suite kunit_current_test_suite = {
 
 kunit_test_suites(&kunit_try_catch_test_suite, &kunit_resource_test_suite,
 		  &kunit_log_test_suite, &kunit_status_test_suite,
-		  &kunit_current_test_suite);
+		  &kunit_current_test_suite, &kunit_device_test_suite);
 
 MODULE_LICENSE("GPL v2");
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 0308865194bb..c457593e4913 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -18,6 +18,7 @@
 #include <linux/sched.h>
 
 #include "debugfs.h"
+#include "device-impl.h"
 #include "hooks-impl.h"
 #include "string-stream.h"
 #include "try-catch-impl.h"
@@ -840,6 +841,8 @@ static int __init kunit_init(void)
 	kunit_install_hooks();
 
 	kunit_debugfs_init();
+
+	kunit_bus_init();
 #ifdef CONFIG_MODULES
 	return register_module_notifier(&kunit_mod_nb);
 #else

-- 
2.43.0.472.g3155946c3a-goog


