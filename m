Return-Path: <linux-kselftest+bounces-20367-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B259A98E6
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 07:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87C4128314D
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 05:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B070613B2A4;
	Tue, 22 Oct 2024 05:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mmcWh7wv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0523A13174B;
	Tue, 22 Oct 2024 05:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729576112; cv=fail; b=jWuF6odBKqHydMzmYipSGqA7Q6NPA/AmB/ba4AiFxKmXadXCMe79pZcTt12YYtf+YIGppI8khQ+vaZNjNGmxi2XDb0KL8r/7NE6FkPCddelT2GOAZv5P8AmX0fIAzawF1xLiBD0FvKZjwOSFLkf3334tRiUfMOgfP8MLeCCOnVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729576112; c=relaxed/simple;
	bh=ztIQf+TAHhanXzDGvDH54mQcE/F2PCrjFil1/MixUL0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ge1eHity+liBn3u3/n7yC8gulFM8YDtf5kw9xpvSHahrEeMPe4PsZqmrZ5+xVEAdyzN6fUrKFXoJyidk08iaTq0/4dfWhfYdjoWjEpL9nua31jk+UcrvZDrmfXJZBGmVI6kdBbCIqrejE9JA9J4bCDpGy1QQFsI3RHZj0+2nBpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mmcWh7wv; arc=fail smtp.client-ip=40.107.100.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XBbIzxYuyJra2My4ZOprt/oxv7FwGgXM/QudfQHoAlrUbXVm1slCKcjHX651nq3G3N37v2OoP9O5Mlo0R9I3BcW8grixcX1oXwgl4UcjtDuxjcf/PJMG5i1lm4w2CzjilACfvqXmWVu5m0b6NlbbCQtYvGqyA2MdTgOcgH2e7CgsH0jJL1O61mh79XdlnVmQnpvLVQuEgBJIjD3QNb97l88POZLFWjYgcaSowF/6TNjTLcctZg5WWEQEUqtlY9kX+p78imElS2rMJXYncoc6yVbDVdlHIDLXskN9gtcCxDWm+yJEskcvN9GGnDNVyX/1wZ4gCJ+TmcF8Vau/gMJF7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2z1p6M6PWjpN3aDYdo3GObOAnwFxmCQ7iykDKvDk68Y=;
 b=rjDkKXEwdYUPxfXDVBn2Os8bIb4t4YivGuvwu3aJzKdEzm+hQr02Qe+N9V3lgGCWOzgMsB+klfpQMCWy7SoEtTTkk5PXFYJuXPOmnIuvqTALolXUtxb+i/TxzMaZArXHtQHQrqPypK2fgD9rvBtdALGzpJ07GBrxtL38lF3L8sC+jJo6KWHi1D4bTuL6miy+5q7W4MUSBU0UHg3D8MIBotqqWoC/PJ/txp5lZCnjN1jW42tTEXJPnbcvMh/TOmZJMq/OFbA5fq8KrcwV/CwxZHkoWyEkxHhpSoOEqMdymwrvrYFyNZ6UTjO+1GGAdNvvdWgVghiFMFdlWWW7W8vG+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2z1p6M6PWjpN3aDYdo3GObOAnwFxmCQ7iykDKvDk68Y=;
 b=mmcWh7wvZ/dmxgj/HKblplgqhSw2B5u0XpmdS+7NVTzPIzd/0FO0UN9qLanm1zoMhu3eg2tIIAaE6SjWg/lEV7apaHqgbigJNEaTCKRV99mi6c8A0MgGksSDDgGlzUHXwmMAxZi0QXG6Vo2a3KsjtPUIwKiQN5TPRoVZ4mviCkU=
Received: from BYAPR04CA0021.namprd04.prod.outlook.com (2603:10b6:a03:40::34)
 by SJ2PR12MB7990.namprd12.prod.outlook.com (2603:10b6:a03:4c3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 05:48:27 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:40:cafe::a0) by BYAPR04CA0021.outlook.office365.com
 (2603:10b6:a03:40::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Tue, 22 Oct 2024 05:48:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 05:48:26 +0000
Received: from chalupa-d178host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 00:48:25 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>, <babu.moger@amd.com>
Subject: [PATCH v4 1/4] x86/cpufeatures: Add CPUID feature bit for Idle HLT intercept
Date: Tue, 22 Oct 2024 05:48:07 +0000
Message-ID: <20241022054810.23369-2-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241022054810.23369-1-manali.shukla@amd.com>
References: <20241022054810.23369-1-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|SJ2PR12MB7990:EE_
X-MS-Office365-Filtering-Correlation-Id: b04e3f91-c30b-4a52-fa0e-08dcf25d265d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkV4VDBYUWFROEt0c0JTcFhiVzV1RHFGQkN4SWJzTlBFY2M2YUlzN2JuejFL?=
 =?utf-8?B?NTZMN2p1K2Zua3hvZ1VmUzVuTUZqcEFKVzJvQzNBSWtEVDN1ZW8wcFhGc2Vi?=
 =?utf-8?B?RGRncTZLLzNvV1lFSG1FVHRsRlFSMlFCc3FSSmhscDZWUEUvQ2lSbVdyekUw?=
 =?utf-8?B?blhOU0N3UEI4UDdTY3Z0bHQzbTF5ZjRHWHlIbk5yZG5haC9OMnhnelVHcnFT?=
 =?utf-8?B?L1dOMlkzODFDVHZzV2N3bnlNYVdZWFYvUGU3Q1VlQkZNZzVuKzA2NEcyWSsv?=
 =?utf-8?B?Z2lublVNbXFoVlN3TkV4QWFMZXYvUmpwWk5CYlRqZmNTU3pwRUl5a1h0MC9w?=
 =?utf-8?B?Qnl3dmhCUElnekFWdTN0b055Ri9mSzRqSWZUWitXWWtHTkVCdjB6VktEVlc4?=
 =?utf-8?B?bERnUWxYai9ibStXbmszRjRUTVJRVVIyTng0RHR3WWhxbWxLMXFHRU9XYjVJ?=
 =?utf-8?B?L3FWVWdVNytQS29VS2tVUGxsNXY3eVIxN3NNQkZlVWdvcDd0UWFBSHhTTDRj?=
 =?utf-8?B?bmZKNDgyVHJZelFUanhoQlprWmJrVjZXWVp3NjUxdlRhQm5TZmczVXpYTTJ0?=
 =?utf-8?B?TlcrZ1RLdzBLTWlvTkJ4cXlEdDJuSStMa3E2RGU0QlZlVi9ZVlJxSytWTG5W?=
 =?utf-8?B?K2hCYitGd3NsU0lWcENsbEZpSVdxVHZOYjlWcmZNdWVZcVcvV0pnK3ZRSHFG?=
 =?utf-8?B?UWs5ZlhtYWJpUHNaenlyL1pweEQ3b3NSV0JuZUhyR0pKZXEzWHZvcmtMaUx3?=
 =?utf-8?B?dnUzN3B3WFRQMWNBcm1KbFVibWtKd2J3bUVjOEg4cE1Xck1UV2tmaUFaYWxt?=
 =?utf-8?B?NDA2Y1YxYmxhVzJ3R3FLR09mQ1hRS3VHUFQ0WU1FOXd3cFlENEI2ZGpYYVR2?=
 =?utf-8?B?OFNvWFBFVlAvT3FzT1F5dGdNdkp1S2tvR1B4TFVSZWQyN00xSXhKSm8vb1JZ?=
 =?utf-8?B?WkV1MmJuVVdxbFJwdHdxcC9qUmNDdlQ4ZHYrdTYxVi8vRFpaWURmcEx4cmNI?=
 =?utf-8?B?RUZOZWhUZE5CRXBaY1ZTakcwQUdLMm5na21uUUVUQWtTN3g2TjU3aGl0d0dx?=
 =?utf-8?B?YkdYYUs2RWNUVWgyMkVmUmFWMU05QUZvQTJwSHhxMDJqS0FmdDRVUDdEdHNs?=
 =?utf-8?B?cXU2N055U1dJZzlYbU12VFlZY2lkc005SUlPcHlUZC9XaFhzRmg0M2FoSkVX?=
 =?utf-8?B?OTRobkUwSnU0dFNxbnh2ZzB2VytPSVBzaDM5Y01Wdk9PM0tlRWhBU2hYTnRW?=
 =?utf-8?B?MVZPKy9zWVltQWFobFdodlBSR1g3T3pKQ1FHQ2pnM1FrVlhNUWlNbEN5dlpy?=
 =?utf-8?B?dHdiVzRrZ3E5bUtzbFh2Qmc4ZFhtQ3BnWHZOTTVQd2FkK2NZOE9BVjU3VXdt?=
 =?utf-8?B?Q05YWnZyRlBPUTNhYktKTFdvSTArZDFZWU5INU1kYklKWXAxUmFuRzhQYUxq?=
 =?utf-8?B?RkFzcm4zOHpCd3pBNDVXdGU3Y2VDTWlzRW41ZkllYjdlUlZ4MHJMWDJPRmZ6?=
 =?utf-8?B?am0xU3RCR0s0NWNvdnZKL1RCNnpmTldNZjMvNFlTaHRlMDZVc1liTy9iektX?=
 =?utf-8?B?SzFzM3AvMk9Ka1BTMUg4aEcvNm5pNnh4cTl1bytieEowalFGVU11RFdXSDVy?=
 =?utf-8?B?UDl5V0xoN2dkZjZyQUFrZlpqTlY1N08wNk44QmQ4Y2xvcldYOWJ2YnRWYjMx?=
 =?utf-8?B?Z1NJRTdTM281WkR4SE01QUxEWnNLR3dPekx5YldxbjlGTlRLdHpFVHpwMzZM?=
 =?utf-8?B?UUNYNktnZFlRSGh1ZUJQVWJ4YklrNEFIcm5vNXJVMWNPWTV2dnhma2NKS29m?=
 =?utf-8?B?L3l1cEVjcDFpWjFTdFQzLzB3MEh2UTAydlRLNE53N0crbFN3ZVc4Y0tzSUVE?=
 =?utf-8?B?NW1hN0pvQVFXeDFFLzdJVWJLOGJjc2FQZGFhS2ZtWHFIN0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 05:48:26.7622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b04e3f91-c30b-4a52-fa0e-08dcf25d265d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7990

From: Manali Shukla <Manali.Shukla@amd.com>

The Idle HLT Intercept feature allows for the HLT instruction
execution by a vCPU to be intercepted by the hypervisor only if there
are no pending events (V_INTR and V_NMI) for the vCPU. When the vCPU
is expected to service the pending events (V_INTR and V_NMI), the Idle
HLT intercept won’t trigger. The feature allows the hypervisor to
determine if the vCPU is idle and reduces wasteful VMEXITs.

In addition to the aforementioned use case, the Idle HLT intercept
feature is also used for enlightened guests who aim to securely manage
events without the hypervisor’s awareness. If a HLT occurs while
a virtual event is pending and the hypervisor is unaware of this
pending event (as could be the case with enlightened guests), the
absence of the Idle HLT intercept feature could result in a vCPU being
suspended indefinitely.

Presence of Idle HLT intercept feature for guests is indicated via CPUID
function 0x8000000A_EDX[30].

Signed-off-by: Manali Shukla <Manali.Shukla@amd.com>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index dd4682857c12..7461a49e1045 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -382,6 +382,7 @@
 #define X86_FEATURE_V_SPEC_CTRL		(15*32+20) /* "v_spec_ctrl" Virtual SPEC_CTRL */
 #define X86_FEATURE_VNMI		(15*32+25) /* "vnmi" Virtual NMI */
 #define X86_FEATURE_SVME_ADDR_CHK	(15*32+28) /* SVME addr check */
+#define X86_FEATURE_IDLE_HLT		(15*32+30) /* "" IDLE HLT intercept */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (ECX), word 16 */
 #define X86_FEATURE_AVX512VBMI		(16*32+ 1) /* "avx512vbmi" AVX512 Vector Bit Manipulation instructions*/

base-commit: c8d430db8eec7d4fd13a6bea27b7086a54eda6da
prerequisite-patch-id: ca912571db5c004f77b70843b8dd35517ff1267f
prerequisite-patch-id: 164ea3b4346f9e04bc69819278d20f5e1b5df5ed
prerequisite-patch-id: 90d870f426ebc2cec43c0dd89b701ee998385455
prerequisite-patch-id: 45812b799c517a4521782a1fdbcda881237e1eda
-- 
2.34.1


