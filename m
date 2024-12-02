Return-Path: <linux-kselftest+bounces-22676-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC39D9E0812
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 17:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6562B61930
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 13:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6AA2036F9;
	Mon,  2 Dec 2024 13:56:01 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A9C202F96;
	Mon,  2 Dec 2024 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733147761; cv=none; b=IkdfWVvFc23X9BUjrPZnC5sWoJWvSESmRWBkHn+9RsT3I1V8zsSM3NdDMSYV+NfKl4H9udAOfOyrVxjK4K2xgyhDSjuDygGc/0VjdoovjUEJtQxsiAD0nFKEY/qQMeFYBsghz/6QI2OXuhXY6gsGgGfwudVbFbv3bd8m/u11CUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733147761; c=relaxed/simple;
	bh=9+YMFUX2I4HdFTp/92kou6lyfn8Jnbq3OTAQBv0F0qM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jhlqHKkr/CILz4GGN0oG6MLsutyKi7YNUkfAhvvaXShNByfj4+m+JtGgnce3BWCJd/EPxsYyGSDYBYv5ZPu5JUH6FE7F8elsXx5wlXlOuvRkVL+BddZHpN+5+/8fCyir8w7wtOuXP4SKmYb5sB6R1bmVCOEEVxIASzYQRJmN60U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Y24xx2ZZ4z1T65k;
	Mon,  2 Dec 2024 21:53:41 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 64E80140135;
	Mon,  2 Dec 2024 21:55:56 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 2 Dec 2024 21:55:55 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <maz@kernel.org>,
	<oliver.upton@linux.dev>, <corbet@lwn.net>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC: <joey.gouly@arm.com>, <suzuki.poulose@arm.com>, <yuzenghui@huawei.com>,
	<shuah@kernel.org>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <xuwei5@huawei.com>, <yangyicong@hisilicon.com>
Subject: [PATCH 1/5] arm64: Provide basic EL2 setup for FEAT_{LS64, LS64_V, LS64_ACCDATA} usage at EL0/1
Date: Mon, 2 Dec 2024 21:55:00 +0800
Message-ID: <20241202135504.14252-2-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20241202135504.14252-1-yangyicong@huawei.com>
References: <20241202135504.14252-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200014.china.huawei.com (7.221.188.8)

From: Yicong Yang <yangyicong@hisilicon.com>

Instructions introduced by FEAT_{LS64, LS64_V, LS64_ACCDATA} is
controlled by HCRX_EL2.{EnALS, EnASR, EnAS0}. Additionally
access of ACCDATA_EL1 for FEAT_LS64_ACCDATA is also affected by
FGT. Configure all of these to allow usage at EL0/1.

This doesn't mean these instructions are always available in
EL0/1 if provided. The hypervisor still have the control at
runtime.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 arch/arm64/include/asm/el2_setup.h | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index 85ef966c08cd..446d3663840b 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -31,9 +31,22 @@
         /* Enable GCS if supported */
 	mrs_s	x1, SYS_ID_AA64PFR1_EL1
 	ubfx	x1, x1, #ID_AA64PFR1_EL1_GCS_SHIFT, #4
-	cbz	x1, .Lset_hcrx_\@
+	cbz	x1, .Lskip_gcs_hcrx_\@
 	orr	x0, x0, #HCRX_EL2_GCSEn
 
+.Lskip_gcs_hcrx_\@:
+	/* Enable LS64, LS64_V, LS64_ACCDATA if supported */
+	mrs_s	x1, SYS_ID_AA64ISAR1_EL1
+	ubfx	x1, x1, #ID_AA64ISAR1_EL1_LS64_SHIFT, #4
+	cbz	x1, .Lset_hcrx_\@
+	orr	x0, x0, #HCRX_EL2_EnALS
+	cmp	x1, #ID_AA64ISAR1_EL1_LS64_LS64_V
+	b.lt	.Lset_hcrx_\@
+	orr	x0, x0, #HCRX_EL2_EnASR
+	cmp	x1, #ID_AA64ISAR1_EL1_LS64_LS64_ACCDATA
+	b.lt	.Lset_hcrx_\@
+	orr	x0, x0, #HCRX_EL2_EnAS0
+
 .Lset_hcrx_\@:
 	msr_s	SYS_HCRX_EL2, x0
 .Lskip_hcrx_\@:
@@ -211,12 +224,21 @@
 	/* GCS depends on PIE so we don't check it if PIE is absent */
 	mrs_s	x1, SYS_ID_AA64PFR1_EL1
 	ubfx	x1, x1, #ID_AA64PFR1_EL1_GCS_SHIFT, #4
-	cbz	x1, .Lset_fgt_\@
+	cbz	x1, .Lskip_gcs_fgt_\@
 
 	/* Disable traps of access to GCS registers at EL0 and EL1 */
 	orr	x0, x0, #HFGxTR_EL2_nGCS_EL1_MASK
 	orr	x0, x0, #HFGxTR_EL2_nGCS_EL0_MASK
 
+.Lskip_gcs_fgt_\@:
+	mrs_s	x1, SYS_ID_AA64ISAR1_EL1
+	ubfx	x1, x1, #ID_AA64ISAR1_EL1_LS64_SHIFT, #4
+	cmp	x1, #ID_AA64ISAR1_EL1_LS64_LS64_ACCDATA
+	b.ne	.Lset_fgt_\@
+
+	/* Disable the trapping of ACCDATA_EL1 */
+	orr	x0, x0, #HFGxTR_EL2_nACCDATA_EL1
+
 .Lset_fgt_\@:
 	msr_s	SYS_HFGRTR_EL2, x0
 	msr_s	SYS_HFGWTR_EL2, x0
-- 
2.24.0


