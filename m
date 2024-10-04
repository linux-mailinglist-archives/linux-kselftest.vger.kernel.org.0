Return-Path: <linux-kselftest+bounces-19003-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD2198FD09
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 07:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E41552840E5
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 05:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB7171739;
	Fri,  4 Oct 2024 05:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eR8ZYsXr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2081.outbound.protection.outlook.com [40.107.96.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DD14E1CA;
	Fri,  4 Oct 2024 05:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728020045; cv=fail; b=DaqV+gf9UoprxXgArub+US2xtWcLUh4/EUcLb4c/sKxrL4h7Cnh75NAiuXL3Syc9vSPT1uvRvJHmQCgi0e8tB4muuEl5Hv9ftoARocMLQQvixR70TSzbu8uWKMmS7tQJ/gWV1FxAL8mIeoOYGH0BcNuR0W9zwqMqKejA91nHsxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728020045; c=relaxed/simple;
	bh=U/0lebVjAjz79Hw7TjaWHRrqUQorfxR5LNHqMorAQf0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=agnMbZ87pydDuWjt/GGxarslT2RM1u6kE4mqrEJ+R5nYYW1jj8GV3jVpq8uYjTW6bDlwGNi1CryRyRRrNbP7MCzRbDrZwETTM0TzgNIcQD+1VZwDvqnBvyS+Msd2l+icTAMqG2uk6CQRbPBJ7mfdkBVjdqUxuMOlWFvEsbY8Bq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eR8ZYsXr; arc=fail smtp.client-ip=40.107.96.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vGOmbdtw8uFEw85V4UVoJ9ZxptlgCmC47BgC347knKSyHDPqYCC5ZEI5Q3Me5bI9wm7W53JoBRPq6bm01bSiyWZmkgKv+gM1TYA4monzNmzqenyc3WIHVz4bcGzx8Cn7L25xQYd0ar7wGW2WXg/QQXNq4wAdIOX+rQiwV+az0LsZtxiE6MyKBIpS42A+tOevR1lRMx5DfJwt+0TVXbHviCMNc4OICshoU8u3QlXmGggt1lVldJWNQAB6lgMXSqC2wd5lbT+2ZH0cDstQoVHb0NWxN4mCU5AnHpZW+/bRnsaMSJRksL8rK9ZgBhyGxEGq0n8toOYMwy8Z2W8QQBOF1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2M9YC83vxgd6T7gTLadVOM+41jTMkhcVG0xXzj1Il14=;
 b=JaqmvQBv+2cwDKlc7fxyBJN3htZbEtGqpw1JJ903xTc//dphwb87dBDnmVsohAw7bq6Y/nR8GSzTUdyZ03lNkTIN51Q+hgHy/JhnEvYeg9TMUYRz0hGhWoKhJFGPPpW2sIQVL66SaTapNN7Ya33MeniIX2Q2hBOffVgz7g7RBPdshRvn5dXow4CUl+F3843jhZuhJP+vZZ/LYuUB/SksgVtcCjGBa+E6uXuwazoMLxhVnV8bgSI4T+HW6QNim4fWEFwB6myuyhmTnE4DC3xW3uirAnByycoWhvts53tap/b+H6hIDZk4XvyxPyOp+elZ0GFpCzb4k6GdXzMIw2yKLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2M9YC83vxgd6T7gTLadVOM+41jTMkhcVG0xXzj1Il14=;
 b=eR8ZYsXrFpTD0bd6GqxZP0n+fJxKqducQOwkAaXTS85NaGfL013VOGs49uFLzxOnCV3NzSKFq5TLq4vEWctcSM4EK1M8FcWXtS1CS7mxjvfxu8tvezuqqkx9vZ5+hWptiocO27ne9lvYySgIrhmiOdlKBu8pxmnLWGdBsTuFqh0=
Received: from BN8PR04CA0010.namprd04.prod.outlook.com (2603:10b6:408:70::23)
 by DS0PR12MB8453.namprd12.prod.outlook.com (2603:10b6:8:157::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 05:34:01 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:408:70:cafe::fb) by BN8PR04CA0010.outlook.office365.com
 (2603:10b6:408:70::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18 via Frontend
 Transport; Fri, 4 Oct 2024 05:34:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Fri, 4 Oct 2024 05:34:00 +0000
Received: from chalupa-d178host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 4 Oct
 2024 00:33:59 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>, <babu.moger@amd.com>
Subject: [PATCH v3 1/4] x86/cpufeatures: Add CPUID feature bit for the Bus Lock Threshold
Date: Fri, 4 Oct 2024 05:33:38 +0000
Message-ID: <20241004053341.5726-2-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241004053341.5726-1-manali.shukla@amd.com>
References: <20241004053341.5726-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|DS0PR12MB8453:EE_
X-MS-Office365-Filtering-Correlation-Id: 64ea5b6f-5905-4a8a-2192-08dce43626bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s7bGW7aSqHzOZv+K0myHocWQtdWgHKKciEyaFBpSugfbxjse2dnroKLeZm1c?=
 =?us-ascii?Q?VYMcEe/hV6vwWOlJAZ2wecG3iZ0AfXYbY4rD1NXFwZuXoeuOhd/gqlkSXYkk?=
 =?us-ascii?Q?AgKBltmUPgq64GU7aBDAeinTtrOenD2RCShjN2XpRYoB/rzzW9RHWIPXy2Rm?=
 =?us-ascii?Q?e/KvepwNuZLBlkcjeplaKyDB7cr/hEHUQhLCCt4Ow+RPMd7KxawzoMOZGVPp?=
 =?us-ascii?Q?vMsxsXHGg70OzriSYLNd7cdaxSaTu+JTx/yTXqe50fNMJtUw5eTjEMnOc8T7?=
 =?us-ascii?Q?PHCKjN74016ksT9ih2dchsand0wKCeATw6VAv6f1gxuHML/KweiMQLMMpEjS?=
 =?us-ascii?Q?9tIVEJafKKRhsHXIOHl5+5fUTDu0Lsy1PEKs3KXDdum+FUCGBRyLEmCS6RMW?=
 =?us-ascii?Q?X4SSTijDeNE7Fm0NMrkyC20f9Ry4xkw39dlglZcFnFDT7OU8ZsYx1uCqMdfP?=
 =?us-ascii?Q?EySFHMoy62xFllmHlrVdvgw2WTgOZgoQDeXMmNyfs4uT2x8eIAqNBqI45v+a?=
 =?us-ascii?Q?79aqBkUsCg1ydPZU3gi7+MiOb8/mIgTLyoadfxk8l/JlnwG82ZC1XzDWzPti?=
 =?us-ascii?Q?pBz93hyYT1BpbOvJT/Y63rLREAtNHASTRfOh9/AMz36DRVBOfjiJE/PRE/RW?=
 =?us-ascii?Q?XkXsKrqi4KIkDVBxqdGVK28ec5t23e9sP0VJhRzYn9Az5Wh0lWsOEd1U8GgN?=
 =?us-ascii?Q?VlVoE8slz9/Vg3cs4mc28Rmd+xxqdTabBAhWN4lTrHoKnHXidpfyK9l0QF/N?=
 =?us-ascii?Q?/RXnK8NzbWwdSgdLTuiXjrVCk9vBMWXJz79SWYeYJUriulSpjPnIm4fhWKHD?=
 =?us-ascii?Q?Ib3UJU2bRyWP2M0esEsaFkWBX4Tr8D30T4dZIElVOHcQv7R9s0mOn2/IJ3A/?=
 =?us-ascii?Q?ivXHV6xflVeDmnEyID6MicJT9hz2KbIprcIqBQcuSf1h2NCJ9IAUS7pP6JmM?=
 =?us-ascii?Q?3+XhuBcyL5QFVaNXbW+aPhaX5LUVCyz3rShYMnCVTfXkJjMRKnKd2D9UDaot?=
 =?us-ascii?Q?GA4lxWddjn2CJAqBiNmdaBLvHRNF7JmY5xj+Oq2M1p07XAIiRlDvFghBbCgv?=
 =?us-ascii?Q?PlvGQ8/O238lVe8uxeRyPFsUpseakYZxyCIfBCx2kTs2vu+4FX4/Al7jHmj6?=
 =?us-ascii?Q?ZXy/ufjysKVcROoOZktFl6o+DN0IE00lGWjkyqcXbgjkgwIr3GxfN4ahyDUp?=
 =?us-ascii?Q?RxGqAlRjYDGOLhMCK3S/DYRa0dry+wIYwCxX1LPjp3/8gmWxTrhliV9idYgh?=
 =?us-ascii?Q?QVUth7VJae//HONdm8JBgMQX6zuGLIqU4rJpRXv+Hf3hpK59sY78QIwVrpKE?=
 =?us-ascii?Q?E/N+bZ/VfJhMK2Xz2bXD8sd474dia8kysV4usrKcRK2JrjcPQkfq5TpqWqY8?=
 =?us-ascii?Q?WOcZH668Mm6yhSOFqwQ4OaHi5/U1?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 05:34:00.8438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ea5b6f-5905-4a8a-2192-08dce43626bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8453

Misbehaving guests can cause bus locks to degrade the performance of
the system. The Bus Lock Threshold feature can be used to address this
issue by providing capability to the hypervisor to limit guest's
ability to generate bus lock, thereby preventing system slowdown due
to performance penalities.

When the Bus Lock Threshold feature is enabled, the processor checks
the bus lock threshold count before executing the buslock and decides
whether to trigger bus lock exit or not.

The value of the bus lock threshold count '0' generates bus lock
exits, and if the value is greater than '0', the bus lock is executed
successfully and the bus lock threshold count is decremented.

Presence of the Bus Lock threshold feature is indicated via CPUID
function 0x8000000A_EDX[29].

Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index dd4682857c12..77fa8e743ccc 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -382,6 +382,7 @@
 #define X86_FEATURE_V_SPEC_CTRL		(15*32+20) /* "v_spec_ctrl" Virtual SPEC_CTRL */
 #define X86_FEATURE_VNMI		(15*32+25) /* "vnmi" Virtual NMI */
 #define X86_FEATURE_SVME_ADDR_CHK	(15*32+28) /* SVME addr check */
+#define X86_FEATURE_BUS_LOCK_THRESHOLD	(15*32+29) /* "buslock" Bus lock threshold */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (ECX), word 16 */
 #define X86_FEATURE_AVX512VBMI		(16*32+ 1) /* "avx512vbmi" AVX512 Vector Bit Manipulation instructions*/

base-commit: efbc6bd090f48ccf64f7a8dd5daea775821d57ec
-- 
2.34.1


