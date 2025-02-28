Return-Path: <linux-kselftest+bounces-27842-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D131AA49518
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 10:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 464C91895FEA
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 09:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35172561D6;
	Fri, 28 Feb 2025 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jMhCvcPi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D119A255E54;
	Fri, 28 Feb 2025 09:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740735181; cv=fail; b=E/7orB4MXvSsp3eOa08yCh8IpdpcfNeajN5ZoblAXPGOLGM7fdNqiMUwXS1GqSGy8Xfkyl4VT49OAqDUhnJNs3xTJ/VC0v3KqUDUTWOF8qDAsVVKxv/6oawJYl5q3CN8enI8q6e3amaDDN9acMUdxwvcvbPVdpYcBsGJhX93/Zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740735181; c=relaxed/simple;
	bh=t0HbtgQtp2sGuQHrq6SnXQhFPbIWZ9LGvtw1jYf/zHI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fSQqlpsp2RmVLi7tqIiOV2NHGGAxMJ+zNea1KLtxSniq884P4Uiv+X0ES4rFphOITLmhZw1eRDmRUhHeZz/KnnTOCZVIE0VO968aFn55qPERFVwLfm8WaDmbasT4/GW/revrFzewAvmV1KXWSaXTXvy/bsW2PEfruZ29jLw96oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jMhCvcPi; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xhgwDsgUmg+C8WFrL7WWv7mXhrIfDJOzaiZwUXpYXnTLzisQQ9u5ju46ZOgd1p02szSJY8Jq41RVrNstNvj+zYE3k/lWjTWPZhKsMP9vGwZgiHUz2h+sfYGMxpFYNPSscFILXVjTa1m87wKkVG9MqwEVhLDzWW+nrSb6mInqlZz2bG5hbHz7r4rIj9HiV4pPb/mk071ta4eirnfpEZ6eZi4JoXso0A/VzeKJ1IgcWJ7o+wnu0KZGhknmk9GCGd6z6Gu5Ltf94CVuU3JLDY5MRpA8Fa70iwZnK41x/jc7MVYNqD7jd/hfpzgyHZYuIfJ5gzDbiQV/mpKRlNJTc2IGPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKSgyK3/rVa8a/HUOQyhXrqjKaleFc3EevLQkbq62js=;
 b=o0XubuSVJPqNgEtEyU6ujvY/s2da9HDHr6dMA6S6kyjAgFXpfwR17Wy4D1BJrxVDDrbjK5MGLaCp7k19AB9gafje2hhUoQ/yCorcf1FqHyIxk2y+yyVl8jOaIjuSa/XMd7sez/vjXDe+yO99sluaG83U3zquXXvQ9rSd0L7/v1if16enQ9ZKFj+OY6MgEgwji9Ka8xYuzk8j6w/HAK/nnNffOGQGDD/BhYu5vAsqNJyufHmE2E0nLx5bZYMsWF8Un307gr1yi0azgK7zp+BkOgTw2p8U9R8YMPJVDhxBw5xZapSe33T1pSed2sMl1iiUbG3jHFUiB4ysX3kYTh3p4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKSgyK3/rVa8a/HUOQyhXrqjKaleFc3EevLQkbq62js=;
 b=jMhCvcPiILw0qIfAbSIE2K1oMScUXpgLJuLvC+X9jthhIxm2MJkdQOoGbKd+RWRnLe4I7A0OsAY/c7ut0Yksiz613J/w5Ad6lkgiODy+UgtNUrK38sE4tCx+Npm0nwmgKvb5hyn4yO8R3IewdJbtf8mXTvMObXlXU5k6PQYouCo=
Received: from MW3PR05CA0001.namprd05.prod.outlook.com (2603:10b6:303:2b::6)
 by PH8PR12MB6889.namprd12.prod.outlook.com (2603:10b6:510:1c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 09:32:52 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:303:2b:cafe::f1) by MW3PR05CA0001.outlook.office365.com
 (2603:10b6:303:2b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.10 via Frontend Transport; Fri,
 28 Feb 2025 09:32:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 09:32:51 +0000
Received: from BLR-L-NUPADHYA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 03:31:18 -0600
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>
Subject: [RFC PATCH 00/31] AMD: Add Secure AVIC KVM selftests
Date: Fri, 28 Feb 2025 14:59:53 +0530
Message-ID: <20250228093024.114983-1-Neeraj.Upadhyay@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|PH8PR12MB6889:EE_
X-MS-Office365-Filtering-Correlation-Id: ff96724e-daf7-447b-0523-08dd57dadf6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RoRxdPefP4dM7DHJ9DeJLkxXrNcWsLZxZmD49P2cRwhXBKXexeKyQx8Zn4SE?=
 =?us-ascii?Q?JYzQ/sfFBGoAGlcsoFeFUcXulAtRuL/kypsolRXNpXhBOyVHy9qMj10udKtW?=
 =?us-ascii?Q?n40pU7rQimOK1qx+Holl7woOfYY2zRY5su69CL6qbr+iTpvzcb5X57YRW3ll?=
 =?us-ascii?Q?ejFNZ2bGj5ir8ixM4JkBNvDDqFLUqz6p72G1GvFA6rnoz9+lC8ffesXan4/c?=
 =?us-ascii?Q?gnf0cwyo7cMEXuBAiBPuuhJKzJsaXoJbbIv9VrtoD9cHWfh7E0TvvMrkUOkp?=
 =?us-ascii?Q?nckSypRZaU7zsh7AqR2deVgfhqKsZ9fV3f7dDX6om9Qw0wUYY19Y3cN30yQ7?=
 =?us-ascii?Q?QyRniYsMZE++iMCdAVKa77mpNeuTJ+/eQ8TaxvaDpOcLynuvOobTscnCgMId?=
 =?us-ascii?Q?Du9NP+GLrBWiwGrHC5Kv5e1umLaqjq9pxmyYneRveuNPC7jRm7ZZB7jEtbJ4?=
 =?us-ascii?Q?xAtVaqhOHFWTiose3Np4csvaVAskTS/H29IAtbwXjDv9siTACSgoIuuu3SMp?=
 =?us-ascii?Q?DI5dEG6UaAvJeetZL4MJ4usZPUgGXq5gP4Xy0pLMBMmIwF9gEuR0YiiNiedw?=
 =?us-ascii?Q?ibroPkPfmGpr1ZMwCyGG2tMzFXcxtu1CFcCdA6othoPDKwzlyIX0fz7nx32T?=
 =?us-ascii?Q?/41E7mna1Dzh001kji97jOMg+Da9ZJt3PhyU22fMHGCUrfu6dcuElq7XR7LK?=
 =?us-ascii?Q?LguXUlcwJwHd9kDFps5ZRd6MJxaDYJWDhy+5XikYChYe4+GMg70GekL4bRE9?=
 =?us-ascii?Q?oTNE0q+qXA5cAAqm/YBMP5/xntID/A0YWSM4/bPgRKVemnC1l9EVB31leSaA?=
 =?us-ascii?Q?zWhBjpvs8Q4v2I+HQ03jg7MJKDHv29QBsFXB6wC6xWVoRL4+i1ZfmTIX3AAj?=
 =?us-ascii?Q?Y5t/m4NbafdON6FZkpureCdpnTo7brLvEBVlfTfPopZQa2JqelhJVdPdxNjr?=
 =?us-ascii?Q?/wTIeOq/tZVr5+WD3pZFF7/ZNV1NAQAoRftjNEKa7xxnH1QLpYuYAa263FGf?=
 =?us-ascii?Q?MgUDAsJFxYWDnCJ7nh+rLi/W2MN9UYBCOHkGgX2FD9FMUUZ6MraLpFgwxgmj?=
 =?us-ascii?Q?CZPXYo6vAwXFnhWDH7uZkLhE974jN3Ytpd+iABkeVg1/2eMSeWXETPZ+9lOq?=
 =?us-ascii?Q?jGtXAjS5XeXTzGEW6//K7cA2yEPASg+nk3rCaB+tBvgRY7yyyCWg3PmM9sEh?=
 =?us-ascii?Q?CCqNbyukmEcoEUD+CCnQGcjbZIybOvbrkwrgj0cx+0kPhx1dQ1q6Lqr6IGtK?=
 =?us-ascii?Q?FnKycwdWm+mLixJH6ftRFFrHqlymq02Hw6op9oHywBo5QZipHv+7G5wKTxoC?=
 =?us-ascii?Q?5GPmP9N2TECCcfVUXvDXbsQ07WM1fW30DbE4ySKO9mY7jI16v1npfsAysRQl?=
 =?us-ascii?Q?R//OKMIBdbu2nR+ppguHd1FiOlxx0WXZWDkPkVJrB2fSb9obzw6BIe+CRjIa?=
 =?us-ascii?Q?F+XLHUL5VDV3RNXTNuoUoili+7Wqx83a?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 09:32:51.7201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff96724e-daf7-447b-0523-08dd57dadf6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6889

This series adds KVM selftests for Secure AVIC.

The Secure AVIC KVM support patch series is at:

https://lore.kernel.org/kvm/20250228085115.105648-1-Neeraj.Upadhyay@amd.com/T/#u  

Git tree is available at:

  https://github.com/AMDESE/linux-kvm/tree/savic-host-latest

This series depends on SNP Smoke tests patch series by Pratik:

https://lore.kernel.org/lkml/20250123220100.339867-1-prsampat@amd.com/

- Patch 1-6 are taken from Peter Gonda's patch series for GHCB support
  for SEV-ES guests. GHCB support for SNP guests is added to these
  patches.

  https://lore.kernel.org/lkml/Ziln_Spd6KtgVqkr@google.com/T/#m6c0fc7e2b2e35f71da67402036332afeed8c8021

  Patches 7-8 are fixes on top of Peter's series.

- Patch 9 fixes IDT vector for #VC exception (29) which has a valid
  error code associated with the exception.

- Patch 10 adds #VC exception handling for rdmsr/wrmsr accesses of
  SEV-ES guests.

- Patch 11 skips vm_is_gpa_protected() check for APIC MMIO base address
  in __virt_pg_map() for VMs with protected memory. This is required
  for xapic tests enablement for SEV VMs.

- Patch 12 and 13 are PoC patches to support MMIO #VC handling for SEV-ES
  guests. They add x86 instruction decoding support.

- Patch 14 adds #VC handling for MMIO accesses by SEV-ES guests.

- Patch 15 adds movabs instruction decoding for cases where compiler
  generates movabs for MMIO reads/writes.

- Patch 16 adds SEV guests testing support in xapic_state_test.

- Patch 17 adds x2apic mode support in xapic_ipi_test.

- Patch 18 adds SEV VMs support in xapic_ipi_test.

- Patch 19 adds a library for Secure AVIC backing page initialization
  and enabling Secure AVIC for a SNP guest.

- Patch 20 adds support for SVM_EXIT_AVIC_UNACCELERATED_ACCESS #VC
  exception handling for APIC msr reads/writes by Secure AVIC enabled
  VM.

- Patch 21 adds support for SVM_EXIT_AVIC_INCOMPLETE_IPI #VC error
  code handling for Secure AVIC enabled VM.

- Patch 22 adds args param to kvm_arch_vm_post_create() to pass
  vmsa features to KVM_SEV_INIT2 ioctl for SEV VMs.

- Patch 23 adds an api for passing guest APIC page GPA to Hypervisor.

- Patch 24 adds Secure AVIC VM support to xapic_ipi_test test.

- Patch 25 adds a test for verifying APIC regs MMIO/msr accesses
  for a Secure AVIC VM before it enables x2apic mode, in x2apic mode
  and after enabling Secure AVIC in the Secure AVIC control msr.

- Patch 26 adds a msr access test to verify accelerated/unaccelerated
  msr acceses for Secure AVIC enabled VM.

- Patch 27 tests idle hlt for Secure AVIC enabled VM.

- Patch 28 adds IOAPIC tests for Secure AVIC enabled VM.

- Patch 29 adds cross-vCPU IPI testing with various destination
  shorthands for Secure AVIC enabled VM. 

- Patch 30 adds Hypervisor NMI injection and cross-vCPU ICR based NMI
  for Secure AVIC enabled VM.

- Patch 31 adds MSI injection test for Secure AVIC enabled VM.
  
Neeraj Upadhyay (25):
  KVM: selftests: Fix ghcb_entry returned in ghcb_alloc()
  KVM: selftests: Make GHCB entry page size aligned
  KVM: selftests: Add support for #VC in x86 exception handlers
  KVM: selftests: Add MSR VC handling support for SEV-ES VMs
  KVM: selftests: Skip vm_is_gpa_protected() call for APIC MMIO base
  KVM: selftests: Add instruction decoding support
  KVM: selftests: Add instruction decoding support
  KVM: selftests: Add MMIO VC exception handling for SEV-ES guests
  KVM: selftests: Add instruction decoding for movabs instructions
  KVM: selftests: Add SEV guests support in xapic_state_test
  KVM: selftests: Add x2apic mode testing in xapic_ipi_test
  KVM: selftests: Add SEV VM support in xapic_ipi_test
  KVM: selftests: Add  Secure AVIC lib
  KVM: selftests: Add unaccelerated APIC msrs #VC handling
  KVM: selftests: Add IPI handling support for Secure AVIC
  KVM: selftests: Add args param to kvm_arch_vm_post_create()
  KVM: selftests: Add SAVIC GPA notification GHCB call
  KVM: selftests: Add Secure AVIC mode to xapic_ipi_test
  KVM: selftests: Add Secure AVIC APIC regs test
  KVM: selftests: Add test to verify APIC MSR accesses for SAVIC guest
  KVM: selftests: Extend savic test with idle halt testing
  KVM: selftests: Add IOAPIC tests for Secure AVIC
  KVM: selftests: Add cross-vCPU IPI testing for SAVIC guests
  KVM: selftests: Add NMI test for SAVIC guests
  KVM: selftests: Add MSI injection test for SAVIC

Peter Gonda (6):
  Add GHCB with setters and getters
  Add arch specific additional guest pages
  Add vm_vaddr_alloc_pages_shared()
  Add GHCB allocations and helpers
  Add is_sev_enabled() helpers
  Add ability for SEV-ES guests to use ucalls via GHCB

 tools/arch/x86/include/asm/msr-index.h        |    4 +-
 tools/testing/selftests/kvm/.gitignore        |    3 +-
 tools/testing/selftests/kvm/Makefile.kvm      |   16 +-
 .../testing/selftests/kvm/include/kvm_util.h  |   14 +-
 .../testing/selftests/kvm/include/x86/apic.h  |   57 +
 .../selftests/kvm/include/x86/ex_regs.h       |   21 +
 .../selftests/kvm/include/x86/insn-eval.h     |   48 +
 .../selftests/kvm/include/x86/processor.h     |   18 +-
 .../testing/selftests/kvm/include/x86/savic.h |   25 +
 tools/testing/selftests/kvm/include/x86/sev.h |   15 +
 tools/testing/selftests/kvm/include/x86/svm.h |  109 ++
 tools/testing/selftests/kvm/lib/kvm_util.c    |  109 +-
 .../testing/selftests/kvm/lib/x86/handlers.S  |    4 +-
 .../testing/selftests/kvm/lib/x86/insn-eval.c | 1726 +++++++++++++++++
 .../testing/selftests/kvm/lib/x86/processor.c |   24 +-
 tools/testing/selftests/kvm/lib/x86/savic.c   |  490 +++++
 tools/testing/selftests/kvm/lib/x86/sev.c     |  598 +++++-
 tools/testing/selftests/kvm/lib/x86/ucall.c   |   18 +
 tools/testing/selftests/kvm/s390/cmma_test.c  |    2 +-
 tools/testing/selftests/kvm/x86/savic_test.c  | 1549 +++++++++++++++
 .../selftests/kvm/x86/sev_smoke_test.c        |   40 +-
 .../selftests/kvm/x86/xapic_ipi_test.c        |  183 +-
 .../selftests/kvm/x86/xapic_state_test.c      |  117 +-
 23 files changed, 5084 insertions(+), 106 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/x86/ex_regs.h
 create mode 100644 tools/testing/selftests/kvm/include/x86/insn-eval.h
 create mode 100644 tools/testing/selftests/kvm/include/x86/savic.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86/insn-eval.c
 create mode 100644 tools/testing/selftests/kvm/lib/x86/savic.c
 create mode 100644 tools/testing/selftests/kvm/x86/savic_test.c


base-commit: f7bafceba76e9ab475b413578c1757ee18c3e44b
-- 
2.34.1


