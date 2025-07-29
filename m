Return-Path: <linux-kselftest+bounces-38054-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9AAB15392
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 21:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E744173F84
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 19:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C341B254AEC;
	Tue, 29 Jul 2025 19:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wVf3qOB6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB47D2522B5
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Jul 2025 19:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753817839; cv=none; b=r1Tc8r8N/gk33jLpxeTmCOjbmjxMqRKOZQSLjEa3PxpBWGXlvBXFyGlobzfHRJ+3lUkRc0wl1YcQF2206LmprN7DaraTzx9jii+ad1Dk2X+dEke8EgaFo5uDBZX6aCV0sEvI3EmiJtdAAulTnWociIybLcyTL+zuEClDMmzWSZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753817839; c=relaxed/simple;
	bh=rackOIhgM/EsRDDaCK1LSMUULc+lDhVTAqkenOqdyzA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rNKyErCNiWFk/L67Gssfc1qsfupVpfkPV+Oo81K5polZbDtrS34wgKiEru+ad7+jJohlNLV70fq6BVDFZ2cLOQGret7NrcijB/Dk7CaLg547dUOFJgCzKd6dQZTI9+3jGeFq6x2mmAhda3NFpLqjT/h5I4xJTy4UZJIlh53CwLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wVf3qOB6; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7c5cd0f8961so1172085585a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Jul 2025 12:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753817837; x=1754422637; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7t36RxdzKGiVmpStJKp3ep3ZJUIKeCeGyRBEDxUk+R0=;
        b=wVf3qOB6z25wTcMy2pe5FF3FO3zfOzFGYKBrnB9Apq/c5apt/uqkjcQ+a1zZt5f0c1
         4r6lRrGQ5pmervaiorqXI8ToVDjZTg+WdV8yM4OFrnVMgcZoqGL3U+sbLqHHdZeEouXm
         GHR5BfT2cIiYOHkfjLtaWwd7M6TqGHrqEUkbetaN25R9BuqocZI/rvfwZNhpjTpyD+WW
         SdGnp2aV9N8R3XyFmzx6BtDYWe600P3K2Nyic/S+fI05IDUcO2XeLfV0OpTYCC0Tiq9k
         T/JKo/IS3Jx/ADPk4qeWuZ8uWGyz/dI7X3nvANRpoTvx1jp4z0jKI3mRBIRgQzSAi1pO
         CIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753817837; x=1754422637;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7t36RxdzKGiVmpStJKp3ep3ZJUIKeCeGyRBEDxUk+R0=;
        b=FId8nMN1PjdpVV+hgjEfyapbxHvYK/FWoWFngG9qydPXU5iyxVb5KqUV8DI0sdj7H8
         9Z+iUPGXQqes4XwD1QSTTgveLwyJN6oQORJ6CYWIiXldPE3maHkyFjUO4PLUrYK2eg+q
         2ZsrNz89Dwc7RoeOo2gs5kZR5k7H+po0MFkVd2QINV/mbxDBzj/DpfRSysqltAKptTE5
         KNici6FgLcI4b2yauVkcLx48gEVdOWKRH2xUNAz65eQZNJxWloKvRaySw7G+wb5DJriR
         hvNuFvpRKPPcm7t96Af/Jdcas1MRtvbJxymh1mb4GuNpnoPeE+mNJbaN6t1DsqxnBmlA
         NdzA==
X-Forwarded-Encrypted: i=1; AJvYcCVH4GAHdLlxeQ/aggix2eCt9HYnchrpzYcmSvAgDq4eHcNMjVyXU0nmOa4nEsVcELYgBgEo5802ofeBp+pKgks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcs31gvCRCWbpV3E2Rp0jdiW0gslR4kHkPfsgFWkRClKoN097j
	D4d46lftv1dwcPI9s3gr5CgwISnC9xZtYcIOb3JQYoQKq3LI5Va0gutUu8K+x7zmyCz9vvUzh94
	fb8ZYdBUgo8hvbQ==
X-Google-Smtp-Source: AGHT+IG4U64kfYbeq2Gjgi7BkIe6ZzOTwFopE8vYX8XJ1HzdrnGiupy82m0rQuOpDRcjZn9ir5jLUg520yac1A==
X-Received: from qtbfh7.prod.google.com ([2002:a05:622a:5887:b0:4ab:d41d:ce0c])
 (user=marievic job=prod-delivery.src-stubby-dispatcher) by
 2002:ae9:e008:0:b0:7e1:9c2d:a862 with SMTP id af79cd13be357-7e66f3534ffmr75742185a.39.1753817836908;
 Tue, 29 Jul 2025 12:37:16 -0700 (PDT)
Date: Tue, 29 Jul 2025 19:36:39 +0000
In-Reply-To: <20250729193647.3410634-1-marievic@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250729193647.3410634-1-marievic@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250729193647.3410634-2-marievic@google.com>
Subject: [PATCH 1/9] kunit: Add parent kunit for parameterized test context
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

Currently, KUnit parameterized tests lack a mechanism
to share resources across individual test invocations
because the same `struct kunit` instance is reused for
each test.

This patch refactors kunit_run_tests() to provide each
parameterized test with its own `struct kunit` instance.
A new parent pointer is added to `struct kunit`, allowing
individual parameterized tests to reference a shared
parent kunit instance. Resources added to this parent
will then be accessible to all individual parameter
test executions.

Signed-off-by: Marie Zhussupova <marievic@google.com>
---
 include/kunit/test.h | 12 ++++++++++--
 lib/kunit/test.c     | 32 +++++++++++++++++++-------------
 2 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 39c768f87dc9..a42d0c8cb985 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -268,14 +268,22 @@ struct kunit_suite_set {
  *
  * @priv: for user to store arbitrary data. Commonly used to pass data
  *	  created in the init function (see &struct kunit_suite).
+ * @parent: for user to store data that they want to shared across
+ *	    parameterized tests.
  *
  * Used to store information about the current context under which the test
  * is running. Most of this data is private and should only be accessed
- * indirectly via public functions; the one exception is @priv which can be
- * used by the test writer to store arbitrary data.
+ * indirectly via public functions; the two exceptions are @priv and @parent
+ * which can be used by the test writer to store arbitrary data or data that is
+ * available to all parameter test executions, respectively.
  */
 struct kunit {
 	void *priv;
+	/*
+	 * Reference to the parent struct kunit for storing shared resources
+	 * during parameterized testing.
+	 */
+	struct kunit *parent;
 
 	/* private: internal use only. */
 	const char *name; /* Read only after initialization! */
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index f3c6b11f12b8..4d6a39eb2c80 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -647,6 +647,7 @@ int kunit_run_tests(struct kunit_suite *suite)
 	struct kunit_case *test_case;
 	struct kunit_result_stats suite_stats = { 0 };
 	struct kunit_result_stats total_stats = { 0 };
+	const void *curr_param;
 
 	/* Taint the kernel so we know we've run tests. */
 	add_taint(TAINT_TEST, LOCKDEP_STILL_OK);
@@ -679,36 +680,39 @@ int kunit_run_tests(struct kunit_suite *suite)
 		} else {
 			/* Get initial param. */
 			param_desc[0] = '\0';
-			test.param_value = test_case->generate_params(NULL, param_desc);
+			/* TODO: Make generate_params try-catch */
+			curr_param = test_case->generate_params(NULL, param_desc);
 			test_case->status = KUNIT_SKIPPED;
 			kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
 				  "KTAP version 1\n");
 			kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
 				  "# Subtest: %s", test_case->name);
 
-			while (test.param_value) {
-				kunit_run_case_catch_errors(suite, test_case, &test);
+			while (curr_param) {
+				struct kunit param_test = {
+					.param_value = curr_param,
+					.param_index = ++test.param_index,
+					.parent = &test,
+				};
+				kunit_init_test(&param_test, test_case->name, test_case->log);
+				kunit_run_case_catch_errors(suite, test_case, &param_test);
 
 				if (param_desc[0] == '\0') {
 					snprintf(param_desc, sizeof(param_desc),
 						 "param-%d", test.param_index);
 				}
 
-				kunit_print_ok_not_ok(&test, KUNIT_LEVEL_CASE_PARAM,
-						      test.status,
-						      test.param_index + 1,
+				kunit_print_ok_not_ok(&param_test, KUNIT_LEVEL_CASE_PARAM,
+						      param_test.status,
+						      param_test.param_index,
 						      param_desc,
-						      test.status_comment);
+						      param_test.status_comment);
 
-				kunit_update_stats(&param_stats, test.status);
+				kunit_update_stats(&param_stats, param_test.status);
 
 				/* Get next param. */
 				param_desc[0] = '\0';
-				test.param_value = test_case->generate_params(test.param_value, param_desc);
-				test.param_index++;
-				test.status = KUNIT_SUCCESS;
-				test.status_comment[0] = '\0';
-				test.priv = NULL;
+				curr_param = test_case->generate_params(curr_param, param_desc);
 			}
 		}
 
@@ -723,6 +727,8 @@ int kunit_run_tests(struct kunit_suite *suite)
 
 		kunit_update_stats(&suite_stats, test_case->status);
 		kunit_accumulate_stats(&total_stats, param_stats);
+		/* TODO: Put this kunit_cleanup into a try-catch. */
+		kunit_cleanup(&test);
 	}
 
 	if (suite->suite_exit)
-- 
2.50.1.552.g942d659e1b-goog


