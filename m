Return-Path: <linux-kselftest+bounces-22066-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9E49C9640
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 00:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D98BB2539C
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 23:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9394A1B85D7;
	Thu, 14 Nov 2024 23:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xq8oFTVF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BCA1B85C2;
	Thu, 14 Nov 2024 23:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731627688; cv=fail; b=FMrtfYYu4tsruZiJL+/dhVl0P90Bc2jX3fFZ0VL6r2jKkJ/FlY8YRtVpHHWLyF1TroKx0Ni8qasWFXmXm4GHLTmsYb6Vd3saQYv+/gp6mHi69CbAkBxLoIqIjCJm5nKjDj4PcLGrRpnWJYe6vG4LdGo2JJy35BU32Yy3bTEeLlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731627688; c=relaxed/simple;
	bh=yHY3EDgDUdTmYX3YgFxmZGHuQqMpDnoRBky5uCUH1YA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DNLuiEgZ3ufLkUw9kBwUx0EoSVQD8X7HCrcalw2OGnXWvrlqgPyu36PcOSj1zZdeYzbF1moRO+ZtU7N/+wYPfq51iAKt799llOsJwj7Ti/Xbh7k2hHER3UtGmV78PXfOVVQykpsvVKPQ+W3BiaGfw2Stp6J4nK28IFYlPUkVUeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xq8oFTVF; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4CGupI9vd8d4PwCgSeXs4gXsYq8Bn3Cj382H8Oa/VY64ypY/5xDFhhnAlhe9F+GAdD2yWFLI2mKAbwhNySHC9ybzdWCc8CKlJJUawIFURyDS5fXQLUSc74LThNPLCCnfO/Ugx2Eb2dUcN/NDHJpCxaMqYG+Gf0CJ3HNKV9qKViGnopIZrmvkeIpdj2kx5ziZS1NOV0CBvvDw7MfPwzCokTrGM8NG/MDiu9mKvDv4SP/njzS7/4cSJpn8grmkEXhiHpWrojDwLsfISN6cpqBIMVOUlsDe8DDr8DcJWAOAn8PJV0HNB5Ef8Z7w7CYqujqtAqpYdHeai6PBTm5g1iGwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afyHDxG922NglCp6p2wbKPTnduMg5Jic4JTKLkdAQQc=;
 b=EMcOmKsNieYZU7I1u+hC+67lze61IYRf570IUNxKpzatPwGUIbxFXEyaPJAK59qdJ1/uOrU47L3VESudeX0pDqGpJ8ylvmV02zMYaApg1BXrjYWwuiUFOvr0W3u6qkLDS3Sq2GrS4n95HfpHbZMl/MuY6WQWOJndBuaxeTCu/E1fliXVbULgc0ZROSSK2dS6tKEZjzPwbij46LA8+F3dlZFjXFp9GfH8HxbxfjTwYBp2rXL9lX5SC7MJy911pCfgdbR0bN67u4ftnMcfCGSuo9gLnjbZbK6A6IIRDn2DpiD3O5+SnfuzkOz36xx83HiRemP64GRehFBdQTMzv53p/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afyHDxG922NglCp6p2wbKPTnduMg5Jic4JTKLkdAQQc=;
 b=xq8oFTVFYOByq55BvkiU27LA/Ntu5gt6wQIC+nvJ/CYY0XihVhUQhMXN3HtXm3Wgy7YJM6Bj2MZTr0dRhb8uMdVlZwRKZwDUeG1G8Kq/KXs9fztpbk/doViUIaxXq0vB8PlQvNKdXMCQmtJ8oeb8dtoDWY2jVsLtL6sh2GqOtSs=
Received: from BY1P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::9)
 by DM6PR12MB4370.namprd12.prod.outlook.com (2603:10b6:5:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Thu, 14 Nov
 2024 23:41:22 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::1d) by BY1P220CA0014.outlook.office365.com
 (2603:10b6:a03:59d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Thu, 14 Nov 2024 23:41:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 23:41:22 +0000
Received: from AUSPRSAMPAT.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Nov
 2024 17:41:21 -0600
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
To: <kvm@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<sos-linux-ext-patches@mailman-svr.amd.com>, <pratikrajesh.sampat@amd.com>
Subject: [PATCH v4 1/8] KVM: SEV: Disable SEV-SNP on FW validation failure
Date: Thu, 14 Nov 2024 17:40:57 -0600
Message-ID: <20241114234104.128532-2-pratikrajesh.sampat@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241114234104.128532-1-pratikrajesh.sampat@amd.com>
References: <20241114234104.128532-1-pratikrajesh.sampat@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|DM6PR12MB4370:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b2a70cd-673e-48c7-61c4-08dd0505d8a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h1P2Xe3kMig6/Z5AnCrQQCnEy5kONU/lTHvvShkXJji95FgGFrbh8Bj+u+5r?=
 =?us-ascii?Q?CHI4wY68RucmkRk18w72TBYvFmgtJNhN3iSyoghZpgSMiG4v9Lu6XKWZqW+2?=
 =?us-ascii?Q?GLNqz2BqmtcmnAxTfkNieuqsP1/CeLtog7gmFVkfM4RI0lUvkxkzccJFMczf?=
 =?us-ascii?Q?0TkqgpV0ehuwe6P7O+0V9oqkIdk2v++Q58pnDXXxCLiAPYZxrX6MW8/99zFb?=
 =?us-ascii?Q?w90kRPOt1g43S8PkNCZvgSW2P/PWKEoYnr1Y+wolMXHXby8cyEz+eae2XHWf?=
 =?us-ascii?Q?5ue+G1jSrm/D6YdpsqAOYV+MkUbXgLVIXIjZYDhU0rAx/hUmFrTB/UGUaXug?=
 =?us-ascii?Q?/28fb8pBF3K0yX56TXqFBi4Apk0pWGD5/Rx5tVKKtQRrKRfgGKKpIZLHevd4?=
 =?us-ascii?Q?CELkW/PGjYjmPpOUV9FkGt9t22ZY38U2ASvr1qFlKn3bnXBE1x5AIhgA6Twd?=
 =?us-ascii?Q?Mx7SugSKyd5G+BPsBDeFifePhCjtZ3c8pKoXl3Nn5jdyjKrzZgLeNYkJd09g?=
 =?us-ascii?Q?9jSb2RdvSG2MyTavkOfSvPW2/MTRmM/piEYQq/JSyvdT0btbOj75YTeBFMYX?=
 =?us-ascii?Q?3+30ijymLtz7Td+5CsXCds7PpffiyYJCiAA5J3/9gkMlFX8Mcdynvlpzs+h/?=
 =?us-ascii?Q?BF/Qv/bP9LqsajtSstKijhqczKBOlx+Cl5J8TFNe3BayRC07jEcsGspxZtKn?=
 =?us-ascii?Q?5Zc91O77O0HpBSwpspV30f3pq13ZZoJ0Qu7ny4aWZd35zmB7D4l/HY+JfdgU?=
 =?us-ascii?Q?MszNiOfrRfoS/+aaUZ/41HkjS8/1TppgPsaymbUHvkKBskbi8lo1lFcviHQ3?=
 =?us-ascii?Q?Heqoo7XsyAd4GjjAmvWSrvIReY5y+KhA7W7GmqnRvMBaUzn5QqJ93bC+Mx2j?=
 =?us-ascii?Q?+O6AtEHiYphNMqL2c4jc1mWWeNVJU7q+DPjLUn94U108Q6F6EBGTuN3kE2yG?=
 =?us-ascii?Q?qmFzAagoDU8GF5Vp5ommMrIYr3GmlLb1n2uwFhqOnxuQWR0YGF7ieb20TnZh?=
 =?us-ascii?Q?aufyAAUBBIto9CnF2BFvNdxe0yVbZV1UywK1TjHMWDLUdmLfZ3JNvcQOF+yb?=
 =?us-ascii?Q?DdXfyT70BJDC4FvJC7n4uJbErrn7rOpkm6hWr4kdQpGHkLekfMJip8uu+ePm?=
 =?us-ascii?Q?H39ql0DDJ07x94v3viDFnUrQp/rGs9gnIaHksQrSacUeszdouyTKcHDGdYLV?=
 =?us-ascii?Q?cKz6D81TGTrn3PRxH3hrTRJlVVRXBbfezrkvi4gesYd21kOOir9HGlVX3Y5I?=
 =?us-ascii?Q?npRGdI209DvqgxYlnZEQCXRhZTzIJBrMAEyBVG4euWIMB2lVNuzb/e8L5h2Q?=
 =?us-ascii?Q?uSg00kFXsd0NVe2l18gVl5BKrjIEI0w9qAXoV9K58rSsLcGaFRqY/65n7As5?=
 =?us-ascii?Q?vG6AH5bZl5THdbGRDQgNTQnDFv125z3AUOzIA8xxA5Pu8vRFJg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 23:41:22.2255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2a70cd-673e-48c7-61c4-08dd0505d8a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4370

On incompatible firmware versions, SEV-SNP support is pulled and the
setup is not performed. However, the platform and subsequently the KVM
capability may continue to advertize support for it. Disable support for
SEV-SNP if the FW version validation fails.

Fixes: 1dfe571c12cf ("KVM: SEV: Add initial SEV-SNP support")
Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
---
 arch/x86/kvm/svm/sev.c       | 4 +++-
 drivers/crypto/ccp/sev-dev.c | 6 ++++++
 include/linux/psp-sev.h      | 3 +++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 72674b8825c4..5ced00e54f0e 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3053,7 +3053,9 @@ void __init sev_hardware_setup(void)
 	sev_es_asid_count = min_sev_asid - 1;
 	WARN_ON_ONCE(misc_cg_set_capacity(MISC_CG_RES_SEV_ES, sev_es_asid_count));
 	sev_es_supported = true;
-	sev_snp_supported = sev_snp_enabled && cc_platform_has(CC_ATTR_HOST_SEV_SNP);
+	sev_snp_supported = (sev_snp_enabled &&
+			    cc_platform_has(CC_ATTR_HOST_SEV_SNP) &&
+			    snp_fw_valid());
 
 out:
 	if (boot_cpu_has(X86_FEATURE_SEV))
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index af018afd9cd7..b45cd60c19b0 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -122,6 +122,12 @@ static inline bool sev_version_greater_or_equal(u8 maj, u8 min)
 	return false;
 }
 
+bool snp_fw_valid(void)
+{
+	return sev_version_greater_or_equal(SNP_MIN_API_MAJOR, SNP_MIN_API_MINOR);
+}
+EXPORT_SYMBOL_GPL(snp_fw_valid);
+
 static void sev_irq_handler(int irq, void *data, unsigned int status)
 {
 	struct sev_device *sev = data;
diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
index 903ddfea8585..e841a8fbbb15 100644
--- a/include/linux/psp-sev.h
+++ b/include/linux/psp-sev.h
@@ -945,6 +945,7 @@ int sev_do_cmd(int cmd, void *data, int *psp_ret);
 void *psp_copy_user_blob(u64 uaddr, u32 len);
 void *snp_alloc_firmware_page(gfp_t mask);
 void snp_free_firmware_page(void *addr);
+bool snp_fw_valid(void);
 
 #else	/* !CONFIG_CRYPTO_DEV_SP_PSP */
 
@@ -979,6 +980,8 @@ static inline void *snp_alloc_firmware_page(gfp_t mask)
 
 static inline void snp_free_firmware_page(void *addr) { }
 
+static inline bool snp_fw_valid(void) { return false; }
+
 #endif	/* CONFIG_CRYPTO_DEV_SP_PSP */
 
 #endif	/* __PSP_SEV_H__ */
-- 
2.43.0


