Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6440438E5F
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Oct 2021 06:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbhJYEcn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Oct 2021 00:32:43 -0400
Received: from mail-bn7nam10on2074.outbound.protection.outlook.com ([40.107.92.74]:6794
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229458AbhJYEck (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Oct 2021 00:32:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ar1qH09GVoHG1uKANRQtIcy8zjHkMfW5uQfGXKSHRLHyJEnXgPKSGYNM2XDuWvZbZcR/myL+jhZrCYXLaKJUNvtQB+FWUKMBSYoCIxRHABwJSe8H1ZL7r6mnC9xzW4N1b9SYYI/waziBCIO5XgpI2ekpSghgAowPRhvMM1iDutZDepGvt/DfYme5Jva4ntPUPHZE+hWKs1RZSSNBz9mIamqNgqlD/oAgIRDGgtVE0DZ+yNFNjZBSBUZsClcOwOMz86klYWB8SBRGNbYtJ8mnbBJJNaXLcKfw/xdikkC5zWkRk5aw5PY2rG3USsoIaR35V6TkocV+wSOQZ/GS+GBCJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRjZGqG0UWxavTMNO+Pqic9mg0kWZi4lcoe80FPBcZo=;
 b=YZJql44aUnGqNRFZZd/VQT929mUzgbM8bWIZZV/Ojwb8VWm0gvZNCQWPxixUVbTBmnLypZFWwZ8VjBj9dSjBjopirv/KtJfiBr2ZMCl9Y+H764+YxTHqOELGBlmONcPwlZZ2pAxOsXDONWLiVFONpcPguJDoWkGsrqIi2pJfK+/83E/yuslCb1fohzJmReJHaL8ouuwjDY9w61dHqX6eLWmQz4866ouvtYFYevrvmCIbS0ZNZS8IcgTIRQrtATwB31RDTZOGAW2GpPmOmgrrNlIrVFIZqJ/facLhW3xJBe6Yrn4puZMerNRSZ3nyWulUuHrAMtVd09ih7WBVBvSyOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRjZGqG0UWxavTMNO+Pqic9mg0kWZi4lcoe80FPBcZo=;
 b=pBLCdFjkcwSvcIGbjghxwisCKyV0lkpEy20xkZUwrWlPqR1keY+VCj+OqDBKDcBRnnk2Si4UAm8W6WFfYR9mWQjFH1UJZCbbeQHoOt8SvJGshDjiwR9buwAt8uMDd16orTiNdq1biCBxO8DV0N8AhP9nXuXmxf7IJnwqXLMVAsM=
Received: from MWHPR14CA0021.namprd14.prod.outlook.com (2603:10b6:300:ae::31)
 by SN6PR12MB4687.namprd12.prod.outlook.com (2603:10b6:805:12::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 04:30:15 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ae:cafe::39) by MWHPR14CA0021.outlook.office365.com
 (2603:10b6:300:ae::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Mon, 25 Oct 2021 04:30:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 04:30:13 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Sun, 24 Oct
 2021 23:30:12 -0500
Date:   Sun, 24 Oct 2021 23:27:16 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     <linux-kselftest@vger.kernel.org>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Nathan Tempelman <natet@google.com>,
        Marc Orr <marcorr@google.com>,
        Steve Rutherford <srutherford@google.com>,
        Sean Christopherson <seanjc@google.com>,
        "Mingwei Zhang" <mizhang@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "David Woodhouse" <dwmw@amazon.co.uk>,
        Ricardo Koller <ricarkol@google.com>,
        "Jim Mattson" <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC 00/16] KVM: selftests: Add tests for SEV, SEV-ES, and
 SEV-SNP guests
Message-ID: <20211025042716.af5gdct3b36swl37@amd.com>
References: <20211005234459.430873-1-michael.roth@amd.com>
 <71547952-c3e7-6683-5eea-70d3003d5224@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <71547952-c3e7-6683-5eea-70d3003d5224@redhat.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b086314f-66f1-4969-8598-08d997702349
X-MS-TrafficTypeDiagnostic: SN6PR12MB4687:
X-Microsoft-Antispam-PRVS: <SN6PR12MB46871FB7B0D52131FAA1716D95839@SN6PR12MB4687.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LnE0VNp0kyVwl5UXD4vLMXCZLwUVj9CyUtqcSZD4NkpwVrZO82oemojnuS4POaMAgRClMdPxDgrQS5lUSuj6fFLXphuRC9fybW55Tyfgq3wlncBuyI3Pyk05zHHEFD2PtTP2HQm6sDRq+/YSmOuzW0whBuv8c5hhRhpgHllg1ud9n8QYlpx2qxBXPgI7bU2kq3T+5kqYb65l+QIF41h+bcJl1/95XkN6EEFmU8Hu1cVjXsibwdGGxBfKvRdRCH/7WiM3kM6//TGEz+0kaM2o7KBnbzwCtjy2Gm1FzDh/1TWaZ2qpbEcfFhBHcZqqOBw6qoLFAbayDZWSbnkuMfD6jR/wL3WM0oKXHrx9d1xc4xhw61BTiwm9AD2zCvznb1wetBx+XtNxnwbxyKwhGEkaebJJqzNKNLJpnaQLxNYCUJ4WCYs0nXSVzaVtfVFcXtS1cJlUJEg4kB4+oOxqu0hzPps72348BXBxdCcurWby0HbCDGM6bc2vnt9sOKhhh5M0zExxTF8SalLMwANBjxPM5H2tR3SKO961C4DVRvdB3UqznBNaFN3UV51vjkSg961YUYhuvhQ62N8k/3AHxrQ/k2FQiC9YXpqUjKH7QBVL+0vk/TBZMYnGknGMSucgUJzRLWwmD3PeRPUkwUMUc47JLaQtRWgN0ITgDKqhdpqn9qvBUvjD1F/s6CYB3m0fDFiLXRb64p+6GppiNLGiNKy3TnvjTBSkaCQnbI2nqoqAD0/1WMJKcEF2nEho9ZWF3l1jpEh3WvI5M1wnTwbq86kWWhPJLzIpV/kZ7wwCVTBCPIsy+50bc7U1SQhm8oB2uVHr1hPriKKRn5dgUyqskhD3M8sUbdUObtRjzfwIqTyO1Ew=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(8936002)(26005)(426003)(2616005)(70586007)(70206006)(4326008)(7416002)(86362001)(16526019)(8676002)(36860700001)(81166007)(356005)(53546011)(336012)(5660300002)(6916009)(44832011)(47076005)(82310400003)(186003)(316002)(36756003)(83380400001)(508600001)(2906002)(1076003)(966005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 04:30:13.2328
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b086314f-66f1-4969-8598-08d997702349
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4687
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 21, 2021 at 06:48:24PM +0200, Paolo Bonzini wrote:
> On 06/10/21 01:44, Michael Roth wrote:
> > These patches and are also available at:
> > 
> >    https://github.com/mdroth/linux/commits/sev-selftests-rfc1
> > 
> > They are based on top of v5 of Brijesh's SEV-SNP hypervisor patches[1]
> > to allow for SEV-SNP testing and provide some context for the overall
> > design, but the SEV/SEV-ES patches can be carved out into a separate
> > series as needed.
> > 
> > == OVERVIEW ==
> > 
> > This series introduces a set of memory encryption-related parameter/hooks
> > in the core kselftest library, then uses the hooks to implement a small
> > library for creating/managing SEV, SEV-ES, SEV-SNP guests. This library
> > is then used to implement a basic boot/memory test that's run for all
> > variants of SEV/SEV-ES/SEV-SNP guest types, as well as a set of SEV-SNP
> > tests that cover various permutations of pvalidate/page-state changes.
> > 
> > - Patches 1-7 implement SEV boot tests and should run against existing
> >    kernels
> > - Patch 8 is a KVM changes that's required to allow SEV-ES/SEV-SNP
> >    guests to boot with an externally generated page table, and is a
> >    host kernel prequisite for the remaining patches in the series.
> > - Patches 9-12 extend the boot tests to cover SEV-ES
> > - Patches 13-16 extend the boot testst to cover SEV-SNP, and introduce
> >    an additional test for page-state changes.
> 
> Hi Mike,
> 
> this SEV/SEV-ES testing (both your series and kvm-unit-tests) is good stuff.
> :)  If you fix up patches 1-12, I will commit them pretty much straight
> away.  The only thing that possibly needs some thought is the integration
> with ucall.

Hi Paolo,

Glad to hear :) For v2 I'll work on getting SEV/SEV-ES broken out into a
separate series with all the review comments addressed. Still a little
unsure about the best way to address some things in patch #3, but
outlined a tentative plan that hopefully seems reasonable. Can re-visit
in v2 as well.

Thanks!

-Mike

> 
> Thanks,
> 
> Paolo
> 
> > Any review/comments are greatly appreciated!
> > 
> > [1] https://lore.kernel.org/linux-mm/20210820155918.7518-1-brijesh.singh@amd.com/
> > 
> > ----------------------------------------------------------------
> > Michael Roth (16):
> >        KVM: selftests: move vm_phy_pages_alloc() earlier in file
> >        KVM: selftests: add hooks for managing encrypted guest memory
> >        KVM: selftests: handle encryption bits in page tables
> >        KVM: selftests: set CPUID before setting sregs in vcpu creation
> >        KVM: selftests: add support for encrypted vm_vaddr_* allocations
> >        KVM: selftests: add library for creating/interacting with SEV guests
> >        KVM: selftests: add SEV boot tests
> >        KVM: SVM: include CR3 in initial VMSA state for SEV-ES guests
> >        KVM: selftests: account for error code in #VC exception frame
> >        KVM: selftests: add support for creating SEV-ES guests
> >        KVM: selftests: add library for handling SEV-ES-related exits
> >        KVM: selftests: add SEV-ES boot tests
> >        KVM: selftests: add support for creating SEV-SNP guests
> >        KVM: selftests: add helpers for SEV-SNP-related instructions/exits
> >        KVM: selftests: add SEV-SNP boot tests
> >        KVM: selftests: add SEV-SNP tests for page-state changes
> > 
> >   arch/x86/include/asm/kvm-x86-ops.h                 |   1 +
> >   arch/x86/include/asm/kvm_host.h                    |   1 +
> >   arch/x86/kvm/svm/svm.c                             |  22 ++
> >   arch/x86/kvm/vmx/vmx.c                             |   8 +
> >   arch/x86/kvm/x86.c                                 |   3 +-
> >   tools/testing/selftests/kvm/.gitignore             |   2 +
> >   tools/testing/selftests/kvm/Makefile               |   3 +
> >   tools/testing/selftests/kvm/include/kvm_util.h     |   8 +
> >   tools/testing/selftests/kvm/include/x86_64/sev.h   |  70 ++++
> >   .../selftests/kvm/include/x86_64/sev_exitlib.h     |  20 ++
> >   tools/testing/selftests/kvm/include/x86_64/svm.h   |  35 ++
> >   .../selftests/kvm/include/x86_64/svm_util.h        |   2 +
> >   tools/testing/selftests/kvm/lib/kvm_util.c         | 249 +++++++++-----
> >   .../testing/selftests/kvm/lib/kvm_util_internal.h  |  10 +
> >   tools/testing/selftests/kvm/lib/x86_64/handlers.S  |   4 +-
> >   tools/testing/selftests/kvm/lib/x86_64/processor.c |  30 +-
> >   tools/testing/selftests/kvm/lib/x86_64/sev.c       | 381 +++++++++++++++++++++
> >   .../testing/selftests/kvm/lib/x86_64/sev_exitlib.c | 326 ++++++++++++++++++
> >   .../selftests/kvm/x86_64/sev_all_boot_test.c       | 367 ++++++++++++++++++++
> >   .../selftests/kvm/x86_64/sev_snp_psc_test.c        | 378 ++++++++++++++++++++
> >   20 files changed, 1820 insertions(+), 100 deletions(-)
> >   create mode 100644 tools/testing/selftests/kvm/include/x86_64/sev.h
> >   create mode 100644 tools/testing/selftests/kvm/include/x86_64/sev_exitlib.h
> >   create mode 100644 tools/testing/selftests/kvm/lib/x86_64/sev.c
> >   create mode 100644 tools/testing/selftests/kvm/lib/x86_64/sev_exitlib.c
> >   create mode 100644 tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c
> >   create mode 100644 tools/testing/selftests/kvm/x86_64/sev_snp_psc_test.c
> > 
> > 
> > 
> 
