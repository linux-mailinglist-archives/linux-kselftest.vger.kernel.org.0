Return-Path: <linux-kselftest+bounces-47632-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F0CCC5E98
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 04:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A29A6300955D
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 03:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD63214A8B;
	Wed, 17 Dec 2025 03:36:57 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out198-11.us.a.mail.aliyun.com (out198-11.us.a.mail.aliyun.com [47.90.198.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEDF3595D;
	Wed, 17 Dec 2025 03:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765942617; cv=none; b=TkARb5zNAV5TH7XR63St46nVY4L1XBLK/OX83qphQd+74DPW4g69wVsk+cVm/BWthQSG72aPpXbp9Ulm1EU4KLQbwtwxjSVIwx/oACCQp8+Qj/AvoejyUsPeiuyDWnPttb8/vbDFYf4z/jf3mK+Q5cQF6U7I6U1yoS1BUSIuQ48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765942617; c=relaxed/simple;
	bh=Z5lfrJjJzPWYCKC/F+6oK2JX8Y/M9TIdFPlWdkAHreI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AG6WOLyx4hZ45y2Rtx5UWq+7kh/HGxcaWqfpunDC7Zh4621pNgRjBViQzVmI61ICrgyS+appf+euwHlEetYFO9yijFOFLtROGk1Alum8/yI9oqYUZf9aNmh1A8PlSobV7REg8WH3fWU+zMyfcUOSGczdHUrR9+rznCxXy7rk2+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=47.90.198.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
Received: from localhost.localdomain(mailfrom:shenxiaochen@open-hieco.net fp:SMTPD_---.fmLmm9V_1765940736 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 17 Dec 2025 11:05:37 +0800
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
Subject: [PATCH v5 2/4] selftests/resctrl: Define CPU vendor IDs as bits to match usage
Date: Wed, 17 Dec 2025 11:04:54 +0800
Message-ID: <20251217030456.3834956-3-shenxiaochen@open-hieco.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251217030456.3834956-1-shenxiaochen@open-hieco.net>
References: <20251217030456.3834956-1-shenxiaochen@open-hieco.net>
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
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/resctrl/resctrl.h     |  7 ++---
 .../testing/selftests/resctrl/resctrl_tests.c | 26 +++++++++++++------
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 3c51bdac2dfa..4f9c7d04c98d 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -23,6 +23,7 @@
 #include <asm/unistd.h>
 #include <linux/perf_event.h>
 #include <linux/compiler.h>
+#include <linux/bits.h>
 #include "kselftest.h"
 
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
index 5154ffd821c4..42605e2a3b66 100644
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
+	static unsigned int vendor_id;
+	static bool initialized;
 	char *s = NULL;
+	FILE *inf;
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


