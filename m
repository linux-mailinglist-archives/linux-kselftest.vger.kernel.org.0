Return-Path: <linux-kselftest+bounces-47388-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A7CCB4E94
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 07:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33CC63007EDC
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 06:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FB1299928;
	Thu, 11 Dec 2025 06:47:17 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out28-194.mail.aliyun.com (out28-194.mail.aliyun.com [115.124.28.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B8027E7EC;
	Thu, 11 Dec 2025 06:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765435636; cv=none; b=WdJaBoMaRrE6C2tewkMDxYoPV133zzJhyg9RbnhakL6P3+52rU+IXDS471sT3JPQY+bIZhiIUCKOuCqkUF4RmrgAKOGLn+1+sfXJ3FYu4jYa9WAGOVpU9s1jG0E4LR0ZMuEWsEZCnD2rV9PT+cUSm+H5tkCXtIyMdxX6CR/eG3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765435636; c=relaxed/simple;
	bh=2YEoP/WBSLku9O3QwMjDqy7IlRvGoIPXUKxMPvaCe1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DgxkaDAOjYnQWaj569zJw+l1IKdvfo3NDp8xmwihqkM7XzDVF1vS6uZSoxYjPny6B/NMFrkTDhT0c9RzL3WnlUMNYmQUAvhmpDU6FzYXPFjU/AEYIGICi/lRWWz5AWv0ShZa/j3zhfGblQu2ggliZBj47QCeSEnWGVz7dHh1KzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
Received: from localhost.localdomain(mailfrom:shenxiaochen@open-hieco.net fp:SMTPD_---.fhodoUl_1765435623 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 11 Dec 2025 14:47:04 +0800
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
Subject: [PATCH v3 2/4] selftests/resctrl: Add CPU vendor detection for Hygon
Date: Thu, 11 Dec 2025 14:46:30 +0800
Message-ID: <20251211064632.2344393-3-shenxiaochen@open-hieco.net>
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

The resctrl selftest currently fails on Hygon CPUs that support Platform
QoS features, printing the error:

  "# Can not get vendor info..."

This occurs because vendor detection is missing for Hygon CPUs.

Fix this by extending the CPU vendor detection logic to include
Hygon's vendor ID.

Signed-off-by: Xiaochen Shen <shenxiaochen@open-hieco.net>
---
 tools/testing/selftests/resctrl/resctrl.h       | 1 +
 tools/testing/selftests/resctrl/resctrl_tests.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index d0f094360e6f..2817c9e41797 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -39,6 +39,7 @@
  */
 #define ARCH_INTEL	BIT(0)
 #define ARCH_AMD	BIT(1)
+#define ARCH_HYGON	BIT(2)
 
 #define END_OF_TESTS	1
 
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 08cbd094e936..92cc6aaef338 100644
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


