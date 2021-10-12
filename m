Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAA342A4F9
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Oct 2021 14:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236434AbhJLM57 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Oct 2021 08:57:59 -0400
Received: from mail-dm6nam08on2054.outbound.protection.outlook.com ([40.107.102.54]:8608
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236326AbhJLM56 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Oct 2021 08:57:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yqdbqxp9wQ8FjpGe1Xin/+YVCnB+7szTxAyoD1l+Dx/FDo7atRqJSLbacYBtOxdfckq+HiVZHpQlilJMBosbYF1Xu1oojgB2/mXvomDQItlqEGg2Xbjy5zMxfo8C1HXYbJ+H/EcDFwPChOzBjcy+nXMpOMP23UxzGsTpK3NcXl+e9+TgP25s2iuTUDyYjcQFEK19GHXQwDI020aZMRxSDeBxZlKZWK38tUKNVkksqGgz+ujoPqQKXv4A86N0JXMLZgLQmd48WgW/FtRljYrwgAYRGUb/g4gd8UkETcW9QKXhXwd7TAX7hrJODqOGBbtUrh1a35nbP54zpL890ZAnkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izrEM28SWfUf2L0HmJiijQQUGtrY9e4uK6O3EZtXOzE=;
 b=oU6qxA3pzBx5RdT3asqAD8dL1//y3eJAbGYhpt6ZBlmcZdluOZ7OrxJtudxkNzi2/GbCiPWjt/+iWR6HjxYhvWk/0Ja9+cfscItukZDQIG+ZadbRNVHJPov87qy1Ojhbv/phcKsbluVYOvB0FnmRIg72cfuYrLxbVuaAOhJCH1fCzAHpHKQSjhyOqRuoHYs0kk3T3ag3Drgcsyw7kYQHI/OXd/FHj7q+JGjS/3D9uEORAvDz+EjxHRf+lzz0t3qx80/bKDLsh28Oa99nj/YETKuQbANurLWYVb3nLAEjx6tnLCCqnkrHl5uktLek/B95jpQp1l+NSLsMy6qEYXwTqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izrEM28SWfUf2L0HmJiijQQUGtrY9e4uK6O3EZtXOzE=;
 b=rH5mSnAe0itPAovvykn/hA+2y2SdBbBrNpVnWHUwgIOzQJs0InF6rrhi49h5/hdei8Q/7JeMW6H8LgV+mpbmeCnmEV8miBaUhz6KvDLUrBjPbXtDtpLnMSk7O3rNdNbWNYAYTCFqy/mmOjUGlXqpq1fES8+dI2rXrEApyyIiq/c=
Received: from DS7PR03CA0343.namprd03.prod.outlook.com (2603:10b6:8:55::17) by
 CY4PR1201MB0023.namprd12.prod.outlook.com (2603:10b6:910:1f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24; Tue, 12 Oct
 2021 12:55:53 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::be) by DS7PR03CA0343.outlook.office365.com
 (2603:10b6:8:55::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend
 Transport; Tue, 12 Oct 2021 12:55:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Tue, 12 Oct 2021 12:55:53 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 12 Oct
 2021 07:55:51 -0500
Date:   Tue, 12 Oct 2021 07:55:36 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     Marc Orr <marcorr@google.com>
CC:     <linux-kselftest@vger.kernel.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Nathan Tempelman <natet@google.com>,
        Steve Rutherford <srutherford@google.com>,
        "Sean Christopherson" <seanjc@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Ricardo Koller <ricarkol@google.com>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC 06/16] KVM: selftests: add library for creating/interacting
 with SEV guests
Message-ID: <20211012125536.qpewvk6cou3mxya7@amd.com>
References: <20211005234459.430873-1-michael.roth@amd.com>
 <20211006203710.13326-1-michael.roth@amd.com>
 <CAA03e5EmnbpKOwfNJUV7fog-7UpJJNpu7mQYmCODpk=tYfXxig@mail.gmail.com>
 <20211012011537.q7dwebcistxddyyj@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211012011537.q7dwebcistxddyyj@amd.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa65b257-4674-473c-1796-08d98d7f9fea
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0023:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0023B688AFBAA7BA2CA4488295B69@CY4PR1201MB0023.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ai5dAXNdJKKb42SL2bp+J2yCCyYF4XDk2GmyZ+8Q+qi+JwbJcNSh/x7JjhatULu2SGXpqcA1IzsDgNw4DXuPOXo254x17moaas02emX/2UPlbRbQmkI+tlHB44RvZ0MTcEK/DZPas/nP0cgb+pNOh0V2AiX8PJbq0fwv0GaOz7ertyncaSB0jZDmavs1/uaHD0qK0a0U7IgJGXhW8iAHmFTUKg2AL1qXCUetJ579XoQ9C0jTM8N1M9jEifjY5TBe1TEhbZqdZ3gWx+Lzk+MBZXsciVlnchDHxfhf3bL5KqO1vWUkyNrXay6tPmO3AGC+7dNB/RNdwdzJMu738SCzbH7PfGatQk57EA46UsexhOG0jwfWKxr+F2tQe3HImOOG+KyWZZZmE7sklmLm3xkNk10Y+r8l+E7QbF1ZAfWlv4FfhUjmKhrEEaLGyVXpaizsKMaxtvLuru6COP2ZpIeG+pHv2bD6M8JNa0Z4KHI/ysMGaOGyGvoNgU76ikZztpF9XmgXXtxnFTwQhqjbTlPgDqz3Ho3GuYMcFSAJBT66KOKg2Yk/klL1pkDqmtrhWQ3oy7XQD7PJoqSKMzshMOFwgWILviEMHXU8XMa3Xs/NqYmz+Qca6sgewDP6ER86fbqfxnf9KfkTnhITvDj925Q4QytomO5eaRVi42tdNEPDvX73cfKlWs4eK4+gjZJJTskN29ED4IJVSLhSwJKa8EEiQaUbY7HmMuvcYUxCqWKypgQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(8676002)(316002)(86362001)(508600001)(2906002)(83380400001)(70206006)(6666004)(70586007)(47076005)(5660300002)(36756003)(7416002)(356005)(36860700001)(16526019)(186003)(44832011)(26005)(1076003)(82310400003)(54906003)(426003)(2616005)(8936002)(336012)(4326008)(53546011)(81166007)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 12:55:53.2144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa65b257-4674-473c-1796-08d98d7f9fea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0023
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 11, 2021 at 08:15:37PM -0500, Michael Roth wrote:
> On Sun, Oct 10, 2021 at 08:17:00PM -0700, Marc Orr wrote:
> > On Wed, Oct 6, 2021 at 1:40 PM Michael Roth <michael.roth@amd.com> wrote:
> > >
> > > Add interfaces to allow tests to create/manage SEV guests. The
> > > additional state associated with these guests is encapsulated in a new
> > > struct sev_vm, which is a light wrapper around struct kvm_vm. These
> > > VMs will use vm_set_memory_encryption() and vm_get_encrypted_phy_pages()
> > > under the covers to configure and sync up with the core kvm_util
> > > library on what should/shouldn't be treated as encrypted memory.
> > >
> > > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > > ---
> > >  tools/testing/selftests/kvm/Makefile          |   1 +
> > >  .../selftests/kvm/include/x86_64/sev.h        |  62 ++++
> > >  tools/testing/selftests/kvm/lib/x86_64/sev.c  | 303 ++++++++++++++++++
> > >  3 files changed, 366 insertions(+)
> > >  create mode 100644 tools/testing/selftests/kvm/include/x86_64/sev.h
> > >  create mode 100644 tools/testing/selftests/kvm/lib/x86_64/sev.c
> > >
> > > diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> > > index 5832f510a16c..c7a5e1c69e0c 100644
> > > --- a/tools/testing/selftests/kvm/Makefile
> > > +++ b/tools/testing/selftests/kvm/Makefile
> > > @@ -35,6 +35,7 @@ endif
> > >
> > >  LIBKVM = lib/assert.c lib/elf.c lib/io.c lib/kvm_util.c lib/rbtree.c lib/sparsebit.c lib/test_util.c lib/guest_modes.c lib/perf_test_util.c
> > >  LIBKVM_x86_64 = lib/x86_64/apic.c lib/x86_64/processor.c lib/x86_64/vmx.c lib/x86_64/svm.c lib/x86_64/ucall.c lib/x86_64/handlers.S
> > > +LIBKVM_x86_64 += lib/x86_64/sev.c
> > 
> > Regarding RFC-level feedback: First off, I'm super jazzed with what
> > I'm seeing so far! (While this is my first review, I've been studying
> > the patches up through the SEV boot test, i.e., patch #7). One thing
> > I'm wondering is: the way this is structured is to essentially split
> > the test cases into non-SEV and SEV. I'm wondering how hard it would
> > be to add some flag or environment variable to set up pre-existing
> > tests to run under SEV. Or is this something you all thought about,
> > and decided that it does not make sense?
> > 
> > Looking at how the guest memory is handled, it seems like it's not far
> > off from handling SEV transparently across all test cases. I'd think
> > that we could just default all memory to use the encryption bit, and
> > then have test cases, such as the test case in patch #7, clear the
> > encryption bit for shared pages. However, I think the VM creation
> > would need a bit more refactoring to work with other test cases.
> 
> I think it's possible, but there's a few missing pieces:
> 
> 1) As you indicated, existing tests which rely on vm_create(),
>    vm_create_default(), vm_create_default_with_vcpus(), etc. would either
>    need to be updated with whatever new interface provides this 'use-sev'
>    flag, or it would need to happen underneath the covers based on said
>    environment variable/global/etc. There's also the question of where
>    to hook in the sev_vm_launch_start() hooks. Maybe the first time a
>    vcpu_run() is issued? Or maybe some explict call each test will need
>    to be updated to call just prior to initial execution.
> 
> 2) Many of the existing tests use the GUESY_SYNC/ucall stuff to handle
>    synchronization between host userspace and guest kernel, which relies on
>    guests issuing PIO instructions to particular port addresses to cause an
>    exit back to host userspace, with various parameters passed via register
>    arguments.
> 
>    - For SEV this would almost work as-is, but some tests might rely on
>      things like memory addresses being passed in this way so would need
>      to audit the code and mark that memory as shared where needed.
> 
>    - For SEV-ES/SEV-SNP, there's a bit more work since:
> 
>      - The registers will not be accessible through the existing
>        KVM_GET_REGS mechanism. It may be possible to set some flag/hook to
>        set/access arguments through some other mechanism like a shared
>        buffer for certain VM types though.
> 
>      - Additionally, the #VC handler only supports CPUID currently, and
>        leverages that fact to avoid doing any significant instruction
>        decoding. Instead the SEV tests use HLT instructions to handle exits
>        to host userspace, which may not work for some tests. So unless
>        there's some other mechanism that SEV/non-SEV tests could utilize
>        rather that PIO, the #VC handler would need to support PIO, which
>        would be nice to have either way, but would likely involve
>        pulling in the intruction decoder library used in the kernel, or
>        some subset/re-implementation of it at least.
> 
> 3) Similar to SEV-ES/SEV-SNP requirements for 1), tests which generate
>    PIO/MMIO and other NAE events would need appropriate support for those
>    events in the #VC handler. Nice-to-have either way, but not sure atm
>    how much it would be to implement all of that. Also any tests relying
>    on things like KVM_GET_REGS/KVM_GET_SREGS are non-starters.

One more I should mention:

4) After encryption, the page table is no longer usable for translations by
   stuff like addr_gva2gpa(), so tests would either need to be
   audited/updated to do these translations upfront and only rely on
   cached/stored values thereafter, or perhaps a "shadow" copy could be
   maintained by kvm_util so the translations will continue to work
   after encryption.
