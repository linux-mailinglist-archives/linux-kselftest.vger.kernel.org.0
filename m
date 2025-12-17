Return-Path: <linux-kselftest+bounces-47628-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 701C0CC5DD1
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 04:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35557304280B
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 03:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3AB28C035;
	Wed, 17 Dec 2025 03:05:52 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out28-217.mail.aliyun.com (out28-217.mail.aliyun.com [115.124.28.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0FB29B781;
	Wed, 17 Dec 2025 03:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765940751; cv=none; b=R5dGLPHLnvhNRE+j6H9+x5TxITIZdVgc7tYbQ1G1MCQPnsbhw5Pmy0QKbKlE6TGAJJFSs1+44beUV5Iq6f5mJCHW5n+pXnQaVmnR7IbBusJQq0hEZ1DohkesQ4TP+PY+Pg5Yg1HhCDO25hHBQdimSMkJItaoD1Z9Bhpm4nW1Vu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765940751; c=relaxed/simple;
	bh=l8aHIE+gZNMr3xtTZZTNuGftofwLC6tgTUJTEeMhtYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BTVF8IUCQe8p5hllkmzD6cXt22neKP4016nkqTdA5S2oX+THyAmreehFrtl/79XZ+kbHWWYqhqyBIi6G6l9abWEZ8qOdXJSgIVJamzFrie7TpnSC6Aw7vpuXGQ0XPsEcKWS+BHk4bhrH764xR1Cw8UFzgTsMvE0GOYCssc9NXrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
Received: from localhost.localdomain(mailfrom:shenxiaochen@open-hieco.net fp:SMTPD_---.fmLmmB0_1765940738 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 17 Dec 2025 11:05:39 +0800
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
Subject: [PATCH v5 3/4] selftests/resctrl: Add CPU vendor detection for Hygon
Date: Wed, 17 Dec 2025 11:04:55 +0800
Message-ID: <20251217030456.3834956-4-shenxiaochen@open-hieco.net>
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
index 42605e2a3b66..dbcd5eea9fbc 100644
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


