Return-Path: <linux-kselftest+bounces-32881-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB13AB472A
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 00:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CF4A7A53B9
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 22:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93BB276052;
	Mon, 12 May 2025 22:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ngihn0ve"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238F824BD1F;
	Mon, 12 May 2025 22:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747088209; cv=fail; b=md/WD3EkAHNRQy+tN/QePaH+8XU6W1u9cN0UZehjQEyZcxY084/AKOXwBFUiQKuVT4h0kPetpd/CxPBdQ/Yt5M+NLj3OVG+sjDt+q6Yo9HWOU+vWWXvfHO15KuyGSkPW499UVKmQPQQeAmGgAcLMqLyv/sTKCiUBGq+KQ4pR61U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747088209; c=relaxed/simple;
	bh=KARAmECtdI8zyPrxu53/O8qRJf3ijeRwvRWT2nGLECg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tzbzkokENIibEx+OTrNZimaBr/OPZllOut34DLNCdQunAy6211TnBYKm/b7jOOswoJ9i4saZBnKMGddTbPdXZz7yi3l6YcayBfOOTvGDg5wK25x70PRJdlE5dccWWrNSKIl5jP7/c5cvW1fHKnFFPpNjtWwkNyVsqaBx4Jlcm3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ngihn0ve; arc=fail smtp.client-ip=40.107.220.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yfb1UJCoh3OTlDQXi40wXouB6zHJzTx/YQ/CGTC4Zq79v8TG93ixFql/vBNN5NF5e56jtm6FINqLJfYJrMcU0hgpjCW//ldIMUfhuXkCoagtfgVMumrAy8jn8jJIlwiWMXDGbii5F63ZlkAWyP5EW4CqZZChUub1iA+5LFApdiaRYzG2eCD8fDbObfid2OjjVYUH29ToC7OxZOEYdnXL+eMPMNCbEJ56aYGSe6r+xSXwdJODODEebfOk77spoLjcZssUVqs4bA9ymGlO8ziQtTxFSf7Y1gp2mFc1R+vnShZ3mPRVetjh6qxyIB+sUiv/FAVnF/lX90vCZFTqWh0D2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QO9i8JbsdHQ5K1Mnmr7CWIu+rQA8pVjLeDYUPMrTeXM=;
 b=AxZGtvgdx+XfDwqk1COUt1sHkBbqtecYIfCWRGy+cGK7OH/ISQbjh77ZhFceN9xzwzLG8+GY1Xf+LSg25JPxU5Ohb3V9UUZqcBzffPgBOkqdg0PleUumKJHnoUxhxymP0TUZRAxr49RQ+M/qCPsy9gXc8rd7MRVsFgz79TC5kxFeVJi6wdzQOREP/Z2OPSCvd6L7WUDSHI2sZ/ZJAZK1f4e0l7ciI/KGs3uPqw/gQWP3cuRpcjCgPRh05WRkbMGLcB/xSEl6o1lznjlXTKia2FZm6LJSXEvVwZqt1sfIM7as52womOBB27LxdO3p7B0cPJWB/jJj5x4qnxaeXZBGJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QO9i8JbsdHQ5K1Mnmr7CWIu+rQA8pVjLeDYUPMrTeXM=;
 b=ngihn0veF2mSCYtsIFxd12qdhafQlfoEvsjgFRygWnyvLQkt6UEsRIxWt5z3X/wVrDryjpMGTMXNmn5EwXcRvp18Ty7Hg5QKf4YiIkEjq93COzQlYE3ojl3gMnFFxdRxaq1p6MYC94Orzkx4ylvK/NtqCUqVDIg/SuDnGPR4H7g=
Received: from MN2PR01CA0042.prod.exchangelabs.com (2603:10b6:208:23f::11) by
 DM4PR12MB8572.namprd12.prod.outlook.com (2603:10b6:8:17d::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.21; Mon, 12 May 2025 22:16:44 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::82) by MN2PR01CA0042.outlook.office365.com
 (2603:10b6:208:23f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Mon,
 12 May 2025 22:16:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 22:16:44 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 17:16:43 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<thomas.lendacky@amd.com>, <shuah@kernel.org>, <prsampat@amd.com>
CC: <pgonda@google.com>, <nikunj@amd.com>, <pankaj.gupta@amd.com>,
	<michael.roth@amd.com>, <sraithal@amd.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-coco@lists.linux.dev>
Subject: [PATCH v3] KVM: SEV: Disable SEV-SNP support on initialization failure
Date: Mon, 12 May 2025 22:16:34 +0000
Message-ID: <20250512221634.12045-1-Ashish.Kalra@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|DM4PR12MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: e7742d21-a264-4cf7-030e-08dd91a2ade8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fbMfd8qkOhQKRSU6XSwkIYTG5vdZzfiGnBlTI5OfID5r0CQxqMqcXy5PM1mF?=
 =?us-ascii?Q?wuW8C9FvUy6ES+udJnfpL8WB3pymf95NNKw16JJXhzR+K6ZPFnH/9Q0SdkPl?=
 =?us-ascii?Q?tvH69Hhqba6bybv1GYPNRwUQPi7hD8VQKOcAya/Y1qXbFJJmJn8RpCS8vio3?=
 =?us-ascii?Q?JUl6/1TmeCsJlP0TBZp3YNvPO6F4TNH4U39oZTintgnrJo1f8d+h+ruS4GTR?=
 =?us-ascii?Q?xL2e+eZI+V9CRU5FX27p0MUQW0EuNP6eQBUYr75pigUzsFxHOTek1wOPYJGt?=
 =?us-ascii?Q?7VFnGfgmf7A0q2SNALq6YBdq4HVwhX2EZ6cQd8HBDGWSOTFwj4LnCOhxDyes?=
 =?us-ascii?Q?JE2hwDZMwwtYnXxTfXUYOOxQ/KSGPs+5u90IKgyd7UpfqNaKeFdCZ7GjPKzv?=
 =?us-ascii?Q?y6Gri2XByot4xKVAtPKQHGOlihWhre4gvkMqMKXDgaNdjE/s6wzg0dZvbePv?=
 =?us-ascii?Q?y8szNkC4Jw7W9j8MJspjj1D7hY+srl0+zMrHCYoSLYoJVJbojgyuBgedmzHY?=
 =?us-ascii?Q?v4Y3Uvt6jHHz91SPJvgcxnp+m4EnzjGHRS/daolXY0mruF8uVRkGl5td8UeD?=
 =?us-ascii?Q?J5v8ZvbZJ/0+a4/+9i/jZjgd35guxWi19uzRaP0lW09akovHPSu+W7G1Xyvt?=
 =?us-ascii?Q?IPqSiRHnxCgFvuhjFMKF9EZ//FSJ7HxRjyaBSZTg+5sF7J4QCZB/IRCyufGi?=
 =?us-ascii?Q?y3FX6+yFWueKtr4n02zXaxVhJ996ELQJBeFr9ls80IEkRIvKxeyVyuYmffy1?=
 =?us-ascii?Q?TYQlcHYhaDn3XswvGs8pOwqQgZLWxWKTe6EvIMDqyC23lIjDg1qbn0pdxo2l?=
 =?us-ascii?Q?NyLEWEfs8qMGHYA1LPVmxBFTfEtpzwE8Y4aThFWzv5Ss8rivSWK5CC5Qe14+?=
 =?us-ascii?Q?rQJpDv1ddvvyN8kYYlQJtCX8UHi7W/y2hToJgOKf9eW08nKgtFoVfVD9ZQTS?=
 =?us-ascii?Q?ctzSgKz99vFD6p7mQB5bnOpBHViT13cbUjOhKf8ppJp+a0P5sDl8JwFbqpQi?=
 =?us-ascii?Q?9/nUG45pn3w1fl8ZeWZVr+gyzNfYlwkPfr+wYq1lyopvHKWrKtCume54dv8h?=
 =?us-ascii?Q?k2wfaFbQ+H45xFgZOGOKYSCqXOp/0fH+q3LFeUr8u5J91HbdBW3ts7vk64OP?=
 =?us-ascii?Q?uJGbaLs4iikUCe+7hSdSxMY++Dwj/FP4Le3oq8Y1wHFuFp3GGWCIFGqiUsp8?=
 =?us-ascii?Q?hGxCB0Ad1NcBwHdsMyC+c0SL/OADc9iZytKOu0w2aZ3XIMvAcC5ggUXMnQUJ?=
 =?us-ascii?Q?K71KJxeRJlzzNjsRngb7cV8dgXJu8Oipbzzan6Fabz6a1hFnbtfW04Vyjr8h?=
 =?us-ascii?Q?ChS5xxLQEU6uqgnG0yyJLsVUwAI3GA75vJtvTssoc7ed4bYysZuhtQz4Vfza?=
 =?us-ascii?Q?hiSPrzAP9f1CM9B24Zqw3Ys/tKfQMnqR+KUACNTbWOQXlUy0qAIdjBpLouXK?=
 =?us-ascii?Q?3mji0dh7nL5c6u4AcTtN8tgLkztzmmVg/3R9N2roT5cZQBifHmL4Jgw7CuL1?=
 =?us-ascii?Q?kTlWgAis5VDC1jvtH388C1zLRwYukIMyl4mz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 22:16:44.4410
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7742d21-a264-4cf7-030e-08dd91a2ade8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8572

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
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/kvm/svm/sev.c | 44 +++++++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index dea9480b9ff6..8c3b12e3de8c 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2935,6 +2935,33 @@ void __init sev_set_cpu_caps(void)
 	}
 }
 
+static bool is_sev_snp_initialized(void)
+{
+	struct sev_user_data_snp_status *status;
+	struct sev_data_snp_addr buf;
+	bool initialized = false;
+	int ret, error = 0;
+
+	status = snp_alloc_firmware_page(GFP_KERNEL | __GFP_ZERO);
+	if (!status)
+		return false;
+
+	buf.address = __psp_pa(status);
+	ret = sev_do_cmd(SEV_CMD_SNP_PLATFORM_STATUS, &buf, &error);
+	if (ret) {
+		pr_err("SEV: SNP_PLATFORM_STATUS failed ret=%d, fw_error=%d (%#x)\n",
+		       ret, error, error);
+		goto out;
+	}
+
+	initialized = !!status->state;
+
+out:
+	snp_free_firmware_page(status);
+
+	return initialized;
+}
+
 void __init sev_hardware_setup(void)
 {
 	unsigned int eax, ebx, ecx, edx, sev_asid_count, sev_es_asid_count;
@@ -3039,6 +3066,14 @@ void __init sev_hardware_setup(void)
 	sev_snp_supported = sev_snp_enabled && cc_platform_has(CC_ATTR_HOST_SEV_SNP);
 
 out:
+	if (sev_enabled) {
+		init_args.probe = true;
+		if (sev_platform_init(&init_args))
+			sev_supported = sev_es_supported = sev_snp_supported = false;
+		else if (sev_snp_supported)
+			sev_snp_supported = is_sev_snp_initialized();
+	}
+
 	if (boot_cpu_has(X86_FEATURE_SEV))
 		pr_info("SEV %s (ASIDs %u - %u)\n",
 			sev_supported ? min_sev_asid <= max_sev_asid ? "enabled" :
@@ -3065,15 +3100,6 @@ void __init sev_hardware_setup(void)
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


