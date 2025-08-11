Return-Path: <linux-kselftest+bounces-38718-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6C3B2182D
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 00:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8741C627781
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 22:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE332E3AEC;
	Mon, 11 Aug 2025 22:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BriwSl5S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97612E2856
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 22:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754950670; cv=none; b=qRFXq5zTKqf1XUWEWYASRqa44/YzXMn1fkM8QVP513sMxL/I6NdSnfQJiVBSx5/ghPHdH45DG/OMd/DZOTW9dg8O2Cwl+bJ6OlD8HWkXeP+GKkeUORC2tG5t+kTNSt98+ubeYsHcQKakjzogiYW6XDFZpM/UMgBDUhfCVB5dlQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754950670; c=relaxed/simple;
	bh=qrCJ5slR+7DAru5YAv/y28Aq3JGsgpLda1pvMhzcxBw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qGdAbr6G/3y9Ehs0/VdPpxukrgxgVpMoCYnf1w2PefVYqqjOg2ZZNsyilQGJ4cSkXFrFvNSp3m3l0bALemxpb9s2ZZJhgPClsnxLAot0POwrbhMsLvEAKgg6bJlqgdfbq45J8EfgKFo6iApZZoyZfNe5+16eVRZ69T0FOZo3OgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BriwSl5S; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-7073cd24febso49373316d6.0
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 15:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754950668; x=1755555468; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ai73eVBeTV1L+LH/Eg2uYJxn5nX9nX6extQG0PIgIeU=;
        b=BriwSl5SUQMiXJN0OYnyYa4YLHdkXE8jxplzVBXEXKjAMTZWLCVWJ/OH5Hrf+1foDx
         naTDRKwkrXDypzCY4pbeimlonKpP2B+F/MvhrMJBFIafqKBGzQax0I3cS7caWFBN5mr0
         sjCSYETukHMhUpvybB/75WGTNnYLNmorU3EB5TVkv0NJQXVzzHBxrhAvLDa6nac5huVj
         UPFmpkKIQ4cBR93eZKPqkXqhM2ojhAQWW1hpWsEHurDPhpdilsDtRlPcMds0qMl8CLdS
         5K66eLUsJ6JAAM5VWydx+mB/VWWLfBUyc+zRqp4WY2jxALtaVnw2tbXY9KnCahhYhBhK
         u48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754950668; x=1755555468;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ai73eVBeTV1L+LH/Eg2uYJxn5nX9nX6extQG0PIgIeU=;
        b=IFQweLq16XGZt+7VysbxzgqnrM0T/RDJvI6pGRTufI4Jvqz8Oa6rSQV9VjunbLEPHc
         rWW/GPLKwj34LWmMYztR3HPV+F0UFwGt8kCWm4g/CLk+jRBvxNR/5bIjqtX2timkHSTh
         CESY9S3qDcJRKaVEeySQtduL3m5aOzjzykhpmjlG+AVhsL4uMxGFFvbTmEWXZYdr2ziF
         WFlisHzT7WE87JtWNgh+bD9JNuB1FP/0mXsh2iI9Jrh3wXZnEwwwh8QeofeS3OefeC5F
         LNczVtzsK28r83nuUIRjjQaRz7ORvEQy4yvpYwUfrC2OGQPSUTyqoHjTZys2xBe447sX
         sZ6w==
X-Forwarded-Encrypted: i=1; AJvYcCVmJJmlpvq9FFyyRICkVw8URQfq6emZKWTAWF4Ot2mIpHU798TwAHQuWHNu/tug8ZiGiiCY+UbnlYv1fOz6tsc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj+6x//2AsmIK63WtzsRCmrbZi2WXgtGcBGWkH5n79aSwqU4NO
	kbDtavPReAos9zbY5PtjsTyPdHDjcJcIUaErQ6Jjot1ix9qbqBFP5jmaxxhh+e+yO6H8MZOLpIQ
	MILTIRq05ssY5iw==
X-Google-Smtp-Source: AGHT+IFh2sPMTRJoRpdZUZIa9gzWqo7Kt+lC8xl+JpuQTbbjZIqwk00Utr+ssMOiXHKMxm002rqOwOTj1ryw8A==
X-Received: from qvad7.prod.google.com ([2002:a0c:f107:0:b0:707:34cf:dea8])
 (user=marievic job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:2522:b0:707:3c17:8e8b with SMTP id 6a1803df08f44-7099a5022e3mr203449086d6.50.1754950667602;
 Mon, 11 Aug 2025 15:17:47 -0700 (PDT)
Date: Mon, 11 Aug 2025 22:17:33 +0000
In-Reply-To: <20250811221739.2694336-1-marievic@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250811221739.2694336-1-marievic@google.com>
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250811221739.2694336-2-marievic@google.com>
Subject: [PATCH v2 1/7] kunit: Add parent kunit for parameterized test context
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

Currently, KUnit parameterized tests lack a mechanism
to share resources across parameter runs because the
same `struct kunit` instance is cleaned up and
reused for each run.

This patch introduces parameterized test context,
enabling test users to share resources between
parameter runs. It also allows setting up resources
that need to be available for all parameter runs only once,
which is helpful in cases where setup is expensive.

To establish a parameterized test context, this
patch adds a parent pointer field to `struct kunit`.
This allows resources added to the parent `struct kunit`
to be shared and accessible across all parameter runs.

In kunit_run_tests(), the default `struct kunit`
created is now designated to act as the parameterized
test context whenever a test is parameterized.

Subsequently, a new `struct kunit` is made
for each parameter run, and its parent pointer is
set to the `struct kunit` that holds the
parameterized test context.

Signed-off-by: Marie Zhussupova <marievic@google.com>
---

Changes in v2:

- Descriptions of the parent pointer in `struct kunit`
  were changed to be more general, as it could be
  used to share resources not only between parameter
  runs but also between test cases in the future.
- When printing parameter descriptions using
  test.param_index was changed to param_test.param_index.
- kunit_cleanup(&test) in kunit_run_tests() was moved
  inside the parameterized test check.
- The comments and the commit message were changed to
  reflect the parameterized testing terminology. See
  the patch series cover letter change log for the
  definitions.

---
 include/kunit/test.h |  8 ++++++--
 lib/kunit/test.c     | 34 ++++++++++++++++++++--------------
 2 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 39c768f87dc9..b47b9a3102f3 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -268,14 +268,18 @@ struct kunit_suite_set {
  *
  * @priv: for user to store arbitrary data. Commonly used to pass data
  *	  created in the init function (see &struct kunit_suite).
+ * @parent: reference to the parent context of type struct kunit that can
+ *	    be used for storing shared resources.
  *
  * Used to store information about the current context under which the test
  * is running. Most of this data is private and should only be accessed
- * indirectly via public functions; the one exception is @priv which can be
- * used by the test writer to store arbitrary data.
+ * indirectly via public functions; the two exceptions are @priv and @parent
+ * which can be used by the test writer to store arbitrary data and access the
+ * parent context, respectively.
  */
 struct kunit {
 	void *priv;
+	struct kunit *parent;
 
 	/* private: internal use only. */
 	const char *name; /* Read only after initialization! */
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index f3c6b11f12b8..14a8bd846939 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -647,6 +647,7 @@ int kunit_run_tests(struct kunit_suite *suite)
 	struct kunit_case *test_case;
 	struct kunit_result_stats suite_stats = { 0 };
 	struct kunit_result_stats total_stats = { 0 };
+	const void *curr_param;
 
 	/* Taint the kernel so we know we've run tests. */
 	add_taint(TAINT_TEST, LOCKDEP_STILL_OK);
@@ -679,37 +680,42 @@ int kunit_run_tests(struct kunit_suite *suite)
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
-						 "param-%d", test.param_index);
+						 "param-%d", param_test.param_index);
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
+			/* TODO: Put this kunit_cleanup into a try-catch. */
+			kunit_cleanup(&test);
 		}
 
 		kunit_print_attr((void *)test_case, true, KUNIT_LEVEL_CASE);
-- 
2.51.0.rc0.205.g4a044479a3-goog


