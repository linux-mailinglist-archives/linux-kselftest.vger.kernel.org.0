Return-Path: <linux-kselftest+bounces-4426-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 294DB84F660
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 15:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDB2B283B21
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 14:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24985730A;
	Fri,  9 Feb 2024 14:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hW100hmi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E744F896;
	Fri,  9 Feb 2024 14:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707487288; cv=none; b=Y5HY7fwpgbU0ILY43yV92VyvJrtoIZlwXsFgozFtzC/TbxfdgC3gazqwn5H70ShIQxL0KT67WAY+ChserE43Q7eUC1ynB4qyw67R6MQ766uNw7UP0z3AWQOxx03zCgA7zL6xkZ7wD0paJhwhLjIrQ3ip3dBJ0CtAVu4q0rbRgtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707487288; c=relaxed/simple;
	bh=ITmCMI4xWgouC17/92dBGHeJbGzaQW2iSuy8CYT4Aao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rn2jTaqDe8HkShRwWONyU6lPVH2VH3Xh+n7TTEIO8CIvNcHeqWEREGsYe1B1Ys4BQySWxVSxHkrBlxWRomQ3esI/BrgQsdBYU/LH5VRRUCgLtkSoQmGCfh4T4pH5OEaOZpl/QPk84nBZLpa9h1Ps30IHGAcXrwC2k1DSMuiguq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hW100hmi; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707487287; x=1739023287;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ITmCMI4xWgouC17/92dBGHeJbGzaQW2iSuy8CYT4Aao=;
  b=hW100hmibI0vASIr2Dih7NzUYWftVkGZwaNh0a/ilrreQ2NAxYPNxAKg
   PfLKpPKlLht3PCubq4ZB5nlvilvdT0GrSZ9PC5SvkuPFvuoOP7CP4NWzO
   ITh4BfnOpKpBu58iELnGQKMzDy4pzt3/kbcE1wHT6GNgMxhLZgOq5YQ+H
   ZQpwi5pXlEPAYsCcA1SdWMYhZJ0pvlyACbzx9P2AEAnKrNA8vJNsES/Ha
   6VPUdfZfPZIrqD1PWkmuiDqkh03vi4F9ZEtbfqYEsnN7gwaEdsXRj3BlH
   J9wCcQ3DurmmNxrBD/2d4JTlHU5Sk4KQWykgc4sNX8ku5sCaDSsbY3SO4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="12801813"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="12801813"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 06:01:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="2284399"
Received: from ldziemin-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.2.218])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 06:01:23 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: reinette.chatre@intel.com,
	shuah@kernel.org,
	fenghua.yu@intel.com
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com
Subject: [PATCH v5 1/5] selftests/resctrl: Add test groups and name L3 CAT test L3_CAT
Date: Fri,  9 Feb 2024 15:01:10 +0100
Message-ID: <62192ad50be67f750b78a0e28a62b7704fbc63f5.1707487039.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707487039.git.maciej.wieczor-retman@intel.com>
References: <cover.1707487039.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

To select test to run -t parameter can be used. However, -t cat
currently maps to L3 CAT test which will be confusing after more CAT
related tests will be added.

Allow selecting tests as groups and call L3 CAT test "L3_CAT", "CAT"
group will enable all CAT related tests.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changelog v5:
- Add Reinette's reviewed-by tag.

Changelog v3:
- Expand group description in struct comment (Reinette).

Changelog v2:
- Move this patch from Ilpo's series here (Ilpo).

 tools/testing/selftests/resctrl/cat_test.c      |  3 ++-
 tools/testing/selftests/resctrl/resctrl.h       |  3 +++
 tools/testing/selftests/resctrl/resctrl_tests.c | 16 +++++++++++-----
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 24af8310288a..39fc9303b8e8 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -295,7 +295,8 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
 }
 
 struct resctrl_test l3_cat_test = {
-	.name = "CAT",
+	.name = "L3_CAT",
+	.group = "CAT",
 	.resource = "L3",
 	.feature_check = test_resource_feature_check,
 	.run_test = cat_run_test,
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index c52eaf46f24d..a1462029998e 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -65,6 +65,8 @@ struct user_params {
 /*
  * resctrl_test:	resctrl test definition
  * @name:		Test name
+ * @group:		Test group - a common name for tests that share some characteristic
+ *			(e.g., L3 CAT test belongs to the CAT group). Can be NULL
  * @resource:		Resource to test (e.g., MB, L3, L2, etc.)
  * @vendor_specific:	Bitmask for vendor-specific tests (can be 0 for universal tests)
  * @disabled:		Test is disabled
@@ -73,6 +75,7 @@ struct user_params {
  */
 struct resctrl_test {
 	const char	*name;
+	const char	*group;
 	const char	*resource;
 	unsigned int	vendor_specific;
 	bool		disabled;
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 75fc49ba3efb..3044179ee6e9 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -65,11 +65,15 @@ static void cmd_help(void)
 	printf("usage: resctrl_tests [-h] [-t test list] [-n no_of_bits] [-b benchmark_cmd [option]...]\n");
 	printf("\t-b benchmark_cmd [option]...: run specified benchmark for MBM, MBA and CMT\n");
 	printf("\t   default benchmark is builtin fill_buf\n");
-	printf("\t-t test list: run tests specified in the test list, ");
+	printf("\t-t test list: run tests/groups specified by the list, ");
 	printf("e.g. -t mbm,mba,cmt,cat\n");
-	printf("\t\tSupported tests:\n");
-	for (i = 0; i < ARRAY_SIZE(resctrl_tests); i++)
-		printf("\t\t\t%s\n", resctrl_tests[i]->name);
+	printf("\t\tSupported tests (group):\n");
+	for (i = 0; i < ARRAY_SIZE(resctrl_tests); i++) {
+		if (resctrl_tests[i]->group)
+			printf("\t\t\t%s (%s)\n", resctrl_tests[i]->name, resctrl_tests[i]->group);
+		else
+			printf("\t\t\t%s\n", resctrl_tests[i]->name);
+	}
 	printf("\t-n no_of_bits: run cache tests using specified no of bits in cache bit mask\n");
 	printf("\t-p cpu_no: specify CPU number to run the test. 1 is default\n");
 	printf("\t-h: help\n");
@@ -199,7 +203,9 @@ int main(int argc, char **argv)
 				bool found = false;
 
 				for (i = 0; i < ARRAY_SIZE(resctrl_tests); i++) {
-					if (!strcasecmp(token, resctrl_tests[i]->name)) {
+					if (!strcasecmp(token, resctrl_tests[i]->name) ||
+					    (resctrl_tests[i]->group &&
+					     !strcasecmp(token, resctrl_tests[i]->group))) {
 						if (resctrl_tests[i]->disabled)
 							tests++;
 						resctrl_tests[i]->disabled = false;
-- 
2.43.0


