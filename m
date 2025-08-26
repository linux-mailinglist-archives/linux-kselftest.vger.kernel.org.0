Return-Path: <linux-kselftest+bounces-39932-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6075DB3586A
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 11:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34D611B27EB8
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 09:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDC130AAA5;
	Tue, 26 Aug 2025 09:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OvbFbj+z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED86307488
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Aug 2025 09:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756199631; cv=none; b=AnDf6VmjabPSFRcrEGINS/EtKP2EUm1eJu0jWbeRxweMU42yW6U61t2su/J6gjwE41fjzhKbiLvl9CcqnDyAwx9ajb8b601+FRqDRfsYHHdxpaseM2HvCtgMw55rO4CIILVwTmH3DprURUeKcRh47mGJ61k1ts3wZdPXbkQXKxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756199631; c=relaxed/simple;
	bh=wGgvEBopG7WMewdUpXEs8e+lMZNdr6DC+bP2gJlld6w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m80FhfPeSAfWTD1cfYLzmiXjO34j1vrF/ufYA065KMpfi/Io7LuH3L/x1c7Qglm88OchCGzXlqJmPL/16gDLKd8A7GrATWbsV74HZLC9+50r2W5/0nijCX5xq1wr+KoZ5aBal8sE6FpgkDnsIWI4rP/AMKA+vZlNKXZ4XvQ2QoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OvbFbj+z; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b47174c65b0so9199282a12.2
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Aug 2025 02:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756199628; x=1756804428; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QTTACq/njMLngdxpMSOXC5XIjUnoWbM4E4SA6Lndzr0=;
        b=OvbFbj+zYqST0wa9T53VqJvgBIirWqEkKjOmwiZpnAGF1tO7x5LBaiqqlTXy+PvsuY
         D8MTBuQTU8lt9Bg0neE5hOABU4AkiFSITYKTxGPBX+mDxrTZhJBknkHdP9z951w8j36G
         dokN6DaNuASgDN2Q06jJBoOwx9m+RL8MEcGDl3kvNlLuDDNpOwbO9Y85K2hCAiwgabck
         J8e/hk0cmPd54mEPvJNhnk3n9Fz3nNIMuCSrXPqGqxh8kEVg/rSzudl+clQRKMjVAuU/
         RZS2XMaL2chvCElqY86lHY3tc6YhBEyZDgEVCRp+6nrLznKu7FuNSWBpUA5yDVAxiyBW
         PQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756199628; x=1756804428;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QTTACq/njMLngdxpMSOXC5XIjUnoWbM4E4SA6Lndzr0=;
        b=M8b753uoXRh7xf36Pf4x+dXqVqluL5Z9fZ9cfAX30iOlWLxyQzLzCTi9Dc5yIM8+XW
         WN0DE4PcTA5JjI41O6rIb79FDTvRr7VRGvTNvwr8Q2QdgYgtoEwmK1pxXyWEx+7+V9Vc
         nsHFRs2niYgIQ2yeukkIzTJfA18rAleHhaxz5vNCqkc2xmEp0dq9MRs9/ef9ccW21qUK
         UkkPTvlyv121foDPB8uS7k/mJk0XHMhL+X4kB7F//aBKnOat9J4/OB+vLWJmbP8tVPmF
         +EhmBVBhoT/rGEKK3H70cVqx4B/OCnNkMz1n8wkig0X+jo0qhDzox0zRFqgybz5UwGY1
         JxRg==
X-Forwarded-Encrypted: i=1; AJvYcCW9epU9sRaz0oayjJtNPDQNpvz6Rm4z5dvJEFeoQyMAqWzdqEwNMvtaSsu/GReSWcQn6ozSDfZA78EGj7ITGZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0VzTAJLPMFEDhvsEB4KHbUepYYhhNiSrrDUceVmc9dUNaRMPY
	S2KwjSarJTSOotO3ht1bDE2f/5NrStbMNnb/UOaBE3pIjFetRE8PVCpBj6mRJGv4a9Fum6vdgV+
	NUvBDZSZcc83ZKQ==
X-Google-Smtp-Source: AGHT+IE+/6MMrkJ74E5uKO4Fuz0dZBNo3Mw+DWRHhhpD3bwunApBgF7++zob2WkBdMyiTfsv7vnhKVDOwX2G5Q==
X-Received: from plpj12.prod.google.com ([2002:a17:903:3d8c:b0:246:1edd:3919])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ccc4:b0:248:79d4:939e with SMTP id d9443c01a7336-24879d49812mr6538095ad.39.1756199627892;
 Tue, 26 Aug 2025 02:13:47 -0700 (PDT)
Date: Tue, 26 Aug 2025 17:13:32 +0800
In-Reply-To: <20250826091341.1427123-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250826091341.1427123-1-davidgow@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250826091341.1427123-3-davidgow@google.com>
Subject: [PATCH v4 2/7] kunit: Introduce param_init/exit for parameterized
 test context management
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

Add (*param_init) and (*param_exit) function pointers to
`struct kunit_case`. Users will be able to set them via the new
KUNIT_CASE_PARAM_WITH_INIT() macro.

param_init/exit will be invoked by kunit_run_tests() once before and once
after the parameterized test, respectively. They will receive the
`struct kunit` that holds the parameterized test context; facilitating
init and exit for shared state.

This patch also sets param_init/exit to None in rust/kernel/kunit.rs.

Reviewed-by: Rae Moar <rmoar@google.com>
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Marie Zhussupova <marievic@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---

No changes in v4:
v3: https://lore.kernel.org/linux-kselftest/20250815103604.3857930-3-marievic@google.com/

Changes in v3:
v2: https://lore.kernel.org/all/20250811221739.2694336-3-marievic@google.com/
- kunit_init_parent_param_test() now sets both the `struct kunit_case`
  and the `struct kunit` statuses as failed if the parameterized test
  init failed. The failure message was also changed to include the failure
  code, mirroring the kunit_suite init failure message.
- A check for parameter init failure was added in kunit_run_tests(). So,
  if the init failed, the framework will skip the parameter runs and
  update the param_test statistics to count that failure.
- Commit message formatting.

Changes in v2:
v1: https://lore.kernel.org/all/20250729193647.3410634-3-marievic@google.com/
- param init/exit were set to None in rust/kernel/kunit.rs to fix the
  Rust breakage.
- The name of __kunit_init_parent_test was changed to
  kunit_init_parent_param_test and its call was changed to happen only
  if the test is parameterized.
- The param_exit call was also moved inside the check for if the test is
  parameterized.
- KUNIT_CASE_PARAM_WITH_INIT() macro logic was change to not automatically
  set generate_params() to KUnit's built-in generator function. Instead,
  the test user will be asked to provide it themselves.
- The comments and the commit message were changed to reflect the
  parameterized testing terminology. See the patch series cover letter
  change log for the definitions.


---
 include/kunit/test.h | 25 +++++++++++++++++++++++++
 lib/kunit/test.c     | 27 ++++++++++++++++++++++++++-
 rust/kernel/kunit.rs |  4 ++++
 3 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 9766403afd56..fc8fd55b2dfb 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -92,6 +92,8 @@ struct kunit_attributes {
  * @name:     the name of the test case.
  * @generate_params: the generator function for parameterized tests.
  * @attr:     the attributes associated with the test
+ * @param_init: The init function to run before a parameterized test.
+ * @param_exit: The exit function to run after a parameterized test.
  *
  * A test case is a function with the signature,
  * ``void (*)(struct kunit *)``
@@ -128,6 +130,8 @@ struct kunit_case {
 	const char *name;
 	const void* (*generate_params)(const void *prev, char *desc);
 	struct kunit_attributes attr;
+	int (*param_init)(struct kunit *test);
+	void (*param_exit)(struct kunit *test);
 
 	/* private: internal use only. */
 	enum kunit_status status;
@@ -218,6 +222,27 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
 		  .generate_params = gen_params,				\
 		  .attr = attributes, .module_name = KBUILD_MODNAME}
 
+/**
+ * KUNIT_CASE_PARAM_WITH_INIT - Define a parameterized KUnit test case with custom
+ * param_init() and param_exit() functions.
+ * @test_name: The function implementing the test case.
+ * @gen_params: The function to generate parameters for the test case.
+ * @init: A reference to the param_init() function to run before a parameterized test.
+ * @exit: A reference to the param_exit() function to run after a parameterized test.
+ *
+ * Provides the option to register param_init() and param_exit() functions.
+ * param_init/exit will be passed the parameterized test context and run once
+ * before and once after the parameterized test. The init function can be used
+ * to add resources to share between parameter runs, and any other setup logic.
+ * The exit function can be used to clean up resources that were not managed by
+ * the parameterized test, and any other teardown logic.
+ */
+#define KUNIT_CASE_PARAM_WITH_INIT(test_name, gen_params, init, exit)		\
+		{ .run_case = test_name, .name = #test_name,			\
+		  .generate_params = gen_params,				\
+		  .param_init = init, .param_exit = exit,			\
+		  .module_name = KBUILD_MODNAME}
+
 /**
  * struct kunit_suite - describes a related collection of &struct kunit_case
  *
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 587b5c51db58..0fe61dec5a96 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -641,6 +641,20 @@ static void kunit_accumulate_stats(struct kunit_result_stats *total,
 	total->total += add.total;
 }
 
+static void kunit_init_parent_param_test(struct kunit_case *test_case, struct kunit *test)
+{
+	if (test_case->param_init) {
+		int err = test_case->param_init(test);
+
+		if (err) {
+			kunit_err(test_case, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
+				"# failed to initialize parent parameter test (%d)", err);
+			test->status = KUNIT_FAILURE;
+			test_case->status = KUNIT_FAILURE;
+		}
+	}
+}
+
 int kunit_run_tests(struct kunit_suite *suite)
 {
 	char param_desc[KUNIT_PARAM_DESC_SIZE];
@@ -678,6 +692,11 @@ int kunit_run_tests(struct kunit_suite *suite)
 			kunit_run_case_catch_errors(suite, test_case, &test);
 			kunit_update_stats(&param_stats, test.status);
 		} else {
+			kunit_init_parent_param_test(test_case, &test);
+			if (test_case->status == KUNIT_FAILURE) {
+				kunit_update_stats(&param_stats, test.status);
+				goto test_case_end;
+			}
 			/* Get initial param. */
 			param_desc[0] = '\0';
 			/* TODO: Make generate_params try-catch */
@@ -714,10 +733,16 @@ int kunit_run_tests(struct kunit_suite *suite)
 				param_desc[0] = '\0';
 				curr_param = test_case->generate_params(curr_param, param_desc);
 			}
+			/*
+			 * TODO: Put into a try catch. Since we don't need suite->exit
+			 * for it we can't reuse kunit_try_run_cleanup for this yet.
+			 */
+			if (test_case->param_exit)
+				test_case->param_exit(&test);
 			/* TODO: Put this kunit_cleanup into a try-catch. */
 			kunit_cleanup(&test);
 		}
-
+test_case_end:
 		kunit_print_attr((void *)test_case, true, KUNIT_LEVEL_CASE);
 
 		kunit_print_test_stats(&test, param_stats);
diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 41efd87595d6..b1c97f8029c7 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -210,6 +210,8 @@ pub const fn kunit_case(
         status: kernel::bindings::kunit_status_KUNIT_SUCCESS,
         module_name: core::ptr::null_mut(),
         log: core::ptr::null_mut(),
+        param_init: None,
+        param_exit: None,
     }
 }
 
@@ -229,6 +231,8 @@ pub const fn kunit_case_null() -> kernel::bindings::kunit_case {
         status: kernel::bindings::kunit_status_KUNIT_SUCCESS,
         module_name: core::ptr::null_mut(),
         log: core::ptr::null_mut(),
+        param_init: None,
+        param_exit: None,
     }
 }
 
-- 
2.51.0.261.g7ce5a0a67e-goog


