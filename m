Return-Path: <linux-kselftest+bounces-28349-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 043F7A520B2
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 00:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82D6E167620
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 23:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632EC1A5BB2;
	Wed,  5 Mar 2025 23:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iOVJofYy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749B02E337F;
	Wed,  5 Mar 2025 23:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215626; cv=fail; b=TFVr4wQKT0Up/8UAT2bW9MiDocp2Y/UCwunWEMicHs/qi71WUK8nkvrBJxLq8jNilE1h2r3sUOLbEBWvnbuhApJxf4UzpBxmk26WaIYsG4D/ynnQzFU+PgHbBgjdONyDbvaR25n/FqeGVdUMuVLH2+fwzawrDBUopFDASKbdk9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215626; c=relaxed/simple;
	bh=Ld2EK9b1QKSfWFJN4YROc5FLb6ZnjEgFxoQWDLfbJqA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U4iK3xjEBjeC8TOWtdGRmyg3KenrHVyrW7p5DovSmJUyRfXfFZD0HR6hJsrFyw6u6uOp8PD0QnkWuKK96vpva1eeSME+wMcCgQEW5F3O6E0wzdnmBltF/jauIukPsTa+2jkrT9lMF6IOtgxyMdsrBF4U5mgaZeqqocH/H/tFBls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iOVJofYy; arc=fail smtp.client-ip=40.107.244.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=USPaOuRYB6037LvCizlNDL58eZCgUSip9iPrDCLbwU+CVQS4bplcxKjuZ12+2nb+bQUMwMJSfuc2lUSCwFnN4g7URxHABIlwyFz9HLuLz14SGNRIOBlYOJuAb7ZNYnKEo4Beer8EMGaT222V4YquJOyvW8JR6f7+RLbOmEmPoTSFgrruHvKfxazMjkZUcxgWm0vy6BFmEc+RZBAcTIIgySdmqJ15980/6dgE3lAodtpeKaoOKAc6EdxFG/sIn/fBeoQJ+IRbwlYiyccVwxrRyEtNouW0dkq5ztf0t1FrcRQ+kE+fAUr8zWJKEGN+p9JSi0khVmv/plCmp2R4yt+Czw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zefVbbJxct/7OPK4dczgpZt66ypwD8vLHohwakMeWzk=;
 b=cF1kGbZpJ4u2ELIRKHWFju4fWdGQClWSJpUESwTHDhjdSv4OgX4Xwq+LdWSrFhCh4tk2WphG0UOuWWplCgNgxqmZ2oyUm49gDUYepNgr6+9q3UcMCv6GLJT8oJhDDm5knGQYrzQcFfuoWpGcb/BcbZ09t500EMohUmhPz9SDMBC7mK17a4sXf3ey9wiTS++JJqpoQo+QjFJyUwiSf33rscdf9TmiVSLdni3eoQJ7O+x3BWyUYCkQ70m+ILg0f4FYQhTCcGnjNj9JhQg+bnqokhV1aHEqMYoTMWr9UPlQ1MOBuCc3vCH9AhXx4tk5w6nv1NfcNgy2mZZeusxM7lwnPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zefVbbJxct/7OPK4dczgpZt66ypwD8vLHohwakMeWzk=;
 b=iOVJofYyTBeNyduSu44MF0KYf9SQ4/P0Oe7evBBtXeawkHU1lum2jEsSWn+ta43gewhSUChTuQyh1L3dRN5Lh1MwE8hr2NP4a3wQqq/OAaaT+UolZG+NCnQej27epJhcrHsO3ajWYkzYvYyBt3rlrKi0Vozf+UMWGScJbj0yT+4=
Received: from MW4PR03CA0149.namprd03.prod.outlook.com (2603:10b6:303:8c::34)
 by CH3PR12MB9283.namprd12.prod.outlook.com (2603:10b6:610:1cd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 23:00:15 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:303:8c:cafe::7c) by MW4PR03CA0149.outlook.office365.com
 (2603:10b6:303:8c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 23:00:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 23:00:14 +0000
Received: from zenon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 17:00:11 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <thomas.lendacky@amd.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <shuah@kernel.org>, <pgonda@google.com>,
	<ashish.kalra@amd.com>, <nikunj@amd.com>, <pankaj.gupta@amd.com>,
	<michael.roth@amd.com>, <sraithal@amd.com>, <prsampat@amd.com>
Subject: [PATCH v8 00/10] Basic SEV-SNP Selftests
Date: Wed, 5 Mar 2025 16:59:50 -0600
Message-ID: <20250305230000.231025-1-prsampat@amd.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|CH3PR12MB9283:EE_
X-MS-Office365-Filtering-Correlation-Id: b65793b8-4e22-4c13-775c-08dd5c397d98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3pPmNIjf5u4fAQ48Yd/voQaaH1qihD/OJRt+c3McVHwk0STCXS9tDd+e0I+k?=
 =?us-ascii?Q?EEzVKPwQEsV2Qf+dNGbrgcuCeWf/pjgZR1jW2UUC5Sx2wpsk0dLHdtKKoHDt?=
 =?us-ascii?Q?7Muchb97JD89//OxPrmwlTWA+UI9jI8yWwH18a0E6X0MPHxwS0HLABT1izZD?=
 =?us-ascii?Q?2wZ3DnPjGoKTLVyk0egwmw2A4MJCCv/PRYcrnwEM+qduO1PNOPjaCpkYd1Kq?=
 =?us-ascii?Q?6MZvCPqOx7qdpgENfgNI/R4srP6ATEsVBBOZZNQXsgGGXS8B7RxbRimXERXL?=
 =?us-ascii?Q?JfYLRJZYrfnjoH48herMGKp1/1lGYbp6OqbBWOlMlakCae4Iq76sa559NH5x?=
 =?us-ascii?Q?Nw5wUfXjNYemnJk3pMvtG0G7UzAuf8T0YI2xLw/8+z/Jzq/lvdXPCraoU2Qy?=
 =?us-ascii?Q?0LcgLDaU2btEnMHMHCHk+16zWjC5i0J8kj/tW3nn8CVUoMM6ZdsPunEwgj3k?=
 =?us-ascii?Q?K5xU1prtVdTHFJELTLYhrdIhKRHTbBlEw+1UJ1JLvF/FxPJkZvpW2cdM4Vth?=
 =?us-ascii?Q?q8hSRSItCDpK2D5CAVou5x4dIuM83AX3JEUW59JgWBd2Z0j3yvRlfkoS4kww?=
 =?us-ascii?Q?9Bl5c91ynqm8IF/HVfINqraYyecwaoJS1jhO8/OnEwHukgiB8QfQeYfD8TrU?=
 =?us-ascii?Q?0QH4AcXIsRfRETM7FY+BchgLEjJ4HdNsTnNbDrKOmyNAM6bROzFJyhiqJA3U?=
 =?us-ascii?Q?rwKNJcqf6MZix+1KwR8Ur2GT0XY3X/asPhRZfxXWy3hNHgn7iII6rxypkN1d?=
 =?us-ascii?Q?dQGc2KiAt/VU7CVVjQf22/LSYsK6N1gW1xZWxnzYpRdAs3H++cm1UHW3yEIT?=
 =?us-ascii?Q?eeMwseS9v8Z37mfdeCLitGW2Mt70Fg36G3ghpXjSlg7K/Kqe/1fbfJMSdLNu?=
 =?us-ascii?Q?svtdIZSYbPL1P2LcQq/DzKFniqqBBcJIBr6150VCB/GFoZkek+UkbODlK6JV?=
 =?us-ascii?Q?XaSCovxF6S9g3x+dyheoBcCYa13glC9cpjG+MR3X0TMMeIvqKb4EsILYl/cH?=
 =?us-ascii?Q?gN2JvTHNt834vtya6FhiuX7B/VQnRD6ayl7L71xVna3/qtWwGnrSDczZBTc8?=
 =?us-ascii?Q?fzf0bVvKt+Tbj09RBTDGW7fkuvySecTJbA7EFpX7sXjIS+s3rPZCeRzynlhb?=
 =?us-ascii?Q?HkZBjbNo0bpUjOwP4HP6mjpXv1/KQlrsMqE8bBJbbgJxKF1zr+XhKMQ/M2ip?=
 =?us-ascii?Q?/JnyfoeytxJbDFyhkr901S/qj+8NCf5pKE1KDTUPPFaeiygBg6El5orqSDDA?=
 =?us-ascii?Q?vJ/mHgzGpz2Av88bIosuzHY6dIYVmASa5v0WP6vsCRhKTDDJgs80SFIPN5iv?=
 =?us-ascii?Q?fwSyeJZkU99R/wUfPvVSG1DYNYLYF+HTdN5OsAjcXAMuDNoljMROToz20GMR?=
 =?us-ascii?Q?rm4S2CI22LLm9P7yl6pzeWUOTq9qJMO1U+rU4vEW4RJ0rfw94yqga9X/4TZb?=
 =?us-ascii?Q?a+SPJe5use708hEOCaU4TL8w58a1qbzB?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 23:00:14.4794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b65793b8-4e22-4c13-775c-08dd5c397d98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9283

This patch series extends the sev_init2 and the sev_smoke test to
exercise the SEV-SNP VM launch workflow.

Primarily, it introduces the architectural defines, its support in the
SEV library and extends the tests to interact with the SEV-SNP ioctl()
wrappers.

Patch 1  - Do not advertise SNP on initialization failure
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

v7..v8:
* Dropped exporting the SNP initialized API from ccp to KVM. Instead
  call SNP_PLATFORM_STATUS within KVM to query the initialization. (Tom)
  
  While it may be cheaper to query sev->snp_initialized from ccp, making
  the SNP platform call within KVM does away with any dependencies.

v6..v7:
https://lore.kernel.org/kvm/20250221210200.244405-7-prsampat@amd.com/
Based on comments from Sean -
* Replaced FW check with sev->snp_initialized
* Dropped the patch which removes SEV+ KVM advertisement if INIT fails.
  This should be now be resolved by the combination of the patches [1,2]
  from Ashish.
* Change vmgexit to an inline function
* Export SMT control parsing interface to kvm_util
  Note: hyperv_cpuid KST only compile tested
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
  capability advertises the presence of the feature. Retain the minimum
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
 arch/x86/kvm/svm/sev.c                        | 30 +++++-
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
 12 files changed, 261 insertions(+), 60 deletions(-)

-- 
2.43.0


