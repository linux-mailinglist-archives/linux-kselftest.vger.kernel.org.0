Return-Path: <linux-kselftest+bounces-47550-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA8DCBA6AD
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Dec 2025 08:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02971300C366
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Dec 2025 07:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E20425A2B4;
	Sat, 13 Dec 2025 07:39:19 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out28-172.mail.aliyun.com (out28-172.mail.aliyun.com [115.124.28.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3436A219E8;
	Sat, 13 Dec 2025 07:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765611559; cv=none; b=QJfkpTgeuZxveNvS5EMn2Lqil3T/hIyv1UM/X6Wit0xqQyyTuty+sLFl9goiY7b1CsFBBswkM4Y/FrQZ9D3VZWvmrL6vr2IJIAUFP6dJOfi3CMmxQlmAdMyuaoScEecQpirTKZD5quuD91VDHJvP9YGZkCIEiqk0ElhAOKVr5GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765611559; c=relaxed/simple;
	bh=Ob1z+21rD4i0I/w7vo7MH52MRJO6sFsR8hG+Frj/3Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/th00CKqVNrfg6CrsOW/9oGNR4gnQU/CEF57xt2Jz67SqZr0BZgAfjaweXHhgpg4RC7ykt483DgFJ5jfG30oS/klYCuVe8yQ1KPEZcS+44ok5cpT9hr2PN741syVR+ys4yyYR1yyoQVaiO2VFM5tf+3AyoQp6vAZruWgIi5FNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
Received: from localhost.localdomain(mailfrom:shenxiaochen@open-hieco.net fp:SMTPD_---.fjNqpry_1765611540 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 13 Dec 2025 15:39:02 +0800
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
Subject: [PATCH v4 2/4] selftests/resctrl: Define CPU vendor IDs as bits to match usage
Date: Sat, 13 Dec 2025 15:38:09 +0800
Message-ID: <20251213073811.3016864-3-shenxiaochen@open-hieco.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251213073811.3016864-1-shenxiaochen@open-hieco.net>
References: <20251213073811.3016864-1-shenxiaochen@open-hieco.net>
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
index 5154ffd821c4..980ecf2bcf10 100644
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
+	FILE *inf;
+	static unsigned int vendor_id;
 	char *s = NULL;
 	char *res;
+	static bool initialized;
 
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


