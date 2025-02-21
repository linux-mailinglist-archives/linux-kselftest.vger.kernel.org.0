Return-Path: <linux-kselftest+bounces-27224-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 391EEA4018A
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 22:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 111E6420208
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 21:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49151FA859;
	Fri, 21 Feb 2025 21:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ruwszakr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A351D5CCD;
	Fri, 21 Feb 2025 21:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740171744; cv=fail; b=k4e7UWhpl9bGuVw8y/YrsxgFnmWX+uK0b2VHSNz8anfpooPO4Fow35vNLOGgaFP96E7UUIoDxBS5qdtMKJ87l4hD3avcEKdOGE78Z8ciRAX+MkuoJw0StFim9j9ea10my1mcLGruy1fr6TsLD13/hxaY3PEs6TjXF1DmlFlsak0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740171744; c=relaxed/simple;
	bh=h1+R/qTR9AvKT8NJlr1jXy2Dj4bMcNSVf013yJ67g2U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hHP5Z6xWrWWqM0ufo7RDoVEjBX9RRmqm3tHOm7toIT9/RPgi6sDi9TojSmL8KRWymAni5H/bxsiObpD18ZGAqp8Yb7rIyKH5JDKQVKuMOgS+vxFJNH1do0JCnc7a1LbK2zB+yt0Ij34PeN3pUFR368SNc0GXzPk3tEx8CpkQhv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ruwszakr; arc=fail smtp.client-ip=40.107.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iwgIjXuKp40YBDXG7dZxSW83AuhhLq0HATs57JItUkQF+Jwh7GSVUElffDskMb1rqDDHzNtcH1M36VatfJVsaWDzLBBhYpJketR+z0WrdI1tSVIqo8ipxHlKrxRPHG0RWNdqgLUe0cuqs27S1pHGYFQlOWjIRoh6WdZfgO2k480BeirN0MDpVkhVMAyv0Je8rXyWXC+BAQxtk816ksB4hPTpbCPVn1CP82tneJiYaJS0Ud7eY11KJBHlqeDTgu7TXiD79wYbtQoewh6Rr624MjsRM2XJV8dSs0plVhfjVzNDdZnfQHXBWbzJy9M3Lw55iDqzZHxkXZ2tOdnHYrPviQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uCcvNioQycA8xf2YRlpklZT1F+qwKRL9kMknKu8AhM=;
 b=zBQHAZO3MMFDEIALg+UO0MNmqIFNzQQrf2+HnZKA1M8A2HtikGLz+5YZfufY22+aVI8zjS4TJBuyVbWIHSjE9uilqIrfxabTGXapoZHKUfyi4TJaBdko6ZX5B3F4dYILIZgtfSfkPHX1uoXJFYwYQbAUl+XJoyMRgP9SGhq4zShhXh9wdK8UO+qET6TYy7gMulFOgeRS/T4qYekTT3/YcB1IeGQqhoaS9+vb1Ts1V1BoAe6Raeq6wAqGqhHKLj6JRSGDRXL58Jr0294MqFmjQBXOOSH2hks/KKOAyfSj1UcInJM8Fe+YI+YoKyttHL1Pv/IJ5/FOMHis3sco5vEZiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uCcvNioQycA8xf2YRlpklZT1F+qwKRL9kMknKu8AhM=;
 b=ruwszakrLjgOTt8vx/Ox7ZTCBynWAk9QbIKptqmdn+tloj2cWh3tZPpLmrwafvHXzJXiNSPrFOM/cJkUNtsEd42VPZrD79D/mGOb08v4FobXQt/+wgmhbB5ATVAiVp3xMjf02L59VW6IZLBSVNNPRAGK+2xp2Vti9I67uoPdUpg=
Received: from BL6PEPF00016419.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:8) by PH8PR12MB7421.namprd12.prod.outlook.com
 (2603:10b6:510:22b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 21:02:15 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2a01:111:f403:c803::4) by BL6PEPF00016419.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.17 via Frontend Transport; Fri,
 21 Feb 2025 21:02:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 21:02:14 +0000
Received: from sampat-dell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 15:02:11 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <nikunj@amd.com>, <pankaj.gupta@amd.com>,
	<michael.roth@amd.com>, <sraithal@amd.com>, <prsampat@amd.com>
Subject: [PATCH v7 00/10] Basic SEV-SNP Selftests
Date: Fri, 21 Feb 2025 15:01:50 -0600
Message-ID: <20250221210200.244405-1-prsampat@amd.com>
X-Mailer: git-send-email 2.48.1
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|PH8PR12MB7421:EE_
X-MS-Office365-Filtering-Correlation-Id: e7ded24f-8653-462d-c00e-08dd52bb04c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?drHDCsaKzk33TekNx6Ne3GFSaGoOiVzIOjl0b5bWu7y2BMpK8J4Wh647chI9?=
 =?us-ascii?Q?iOBGMCRdDtM5G/VSa3jhdMqn7jG5YOc6z88+BFCt1jE4XrN2jV7Eg4kgEmBW?=
 =?us-ascii?Q?h5Kgl2frla4pyFhz8BIMjXVuDS/fn0H2nLCS7WIu9JKXjSB05rjSOJJIZer9?=
 =?us-ascii?Q?ykTKKPCo+KjK0zswy4VlzeA4aB8c8MQd0KGqUmhmhSZhIUKbaht3OVYZ/Jz/?=
 =?us-ascii?Q?b8Hy4LuwnS2yWBxTl+tASyrxYUxefAdcvjcwwhxqIPBML5wGYcpbGd8gjEaP?=
 =?us-ascii?Q?ltwGipmhvjgXlOUmbxAtCoxF/T/pokpJ01nVwGHpWWRglpxmDOAvZWiUVuxl?=
 =?us-ascii?Q?ewD1pZ8dm91c6cm0Qu+OBxGYJfM4zecOuHS9PiV/J5mfvxUiEk7/HVy5j0mh?=
 =?us-ascii?Q?UeXi6aGYmus46OtlZk102ndQOPqBElF/n8Q41ClYHaSEngd6A/U/4WVuEWsQ?=
 =?us-ascii?Q?FNPlIdWZayKBsgbOzNpKDO9Un8BMjf3fYzzpB+b/t430788Lte1TPReBl+Pt?=
 =?us-ascii?Q?vGK11jioNQe/oEhRKQOsmVCCS+h9QyfPOJeZZSzf/JVygmoF6LeFOQxf5D7x?=
 =?us-ascii?Q?PFV9ykJG9L3Lm1SLWBWWn7SandGLqAFrv4qYDW/zsGCqdo7XnH6swsoDCvJ9?=
 =?us-ascii?Q?WfgSBH6yMUlBhIiKiPhkpOe2eY4m0zcch4U+jStKGdkvkpySZHvFFEUVkCPR?=
 =?us-ascii?Q?uoNCi/f20FTifpu8wa9au505MnLwJw63iw8MDEvavmL+nvgXJ93VYqTx5eVm?=
 =?us-ascii?Q?CMOGef/zsFTmzyNQpcVkupaOtwxP79akn0uZ5N0woKX5M1jw6VCxwEmoVSJq?=
 =?us-ascii?Q?sBVUREwtTzBb9D9s9yW8sXRyW2oiG/ANople0Q2GAVinedgKy1c+3Onhynmp?=
 =?us-ascii?Q?mmcor9Zdkn7DCz1n3stBweW7yebs7hQlrvYcHtWTyHQq0hbv4y2wNGzpdUbl?=
 =?us-ascii?Q?rJDmfOwUfwW+7iYGICY4S5QbHcprI1P9WANNxZvFwtmSUXu1u4g0QLmlaF/H?=
 =?us-ascii?Q?l4sNxDTzqmx0oJwU3OP8WVVxw9J/ULn79uhXXM8FrBCf70a6kUEBPg+LPXh/?=
 =?us-ascii?Q?EcYVgq5AhMVNCoPm9MboA4Tvh3/hAD5XJUjKPtHKr8+HqcWH8QfXZIvEw6jz?=
 =?us-ascii?Q?RcgPUFcoBdONDJFetJYCORLslwtrvukAhUWVOWHnpMjwTSDg/2/1gn8HpRwj?=
 =?us-ascii?Q?8QZY9PNMpuFtdS71bn6XstnCEaKhd7Y2Khukly0+DWBQ+Q7NXinXzsafMPdG?=
 =?us-ascii?Q?fGw2Euc6fcTFOy34/zI5ZQw3/PKw9MZiwRv+V1xou27hlIlmduoNMKlRtXlt?=
 =?us-ascii?Q?+2Ma56d7RorhgeSNWTSGD2nvyiPRqquCPrcZJ5Es+ELT+7gwo1AWxQAm4niq?=
 =?us-ascii?Q?69oo1Bvi9zWqvff2TPeiuYJyHpVMwjWc6tlpQL1OxsURclS/xtd2LllpTRxS?=
 =?us-ascii?Q?Xj+Nh8aKdG7sKzizweYwLXofJw2tp6JI?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 21:02:14.7800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ded24f-8653-462d-c00e-08dd52bb04c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7421

This patch series extends the sev_init2 and the sev_smoke test to
exercise the SEV-SNP VM launch workflow.

Primarily, it introduces the architectural defines, its support in the
SEV library and extends the tests to interact with the SEV-SNP ioctl()
wrappers.

Patch 1  - Do not advertize SNP on initialization failure
Patch 2  - SNP test for KVM_SEV_INIT2
Patch 3  - Add vmgexit helper
Patch 4  - Add SMT control interface helper
Patch 5  - Replace assert() with TEST_ASSERT_EQ()
Patch 6  - Introduce SEV+ VM type check
Patch 7  - SNP iotcl() plumbing for the SEV library
Patch 8  - Force set GUEST_MEMFD for SNP
Patch 9  - Cleanups of smoke test - Decouple policy from type
Patch 10 - SNP smoke test

The series is based on
	git.kernel.org/pub/scm/virt/kvm/kvm.git next

v6..v7:
Based on comments from Sean -
* Replaced FW check with sev->snp_initialized
* Dropped the patch which removes SEV+ KVM advertizement if INIT fails.
  This should be now be resolved by the combination of the patches [1,2]
  from Ashish.
* Change vmgexit to an inline function
* Export SMT control parsing interface to kvm_util
  Note: hyperv_cpuid KST only compile testeworkbench.editor.empty.hintd
* Replace assert() with TEST_ASSERT_EQ() within SEV library
* Define KVM_SEV_PAGE_TYPE_INVALID for SEV call of encrypt_region()
* Parameterize encrypt_region() to include privatize_region()
* Deduplication of sev test calls between SEV,SEV-ES and SNP
* Removed FW version tests for SNP
* Included testing of SNP_POLICY_DBG
* Dropped most tags from patches that have been changed or indirectly
  affected

[1] https://lore.kernel.org/all/d6d08c6b-9602-4f3d-92c2-8db6d50a1b92@amd.com
[2] https://lore.kernel.org/all/f78ddb64087df27e7bcb1ae0ab53f55aa0804fab.1739226950.git.ashish.kalra@amd.com

v5..v6:
https://lore.kernel.org/kvm/ab433246-e97c-495b-ab67-b0cb1721fb99@amd.com/
* Rename is_sev_platform_init to sev_fw_initialized (Nikunj)
* Rename KVM CPU feature X86_FEATURE_SNP to X86_FEATURE_SEV_SNP (Nikunj)
* Collected Tags from Nikunj, Pankaj, Srikanth.

v4..v5:
https://lore.kernel.org/kvm/8e7d8172-879e-4a28-8438-343b1c386ec9@amd.com/
* Introduced a check to disable advertising support for SEV, SEV-ES
  and SNP when platform initialization fails (Nikunj)
* Remove the redundant SNP check within is_sev_vm() (Nikunj)
* Cleanup of the encrypt_region flow for better readability (Nikunj)
* Refactor paths to use the canonical $(ARCH) to rebase for kvm/next

v3..v4:
https://lore.kernel.org/kvm/20241114234104.128532-1-pratikrajesh.sampat@amd.com/
* Remove SNP FW API version check in the test and ensure the KVM
  capability advertizes the presence of the feature. Retain the minimum
  version definitions to exercise these API versions in the smoke test
* Retained only the SNP smoke test and SNP_INIT2 test
* The SNP architectural defined merged with SNP_INIT2 test patch
* SNP shutdown merged with SNP smoke test patch
* Add SEV VM type check to abstract comparisons and reduce clutter
* Define a SNP default policy which sets bits based on the presence of
  SMT
* Decouple privatization and encryption for it to be SNP agnostic
* Assert for only positive tests using vm_ioctl()
* Dropped tested-by tags

In summary - based on comments from Sean, I have primarily reduced the
scope of this patch series to focus on breaking down the SNP smoke test
patch (v3 - patch2) to first introduce SEV-SNP support and use this
interface to extend the sev_init2 and the sev_smoke test.

The rest of the v3 patchset that introduces ioctl, pre fault, fallocate
and negative tests, will be re-worked and re-introduced subsequently in
future patch series post addressing the issues discussed.

v2..v3:
https://lore.kernel.org/kvm/20240905124107.6954-1-pratikrajesh.sampat@amd.com/
* Remove the assignments for the prefault and fallocate test type
  enums.
* Fix error message for sev launch measure and finish.
* Collect tested-by tags [Peter, Srikanth]](<This patch series extends the sev_init2 and the sev_smoke test to
exercise the SEV-SNP VM launch workflow.

Primarily, it introduces the architectural defines, its support in the SEV
library and extends the tests to interact with the SEV-SNP ioctl()
wrappers.

Patch 1  - Do not advertize SNP on initialization failure
Patch 2  - SNP test for KVM_SEV_INIT2
Patch 3  - Add vmgexit helper
Patch 4  - Helper for SMT control interface
Patch 5  - Replace assert() with TEST_ASSERT_EQ()
Patch 6  - Introduce SEV+ VM type check
Patch 7  - SNP iotcl() plumbing for the SEV library
Patch 8  - Force set GUEST_MEMFD for SNP
Patch 9  - Cleanups of smoke test - Decouple policy from type
Patch 10 - SNP smoke test

The series is based on
	git.kernel.org/pub/scm/virt/kvm/kvm.git next

v6..v7
Based on comments from Sean -
* Replaced FW check with sev-%3Esnp_initialized
* Dropped the patch which removes SEV+ KVM advertizement if INIT fails
  This should be resolved by the combination of [1][2] from Ashish:
* Change vmgexit to an inline function
* Export SMT control parsing interface to kvm_util
* Replace assert() with TEST_ASSERT_EQ() within SEV library
* Define KVM_SEV_PAGE_TYPE_INVALID for SEV to use it with
  encrypt_region()
* Parameterize encrypt_region() to include privatize_region()
  functionality
* Deduplication of sev test calls between SEV,SEV-ES and SNP
* Removed FW version tests for SNP
* Included testing of SNP_POLICY_DBG
* Dropped most tags from patches that have directly / indirectly
  changed.

[1] https://lore.kernel.org/all/d6d08c6b-9602-4f3d-92c2-8db6d50a1b92@amd.com
[2] https://lore.kernel.org/all/f78ddb64087df27e7bcb1ae0ab53f55aa0804fab.1739226950.git.ashish.kalra@amd.com

v5..v6
https://lore.kernel.org/kvm/ab433246-e97c-495b-ab67-b0cb1721fb99@amd.com/
* Rename is_sev_platform_init to sev_fw_initialized (Nikunj)
* Rename KVM CPU feature X86_FEATURE_SNP to X86_FEATURE_SEV_SNP (Nikunj)
* Collected Tags from Nikunj, Pankaj, Srikanth.

v4..v5:
https://lore.kernel.org/kvm/8e7d8172-879e-4a28-8438-343b1c386ec9@amd.com/
* Introduced a check to disable advertising support for SEV, SEV-ES
  and SNP when platform initialization fails (Nikunj)
* Remove the redundant SNP check within is_sev_vm() (Nikunj)
* Cleanup of the encrypt_region flow for better readability (Nikunj)
* Refactor paths to use the canonical $(ARCH) to rebase for kvm/next

v3..v4:
https://lore.kernel.org/kvm/20241114234104.128532-1-pratikrajesh.sampat@amd.com/
* Remove SNP FW API version check in the test and ensure the KVM
  capability advertizes the presence of the feature. Retain the minimum
  version definitions to exercise these API versions in the smoke test
* Retained only the SNP smoke test and SNP_INIT2 test
* The SNP architectural defined merged with SNP_INIT2 test patch
* SNP shutdown merged with SNP smoke test patch
* Add SEV VM type check to abstract comparisons and reduce clutter
* Define a SNP default policy which sets bits based on the presence of
  SMT
* Decouple privatization and encryption for it to be SNP agnostic
* Assert for only positive tests using vm_ioctl()
* Dropped tested-by tags

In summary - based on comments from Sean, I have primarily reduced the
scope of this patch series to focus on breaking down the SNP smoke test
patch (v3 - patch2) to first introduce SEV-SNP support and use this
interface to extend the sev_init2 and the sev_smoke test.

The rest of the v3 patchset that introduces ioctl, pre fault, fallocate
and negative tests, will be re-worked and re-introduced subsequently in
future patch series post addressing the issues discussed.

v2..v3:
https://lore.kernel.org/kvm/20240905124107.6954-1-pratikrajesh.sampat@amd.com/
* Remove the assignments for the prefault and fallocate test type
  enums.
* Fix error message for sev launch measure and finish.
* Collect tested-by tags [Peter, Srikanth]

Pratik R. Sampat (10):
  KVM: SEV: Disable SEV-SNP support on initialization failure
  KVM: selftests: SEV-SNP test for KVM_SEV_INIT2
  KVM: selftests: Add vmgexit helper
  KVM: selftests: Add SMT control state helper
  KVM: selftests: Replace assert() with TEST_ASSERT_EQ()
  KVM: selftests: Introduce SEV VM type check
  KVM: selftests: Add library support for interacting with SNP
  KVM: selftests: Force GUEST_MEMFD flag for SNP VM type
  KVM: selftests: Abstractions for SEV to decouple policy from type
  KVM: selftests: Add a basic SEV-SNP smoke test

 arch/x86/include/uapi/asm/kvm.h               |  1 +
 arch/x86/kvm/svm/sev.c                        |  4 +-
 drivers/crypto/ccp/sev-dev.c                  |  8 ++
 include/linux/psp-sev.h                       |  3 +
 tools/arch/x86/include/uapi/asm/kvm.h         |  1 +
 .../testing/selftests/kvm/include/kvm_util.h  | 35 +++++++
 .../selftests/kvm/include/x86/processor.h     |  1 +
 tools/testing/selftests/kvm/include/x86/sev.h | 42 ++++++++-
 tools/testing/selftests/kvm/lib/kvm_util.c    |  7 +-
 .../testing/selftests/kvm/lib/x86/processor.c |  4 +-
 tools/testing/selftests/kvm/lib/x86/sev.c     | 93 +++++++++++++++++--
 .../testing/selftests/kvm/x86/hyperv_cpuid.c  | 19 ----
 .../selftests/kvm/x86/sev_init2_tests.c       | 13 +++
 .../selftests/kvm/x86/sev_smoke_test.c        | 75 +++++++++------
 14 files changed, 246 insertions(+), 60 deletions(-)

-- 
2.43.0


