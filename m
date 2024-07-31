Return-Path: <linux-kselftest+bounces-14513-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC239942742
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 09:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E23284226
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 07:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFAC1A4B39;
	Wed, 31 Jul 2024 07:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qNgtwcfF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033A2161328
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 07:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722409346; cv=none; b=e6uAU4ERUCDpSFD43KJNyzoN4Id6C2r80ITil0KXbkwxMswK2pgo53fEa9yvAzZLlVmM7pvC3YVgDJLpxy9CQV3PHSvA1SkOOnIK6FETBOFitHKUj848CVVrCdx3OPx82yuvqE3kuHGhDZe4FCCBA9tMU2C0nSXuB4bDwuGn8cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722409346; c=relaxed/simple;
	bh=UvGS2KNgksmGdxRxMB/KVioF0rHo3JEoWgRJlI3psks=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ms2shu2mDKHpbD5GJT2Lp3VS348THcKpaXCDjqDoihTtLq26hLplj6dytZrqNud9yg51eDYhMsV+NfSbL56UKTCJ91hBMMNphRMdPIdN/W57RmmH2oPY9sR1sxOieYfxgLt6S4ikOcjlDv5jXM+AIY7OsMNKicFK8z46QH5coGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qNgtwcfF; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-66b3b4415c7so111826787b3.0
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 00:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722409343; x=1723014143; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=088JFC1WZ8ZgSpH7zRMZEF3/RcvpIxuKl/0OLwbt5dE=;
        b=qNgtwcfFVQdzzMsxEn63UyeFDKtU0eC7NRQgJrIxzyOnZJtx+RxDBoq1ptDKqZC52Y
         rymLI1CIR4o+Z5uvcwX38hqmyp5liRDBZmJMYJKFSgI6FFnON+NZPDNg+taEQFdeQjOy
         zJ5Ka5qRr2hfwq3wDpQZV8QOOQYVXiPP3Z427eIaiOWaPtK3o41qdVm7PQUx31tGIe+0
         063hoiix+b97XVqcKGGvg5xX2xtpb9XJ4zRgj+7Wb8CAxc/TQqHHtNo9yoze1LkNc3X4
         kTH3hhXYFBpToQHeZr8mut4eS10j01kK8DpCwyod3Hx2Q1HbRKG/+U4j3NYFf+4Xl8vh
         Lc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722409343; x=1723014143;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=088JFC1WZ8ZgSpH7zRMZEF3/RcvpIxuKl/0OLwbt5dE=;
        b=R8jpyKgPH5+jWnMtnRoMPyGknqnBFuGLwuy3QzpErEIOTXwIY97cbIVBX6BdovAcaB
         IkCF+vahAIQ3GPen+wZUSla2+TgH6BWfBk0bkdUfUy07pJUQj26rL6W4+UKwt8sElOHF
         vWgBBEQlrIHnlK1mOqg3cC+xtxcyzp4YWd/PuJH/+o71cQfMf+vcdEmTFzJ8VCgFEHwT
         1Qbf/ES8fUOCfUawgC6FSOToVJVnd++0s/3nTmKiS8wCew69La1lhzY/HoTjg4/17uQ+
         0RfpNvDymXDJ86tU4SWiNvxV5kMRmuR3GlA9Nl/4MvO5e7FhGexTb8fX64UmFQaoUIsD
         6UxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAoGEPfI9/BAN9rCbqfxqYDprJGBlvIqOVzjFF4FBkgpijlC5+HkYyM1j+yS6QRnUiKGYuzFt1E+YG7fGOe3s++vFHeMNvFu4IfIJZ+fPn
X-Gm-Message-State: AOJu0YyGOanEiCwZuNW5RoBpMRXmcMW05P9rkn2fPBJWaqZQuW8Em89m
	LbRWlZEbuqbtf9vWVxlZe3qy8lceEoO92aE/dLp4URAHf0eLA0Oc4Ir22zKJYQ9DzF9AM5p7Goz
	OHIY8yHuTjA==
X-Google-Smtp-Source: AGHT+IEvcL19rB/+XJE1g92cQ/lu74+Om7niyk0FqxVzSWQtmKy7T05Ze92qeC+Wk1rlur/edUgwreXL+ZLrXg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:949:0:b0:e0b:bafe:a7ff with SMTP id
 3f1490d57ef6-e0bbafea980mr1564276.6.1722409342902; Wed, 31 Jul 2024 00:02:22
 -0700 (PDT)
Date: Wed, 31 Jul 2024 15:02:06 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240731070207.3918687-1-davidgow@google.com>
Subject: [PATCH] kunit: Device wrappers should also manage driver name
From: David Gow <davidgow@google.com>
To: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Maxime Ripard <mripard@kernel.org>, 
	Kees Cook <kees@kernel.org>, Nico Pache <npache@redhat.com>
Cc: David Gow <davidgow@google.com>, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

kunit_driver_create() accepts a name for the driver, but does not copy
it, so if that name is either on the stack, or otherwise freed, we end
up with a use-after-free when the driver is cleaned up.

Instead, strdup() the name, and manage it as another KUnit allocation.
As there was no existing kunit_kstrdup(), we add one. Further, add a
kunit_ variant of strdup_const() and kfree_const(), so we don't need to
allocate and manage the string in the majority of cases where it's a
constant.

This fixes a KASAN splat with overflow.overflow_allocation_test, when
built as a module.

Fixes: d03c720e03bd ("kunit: Add APIs for managing devices")
Reported-by: Nico Pache <npache@redhat.com>
Closes: https://groups.google.com/g/kunit-dev/c/81V9b9QYON0
Signed-off-by: David Gow <davidgow@google.com>
Reviewed-by: Kees Cook <kees@kernel.org>
---

There's some more serious changes since the RFC I sent, so please take a
closer look.

Thanks,
-- David

Changes since RFC:
https://groups.google.com/g/kunit-dev/c/81V9b9QYON0/m/PFKNKDKAAAAJ
- Add and use the kunit_kstrdup_const() and kunit_free_const()
  functions.
- Fix a typo in the doc comments.


---
 include/kunit/test.h | 58 ++++++++++++++++++++++++++++++++++++++++++++
 lib/kunit/device.c   |  7 ++++--
 2 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index e2a1f0928e8b..da9e84de14c0 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -28,6 +28,7 @@
 #include <linux/types.h>
 
 #include <asm/rwonce.h>
+#include <asm/sections.h>
 
 /* Static key: true if any KUnit tests are currently running */
 DECLARE_STATIC_KEY_FALSE(kunit_running);
@@ -480,6 +481,63 @@ static inline void *kunit_kcalloc(struct kunit *test, size_t n, size_t size, gfp
 	return kunit_kmalloc_array(test, n, size, gfp | __GFP_ZERO);
 }
 
+
+/**
+ * kunit_kfree_const() - conditionally free test managed memory
+ * @x: pointer to the memory
+ *
+ * Calls kunit_kfree() only if @x is not in .rodata section.
+ * See kunit_kstrdup_const() for more information.
+ */
+static inline void kunit_kfree_const(struct kunit *test, const void *x)
+{
+	if (!is_kernel_rodata((unsigned long)x))
+		kunit_kfree(test, x);
+}
+
+/**
+ * kunit_kstrdup() - Duplicates a string into a test managed allocation.
+ *
+ * @test: The test context object.
+ * @str: The NULL-terminated string to duplicate.
+ * @gfp: flags passed to underlying kmalloc().
+ *
+ * See kstrdup() and kunit_kmalloc_array() for more information.
+ */
+static inline char *kunit_kstrdup(struct kunit *test, const char *str, gfp_t gfp)
+{
+	size_t len;
+	char *buf;
+
+	if (!str)
+		return NULL;
+
+	len = strlen(str) + 1;
+	buf = kunit_kmalloc(test, len, gfp);
+	if (buf)
+		memcpy(buf, str, len);
+	return buf;
+}
+
+/**
+ * kunit_kstrdup_const() - Conditionally duplicates a string into a test managed allocation.
+ *
+ * @test: The test context object.
+ * @str: The NULL-terminated string to duplicate.
+ * @gfp: flags passed to underlying kmalloc().
+ *
+ * Calls kunit_kstrdup() only if @str is not in the rodata section. Must be freed with
+ * kunit_free_const() -- not kunit_free().
+ * See kstrdup_const() and kunit_kmalloc_array() for more information.
+ */
+static inline const char *kunit_kstrdup_const(struct kunit *test, const char *str, gfp_t gfp)
+{
+	if (is_kernel_rodata((unsigned long)str))
+		return str;
+
+	return kunit_kstrdup(test, str, gfp);
+}
+
 /**
  * kunit_vm_mmap() - Allocate KUnit-tracked vm_mmap() area
  * @test: The test context object.
diff --git a/lib/kunit/device.c b/lib/kunit/device.c
index 25c81ed465fb..520c1fccee8a 100644
--- a/lib/kunit/device.c
+++ b/lib/kunit/device.c
@@ -89,7 +89,7 @@ struct device_driver *kunit_driver_create(struct kunit *test, const char *name)
 	if (!driver)
 		return ERR_PTR(err);
 
-	driver->name = name;
+	driver->name = kunit_kstrdup_const(test, name, GFP_KERNEL);
 	driver->bus = &kunit_bus_type;
 	driver->owner = THIS_MODULE;
 
@@ -192,8 +192,11 @@ void kunit_device_unregister(struct kunit *test, struct device *dev)
 	const struct device_driver *driver = to_kunit_device(dev)->driver;
 
 	kunit_release_action(test, device_unregister_wrapper, dev);
-	if (driver)
+	if (driver) {
+		const char *driver_name = driver->name;
 		kunit_release_action(test, driver_unregister_wrapper, (void *)driver);
+		kunit_kfree_const(test, driver_name);
+	}
 }
 EXPORT_SYMBOL_GPL(kunit_device_unregister);
 
-- 
2.46.0.rc1.232.g9752f9e123-goog


