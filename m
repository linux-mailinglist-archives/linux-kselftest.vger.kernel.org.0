Return-Path: <linux-kselftest+bounces-1118-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21944804B23
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 08:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D8A4B20CA0
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 07:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6D2225A8;
	Tue,  5 Dec 2023 07:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XP/23V3H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4F7130
	for <linux-kselftest@vger.kernel.org>; Mon,  4 Dec 2023 23:31:56 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d3911218b3so67963147b3.1
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Dec 2023 23:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701761515; x=1702366315; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVAFZpMC/pXXNd/TQY0spuN4AL3218SOHwbqzpG63Og=;
        b=XP/23V3H9uWZPnI1fVr7B/Z9WAqkHRaQpwzPYHC2UsQZ26b/JJDXC4uzkh6gDaoutV
         HfTuOgf6aIzfMsPQM1fILXVLn5V9zMtSjn8Tldz20AYcOyvgUsCj3DdkjOVxxrfZT2A0
         EKlME95+nzUWPEv0/SWAd10PiyF+NZi5jnPKArQP0Yl2huuBRzoo69G+1ukAQIRlGQQk
         qMuSuzOcDTn2FcFMq1YfY2wCCIpaGR3XNYUbrpS1ygKMVEsKZUWwXo8d0buYfltdlOqo
         s5VQit0iZXGyVuK9wjfW7Jgn02ETVKw2IDmkDUnPK6BeGZLjib+nDNiySyjzxmMLUKrD
         XUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701761515; x=1702366315;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVAFZpMC/pXXNd/TQY0spuN4AL3218SOHwbqzpG63Og=;
        b=eFuiv7OBXk4IzjwUrayXoJoBvsuwsglWGNsKVDQyH+Eb4oJEF4c8LWdnH0Fa5RKGV9
         MGl5e1ErumF5O0BvSb8og6ume49ec7b1AV3XHgrJYOLGL9dhDJfr+jxNsLvLBevo8oYA
         mPQ59SfxRRA4MNfLREh2Tlwbuzo46lxnLutYhl7EYGxWEs8HlY7HRUrxw1aOgTDRFtFo
         5kybuN4y/kwOwpbbGiGW4+F+/CmJDVZkw7mfSiTIyrSoA1k4h20hq4NWkKRvuegsYobi
         rCG/AdYJmt5xem3bzcQhUdUpWCpaLo+XKbXGsYSEPkWXGsrJFhrqR8E3AFuVx4uSr+qm
         vfNA==
X-Gm-Message-State: AOJu0YwBAva6GvfLkdM6sEOL6n5OCC66/FBeAc9Ivt0/8CClrckIiYWb
	oHDGXAzQxQzNfFAIOE+A+daUbqOxhB06vA==
X-Google-Smtp-Source: AGHT+IGfzqpHM2bt3eU+nbEARgOrDBsLKYb6WEtxSxhfPLTlJokPndKpUxfpVudRRQ022uRPVG12qnbYnST1BA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a81:ff08:0:b0:5cb:1bf4:ce09 with SMTP id
 k8-20020a81ff08000000b005cb1bf4ce09mr1108825ywn.2.1701761515615; Mon, 04 Dec
 2023 23:31:55 -0800 (PST)
Date: Tue, 05 Dec 2023 15:31:33 +0800
In-Reply-To: <20231205-kunit_bus-v1-0-635036d3bc13@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231205-kunit_bus-v1-0-635036d3bc13@google.com>
X-Mailer: b4 0.13-dev-099c9
Message-ID: <20231205-kunit_bus-v1-1-635036d3bc13@google.com>
Subject: [PATCH 1/4] kunit: Add APIs for managing devices
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
	David Gow <davidgow@google.com>
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

Signed-off-by: David Gow <davidgow@google.com>
---
 Documentation/dev-tools/kunit/usage.rst |  49 +++++++++
 include/kunit/device.h                  |  76 ++++++++++++++
 lib/kunit/Makefile                      |   3 +-
 lib/kunit/device.c                      | 176 ++++++++++++++++++++++++++++++++
 lib/kunit/kunit-test.c                  |  68 +++++++++++-
 lib/kunit/test.c                        |   3 +
 6 files changed, 373 insertions(+), 2 deletions(-)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 9db12e91668e..a222a98edceb 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -797,3 +797,52 @@ structures as shown below:
 KUnit is not enabled, or if no test is running in the current task, it will do
 nothing. This compiles down to either a no-op or a static key check, so will
 have a negligible performance impact when no test is running.
+
+Managing Fake Devcices and Drivers
+----------------------------------
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
+
+		// Pass it to functions which need a device.
+		dev_managed_string = devm_kstrdup(fake_device, "Hello, World!");
+
+		// Everything is cleaned up automatically when the test ends.
+	}
\ No newline at end of file
diff --git a/include/kunit/device.h b/include/kunit/device.h
new file mode 100644
index 000000000000..fd2193bc55f1
--- /dev/null
+++ b/include/kunit/device.h
@@ -0,0 +1,76 @@
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
+struct kunit_device;
+struct device;
+struct device_driver;
+
+// For internal use only -- registers the kunit_bus.
+int kunit_bus_init(void);
+
+/**
+ * kunit_driver_create() - Create a struct device_driver attached to the kunit_bus
+ * @test: The test context object.
+ * @name: The name to give the created driver.
+ *
+ * Creates a struct device_driver attached to the kunit_bus, with the name @name.
+ * This driver will automatically be cleaned up on test exit.
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
+ * wish KUnit to create and manage a driver for you
+ */
+struct device *kunit_device_register_with_driver(struct kunit *test,
+						 const char *name,
+						 struct device_driver *drv);
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
diff --git a/lib/kunit/device.c b/lib/kunit/device.c
new file mode 100644
index 000000000000..93ace1a2297d
--- /dev/null
+++ b/lib/kunit/device.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit basic device implementation
+ *
+ * Implementation of struct kunit_device helpers.
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
+
+/* Wrappers for use with kunit_add_action() */
+KUNIT_DEFINE_ACTION_WRAPPER(device_unregister_wrapper, device_unregister, struct device *);
+KUNIT_DEFINE_ACTION_WRAPPER(driver_unregister_wrapper, driver_unregister, struct device_driver *);
+
+static struct device kunit_bus = {
+	.init_name = "kunit"
+};
+
+/* A device owned by a KUnit test. */
+struct kunit_device {
+	struct device dev;
+	struct kunit *owner;
+	/* Force binding to a specific driver. */
+	struct device_driver *driver;
+	/* The driver is managed by KUnit and unique to this device. */
+	bool cleanup_driver;
+};
+
+static inline struct kunit_device *to_kunit_device(struct device *d)
+{
+	return container_of(d, struct kunit_device, dev);
+}
+
+static int kunit_bus_match(struct device *dev, struct device_driver *driver)
+{
+	struct kunit_device *kunit_dev = to_kunit_device(dev);
+
+	if (kunit_dev->driver == driver)
+		return 1;
+
+	return 0;
+}
+
+static struct bus_type kunit_bus_type = {
+	.name		= "kunit",
+	.match		= kunit_bus_match
+};
+
+int kunit_bus_init(void)
+{
+	int error;
+
+	error = bus_register(&kunit_bus_type);
+	if (!error) {
+		error = device_register(&kunit_bus);
+		if (error)
+			bus_unregister(&kunit_bus_type);
+	}
+	return error;
+}
+late_initcall(kunit_bus_init);
+
+static void kunit_device_release(struct device *d)
+{
+	kfree(to_kunit_device(d));
+}
+
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
+struct kunit_device *__kunit_device_register_internal(struct kunit *test,
+						      const char *name,
+						      struct device_driver *drv)
+{
+	struct kunit_device *kunit_dev;
+	int err = -ENOMEM;
+
+	kunit_dev = kzalloc(sizeof(struct kunit_device), GFP_KERNEL);
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
+	/* Set the expected driver pointer, so we match. */
+	kunit_dev->driver = drv;
+
+	kunit_dev->dev.release = kunit_device_release;
+	kunit_dev->dev.bus = &kunit_bus_type;
+	kunit_dev->dev.parent = &kunit_bus;
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
+struct device *kunit_device_register_with_driver(struct kunit *test,
+						 const char *name,
+						 struct device_driver *drv)
+{
+	struct kunit_device *kunit_dev = __kunit_device_register_internal(test, name, drv);
+
+	if (IS_ERR_OR_NULL(kunit_dev))
+		return (struct device *)kunit_dev; /* This is an error or NULL, so is compatible */
+
+	return &kunit_dev->dev;
+}
+EXPORT_SYMBOL_GPL(kunit_device_register_with_driver);
+
+struct device *kunit_device_register(struct kunit *test, const char *name)
+{
+	struct device_driver *drv = kunit_driver_create(test, name);
+	struct kunit_device *dev;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drv);
+
+	dev = __kunit_device_register_internal(test, name, drv);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	dev->cleanup_driver = true;
+
+	return (struct device *)dev;
+}
+EXPORT_SYMBOL_GPL(kunit_device_register);
+
+void kunit_device_unregister(struct kunit *test, struct device *dev)
+{
+	bool cleanup_driver = ((struct kunit_device *)dev)->cleanup_driver;
+	struct device_driver *driver = ((struct kunit_device *)dev)->driver;
+
+	kunit_release_action(test, device_unregister_wrapper, dev);
+	if (cleanup_driver)
+		kunit_release_action(test, driver_unregister_wrapper, driver);
+}
+EXPORT_SYMBOL_GPL(kunit_device_unregister);
+
diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index 3e9c5192d095..a4007158bf36 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -8,6 +8,9 @@
 #include <kunit/test.h>
 #include <kunit/test-bug.h>
 
+#include <linux/device.h>
+#include <kunit/device.h>
+
 #include "string-stream.h"
 #include "try-catch-impl.h"
 
@@ -687,6 +690,69 @@ static struct kunit_case kunit_current_test_cases[] = {
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
+
+	test_device = kunit_device_register(test, "my_device");
+
+	KUNIT_ASSERT_NOT_NULL(test, test_device);
+
+	// Add an action to verify cleanup.
+	devm_add_action(test_device, test_dev_action, &test->priv);
+
+	KUNIT_EXPECT_PTR_EQ(test, test->priv, (void *)0);
+
+	kunit_device_unregister(test, test_device);
+
+	KUNIT_EXPECT_PTR_EQ(test, test->priv, (void *)1);
+}
+
+static void kunit_device_driver_test(struct kunit *test)
+{
+	struct device_driver *test_driver;
+	struct device *test_device;
+
+	test_driver = kunit_driver_create(test, "my_driver");
+
+	KUNIT_ASSERT_NOT_NULL(test, test_driver);
+
+	test_device = kunit_device_register_with_driver(test, "my_device", test_driver);
+
+	KUNIT_ASSERT_NOT_NULL(test, test_device);
+
+	// Add an action to verify cleanup.
+	devm_add_action(test_device, test_dev_action, &test->priv);
+
+	KUNIT_EXPECT_PTR_EQ(test, test->priv, (void *)0);
+
+	kunit_device_unregister(test, test_device);
+	test_device = NULL;
+
+	// The driver should not automatically be destroyed by
+	// kunit_device_unregister, so we can re-use it.
+	test_device = kunit_device_register_with_driver(test, "my_device", test_driver);
+	KUNIT_ASSERT_NOT_NULL(test, test_device);
+
+	// Everything is automatically freed here.
+}
+
+static struct kunit_case kunit_device_test_cases[] = {
+	KUNIT_CASE(kunit_device_test),
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
@@ -694,6 +760,6 @@ static struct kunit_suite kunit_current_test_suite = {
 
 kunit_test_suites(&kunit_try_catch_test_suite, &kunit_resource_test_suite,
 		  &kunit_log_test_suite, &kunit_status_test_suite,
-		  &kunit_current_test_suite);
+		  &kunit_current_test_suite, &kunit_device_test_suite);
 
 MODULE_LICENSE("GPL v2");
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 0308865194bb..144c8e7be197 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -10,6 +10,7 @@
 #include <kunit/test.h>
 #include <kunit/test-bug.h>
 #include <kunit/attributes.h>
+#include <kunit/device.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -840,6 +841,8 @@ static int __init kunit_init(void)
 	kunit_install_hooks();
 
 	kunit_debugfs_init();
+
+	kunit_bus_init();
 #ifdef CONFIG_MODULES
 	return register_module_notifier(&kunit_mod_nb);
 #else

-- 
2.43.0.rc2.451.g8631bc7472-goog


