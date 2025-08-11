Return-Path: <linux-kselftest+bounces-38720-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE62DB21833
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 00:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA5151A22953
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 22:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686E92E5439;
	Mon, 11 Aug 2025 22:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k5tLIDdN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3732E5425
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 22:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754950677; cv=none; b=X1m1YCEHrd+sPlkwDf3V4TouuPGPCCvjJRSS/hKRGjYuNKJQojs/677i1lktMz9tQMEQRrdviPVk+czWYFLY/w6q9J3UPqPWWcON3xVOB/kRiWFieM6TqtfqTZTaltBHBfezJXPsyPFh22Ek33PHg+5MmNEfV+xO8TiWpZo7WfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754950677; c=relaxed/simple;
	bh=AuuW0InWCQk9tTKVdsuO4GpylrRHeulwSYbA66YdFlg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ttGKGPX5doyxUv0shtHeH/IMLu2Ef2Yk2avyKD2sX8sLyoNijaSA3TYFqZ7aWtjaIMqBi113WpOoBhuosWwgIx4xe+cou1DobJbPq2aY4j7Q6T5TFek1r/B9cA7PeboFboKEMmWtTxVI7IXcjCx/PNLd7I6CbxYbamGG5iMC//g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k5tLIDdN; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4b065932d0bso145847191cf.3
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 15:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754950674; x=1755555474; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c1k/A69TckTlEbMn2yQThZDMwfxta59hKgkCx2fsjOU=;
        b=k5tLIDdNbeEtQFQ0Sfo89bLd4PtFapUpyhm5bnUqxy9yrcqUERtT2fMzOthuhGb6HN
         Y2jMxJMjEOZblq0mqgZ7RPTVouoQTK8aEANMZxXyPkP2MNchyx2Ugfb8PrB0/FQ2O4HU
         Ub8EWEHg0wk58On79P9HEYR7n5YKivv5M2ZsLBCUGqwDGQJM0avbnCY29yiSz026d2QN
         Mlxpqj74oJfCrkH+XI1XDhxsp4+0S+8wpNqbGYryav/tmjqM1zPC4CaHuYrEIA4hEu10
         y8LMl2opaGAOFNpg2JHcY3jaWxML69ayuSDSH68OJ8F/pLrVE9jGZSxcaPrsVnLAFbsT
         NnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754950674; x=1755555474;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c1k/A69TckTlEbMn2yQThZDMwfxta59hKgkCx2fsjOU=;
        b=RjlVGwu1Y2f9PzgjnFlEJxZ1pEXjPwSXOm+OCoZGpp8bJcQfQpnDn0IY+2Uhd4qu5V
         2CVGOt5jCGrE544A3ErBenMUTN2dr0h8XdriMrMOBXcHOsm2XBf2/OqzH8X4LN/iiPKb
         GyoS7CwVw0h/CywqezVpdkgsOvkqOwesHBRvbW9v7p2HTgBNlNVmfDGrlvR2NFOsZlVH
         GBx81jKFrLgR1tHQd0aS4NANfnQEcxCfr7xZ0VvbZQvQZeRMeTz/a6evGee6lJYI0kUF
         bSz4Rh1wvVUoGUq5YZMlRDuaKrbcpImWd7dFulJf95VvOFXZZnuETSzqP6KhyoB5VDKF
         ISFw==
X-Forwarded-Encrypted: i=1; AJvYcCV7EnsJzI8HXxoEC0d1am8VpUmyRR9aD7bzmkTbZExLtNJ92ppAZBPywWkmXQGcyqbFAqbWFcby6/PJ+XpdYNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS7Ey1YjoGzhEtnx1Yx/PIi8GeMDSVGpuui5Z/1WR0LptTBE5L
	vIskwld9HDaWFH4kEY3giz1q8ML8ob2vIQbD12tppqPLKTV+bb8eBmTHd8w/KWghC8QtyQ0fyvP
	85FGV2DN2BKDJ3w==
X-Google-Smtp-Source: AGHT+IG/qveeEReHM0gDJd2Ok+O/CFZMWEx9/kt8KnHeEQT3ZmM6/JD4IgQ+YGLJNJOK2u1VlEc+7OxU54BkFw==
X-Received: from qtbfd13.prod.google.com ([2002:a05:622a:4d0d:b0:4ab:b3a4:9650])
 (user=marievic job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:18a6:b0:4ab:66c5:b265 with SMTP id d75a77b69052e-4b0ecaeac57mr23998721cf.0.1754950674545;
 Mon, 11 Aug 2025 15:17:54 -0700 (PDT)
Date: Mon, 11 Aug 2025 22:17:35 +0000
In-Reply-To: <20250811221739.2694336-1-marievic@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250811221739.2694336-1-marievic@google.com>
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250811221739.2694336-4-marievic@google.com>
Subject: [PATCH v2 3/7] kunit: Pass parameterized test context to generate_params()
From: Marie Zhussupova <marievic@google.com>
To: rmoar@google.com, davidgow@google.com, shuah@kernel.org, 
	brendan.higgins@linux.dev
Cc: mark.rutland@arm.com, elver@google.com, dvyukov@google.com, 
	lucas.demarchi@intel.com, thomas.hellstrom@linux.intel.com, 
	rodrigo.vivi@intel.com, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, kasan-dev@googlegroups.com, 
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Marie Zhussupova <marievic@google.com>
Content-Type: text/plain; charset="UTF-8"

To enable more complex parameterized testing scenarios,
the generate_params() function needs additional context
beyond just the previously generated parameter. This patch
modifies the generate_params() function signature to
include an extra `struct kunit *test` argument, giving
test users access to the parameterized test context when
generating parameters.

The `struct kunit *test` argument was added as the first parameter
to the function signature as it aligns with the convention
of other KUnit functions that accept `struct kunit *test` first.
This also mirrors the "this" or "self" reference found
in object-oriented programming languages.

This patch also modifies xe_pci_live_device_gen_param()
in xe_pci.c and nthreads_gen_params() in kcsan_test.c
to reflect this signature change.

Signed-off-by: Marie Zhussupova <marievic@google.com>
---

Changes in v2:

- generate_params signature changes in
  xe_pci.c and kcsan_test.c were squashed
  into a single patch to avoid in-between
  breakages in the series.
- The comments and the commit message were changed to
  reflect the parameterized testing terminology. See
  the patch series cover letter change log for the
  definitions.

---
 drivers/gpu/drm/xe/tests/xe_pci.c | 2 +-
 include/kunit/test.h              | 9 ++++++---
 kernel/kcsan/kcsan_test.c         | 2 +-
 lib/kunit/test.c                  | 5 +++--
 4 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/xe/tests/xe_pci.c b/drivers/gpu/drm/xe/tests/xe_pci.c
index 1d3e2e50c355..62c016e84227 100644
--- a/drivers/gpu/drm/xe/tests/xe_pci.c
+++ b/drivers/gpu/drm/xe/tests/xe_pci.c
@@ -129,7 +129,7 @@ EXPORT_SYMBOL_IF_KUNIT(xe_pci_fake_device_init);
  * Return: pointer to the next &struct xe_device ready to be used as a parameter
  *         or NULL if there are no more Xe devices on the system.
  */
-const void *xe_pci_live_device_gen_param(const void *prev, char *desc)
+const void *xe_pci_live_device_gen_param(struct kunit *test, const void *prev, char *desc)
 {
 	const struct xe_device *xe = prev;
 	struct device *dev = xe ? xe->drm.dev : NULL;
diff --git a/include/kunit/test.h b/include/kunit/test.h
index d2e1b986b161..b527189d2d1c 100644
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
@@ -1691,7 +1692,8 @@ do {									       \
  * Define function @name_gen_params which uses @array to generate parameters.
  */
 #define KUNIT_ARRAY_PARAM(name, array, get_desc)						\
-	static const void *name##_gen_params(const void *prev, char *desc)			\
+	static const void *name##_gen_params(struct kunit *test,				\
+					     const void *prev, char *desc)			\
 	{											\
 		typeof((array)[0]) *__next = prev ? ((typeof(__next)) prev) + 1 : (array);	\
 		if (__next - (array) < ARRAY_SIZE((array))) {					\
@@ -1712,7 +1714,8 @@ do {									       \
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
index c2871180edcc..fc76648525ac 100644
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
index 49a5e6c30c86..01b20702a5a2 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -695,7 +695,7 @@ int kunit_run_tests(struct kunit_suite *suite)
 			/* Get initial param. */
 			param_desc[0] = '\0';
 			/* TODO: Make generate_params try-catch */
-			curr_param = test_case->generate_params(NULL, param_desc);
+			curr_param = test_case->generate_params(&test, NULL, param_desc);
 			test_case->status = KUNIT_SKIPPED;
 			kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
 				  "KTAP version 1\n");
@@ -726,7 +726,8 @@ int kunit_run_tests(struct kunit_suite *suite)
 
 				/* Get next param. */
 				param_desc[0] = '\0';
-				curr_param = test_case->generate_params(curr_param, param_desc);
+				curr_param = test_case->generate_params(&test, curr_param,
+									param_desc);
 			}
 			/*
 			 * TODO: Put into a try catch. Since we don't need suite->exit
-- 
2.51.0.rc0.205.g4a044479a3-goog


