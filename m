Return-Path: <linux-kselftest+bounces-3557-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8B983C090
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 12:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 355001F2500E
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 11:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7B91C6B8;
	Thu, 25 Jan 2024 11:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jSjv95FV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0C451017;
	Thu, 25 Jan 2024 11:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706181057; cv=none; b=hEz4mXhtcDUS6jdl5mZ1EYVfYO/qv1Wk21A2AUcI21DntLeBcJml5Ti2R9uTcC+StSV/GsWXUOAJXxP8GLncbXo3QVj+CwxvIk5m752CuzmIbotIksaUVeQc6U6vwkRx3TXekrpx/upZzvZQ5J/buU1gMmtiZdmVgPimF40L9jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706181057; c=relaxed/simple;
	bh=zZN4cETb3MBIZuAuJx/wxgse1CPcOB28R3CvbuhlFiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iah5fXhV0zVnyXtpTRNvt9B8jIssj7Sf3/Oo6XGoTxAz2/M4C64VdggikqvWv8o5e2n3n6fht8voqbmhDAVAg/nPVihVWdyrVUy0btfDBzukdgpnpI8hOO6urGOSBaHT+oOSWkw/x2S+PdmY5rYltXK9TynP29UqEizsRM+XGKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jSjv95FV; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706181056; x=1737717056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zZN4cETb3MBIZuAuJx/wxgse1CPcOB28R3CvbuhlFiM=;
  b=jSjv95FVgT6btkMPgERI5FAAuWH3HF2gthpNaaZVZMeqjlE5SkugSSkb
   HPKMHU7hRy9uutnLJRtt0gamFCy80s70pPd0AgDsLaZMJv1SS3ZZwUfGe
   nM7zmX1WXdU4IxBpcseFS+HSTs0IU+RjSBhD7xlk1VNrfNiZeuV7eQFtl
   0fZIRaxfCPA0WNDObLwkMt65zmn6ncKY36Oespv2jaUSjGMsolSM+S72U
   vMiXDfOPRG5lqezWpkNs/ci4jPMlJ0Nc8gS5QUaKuSawGoNDbh7cgd+KT
   PtFaJ1GuaBzPKMj+srByldq2s1wtugwBWdTvmVKYDX+VdU+Qnk6gb90Zi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="9244149"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9244149"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 03:10:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="959822713"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="959822713"
Received: from apejovix-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.0.239])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 03:10:53 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: reinette.chatre@intel.com,
	fenghua.yu@intel.com,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com
Subject: [PATCH v3 1/5] selftests/resctrl: Add test groups and name L3 CAT test L3_CAT
Date: Thu, 25 Jan 2024 12:10:09 +0100
Message-ID: <4462d207c35c7d22875ab58be6aecb1a899d254f.1706180726.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706180726.git.maciej.wieczor-retman@intel.com>
References: <cover.1706180726.git.maciej.wieczor-retman@intel.com>
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
---
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


