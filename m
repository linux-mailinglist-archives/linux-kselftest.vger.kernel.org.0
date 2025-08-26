Return-Path: <linux-kselftest+bounces-39931-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1301AB3588E
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 11:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7145F361101
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 09:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C886A308F2F;
	Tue, 26 Aug 2025 09:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ewb5bsJg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C13306D57
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Aug 2025 09:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756199628; cv=none; b=Kv19jxjHLX5+lHAaB5k/Qrwfx5H4ZBWqUsNhoJAOKzmp5PsjQGLKKIDFGp/B9jC5Z2nNLa4yvJeZsDz1VA7kkxyQ24wkeyiFBFRyhUfDolE44SsQzm9lqaHJVRkld2GQ1RFdRrsYpoMmrt5YIu7rkLTRx9HBfwiIW+3euYnRtT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756199628; c=relaxed/simple;
	bh=pD4XLTg0DldHukyFdaH/5tCPbfyEuITBPgA9nptPuIs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iiF5SQj1HimHWjD90AZTZ/2y1G5FrabFu7rRqz8kRIqy+SRdJm8Xgs706Hb0FtAx+wlMZ1p0pIEo4wrmrieGs8NlM4rISUdyebsxiA1dMtx8b3AUWOYg5z37SNtjOKP6V5awY3ab0RbEZdtf2DeFWGUuNSXSYvIl7MtW1e1NHsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ewb5bsJg; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-770d7a5f812so1789683b3a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Aug 2025 02:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756199626; x=1756804426; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z06H7nQAXuGVWeGBmy7rHwPZSCBDj75F7L0FEZo0y1s=;
        b=Ewb5bsJg7v5I8LPD/DDkPTVsnY7ekoQSmDMcNoLT/xpje1tYxWf9suaDoBcQZidKJw
         jtYRYE4zCRQVrV3txNqzqKmSfJ4BOQX2TpEbDHukl0Rz7ZnD7Xc0/SD38Q/aElR+wE2V
         bE/w1aDz7f6b7Dao5CPtWTfiyF0VM/Cr2IaFAIAq9Pe7Y5iVvLglxA9yCFv66GF4CvM0
         s4VDI7/cdZbdKFd8S4GuopxmC61+C4viNA+Qi3Y6fOvr/tBfyel6oYuYVKBb7VrFWjo0
         6K7GnRdRagoLorV4bZtRng4tH1iGhHB1S9A+nmMltUo9jdzAwdjCVynORVwxe6IQgQIP
         Y85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756199626; x=1756804426;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z06H7nQAXuGVWeGBmy7rHwPZSCBDj75F7L0FEZo0y1s=;
        b=OOxcrjk66ZPeUZCG6bOQytcOdiKxILUbrGeQJlz3urLRbvd/0xITG87u46wEN6Vr7M
         eJ9PVc8OfqkZE92W8aI1UyW2d1RUFZ0czqBIRPH9wnUgpVANbMUc7HJi7f+J1t7yYZEU
         l3zBmIaFDJRZevz1oD+O2CfNj3rKj8h78deQ3YD+d+MKRn7kxV1/B+Q95sQH3PkGlljb
         PASKcmICiZ6++AbF+LMVK0rr7P0XDJY8RxOawgms7U5I4BT6aolr9UCz35UT/kZJzGtW
         ASWy6sAKuMkiYdZ1pgBI4pwuVaUBwI4z+xadPNboPGm39ZPj2Uh7A79G1uBzBQkF40ga
         pOtg==
X-Forwarded-Encrypted: i=1; AJvYcCUsE1XkKLCLisXLX+IQK/Xi6J2IHiiTgmJMBKAxqDtSGbmZA9Jt9d7ySOSNTZoEV/Z/E2zp4V2UqyIxHSEiAm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnmVokx9qrbXSuS1iCJMfjJth5tiTWkn8LZNVKxUifSWiOiElb
	Kghj0eN1KVkKnopBCC5+rYeF/Dx9Ey5bWeywG78y40xs1oignphU4sn1DCUPsxqHM+eGidtkqWN
	2a1hEAhCathY51A==
X-Google-Smtp-Source: AGHT+IFv6OGkkYcCqgD5ALA5r0X9nZMsDa3qbm/600rcJO0vkLNs5ciUkvjSFY6CyLtsEnsS+a8iY6JjNwchPA==
X-Received: from pfx51.prod.google.com ([2002:a05:6a00:a473:b0:771:e00d:cee])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4b56:b0:76e:7ae9:e869 with SMTP id d2e1a72fcca58-7702fb00068mr18610618b3a.25.1756199626242;
 Tue, 26 Aug 2025 02:13:46 -0700 (PDT)
Date: Tue, 26 Aug 2025 17:13:31 +0800
In-Reply-To: <20250826091341.1427123-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250826091341.1427123-1-davidgow@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250826091341.1427123-2-davidgow@google.com>
Subject: [PATCH v4 1/7] kunit: Add parent kunit for parameterized test context
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
Signed-off-by: David Gow <davidgow@google.com>
---

No changes in v4:
v3: https://lore.kernel.org/linux-kselftest/20250815103604.3857930-2-marievic@google.com/

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
index d958ee53050e..9766403afd56 100644
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
index d2bfa331a2b1..587b5c51db58 100644
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
2.51.0.261.g7ce5a0a67e-goog


