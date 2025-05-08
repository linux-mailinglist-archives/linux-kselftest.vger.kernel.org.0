Return-Path: <linux-kselftest+bounces-32688-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18324AB0627
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 00:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78B074C4909
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 22:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4BE22A811;
	Thu,  8 May 2025 22:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fjh2isy4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC77218596;
	Thu,  8 May 2025 22:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746744794; cv=fail; b=VXWX7RWDg7ugVzYG9orNdcaAgZ6sg4/c5KG6K0IzXwUks9S5ymZJIp4Y6pc5GVbsNCdkqbB0cZbSNvYBdOA7KojReUWEp3G5zw/asaSOalLaTbVSMmsZquugdPdrUfe9pV3IrjJFhDSeQQEkssKw+sPatiERkXz8frWanCTCyHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746744794; c=relaxed/simple;
	bh=+s3eMcQNICvOx343UjNoBJXH8Sr5L7AwaPAAqHliBhs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MQSt6NesQv6yOdUL/zixVNHO4unxBtXHRNF7Jyvrwwq5v4uEEwJ5R6Yu8qfV8kOzSKbAR7oxjVKhDpHox+G07olPXE+jgGxk/QzEaE9WFPnkxs31dYcU5/myyoKA4UE5CGs0M9+25yIhpLTDBytcnZlKO712LIUZvCacFcQrh2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fjh2isy4; arc=fail smtp.client-ip=40.107.93.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rETq0WNr90jz9XkPY7JgdkPhK9wzShPYOqJA1uYBBhbXh+8Zf+KK8/fYsQojruap7ErWXymOajzWEfXTkoGgDdmEQ5/J4aH11sGFmmyPvKXgzptqa+/9T3dgRIDrsab+EahBZqWKwpdRs+LA3LU4NqNw7BF6/KWJxCRAxfOx1imdYuy5EEyrPBf7hDUMK4A7GcW362XQ/8Iolg9urhSUiByDmKBwWVVEDQ7tL21CdG2O6OG1cPbHnA9cFgiwIU9VhhfMcq0nVnt02VZwfVuDORFefwmJR0SyPpjAJBBCVkBOO+aDhT5pS+aI9QIEpLNzjzGGEw8NijEWgJ8A7mjC6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2UT5sNFiOJJtvAG3+FhcgmZ9BIMFwrA3eewkdOeTSc=;
 b=mJhhHZFOEvOf1TwAzLd/HOoHClqbj3QxEfPjYDidTX/W2zqdmZUAEc6N520rVkqPFqcpPfDUl7EEGSeGqoSp9ODFl6LuJZNidGQJITiffoTsFVA5H6f5So09mGzIbpD+9BuP7eLSb5/DKD0UCO6TlkY11Ss6jID+i1gUqOLM5MWZXbd9wYXoF9FeKCfTiXu4qCquiYPGo8DhhBEm/PwvZ+6cEoRxeMaNBShZHwtnxHIXApXHrmH0emzsYhbUTmeZEqfvSV6aJWEf3XeTyg4CcYxN4Nqlnec+PLNSYbZsPHSnJdRoNKLpi8is4IemdKcxIytYRu50z1UX7fCkPRrXtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2UT5sNFiOJJtvAG3+FhcgmZ9BIMFwrA3eewkdOeTSc=;
 b=fjh2isy4Tea55SljdFc+SNIyI+HbL7aByn2CV+Uz8S4FrP2UhKRVg2j7aJx//j6AbRexhecoh36LQA3ro63x8QYMUxyiOkvNvDtCqe85P6ms0NHhJhMRSTunnpyqR7tnu8SpWAbXzVyqJ5c3fEiswtcOIEePKKQgWsAc3zRRPj0=
Received: from DM6PR03CA0075.namprd03.prod.outlook.com (2603:10b6:5:333::8) by
 IA1PR12MB6411.namprd12.prod.outlook.com (2603:10b6:208:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Thu, 8 May
 2025 22:53:09 +0000
Received: from DS3PEPF000099D9.namprd04.prod.outlook.com
 (2603:10b6:5:333:cafe::69) by DM6PR03CA0075.outlook.office365.com
 (2603:10b6:5:333::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Thu,
 8 May 2025 22:53:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D9.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 22:53:09 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 May
 2025 17:53:07 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<thomas.lendacky@amd.com>, <shuah@kernel.org>, <prsampat@amd.com>
CC: <pgonda@google.com>, <nikunj@amd.com>, <pankaj.gupta@amd.com>,
	<michael.roth@amd.com>, <sraithal@amd.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-coco@lists.linux.dev>
Subject: [PATCH] KVM: SEV: Disable SEV-SNP support on initialization failure
Date: Thu, 8 May 2025 22:52:57 +0000
Message-ID: <20250508225257.9810-1-Ashish.Kalra@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D9:EE_|IA1PR12MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: 56df11fb-255a-46a9-e321-08dd8e831a73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VrPkUswDnIzOeqOfjbWw7pTLzvi2PHLvKIDeH1jyO9ruSpm9gr3XepmQhTav?=
 =?us-ascii?Q?Cw0nphGT1+hNpLaHoFcgu5qnyX4fTbYTN0ZkbGDgNK0aSVRCUacEtoswbu3o?=
 =?us-ascii?Q?CTCGHvB2is1Cg9el3J57JQdv0FZJ6/GNgFBCjCx5dUPYNsY4laB9GRcz71oy?=
 =?us-ascii?Q?TbvnijeuWK8Ob1TMqJzi0VKywgICFJQoGdNJVBCZ21DHkbbK5iOa+B78iDMD?=
 =?us-ascii?Q?BONJoyBn0+Jy0r1ta1+5DmBPU2sCIrIviyKMssUd7HjCJ3PY3zVj8BE5Hpfs?=
 =?us-ascii?Q?xKM3emWDObkWKfzA8CpVWLKwxGGvPLDRIao4HogeHCfP7t7d8+sUeMe6UKuE?=
 =?us-ascii?Q?hl5ok+zvoNqT3M91pb0IDlp4VH4lODd4UKbiOZq+4FC55+YmPfzWV/nMLHbY?=
 =?us-ascii?Q?HwGww/4SvHG4k0jsQmNeIlzBu6Qz+rRmm4OB9QWSWpSmDm4k2t8+3zrtTxGr?=
 =?us-ascii?Q?1HohjME7RcpQHtM+oUdQxtjtuLKR0m+p7P17o3hhLxhHEuTs4VFbc+4h/g+V?=
 =?us-ascii?Q?8Jp/LmwpDP0PQgLr3I24x1Z3+7A2pGXVLeUiM+zO1E8f70OH0Bx+qDmhGTNl?=
 =?us-ascii?Q?1E/A0Gu03s887tmMdRO3F2upBN+syeaAlvbIOoFXsLYW3zCsJqsES3Hz3/Aq?=
 =?us-ascii?Q?VtTeTAKv0+TMp/9xOQhG2+U3vgQDx0wheJS+fj3Q5iUHvzqRCp2TSsxaiVgR?=
 =?us-ascii?Q?VT7vShmgShI8EnQU4coaDlNU0mHCWjXPq8ac3fLdCWrAc79AAsplhFApkcTs?=
 =?us-ascii?Q?n3pEtdmsQ86Qr53CCpxOpG5x0Ow9iwuz91nHx0SGGJG8wzRs83+SuWumTfF2?=
 =?us-ascii?Q?FB2DeDP6Hs0z3Eo7fEyfkbBtlA+wb2z9SzQvTr3V1EGuUJrD6dwDVt89Xhet?=
 =?us-ascii?Q?CZGdcwjc1BFZE5eug+FA2Ko2Z8DR3gNvgzjsd3maa1aCQf0bkLjOsAzlZuRw?=
 =?us-ascii?Q?+o5jRLequ9sfSGCDTVleDlsv3Wp2slk1wnldDdxlC9p5nC56qcb9ZxDPjTzI?=
 =?us-ascii?Q?0KmCIHCjdgOz8nO0l6MQnHKem1gZ22O4cZNa6boseErxe7dhIB0fuwE3p14Y?=
 =?us-ascii?Q?uNfMWQPW3q7AcXMj1maNVM/VP+5NsQjBmgPTJDpzgscDh1RCIyMZTQ/1rPkM?=
 =?us-ascii?Q?mBVfRvuR4XHubVQNCyHpw6Yyx7APYGvRZzu6A5FjLT11OpjhL4WVVt2/0Oo3?=
 =?us-ascii?Q?xtT6zIKqxJBsZynkW5c3wtXge5utadCmHxBonzzz0GSNdKNyEzhIr1wfl9YK?=
 =?us-ascii?Q?yWkPUz6MqPHK43xOQhvT7kRmDWrNaq0Nt6jJo2Mp1k0c9TlGk+0u1AQnimGV?=
 =?us-ascii?Q?BxyKCd5F6kB2+BcJeBAaSowvQHmAv6fizO5vE44YQqfpb3kkFxyfq39dzxyc?=
 =?us-ascii?Q?Dw6vZkkR78tlq5sOzvHYoEIoCf/pFki5cN+tNR//perwqu5g3WAr7EYZ5vKG?=
 =?us-ascii?Q?ixG7IMEYPfpXwhUa0s8OpLaxlKCm/MNH+UKBYMrKHNfSUmNVUot8m7u+eMvw?=
 =?us-ascii?Q?bsH5ccAY2SKSoo3MntbiddTq0sEejcO12PaU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 22:53:09.1382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56df11fb-255a-46a9-e321-08dd8e831a73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6411

From: Ashish Kalra <ashish.kalra@amd.com>

During platform init, SNP initialization may fail for several reasons,
such as firmware command failures and incompatible versions. However,
the KVM capability may continue to advertise support for it.

The platform may have SNP enabled but if SNP_INIT fails then SNP is
not supported by KVM.

During KVM module initialization query the SNP platform status to obtain
the SNP initialization state and use it as an additional condition to
determine support for SEV-SNP.

Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Co-developed-by: Pratik R. Sampat <prsampat@amd.com>
Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/kvm/svm/sev.c | 43 +++++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index ada53f04158c..a6abdb26f877 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2934,6 +2934,32 @@ void __init sev_set_cpu_caps(void)
 	}
 }
 
+static bool sev_is_snp_initialized(void)
+{
+	struct sev_user_data_snp_status *status;
+	struct sev_data_snp_addr buf;
+	bool initialized = false;
+	void *data;
+	int error;
+
+	data = snp_alloc_firmware_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+	if (!data)
+		return initialized;
+
+	buf.address = __psp_pa(data);
+	if (sev_do_cmd(SEV_CMD_SNP_PLATFORM_STATUS, &buf, &error))
+		goto out;
+
+	status = (struct sev_user_data_snp_status *)data;
+	if (status->state)
+		initialized = true;
+
+out:
+	snp_free_firmware_page(data);
+
+	return initialized;
+}
+
 void __init sev_hardware_setup(void)
 {
 	unsigned int eax, ebx, ecx, edx, sev_asid_count, sev_es_asid_count;
@@ -3038,6 +3064,14 @@ void __init sev_hardware_setup(void)
 	sev_snp_supported = sev_snp_enabled && cc_platform_has(CC_ATTR_HOST_SEV_SNP);
 
 out:
+	if (sev_enabled) {
+		init_args.probe = true;
+		if (sev_platform_init(&init_args))
+			sev_supported = sev_es_supported = sev_snp_supported = false;
+		else
+			sev_snp_supported &= sev_is_snp_initialized();
+	}
+
 	if (boot_cpu_has(X86_FEATURE_SEV))
 		pr_info("SEV %s (ASIDs %u - %u)\n",
 			sev_supported ? min_sev_asid <= max_sev_asid ? "enabled" :
@@ -3064,15 +3098,6 @@ void __init sev_hardware_setup(void)
 	sev_supported_vmsa_features = 0;
 	if (sev_es_debug_swap_enabled)
 		sev_supported_vmsa_features |= SVM_SEV_FEAT_DEBUG_SWAP;
-
-	if (!sev_enabled)
-		return;
-
-	/*
-	 * Do both SNP and SEV initialization at KVM module load.
-	 */
-	init_args.probe = true;
-	sev_platform_init(&init_args);
 }
 
 void sev_hardware_unsetup(void)
-- 
2.34.1


