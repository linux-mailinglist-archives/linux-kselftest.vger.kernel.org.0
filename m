Return-Path: <linux-kselftest+bounces-2070-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A54814B7C
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 16:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BD052804DD
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 15:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103503A8F9;
	Fri, 15 Dec 2023 15:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IwK5JV2c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA903FE30
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Dec 2023 15:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702653226; x=1734189226;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2kQV2dId0UrgYhXYi/uAsAuwiFtuS9UJf4+1fL+cAdg=;
  b=IwK5JV2cxOVYKaKPMeaaEXmSHHPFG6zGUbm5TJYBpXEkbjqiW0zfK661
   FTuodfhmaZtNzg76SmRB2F0yyMViJb5nBpIhQBcFH0XziRM+eeqMmg+WF
   t2e/oRWBUbVGq1W8KU8ny9eIF/CYt5Rhkkg4DAq+k9bKuK60zd5M91eTR
   baIQWxKhrRrcrH4qwRJh96xJza+ufWDixP0xMjI9Cql6veI1chNBPj+5X
   SV6IsOXOsVOYbJVgWg50w7EFLGb/LgeZ09RHy9Po2MXn22hLhyainy2Vr
   RpMaIPV3iOl9+RbuTdZUzU8hCwA4rM8K9YzCjwP3Kf7Ba+KrHucoTYyL/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="8645421"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="8645421"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:13:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="840692232"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="840692232"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.249.144.211])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:13:42 -0800
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>
Subject: [PATCH 1/2] kunit: Add example for using test->priv
Date: Fri, 15 Dec 2023 16:13:26 +0100
Message-Id: <20231215151327.1835-2-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20231215151327.1835-1-michal.wajdeczko@intel.com>
References: <20231215151327.1835-1-michal.wajdeczko@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a test->priv field the user can store arbitrary data.
Add example how to use this feature in the test code.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
---
 lib/kunit/kunit-example-test.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index 6bb5c2ef6696..d7dfcf209ece 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -221,6 +221,20 @@ static void example_params_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, param->value % param->value, 0);
 }
 
+/*
+ * This test shows the use of test->priv.
+ */
+static void example_priv_test(struct kunit *test)
+{
+	/* unless setup in suite->init(), test->priv is NULL */
+	KUNIT_ASSERT_NULL(test, test->priv);
+
+	/* but can be used to pass arbitrary data to other functions */
+	test->priv = kunit_kzalloc(test, 1, GFP_KERNEL);
+	KUNIT_EXPECT_NOT_NULL(test, test->priv);
+	KUNIT_ASSERT_PTR_EQ(test, test->priv, kunit_get_current_test()->priv);
+}
+
 /*
  * This test should always pass. Can be used to practice filtering attributes.
  */
@@ -245,6 +259,7 @@ static struct kunit_case example_test_cases[] = {
 	KUNIT_CASE(example_mark_skipped_test),
 	KUNIT_CASE(example_all_expect_macros_test),
 	KUNIT_CASE(example_static_stub_test),
+	KUNIT_CASE(example_priv_test),
 	KUNIT_CASE_PARAM(example_params_test, example_gen_params),
 	KUNIT_CASE_SLOW(example_slow_test),
 	{}
-- 
2.25.1


