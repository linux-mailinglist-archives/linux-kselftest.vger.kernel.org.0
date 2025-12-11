Return-Path: <linux-kselftest+bounces-47389-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7D4CB4E97
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 07:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46D5530081BA
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 06:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EF329B8C7;
	Thu, 11 Dec 2025 06:47:17 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out28-50.mail.aliyun.com (out28-50.mail.aliyun.com [115.124.28.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9C83B8D4B;
	Thu, 11 Dec 2025 06:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765435637; cv=none; b=suXQ5x4GLTTJAeUKOXspWEfnuKYw7S5dgHsRh3Hp6sz2/pu6k/1VsvH6QC53Y898MjWjO1UGqwz/wAtnTX5ROzq0hiKuIJ2/A9kghBp7gPwavDiht423y/mLxFNndt9UfkIGSziWzrbd+WVgSLOibhn3LGzoJMHksoOEV+B/Sgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765435637; c=relaxed/simple;
	bh=0o3JGfptk2ckHJcnm8xaASvg3+sqPLjA9Kk3vCuyNOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OaSEIEyLY0PTbNFuwHOFsInHdARBFI2825ams7H4v1tnRWoFUHf2gOWy1M2aVxpn7A9nJQUj6sXzjoA293O1Qdewbg9EoWtqKxsuXWMdkw40VGmbWBV5VpKy6T22eGKbjmm9NCaN66ypY2S8RQv17pLXaQQUC/8VGeBz40CGglo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
Received: from localhost.localdomain(mailfrom:shenxiaochen@open-hieco.net fp:SMTPD_---.fhodoTV_1765435622 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 11 Dec 2025 14:47:03 +0800
From: Xiaochen Shen <shenxiaochen@open-hieco.net>
To: tony.luck@intel.com,
	reinette.chatre@intel.com,
	bp@alien8.de,
	fenghuay@nvidia.com,
	shuah@kernel.org,
	skhan@linuxfoundation.org
Cc: babu.moger@amd.com,
	james.morse@arm.com,
	Dave.Martin@arm.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shenxiaochen@open-hieco.net
Subject: [PATCH v3 1/4] selftests/resctrl: Define CPU vendor IDs as bits to match usage
Date: Thu, 11 Dec 2025 14:46:29 +0800
Message-ID: <20251211064632.2344393-2-shenxiaochen@open-hieco.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251211064632.2344393-1-shenxiaochen@open-hieco.net>
References: <20251211064632.2344393-1-shenxiaochen@open-hieco.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CPU vendor IDs are required to be unique bits because they're used
for vendor_specific bitmask in the struct resctrl_test.
Consider for example their usage in test_vendor_specific_check():
	return get_vendor() & test->vendor_specific

However, the definitions of CPU vendor IDs in file resctrl.h is quite
subtle as a bitmask value:
  #define ARCH_INTEL     1
  #define ARCH_AMD       2

A clearer and more maintainable approach is to define these CPU vendor
IDs using BIT(). This ensures each vendor corresponds to a distinct bit
and makes it obvious when adding new vendor IDs.

Accordingly, update the return types of detect_vendor() and get_vendor()
from 'int' to 'unsigned int' to align with their usage as bitmask values
and to prevent potentially risky type conversions.

Furthermore, introduce a bool flag 'initialized' to simplify the
get_vendor() -> detect_vendor() logic. This ensures the vendor ID is
detected only once and resolves the ambiguity of using the same variable
'vendor' both as a value and as a state.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Suggested-by: Fenghua Yu <fenghuay@nvidia.com>
Signed-off-by: Xiaochen Shen <shenxiaochen@open-hieco.net>
---
 tools/testing/selftests/resctrl/resctrl.h     |  7 ++---
 .../testing/selftests/resctrl/resctrl_tests.c | 26 +++++++++++++------
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index cd3adfc14969..d0f094360e6f 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -23,6 +23,7 @@
 #include <asm/unistd.h>
 #include <linux/perf_event.h>
 #include <linux/compiler.h>
+#include <linux/bits.h>
 #include "../kselftest.h"
 
 #define MB			(1024 * 1024)
@@ -36,8 +37,8 @@
  * Define as bits because they're used for vendor_specific bitmask in
  * the struct resctrl_test.
  */
-#define ARCH_INTEL     1
-#define ARCH_AMD       2
+#define ARCH_INTEL	BIT(0)
+#define ARCH_AMD	BIT(1)
 
 #define END_OF_TESTS	1
 
@@ -163,7 +164,7 @@ extern int snc_unreliable;
 extern char llc_occup_path[1024];
 
 int snc_nodes_per_l3_cache(void);
-int get_vendor(void);
+unsigned int get_vendor(void);
 bool check_resctrlfs_support(void);
 int filter_dmesg(void);
 int get_domain_id(const char *resource, int cpu_no, int *domain_id);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 5154ffd821c4..08cbd094e936 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -23,16 +23,24 @@ static struct resctrl_test *resctrl_tests[] = {
 	&l2_noncont_cat_test,
 };
 
-static int detect_vendor(void)
+static unsigned int detect_vendor(void)
 {
-	FILE *inf = fopen("/proc/cpuinfo", "r");
-	int vendor_id = 0;
+	static bool initialized;
+	static unsigned int vendor_id;
+	FILE *inf;
 	char *s = NULL;
 	char *res;
 
-	if (!inf)
+	if (initialized)
 		return vendor_id;
 
+	inf = fopen("/proc/cpuinfo", "r");
+	if (!inf) {
+		vendor_id = 0;
+		initialized = true;
+		return vendor_id;
+	}
+
 	res = fgrep(inf, "vendor_id");
 
 	if (res)
@@ -45,15 +53,17 @@ static int detect_vendor(void)
 
 	fclose(inf);
 	free(res);
+
+	initialized = true;
 	return vendor_id;
 }
 
-int get_vendor(void)
+unsigned int get_vendor(void)
 {
-	static int vendor = -1;
+	unsigned int vendor;
+
+	vendor = detect_vendor();
 
-	if (vendor == -1)
-		vendor = detect_vendor();
 	if (vendor == 0)
 		ksft_print_msg("Can not get vendor info...\n");
 
-- 
2.47.3


