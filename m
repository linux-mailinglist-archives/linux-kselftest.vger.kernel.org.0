Return-Path: <linux-kselftest+bounces-5273-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD72F85F541
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 11:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CDC41F25EBF
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 10:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D5D3BB37;
	Thu, 22 Feb 2024 10:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VaZBzezE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791C639FDC;
	Thu, 22 Feb 2024 10:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708596325; cv=none; b=IO9bezJsbrLPs8TH08H7sd+FgoDYcCtK9XxWct3z5bmW6fR51KtZF2XSCu89HaqtAuHvZ+ftKMKsNlwTeKz5mV0RcZS7TqJFP8MfZhSR7Y1Yx4MT0rSTPiiLjdgrGgQGzXdxL1SDYw4aGMCp+342Epxw1XYIU+SjzSkjBvKv/7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708596325; c=relaxed/simple;
	bh=Gi1VkP9GPyzQfNuuc0NAYEJ6mkbO6wyMOkVcf8T5EK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HxtnV274viniheZM1k/597B+PSyTku7kaycS/CiIqQ+XbLlGgw4yOBLCILlokdyT1xZKNoARxgBut2tSh4KYhZxzxHaii0hRpLVlkspBjjSS4ivtHfhXOQWaDp8FSP+vqwY+JX0U8sP5jLqh5rUD1BR3PHDCapjQo8+75Frou1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VaZBzezE; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708596311; x=1740132311;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gi1VkP9GPyzQfNuuc0NAYEJ6mkbO6wyMOkVcf8T5EK0=;
  b=VaZBzezERro6mMGYSi+ENTxKhb6n6BO27p2EmIgKHZaDQ3b8cpIuVD/9
   FbOUeGubfYU/gA7p75ER4o+ZDzjFwMM02Ti8ButrG10e45We4Z3+mDiUJ
   dYM6/5SWtyjD3FLgaHrAlQjz5d1ljDVSCNtsQnosODExFWkr3XsaAjTr6
   me3reEwxjbGDa7RJi8OgnokIwWzV0MtuhuE2xx4gcNV4xgNf4NrEho3Z3
   2oq01WY6Q/CGRV/KNUhRWQ8SnwuZ1RKnLF9d1WgrKBoIE1kmpdPg+2bxc
   JXqnWyYgp+J9PsWjatABDLDKQ2SQqw0Jx0whEIcXupF1McFp0SiUmd97/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="2920696"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="2920696"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 02:05:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="5753878"
Received: from ksulimow-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.23.120])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 02:05:02 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>
Cc: ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 1/3] selftests/resctrl: Add cleanup function to test framework
Date: Thu, 22 Feb 2024 11:04:28 +0100
Message-ID: <357fdb981c7dddcc474818f7bedb1f57a79e117c.1708596015.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1708596015.git.maciej.wieczor-retman@intel.com>
References: <cover.1708596015.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resctrl selftests use very similar functions to cleanup after
themselves. This creates a lot of code duplication. Also not being
hooked to the test framework means that ctrl-c handler isn't aware of
what test is currently running and executes all cleanups even though
only one is needed.

Add a function pointer to the resctrl_test struct and attach to it
cleanup functions from individual tests.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 tools/testing/selftests/resctrl/cat_test.c | 1 +
 tools/testing/selftests/resctrl/cmt_test.c | 1 +
 tools/testing/selftests/resctrl/mba_test.c | 1 +
 tools/testing/selftests/resctrl/mbm_test.c | 1 +
 tools/testing/selftests/resctrl/resctrl.h  | 2 ++
 5 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 24af8310288a..2d2f69d3e5b7 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -299,4 +299,5 @@ struct resctrl_test l3_cat_test = {
 	.resource = "L3",
 	.feature_check = test_resource_feature_check,
 	.run_test = cat_run_test,
+	.cleanup = cat_test_cleanup,
 };
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index dd5ca343c469..32ddee87e43d 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -178,4 +178,5 @@ struct resctrl_test cmt_test = {
 	.resource = "L3",
 	.feature_check = cmt_feature_check,
 	.run_test = cmt_run_test,
+	.cleanup = cmt_test_cleanup,
 };
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index da256d2dbe5c..7cc4067ce930 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -180,4 +180,5 @@ struct resctrl_test mba_test = {
 	.vendor_specific = ARCH_INTEL,
 	.feature_check = mba_feature_check,
 	.run_test = mba_run_test,
+	.cleanup = mba_test_cleanup,
 };
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 34879e7b71a0..071e2d3808a7 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -150,4 +150,5 @@ struct resctrl_test mbm_test = {
 	.vendor_specific = ARCH_INTEL,
 	.feature_check = mbm_feature_check,
 	.run_test = mbm_run_test,
+	.cleanup = mbm_test_cleanup,
 };
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index c52eaf46f24d..0f49df4961ea 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -70,6 +70,7 @@ struct user_params {
  * @disabled:		Test is disabled
  * @feature_check:	Callback to check required resctrl features
  * @run_test:		Callback to run the test
+ * @cleanup:		Callback to cleanup after the test
  */
 struct resctrl_test {
 	const char	*name;
@@ -79,6 +80,7 @@ struct resctrl_test {
 	bool		(*feature_check)(const struct resctrl_test *test);
 	int		(*run_test)(const struct resctrl_test *test,
 				    const struct user_params *uparams);
+	void		(*cleanup)(void);
 };
 
 /*
-- 
2.43.2


