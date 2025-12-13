Return-Path: <linux-kselftest+bounces-47549-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE8DCBA6AA
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Dec 2025 08:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C99FB305E377
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Dec 2025 07:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A1C2236E0;
	Sat, 13 Dec 2025 07:39:18 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out28-52.mail.aliyun.com (out28-52.mail.aliyun.com [115.124.28.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BD2214A64;
	Sat, 13 Dec 2025 07:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765611558; cv=none; b=ZnOY2kkJsmIZb+Qcvrv6PHHKlYfUDDQMmjRs/yYkGI7kU+C4hYd80Cm/ZNbGr10j55ZRmJpZPW8jErxqRYRvbOuPf3jKohfhw8TCe91XdAQtd27KtR1JzQox6I9ZZ1qRVJFGr4Y7pgbJPOWkuxONXEj+01gXrRmPfbMqVXmTgwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765611558; c=relaxed/simple;
	bh=0Ca7myKC8kmKRiG/2n/eciaKr7dyRWmpXAVFSAJLv3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ja1peKOZFpWK5V+ZyfJMvL7cP1Bt1IPvRrmdqlfzYYKkpHTvxGF27j3k1EnFDUb5+arQIfxiIzl9ZbDRF1OcA/C9buI+BtIE7NQ3wD8MrdBi0nCgBfLB6QK/XCViPtZ2DOOOl1VT4ed/m46pvRa7aCoHpfrlZhWoHU5gUN30IR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
Received: from localhost.localdomain(mailfrom:shenxiaochen@open-hieco.net fp:SMTPD_---.fjNqpvI_1765611543 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 13 Dec 2025 15:39:05 +0800
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
Subject: [PATCH v4 3/4] selftests/resctrl: Add CPU vendor detection for Hygon
Date: Sat, 13 Dec 2025 15:38:10 +0800
Message-ID: <20251213073811.3016864-4-shenxiaochen@open-hieco.net>
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

The resctrl selftest currently fails on Hygon CPUs that support Platform
QoS features, printing the error:

  "# Can not get vendor info..."

This occurs because vendor detection is missing for Hygon CPUs.

Fix this by extending the CPU vendor detection logic to include
Hygon's vendor ID.

Signed-off-by: Xiaochen Shen <shenxiaochen@open-hieco.net>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/resctrl/resctrl.h       | 1 +
 tools/testing/selftests/resctrl/resctrl_tests.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 4f9c7d04c98d..afe635b6e48d 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -39,6 +39,7 @@
  */
 #define ARCH_INTEL	BIT(0)
 #define ARCH_AMD	BIT(1)
+#define ARCH_HYGON	BIT(2)
 
 #define END_OF_TESTS	1
 
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 980ecf2bcf10..78626bbae976 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -50,6 +50,8 @@ static unsigned int detect_vendor(void)
 		vendor_id = ARCH_INTEL;
 	else if (s && !strcmp(s, ": AuthenticAMD\n"))
 		vendor_id = ARCH_AMD;
+	else if (s && !strcmp(s, ": HygonGenuine\n"))
+		vendor_id = ARCH_HYGON;
 
 	fclose(inf);
 	free(res);
-- 
2.47.3


