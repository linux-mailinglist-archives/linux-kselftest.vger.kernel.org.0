Return-Path: <linux-kselftest+bounces-23847-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B298A005A1
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 09:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 385D91633CE
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 08:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160F01C1F10;
	Fri,  3 Jan 2025 08:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pJZhBYlI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504AF1BD032;
	Fri,  3 Jan 2025 08:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735892333; cv=fail; b=o9kp0jFg/pBq0cJ83LAZ/YAVDwkSAu/nA1P7tRFOiTNA5aRXiZOfuMut0QxMO0QLVqOCmNOEEItB0zdia6fZOLEaieusXBasFjsYd0HEI9lPyyZMunkkFfqCGoeWrjqBJK1FHUr9Rw7Pp+MjIaziMB1QaaXHqeOaEWBAqWTUfsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735892333; c=relaxed/simple;
	bh=kA7GPfQNp1IychYU31YWxUwLV2fDIPZJTzndjrTvihE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J5zV1Mo2pzxVGRgSDWnPPrVg+FT4tRKKCDBkR661wxb03ThcF2QEem5gvrWJjRe0/pygT0iZsrEYA4YjBKQWd9jeD1t2Ac0vDFgKf418Ga0oZdweJ+/Z0oViKNSDLt2foPkxbOFXnlxTQ2mPsXb6ykF8dordsEizdoqDDIgAVF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pJZhBYlI; arc=fail smtp.client-ip=40.107.243.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bkH8FDBYNJpPk73m6yfVqiHkwIBw2PcL9s6aQBdwfZMl5uATSuqAZM04p/BsaRlQOBnc6Z6TnVQW5RyXMp2+GGyMkNawZTHvke2nULvD2CJLdNCPZRESdHgXpJTI4W+XLgdMLwJHAYA/JsXaOnBcwBHI17NHSckTQB72XoovwBwM7R1L20GNkqTsiJb3e/0kzRcs+8+VgElh/J+SQyrWFC4LtbUbNKCYtx4U2r51E41RFZibCdmsvnTXDj57gb7PKAdsXMAPwd1xXD0YsIMk2YZ95lwyporFAK4Y+k+xj94Ae3hZLu6ymCQHfVI8s/rvse8TI4Oi1snMbMoCnA7AlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIEsdXFDlozR9ou1amcSBTWy5yqNsRgDFe60vxAccVM=;
 b=Kbk/DTKXul3l5Hfb+nIzWjImfFd15GbsLwAJsq5yuVpSLMlsVK+LiRAV/gVH+1CILS1C8+vuVhuumhatAA8s2D+jeizoSVWHdbWYenUTgm6u6hBve9eQFFnio5bggiwLFP3qdzYpH7sB75uSIGWbYEaTxyw8IHNDyVgI26QeDy6sAAZXf7/n92k2w3srRuPvv1AJ6JZ0GvkHBcXwHe2Gwvx2/rt77wHUpqWqP1Z4QdWcbwzvF49r17SL0oYtvC55nvMlcL/+aAc+GKEFM4QvpUWDsdmWtglm40/IsaDv4g17iNnQxe5oaNJHDKKcEewrSeyCSJ7yaIuciBqBurDFpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIEsdXFDlozR9ou1amcSBTWy5yqNsRgDFe60vxAccVM=;
 b=pJZhBYlInwjTZzBbQzOS0RRJ259iQCv9ENJ8UmE31WmIUSDBva4jJhIHZmo8DdEtoXej6DH0WPB1g0D4PCwKy8BasrAdH3BYBf7/ExF5FLc6I5IiTiQihbetfgHoDRxYzPoz3JUNZ7SB/kyVwJQ/mPWTGCnFE6XE9o4MjSv0ewQ=
Received: from DS7PR07CA0014.namprd07.prod.outlook.com (2603:10b6:5:3af::17)
 by DS0PR12MB8219.namprd12.prod.outlook.com (2603:10b6:8:de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Fri, 3 Jan
 2025 08:18:45 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:5:3af:cafe::cc) by DS7PR07CA0014.outlook.office365.com
 (2603:10b6:5:3af::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.14 via Frontend Transport; Fri,
 3 Jan 2025 08:18:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Fri, 3 Jan 2025 08:18:44 +0000
Received: from chalupa-d178host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 3 Jan
 2025 02:18:43 -0600
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>, <babu.moger@amd.com>
Subject: [PATCH v5 1/3] x86/cpufeatures: Add CPUID feature bit for Idle HLT intercept
Date: Fri, 3 Jan 2025 08:18:26 +0000
Message-ID: <20250103081828.7060-2-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250103081828.7060-1-manali.shukla@amd.com>
References: <20250103081828.7060-1-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|DS0PR12MB8219:EE_
X-MS-Office365-Filtering-Correlation-Id: 994f70dc-6243-4635-b292-08dd2bcf3db2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGRVTmZZQlF2dllLUE8xM3AwOFJ6eXUvUUdqUVRPVTFQSXVCRmY0bm1rWllJ?=
 =?utf-8?B?SUdaRHNTUUlyV0s0elNDdVRKR2JPVlNQc3NPakFwSUxudnpKdnMxNHR1T1dD?=
 =?utf-8?B?SUUwVVZwWjBaVVp1dEFjZWozKzdFOUdQQVZGMjNrR2NMQlVHUWhIZ1NhTWxw?=
 =?utf-8?B?dkRPUUZUNmJ5S3RSRXBkTVB1Q1JmbForalJPTEp2cG1UNzRVd09NenhBZlBj?=
 =?utf-8?B?OVFBTXE0SHFWbHFVdzJ1b3duVW9TMi9YTWV0TUtjMFhvb3NZYkxHRWltNko3?=
 =?utf-8?B?REtsQ0FhNDByNU1YbGM1N1VTenBGWWNSWVNUS2FWbHdwWERWNEVQTGRScmln?=
 =?utf-8?B?UzNaSUV3ZGovZVlwNi8wVEZVYjJYM1hETTBrUUlpMkZ3TG5xQnpNRU9sdGRY?=
 =?utf-8?B?SHFIOEl0ZGxjcU8rSUtSbTJVMTRsd3NHeUdnOUlYWmlsck4vcVZNL0NUWUhS?=
 =?utf-8?B?OUtNMzRNTWhQQ2hwcDFoS2pTWmxGUUVab1RGSS9BbHVvcTFDWEhoT2hIdjJC?=
 =?utf-8?B?SVZ0T3lQKzZDYmlhT3BnUEFla1FMNnJVWklveGZ5dThwUGNtR0IwZVVHMmtz?=
 =?utf-8?B?by9QZ1BsRG1NMWpsT0YyUVlIMHdvV3NQa0VMWUJseThsUkFyM0twSVFuZzhw?=
 =?utf-8?B?Y1lEd3ZaK2N2b3hua0wyMHAzTGRZMWd1b0RGRFdDUlA4bXRHZy8ySlh2QnFa?=
 =?utf-8?B?NyswdnNuTGN5TWptdExncy9RdmMwUFlaTzBacS9mMXh2V2doU1dpdkx2ajBS?=
 =?utf-8?B?N3ljOFBONlBrSlpiTVdoUUJLUjJ3cTZLeXFaUGUzVVlURXpJVVZKU1VGVmFN?=
 =?utf-8?B?dWE1YWFRTEhBNms4QTNONXpoS1JVN3NqRzVHN2RSSDU3dG5WMTlEQThkaVRN?=
 =?utf-8?B?VFdtS2FDRTBwaG4wdjRGcmNQQUNJbU8wNkg5bXp4TzkzTW5KYWFuN2dSSE4w?=
 =?utf-8?B?Qm9hV1hlZ3Z0NDVuUk0xRldKcUdBYklvNlVwdkJiTWkwMFpaOGNLa3Y3dzNl?=
 =?utf-8?B?NjZISmR3S3dlTXFYR2dMc0hnTVZseFJxNnFHWE8yQ1NCQ3BJeWdCTEh2QjYr?=
 =?utf-8?B?TU9Ldm0zakpTc2IrWTgrbmtWTnVRNFVSOTRETUw1MnlnaHM0RHVxdnQyZFcy?=
 =?utf-8?B?WCtCWU1uNDBFZWd1cjhwZHduUkNBbWhoU1hwTitFOHU3TkMzQU1GMzFvSXc5?=
 =?utf-8?B?OUZvYjY0b1ZUYXhNWk1tTU5KUTNNUnJQbXdNK2xCV29RNVF6SG92RWxSVEtS?=
 =?utf-8?B?aXNVM2JXL1FpcWhpZVFUaDRmODIxMmNidE1sbitvZjB5OTNhRE9aait2YWVt?=
 =?utf-8?B?MEI1eDJidmRUVFI4dFVCU2V1L2IzZ1c2KzdMN1JneVYwZjhtMFU0RitWbUhL?=
 =?utf-8?B?NHhlNkl4OExDZWloeFI3M3JSYVdhZXRxZlRlaW1Hb1prRXR4Q0RRVGhTUlZ6?=
 =?utf-8?B?VmF2ZTkyNDBucFJ5eWVJQ3Brd3RnakxzTWpMZGxGa1ZObEZBWllaZjNyTUll?=
 =?utf-8?B?d1kxSUVtMUZZUHI2MUVtVmdOK25ycWpnQVRkcWgvQ2NrVDZ1M0xabW1UeVJy?=
 =?utf-8?B?cTkvKzRBNUYzT3J6akI1eG1GZnZob2ZvZnU5MGYwTW1od2p1Sk1PMFloYjdH?=
 =?utf-8?B?cFZEMmlWbDRMYXM2eDc1ejhVamt6VnBHeVB0aXk1ZXdkTDUvVC9iQXlHUjBs?=
 =?utf-8?B?a0RMZkE2THM1V2lidHg1MkpKTm50Q1RVVE5FMmVucngyZ2ZZYk1yN1d1dCtx?=
 =?utf-8?B?SklyRFpZckxkQWttQXpWd0xKdkhZSkZ3azQycjZsRDBLUUhDYVhIWkE4WkRq?=
 =?utf-8?B?YmNJbjFJWGxVcHZFS01nM21UYmFFbG5UeklPaTZaaVZ3cWp0OVYyb2w2dTFI?=
 =?utf-8?B?cjIyNGF1QXdhSmVIZk5RZHQrL2oxT1BQOUlDcmt0NTFxSnRxdjN6WTFwUFFR?=
 =?utf-8?B?bHFnbGY3TEFXbktVaHIzeWV1eitxQjNqQlMrSC9Kdm9RVUFCa0xnYVJibThS?=
 =?utf-8?Q?ewBJ56cHSRDW9RhxaX6CISII4NRtNY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 08:18:44.8261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 994f70dc-6243-4635-b292-08dd2bcf3db2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8219

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
index 645aa360628d..4fef0533f764 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -386,6 +386,7 @@
 #define X86_FEATURE_V_SPEC_CTRL		(15*32+20) /* "v_spec_ctrl" Virtual SPEC_CTRL */
 #define X86_FEATURE_VNMI		(15*32+25) /* "vnmi" Virtual NMI */
 #define X86_FEATURE_SVME_ADDR_CHK	(15*32+28) /* SVME addr check */
+#define X86_FEATURE_IDLE_HLT		(15*32+30) /* IDLE HLT intercept */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (ECX), word 16 */
 #define X86_FEATURE_AVX512VBMI		(16*32+ 1) /* "avx512vbmi" AVX512 Vector Bit Manipulation instructions*/

base-commit: 13e98294d7cec978e31138d16824f50556a62d17
prerequisite-patch-id: cb345fc0d814a351df2b5788b76eee0eef9de549
prerequisite-patch-id: 71806f400cffe09f47d6231cb072cbdbd540de1b
prerequisite-patch-id: 9ea0412aab7ecd8555fcee3e9609dbfe8456d47b
prerequisite-patch-id: 3504df50cdd33958456f2e56139d76867273525c
prerequisite-patch-id: 674e56729a56cc487cb85be1a64ef561eb7bac8a
prerequisite-patch-id: 48e87354f9d6e6bd121ca32ab73cd0d7f1dce74f
prerequisite-patch-id: 74daffd7677992995f37e5a5cb784b8d4357e342
prerequisite-patch-id: 509018dc2fc1657debc641544e86f5a92d04bc1a
prerequisite-patch-id: 4a50c6a4dc3b3c8c8c640a86072faafb7bae4384
-- 
2.34.1


