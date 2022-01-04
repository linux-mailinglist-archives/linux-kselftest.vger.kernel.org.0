Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18DD2484B3E
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jan 2022 00:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbiADXlw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jan 2022 18:41:52 -0500
Received: from mail-dm6nam10on2042.outbound.protection.outlook.com ([40.107.93.42]:5248
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235383AbiADXlw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jan 2022 18:41:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwKowROj6HFCwafIg5KKIgNc6ZxPkNlLOBRNmLDR5WHxSLr8mbVZlilFFaeVZMSbkT8/ZP4awSIICGo81EAmcTMNnhlCB9c7OhvcaY5ExU89X7LCYRqmc9uuvgnJ9Ys1l3IelQeWqjpkma2CS/Zu3tjxjrysCYvSEe3z8E5T/w0mWE9+xio/8GVRSzU6OFlZm03fdQCfewsxR6DJ8vXw2e6jDl0/RNwb54Nxy9uTVYE4SK2AbBiI1rRkp1M/d084tbJHHPisbbiibkilxJ5Svayse3gS7xsch6HQx671hdjcY2pHvG4fKaO3TjwEQUxGw+sqlMzzm8Nl+JY3f8PrpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLlRqvdGVTwSwk5vsEEuVJZ+ZCogcD696/sFcvngZ8s=;
 b=mMlI1kDAP548ZjSKvVTTg7t/m4lep7TDLgxyN6GGuoaaPEzVuRgOSZg2vsrIdRMvCWdJOqkeH589RJQ/Y74jdPaUh72K6ckWXO7LnY9kS/LH9LYp6pMRFgy2mNxpxvtBtQWM8hy42GZMPgyBxZhGNSTXhytJefrHJR6wEdnXswWUYb06ysnFfp2rCKpu3BuDJw+iVGrJeUy3sNVmGP+XrXcww2v3tm9YXmvvbX93SbrrhZ4CDjoSbOMA5RB3hWsMDvLN3DD8LP7k7QL/g3w8DdIXYMJRKZRu3uIJUJASYNIJgyZlCXcvkTzmytUYiT5RJngNgZngstH35pCmYrJWZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLlRqvdGVTwSwk5vsEEuVJZ+ZCogcD696/sFcvngZ8s=;
 b=JzG/KaGVoz9EM/juIWWoMmxewVrQJwfYIZklTneozP5obiFxihSdnPLbolLHJav41nEbfXLAQGPUbcIbtGHXu2zEPSZCpUquf7EbL1Ud/k+A+qO1XEKNVCZzUih/OFoyWiS3OkZ+np8FzXdAtq+Oo5xapcNspCwJLKMwJxH9sbc=
Received: from DM5PR15CA0027.namprd15.prod.outlook.com (2603:10b6:4:4b::13) by
 CH2PR12MB4021.namprd12.prod.outlook.com (2603:10b6:610:2b::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.7; Tue, 4 Jan 2022 23:41:45 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::58) by DM5PR15CA0027.outlook.office365.com
 (2603:10b6:4:4b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.16 via Frontend
 Transport; Tue, 4 Jan 2022 23:41:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Tue, 4 Jan 2022 23:41:45 +0000
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 4 Jan
 2022 17:41:45 -0600
Date:   Tue, 4 Jan 2022 17:35:17 -0600
From:   Michael Roth <michael.roth@amd.com>
To:     Sean Christopherson <seanjc@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Nathan Tempelman <natet@google.com>,
        Marc Orr <marcorr@google.com>,
        Steve Rutherford <srutherford@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Ricardo Koller <ricarkol@google.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        "Janosch Frank" <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        "Claudio Imbrenda" <imbrenda@linux.ibm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        "Suzuki K Poulose" <suzuki.poulose@arm.com>,
        <kvmarm@lists.cs.columbia.edu>
Subject: Re: [RFC PATCH 00/10] KVM: selftests: Add support for
 test-selectable ucall implementations
Message-ID: <20220104233517.kxjbdw4t7taymab5@amd.com>
References: <20211210164620.11636-1-michael.roth@amd.com>
 <Yc4gcJdhxthBKUUd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yc4gcJdhxthBKUUd@google.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3be571a6-3cb7-4414-5f5e-08d9cfdbc4f9
X-MS-TrafficTypeDiagnostic: CH2PR12MB4021:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB40218E908801E32AAFF7E3AF954A9@CH2PR12MB4021.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l3U2gnaiY8QcHRokiHA2uFp/PloRhzY3Y0BR1wQsylhv7XdpI1WNVC+kgy5cwmNRU1N8imiaxlWnm0UPi8i9hAIjdGF0Y491YAP0piFW6ELAfpDaTznrFqZDcQ2h+LYNbtlvghq57y1nUXa03Jg2uWbwT6ErBljj+DS/DtiG0X/QqDgRP32EWec+VKxmFfu2xwyoM0q9Lk1tcoYMk9QkeHM28sEugM6kFMTAeUv2BkwQfmjWpkfqY9MPRYKZZ1ySJP6nuzCwa5hnnZjw5NctBPN8GDQ1s01tSRKV4dEXlPocRAaTCfypRPTAYmD37jZdwCWJHaVgR/8G72Z+dI3WFx3txA1A97ynX5nhHNQ/pk+JJknSBcidNIputO9YJM4bPCBMAp/PBAIXZYBo/CczFzCX+o0sv9gVvc25kuwo5UnP8jk6IkFQUEqwaMtDBRZYXV8JMovv5tlMIX4CV+Lsi2KQXJ7e3GN88xrM3mMHgWFYm/fxivoBkFc6xtf1TWx12WJn5GlzJIOG3X0o3ptz1X+CeOGnCv6KCpPR2eQ6OPIKsZUGyEV9N75iwoSmNcrcsCtgJj2ysTJkm1vZGFcMH6a/X4mbjVDGZB41fE+WJI4ot9lWy/5sWQAIRk7WEf1Vt8LK/CGmzPV+UeKeL+iz/YfY2oDHhgBBPqBEbwk7M/W7fRMB623vFSU4b8unvKpFfA2TV5IsXq+wocupi4q8cwC7XJFIc25DZuZ042VuKF78ixWqE/2oV9bU9eNtKC5zp7Mxd8sgjHizG6xETb4nfAnHwsVPJrHGBrqIWnq8lRo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700002)(8936002)(26005)(8676002)(83380400001)(47076005)(7416002)(2906002)(4326008)(316002)(1076003)(44832011)(54906003)(16526019)(86362001)(40460700001)(186003)(82310400004)(6666004)(356005)(508600001)(70206006)(81166007)(6916009)(70586007)(426003)(36860700001)(336012)(5660300002)(36756003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 23:41:45.8319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be571a6-3cb7-4414-5f5e-08d9cfdbc4f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4021
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 30, 2021 at 09:11:12PM +0000, Sean Christopherson wrote:
> On Fri, Dec 10, 2021, Michael Roth wrote:
> > To summarize, x86 relies on a ucall based on using PIO intructions to generate
> > an exit to userspace and provide the GVA of a dynamically-allocated ucall
> > struct that resides in guest memory and contains information about how to
> > handle/interpret the exit. This doesn't work for SEV guests for 3 main reasons:
> > 
> >   1) The guest memory is generally encrypted during run-time, so the guest
> >      needs to ensure the ucall struct is allocated in shared memory.
> >   2) The guest page table is also encrypted, so the address would need to be a
> >      GPA instead of a GVA.
> >   3) The guest vCPU register may also be encrypted in the case of
> >      SEV-ES/SEV-SNP, so the approach of examining vCPU register state has
> >      additional requirements such as requiring guest code to implement a #VC
> >      handler that can provide the appropriate registers via a vmgexit.
> > 
> > To address these issues, the SEV selftest RFC1 patchset introduced a set of new
> > SEV-specific interfaces that closely mirrored the functionality of
> > ucall()/get_ucall(), but relied on a pre-allocated/static ucall buffer in
> > shared guest memory so it that guest code could pass messages/state to the host
> > by simply writing to this pre-arranged shared memory region and then generating
> > an exit to userspace (via a halt instruction).
> > 
> > Paolo suggested instead implementing support for test/guest-specific ucall
> > implementations that could be used as an alternative to the default PIO-based
> > ucall implementations as-needed based on test/guest requirements, while still
> > allowing for tests to use a common set interfaces like ucall()/get_ucall().
> 
> This all seems way more complicated than it needs to be.  HLT is _worse_ than
> PIO on x86 because it triggers a userspace exit if and only if the local APIC is
> not in-kernel.  That is bound to bite someone.

Hmmm, fair point. It's easy for me to just not use in-kernel APIC in
the current SEV tests to avoid the issue, but HLT is being made
available as an available ucall implementation for other tests as well,
and given in-kernel APIC is set up automatically maybe it's not robust
enough.

> not in-kernel.  That is bound to bite someone.  The only issue with SEV is the
> address, not the VM-Exit mechanism.  That doesn't change with SEV-ES, SEV-SNP,
> or TDX, as PIO and HLT will both get reflected as #VC/#VE, i.e. the guest side
> needs to be updated to use VMGEXIT/TDCALL no matter what, at which point having
> the hypercall request PIO emulation is just as easy as requesting HLT.

I'm not aware of any #VC handling needed for HLT in the case of
SEV-ES/SEV-SNP. That was one of the reasons for the SEV tests using
this ucall implementation. Of course, at some point, we'd want full support
for PIO/MMIO/etc. in the #VC handler, but it's not something I'd planned on
adding until after the SEV-SNP tests, since it seems like we'd need to
import a bunch of intruction decoding code from elsewhere in the kernel,
which is a lot of churn that's not immediately necessary for getting at least
some basic tests in place. Since the HLT implementation is only 20 lines of
code it seemed like a reasonable stop-gap until we start getting more CoCo
tests in place. But the in-kernel APIC issue probably needs more
consideration...

Perhaps for *just* PIO, the intruction decoding can be open-coded so it
can be added to the initial #VC handler implementation, which would avoid the
need for HLT implementation. I'll take a look at that.

> 
> I also don't like having to differentiate between a "shared" and "regular" ucall.
> I kind of like having to explicitly pass the ucall object being used, but that
> puts undue burden on simple single-vCPU tests.

I tried to avoid it, but I got hung up on that fact that pre-allocating
arrays/lists of ucall structs needs to be done for each VM, and so we'd
end up needing some way for a guest to identify which pool it's ucall
struct should be allocated from. But you've gotten around that by just
sync_global_to_guest()'ing for each pool at the time ucall_init() is
called, so the guest only ever sees it's particular pool. Then the switch
from writing GVA to writing GPA solves the translation problem. Nice.

> 
> The inability to read guest private memory is really the only issue, and that can
> be easily solved without completely revamping the ucall framework, and without
> having to update a huge pile of tests to make them place nice with private memory.

I think the first 5 patches in this series are still relevant cleanups
vs. having a complete standalone ucall implementation for each arch, and Andrew
has also already started looking at other header cleanups related to
patch #1, so maybe Paolo would still like to queue those. Would also
provide a better starting point for having a centralized allocator for
the ucall structs, which you hinted at wanting below.

But the subsequent patches that add the ucall_shared() interfaces should
probably be set aside for now in favor of your proposal.

> 
> This would also be a good opportunity to clean up the stupidity of tests having to
> manually call ucall_init(), drop the unused/pointless @arg from ucall_init(), and
> maybe even fix arm64's lurking landmine of not being SMP safe (the address is shared
> by all vCPUs).

I thought you *didn't* want to update a huge pile of tests :) I suppose
it's unavoidable, since with your proposal, having something like ucall_init()
being called at some point is required, as opposed to the current
implementation where it is optional. Are you intending to have it be
called automatically by vm_create*()?

> 
> To reduce the burden on tests and avoid ordering issues with creating vCPUs,
> allocate a ucall struct for every possible vCPU when the VM is created and stuff
> the GPA of the struct in the struct itself so that the guest can communicate the
> GPA instead of the GVA.  Then confidential VMs just need to make all structs shared.

So a separate call like:

  ucall_make_shared(vm->ucall_list)

? Might need some good documentation/assertions to make sure it gets
called at the right place for confidential VMs, and may need some extra
hooks in SEV selftest implementation for switching from private to shared
after the memory has already been allocated, but seems reasonable.

> 
> If all architectures have a way to access a vCPU ID, the ucall structs could be
> stored as a simple array.  If not, a list based allocator would probably suffice.

I think list allocator is nicer, generating #VCs for both the PIO and the
cpuid checks for vCPU lookup seems like a lot of extra noise to sift
through while debugging where an errant test is failing, and doesn't seem to
have any disadvantage vs. an array.

Thanks,

Mike
