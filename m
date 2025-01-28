Return-Path: <linux-kselftest+bounces-25303-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D30CA20AB7
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 13:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C13057A3C96
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 12:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1494F19F133;
	Tue, 28 Jan 2025 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D52GeGil"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491D719C54E;
	Tue, 28 Jan 2025 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738068529; cv=fail; b=h3A6MaANMZ7mLVUw3zvc2adWxji8kqk/hRc4aFwDcAvvZ+5Skvwo+j/RYrTrOSE18a2pYso3/26oWvxiB/pfpomriiUbdCYWGHS+CIw3/bCFFrh0URA168UAR0L2Pn6oWIusjtmijraQKX3mmUz3GsRQqrpkdMJRRSvfkEWIHk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738068529; c=relaxed/simple;
	bh=g+wHvv/brCh4j/YO9duzEo9ENKIrH0oFq56j5wuikm0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ESaLBzxcELycOKv8QovHwhrhn4h8NCsK/9mfSJ/eEIEb22cSE5Z5ljUOdspoozqLl0Cwm9jK0WQERRwHFNpQdqRpU3TPsEeiQZKsBvV3Z1qwKWqPw+GkBcm8B4za/8d45b2GAyV45Ocz4CQgDW7SeKZ8LvesU68RyyFulv5SsX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D52GeGil; arc=fail smtp.client-ip=40.107.95.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTF1m7qtc/fqRDaAFc0Y8RTh6InWMliKHu6OgeqQA36ohNHhvfvFEiX/dLFEV7DDwpLdNzEgG51QOwf9yI/VRrmMh0Zr62L6E81A22VvmO0eUXxnk4TwCFJSzQg8njJuVLpYe5+DTFIF5eCahqT/mHucdd5K/iPvQkZ6tKggg3zqp4QHY6fwADLGlN0YB1mzmLXzy3RbGywFUSf4YWR7f+G9dhy2rvaxV/7LlosmgeEZzZuj3o2etH5dnznqRgdnYwVqwD+vvEP8dO/ljYeoOLNQX3VJh3EDowBV1pYRvrG/1YlUA2AQnzhpKWR4gUnwHaHNCKW/vkFVs3sNfhn2dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERReT5X5J20dNGcXECin8n80rkfppC59DoNDvVAn4ZA=;
 b=Ee+w5x7rKJjm/MYvVHGByXLhl6Zn1YIHRu12wRso0Bs2VOLwM0khN5sqHDRhD9j2tffedyUPMyUjTUrmv1NiSPMTqbVJC8r1R3wOh3JDZpQPkaJfVz1JFYWPpEwVkGHnpjCh318j1cf6QY5/gfJD31XswN0WNgpcneSzmNNWgH0egpkr3gOU+t3BuvxfT9s2+zYlBWroRmc8+MNgiMxlp8/3kN1QZhEh071yMyNIt52zP09fCG9P3xEu0jSGkFxgxuv6I3PcSlYRwP6+dn41B9MyWDJCDgBKJfJgrcoNxWH5udeZfw9HUc83vB4t/0D18iN7tM/Geb55mLqQHKYd3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERReT5X5J20dNGcXECin8n80rkfppC59DoNDvVAn4ZA=;
 b=D52GeGil7VMXEzjol8znx0QHLYQc+P9UcFsb3+fyiW1uftDfoeaxaOYz2i9SIiSJNib4PfPdgrtzTEwoVZ4mV9Sj3xA8EockH4y848MCmVG8QMzp6j+pSr2dm5hGG1imJuU/Kcp/9qlTeVk63232Em/DbrOqOTwn/bc7JTdpSj4=
Received: from BN9P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::19)
 by CY8PR12MB7660.namprd12.prod.outlook.com (2603:10b6:930:84::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Tue, 28 Jan
 2025 12:48:42 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:408:13e:cafe::f7) by BN9P220CA0014.outlook.office365.com
 (2603:10b6:408:13e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.22 via Frontend Transport; Tue,
 28 Jan 2025 12:48:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.0 via Frontend Transport; Tue, 28 Jan 2025 12:48:42 +0000
Received: from chalupa-d178host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Jan
 2025 06:48:40 -0600
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>, <babu.moger@amd.com>,
	<neeraj.upadhyay@amd.com>
Subject: [PATCH v6 0/3] Add support for the Idle HLT intercept feature
Date: Tue, 28 Jan 2025 12:48:09 +0000
Message-ID: <20250128124812.7324-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|CY8PR12MB7660:EE_
X-MS-Office365-Filtering-Correlation-Id: ccec9d8d-2960-4209-f09d-08dd3f9a185d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dTlDeTRVeHFLcU9XT1BYK3k0ZzREdHZmc0gwOCsyNndJaVJGSk5PS2dSYy9a?=
 =?utf-8?B?a3pSc2RDK1BYZGFEWnpCNHJMRTRkZTBULzRBR25UZDRDcWo3YXIrUUplckZF?=
 =?utf-8?B?ZnJoclZOWC9ZYWxNY01DN2lMM1J5MUtNSU1rdnp4dUtxRFpXZzMzaHNXNlJT?=
 =?utf-8?B?eXdOMmNOSlVTRXk3OUY3amp2SnNJYk4vNGlMd0R3dXZORUs3U0xzZ0tISExm?=
 =?utf-8?B?VGJwbTRBZDBCMHg2SVVVMWhpVnp4Zm40UjhZMm9kOGtsbGFOdUkyQzJkdVBN?=
 =?utf-8?B?aTBHVlNkTzBQUlBMa2hBY1FENTk5Q3FSQ05WRThrWGRtdW51N1A3RHp4U2o3?=
 =?utf-8?B?R3A2dlV5NTBYUzBZTHJtaEVPcjdTS2FpUTVvdGhoc1RtT3kwUGhYOVhYcHIy?=
 =?utf-8?B?eU51T09WYzFZYWNkVUJpRnRCc084cFhLWHBpVWgxcmJwajgzUWZrT3Z0b3BJ?=
 =?utf-8?B?QngydFdWcjlacWN3WGZtZXBkUTNibWhCdnBpaytVZUdLbm9yWi8wb0F0YnpX?=
 =?utf-8?B?UjNIcGxkTXU0QlM5UU9BdjltN3BsYjMxTmRyRzFmSVQyMEdvQWVGWHFqQUlp?=
 =?utf-8?B?MzBrNkNmRDZ6TlFIU3R4aXBzWUo5bzE1K1JhcThCZG1nUVZwNDhqQm5SNmlW?=
 =?utf-8?B?K1VaMnpaZzU2RHIwemhBZ1N6V05qOUV4WW43Ymg5bzQ3d1hEcXpuSTdIQUVU?=
 =?utf-8?B?ejN5aWYrNFp6SGRDRE5rdHZXUzZFVm9JMjMrZHE0QjV4Mlh4a0I3dXVYaEQx?=
 =?utf-8?B?UnI1WTJhZmJHSERVdVE4U1BPeW5JbzIvclZXZmxoMlZWVGJBNDcxMDNnZ0RW?=
 =?utf-8?B?ZVBMVkIyNGoyOW1xRTREdDBldXdKT3RsM1pnTUxTclN0SmxlM29mYkpJVzlU?=
 =?utf-8?B?eHRYMzIyVy9xSHJOMWVIV1pRWXhaelNCTkt2WWx6UTNuNFZHeHJ3SnNaeFVP?=
 =?utf-8?B?SjlYSzZvTGZzejNHbWRUSXF0cUxtamI5aTdXN29HWXJXc2hJNm1IRHRxd0Jp?=
 =?utf-8?B?eTlOQWZvRm1ld0w2dHJwQ2JjeG1tOHVndUFYWkUveDZQaXcrbTQzL3IwcHJq?=
 =?utf-8?B?NzZMOThhRG8wNTJnMENYZzVEb1hGOW5yNUY3WDgwZDJaUVVyK2dpRldyR1BD?=
 =?utf-8?B?SjBHMVVJNEhQUjJITzFLckllcGY0am5FQUVFa3BZNG9IR0VzQzVVNHVGd3Fr?=
 =?utf-8?B?L2V1dlN6dGtUQzJ3azV1emRGTC8zOEtsb0dBejM1OExnTzZuWGZQelhSL3Na?=
 =?utf-8?B?aUFnTWk2SDlmNUJKT3pvdEN0cFhnU24wVjlVZEtFTGh5REhRRENDdnVkdzZ5?=
 =?utf-8?B?d0Zod0hmQ0RrZ1duMDBwZ0RrWnhHWmVCTGw4UUh0aU1nTTdmZEVmVVVsdFdu?=
 =?utf-8?B?bXZMM2poeXd6eFgrd1p3eUZrUWZKZmQxUm4wNVczZlNwcDBOKzJ3d3RndHRW?=
 =?utf-8?B?TXRiQ2orSE8rYXlOcHNjMDgyTUVVRlVGUG8vdExuRGxyekQ3eE14dUFlbVdo?=
 =?utf-8?B?WWM1bG4rNElYMGp5S0NHbm51d2ZIQzhGZGpqaGhrK1pocGlFejFDdlhDR25k?=
 =?utf-8?B?cE4wOUUrK2VIRTljZVkyQWpYOHhkdm85Z3Q2dy9IaUVQQjlsTnBSb01IdHhQ?=
 =?utf-8?B?OE00MittdmxBcW5JWXpsd3QyMVBOZElNZnRubWs3clNhK2VSbGdCcUxRT2hy?=
 =?utf-8?B?TWNoK09qNmZ6NXh1WU91YlVwUGdEZHhxUnFOQnpDdUcvcXVwT3R1SmtMeHJx?=
 =?utf-8?B?MGdzNkZFYkhRTjRNYzNvcllrL1AzbW84dE9qcnZ0Q3loQVR2R094aktNUmMv?=
 =?utf-8?B?SjV1Mm92bjJiS1VrTVFtQktFMnlWN0FrL2tqdklxNVB0MXRIcXFaaFduU3h2?=
 =?utf-8?B?Q3ZwZy9TY2lJdklaemdGRDlmMk5uQmtnN1ZMc003WFRZQnJLd3JndURnRERR?=
 =?utf-8?Q?oHiCuOSjNjI2JJ3COD50sEsX+A2MTsJF?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 12:48:42.2020
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccec9d8d-2960-4209-f09d-08dd3f9a185d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7660

The upcoming new Idle HLT Intercept feature allows for the HLT
instruction execution by a vCPU to be intercepted by the hypervisor
only if there are no pending V_INTR and V_NMI events for the vCPU.
When the vCPU is expected to service the pending V_INTR and V_NMI
events, the Idle HLT intercept won’t trigger. The feature allows the
hypervisor to determine if the vCPU is actually idle and reduces
wasteful VMEXITs.

The Idle HLT intercept feature is used for enlightened guests who wish
to securely handle the events. When an enlightened guest does a HLT
while an interrupt is pending, hypervisor will not have a way to
figure out whether the guest needs to be re-entered or not. The Idle
HLT intercept feature allows the HLT execution only if there are no
pending V_INTR and V_NMI events.

Presence of the Idle HLT Intercept feature is indicated via CPUID
function Fn8000_000A_EDX[30].

Document for the Idle HLT intercept feature is available at [1].

This series is based on kvm-x86/next (eb723766b103) + [2].

Testing Done:
- Tested the functionality for the Idle HLT intercept feature
  using selftest ipi_hlt_test.
- Tested on normal, SEV, SEV-ES, SEV-SNP guest for the Idle HLT intercept
  functionality.
- Tested the Idle HLT intercept functionality on nested guest.

v5 -> v6
- Incorporated Neeraj's review comments on selftest.

v4 -> v5
- Incorporated Sean's review comments on nested Idle HLT intercept support.
- Make svm_idle_hlt_test independent of the Idle HLT to run on all hardware.

v3 -> v4
- Drop the patches to add vcpu_get_stat() into a new series [2].
- Added nested Idle HLT intercept support.

v2 -> v3
- Incorporated Andrew's suggestion to structure vcpu_stat_types in
  a way that each architecture can share the generic types and also
  provide its own.

v1 -> v2
- Did changes in svm_idle_hlt_test based on the review comments from Sean.
- Added an enum based approach to get binary stats in vcpu_get_stat() which
  doesn't use string to get stat data based on the comments from Sean.
- Added safe_halt() and cli() helpers based on the comments from Sean.

[1]: AMD64 Architecture Programmer's Manual Pub. 24593, April 2024,
     Vol 2, 15.9 Instruction Intercepts (Table 15-7: IDLE_HLT).
     https://bugzilla.kernel.org/attachment.cgi?id=306251

[2]: https://lore.kernel.org/kvm/ee027335-f1b9-4637-bc79-27a610c1ab08@amd.com/T/#u

---
V5: https://lore.kernel.org/kvm/20250103081828.7060-1-manali.shukla@amd.com/
V4: https://lore.kernel.org/kvm/20241022054810.23369-1-manali.shukla@amd.com/
V3: https://lore.kernel.org/kvm/20240528041926.3989-4-manali.shukla@amd.com/T/
V2: https://lore.kernel.org/kvm/20240501145433.4070-1-manali.shukla@amd.com/
V1: https://lore.kernel.org/kvm/20240307054623.13632-1-manali.shukla@amd.com/

Manali Shukla (3):
  x86/cpufeatures: Add CPUID feature bit for Idle HLT intercept
  KVM: SVM: Add Idle HLT intercept support
  KVM: selftests: Add self IPI HLT test

 arch/x86/include/asm/cpufeatures.h            |  1 +
 arch/x86/include/asm/svm.h                    |  1 +
 arch/x86/include/uapi/asm/svm.h               |  2 +
 arch/x86/kvm/svm/svm.c                        | 13 ++-
 tools/testing/selftests/kvm/Makefile.kvm      |  1 +
 .../selftests/kvm/include/x86/processor.h     |  1 +
 tools/testing/selftests/kvm/ipi_hlt_test.c    | 81 +++++++++++++++++++
 7 files changed, 97 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/ipi_hlt_test.c


base-commit: eb723766b1030a23c38adf2348b7c3d1409d11f0
prerequisite-patch-id: cb345fc0d814a351df2b5788b76eee0eef9de549
prerequisite-patch-id: 71806f400cffe09f47d6231cb072cbdbd540de1b
prerequisite-patch-id: 9ea0412aab7ecd8555fcee3e9609dbfe8456d47b
prerequisite-patch-id: 3504df50cdd33958456f2e56139d76867273525c
prerequisite-patch-id: 674e56729a56cc487cb85be1a64ef561eb7bac8a
prerequisite-patch-id: 48e87354f9d6e6bd121ca32ab73cd0d7f1dce74f
prerequisite-patch-id: b32c21df6522a7396baa41d62bcad9479041d97a
prerequisite-patch-id: 0ff4b504e982db7c1dfa8ec6ac485c92a89f4af8
prerequisite-patch-id: 509018dc2fc1657debc641544e86f5a92d04bc1a
-- 
2.34.1


