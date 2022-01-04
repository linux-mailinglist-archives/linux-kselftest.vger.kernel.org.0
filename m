Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419F3484B47
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jan 2022 00:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236554AbiADXme (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jan 2022 18:42:34 -0500
Received: from mail-mw2nam12on2051.outbound.protection.outlook.com ([40.107.244.51]:48374
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236541AbiADXmd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jan 2022 18:42:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JaFOLw9sX5cYwcq3Su3ordrTKslR5DpnUT1oD/y3+o3+8v6WCyddf586keTsGqRaf7Ce+GuRUAaiMCqg9Ovww8+bAOaFXjiey0gaKme5FuCA10ZZ8IdiJVPrrpn5hj9KRP97T5eS4eEspwWIkdQHOvzfiyR+iCtmIp9aMTNPMqtC0d42dq9U6lnxSbsiOyvZKej1WlIrMcWYsGhuWMjrDAxHSFxJ/nQ+UYDgKQdSA/eNn55L1xz1Dupiqgb4BsfTxg6oVgFon2VBc+sHppONxNJuJfgBtQGcd3B1lXI4rjkUh1aiRS3h6XKi0P6CZN52HoXqzuCAFs7ps/SI7HxFrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+bSWmoDV0jFhXma4w+i2bFpjbuDW0zv5cMptByc5n4=;
 b=WmyrhOWpZ5T62mU5H4L1M52Yga8g0NaKf87RrEwUyUGVUviz/kfwCLZPWRXvfAEeLn25xygko1K5LnLxIjOXswnehWBOVU4YDaC9YROAMQSSO//e5QCpnrdanzah+2baXx2nmX39IZoUseq8KfpydHVV5QbKNVNnEPlBgH4kXIL+FpjWlUFtMMZjDZJudn/Q8XG0ciHFLcSrdvVNBVxP5PCYblGU2ZJbTHOOPZ+GH4hirW+t+99fJWEaxPzglpO+vwidIJwaSc/jDmK4FBTmQWfhqXGASZW/ZUQZ/kUY5zn2vOfRcmBd7pZeYE8NLtksH8vcWvhdkA+nAjjbYM/FMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+bSWmoDV0jFhXma4w+i2bFpjbuDW0zv5cMptByc5n4=;
 b=Bi/O6cCI6koQXZMaMvGo2Ccf/IEX/hQ5V1gyICZWy1SQbggqZK8EPAfn7d1TG2OQC9TfZFvUtdVh0SRkabeqmG1yZHIgWbcQ1cXMVNNZOY+PcNfGNgUcuqMxHiyutfAg0eFs8TpY4lA63FGgxUrANmmP3dBx3wrDm7l7GuODf5E=
Received: from DM6PR13CA0043.namprd13.prod.outlook.com (2603:10b6:5:134::20)
 by MWHPR1201MB2542.namprd12.prod.outlook.com (2603:10b6:300:e8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 23:42:28 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::e) by DM6PR13CA0043.outlook.office365.com
 (2603:10b6:5:134::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.6 via Frontend
 Transport; Tue, 4 Jan 2022 23:42:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4844.14 via Frontend Transport; Tue, 4 Jan 2022 23:42:28 +0000
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 4 Jan
 2022 17:42:27 -0600
Date:   Tue, 4 Jan 2022 17:41:29 -0600
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
        Joerg Roedel <joro@8bytes.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Peter Gonda <pgonda@google.com>
Subject: Re: [PATCH v2 00/13] KVM: selftests: Add tests for SEV and SEV-ES
 guests
Message-ID: <20220104234129.dvpv3o3tihvzsqcr@amd.com>
References: <20211216171358.61140-1-michael.roth@amd.com>
 <c01b0592-9d7b-601d-035b-fa2c308690aa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c01b0592-9d7b-601d-035b-fa2c308690aa@redhat.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7aa3311c-8dce-4fcc-cb7e-08d9cfdbde30
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2542:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB254270414B9B54F59142CC80954A9@MWHPR1201MB2542.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5c8zdhCRAWqe1vKHmGUnDX9qaIJ7CWpJNgbwh81uBs0R36SCpSqQMojLTelijNKhkwdxV0Vba3Iv3sP6rqR6MgbuBNfcXpD5Y6cMdWo01p2giIpWnFuwwGaF13qp7uBTTxYuW02w36c2Wwt9RRN4E35JwcOezkt2LEbD0Ld8ETJiPG6kV+x59SPaHzp4HhphOy7IhB/SFk/2ue+12o3CNmEBhHURhD212eajAZeyYxX1fiVeFqVypDNRC8CvTR3ndmnZNIP/Kv4v4lgVBti72QBzQ9IcFntmo83i0RvIy9wGLaKYIgqmqaE58P8eC9kevjeEn0PznAVXhzOaOfK8zYF1kaX0Bv8EY39tbKLvsngy9tIMK6qoEu8xUk7fOaDVzgrfMDULUpOJzwiH1QyaCkA2DBcjHnCzaHjSoQNlU4XEeoDsI5fFIsTim5MR41/K3VZ1T1dmn7WfNdjlYnm8gcKNlgZoCyMoC/0YIWBNYTnss+n/N7FClgDKpmdH6MqPI/VFUweSuucqNhXug5BakjuyDivu6mN7Ogilw8LtV4FTWX9YoKaQW5XP91hxjZijrPLYRFn09AF+osZNPv5Q0Su9ySBS11bZp7rwC4g7rAZCq/++mMhcIYgEYGNnjM3UyXcVrjSku8YO4Zyj0/fFJETxet6R6MVbwCWRUfmCGuqWOPxaKsxeflEd68ghEGbmqXcTZZ4zMafbAe31sLcDXrzn5h3aY7vyPXSsN1I9R0jabJEHL6xFn+hu7+H13exMrW22+RdVukAU/1bB2E9ouUAIFtvSlMHBEOlPTDDbePSMHdtszFAXU171a6JU5eUEr/F2UTgCHFErgHQMd4x4aXOHXcyChtbfZD1BIOvtRr+UCCQAr6fUu9AHseyX5M5nSRGXuMK/lVzmkVD5qPbv832+cU0eaA/0KYsQ1E8tC60=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700002)(8936002)(36860700001)(36756003)(4001150100001)(83380400001)(2906002)(45080400002)(508600001)(966005)(8676002)(6916009)(7416002)(70586007)(426003)(70206006)(5660300002)(356005)(40460700001)(81166007)(336012)(53546011)(186003)(47076005)(26005)(54906003)(86362001)(2616005)(1076003)(316002)(44832011)(4326008)(82310400004)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 23:42:28.1069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa3311c-8dce-4fcc-cb7e-08d9cfdbde30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2542
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 22, 2021 at 03:56:23PM +0100, Paolo Bonzini wrote:
> On 12/16/21 18:13, Michael Roth wrote:
> > These patches and are also available at:
> > 
> >    https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fmdroth%2Flinux%2Fcommits%2Fsev-selftests-v2&amp;data=04%7C01%7Cmichael.roth%40amd.com%7C749cb23438484cede3bc08d9c55b3c4e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637757817978399009%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=8F%2BcL%2F9FcCx4I2QXJUmBwGGxdHymP6l%2BoRKQO7%2BVj1Y%3D&amp;reserved=0
> > 
> > They are based on top of the recent RFC:
> > 
> >    "KVM: selftests: Add support for test-selectable ucall implementations"
> >    https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F20211210164620.11636-1-michael.roth%40amd.com%2FT%2F&amp;data=04%7C01%7Cmichael.roth%40amd.com%7C749cb23438484cede3bc08d9c55b3c4e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637757817978399009%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=BZu%2BqGCqpHEHlkL%2B5zFELdOaERRrUdznCFO%2FzPaQ4v8%3D&amp;reserved=0
> > 
> >    https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fmdroth%2Flinux%2Fcommits%2Fsev-selftests-ucall-rfc1&amp;data=04%7C01%7Cmichael.roth%40amd.com%7C749cb23438484cede3bc08d9c55b3c4e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637757817978399009%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=DkCRww6ifTrnavR9XvmWwX1wkKHK172iuivTaqEfu6o%3D&amp;reserved=0
> > 
> > which provides a new ucall implementation that this series relies on.
> > Those patches were in turn based on kvm/next as of 2021-12-10.
> 
> Looks good, apart from the cleanups that Peter pointed out in patch 7.
> 
> When you send the next version, you can keep it based on the same ucall RFC,
> even if I haven't yet pushed them (which I'll do only after testing on
> s390).

Hi Paolo,

Didn't manage to get these out before going on break, but back in office now
and will get an updated version out as soon as we figure out a plan for
implementing some of Sean's recent suggestions for the ucall side of things.

Thanks,

Mike

> 
> Thanks,
> 
> Paolo
> 
> > == OVERVIEW ==
> > 
> > This series introduces a set of memory encryption-related parameter/hooks
> > in the core kselftest library, then uses the hooks to implement a small
> > library for creating/managing SEV, SEV-ES, and (eventually) SEV-SNP guests.
> > This library is then used to implement a basic boot/memory test that's run
> > for variants of SEV/SEV-ES guests.
> > 
> > - Patches 1-8 implement SEV boot tests and should run against existing
> >    kernels
> > - Patch 9 is a KVM changes that's required to allow SEV-ES/SEV-SNP
> >    guests to boot with an externally generated page table, and is a
> >    host kernel prequisite for the remaining patches in the series.
> > - Patches 10-13 extend the boot tests to cover SEV-ES
> > 
> > Any review/comments are greatly appreciated!
> > 
> > v2:
> > - rebased on ucall_ops patchset (which is based on kvm/next 2021-12-10)
> > - remove SEV-SNP support for now
> > - provide encryption bitmap as const* to original rather than as a copy
> >    (Mingwei, Paolo)
> > - drop SEV-specific synchronization helpers in favor of ucall_ops_halt (Paolo)
> > - don't pass around addresses with c-bit included, add them as-needed via
> >    addr_gpa2raw() (e.g. when adding PTEs, or initializing initial
> >    cr3/vm->pgd) (Paolo)
> > - rename lib/sev.c functions for better consistency (Krish)
> > - move more test setup code out of main test function and into
> >    setup_test_common() (Krish)
> > - suppress compiler warnings due to -Waddress-of-packed-member like kernel
> >    does
> > - don't require SNP support in minimum firmware version detection (Marc)
> > - allow SEV device path to be configured via make SEV_PATH= (Marc)
> > 
> > ----------------------------------------------------------------
> > Michael Roth (13):
> >        KVM: selftests: move vm_phy_pages_alloc() earlier in file
> >        KVM: selftests: sparsebit: add const where appropriate
> >        KVM: selftests: add hooks for managing encrypted guest memory
> >        KVM: selftests: handle encryption bits in page tables
> >        KVM: selftests: add support for encrypted vm_vaddr_* allocations
> >        KVM: selftests: ensure ucall_shared_alloc() allocates shared memory
> >        KVM: selftests: add library for creating/interacting with SEV guests
> >        KVM: selftests: add SEV boot tests
> >        KVM: SVM: include CR3 in initial VMSA state for SEV-ES guests
> >        KVM: selftests: account for error code in #VC exception frame
> >        KVM: selftests: add support for creating SEV-ES guests
> >        KVM: selftests: add library for handling SEV-ES-related exits
> >        KVM: selftests: add SEV-ES boot tests
> > 
> >   arch/x86/include/asm/kvm-x86-ops.h                 |   1 +
> >   arch/x86/include/asm/kvm_host.h                    |   1 +
> >   arch/x86/kvm/svm/svm.c                             |  19 ++
> >   arch/x86/kvm/vmx/vmx.c                             |   6 +
> >   arch/x86/kvm/x86.c                                 |   1 +
> >   tools/testing/selftests/kvm/.gitignore             |   1 +
> >   tools/testing/selftests/kvm/Makefile               |  10 +-
> >   .../testing/selftests/kvm/include/kvm_util_base.h  |  10 +
> >   tools/testing/selftests/kvm/include/sparsebit.h    |  36 +--
> >   tools/testing/selftests/kvm/include/x86_64/sev.h   |  44 +++
> >   .../selftests/kvm/include/x86_64/sev_exitlib.h     |  14 +
> >   tools/testing/selftests/kvm/include/x86_64/svm.h   |  35 +++
> >   .../selftests/kvm/include/x86_64/svm_util.h        |   1 +
> >   tools/testing/selftests/kvm/lib/kvm_util.c         | 270 ++++++++++++------
> >   .../testing/selftests/kvm/lib/kvm_util_internal.h  |  10 +
> >   tools/testing/selftests/kvm/lib/sparsebit.c        |  48 ++--
> >   tools/testing/selftests/kvm/lib/ucall_common.c     |   4 +-
> >   tools/testing/selftests/kvm/lib/x86_64/handlers.S  |   4 +-
> >   tools/testing/selftests/kvm/lib/x86_64/processor.c |  16 +-
> >   tools/testing/selftests/kvm/lib/x86_64/sev.c       | 252 ++++++++++++++++
> >   .../testing/selftests/kvm/lib/x86_64/sev_exitlib.c | 249 ++++++++++++++++
> >   .../selftests/kvm/x86_64/sev_all_boot_test.c       | 316 +++++++++++++++++++++
> >   22 files changed, 1215 insertions(+), 133 deletions(-)
> >   create mode 100644 tools/testing/selftests/kvm/include/x86_64/sev.h
> >   create mode 100644 tools/testing/selftests/kvm/include/x86_64/sev_exitlib.h
> >   create mode 100644 tools/testing/selftests/kvm/lib/x86_64/sev.c
> >   create mode 100644 tools/testing/selftests/kvm/lib/x86_64/sev_exitlib.c
> >   create mode 100644 tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c
> > 
> > 
> 
