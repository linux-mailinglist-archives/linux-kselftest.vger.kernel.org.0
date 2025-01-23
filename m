Return-Path: <linux-kselftest+bounces-25045-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2B4A1AC48
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 23:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2296E3A5C1B
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 22:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0081C4A26;
	Thu, 23 Jan 2025 22:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1hva/mXF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB1F1CDFCC;
	Thu, 23 Jan 2025 22:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737669686; cv=fail; b=kXlxFp7cQ4jB5Iw6qwOwRco8whbL9vhey0dcBzNeIAn2Iw/4K0rJKqXyKShin9YPxcfbiY6IP6i5vM6I2meEs4fVT6va6VyiHiAAwk1SzzuV9ve3KZdNjuTTUGNVZLJE3oT7J4WUmyt2OHDJRrda9//S4GJqhiKOe4CgyF3nAbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737669686; c=relaxed/simple;
	bh=9zjrEOAZk1clPCYjD6TWPciC5jP098cMGX4VYB1uzW8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dID51uSiEd081DEMEATQhy2+hBP1TRknCPXI5I8XBKhwCRdn/99bdqp4H053Ki5TGAxzMrzAXSrYL84mBC1eLhd6Cyllx+PXNKYf6iCOVsiLRyyNx6rermLmGxgikxcC4+o5kByzENC4QKY9pjVH47SYcUub+OlGlQVp9iHT8QU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1hva/mXF; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bxo5kKNA1xp3JDZYyaMFYNH9qCEac0pPUNCmEZCakp9vHc/UqoQw1NzGBJatSgaHpWKj4IW9zPqxorLoHoTbYsigZIjzvrdbUxAi/Saqhsx0vgUlqQdnfvi8yTQ0DPvXQbEhGnqv4VfiHMwAyApHOjW0rM4WkRlbF9XVNLmiRUPsdHRKy9IfdpYpw+QYRmkOsQPg3fvGIkljROFSCLbqcZ+PsISyEfdbGF5drxa+c24T+TGgUpu9jk7Xg8pTEUfPI4v/QdlxMjvdSBs9MaM7u2y51KVjegngmrZ1N96KK10us71cWd82dQ9mCQR9GGG+B/7N2sJ8QvCpBinJkLBWLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDlxF0qn06tRCbMep8ljnAs6NptWphOsIXaqRPiHJp4=;
 b=jPJ3cgTTbTzQyoWxw6w23v/+L0McmakAlzcbR1BlOzXMmwjANnq1R8ggODSIdXaZfXVDSdVDw8RtdQ4bx3CQunCwOfXCfj8lCPBVUfWiuJIPPzDHox0k0f7dAdVeJNBCqJ5qBEOBKZ6CVvhjIbFYaEUv/f1kVWHiD/k7k729ZDvkZ9vNGb1N96f9uzWpkHcyRMq8ZYeZuA9pTvtsK1Ukb6nrF+B72ETMRWg52LPZy5l21IWZ+BlJITWI+bfItZB5tfXPSBi5DW3YqiC7+zhiLHQ/Op0sBKas9TeYYg02QauTwoAPhHK2TDG5pkMTT0inohuJOXlgqr0yFFUwrvbgJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDlxF0qn06tRCbMep8ljnAs6NptWphOsIXaqRPiHJp4=;
 b=1hva/mXFcwFL5xQfhOdo9SX154ictlMGZgKGCWBBtCinKcwiArLMMWcd7JmqjlydFexUXyPLSSmt8VoP3magcxcnAgTe5ZOsNRX7zxrVnvxfNeCSVfDQ3hch6qR39K07ofvVacxwPgV3VaULODUG6Sr96+rLXt7b86Z1tacpXZg=
Received: from SJ0PR05CA0130.namprd05.prod.outlook.com (2603:10b6:a03:33d::15)
 by SJ0PR12MB7473.namprd12.prod.outlook.com (2603:10b6:a03:48d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Thu, 23 Jan
 2025 22:01:19 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::8a) by SJ0PR05CA0130.outlook.office365.com
 (2603:10b6:a03:33d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.13 via Frontend Transport; Thu,
 23 Jan 2025 22:01:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Thu, 23 Jan 2025 22:01:19 +0000
Received: from sampat-dell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 23 Jan
 2025 16:01:17 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <nikunj@amd.com>, <michael.roth@amd.com>,
	<sraithal@amd.com>, <prsampat@amd.com>
Subject: [PATCH v5 1/9] KVM: SEV: Disable SEV-SNP on FW validation failure
Date: Thu, 23 Jan 2025 16:00:52 -0600
Message-ID: <20250123220100.339867-2-prsampat@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250123220100.339867-1-prsampat@amd.com>
References: <20250123220100.339867-1-prsampat@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|SJ0PR12MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a80ffc9-4af2-4555-4a59-08dd3bf9778f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hSFBS4Oe8jvri5s2vUQp0shx3XI8F9oCj7S5vxBmBquBdtG9nf1tbUbSyCwm?=
 =?us-ascii?Q?0Mf24HuvtAkJh66mU1n4X7ZrergHA6oA25d0IqJLbpeF7BAejTn7TZmykDSC?=
 =?us-ascii?Q?zfoF/QhuO2+7atpmqNJ4OrLCVsSn3UljcxKR4gEuf142lL5TyYjSEjnepLnq?=
 =?us-ascii?Q?Of353Ou7jWCJV1ljJlh/t4Lgw10Y0y6zxWUgVwgJ3KiOaYOLng57v6ohQMoy?=
 =?us-ascii?Q?okHKsZI0qejBTPxE11cOwr05CTHDziX129XJc4jqTBurjKy7wkybOCazAWsG?=
 =?us-ascii?Q?xOVW3CMzI5TFc3qbhSKnBvezvRGluNiZ+TseGVn4eZLqUGToFuuDzZVfzfsD?=
 =?us-ascii?Q?cVRHP6OMEufy6t2yNqTEWHAq1h3QmLpP/8OH2uHLvvjln0KxIlAjXzRZmMAz?=
 =?us-ascii?Q?+7TykL8wF51085q3D/8GptH4b14vCqY7hxwqH9LR82H7iKkP2CjCCBISLj8A?=
 =?us-ascii?Q?gdyeRoQZrPLCAsCx4RPdZWAzNdb/V1ZYL1EymFkDKfzxKXulPH5Ygt77hEUi?=
 =?us-ascii?Q?isKpUyRtNto01kbCkTFgwBV9Vmpsue3IxiXilFOr6CQJLAydOJiEKYlw1h+O?=
 =?us-ascii?Q?rDcmuXAQyW/BI8/AakbknLFiZEBnOpJ9Sfd7dG0K4mm5dV/nXurHK+DaYg02?=
 =?us-ascii?Q?OwPioMa/dzwutaC5O6Q29OE6qmfkyG4cqMSujkGY+U8JKJHkqlFn5IO9NVcy?=
 =?us-ascii?Q?ulM/jmjwIqDXM5fPgvErXfWvNXPViy2Pse9sScJfLRWaDJNrAA8O/s2vNWQG?=
 =?us-ascii?Q?46wGV85h9CERHSkg1OnkEwQzAjcnZLbd9sH5vrz7XUU6zhFfAlsd3OzlHI2G?=
 =?us-ascii?Q?v/iaUJ+ZSLMINduCr+7kwtd9dHKyOmvFAopJYJh/Sm64wvzcucz0hrefNTQ5?=
 =?us-ascii?Q?Sk42XX8l5PIo5yIeCvtRB4LqXOo61Us2pDYL6maFCIluGjhpyzC9S0m1vp3c?=
 =?us-ascii?Q?hbk0kW+KgdoR0AYu/QMhcSE2ByDo4Op4651FqkZFqWRJI/d60JrN9p5oRVFI?=
 =?us-ascii?Q?vhIDh5eVMI/abofPIWVFW+0Vnz7uVmcdQUhlg4W17X3uIS1JSkdMIbOOHrVW?=
 =?us-ascii?Q?d2gG+Gnuu6J1PMKxH5b+/NDSckhdgocnm3G2Odwsnc6AtcbfNelCaKqNuI5X?=
 =?us-ascii?Q?t61tAdNGCAZI0LubVAkQemZfZcQd1LgfDR2EfiDsPExzk15oKAiA7Hkg3Zcz?=
 =?us-ascii?Q?2YzG7efRoGhF6QkIfbGc6cjrNvkeJo50cvRgYSe3Ii53Kw+Wl11QkFvSyJPW?=
 =?us-ascii?Q?djflwkZMFnSwKvRUwsBLuEDOQtGd0sEanOHkjxQ5tKzqKRe1EvhSVVgLrWPt?=
 =?us-ascii?Q?Q095i5J43MXarV0HOxFvHU2kTUiUXxwh4Ruiux8/jXH8+mhHaNttUjNrqSzi?=
 =?us-ascii?Q?aXEtE213xaNwwkGtroGpelKzS8loV0RgxmbQrZMmxChIbp+uR0Y0RKgA+Z4G?=
 =?us-ascii?Q?IUd2JaZYoBUuB9NTQv57sBiAkfaBaGBg6i9+gYgD2QKiloAOEPEwNdfvt+iu?=
 =?us-ascii?Q?46d1JsWBuaeJELg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 22:01:19.3690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a80ffc9-4af2-4555-4a59-08dd3bf9778f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7473

On incompatible firmware versions, SEV-SNP support is pulled and the
setup is not performed. However, the platform and subsequently the KVM
capability may continue to advertise support for it. Disable support for
SEV-SNP if the FW version validation fails.

Fixes: 1dfe571c12cf ("KVM: SEV: Add initial SEV-SNP support")
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
 arch/x86/kvm/svm/sev.c       | 4 +++-
 drivers/crypto/ccp/sev-dev.c | 6 ++++++
 include/linux/psp-sev.h      | 3 +++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 0f04f365885c..b709c2f0945c 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3040,7 +3040,9 @@ void __init sev_hardware_setup(void)
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


