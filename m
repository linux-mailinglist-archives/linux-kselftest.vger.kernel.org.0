Return-Path: <linux-kselftest+bounces-20366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4113F9A98E4
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 07:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5A5F1F241B5
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 05:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F257F136328;
	Tue, 22 Oct 2024 05:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ADXhBBmV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062A81E529;
	Tue, 22 Oct 2024 05:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729576111; cv=fail; b=fWP6/NwbCWEJW5D9GQv9mjad0Zfcr5RlI0ejzVAEZzKYnH9xhMvxzO8GiUv+tHg7uBPD8ggqY6rwKsCGH0mwiTjglTimIg03UAHFFW8TMFNIYUFUElZn9kHsO9Re6dOpxHVIr2gGT8aGCNVRnY/z2M46nAB5Wbh0o6Jny/lvds0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729576111; c=relaxed/simple;
	bh=sc6HM7Xlox17can0MY/QOMfBcJW/6In6No0oos46pmE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cgVi+zEptCHCcX38/4i2+KkHLmZhD/BYfnLmC1R3KWigAFb06+KR8WAvvs/GvCJEl8m86g26CVK1TSpVKEc0OcOfhhdWYYyDZ9hOEMMBN/G94VGs040E00W9XJyeH1LiIEucWuFzMqB4DCw151ziMZwKE3dvzBPbbTL7FUY/VsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ADXhBBmV; arc=fail smtp.client-ip=40.107.243.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4+qbAFjxA63QtUISuBYT+CJBysaEYYPKpAfZbAmkfge8nNa7acQXfbj47eMiO9RWZKLNj4FK8R7LhfeZROf0oAynfJdam0v5IC/4ngqjkfTWdgqZiDMdNMNmX6VV/MkjpWpTkBzaHNhPvjmMn4gSG0h6XuHZaU3x1ew6oRkiUllTY/MqrBM9IauYXgngQdswIvZaFbhlcCD7RaazAWkJ9iyit8/YlySFJSqnuOp2hUbAaOM3OsKbaRL7Yk7ehRhxSF8c6NNYBUOfdV9BqoxpMBvXq8YfFhafepUk0HaoR4lfB9m5gVetvmetuRh2TSd8Rz6OPqrc2dnylYIR1hwAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSRCWKClXPhRoI/mrxQGcL/Rja0auo871KakVsXbAbs=;
 b=A5lO5bLk8zRnxdBNVhiThD8xt/gnjDiwDW0PyjzSlhc8tWVeLZbqTV0fqJ2VaZmJ9wVv8nY/Dc4AmcNNeF94AB4bLSPaL+cDnLoPe3anuKxPKDC63ZM37cqV9nFVh6CQ8vXsrW/aqblR1AorlfT2RI+pVfIFH1Z5IMqQJ9uWP0TrwieGzTyWO3y5O9g5m6tYlu65wyum8WenwIx8GXg38KKX1vMJkKoRwp06aiLVmN1mIE7aSVra+5+B97cYhfMUYG21whnk6TvzN9ECDXrdHA56qjl+CSuJd+fCsadvXTsj5aJaQs8lfShqELbA0O2QNceq0yaMn4PIURYOc9phUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSRCWKClXPhRoI/mrxQGcL/Rja0auo871KakVsXbAbs=;
 b=ADXhBBmVOrRfXpm5B8NIgWYBdawWoGS3jMN6sPvoAkm2d7mdva1epOBqZWIW4qJc2P+XcP8RZix6b1eH8vfnMWSzWhJp+8gMXVvKAT4ICzdrU6660gmsOmBQ020iX5mPaeCzPssrCcttXE58W1B+oaB3jZGvV1eZ6F91AF5AePY=
Received: from BYAPR04CA0029.namprd04.prod.outlook.com (2603:10b6:a03:40::42)
 by PH7PR12MB8780.namprd12.prod.outlook.com (2603:10b6:510:26b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 05:48:26 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:40:cafe::58) by BYAPR04CA0029.outlook.office365.com
 (2603:10b6:a03:40::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
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
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 05:48:25 +0000
Received: from chalupa-d178host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 00:48:24 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<nikunj@amd.com>, <thomas.lendacky@amd.com>, <vkuznets@redhat.com>,
	<manali.shukla@amd.com>, <bp@alien8.de>, <babu.moger@amd.com>
Subject: [PATCH v4 0/4] Add support for the Idle HLT intercept feature
Date: Tue, 22 Oct 2024 05:48:06 +0000
Message-ID: <20241022054810.23369-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|PH7PR12MB8780:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ca4d8ee-87b7-478f-144c-08dcf25d25d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXM0eVNyZUVuaGFzYUhsKzA3ZEx3cGRTb3RmRDdBUnI2eHhFcHpyQU4xc0hR?=
 =?utf-8?B?NG5yelRUYWlPbytJb044cDVpdWZpcjB6SU55TXRaSnRwUTdZaU5QczZ6L3cy?=
 =?utf-8?B?MnlxQjZuMmR3MllML2dkRTZTcXJQR2twcXBiK3UzMXdyTm5uWkFSSG5XaXlZ?=
 =?utf-8?B?Wml5NGdLUlo5R2VKcFFTYTV4ODBXL29Sby93b0U1ZmtpK09PWjFLOHM1Z2tk?=
 =?utf-8?B?emZ4UnpTZ3FFL25OWm5NMHNUQ3p5Rm11cmFHYlB0TWV2RFlDM2NGa2g0bGlw?=
 =?utf-8?B?NjZNc3NLNnBEZDZ5S1J5SlZaZVNDbnhaSWMvaWtCT0pXbTBOdWVmMUdWaXF5?=
 =?utf-8?B?QTdVd3BHVm9SOHVqRkRiaGdGa2JJNGJvckhDS3hJNm8yazl6eGd0R0V1blEv?=
 =?utf-8?B?eFJyRWNoSVViQ0llMlF5TWhTeFdscVVUaytWbzVqUXdXTjVhTURXcWY2UjNV?=
 =?utf-8?B?WUo4c3RadHE1bkFUdGpUMVRmYy8wS0g2Ylk3a2N6cElOYW5Tb1RLSFNnVWZn?=
 =?utf-8?B?VWhoaWJxWGh5RGhvem9hMmplQ3JBNG1SdlZySzlQUzVIZGQyT1ZDRllYQ09i?=
 =?utf-8?B?U3hYQ0Y0b1Q4aVljMnFHcjNpbUdoamZxT0hJUVo5b0dlUkNZYVRqMG9PYTBZ?=
 =?utf-8?B?MWRHaStOVCttalJTQ0R4bnRqZlZHNnAzZXJIYm9tVW45WjZrQWhhVnZ6RjVW?=
 =?utf-8?B?SUhKakI3Q0dOT2xZS2E4WHF6RXVnb1Y1dmxXM2M3a0lLRHY1ekh1aGRoUTB2?=
 =?utf-8?B?OU9vMG1MWHV4T3NJOHZWUkw5WWhoZ0pxMkhiZkRmR3I4S2t4RnNENmpNRWhQ?=
 =?utf-8?B?cUdyb1lFakNIZkRLOEVkWVRKc2dFSjdrd0VkWEV6cGRlcVZIUWhrVUQ3YTAw?=
 =?utf-8?B?Yzl3cVlORmMyMmhpOUdHMlhqNlhMa1Q5Z0JsUWduWitjbjBKZVRnWWlQL0RV?=
 =?utf-8?B?cHNKazluOUhhdW4zMERyZ1lCaVpTK0RmVWpMNDJjb0diU0FNcGE0Z252T0s0?=
 =?utf-8?B?SUhnenB5VkxpWUlUbW5sN1Q3SnlzVzhxaU4vOVhtbjBHS0dBbjZ0eERjanF1?=
 =?utf-8?B?a0F3ejlnM21RVUFBMVdWNHEvaVBQM0V0SjFqSi9DenNNb0xIYTVSbnVTZUc4?=
 =?utf-8?B?K2lkYnZHZnhaYUdwdXg1RDhtbm9ybEE2UFVQU3FDVWlMSGk5T0c3MG53Qm9W?=
 =?utf-8?B?UmN3M1VjTmo4UzQ4QVByZ3lmcEZmUjMwRkdOekF3WnRJcElHMTVRb2Y3QUx5?=
 =?utf-8?B?bmpJSTZna3VMWm9VUS9aTFR3UmJKMTZPMml1K3Y1bUx2dDJ5U1MwMUR0cU5u?=
 =?utf-8?B?YzExeVlPZjFaSHJaSDRQNTVzNzBubDc0U0szVmJ2VUw4NFU4WndLMnZadjlZ?=
 =?utf-8?B?bjNKN0Q2RFc5ZWt1ejh6YW4vNGVDTmVCbFp1cXkvdk90VCtmRURxVjZFSlVt?=
 =?utf-8?B?QjFXQXFBdDJVNlQrK0M4N0dwUlpnZ3E0UGxLUWlDMnFrZGVJeHJvd1RyNm5z?=
 =?utf-8?B?MTNqbUFlNUtFK0R6d3lvcmNWNnVMZDRvTHROWVQ3YXZQSnJIcEhyK1hBWWVq?=
 =?utf-8?B?YktCRTZGb29ua3F3c25CODV1YkZFSWpQbFZRU1VBaFQyOS81WGsvbHdkWmkr?=
 =?utf-8?B?Sm1naENPcVBLKytkcHRrbjYrQ3FlNm9TQTBKNGp5Q1FGQnkxQkY2SVpPZTJz?=
 =?utf-8?B?Z3h4QU1KSDNLUWQyWFdhSDZMWTc3eFJRZFo0dVMyOGpuc00rbGJpQWNOUUJn?=
 =?utf-8?B?emdNcHFxMGpyakVqNUIwUmN1UFpZTEpQQ3VMZ3h4VDgzUmpxM1NmaU54WUpy?=
 =?utf-8?B?QzgwcnNmU29FWitOc2JrRy9QaWplRVVuZXd2NVFuWFpHSktJZ0w4cE5aOWt5?=
 =?utf-8?B?S0FMSGEwNWMyT1ZRNnJUMU1aTXdGV3BqWlJUT3UyZGtCallvYXVKaW9KbmlD?=
 =?utf-8?Q?I5aqsLzCm7Q=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 05:48:25.8716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca4d8ee-87b7-478f-144c-08dcf25d25d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8780

The upcoming new Idle HLT Intercept feature allows for the HLT
instruction execution by a vCPU to be intercepted by the hypervisor
only if there are no pending V_INTR and V_NMI events for the vCPU.
When the vCPU is expected to service the pending V_INTR and V_NMI
events, the Idle HLT intercept won’t trigger. The feature allows the
hypervisor to determine if the vCPU is actually idle and reduces
wasteful VMEXITs.

The idle HLT intercept feature is used for enlightened guests who wish
to securely handle the events. When an enlightened guest does a HLT
while an interrupt is pending, hypervisor will not have a way to
figure out whether the guest needs to be re-entered or not. The Idle
HLT intercept feature allows the HLT execution only if there are no
pending V_INTR and V_NMI events.

Presence of the Idle HLT Intercept feature is indicated via CPUID
function Fn8000_000A_EDX[30].

Document for the Idle HLT intercept feature is available at [1].

This series is based on kvm-next/next (64dbb3a771a1) + [2].

Experiments done:
----------------

kvm_amd.avic is set to '0' for this experiment.

The below numbers represent the average of 10 runs.

Normal guest (L1)
The below netperf command was run on the guest with smp = 1 (pinned).

netperf -H <host ip> -t TCP_RR -l 60
----------------------------------------------------------------
|with Idle HLT(transactions/Sec)|w/o Idle HLT(transactions/Sec)|
----------------------------------------------------------------
|         25645.7136            |        25773.2796            |
----------------------------------------------------------------

Number of transactions/sec with and without idle HLT intercept feature
are almost same.

Nested guest (L2)
The below netperf command was run on L2 guest with smp = 1 (pinned).

netperf -H <host ip> -t TCP_RR -l 60
----------------------------------------------------------------
|with Idle HLT(transactions/Sec)|w/o Idle HLT(transactions/Sec)|
----------------------------------------------------------------
|          5655.4468            |          5755.2189           |
----------------------------------------------------------------

Number of transactions/sec with and without idle HLT intercept feature
are almost same.

Testing Done:
- Tested the functionality for the Idle HLT intercept feature
  using selftest svm_idle_hlt_test.
- Tested SEV and SEV-ES guest for the Idle HLT intercept functionality.
- Tested the Idle HLT intercept functionality on nested guest.

v3 -> v4
- Drop the patches to add vcpu_get_stat() into a new series [2].
- Added nested Idle HLT intercept support.

v2 -> v3
- Incorporated Andrew's suggestion to structure vcpu_stat_types in
  a way that each architecture can share the generic types and also
  provide its own.

v1 -> v2
- Done changes in svm_idle_hlt_test based on the review comments from Sean.
- Added an enum based approach to get binary stats in vcpu_get_stat() which
  doesn't use string to get stat data based on the comments from Sean.
- Added self_halt() and cli() helpers based on the comments from Sean.

[1]: AMD64 Architecture Programmer's Manual Pub. 24593, April 2024,
     Vol 2, 15.9 Instruction Intercepts (Table 15-7: IDLE_HLT).
     https://bugzilla.kernel.org/attachment.cgi?id=306250

[2]: https://lore.kernel.org/kvm/20241021062226.108657-1-manali.shukla@amd.com/T/#t

Manali Shukla (4):
  x86/cpufeatures: Add CPUID feature bit for Idle HLT intercept
  KVM: SVM: Add Idle HLT intercept support
  KVM: nSVM: implement the nested idle halt intercept
  KVM: selftests: KVM: SVM: Add Idle HLT intercept test

 arch/x86/include/asm/cpufeatures.h            |  1 +
 arch/x86/include/asm/svm.h                    |  1 +
 arch/x86/include/uapi/asm/svm.h               |  2 +
 arch/x86/kvm/governed_features.h              |  1 +
 arch/x86/kvm/svm/nested.c                     |  7 ++
 arch/x86/kvm/svm/svm.c                        | 15 +++-
 tools/testing/selftests/kvm/Makefile          |  1 +
 .../selftests/kvm/include/x86_64/processor.h  |  1 +
 .../selftests/kvm/x86_64/svm_idle_hlt_test.c  | 89 +++++++++++++++++++
 9 files changed, 115 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/svm_idle_hlt_test.c


base-commit: c8d430db8eec7d4fd13a6bea27b7086a54eda6da
prerequisite-patch-id: ca912571db5c004f77b70843b8dd35517ff1267f
prerequisite-patch-id: 164ea3b4346f9e04bc69819278d20f5e1b5df5ed
prerequisite-patch-id: 90d870f426ebc2cec43c0dd89b701ee998385455
prerequisite-patch-id: 45812b799c517a4521782a1fdbcda881237e1eda
-- 
2.34.1


