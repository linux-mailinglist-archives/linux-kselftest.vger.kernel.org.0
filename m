Return-Path: <linux-kselftest+bounces-5283-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED8285F7BC
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 13:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D02E11C23527
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 12:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266086089A;
	Thu, 22 Feb 2024 12:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XaeK9vDp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D6060873;
	Thu, 22 Feb 2024 12:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708603672; cv=none; b=kAEL19joA47I8mbD8jb99pLE3C0zq6KhYVeBeQXfD83CsFzKuqANFMTs2j0ztNd9sixLI/i84aMdKW4jiUfORGpc4frzzozRP/RoK3aC7hfGoS+eMoIqU0p9MxNbZXwoqh1LL6JrD6hcDnp9uoR8bkkjVCVmIwVjk9XOY/o982o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708603672; c=relaxed/simple;
	bh=Gi1VkP9GPyzQfNuuc0NAYEJ6mkbO6wyMOkVcf8T5EK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D8Xv2LIpGJr6oYFv2eFPrvtx739L9bhE+97O3WVIKRx2pfwKjnN0ksR4iiV61yPNqhMOumrYF6KM1X9+LwZM9N7WOegGGoDYME63LFvawoaN/XXXo6ir72iTu7yEGRWyn3I9cjWHxop5r+yzWtAvYQu4C04/YhvpH8q+BUQ1sIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XaeK9vDp; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708603670; x=1740139670;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gi1VkP9GPyzQfNuuc0NAYEJ6mkbO6wyMOkVcf8T5EK0=;
  b=XaeK9vDp+GNnNr4GygUsocQWlW4YUb97BRRA4Lj0rqt2UsMpEK1jSxuN
   oC/rGJh8RyW/uxsAg9Hhg0RRxsNo08iSk48YS2cB4UaqD2RJejjlu5bME
   Rm0V9wmz91IzoaSJl8+HGc39BAlNkwRbq1K9qemp8WKVW4o8wM8RXLQaU
   ZhVrYYaubkvsKe7VmXS7HRPWMosejLG8PsZ5NMvf5hWzLXHzlDrIDFZib
   b7YeML1tR9/r46IXNdQgrEEpDx1GQgbTgxU/scPgtSUdN37SoXQspvEeD
   4fgAieo0l8P0Bha+9dIorPWnJZjUVvkPgdY2wigeMfdRcJXCCRNhk0HO+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="2974032"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="2974032"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 04:07:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="5843247"
Received: from ksulimow-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.23.120])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 04:07:47 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>
Cc: ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 1/3] selftests/resctrl: Add cleanup function to test framework
Date: Thu, 22 Feb 2024 13:07:29 +0100
Message-ID: <357fdb981c7dddcc474818f7bedb1f57a79e117c.1708599491.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1708599491.git.maciej.wieczor-retman@intel.com>
References: <cover.1708599491.git.maciej.wieczor-retman@intel.com>
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


