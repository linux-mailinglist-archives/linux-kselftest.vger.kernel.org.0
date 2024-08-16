Return-Path: <linux-kselftest+bounces-15484-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 833B79540B8
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 06:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C1B81F2471D
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 04:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15DD7829C;
	Fri, 16 Aug 2024 04:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fiAwYtQs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03246F30D
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Aug 2024 04:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723783906; cv=none; b=b7RgGyoDmTIP/iHbliIyAUauKHKfAqaYcnlvrN+0WPcPIXgkgbmvqJjsIqYa3Fhoib7cB8GNOCbSuqUX50DpB+dnJTkuU1os+mKcR9iejDiNRzHelF4FzFUzxlYwIF+gPB8GQnRwXQmwI1wR+pf03N782XMyC+pTMtP1mvcumk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723783906; c=relaxed/simple;
	bh=A/KfasNRi0g5XvdGj/po0279FLZSvsWIP8hmy4Qr3cw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=po0CjLu2kPJutlCoUuOg3EVHelWSNrakCEZDDf1zWUfuFj3utk1Aq6k8Hd5zO9ZtCsVPyTpbU0tb0tfVhHSABB4TNDGTjNe5eLez+SPtxeKDHIc71JcHb6aMm3zRsBdWOGG6grecXAsuErtiIY5ig8yz8sJc2tFcxal/VZxcC/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fiAwYtQs; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-64c3f08ca52so25349077b3.3
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Aug 2024 21:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723783903; x=1724388703; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DhTgaG8i8OC9CKXcSkFlxGY34/XHKFb19/JSnEJ2u0M=;
        b=fiAwYtQsvQXVpW3ebSpJSvIquTKfLDEyQc3ATQafOFP7G2P28C/Un1vuc6V1z+h34C
         mehSbucuZDjYhjQIZ3XaEicD3MEoqCRYEJTWg4HSrdCStF+jjj7jpaxsckbea9btsx2M
         mAMzfdOvEZ+AzJR0itKIDH3rHfSncQLw505GkVjBRL6WT6MRvtgKeUhD75LOJJGb0+cQ
         jKSJHBpAAthA6kRrxI9TEzctuiExQlIcQoGr1LN0zD9UMBAXbSa4RBp539r24dYBfFOs
         /iu2Ixf9CsrciSkGk6+HKY7g3uA78xEaBVYK3qaFQKUajMUcrd1bQjZ22ZJ1sHCtYvVz
         NOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723783903; x=1724388703;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DhTgaG8i8OC9CKXcSkFlxGY34/XHKFb19/JSnEJ2u0M=;
        b=QY96VI2lKv74on+sWF+ruc4Lg8RPlk76SqiYDN17WoZLuKn8A+tHmtoIlJK0rFyllo
         exfCZ8eRF6dwPkBWXMAki4YxqIhA5lG3XIKNFjuwb7IFotweWg4WuJHsZaXl/cxdvL5n
         +tTImTkfVv1SGGnPpnqVqKe9rvcts+Drsjr5SlrOW/PRxmK7QMAO/10v6PLKQXetvGpH
         VHtAWISmY9BqdRC8UmjwS/Pgc5jI8X6wxsRR/BHKstXsuPuVlfXLvqvYrSlRCO80EFBp
         QYkBU2Typii77/HH4VwThJC8+PrIoLssWqWU7UxXdHbulOs7u/GW2de6PizdzcQsn02E
         8EAw==
X-Forwarded-Encrypted: i=1; AJvYcCW+oPG64A/eSm4cgjeEvWkFy9OE57zjZYpq+Ydd6AW3bGUZ3/r0FCuMRhdnRDO4hKfsgilrcrDax9n+X/sAdRaTBsHk6njcQGKxrGCl3hXy
X-Gm-Message-State: AOJu0YzcBbzWPXhR6Sz5qmTnLeZWSJi9evozAKADR0jFPJY7PvB37u/D
	fwVcgu3PAsGQNE01GCsfJQky/X2cWnQfqR4ZBYZmZKPSLM+YovfLVv80KIuIaMxPEkNgqh1n8lC
	D2uKqBIt1ow==
X-Google-Smtp-Source: AGHT+IFfrDRpqPxG6V89G/9xGljq5m4jX1zEjkDMzFQgw42PzAbdt0C893N+Ot4519M06eCP0IwzsIvp0hltgA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:8751:0:b0:e0b:af9b:fb79 with SMTP id
 3f1490d57ef6-e1180e45104mr75687276.3.1723783903487; Thu, 15 Aug 2024 21:51:43
 -0700 (PDT)
Date: Fri, 16 Aug 2024 12:51:22 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240816045123.1934387-2-davidgow@google.com>
Subject: [PATCH v2] kunit: Device wrappers should also manage driver name
From: David Gow <davidgow@google.com>
To: Kees Cook <kees@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Rae Moar <rmoar@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Nico Pache <npache@redhat.com>, Ivan Orlov <ivan.orlov0322@gmail.com>, 
	Erhard Furtner <erhard_f@mailbox.org>
Cc: David Gow <davidgow@google.com>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
Content-Type: text/plain; charset="UTF-8"

kunit_driver_create() accepts a name for the driver, but does not copy
it, so if that name is either on the stack, or otherwise freed, we end
up with a use-after-free when the driver is cleaned up.

Instead, strdup() the name, and manage it as another KUnit allocation.
As there was no existing kunit_kstrdup(), we add one. Further, add a
kunit_ variant of strdup_const() and kfree_const(), so we don't need to
allocate and manage the string in the majority of cases where it's a
constant.

However, these are inline functions, and is_kernel_rodata() only works
for built-in code. This causes problems in two cases:
- If kunit is built as a module, __{start,end}_rodata is not defined.
- If a kunit test using these functions is built as a module, it will
  suffer the same fate.

This fixes a KASAN splat with overflow.overflow_allocation_test, when
built as a module.

Restrict the is_kernel_rodata() case to when KUnit is built as a module,
which fixes the first case, at the cost of losing the optimisation.

Also, make kunit_{kstrdup,kfree}_const non-inline, so that other modules
using them will not accidentally depend on is_kernel_rodata(). If KUnit
is built-in, they'll benefit from the optimisation, if KUnit is not,
they won't, but the string will be properly duplicated.

Fixes: d03c720e03bd ("kunit: Add APIs for managing devices")
Reported-by: Nico Pache <npache@redhat.com>
Closes: https://groups.google.com/g/kunit-dev/c/81V9b9QYON0
Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Rae Moar <rmoar@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---

This is a combination of the previous version of this patch with the
follow-up fix "kunit: Fix kunit_kstrdup_const() with modules".

kunit_kstrdup_const() now falls back to kstrdup() if KUnit is built as a
module, and is no longer inlined. This should fix the issues we'd seen
before.

I've not tried doing something fancy by looking at module rodata
sections: it might be a possible optimisation, but it seems like it'd
overcomplicate things for this initial change. If we hit a KUnit test
where this is a bottleneck (or if I have some more spare time), we can
look into it.

The overflow_kunit test has been fixed independently to not rely on this
anyway, so there shouldn't be any current cases of this causing issues,
but it's worth making the API robust regardless.

Changes since previous version:
https://lore.kernel.org/linux-kselftest/20240731070207.3918687-1-davidgow@google.com/
- Fix module support by integrating:
  https://lore.kernel.org/linux-kselftest/20240806020136.3481593-1-davidgow@google.com/

---
 include/kunit/test.h | 48 ++++++++++++++++++++++++++++++++++++++++++++
 lib/kunit/device.c   |  7 +++++--
 lib/kunit/test.c     | 19 ++++++++++++++++++
 3 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index e2a1f0928e8b..5ac237c949a0 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -28,6 +28,7 @@
 #include <linux/types.h>
 
 #include <asm/rwonce.h>
+#include <asm/sections.h>
 
 /* Static key: true if any KUnit tests are currently running */
 DECLARE_STATIC_KEY_FALSE(kunit_running);
@@ -480,6 +481,53 @@ static inline void *kunit_kcalloc(struct kunit *test, size_t n, size_t size, gfp
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
+void kunit_kfree_const(struct kunit *test, const void *x);
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
+ * kunit_kfree_const() -- not kunit_kfree().
+ * See kstrdup_const() and kunit_kmalloc_array() for more information.
+ */
+const char *kunit_kstrdup_const(struct kunit *test, const char *str, gfp_t gfp);
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
 
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index e8b1b52a19ab..089c832e3cdb 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -874,6 +874,25 @@ void kunit_kfree(struct kunit *test, const void *ptr)
 }
 EXPORT_SYMBOL_GPL(kunit_kfree);
 
+void kunit_kfree_const(struct kunit *test, const void *x)
+{
+#if !IS_MODULE(CONFIG_KUNIT)
+	if (!is_kernel_rodata((unsigned long)x))
+#endif
+		kunit_kfree(test, x);
+}
+EXPORT_SYMBOL_GPL(kunit_kfree_const);
+
+const char *kunit_kstrdup_const(struct kunit *test, const char *str, gfp_t gfp)
+{
+#if !IS_MODULE(CONFIG_KUNIT)
+	if (is_kernel_rodata((unsigned long)str))
+		return str;
+#endif
+	return kunit_kstrdup(test, str, gfp);
+}
+EXPORT_SYMBOL_GPL(kunit_kstrdup_const);
+
 void kunit_cleanup(struct kunit *test)
 {
 	struct kunit_resource *res;
-- 
2.46.0.184.g6999bdac58-goog


