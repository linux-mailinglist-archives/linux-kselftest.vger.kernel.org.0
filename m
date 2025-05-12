Return-Path: <linux-kselftest+bounces-32876-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 548A5AB45EC
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 23:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B80C41722A2
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 21:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED65298CDB;
	Mon, 12 May 2025 21:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0eDjVVRd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2081.outbound.protection.outlook.com [40.107.100.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F0E1DFDE;
	Mon, 12 May 2025 21:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747083867; cv=fail; b=JW4CyfKKt94bUr12f7ABmB0LGDZaOoXMPO4CW0ey9uscBZIuQzOLi5NRKMc0IaBSgj6aeYrrF/Tez/aDOF32hcHefQpvVv2A4gUwQ14F6S0vKdN1STTXo+CJHEB8j/TqYgb2OfagZRNwPy10b1YI2MNMcGFxWdlNXeXTx/Oe+bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747083867; c=relaxed/simple;
	bh=m/mZwQMpCV/3ZW/LWz4one5sThN9HR31d9Lf0VHE88U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=An0Xc2j4XxBq30IXKwteuc/sV0JGJdvHJPGM4FguzRSWc/QxXEv5MgZbJ/lsUir9b271u1A0P6p+xdUNesiB25lePvry7tdQVZ0Xyzngf+oUaEJuh9R6bGHlBWuYcDJchZlXRZDkmpQ0ss+2Ey+gsXBCPtGeuWlOQoRADx/0Ba0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0eDjVVRd; arc=fail smtp.client-ip=40.107.100.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/P7lrhVwuOAzgUkMR0wyd7b8pYY+9K1owLUM1R3IyI5vMojokiYv4wgqUkLOYNiS5S+o2r0/z0LshAqX2cVu/1kFm7WQmvkZDnrVJABcgiSIeSdb+ZFoXuPzjZ712zQaakqzXj1nay/Z9X6C1MBMWkFFoOv/ESI+EpuZYvhOE8UCJmG517gyk7xxOMpGnWxJ+TQ/jC7sVmphp0KR+i4gZjE0G4rWbQ3YNC4wC6VlbOOjz0fuuK/gceJgnP2vgUBvYHhqDSaMnfdlcK93SWG2+nT/8cK4BRMWaKW4LBmmAKr/BE0qnwWm0xli8OGz2NZUIx1EPxb6uxEZMvPywRgQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0OU4vLxVqj9P45caG+qxxhf3c3XXPlO9fQld0BL31fU=;
 b=WBi2Nftb/dQZYYZCvWfPlS39X5p5XBBBRde7JmTNFxWStmOFNzdCB7Y+Fc2MSrpZWMOuQIVsHny6neLYf/tuPal5mM3dBOi1PYKszUcXPvi4HMnVvcjViG+rFJvZbS+2Xri4YSbi/p4IeEPiO+ZeDq33k22lTIum21q/cBtjKJyDqaPzr74z8GSPx9IHIXiYIVrUZqaQ/Z6MzcM9F0mYbvzpaoyp+ZZQzUAChjTNsM8gZap8wvV06LEGlQeg1np8APlVwnnH5MuBvY7Zsi4LYT/IUy8Kula5cC+t8bVxacDhO/jzn+XcdAlTnf2DtuxzLGAAzJ4SgrOnLoq5tV17Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OU4vLxVqj9P45caG+qxxhf3c3XXPlO9fQld0BL31fU=;
 b=0eDjVVRdURbYvoCVj4YP9guCOvTMTHxvNfFzKjp71y3YruQWMZ9ho4YUmkqX7+6o3pGfrsaV2hyNiQpp0kQE4Hz/7DuX6n9RJjaq5PFnINDLQaLZOn2xouD4MyVnJLOTHmUZeG5bgwUAUjBu43277wpV1qvU08bWijd5pQOsbSY=
Received: from MN2PR08CA0016.namprd08.prod.outlook.com (2603:10b6:208:239::21)
 by SN7PR12MB7370.namprd12.prod.outlook.com (2603:10b6:806:299::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 21:04:22 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:208:239:cafe::4f) by MN2PR08CA0016.outlook.office365.com
 (2603:10b6:208:239::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.32 via Frontend Transport; Mon,
 12 May 2025 21:04:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 21:04:22 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 16:04:21 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<thomas.lendacky@amd.com>, <shuah@kernel.org>, <prsampat@amd.com>
CC: <pgonda@google.com>, <nikunj@amd.com>, <pankaj.gupta@amd.com>,
	<michael.roth@amd.com>, <sraithal@amd.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-coco@lists.linux.dev>
Subject: [PATCH v2] KVM: SEV: Disable SEV-SNP support on initialization failure
Date: Mon, 12 May 2025 21:04:10 +0000
Message-ID: <20250512210410.10172-1-Ashish.Kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|SN7PR12MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c87080b-e192-46b5-a040-08dd919891cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+1Ef131zhO41RdHVq2Qa3FqeGz7vnEsghOoPOxSpMX2ECHmrkheoMY0Ci4Sc?=
 =?us-ascii?Q?v0g1kQcMlfctjI+UoIgzz6DoN/fRAXv2WZB3yZAiCzwNvEEvllCvwAdFX3Um?=
 =?us-ascii?Q?tIti0UdZQ70x7Pdb8UaYQ+0s72+Ft8XNkJuxHT5nxCP8qrmVFlFh5QIrPlZN?=
 =?us-ascii?Q?csB6ZNDbGifdWt+HrEQfc+2Ez709X9xn30OuRW8AO4OHGTLfz98kChtD5+ex?=
 =?us-ascii?Q?9FUSHkAVLs8VKyy4eayxOJ3Llysf9sw+VgPpiUH/e4xrX13foc58WLnJbt68?=
 =?us-ascii?Q?TYayjzBHdc/sLS1QyPJ4B6UinZzc0xGGGFoHf4eKjrNg9JfMjXnuTSNZ7sP0?=
 =?us-ascii?Q?L2NmOW6esIw/RhyFiXMn2gKqJ5OUNoM6XJNwrYdjwlm1I9E+85cW8qpJ4PI2?=
 =?us-ascii?Q?z1S+LgrvOMt/F1PQT9PliTZSwE83aXmBBVNfxIE9xkpRdoaseALmu79qPNZ4?=
 =?us-ascii?Q?XP8FH5bJi91C/7XVAhUZ4ZJbzlGb5TUppG+Rsxhr4JqS/oJe4rxgGHswwpZW?=
 =?us-ascii?Q?sI3IQQlKaT/Tu+X2VDr3+sCcl3AUUXdGNefJZQ7GQjga9Eus7ECAj9HVNQGV?=
 =?us-ascii?Q?r80YAjdWEsyPoepYp6hvnyerG+cdISJcBUn8Coiuoz6+1bA7MS0H7SvjvWJN?=
 =?us-ascii?Q?LfMiz/fSexFm595kMSJntC4nfyOTMMeFOpjulUmpUqo1zr4thaTd7OUSFbVX?=
 =?us-ascii?Q?BBK0KhjRIPf//j5M1bUXQUcuA3hMkuKhPI6lYzDmoDg4lI2+r9d4MXtRsaAf?=
 =?us-ascii?Q?7v64iE+B3n86gejaiXMItJ5Jt1YyFhdJrOA98jmQcJDRvBsRHOUR3D/CZgu9?=
 =?us-ascii?Q?xb6rsSBL6Endbc1sccL95pajfwBXQiYSW2Jh0UnUxr4Tjwe47igYJVWteDmx?=
 =?us-ascii?Q?Ze0gd5hIT8YUyRqF+LlVpC8PdFCW+Pw/Z2HQVHbB9yxyBGmAyf9QdPMEHaX/?=
 =?us-ascii?Q?36fqhxMw5IH0+A+GUrnJ70m5iCy/pfCRd9P0HN2wwxmc8gxUYR2JLHQOCO7W?=
 =?us-ascii?Q?S7PHxqXpdcRvy8rgRCIALk2NOeunwpPvvuV+zr3lvYmvJNRjSyPRRbiSVPCe?=
 =?us-ascii?Q?/6K75nGUvjz1ecnLlbgZg0ZsUaYcKx5rQPCfrI17kCnv1wKvsQfzBDmpUqsH?=
 =?us-ascii?Q?AHImYmAYX1gAs7yQocYcP4UcjGfCCVZVBSODqw8/y2oao0GH7RVKyKVbSkYu?=
 =?us-ascii?Q?9HBeuYSd0+haIF8hN8ZCpM6o2Z7PoUg7wjLlFZgHkOp6OthuQoHVawP1Qe+c?=
 =?us-ascii?Q?bkDTbqwqyVJOTVCgdYsAcXlu6hB1/NOL4dbD7LuxbDzxxsAlSeWP59o610Xl?=
 =?us-ascii?Q?IttenAEVUCC27DUjxot1kqKG9bcQvfuwmd0YA4GCvi5F+tySOVA32gDNnULN?=
 =?us-ascii?Q?BeYBbyZy2yDlvK9VAHeJqKdoMGKlwNfx+U/EQmpTQj+++jZpQhSaNSIM6eLp?=
 =?us-ascii?Q?mbRCJ5b+Uek2JQof+DQuBn53kNX9o3aZCDrzSgfu/+4MVvccGKxYAM4GBiKd?=
 =?us-ascii?Q?e9hGvDTPwErJrQTsHfitFvMe27U+pFdP1W+C?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 21:04:22.3404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c87080b-e192-46b5-a040-08dd919891cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7370

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
 arch/x86/kvm/svm/sev.c | 44 +++++++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index dea9480b9ff6..f7d343ab9acd 100644
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
+	int error, ret;
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


