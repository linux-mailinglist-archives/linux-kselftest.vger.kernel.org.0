Return-Path: <linux-kselftest+bounces-42091-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9329DB944C1
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 07:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 482A33B9A92
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 05:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F58D25B662;
	Tue, 23 Sep 2025 05:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xExgqafU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012034.outbound.protection.outlook.com [40.93.195.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8787378F20;
	Tue, 23 Sep 2025 05:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758604202; cv=fail; b=kermrXnTNh97v2qqOBvui4APg+0X83wt08NrA2fkYnBkl0EURofQSt+dhwaVASf+6k7U0uMhO52XeUGX/Cti8QQVnprl2ecDIy0cAbro+1KNT1ACtr0SVI97yOOLZgr6VjUiqvG+EmtkHCpyyTw3mYFI8EEzGqVsYo846tuBCbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758604202; c=relaxed/simple;
	bh=+HVIXJuVeBs0oQVOygluw6xkQgHQ+Sdlnyzhgm9cCM0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=krRJ7A7xlrUeFBEeHmOTWzuxDW7GrdLWmfBYwLxexZUwtNY14CBGWykQxb81je6c1/F7AqD6FqDXa4k4SXGVcdCgOatvbi94WIqcoUqdkUCIfae17VWgQUjFVngKfJ7KQs8FjjPb6Kk26MmgK+6KWgbZw/PzwCYNRChTUeLxQy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xExgqafU; arc=fail smtp.client-ip=40.93.195.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLO9gT1mDSbarJDING27QetTGXegqBhIrSKAU8F99wHzmzuKps7OiC1mo8C1s3IBARDuxt/0huwmWeOkhMIS3eK0irW1+iy5z5k7IygIs59pFapySZOrVP6lOuhZ9Ld3O5KTfkKPRaDNazkXUPDmvRkDNhkk/BUYswqCAOUUyluRAFjGQ5SjPSuwD4tRh9kZT9Wyc/5MfkzWwg7IugtvHPvW7hARi+dCKO0nL7ox7oUZffX7dOjqG+JeR566H+hY0L3MfoSI8wt4Gp8BImB3xAF95PR3Z1NtM8XfRh8mrCf8Aq3pGjMIQ8xOEnOkGWyelFP15aPmTPMVBzc0RsF5Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvPaGZwIwnhy3Alm8YPuoiO7NpudanBtamckycDvePo=;
 b=IbInj1grebLXqkI5xaLIdloK+u9y+JBlmYDgzwboPoPnFrKAiChpeuBGmTGsC8A+0Gi6jEeAtgwABEJi5J1IPNsVQV0OcNj90DLYQgTaQpAwk9Iwi/57xCtVjoCLIijsc+Bs2oT/e4NpvLV568EVrttr4ylyshvbHP2o/f4YYFSve3MqXA1IqO/7Edixt1tPhKnVZbZOMb6XIj5x3pKAj04QECDGiFJcizsV5Vm88jDcJ+PPOxHvQF1k+zUuPg5cTVyVwfehUhPmTNN4VlWPANYLIBc6QK4eo2QdHbEQ+iX9SnQpLBTnsZTqtkJTQVHrUK4Wzh0YFIUdpXBryXaTkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvPaGZwIwnhy3Alm8YPuoiO7NpudanBtamckycDvePo=;
 b=xExgqafUGPQFQa1Fkn1snUdtJqJfI6umC6VepjPy2I7Nh1X14j6tT51cYKsFOpvP711S/PHszJaRiveaVPUvV8f4iWJzQpQmay5P5SGMvhdmq3VZT8xH1wM3YKpRwhEG2/bkbImu5bAjARxNQ+u/BfIs4DzXn3XOg733kQwUUkE=
Received: from CH0PR03CA0424.namprd03.prod.outlook.com (2603:10b6:610:10e::21)
 by CH1PR12MB9597.namprd12.prod.outlook.com (2603:10b6:610:2ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 05:09:56 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::b4) by CH0PR03CA0424.outlook.office365.com
 (2603:10b6:610:10e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 05:09:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 05:09:55 +0000
Received: from BLR-L-NUPADHYA.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 22:09:50 -0700
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <Thomas.Lendacky@amd.com>,
	<nikunj@amd.com>, <Santosh.Shukla@amd.com>, <Vasant.Hegde@amd.com>,
	<Suravee.Suthikulpanit@amd.com>, <bp@alien8.de>, <David.Kaplan@amd.com>,
	<huibo.wang@amd.com>, <naveen.rao@amd.com>, <pgonda@google.com>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>, <tiala@microsoft.com>
Subject: [RFC PATCH v2 00/35] AMD: Add Secure AVIC KVM selftests
Date: Tue, 23 Sep 2025 10:39:07 +0530
Message-ID: <20250923050942.206116-1-Neeraj.Upadhyay@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|CH1PR12MB9597:EE_
X-MS-Office365-Filtering-Correlation-Id: d4210491-c5bb-4d34-2927-08ddfa5f6fa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EuSP+qgkuHu81JU+rjAlLia6Y+6YnfmQFc5c9p4KbjsXNYtKlGJA1cCN5vVM?=
 =?us-ascii?Q?05hs4C7shG7rkfa0HTnMteXwx3EREw5fu0IZx9a4Txu1rermB3tl+Cdqi7r9?=
 =?us-ascii?Q?2fPy0V/xR/5eC4tlOxyas9RTRDDyiNqUzodQ6BdavAr9s3wRhLGdb15YiRWY?=
 =?us-ascii?Q?XJcsF00YGBRN6AIdMJbvb+A3ayL8s3KNhGs6SxgJFx53DMTVdK9U0USaPLZR?=
 =?us-ascii?Q?i7w0Y4JvzFdqDb/PpL7Q/3GS2LyAaGLzN5ZB22KPAueKEN00LamEiPK0XxjU?=
 =?us-ascii?Q?TD9wWA97PjlkixAhrSpEMv5wRIwo26NQ+8E6V85xOEjByWwKnEK5RnD9+U5Z?=
 =?us-ascii?Q?WutZRAB05e5pY+4lp2EqfBslUL4qVUkcdsD1KjxV/WLgEeqneIgXIZroxMKT?=
 =?us-ascii?Q?AWhP61Cp18r3+zndwQ9m155Z1vAbluiiNAO3VEZWK/Nxh2IGO0P67G6f6xpw?=
 =?us-ascii?Q?6CTdm9hpIOeqUC5PFdKzxSD0QuYFIug/VrKbRffy5uqG9uS38QRjwq0yK+30?=
 =?us-ascii?Q?iDZM/XR3HbMglV5JnrBkBZ9o64w5blkYhLL8FPCPt0l4rMaYj9mCv2hWhXrM?=
 =?us-ascii?Q?3wTOHddvvSbkL1ncKplFQRrzQuhxO3jymBRlGHnUXq4p2e3F8hpiI8si8s39?=
 =?us-ascii?Q?z3eV27/K2h9cVTKfyhc2tRZLsb1Dti1k5Kx+d43DuTZIkCN9wvc3EgcDwnL3?=
 =?us-ascii?Q?UCmaA3IkQi4LiVoROlVP7iftf3yElChE2Wk4C4SXIfRaoCyjFJTBiLqRpa/H?=
 =?us-ascii?Q?frCYDJ3ZSzoKQ/avQcaNmSmdgNp5LpewYBgFYCkmjk64NNkDt7tIYE0WSvQe?=
 =?us-ascii?Q?qRnj3tntqvGsd3HYle5R5EHCjwyzFHfi8KfyOlOVOt89+OOZEmZgJxm12yWh?=
 =?us-ascii?Q?0v1WcbI6wO6WGIVGN/14z6IAb7CvG4d6PHt++nc8JlqIh8vbmOAV21ILq4c4?=
 =?us-ascii?Q?971NSjMTvcCOApvCKW1pDBKjhgaCNTlfhZPJZUR3Zc30qoQphEQ5pCK5Mkt+?=
 =?us-ascii?Q?92y4RRAsaM6/x2OK62HsEnq55VO9rIXq6f+yTnA7b+hKwmLzPSEjgExQRT8m?=
 =?us-ascii?Q?nIwBt70nIHi2+p1bUIHzZzRYCQbS2wZgDJQZz/pDeZ10u6pd8Mbq+XAFai2J?=
 =?us-ascii?Q?jQM2iS7w22amw+LtHnpaIk1Q9Ai27jdXf6ChAcd73WzquEvlQD4Kyv7YQKxM?=
 =?us-ascii?Q?x8epNc8mUy+pVf9jMdcjFw13Ix1P8DkwXbGdv0pitFo42X8T0NmcAWOLfI5B?=
 =?us-ascii?Q?eDqwr02jE0IOSaTPOAguB0dAZ8tnKYueyPuLj2yuz3m/65rJZ+T6iPq3eZtc?=
 =?us-ascii?Q?+sPuglSIMTLGKSXsFumiuIosj7o5WIwk3X1GxNyukfEPEMDLH14E2zWZ+AQP?=
 =?us-ascii?Q?lHwuHofKhmt5rMJwKmzsbwNQCwRpVs12YfcKcJ1fwGSMzaTyn1fdpU5i7r2D?=
 =?us-ascii?Q?lKp6QiVTuV7cbV3ssWlfc9+MJGg6ohtv9I5bbImiJipO/Kuik7z+QpbmVXYu?=
 =?us-ascii?Q?sEJ1JWeBSKapVCQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 05:09:55.7549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4210491-c5bb-4d34-2927-08ddfa5f6fa0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9597

This series adds KVM selftests for Secure AVIC.

The Secure AVIC KVM support patch series is at:

https://lore.kernel.org/kvm/20250923050317.205482-1-Neeraj.Upadhyay@amd.com/

Git tree is available at:

  https://github.com/AMDESE/linux-kvm/tree/savic-host-latest

Changes since v1:

v1: https://lore.kernel.org/lkml/20250228093024.114983-1-Neeraj.Upadhyay@amd.com/

- Drop Secure AVIC APIC regs test as it relied on KVM_GET_LAPIC,
  KVM_SET_LAPIC IOCTLS. Since commit f65916a ("KVM: TDX: Force APICv active
  for TDX guest"), these IOCTLs do not work for protected APIC guests.
- Rebase on top of latest kvm next tree.
- Add detailed commit logs.
- Clean up the instruction decoder.

Neeraj Upadhyay (29):
  KVM: selftests: Return an unused GHCB from the pool
  KVM: selftests: Align GHCB entry struct to page size
  KVM: selftests: Add #VC exception handler with error code support
  KVM: selftests: Add MSR access support for SEV-ES guests
  KVM: selftests: Skip guest memory checks for APIC MMIO mapping
  KVM: selftests: Add x86 instruction decoding library
  KVM: selftests: Adapt instruction decoder library for userspace
  KVM: selftests: Restrict instruction decoder to x86_64 only
  KVM: selftests: Remove unneeded functions from instruction decoder
  KVM: selftests: Fix missing definitions in x86 instruction decoder
  KVM: selftests: Change pt_regs to ex_regs for selftest use
  KVM: selftests: Add compilation for instruction decoder library
  KVM: selftests: Add MMIO #VC exception handling for SEV-ES guests
  KVM: selftests: Add instruction decoding for movabs instructions
  KVM: selftests: Add SEV guest support in xapic_state_test
  KVM: selftests: Add x2apic mode testing in xapic_ipi_test
  KVM: selftests: Add SEV VM support in xapic_ipi_test
  KVM: selftests: Add Secure AVIC library
  KVM: selftests: Add #VC handler for unaccelerated Secure AVIC MSRs
  KVM: selftests: Add IPI handling support for Secure AVIC
  KVM: selftests: Add args parameter to kvm_arch_vm_post_create()
  KVM: selftests: Add GHCB call for SAVIC backing page notification
  KVM: selftests: Add Secure AVIC mode to xapic_ipi_test
  KVM: selftests: Add test to verify APIC MSR accesses for SAVIC guest
  KVM: selftests: Extend savic_test with idle halt testing
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
 tools/testing/selftests/kvm/Makefile.kvm      |   14 +-
 .../testing/selftests/kvm/arm64/set_id_regs.c |    2 +-
 .../testing/selftests/kvm/include/kvm_util.h  |   14 +-
 .../testing/selftests/kvm/include/x86/apic.h  |   57 +
 .../selftests/kvm/include/x86/insn-eval.h     |   48 +
 .../selftests/kvm/include/x86/processor.h     |    8 +
 .../testing/selftests/kvm/include/x86/savic.h |   25 +
 tools/testing/selftests/kvm/include/x86/sev.h |   29 +
 tools/testing/selftests/kvm/include/x86/svm.h |  109 ++
 tools/testing/selftests/kvm/lib/kvm_util.c    |  109 +-
 .../testing/selftests/kvm/lib/x86/handlers.S  |    4 +-
 .../testing/selftests/kvm/lib/x86/insn-eval.c | 1238 +++++++++++++++++
 .../testing/selftests/kvm/lib/x86/processor.c |   24 +-
 tools/testing/selftests/kvm/lib/x86/savic.c   |  488 +++++++
 tools/testing/selftests/kvm/lib/x86/sev.c     |  581 +++++++-
 tools/testing/selftests/kvm/lib/x86/ucall.c   |   18 +
 tools/testing/selftests/kvm/s390/cmma_test.c  |    2 +-
 tools/testing/selftests/kvm/x86/savic_test.c  | 1171 ++++++++++++++++
 .../selftests/kvm/x86/sev_smoke_test.c        |   40 +-
 .../selftests/kvm/x86/xapic_ipi_test.c        |  183 ++-
 .../selftests/kvm/x86/xapic_state_test.c      |  117 +-
 23 files changed, 4192 insertions(+), 96 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/x86/insn-eval.h
 create mode 100644 tools/testing/selftests/kvm/include/x86/savic.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86/insn-eval.c
 create mode 100644 tools/testing/selftests/kvm/lib/x86/savic.c
 create mode 100644 tools/testing/selftests/kvm/x86/savic_test.c


base-commit: a6ad54137af92535cfe32e19e5f3bc1bb7dbd383
-- 
2.34.1


