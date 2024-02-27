Return-Path: <linux-kselftest+bounces-5474-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F74B8689C4
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 08:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBED51C21D93
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 07:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36735467A;
	Tue, 27 Feb 2024 07:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dbTWJBnM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F57154775;
	Tue, 27 Feb 2024 07:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709018522; cv=none; b=emtBiV9LkFsXv7aFXdYRqV81hbyNTSDxXglxKWbQoM+a3OHbIghSW0ZVHfG5Ywbka+eMj+5qyU54aNW44Xkgnf6x1qpR93/YCq3mtPMBWvP3wJIPRg7XzP8RwbwkcmN8MpQNp7Gh3XMfVysX/wd0/iah7/9npTEtoJI9L1ZJCjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709018522; c=relaxed/simple;
	bh=WTwAMZ8VnEDkTh0dE/dMd6d/Mq+BRQMlMkdEJRqlfZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=obZJEAn5LOxkhxJCNLLH80GldMuTMM+J6i260W6eYx7TisbSxwu+V7K/OS73lJ9wdvhiX+adbjOYTCHDjEkEbGL38XNTmbjkGjZ0ICyzzpaVrf0E5Tm6t+I5ck75Scy3ltLXr3r13+QxZyD54kBaxjvVfNL/+nl93qfxzVcuaKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dbTWJBnM; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709018520; x=1740554520;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WTwAMZ8VnEDkTh0dE/dMd6d/Mq+BRQMlMkdEJRqlfZI=;
  b=dbTWJBnM+JVC1qFrJg9fJm5XGWw7WfCiQC5nTydcGPareNruXRva2FwI
   mgPd4K5X+yz35LfMcNVI/IdO46Hgxvyl1FScVE3OYiL43rjmzWyW8E0lW
   sQdVv7V1Dx6kXgVgFMD4v6VaF9LUOz6Vh1IgcXUw6UmfIwQisgTeupfEV
   YWfvpchFiUb6L+xNIon45t+bkQwzYEA4bIV3OzJFy0cwfppOUyusZfWI4
   6hKJGSYSodRuBARxMarLmeELkRVpbhCXOwDj3gkM/5gQ3HCXT2YCGanT6
   lQB7ZUquN+1OHHHL14Er+vf1XhJw3CH05qCBYEfr9dmXjF2dySN1PYCxx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3508435"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="3508435"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 23:22:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="6910275"
Received: from lzaleski-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.4.236])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 23:21:57 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>
Cc: ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v5 1/3] selftests/resctrl: Add cleanup function to test framework
Date: Tue, 27 Feb 2024 08:21:41 +0100
Message-ID: <bcf471c82a58ef4e053fe5729b1df09e859f25d0.1709018050.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1709018050.git.maciej.wieczor-retman@intel.com>
References: <cover.1709018050.git.maciej.wieczor-retman@intel.com>
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
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changelog v5:
- Rebased onto kselftests/next.
- Add Reinette's reviewed-by tag.

 tools/testing/selftests/resctrl/cat_test.c | 1 +
 tools/testing/selftests/resctrl/cmt_test.c | 1 +
 tools/testing/selftests/resctrl/mba_test.c | 1 +
 tools/testing/selftests/resctrl/mbm_test.c | 1 +
 tools/testing/selftests/resctrl/resctrl.h  | 2 ++
 5 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 4cb991be8e31..8fa4348ab461 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -373,6 +373,7 @@ struct resctrl_test l3_cat_test = {
 	.resource = "L3",
 	.feature_check = test_resource_feature_check,
 	.run_test = cat_run_test,
+	.cleanup = cat_test_cleanup,
 };
 
 struct resctrl_test l3_noncont_cat_test = {
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index a81f91222a89..a01ccf86e6ce 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -178,4 +178,5 @@ struct resctrl_test cmt_test = {
 	.resource = "L3",
 	.feature_check = cmt_feature_check,
 	.run_test = cmt_run_test,
+	.cleanup = cmt_test_cleanup,
 };
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 7946e32e85c8..189fbe20dc7b 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -180,4 +180,5 @@ struct resctrl_test mba_test = {
 	.vendor_specific = ARCH_INTEL,
 	.feature_check = mba_feature_check,
 	.run_test = mba_run_test,
+	.cleanup = mba_test_cleanup,
 };
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index d67ffa3ec63a..73d6a8b989f5 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -150,4 +150,5 @@ struct resctrl_test mbm_test = {
 	.vendor_specific = ARCH_INTEL,
 	.feature_check = mbm_feature_check,
 	.run_test = mbm_run_test,
+	.cleanup = mbm_test_cleanup,
 };
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 2051bd135e0d..221c94532733 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -72,6 +72,7 @@ struct user_params {
  * @disabled:		Test is disabled
  * @feature_check:	Callback to check required resctrl features
  * @run_test:		Callback to run the test
+ * @cleanup:		Callback to cleanup after the test
  */
 struct resctrl_test {
 	const char	*name;
@@ -82,6 +83,7 @@ struct resctrl_test {
 	bool		(*feature_check)(const struct resctrl_test *test);
 	int		(*run_test)(const struct resctrl_test *test,
 				    const struct user_params *uparams);
+	void		(*cleanup)(void);
 };
 
 /*
-- 
2.43.2


