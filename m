Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6655477A3E
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Dec 2021 18:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbhLPRPP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Dec 2021 12:15:15 -0500
Received: from mail-bn7nam10on2052.outbound.protection.outlook.com ([40.107.92.52]:42816
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231211AbhLPRPP (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Dec 2021 12:15:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8R6v4XQkSALuBPCrv07/RCutzbUIiC9xUEFmbopoRD+xp7EezDQ1wYt4CnhhTvXx2VAnGp8P6flCUVrlaU20Xj72494Q0JF/zhK153e46yNXCDr/6avhRbhsMl1a4h+o1GAbpbYjBpaf9GmNZczu0N1ba2Ia4cmML41foRzFzbU22mW6y1b4iaEgX8/JVoPVDeoPW3zXgmUxsC1XFueniSi3Ni4lyteA9kFRl857fC6n2exJSL2oqAUEQLnBZy2I6AOTr3gCeoPCCBMzvACIiPQMFlaMwDWSvhIXM9iS9RLSLmtR44AV5w/roKSFmuYffvzVvcdB2v+cJ+VLy9pNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25r4IqQbZEvLm4LQ6EleFom5tJ5jJtwXiKy0MrNXrTw=;
 b=iXEyd0AWd+fTe3/CwM6nARu4okojg16dMEx4vfnJ9uyHdDnYCZtgxr4GRnlEWa2qEDyuOjeLYbCX4wEunjVY9YcBM+CRKW3Dn7h6wZ1x26o7H2Aubnk9tH+uqAH6diu6v7n9JWrtUkgjz1Fe0xLxYjev52ABRThTv2riQLHLXAnUgfg0ONT3on/6dmKLMPwfL29rZ4501WXHZzJhblrsmtBy4rA5A7ZzOoEttSrDis+Sr8tY3pCtqEuAe4BSVZOZunbs6pqwzu0PxRq+2jFveFXuScOPVwmMND87jOZ8JxHOYAvD8BkH396rBiDwESkrfpElVx0QStr9pKKNGAxgLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25r4IqQbZEvLm4LQ6EleFom5tJ5jJtwXiKy0MrNXrTw=;
 b=i9yiLfN8ocgKRK9s0AapQUmdjzInp0PXd5h2mOag9y6/D3I1Kdru9dtiZ7xiGzV9SJNm56AYGUbj9oWrbnpuWruoiWxlnKE8eJGZvX1NaC6cd9RCf0UXsUqkhneBO6l228xLGnv0wAR1tCPVf6DOT1tMf0cE7iC+diu33h22llE=
Received: from MWHPR2201CA0053.namprd22.prod.outlook.com
 (2603:10b6:301:16::27) by DM5PR12MB2375.namprd12.prod.outlook.com
 (2603:10b6:4:b3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15; Thu, 16 Dec
 2021 17:15:12 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:16:cafe::3f) by MWHPR2201CA0053.outlook.office365.com
 (2603:10b6:301:16::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Thu, 16 Dec 2021 17:15:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Thu, 16 Dec 2021 17:15:12 +0000
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 16 Dec
 2021 11:15:11 -0600
From:   Michael Roth <michael.roth@amd.com>
To:     <linux-kselftest@vger.kernel.org>
CC:     <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>, Nathan Tempelman <natet@google.com>,
        Marc Orr <marcorr@google.com>,
        "Steve Rutherford" <srutherford@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "David Woodhouse" <dwmw@amazon.co.uk>,
        Ricardo Koller <ricarkol@google.com>,
        "Jim Mattson" <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Peter Gonda <pgonda@google.com>
Subject: [PATCH v2 00/13] KVM: selftests: Add tests for SEV and SEV-ES guests
Date:   Thu, 16 Dec 2021 11:13:45 -0600
Message-ID: <20211216171358.61140-1-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53115371-6e7f-43d3-c604-08d9c0b79ebd
X-MS-TrafficTypeDiagnostic: DM5PR12MB2375:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB23750A2E7281127423C8D5D895779@DM5PR12MB2375.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RdUFRjBHWcvoQFv7COhir+AoIF0R6OZvhzzZcBJdPzKjXPiH42KeAyfsPAK9ggLQ1AA/eVmNNfQ4X4UcOmaFpdpd66XTZ+AMB6WGW44p7+aGdJWDAu+cCAeoOdSddHSEGpVK0+LaJ3W8oSAkiZ4ztzfd4CQjkpCXkrGX+4VXRhCEgdqB4hThIWHGWYjkfmS0f0GIHyLM3T6PoO0/Of59b6q9TzI8r9YpRu0M+4SFVeiBuIcGIuC1lNvqORETYRvfYGD3pGArQOXAE58WlGPHbiXe4ElMWpJQ7+KBSEj5ZmbOYSDT14p1VmMZsj6oL5psHVcp1zyoqOymRkOPjlS8ejA1FmudxeChp2Gsy+FBkMLB6G2l8kYZ517/c/7prMlWB+BS3qx/39vkgnKoio3fve5TPTVoHzNQOGKfqKI4W4gbLGcE1PMJ5TTSMDYu+zVy966jHHeJGpD0u1QofC7/2rrZ/Seg/WdRVoRDSoBeifsL9AtiqTzDsCu61zRCvrSTIw1AlH/OgZk8KnIDx2CkX0KxqxVJviEmKTscj2aVdktl57K6y2ffSG0AlLiyVZtHSh0t/s+FVGdoE7mY6tKo0IizqacOMLlJa2hWngLZlMZCRJ/QanmXy+seIw3Kn5egHEwJsOmQ9/IB/veO6rdfyC721wLITgMkNm2y/52fNyLImYLJyjnGYo4Vnh3D/1NVMIckuCViAHn8ILks4t5Vn0ndKXRZSPs3NU5THWC0gIMOBdjYcRknUXP48pAxvCA3Uv19tUllWtLli3BbyXwzLgqWAgyWITGAn6bGJevSkgfzx6BX5BrSgsWozxtLUA0F0hCffnr5NrO6nYnIiDTS8c1tfQN/BFMs2BvS3nbwNZOBtTL9YcU5DQAtaxtRwGR8VMTypkaHvOljop79eFmVUhj1PaOd8LKwVn/KpGp8YhM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(7416002)(508600001)(316002)(26005)(40460700001)(54906003)(336012)(86362001)(8936002)(16526019)(4001150100001)(4326008)(966005)(2616005)(82310400004)(8676002)(83380400001)(5660300002)(6916009)(47076005)(81166007)(1076003)(36860700001)(36756003)(70586007)(186003)(70206006)(356005)(426003)(2906002)(44832011)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 17:15:12.2858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53115371-6e7f-43d3-c604-08d9c0b79ebd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2375
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

These patches and are also available at:

  https://github.com/mdroth/linux/commits/sev-selftests-v2

They are based on top of the recent RFC:

  "KVM: selftests: Add support for test-selectable ucall implementations"
  https://lore.kernel.org/all/20211210164620.11636-1-michael.roth@amd.com/T/

  https://github.com/mdroth/linux/commits/sev-selftests-ucall-rfc1

which provides a new ucall implementation that this series relies on.
Those patches were in turn based on kvm/next as of 2021-12-10.

== OVERVIEW ==

This series introduces a set of memory encryption-related parameter/hooks
in the core kselftest library, then uses the hooks to implement a small
library for creating/managing SEV, SEV-ES, and (eventually) SEV-SNP guests.
This library is then used to implement a basic boot/memory test that's run
for variants of SEV/SEV-ES guests.

- Patches 1-8 implement SEV boot tests and should run against existing
  kernels
- Patch 9 is a KVM changes that's required to allow SEV-ES/SEV-SNP
  guests to boot with an externally generated page table, and is a
  host kernel prequisite for the remaining patches in the series.
- Patches 10-13 extend the boot tests to cover SEV-ES

Any review/comments are greatly appreciated!

v2: 
- rebased on ucall_ops patchset (which is based on kvm/next 2021-12-10)
- remove SEV-SNP support for now
- provide encryption bitmap as const* to original rather than as a copy
  (Mingwei, Paolo)
- drop SEV-specific synchronization helpers in favor of ucall_ops_halt (Paolo)
- don't pass around addresses with c-bit included, add them as-needed via
  addr_gpa2raw() (e.g. when adding PTEs, or initializing initial
  cr3/vm->pgd) (Paolo)
- rename lib/sev.c functions for better consistency (Krish)
- move more test setup code out of main test function and into
  setup_test_common() (Krish)
- suppress compiler warnings due to -Waddress-of-packed-member like kernel
  does
- don't require SNP support in minimum firmware version detection (Marc)
- allow SEV device path to be configured via make SEV_PATH= (Marc)

----------------------------------------------------------------
Michael Roth (13):
      KVM: selftests: move vm_phy_pages_alloc() earlier in file
      KVM: selftests: sparsebit: add const where appropriate
      KVM: selftests: add hooks for managing encrypted guest memory
      KVM: selftests: handle encryption bits in page tables
      KVM: selftests: add support for encrypted vm_vaddr_* allocations
      KVM: selftests: ensure ucall_shared_alloc() allocates shared memory
      KVM: selftests: add library for creating/interacting with SEV guests
      KVM: selftests: add SEV boot tests
      KVM: SVM: include CR3 in initial VMSA state for SEV-ES guests
      KVM: selftests: account for error code in #VC exception frame
      KVM: selftests: add support for creating SEV-ES guests
      KVM: selftests: add library for handling SEV-ES-related exits
      KVM: selftests: add SEV-ES boot tests

 arch/x86/include/asm/kvm-x86-ops.h                 |   1 +
 arch/x86/include/asm/kvm_host.h                    |   1 +
 arch/x86/kvm/svm/svm.c                             |  19 ++
 arch/x86/kvm/vmx/vmx.c                             |   6 +
 arch/x86/kvm/x86.c                                 |   1 +
 tools/testing/selftests/kvm/.gitignore             |   1 +
 tools/testing/selftests/kvm/Makefile               |  10 +-
 .../testing/selftests/kvm/include/kvm_util_base.h  |  10 +
 tools/testing/selftests/kvm/include/sparsebit.h    |  36 +--
 tools/testing/selftests/kvm/include/x86_64/sev.h   |  44 +++
 .../selftests/kvm/include/x86_64/sev_exitlib.h     |  14 +
 tools/testing/selftests/kvm/include/x86_64/svm.h   |  35 +++
 .../selftests/kvm/include/x86_64/svm_util.h        |   1 +
 tools/testing/selftests/kvm/lib/kvm_util.c         | 270 ++++++++++++------
 .../testing/selftests/kvm/lib/kvm_util_internal.h  |  10 +
 tools/testing/selftests/kvm/lib/sparsebit.c        |  48 ++--
 tools/testing/selftests/kvm/lib/ucall_common.c     |   4 +-
 tools/testing/selftests/kvm/lib/x86_64/handlers.S  |   4 +-
 tools/testing/selftests/kvm/lib/x86_64/processor.c |  16 +-
 tools/testing/selftests/kvm/lib/x86_64/sev.c       | 252 ++++++++++++++++
 .../testing/selftests/kvm/lib/x86_64/sev_exitlib.c | 249 ++++++++++++++++
 .../selftests/kvm/x86_64/sev_all_boot_test.c       | 316 +++++++++++++++++++++
 22 files changed, 1215 insertions(+), 133 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/sev.h
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/sev_exitlib.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/sev.c
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/sev_exitlib.c
 create mode 100644 tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c


