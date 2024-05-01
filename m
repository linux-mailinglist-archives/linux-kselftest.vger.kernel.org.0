Return-Path: <linux-kselftest+bounces-9210-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 314A68B8C30
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 16:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B23151F2196D
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 14:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42F612EBFC;
	Wed,  1 May 2024 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1GmXMWg6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1200812D779;
	Wed,  1 May 2024 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714575321; cv=fail; b=XSxPdN7DibLQbJrj48L526t/FfkktTLx2qYN1jjtoeeyAJqVOxYQ/A7QHMtITfIXZ2tO9xttVp853lXXx2sosIrhXHP+vRFTnsMCaV5o/OmsWXJIPHB09V/hpQwwAMiuV1pWu45wfJD7iBKUmTZq4PXFVI3eXLz2svMGJCuvmDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714575321; c=relaxed/simple;
	bh=ccbsUzLUDmt8K78GZGcF5FxkX7cIAD2kW6bE0+TtrfE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AFlMjLKgAM6NrYGT2ZZMGn0kFcTWt4oCS8jlFthEWAbH5H94Muxehfj8fmTCIA7WuAzpp11I5Y2ChxatUCPamZBXfY/EsgQgLcQXX51Twc9xWlrg9mu5jrMsz85/tuSm1mKHV0m7CyyL5Zy5piQz1Rk7JntCFgBOqam/Fq89Jm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1GmXMWg6; arc=fail smtp.client-ip=40.107.220.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0g36Pt3WR5Voje2X0WvnEQSs4YUFoOkCLjM8+/3V2pqdsq3SaUy8gVItJWAdFU6+Kfe5lAVHouoGOZz/EqskQRJO0wP2Hvgqwpg8JM2Mp5XGhnYjxjCappc3D9lzDsZEdSAS/P7dSN52rd1q2aMt0uY0AqZhbq9MkqM/WfkDFfgWHtaCqzVXpgCTJ+zoR8PT3uuU48Q9xO63lOSWxEH4UatJ5c1OI3tlfQEvTIfLOgk+ruDJCMOOVGgsklzbXxaaNs9iWv4QoZ5MY3ocD833s0mORvfeIwaEGUNRWCpO/F3HOwh5cc0OAIQB2upC5VUaRBrxwUFr1a50L840fhf7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3YTc/ZxExyvr4Z3THBrK5vr01b0hvDQ8hUGL9hQWyA=;
 b=elD4kdglYG9OVnVxAskTDsir9C/yB3DBVrjjzfXa4R7r25E7cEvpSfJrLteRlOT23GNwojrkC4qXEykDiVPAFQeSjqLpKE2UbOSbyeNuKyhVMkDEDtAnPkyV8P9NrhgKh2ahybpXuLErIBv4TvPowi9Q/Lb+iCO6IGM2mQDjINqa9SFm/V/y3TPXOXgz+WSx/XgAZK7kBI24d6FKAmPDkkZcRYGSV5N474ZTeVQ6qn4JGxh5I3RnfBh8o3bza07O7jEtNWbr2zEMxvC3gOp5fGwCjNjuv7IeBAVwXYHKmqZsIa7AlbEhj0QtVZSDCV+++o7P3pjTdQkI0U1gpjOoWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3YTc/ZxExyvr4Z3THBrK5vr01b0hvDQ8hUGL9hQWyA=;
 b=1GmXMWg6kA12ABVWmjbXGSgvSE2GqwX3Xrp9n73fYViSMiMedr17URgNDKCUPVfbnSliEqTaNQVxg2oEenmvg5krfeYuk6kMFq3W5y1BpHPY5flwQPBuGLLBfxgYDHOKyUGJIsWVo0szMKdw0EsP3SJ/HQ13PHlv7c7PqvBSSxQ=
Received: from CH2PR10CA0001.namprd10.prod.outlook.com (2603:10b6:610:4c::11)
 by PH7PR12MB5925.namprd12.prod.outlook.com (2603:10b6:510:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Wed, 1 May
 2024 14:55:15 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:4c:cafe::59) by CH2PR10CA0001.outlook.office365.com
 (2603:10b6:610:4c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29 via Frontend
 Transport; Wed, 1 May 2024 14:55:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Wed, 1 May 2024 14:55:14 +0000
Received: from chalupa-4a00host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 09:55:13 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>
Subject: [PATCH v2 0/5] Add support for the Idle HLT intercept feature
Date: Wed, 1 May 2024 14:54:28 +0000
Message-ID: <20240501145433.4070-1-manali.shukla@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|PH7PR12MB5925:EE_
X-MS-Office365-Filtering-Correlation-Id: d518f993-a97a-4dc7-bcf7-08dc69eeb558
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400014|376005|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QU9RMFRVeUU4YjJxMUk3cmx2Ky80cVhpVFBOWjk1bElaTHdTVlFycXRCUFdW?=
 =?utf-8?B?TXZvenY2NFdzMEQzUkhJUXlCaTgvWE52TlBCa21EOW1PTDRPc3VnMzUwbUkx?=
 =?utf-8?B?aU84bVM4SlZ2NTQwVnJUSm1XVzdYbmc4a0FaK1BlTVRGWUJnMkk0LzVlVTMv?=
 =?utf-8?B?eFlFWittdFlEd0lCQno4TkFtOTkvYlpqdmxCbXdBM2hWMWRlc2I0QlEvK2Zt?=
 =?utf-8?B?NE1CR092djlwL0lTM3h0QVEzMTQ0RXRpNzRnaXFsanUwNHRHQkJqR01rVzBW?=
 =?utf-8?B?UU9aaXczWWQxakI1T1FjQzBablEyNFloeUpvcURCZGRSeGwrbGFzajhVOFVV?=
 =?utf-8?B?SDQrZjVZN056anRLUDlXbXFaR1JVNXNydExwczFyZnZDaDU5WmdGV1dHTUNq?=
 =?utf-8?B?TE90R2hMWVVJejBWRUh3NHNsSGV2S2djdm9MK3pMUnZwWGxmaVNvWDBwSkxl?=
 =?utf-8?B?YVcxeGIxbThXNkpTRXZLMnd5Yld6Ty9mTmZvNDI1VVNjaVdhSXo3SzFDYzhU?=
 =?utf-8?B?NWZmZEU4MDBEZG9iL1hMSVRVcnhoTmttNWsvRXJIWUZoK1N4QVZhY2FEMWlP?=
 =?utf-8?B?T2J3L1JlZDhCV0JZbmlMempxZjdqNTlVeFJ2dHVJYUg2VDRFbFVrZ2xtbS9u?=
 =?utf-8?B?dlVGV01CWllWK1NEV0poM09TM2pOZHJBdzJmeENRb0VFSC9Va0pzR1hENkgr?=
 =?utf-8?B?eHFKRWVmSFZnNXJBSDlSQkJKcFdDK0VOanhFNjJuencwZ2tUNEhrdHdBQ2Ey?=
 =?utf-8?B?a0tZb3hERHlDSVVmUjhxNm1oRThaMGJ3ODlJYldLMGNQNytGQXFqajA1dGpi?=
 =?utf-8?B?b2ZCZ092R0FMR2hzQWpZdE1rUXpMZ3dpbTJUbGFoNExPbGJwTGR2UlF0QUhp?=
 =?utf-8?B?TEZPeWF5cjRtV0RCaDRrSXBTT3VsQWV5dXM4L0t1OXBXRDN1SGhYSzEwUi9h?=
 =?utf-8?B?VFlISW9PWk1neExpRlZtaU0yNUwwZ0RmeHdyTWdzdGhONDc0cDNUZlZObGJl?=
 =?utf-8?B?YVdSYVhNV2J3TldQangwY0ZrZUNBcFg4V1h0eXlwUXFjZkRVTVd1STBSUTVF?=
 =?utf-8?B?bkJ4bXk3TTZuVm5FdVJqMGhOSHczOHZrOGxsNFdtREREbUg1V1FsUkZMMDkv?=
 =?utf-8?B?cU9BUXVUcFVHdEJ1NnRlYU1XNm9jRWp4NVpyenZCeXdXUXpNMTBpMFpHNHpG?=
 =?utf-8?B?YjAvRmRidjlIOWY3ZHJiM2pRcFJlcmhNMG1tS2YreTk3Wk5uck90UmVkbmpC?=
 =?utf-8?B?ZERlekN6Mi85WlJkaXFRSG8xajVWdG1rekZoVVpqVWhLcWJJa1R3anVhbXVD?=
 =?utf-8?B?RFloN2cxWEt0SWZmTWJmQ3dEQ25tOENybU54S1Nqby94TFdPZ0UxVXZza2o1?=
 =?utf-8?B?SnBpRXNvL2g2eHdMOGxOcUZrWFhOWDhxei9EUjhDdzVWSHRjTFRKdVlSQWVk?=
 =?utf-8?B?R1FzcXFveHBhNTVXQUFHY0lXUS83c2FDVjlxdWNHNy84ZWdXQzFLdG9zSWEx?=
 =?utf-8?B?RExxM3k0NGlyR0xxT3R5ZEFKQnpOdjNaUXNYd3pVZm1Zc3lBeWhEWXczZlM3?=
 =?utf-8?B?ZENoL2xpRjVuc3F2NW80RVFLY3hJOUxzVWVtaVRTaTZRNXhEUzh4cFE0YmlN?=
 =?utf-8?B?eStMREFtUGp0bWNBc3pHVk9XWUtnQ1Y3Q3JxS3ExNWJpUjAvZGN6TVRISGhZ?=
 =?utf-8?B?cnNlUEE5a3dwakhiTm50ZkNHV0lEWFRKYW9jejRlQXZVanNxMEVvZUxLTngy?=
 =?utf-8?Q?qRioY3njIYZnzrO6ulq5r3m1ZzXcNnI6FGhhydA?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 14:55:14.4767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d518f993-a97a-4dc7-bcf7-08dc69eeb558
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5925

The upcoming new Idle HLT Intercept feature allows for the HLT
instruction execution by a vCPU to be intercepted by the hypervisor
only if there are no pending V_INTR and V_NMI events for the vCPU.
When the vCPU is expected to service the pending V_INTR and V_NMI
events, the Idle HLT intercept won’t trigger. The feature allows the
hypervisor to determine if the vCPU is actually idle and reduces
wasteful VMEXITs.

Presence of the Idle HLT Intercept feature is indicated via CPUID
function Fn8000_000A_EDX[30].

Document for the Idle HLT intercept feature is available at [1].

[1]: AMD64 Architecture Programmer's Manual Pub. 24593, April 2024,
     Vol 2, 15.9 Instruction Intercepts (Table 15-7: IDLE_HLT).
     https://bugzilla.kernel.org/attachment.cgi?id=306250

Testing Done:
Added a selftest to test the Idle HLT intercept functionality.
Tested SEV and SEV-ES guest for the Idle HLT intercept functionality.

v1 -> v2
- Done changes in svm_idle_hlt_test based on the review comments from Sean.
- Added an enum based approach to get binary stats in vcpu_get_stat() which
  doesn't use string to get stat data based on the comments from Sean.
- Added self_halt() and cli() helpers based on the comments from Sean.

Manali Shukla (5):
  x86/cpufeatures: Add CPUID feature bit for Idle HLT intercept
  KVM: SVM: Add Idle HLT intercept support
  KVM: selftests: Add safe_halt() and cli() helpers to common code
  KVM: selftests: Add an interface to read the data of named vcpu stat
  KVM: selftests: KVM: SVM: Add Idle HLT intercept test

 arch/x86/include/asm/cpufeatures.h            |  1 +
 arch/x86/include/asm/svm.h                    |  1 +
 arch/x86/include/uapi/asm/svm.h               |  2 +
 arch/x86/kvm/svm/svm.c                        | 15 +++-
 tools/testing/selftests/kvm/Makefile          |  1 +
 .../testing/selftests/kvm/include/kvm_util.h  | 66 ++++++++++++++
 .../selftests/kvm/include/x86_64/processor.h  | 18 ++++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 32 +++++++
 .../selftests/kvm/x86_64/svm_idle_hlt_test.c  | 87 +++++++++++++++++++
 9 files changed, 220 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/svm_idle_hlt_test.c


base-commit: 2489e6c9ebb57d6d0e98936479b5f586201379c7
-- 
2.34.1


