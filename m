Return-Path: <linux-kselftest+bounces-47094-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62825CA6F78
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 10:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CA663017935
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 09:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4A13115A2;
	Fri,  5 Dec 2025 09:42:28 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out28-3.mail.aliyun.com (out28-3.mail.aliyun.com [115.124.28.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7672309EFA;
	Fri,  5 Dec 2025 09:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764927747; cv=none; b=qt/8n37hoMXh9Tb17AsRU8sQ+70d4LQRvBmMn6z/ZfMMXBY83yEGcJ0XzF/K/WjGb/U6FYxgyTlupUYN0zjRci296QgW/+D7wh8GH4z4Bq8GLPfQU90bkantQ/4WE8nwyg+rzXyLMU0m2c6kTnHayy8fB1e0bwmvADq6VO07An8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764927747; c=relaxed/simple;
	bh=ppQPS0N9E/PJBcTSbSTk5MAHlDlKeG8mU7ofuh9dmOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJljXUsfT8eRmbPaevmo2+ZsTOVumljf5Tkczznr/p8OIg1hqA168G8n3AIRRzbPLzxx9A+ez7buCqcHJ4HPbfJGuhxsZEbnD6pHW8LZI53I5xq7kVgtTe+sllLJtk2LISiqn/LWEie3WxeoGjMnZ280BhIpc9XAZWHzv5sxj7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
Received: from localhost.localdomain(mailfrom:shenxiaochen@open-hieco.net fp:SMTPD_---.fdWs0T0_1764926783 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 05 Dec 2025 17:26:26 +0800
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
Subject: [PATCH v2 1/3] selftests/resctrl: Add CPU vendor detection for Hygon
Date: Fri,  5 Dec 2025 17:25:42 +0800
Message-ID: <20251205092544.2685728-2-shenxiaochen@open-hieco.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251205092544.2685728-1-shenxiaochen@open-hieco.net>
References: <20251205092544.2685728-1-shenxiaochen@open-hieco.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The resctrl selftest currently fails on Hygon CPUs that support Platform
QoS features, printing the error:

  "# Can not get vendor info..."

This occurs because vendor detection is missing for Hygon CPUs.

Fix this by extending the CPU vendor detection logic to include
Hygon's vendor ID.

Signed-off-by: Xiaochen Shen <shenxiaochen@open-hieco.net>
---
 tools/testing/selftests/resctrl/resctrl.h       | 6 ++++--
 tools/testing/selftests/resctrl/resctrl_tests.c | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index cd3adfc14969..411ee10380a5 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -23,6 +23,7 @@
 #include <asm/unistd.h>
 #include <linux/perf_event.h>
 #include <linux/compiler.h>
+#include <linux/bits.h>
 #include "../kselftest.h"
 
 #define MB			(1024 * 1024)
@@ -36,8 +37,9 @@
  * Define as bits because they're used for vendor_specific bitmask in
  * the struct resctrl_test.
  */
-#define ARCH_INTEL     1
-#define ARCH_AMD       2
+#define ARCH_INTEL	BIT(0)
+#define ARCH_AMD	BIT(1)
+#define ARCH_HYGON	BIT(2)
 
 #define END_OF_TESTS	1
 
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 5154ffd821c4..9bf35f3beb6b 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -42,6 +42,8 @@ static int detect_vendor(void)
 		vendor_id = ARCH_INTEL;
 	else if (s && !strcmp(s, ": AuthenticAMD\n"))
 		vendor_id = ARCH_AMD;
+	else if (s && !strcmp(s, ": HygonGenuine\n"))
+		vendor_id = ARCH_HYGON;
 
 	fclose(inf);
 	free(res);
-- 
2.47.3


