Return-Path: <linux-kselftest+bounces-38055-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F311B1539B
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 21:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5B13BCE96
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 19:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B0C256C8A;
	Tue, 29 Jul 2025 19:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zSijkJkz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FA9254876
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Jul 2025 19:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753817842; cv=none; b=J857Vl12aj7yF9O0p8ec1i5Zmv++/Fh0Ap4/tMK4+4CyIsD9TvMuQmYSjToBapLAasAJ4dPy8gtc4AAQeY796So5kanz542D8bszVI+yY4iJP89Ojc+Oqu656oLORs1NUktJfyUfxJBO4cvjO/GFWUjNDeY2xsbPTMsKF2hDyzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753817842; c=relaxed/simple;
	bh=zbQaQ6zPDEvMaH4SGHFOo3O8aSEe60ypCwxlGBEUT5A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tT5kbMsW/tJqiWbGQbXbh9rD9LC3LDfCo4+qcT7QrrAClIaFJjJJgh/XU+BDdMENqx9DefDkAm3TsiUnFFHunkbRxdji4Eh2RCzUARR6wG0HDcLS+jkcRlz/UiNwRqcF1ULv+rMe5JS/V51z6CHbkvhFX+EocCmE99ChEaWLGZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zSijkJkz; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4ab60125e3dso137420741cf.0
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Jul 2025 12:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753817840; x=1754422640; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tISY+xBUYYz9JGsqhSxSDiuo5pXcWFPbk33bCR9svy4=;
        b=zSijkJkzKHR6F/DQicDIGt/7DEMKF3lSaEjeK5yVnJRWBJzrcwR+pksUPVwIT9vbgq
         LdqjZpGXWyK++5iKDYCrdsz37R4aOCZd/b6IMDB/ivGhYQdFyUYPDf2bUrgRaqYz4cSV
         kX+qZ9JyOHU+68N33B8cUPkFglemVkTvU2tLOopCxiz0L7dyEApx3RFNbdyf0C6ajI6U
         2CrqTyNa33vDHO+YtJSu3r+hHS31kTvJuNN8bQltTQnihBB7C9e6Ph+tG3Fq4g5KBhRZ
         yZILhrANJpXOFpuFQxLFkBED95U4QMBSjQjZQJZUW7v6ox9/AUg4dQFtq3cPN/S6NNBM
         zu0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753817840; x=1754422640;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tISY+xBUYYz9JGsqhSxSDiuo5pXcWFPbk33bCR9svy4=;
        b=k96gAQXnytkr3p9Rvfwq261TonRajeOFDBhlshSO5nsvgkAbeBV6JID2t2Y695WaLR
         vqCRxFvhQPmKcA9zpdzgfUxWeA6zl+PaqaKGSp3XZJwcCAddVeqgL4GHQdWJ8N35aRIf
         JTpyG2vBlSPI9izfxW7C6qIjSkn6fiKfjQ/ZQcT+NgtA1zY9HgofJ0Da3jLKrD1zN71T
         xzZMiH7ai/u7SXrhRIgknzWxkaaVMm1Vb2ALVb7Ny576NT+wUJetEiDz8QprDhZt6R0Y
         IyrLLaY4Vx6PJapkoR0cM7DAjOz17OkvkssoQmXf2VI7lYEzqKAVpM3ExnhE/WqwYbO9
         D7XQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVDXJlPjEKO6Xqj0ZDpa8FzEB49tjouN7A2KNm7ETx7fnDggJMnlu/7mJu/0JE34L+qweCU0qvNCLWvHk9ScI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyth0ZqIA7HoSXz2DnAYeidqZ1tTweKF4ToOxEZwwJSKeeSOry1
	DXFriktz+4bZLQeIIh3H5octUVdJXhvHpNfF06deLfPnX5gsngx6C08A1Pnj1cmaVQWpeNB9PT/
	Tw+cpktJGfIKfww==
X-Google-Smtp-Source: AGHT+IHO3w/OWxc0bh2stWMFfWMHfCNuwQ8ImCAJ/qrdu5G1dagcPV42fbu2D6wVRt/h4M0z28H1fFDxXyPbjg==
X-Received: from qtbcf19.prod.google.com ([2002:a05:622a:4013:b0:4ab:9556:af14])
 (user=marievic job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:ca:b0:4a8:19d5:f8a5 with SMTP id d75a77b69052e-4aedbc45df3mr13576391cf.35.1753817839732;
 Tue, 29 Jul 2025 12:37:19 -0700 (PDT)
Date: Tue, 29 Jul 2025 19:36:40 +0000
In-Reply-To: <20250729193647.3410634-1-marievic@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250729193647.3410634-1-marievic@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250729193647.3410634-3-marievic@google.com>
Subject: [PATCH 2/9] kunit: Introduce param_init/exit for parameterized test
 shared context management
From: Marie Zhussupova <marievic@google.com>
To: rmoar@google.com, davidgow@google.com, shuah@kernel.org, 
	brendan.higgins@linux.dev
Cc: elver@google.com, dvyukov@google.com, lucas.demarchi@intel.com, 
	thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	kasan-dev@googlegroups.com, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Marie Zhussupova <marievic@google.com>
Content-Type: text/plain; charset="UTF-8"

Add `param_init` and `param_exit` function pointers to
`struct kunit_case`. Users will be able to set them
via the new `KUNIT_CASE_PARAM_WITH_INIT` macro.

These functions are invoked by kunit_run_tests() once before
and once after the entire parameterized test series, respectively.
They will receive the parent kunit test instance, allowing users
to register and manage shared resources. Resources added to this
parent kunit test will be accessible to all individual parameterized
tests, facilitating init and exit for shared state.

Signed-off-by: Marie Zhussupova <marievic@google.com>
---
 include/kunit/test.h | 33 ++++++++++++++++++++++++++++++++-
 lib/kunit/test.c     | 23 ++++++++++++++++++++++-
 2 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index a42d0c8cb985..d8dac7efd745 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -92,6 +92,8 @@ struct kunit_attributes {
  * @name:     the name of the test case.
  * @generate_params: the generator function for parameterized tests.
  * @attr:     the attributes associated with the test
+ * @param_init: The init function to run before parameterized tests.
+ * @param_exit: The exit function to run after parameterized tests.
  *
  * A test case is a function with the signature,
  * ``void (*)(struct kunit *)``
@@ -129,6 +131,13 @@ struct kunit_case {
 	const void* (*generate_params)(const void *prev, char *desc);
 	struct kunit_attributes attr;
 
+	/*
+	 * Optional user-defined functions: one to register shared resources once
+	 * before the parameterized test series, and another to release them after.
+	 */
+	int (*param_init)(struct kunit *test);
+	void (*param_exit)(struct kunit *test);
+
 	/* private: internal use only. */
 	enum kunit_status status;
 	char *module_name;
@@ -218,6 +227,27 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
 		  .generate_params = gen_params,				\
 		  .attr = attributes, .module_name = KBUILD_MODNAME}
 
+/**
+ * KUNIT_CASE_PARAM_WITH_INIT() - Define a parameterized KUnit test case with custom
+ * init and exit functions.
+ * @test_name: The function implementing the test case.
+ * @gen_params: The function to generate parameters for the test case.
+ * @init: The init function to run before parameterized tests.
+ * @exit: The exit function to run after parameterized tests.
+ *
+ * Provides the option to register init and exit functions that take in the
+ * parent of the parameterized tests and run once before and once after the
+ * parameterized test series. The init function can be used to add any resources
+ * to share between the parameterized tests or to pass parameter arrays. The
+ * exit function can be used to clean up any resources that are not managed by
+ * the test.
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
@@ -269,7 +299,8 @@ struct kunit_suite_set {
  * @priv: for user to store arbitrary data. Commonly used to pass data
  *	  created in the init function (see &struct kunit_suite).
  * @parent: for user to store data that they want to shared across
- *	    parameterized tests.
+ *	    parameterized tests. Typically, the data is provided in
+ *	    the param_init function (see &struct kunit_case).
  *
  * Used to store information about the current context under which the test
  * is running. Most of this data is private and should only be accessed
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 4d6a39eb2c80..d80b5990d85d 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -641,6 +641,19 @@ static void kunit_accumulate_stats(struct kunit_result_stats *total,
 	total->total += add.total;
 }
 
+static void __kunit_init_parent_test(struct kunit_case *test_case, struct kunit *test)
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
@@ -668,6 +681,8 @@ int kunit_run_tests(struct kunit_suite *suite)
 		struct kunit_result_stats param_stats = { 0 };
 
 		kunit_init_test(&test, test_case->name, test_case->log);
+		__kunit_init_parent_test(test_case, &test);
+
 		if (test_case->status == KUNIT_SKIPPED) {
 			/* Test marked as skip */
 			test.status = KUNIT_SKIPPED;
@@ -677,7 +692,7 @@ int kunit_run_tests(struct kunit_suite *suite)
 			test_case->status = KUNIT_SKIPPED;
 			kunit_run_case_catch_errors(suite, test_case, &test);
 			kunit_update_stats(&param_stats, test.status);
-		} else {
+		} else if (test_case->status != KUNIT_FAILURE) {
 			/* Get initial param. */
 			param_desc[0] = '\0';
 			/* TODO: Make generate_params try-catch */
@@ -727,6 +742,12 @@ int kunit_run_tests(struct kunit_suite *suite)
 
 		kunit_update_stats(&suite_stats, test_case->status);
 		kunit_accumulate_stats(&total_stats, param_stats);
+		/*
+		 * TODO: Put into a try catch. Since we don't need suite->exit
+		 * for it we can't reuse kunit_try_run_cleanup for this yet.
+		 */
+		if (test_case->param_exit)
+			test_case->param_exit(&test);
 		/* TODO: Put this kunit_cleanup into a try-catch. */
 		kunit_cleanup(&test);
 	}
-- 
2.50.1.552.g942d659e1b-goog


