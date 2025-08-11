Return-Path: <linux-kselftest+bounces-38719-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9E5B2182F
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 00:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33A0F464035
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 22:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D8E2E3B1B;
	Mon, 11 Aug 2025 22:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AAR47EZJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272E12E2DE7
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 22:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754950672; cv=none; b=bJCN0amhf6MevFPZ6KfbmH7y81OHUby0F4mLRmjba+or8WRTzr2Ii3Jha+zGtcuwoEDvIk59i5Xt3xPbnzmC1ZaAnklSJY0GVlui96lZBIpXIlvI9t3nzWmCKvbvWEI4JQsEp8G/HMZOzig8DrUY/9Ce7S5A86viUmfQlIPZsfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754950672; c=relaxed/simple;
	bh=IMEgfP4CCzqoSEkMoAKIhVE+KHIxb6e15QS5v2PdyIc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c3YQhaMgN2aMAZ5MEklpImEtM4O1LBBwuum5cefOlgPNhZAjnWYHPktAV+Ev7EDkbS19WTE3ggUf+lHP5CGPJcaEWZCqVTQVHb5pOMYwpI51RJrLpg0MolwxqMWlSb/Cbemd28XMhBPPlLJN+yUDDFXVGjVn9VJMg/FK71TjaEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AAR47EZJ; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7e7ffe84278so991688185a.2
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 15:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754950670; x=1755555470; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tOKMohtGJshnbgrwq7yuoLuH6EcijO5VHFU8Cl1yLsQ=;
        b=AAR47EZJea03fPQ/QGo6UNUrwJE5LUgr7VeVUxWDext7fxoyS9MVYigwLz2b3rouwX
         OrQrETVKcQoywrm+RXYBNcF4sO/QSnZqGWirSW5/TFbXoMdew/0EE+MySeCzM7S+dcjH
         AuUxcFlYEiFvuipix8CG2AEO4k9IZSr12tFz7y1PMo39RUI6Tpy8zebXj/6LP5uNJp5y
         cg4fP1Sju2oe0c9b6z+qZ5MVNYPU//sgZBZF3BH5ZIJPfRrbkT4dqLIw3vn4D8/kGqK9
         ASc5Uuk+7dldW8rEUU+HhB8gbc60whqUZwfSYve3xLf46DpFDZDASCZ7UM/T8W9DxOdA
         Cdtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754950670; x=1755555470;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tOKMohtGJshnbgrwq7yuoLuH6EcijO5VHFU8Cl1yLsQ=;
        b=JBT7ozhBUk1q6drKqRPe3DtMXPPxIiOAYwQe0rcG8tIp79bTyFZcJk065ZMT8Kd5Rt
         LbrTyz4goPE639Kmu/52/bOf6kDaK+d2R01qarT/1M3n3UziLdCEH8fH9VZeCp5TOkQ8
         aCjxNQbn8XmPdi99tlcc7EFKmgKOYr04AwyoGSTmQjaGPab0p/X/OjCRupLp0vJ2PVqL
         CmlO2+J2oxT3p+dqZudq0wh/DX9KI7tTsuo1PwjNkd5Grp/bel7PTD3hOyqxJlSWCRKW
         8Gz3TIfu1dDXmkyhR0VJgoNr2XgXPAM3f+VZQUz2uaDyMuRRYO63r2t+vNZ9GKDxC5VK
         Jm8w==
X-Forwarded-Encrypted: i=1; AJvYcCWFwwv/mtBxzVKCTWUOXPwmJFV+3b4Gabg8iLmpsMz1hG4RWPQqnlIFiqCqKuqcLrUDfLe9rKh7TvTdarIoGJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDPTUMuvUrRvqCL3lBGFdijQ5bV0C+D+s5xMogqKiwcH4JW2wT
	fDYttj/rB/Gnuwy2PWiLUqwyFyegcerqW5AwY1Lh8RiPBW/egiMbykMs2tTVSo3ZhIYJN+Uxh/C
	ZnSRnYEV5PHKzdA==
X-Google-Smtp-Source: AGHT+IFxrwl69sKXEkrueVCJAaVXqlAaXH6QFL249asiEL3cJVngjB06qwggD3EuOvpxoU8cfCz5OE0U4k7+ow==
X-Received: from qkfw14.prod.google.com ([2002:ae9:e50e:0:b0:7e8:1e34:1791])
 (user=marievic job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:414f:b0:7e6:8751:96ae with SMTP id af79cd13be357-7e8588965a6mr233742085a.31.1754950669987;
 Mon, 11 Aug 2025 15:17:49 -0700 (PDT)
Date: Mon, 11 Aug 2025 22:17:34 +0000
In-Reply-To: <20250811221739.2694336-1-marievic@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250811221739.2694336-1-marievic@google.com>
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250811221739.2694336-3-marievic@google.com>
Subject: [PATCH v2 2/7] kunit: Introduce param_init/exit for parameterized
 test context management
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

Add (*param_init) and (*param_exit) function pointers to
`struct kunit_case`. Users will be able to set them
via the new KUNIT_CASE_PARAM_WITH_INIT() macro.

param_init/exit will be invoked by kunit_run_tests() once before
and once after the parameterized test, respectively.
They will receive the `struct kunit` that holds the parameterized
test context; facilitating init and exit for shared state.

This patch also sets param_init/exit to None in
rust/kernel/kunit.rs.

Signed-off-by: Marie Zhussupova <marievic@google.com>
---

Changes in v2:

- param init/exit were set to None
  in rust/kernel/kunit.rs to fix the Rust breakage.
- The name of __kunit_init_parent_test was
  changed to kunit_init_parent_param_test and
  its call was changed to happen only if the
  test is parameterized.
- The param_exit call was also moved inside
  the check for if the test is parameterized.
- KUNIT_CASE_PARAM_WITH_INIT() macro logic was changed
  to not automatically set generate_params() to KUnit's
  built-in generator function. Instead, the test user
  will be asked to provide it themselves.
- The comments and the commit message were changed to
  reflect the parameterized testing terminology. See
  the patch series cover letter change log for the
  definitions.

---
 include/kunit/test.h | 25 +++++++++++++++++++++++++
 lib/kunit/test.c     | 20 ++++++++++++++++++++
 rust/kernel/kunit.rs |  4 ++++
 3 files changed, 49 insertions(+)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index b47b9a3102f3..d2e1b986b161 100644
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
index 14a8bd846939..49a5e6c30c86 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -641,6 +641,19 @@ static void kunit_accumulate_stats(struct kunit_result_stats *total,
 	total->total += add.total;
 }
 
+static void kunit_init_parent_param_test(struct kunit_case *test_case, struct kunit *test)
+{
+	if (test_case->param_init) {
+		int err = test_case->param_init(test);
+
+		if (err) {
+			kunit_err(test_case, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
+				"# failed to initialize parent parameter test.");
+			test_case->status = KUNIT_FAILURE;
+		}
+	}
+}
+
 int kunit_run_tests(struct kunit_suite *suite)
 {
 	char param_desc[KUNIT_PARAM_DESC_SIZE];
@@ -678,6 +691,7 @@ int kunit_run_tests(struct kunit_suite *suite)
 			kunit_run_case_catch_errors(suite, test_case, &test);
 			kunit_update_stats(&param_stats, test.status);
 		} else {
+			kunit_init_parent_param_test(test_case, &test);
 			/* Get initial param. */
 			param_desc[0] = '\0';
 			/* TODO: Make generate_params try-catch */
@@ -714,6 +728,12 @@ int kunit_run_tests(struct kunit_suite *suite)
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
diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 4b8cdcb21e77..cda64574b44d 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -207,6 +207,8 @@ pub const fn kunit_case(
         status: kernel::bindings::kunit_status_KUNIT_SUCCESS,
         module_name: core::ptr::null_mut(),
         log: core::ptr::null_mut(),
+        param_init: None,
+        param_exit: None,
     }
 }
 
@@ -226,6 +228,8 @@ pub const fn kunit_case_null() -> kernel::bindings::kunit_case {
         status: kernel::bindings::kunit_status_KUNIT_SUCCESS,
         module_name: core::ptr::null_mut(),
         log: core::ptr::null_mut(),
+        param_init: None,
+        param_exit: None,
     }
 }
 
-- 
2.51.0.rc0.205.g4a044479a3-goog


