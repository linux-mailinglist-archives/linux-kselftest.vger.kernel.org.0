Return-Path: <linux-kselftest+bounces-25046-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1092FA1AC4A
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 23:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FD0116CA09
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 22:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B3F1CD1E1;
	Thu, 23 Jan 2025 22:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W/9iBi+M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88C21C5F34;
	Thu, 23 Jan 2025 22:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737669697; cv=fail; b=BvCzfi5GPrHGtA+YHlL7rUnzQsAHMO++o5f6GKnC7jwOEZN5s/miAKEWjBhDgxii15ngxyJspzMFk7+MiuBpf+RVodxgJTPJ3WH1qSg6TKEbcdAOqBEnfoc6PkJ9GlOM1f61JcCx783GRT8AoVAxpZnyGn4gbMJdbMfjZ9QJoXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737669697; c=relaxed/simple;
	bh=cUypLWhR+AqVFpfac8jIFXQ1A19F6VYFkYeDOaeYROA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DooNjmIwkxDR73GeT1kmYxYMlRUsVKAhVhrPAEceS9KPiIDHERdqBwMYH9kIIOJf9oZvidRhK3lauN6WZxqeBbKCyneegLOl3TVlXBWDBNUkihlnE/Ms6Y+7VR2s0wZwi5MXRnz7Op81D3MHo2x3dkhIk3pmUwDmZxiddHCxR0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W/9iBi+M; arc=fail smtp.client-ip=40.107.243.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mx2iSJ/3/PBpDiMwkBT/IsXeINEKooEgsDnOq5m4YtxUqFhctBWFrmMjNU4no/OAV/kWZTyZn7JpzSQSe0AdoV4i/k0HzllD43iTvo8/51AKjoZWYbmoHk4eZWw88nHZZMXl2PYv/427CNgouorZLyneDTjHZzLkVT0nC1YChvK4Ay0bybj6QOIVB9FKxlnVBUPA2N08b35rFkZ4Z5E33a3j8uiOFS17Bgp2YVDtYSXhHHf2zHTUcyNO0dv3iC+6oXmZI3BVGF+HFB/cRq7giDufq84y6IwchYbqZl7suqV/wCqPXso/svq0Zsh31zzx+Bbd82lglqBJoUMaXG9ZmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0s/+wPwAZiBTdlVt8wR7NSvWeYEG2LljblYoDWE/9k=;
 b=rVHTBkmr4qnYwxnOQsTKT0LPpMZo51L1phqN0P5iFgNkT+sTMKOcMBFO/BQ+WzcFr/h/NSZf2peFT6+gEmjxZQB+hejK3lHAJatZesmCKq/Lh1wouzM9rU37+xqRNJPsBxEMryTJUU7XXBOsGQeHRf4YM3luBytSZ9t8r5rdU6tKEIybWrKiEMx4y8ekH0ZSsKcCo/DjaCwnGMDWmk48zhYam9oX7hodEKCg6WEqOI8tmwlwNWBbKYvIm2SpMXLFXbHPunbMwUAs5AFe40WAiIovNgbXPVh/yH9wM0KFFxq25c6ZbnzAvXVPu8FrZJr0K40g3b6DmaDqwHiXRueHiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0s/+wPwAZiBTdlVt8wR7NSvWeYEG2LljblYoDWE/9k=;
 b=W/9iBi+M1rmc0ssy04F/q80xRftrSCOCtm1wsQpTQHxZ9a3r2K8dAhTOCJV3eD9+1XTERd7/3R1YrpLs3lWdnXGfTRD47DxsXoXxjFaDsJ/JXkh/uTKBQWUE6ezPRkD5N+9d0luluyCLfbdc3YUsbbJejgZzAMc9EAttf4He/Iw=
Received: from SJ0PR05CA0148.namprd05.prod.outlook.com (2603:10b6:a03:33d::33)
 by CH0PR12MB8577.namprd12.prod.outlook.com (2603:10b6:610:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Thu, 23 Jan
 2025 22:01:32 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:a03:33d::4) by SJ0PR05CA0148.outlook.office365.com
 (2603:10b6:a03:33d::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.12 via Frontend Transport; Thu,
 23 Jan 2025 22:01:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Thu, 23 Jan 2025 22:01:30 +0000
Received: from sampat-dell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 23 Jan
 2025 16:01:29 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <nikunj@amd.com>, <michael.roth@amd.com>,
	<sraithal@amd.com>, <prsampat@amd.com>
Subject: [PATCH v5 2/9] KVM: SEV: Disable SEV on platform init failure
Date: Thu, 23 Jan 2025 16:00:53 -0600
Message-ID: <20250123220100.339867-3-prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|CH0PR12MB8577:EE_
X-MS-Office365-Filtering-Correlation-Id: f3acf061-3f0c-473b-d4a8-08dd3bf97e6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VWI50gWcY9AE2NhAMnxFFhAu1Sy3oV5dxktyGwIbbE0XzmeBENYivgOPxFoe?=
 =?us-ascii?Q?1M4InM55GSbW0wAIAxgn9Ur06bsPsY/goG9UvCG39L3f0yPE66M06JVd0G7c?=
 =?us-ascii?Q?U2XqId0ZxspgS+Le+LevvjNcIKU7Qj1gjHMFIJWuD6fPM9hiPEF1OrYIguGM?=
 =?us-ascii?Q?C219VqAQ7K/ZrWY/CPnrSPfdUENI1dmKkjoyy1rmu8OVtld2ubd0Gxj9qQa5?=
 =?us-ascii?Q?OdKbOsJtjZCer2bxDfGE91tjx9x6Zq75ntrrPrvx7cLzKnF5wEiTR9PW/V7m?=
 =?us-ascii?Q?MafOtAjIL/YJWNJfnih8gv15N8Z0T1LPKtUKeDBz/d3VX+mtQFrAasaKgiUc?=
 =?us-ascii?Q?9a7MqwlYhKWJy3FB+i2DFztucEv+dTGuDnNZKDZB8Kar5wIdHcnCeNLrTkEs?=
 =?us-ascii?Q?5bSz4KV2HvqNUm1vcFISzcIe2yPAqpSEYcCnCKu8ds5X/KrJSgvBOW5s7NVn?=
 =?us-ascii?Q?vOJ67lShNCXXeNdCHJqNbU0HBPYg5jEG1UFCXonjjM6wEnjn1Q/LDJIrE77U?=
 =?us-ascii?Q?svFv+rGWPml3Fv+0G0qm7L/eb0jxypk+YnV9MVDTsdd8HB4puRSKPL7We9SQ?=
 =?us-ascii?Q?x4J7sz7dmGcxQ3SuODeNBQQLmWIrp19h3IMiUwcPVF8iHmx5KbE+9pfjEa5h?=
 =?us-ascii?Q?F9ZynML1upcX61VXXmZAZaNdxXLCUE4obl/WwxfDj02d4X3BKd6E8AMRdIjX?=
 =?us-ascii?Q?WeAP7X9vj9GSl2+Z4E2E4FRlQFOtPGA6AXWMHdFicOxyBDUbsxdvDWNg/8IY?=
 =?us-ascii?Q?onMBQQ7EpyNKEtn4A5aZ36X4DvR45RzIrP4Phu1PWCwkO3b1Oa5fSzJSm1K/?=
 =?us-ascii?Q?eKmtFdWejm9JLpq2eyO2yt70ZnAduhNTLLZ0oARdukYvv30aAm9btqAggI25?=
 =?us-ascii?Q?XG0Pc7g+uFh3eTud4fGGh+Av0xa1Xhdo+WWaoIXQMgvWevVFJbrKv3cDe71u?=
 =?us-ascii?Q?8+/R3Uq8N/g29dG+JoUoLgw8MMQwD1zXRT4YG49pXgA5IQ6GWqLP5Lyn9lRW?=
 =?us-ascii?Q?v6/Id9XJpbilt017CmXDRvsmDM4+AqmSgoWdXxQ6xrp5mzCOgewpjzaL6aUj?=
 =?us-ascii?Q?aaEhaZ1vdKqNL4LyhuaBnwTR5JjpIBnN21ERCQ0Is9c/dfIPaNma9mQ2GHjy?=
 =?us-ascii?Q?/IiRkNj1TKZdaIjAvBplBpZMrZxYrjVcyWIoVUv+2WvrAw6+IC5q33kXngR4?=
 =?us-ascii?Q?M5R1+0k3/lON3Y/Tj7mmHqNhWEIAZPkFjk8m3EDOBSuusW9/H0ZADnOxk3ua?=
 =?us-ascii?Q?R3prnV9f53NkLuI2AcXWJAdyNYNgWR76S7trtkUwF/qVjhPr4zR8HjOr97os?=
 =?us-ascii?Q?tMHMmwoqYGLFp9DJTcKu07Klnwg4zIQlq7iXqsZHtIB3WUfoIV7ELTaort7M?=
 =?us-ascii?Q?vQ0EbGouW0QojknQtO5k3d0O0FhT0ZQseRncki+ZOq/BGmUH0IJhQwVamyvG?=
 =?us-ascii?Q?A8zrW4rfBXLpfDzi935GVrN8uIJWi60rw3JFqgjS3BZ9rl2gnVT307BlJJ5W?=
 =?us-ascii?Q?5vLM4HWlhVGuE9U=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 22:01:30.9004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3acf061-3f0c-473b-d4a8-08dd3bf97e6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8577

If the platform initialization sev_platform_init() fails, SEV cannot be
set up and a secure VM cannot be spawned. Therefore, in this case,
ensure that KVM does not set up, nor advertise support for SEV, SEV-ES,
and SEV-SNP.

Suggested-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
v4..v5
* Export the failure of platform_init() to disable SEV+ support
---
---
 arch/x86/kvm/svm/sev.c       |  2 +-
 drivers/crypto/ccp/sev-dev.c | 10 ++++++++++
 include/linux/psp-sev.h      |  3 +++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index b709c2f0945c..188f04247dcf 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2957,7 +2957,7 @@ void __init sev_hardware_setup(void)
 	bool sev_es_supported = false;
 	bool sev_supported = false;
 
-	if (!sev_enabled || !npt_enabled || !nrips)
+	if (!is_sev_platform_init() || !sev_enabled || !npt_enabled || !nrips)
 		goto out;
 
 	/*
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index b45cd60c19b0..374ca2dd5730 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -81,6 +81,8 @@ MODULE_FIRMWARE("amd/amd_sev_fam19h_model1xh.sbin"); /* 4th gen EPYC */
 static bool psp_dead;
 static int psp_timeout;
 
+static bool platform_init;
+
 /* Trusted Memory Region (TMR):
  *   The TMR is a 1MB area that must be 1MB aligned.  Use the page allocator
  *   to allocate the memory, which will return aligned memory for the specified
@@ -1358,6 +1360,12 @@ int sev_platform_init(struct sev_platform_init_args *args)
 }
 EXPORT_SYMBOL_GPL(sev_platform_init);
 
+bool is_sev_platform_init(void)
+{
+	return platform_init;
+}
+EXPORT_SYMBOL_GPL(is_sev_platform_init);
+
 static int __sev_platform_shutdown_locked(int *error)
 {
 	struct psp_device *psp = psp_master;
@@ -2427,6 +2435,8 @@ void sev_pci_init(void)
 	if (rc)
 		dev_err(sev->dev, "SEV: failed to INIT error %#x, rc %d\n",
 			args.error, rc);
+	else
+		platform_init = true;
 
 	dev_info(sev->dev, "SEV%s API:%d.%d build:%d\n", sev->snp_initialized ?
 		"-SNP" : "", sev->api_major, sev->api_minor, sev->build);
diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
index e841a8fbbb15..3a40b79fb37f 100644
--- a/include/linux/psp-sev.h
+++ b/include/linux/psp-sev.h
@@ -946,6 +946,7 @@ void *psp_copy_user_blob(u64 uaddr, u32 len);
 void *snp_alloc_firmware_page(gfp_t mask);
 void snp_free_firmware_page(void *addr);
 bool snp_fw_valid(void);
+bool is_sev_platform_init(void);
 
 #else	/* !CONFIG_CRYPTO_DEV_SP_PSP */
 
@@ -982,6 +983,8 @@ static inline void snp_free_firmware_page(void *addr) { }
 
 static inline bool snp_fw_valid(void) { return false; }
 
+static inline bool is_sev_platform_init(void) { return false; }
+
 #endif	/* CONFIG_CRYPTO_DEV_SP_PSP */
 
 #endif	/* __PSP_SEV_H__ */
-- 
2.43.0


