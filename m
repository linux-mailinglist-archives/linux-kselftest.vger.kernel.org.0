Return-Path: <linux-kselftest+bounces-39095-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02912B27E65
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 12:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21023AA10BA
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 10:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15303002B1;
	Fri, 15 Aug 2025 10:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4Ez2DVcu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1452C2FFDF1
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Aug 2025 10:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755254178; cv=none; b=UgvUUmvfA269A2T1zO2e/+g7gz6UUTKqMioINdndCx+JtJrsPx3+xkLzLjKwhDD4YVur204MuvEdka+fwpkwB9M+bnWEKXqriuyp31Q1+R5zBl5cgKUoHAwP4594kTAdBsyKa3rGCMRovAVhPGf7i/x5AD13gysCkCiWy/JtDHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755254178; c=relaxed/simple;
	bh=WzKOwOZ/Egx5fUkYaQAlnWSmFemcKYO4P0JLz87ddqU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LCe3zCZyrdYm4rQQbT2MNbsJJcFfAjtjdYniRLJmb7APFQJ6uE5ddr6dHV/e/oTTarqdW6ONqisYPkiymbgaclWVcoj/xxscwTvSEw+slC4AkMnd1r2J8HL0KWKHnjKj5UGoBdcn5FhGnIqdNTkrLVNI4uWPjq5mJNwQwnz24L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4Ez2DVcu; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4b109919a51so75858411cf.0
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Aug 2025 03:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755254176; x=1755858976; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BONUnu1NKFOsWRPuaKEG6QiZAgg+IitETz5ddIXNoOc=;
        b=4Ez2DVcuEWrpsowGNCWBVt9dRxfLT62JSIVYnlhNQjBTdOZBISyTZeqDTXJHg+1c4S
         uR8c7yoZ1915bCNdGRswr7ztbq1lEfnUpHvYDBNAITFFKhVCBLpL5mQO1TgV6tZCYjjD
         Tjs1aL+0JK/eQNtWKkSCCD5pl3iZa1DIj7Itvv7XzRYSOTmbTB7kreVL+jhuStGlM4No
         G5LaRKN5kz2Jebma7dW/SDQxEG8def2Pd3ZDdJ3c3q9IySrO3EWVjzBT7xyVuvCyjcrF
         Gd1ohlkEfxv1QWVeBxcA+XZsGN59p8aImaAaIcBs5yVDVO/lZXmMZL98CDI93NdZ+XlC
         dttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755254176; x=1755858976;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BONUnu1NKFOsWRPuaKEG6QiZAgg+IitETz5ddIXNoOc=;
        b=SJfApo0TKOcrE1AFeMnuoY6qqNsWY/N5VVHtZlfwZPCYD2BeKraW75VRzw30L1f8jv
         5VflVtNMAG8RIxqzQkfUvkNoyPMHO6SHFscjJ4C/M6RCl4cI5dn0t+wZZshVitQ7Jmj2
         me9fQlYCkAI4N6mv/e1MUOfQzX6Jfkd6tmzow/WL0Hcpx7A0HMg2gv9+BObDeK83Xw+k
         5pCZZVEVJ3dvDEqxUUBII3BnSbjyLepyNpPaYVQ0Qf3rsBlS5bIclUloykKZ2gIKqe5X
         lRcPzROFruY6eEsnGghIuZ/AYOL0f9UIFcqm0iwyNErTp2Ct0w3+O/Ziy0rOsQ5zQpSn
         Il1A==
X-Forwarded-Encrypted: i=1; AJvYcCWczTf3xIPhnlrck7PAeHODWdUwqG5mgqw8atq2Qj6/74rKa7rxNv9wDdQgDYZ67FXTmWcKSlY6hH1H8XMfm+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfDrES/Qt+qY8T88/LuVBkAKocRr49ErKpORE4ToyKrzjjzlEf
	ly0MgvtDSY0Cvl/AsNY+isVSkfu/jtEi8KuLQFUgYSwedrYwX4RmUoDCcXkSUyzBXiKOfWdpZ/m
	uGwTDcx2IIpIvww==
X-Google-Smtp-Source: AGHT+IEcA9mV3vSJ0s1QyQh2RxJ/dCmFXZLqK+CHWderFPKfVsCVEdy6IgdXgjKdrlUhFX5Rm47QMzQ9n3WdHQ==
X-Received: from qtbih3.prod.google.com ([2002:a05:622a:6a83:b0:4ae:75d2:c21])
 (user=marievic job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:590a:0:b0:4b0:8057:1de9 with SMTP id d75a77b69052e-4b11e125b21mr15990631cf.3.1755254175914;
 Fri, 15 Aug 2025 03:36:15 -0700 (PDT)
Date: Fri, 15 Aug 2025 10:36:00 +0000
In-Reply-To: <20250815103604.3857930-1-marievic@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815103604.3857930-1-marievic@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250815103604.3857930-4-marievic@google.com>
Subject: [PATCH v3 3/7] kunit: Pass parameterized test context to generate_params()
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
---

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
index 917df2e1688d..ac8fa8941a6a 100644
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
2.51.0.rc1.167.g924127e9c0-goog


