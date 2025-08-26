Return-Path: <linux-kselftest+bounces-39933-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBECB35893
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 11:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 360B17C2313
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 09:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460F6308F3A;
	Tue, 26 Aug 2025 09:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PfyA6XUh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332FA3093A6
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Aug 2025 09:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756199632; cv=none; b=roiXH+3ToCzONXg04F8rx430C7iXCHN8hY3YZU0u4DeKZKcDc5vv5PFMHoIZ7sM+FqoLHBQt5BIvvyG2OBG8pFdxVzUE9rSH6g7qO/bEDf5jj+BnAzud1F1eThxkiTwPcIahH4aZPIGLxcrF5cKYkvEDVfMLRgyuPVZsQ0+5XR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756199632; c=relaxed/simple;
	bh=riDptoiHOYi3XRCYC5H+gPi3YBs3p0cVYPBHp6fHT4A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qvxerfoRol7FManaM2y0b9+n4Qy9CpbT5e+Bp1nWL3RWtzOzSLfIDqeq/eJMzjaeS8AAdieqyL68HwIWfQwRccYwN5c0Hfy68yfkw8n5xZr0xIT9pFQzcXIs3SzaujZ3r0PaWPT9V46TE2PaJmhzG9J+IT/9UjEjwiM7lpDlPvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PfyA6XUh; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-771e7d00fd4so2460054b3a.2
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Aug 2025 02:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756199629; x=1756804429; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wOxgoJJJ8SZ3HeZjErz3bRaIvB/ECPnvmYM5E2IyxbQ=;
        b=PfyA6XUhDi50znW/4VwwIMagKB70QBPnJKilYqJcM6DGemkZpod6E+E0wp5GBqDo/i
         kAJOKmQxZfAMDNjGd+1uBUH0OkBye2yu4VAFQrDPJdK+Erphk4A7GTKDoYCNsIoniCVX
         sw/sr0Y08thw6bsCmSb+lrdFsUkm4CZmbfHb2TPHtn6S9lSrJFdgaibiCXMkQO4OTWHd
         +fSlMbRs79SE6KYxW4lOD3hC1o3EBFaKMavYwNwKDkinotLxwyf+cAyxvDuvCVVpqIRq
         OvC0dOfsuDdOUENarVIeX0S9yKYm5XwSv3PgTNF9j+3s0F30pfo7TS4BJ0rwd42l9dm+
         P7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756199629; x=1756804429;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wOxgoJJJ8SZ3HeZjErz3bRaIvB/ECPnvmYM5E2IyxbQ=;
        b=c8FYHujZI+XnLkbDHb1vrjhQ9mkui6Ym6pUmt/AdM43QDyO8PBWLMTyXW0Xo0uIEbB
         a0IbNV9c9u8REKYdJIM0yOF8EH5h6ozhMt7Snw80ZHbVYArWimjVgY+/DOxrYlyTlZ/S
         nCXDDuOjawR2TjE0oOi8D3Mb9wTGDKoQtKWPVzABAGKlwa1mo9YIw5PMxidcYn/nONm7
         FtgSF8UzAMpvqF4Nhi9R+Hm/Lk0g7RjxtIC7iXBsIp3C5dmXarFOtaRdqTi1uyKMgMfj
         bXJRBvWti8wFjgxToBVViwbsyqCXENNSGqRW7yaspZ9+1n8lfp66VJt6OJ/A+wmg7Dr8
         AApQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrlfirLS8GhvZY5TO3RaZua41d/1YSaj/zXuzfndgZho7oOi5lZUJd9DdUluugZ/Cm44bqMgLCQbYE6LHUcYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZWBtTQO1RK2Ge1gSZv/iB3HAleAQ7qKPDLtnFufPVabzwoX+Q
	5zOfZmKB3jwAQMs7BcpB8ZVpB8srM6QFj1em0v3P3HBo5GPrcKMRGBgJDK8q6ge0or0z95FguIw
	gCw+C2yZjvv7HSQ==
X-Google-Smtp-Source: AGHT+IHgOfXfiRixc9DNGQsel6kZ84cURw6Em9ox/O6G5u8K+rIPYnapy1P78kwhi3bDoiirsFCy+wrz1erCSg==
X-Received: from pfbkw7.prod.google.com ([2002:a05:6a00:94f7:b0:74b:41c0:e916])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:14c4:b0:771:fbb0:b1ce with SMTP id d2e1a72fcca58-771fbb0b3dfmr1136261b3a.25.1756199629409;
 Tue, 26 Aug 2025 02:13:49 -0700 (PDT)
Date: Tue, 26 Aug 2025 17:13:33 +0800
In-Reply-To: <20250826091341.1427123-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250826091341.1427123-1-davidgow@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250826091341.1427123-4-davidgow@google.com>
Subject: [PATCH v4 3/7] kunit: Pass parameterized test context to generate_params()
From: David Gow <davidgow@google.com>
To: Marie Zhussupova <marievic@google.com>, marievictoria875@gmail.com, rmoar@google.com, 
	shuah@kernel.org, brendan.higgins@linux.dev
Cc: mark.rutland@arm.com, elver@google.com, dvyukov@google.com, 
	lucas.demarchi@intel.com, thomas.hellstrom@linux.intel.com, 
	rodrigo.vivi@intel.com, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, kasan-dev@googlegroups.com, 
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, 
	David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Marie Zhussupova <marievic@google.com>

To enable more complex parameterized testing scenarios, the
generate_params() function needs additional context beyond just
the previously generated parameter. This patch modifies the
generate_params() function signature to include an extra
`struct kunit *test` argument, giving test users access to the
parameterized test context when generating parameters.

The `struct kunit *test` argument was added as the first parameter
to the function signature as it aligns with the convention of other
KUnit functions that accept `struct kunit *test` first. This also
mirrors the "this" or "self" reference found in object-oriented
programming languages.

This patch also modifies xe_pci_live_device_gen_param() in xe_pci.c
and nthreads_gen_params() in kcsan_test.c to reflect this signature
change.

Reviewed-by: David Gow <davidgow@google.com>
Reviewed-by: Rae Moar <rmoar@google.com>
Acked-by: Marco Elver <elver@google.com>
Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Marie Zhussupova <marievic@google.com>
[Catch some additional gen_params signatures in drm/xe/tests --David]
Signed-off-by: David Gow <davidgow@google.com>
---

Changes in v4:
v3: https://lore.kernel.org/linux-kselftest/20250815103604.3857930-4-marievic@google.com/
- Fixup some additional generate_params signature changes in xe_pci.
- These are also available as a separate patch here:
  https://lore.kernel.org/linux-kselftest/20250821135447.1618942-1-davidgow@google.com/

Changes in v3:
v2: https://lore.kernel.org/all/20250811221739.2694336-4-marievic@google.com/
- Commit message formatting.

Changes in v2:
v1: https://lore.kernel.org/all/20250729193647.3410634-4-marievic@google.com/
    https://lore.kernel.org/all/20250729193647.3410634-5-marievic@google.com/
    https://lore.kernel.org/all/20250729193647.3410634-6-marievic@google.com/
- generate_params signature changes in xe_pci.c and kcsan_test.c were
  squashed into a single patch to avoid in-between breakages in the series.
- The comments and the commit message were changed to reflect the
  parameterized testing terminology. See the patch series cover letter
  change log for the definitions.

---
 drivers/gpu/drm/xe/tests/xe_pci.c      | 14 +++++++-------
 drivers/gpu/drm/xe/tests/xe_pci_test.h |  9 +++++----
 include/kunit/test.h                   |  9 ++++++---
 kernel/kcsan/kcsan_test.c              |  2 +-
 lib/kunit/test.c                       |  5 +++--
 5 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/xe/tests/xe_pci.c b/drivers/gpu/drm/xe/tests/xe_pci.c
index 9c715e59f030..f707e0a54295 100644
--- a/drivers/gpu/drm/xe/tests/xe_pci.c
+++ b/drivers/gpu/drm/xe/tests/xe_pci.c
@@ -44,9 +44,9 @@ KUNIT_ARRAY_PARAM(pci_id, pciidlist, xe_pci_id_kunit_desc);
  *
  * Return: pointer to the next parameter or NULL if no more parameters
  */
-const void *xe_pci_graphics_ip_gen_param(const void *prev, char *desc)
+const void *xe_pci_graphics_ip_gen_param(struct kunit *test, const void *prev, char *desc)
 {
-	return graphics_ip_gen_params(prev, desc);
+	return graphics_ip_gen_params(test, prev, desc);
 }
 EXPORT_SYMBOL_IF_KUNIT(xe_pci_graphics_ip_gen_param);
 
@@ -61,9 +61,9 @@ EXPORT_SYMBOL_IF_KUNIT(xe_pci_graphics_ip_gen_param);
  *
  * Return: pointer to the next parameter or NULL if no more parameters
  */
-const void *xe_pci_media_ip_gen_param(const void *prev, char *desc)
+const void *xe_pci_media_ip_gen_param(struct kunit *test, const void *prev, char *desc)
 {
-	return media_ip_gen_params(prev, desc);
+	return media_ip_gen_params(test, prev, desc);
 }
 EXPORT_SYMBOL_IF_KUNIT(xe_pci_media_ip_gen_param);
 
@@ -78,9 +78,9 @@ EXPORT_SYMBOL_IF_KUNIT(xe_pci_media_ip_gen_param);
  *
  * Return: pointer to the next parameter or NULL if no more parameters
  */
-const void *xe_pci_id_gen_param(const void *prev, char *desc)
+const void *xe_pci_id_gen_param(struct kunit *test, const void *prev, char *desc)
 {
-	const struct pci_device_id *pci = pci_id_gen_params(prev, desc);
+	const struct pci_device_id *pci = pci_id_gen_params(test, prev, desc);
 
 	return pci->driver_data ? pci : NULL;
 }
@@ -159,7 +159,7 @@ EXPORT_SYMBOL_IF_KUNIT(xe_pci_fake_device_init);
  * Return: pointer to the next &struct xe_device ready to be used as a parameter
  *         or NULL if there are no more Xe devices on the system.
  */
-const void *xe_pci_live_device_gen_param(const void *prev, char *desc)
+const void *xe_pci_live_device_gen_param(struct kunit *test, const void *prev, char *desc)
 {
 	const struct xe_device *xe = prev;
 	struct device *dev = xe ? xe->drm.dev : NULL;
diff --git a/drivers/gpu/drm/xe/tests/xe_pci_test.h b/drivers/gpu/drm/xe/tests/xe_pci_test.h
index ce4d2b86b778..6d8bc56f7bde 100644
--- a/drivers/gpu/drm/xe/tests/xe_pci_test.h
+++ b/drivers/gpu/drm/xe/tests/xe_pci_test.h
@@ -7,6 +7,7 @@
 #define _XE_PCI_TEST_H_
 
 #include <linux/types.h>
+#include <kunit/test.h>
 
 #include "xe_platform_types.h"
 #include "xe_sriov_types.h"
@@ -25,9 +26,9 @@ struct xe_pci_fake_data {
 
 int xe_pci_fake_device_init(struct xe_device *xe);
 
-const void *xe_pci_graphics_ip_gen_param(const void *prev, char *desc);
-const void *xe_pci_media_ip_gen_param(const void *prev, char *desc);
-const void *xe_pci_id_gen_param(const void *prev, char *desc);
-const void *xe_pci_live_device_gen_param(const void *prev, char *desc);
+const void *xe_pci_graphics_ip_gen_param(struct kunit *test, const void *prev, char *desc);
+const void *xe_pci_media_ip_gen_param(struct kunit *test, const void *prev, char *desc);
+const void *xe_pci_id_gen_param(struct kunit *test, const void *prev, char *desc);
+const void *xe_pci_live_device_gen_param(struct kunit *test, const void *prev, char *desc);
 
 #endif
diff --git a/include/kunit/test.h b/include/kunit/test.h
index fc8fd55b2dfb..8eba1b03c3e3 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -128,7 +128,8 @@ struct kunit_attributes {
 struct kunit_case {
 	void (*run_case)(struct kunit *test);
 	const char *name;
-	const void* (*generate_params)(const void *prev, char *desc);
+	const void* (*generate_params)(struct kunit *test,
+				       const void *prev, char *desc);
 	struct kunit_attributes attr;
 	int (*param_init)(struct kunit *test);
 	void (*param_exit)(struct kunit *test);
@@ -1703,7 +1704,8 @@ do {									       \
  * Define function @name_gen_params which uses @array to generate parameters.
  */
 #define KUNIT_ARRAY_PARAM(name, array, get_desc)						\
-	static const void *name##_gen_params(const void *prev, char *desc)			\
+	static const void *name##_gen_params(struct kunit *test,				\
+					     const void *prev, char *desc)			\
 	{											\
 		typeof((array)[0]) *__next = prev ? ((typeof(__next)) prev) + 1 : (array);	\
 		if (__next - (array) < ARRAY_SIZE((array))) {					\
@@ -1724,7 +1726,8 @@ do {									       \
  * Define function @name_gen_params which uses @array to generate parameters.
  */
 #define KUNIT_ARRAY_PARAM_DESC(name, array, desc_member)					\
-	static const void *name##_gen_params(const void *prev, char *desc)			\
+	static const void *name##_gen_params(struct kunit *test,				\
+					     const void *prev, char *desc)			\
 	{											\
 		typeof((array)[0]) *__next = prev ? ((typeof(__next)) prev) + 1 : (array);	\
 		if (__next - (array) < ARRAY_SIZE((array))) {					\
diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index 49ab81faaed9..a13a090bb2a7 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -1383,7 +1383,7 @@ static void test_atomic_builtins_missing_barrier(struct kunit *test)
  * The thread counts are chosen to cover potentially interesting boundaries and
  * corner cases (2 to 5), and then stress the system with larger counts.
  */
-static const void *nthreads_gen_params(const void *prev, char *desc)
+static const void *nthreads_gen_params(struct kunit *test, const void *prev, char *desc)
 {
 	long nthreads = (long)prev;
 
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 0fe61dec5a96..50705248abad 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -700,7 +700,7 @@ int kunit_run_tests(struct kunit_suite *suite)
 			/* Get initial param. */
 			param_desc[0] = '\0';
 			/* TODO: Make generate_params try-catch */
-			curr_param = test_case->generate_params(NULL, param_desc);
+			curr_param = test_case->generate_params(&test, NULL, param_desc);
 			test_case->status = KUNIT_SKIPPED;
 			kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
 				  "KTAP version 1\n");
@@ -731,7 +731,8 @@ int kunit_run_tests(struct kunit_suite *suite)
 
 				/* Get next param. */
 				param_desc[0] = '\0';
-				curr_param = test_case->generate_params(curr_param, param_desc);
+				curr_param = test_case->generate_params(&test, curr_param,
+									param_desc);
 			}
 			/*
 			 * TODO: Put into a try catch. Since we don't need suite->exit
-- 
2.51.0.261.g7ce5a0a67e-goog


