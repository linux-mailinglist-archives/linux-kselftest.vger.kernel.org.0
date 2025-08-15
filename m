Return-Path: <linux-kselftest+bounces-39093-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4638FB27E69
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 12:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A93C616CC7B
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 10:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083E52FF65F;
	Fri, 15 Aug 2025 10:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yQXlADGI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543032FDC34
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Aug 2025 10:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755254173; cv=none; b=EOLeG9ba+NkQlbwLDhiH/3hTzqVGT4RtSEqUYX8dkYKUemV+r2CK07xzSJSOhOlNgjX+jIbvSJZ1LeehJe5fPLgnKdzDhpDDjolHdgxmkO5tgNhuXY9SGAwfo8y4Yesy26dnOrLgEgwLEr8lJ40VwpMYjL4Pgk5U+0pufcCq7rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755254173; c=relaxed/simple;
	bh=PXQaTPzfeZfmaVn+8SVNIYBwLVe02DdrsG9PDJmT+1o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gl1biz3WjXTIe5ereYS+QAdTi3/5PTNS6xD6xgTusf0oY4pFIMw1hb2YHeeJgUJ/QAXoPTwK1kdgnfIBV2k0Fj57kUORJyHXVZOx96ld8D4z+D3DvZ78FjUXRDhOabbXYr7sstD2Uiyq+q67HLrpFjSQNagvnp9jWBfNLwYc9qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yQXlADGI; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4b10990a1f0so38156851cf.0
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Aug 2025 03:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755254171; x=1755858971; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9cK185h9gxNmOTBKXZc10qbmIH62I7BV6bECtC8O9ek=;
        b=yQXlADGIZBWVHcOurm+jLTaWrRQr8hjvlpxHup6Rr1/1m+Hzkg3V0LRSvWx567rfZ/
         iwWNlZwqrAW6NXzcyJh6Iek2A5nO53f4TH/w0UX/Ap2Dk8GNGqh68GP+gFnyEJm7UzWA
         rsd1bwAfwtLMuY1Jpus9Qjk22mj5eeyOJw8JoLGIXmu2uXMUyddQbA1fNxoE2/xE2VkX
         Rf7J7FApC6uK1+z+WtL6kaC+3FAWActotW0+m/yWhQ+U5/PoMo1g+YV6qaB6E6oK2ZK5
         HEhqa+xEy5vlGb+9rUf0nFc0tEQ1Ud0biNkU7gJps+uWZiw5OBopim/FyOL6hNqrXyU3
         beKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755254171; x=1755858971;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9cK185h9gxNmOTBKXZc10qbmIH62I7BV6bECtC8O9ek=;
        b=mPkzV52i1YtD/RdMn4iIwgIwdno+yCingmARstkuBoWIwBAkT51wzH+RZoquph/wy6
         utJuUrY5DV5iTMs0ObvdoeLg2D/I/g+Wd6LlAtS9zUiblR1YJam11RYejDt+BYBv82KJ
         5OrI3w5LoMWgjyJkRJCMYs/7X9MT4aVJt5DGbEYogqcUm3zcF+D0v3S4I2wE++RQYZBY
         QP1zEWvEDUAEKYYRQYaZ5iPcLtuyreq+P126fQ1hFYHkp9l2+EWYjgiXIbIstNfkoCmk
         7PQiGtuCiqTGTd2WXY/u/Y2Z7ba24YRzFA/SfbAz5Ru2eMEs6ZLUu14uup9mGRB4KwII
         JVxg==
X-Forwarded-Encrypted: i=1; AJvYcCWMalwWjn++olMlp519syurG8bP6bRpiUmdqskNjQdF6G56ZNbxF7xDtgOriWAQ0wndTdtSCQXF22QzMHzqBko=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz37AYqLAK+bLYDV6lBF/I32YpOwX4Q06pQRka/TLP9QW0h2rQ
	pOM6ZVhYLCppGHflmvQ/SRRmZTHKr6qU+GtFAYTfVr/sWmyfEWBQ74PrcNgLuMkmfCfZPMfLiyh
	zJZFmyrWk29EzYQ==
X-Google-Smtp-Source: AGHT+IEaT0Jnn5or3jfzn5ggHOZAVAIlHTvGeOhQZuo5gK5kIbPKro1ACE25ujkZ3EehfX1NVXCYKKGDM6Qxbg==
X-Received: from qtbih9.prod.google.com ([2002:a05:622a:6a89:b0:4b0:9663:7cc6])
 (user=marievic job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1b12:b0:4b0:616f:919b with SMTP id d75a77b69052e-4b11e21e941mr15083281cf.39.1755254171112;
 Fri, 15 Aug 2025 03:36:11 -0700 (PDT)
Date: Fri, 15 Aug 2025 10:35:58 +0000
In-Reply-To: <20250815103604.3857930-1-marievic@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815103604.3857930-1-marievic@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250815103604.3857930-2-marievic@google.com>
Subject: [PATCH v3 1/7] kunit: Add parent kunit for parameterized test context
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

Currently, KUnit parameterized tests lack a mechanism to share
resources across parameter runs because the same `struct kunit`
instance is cleaned up and reused for each run.

This patch introduces parameterized test context, enabling test
users to share resources between parameter runs. It also allows
setting up resources that need to be available for all parameter
runs only once, which is helpful in cases where setup is expensive.

To establish a parameterized test context, this patch adds a
parent pointer field to `struct kunit`. This allows resources added
to the parent `struct kunit` to be shared and accessible across all
parameter runs.

In kunit_run_tests(), the default `struct kunit` created is now
designated to act as the parameterized test context whenever a test
is parameterized.

Subsequently, a new `struct kunit` is made for each parameter run, and
its parent pointer is set to the `struct kunit` that holds the
parameterized test context.

Reviewed-by: David Gow <davidgow@google.com>
Reviewed-by: Rae Moar <rmoar@google.com>
Signed-off-by: Marie Zhussupova <marievic@google.com>
---

Changes in v3:
v2: https://lore.kernel.org/all/20250811221739.2694336-2-marievic@google.com/
- Commit message formatting.

Changes in v2:
v1: https://lore.kernel.org/all/20250729193647.3410634-2-marievic@google.com/
- Descriptions of the parent pointer in `struct kunit` were changed to
  be more general, as it could be used to share resources not only
  between parameter runs but also between test cases in the future.
- When printing parameter descriptions using test.param_index was changed
  to param_test.param_index.
- kunit_cleanup(&test) in kunit_run_tests() was moved inside the
  parameterized test check.
- The comments and the commit message were changed to reflect the
  parameterized testing terminology. See the patch series cover letter
  change log for the definitions.

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
2.51.0.rc1.167.g924127e9c0-goog


