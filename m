Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2D94856FF
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jan 2022 18:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242102AbiAERDF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jan 2022 12:03:05 -0500
Received: from mail-bn7nam10on2070.outbound.protection.outlook.com ([40.107.92.70]:5120
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242066AbiAERDE (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jan 2022 12:03:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltj0gxp4f0Ns9bswVemQgUEBA20dYAD0x6dmcajHZ//UYjagy+UZD0N0bKkg/rtOJzsKtwQCdNi5RYPLk7BmKkiCySndjQLJUHfGJmE24oQW1kALSesPVPnI00g6HCzV3ejeYPFNTVKEuYlf6vyWcVGf/oWj4LzlpphX4iKa/04jjOc8x7wqx5UG3NbJtXtFEwmZHVXLTZE4QLyqcEeiCenQbMs2Jnl8atP4cQR/Qmhs1OMqnaOB4xxmqVKOEGJbsRebGsFvLmS8k7Em3OjwfXWpKp/y8aY8f5ZGSdYI12cZ2gur2tNz6+TF5GLUef1rP27kvaQhoLOqWB6cdEI2JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2s9Z4j0Fuyhd9rzUN4yCZCvYx9VxGT9WK2VS6OKdoo=;
 b=HWSYQAR38H5ZsghkMpo2LxPvEkLC0NSdQ7VYe4Mk24991EaYc0IwicnC50jSKMy1Vw6dbEYEN5zrqw2ZYcqzMcNLighJWT0fHGBYDSKj2zOusmWNdMShi+U+ueAQ6Oq68cKQejIQyXagKDQsobpAbO0EdrsrOHGpV9s0qs0v9XrM2QFBmwxEpYaBAROUOlnCIIxiJMnJRpYr65oP6yXymiJJTvgaG/OMOWdsspssxq4jwwdqMeKGdOCOTVdAPAU2e4nney+CVWWvhzq9yh3r09Ecyn6RGMSfHKhFTux42J+azVQmgUFMZoiUN5mViRPeEZdSCK57q7oY3es1ARhEnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2s9Z4j0Fuyhd9rzUN4yCZCvYx9VxGT9WK2VS6OKdoo=;
 b=bJIJbRyb8BSpGOnqOMxo8mXdyJuNLhS8+Bj5AfVOrVT0kocs50ovPa9khP4xLN90CkaL/MSsTICSDHnLJ4+BU750ufK2e5lznhuicngqMJzTus/6bZoZ+Y6TjHXvRRBZCFutYSDjAnHoxvfZjJ0pzV5643slCXRzcfwDRRDhr80=
Received: from BN7PR06CA0072.namprd06.prod.outlook.com (2603:10b6:408:34::49)
 by DM6PR12MB3628.namprd12.prod.outlook.com (2603:10b6:5:3d::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 17:03:02 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::18) by BN7PR06CA0072.outlook.office365.com
 (2603:10b6:408:34::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Wed, 5 Jan 2022 17:03:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Wed, 5 Jan 2022 17:03:02 +0000
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 5 Jan
 2022 11:03:01 -0600
Date:   Wed, 5 Jan 2022 11:02:44 -0600
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
Message-ID: <20220105170244.jwr6i2erecbhx3fz@amd.com>
References: <20211210164620.11636-1-michael.roth@amd.com>
 <Yc4gcJdhxthBKUUd@google.com>
 <20220104233517.kxjbdw4t7taymab5@amd.com>
 <YdTjnRZQID5IabK0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YdTjnRZQID5IabK0@google.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d185ae54-3443-428d-1736-08d9d06d3bcd
X-MS-TrafficTypeDiagnostic: DM6PR12MB3628:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3628C58EC79B17AB334D48DD954B9@DM6PR12MB3628.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ujRaMNgUX0lGMFO0fQYYTLrm68EE+hD8z2BVmsn80Var+TdvPj/GsMKU8ltFcxsszlN9IS49K6DV212R0xDGA3cSxzIwYLN1TtsPKUSBDltNn+LxdjU+zqVl8aGVy8vMHV1YErczuPLPT9iOKZzewmVdvtHwDJE6PPLZm1qxKTAw/XW+EKkcje+TBPv1YT50NxXrUaGEyxSZV5BbXzCIetU49Tae4NHk+NKq4BcY1Lw6KRMiymmHDMKFsjXOi0WcyLQLu/w7FxnyMjZP/Joe4oPT9jVgqFmSeLYQFOg0WeRPbDhLg8MxovtPsE+1ZtwGuE/14LAoOhH90CB+IIHsQh/s21IE5VvBQhh2rlX+qBMFowzxlUdnc4AKLbMSe+MQFKpsdmTRQZn8CS8LlX+43DK1Kkl+63cW1phdR4CUHX5EiuyUnEoYZ+zxtHSyrgCrihyCqaC+kriSBggoO9GL/ZM4ITcEmH0lgPk5OwIUegJKxQO41TEkweySdigAKcnuZduI7ow0yUJB6QH9HLjVZXmuck9hAdyjvpmQRUESeJY2CDqYS/X6HTYVCXDzPJL+0MreLDJCP/jBo5Vhm1ULHaqgbNOD+Zhl2hmIJ6P7pGzbz5mbvrLRI+p1m6x/nB1HG/vYUDyvSQhOY3aPyBnRupvPMgkcdyzPQwrxLpDrQJcW/vVhNNvAW6ZYaZ9cEXQI0T10sdYQIqj3dSSlfWAlQaHu6oHavfepsHd+gctWKgJRuRnYkqOES+jJTVeZVg3WAT6GPrO1fJn4iGTFWAbZTQ0fnm6XZUSyI01kTTqzvgQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(40470700002)(36840700001)(46966006)(86362001)(47076005)(508600001)(6916009)(83380400001)(4326008)(81166007)(316002)(54906003)(70586007)(426003)(2906002)(5660300002)(336012)(16526019)(186003)(70206006)(6666004)(44832011)(2616005)(26005)(40460700001)(356005)(8676002)(1076003)(36756003)(8936002)(7416002)(82310400004)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 17:03:02.2476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d185ae54-3443-428d-1736-08d9d06d3bcd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3628
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 05, 2022 at 12:17:33AM +0000, Sean Christopherson wrote:
> On Tue, Jan 04, 2022, Michael Roth wrote:
> > On Thu, Dec 30, 2021 at 09:11:12PM +0000, Sean Christopherson wrote:
> > > not in-kernel.  That is bound to bite someone.  The only issue with SEV is the
> > > address, not the VM-Exit mechanism.  That doesn't change with SEV-ES, SEV-SNP,
> > > or TDX, as PIO and HLT will both get reflected as #VC/#VE, i.e. the guest side
> > > needs to be updated to use VMGEXIT/TDCALL no matter what, at which point having
> > > the hypercall request PIO emulation is just as easy as requesting HLT.
> > 
> > I'm not aware of any #VC handling needed for HLT in the case of
> > SEV-ES/SEV-SNP. That was one of the reasons for the SEV tests using
> > this ucall implementation.
> 
> Ah, you're right, HLT is an "automatic" exit and the CPU takes care of adjusting
> RIP.  TDX is the only one that requires a hypercall.
> 
> > Of course, at some point, we'd want full support for PIO/MMIO/etc. in the #VC
> > handler, but it's not something I'd planned on adding until after the SEV-SNP
> > tests, since it seems like we'd need to import a bunch of intruction decoding
> > code from elsewhere in the kernel, which is a lot of churn that's not
> > immediately necessary for getting at least some basic tests in place. Since
> > the HLT implementation is only 20 lines of code it seemed like a reasonable
> > stop-gap until we start getting more CoCo tests in place. But the in-kernel
> > APIC issue probably needs more consideration...
> > 
> > Perhaps for *just* PIO, the intruction decoding can be open-coded so it
> > can be added to the initial #VC handler implementation, which would avoid the
> > need for HLT implementation. I'll take a look at that.
> 
> PIO shouldn't require instruction decoding or a #VC handler.  What I was thinking
> is that the guest in the selftest would make a direct #VMGEXIT/TDCALL to request
> PIO instead of executing an OUT.  

That seems like a nicer approach. But it sort of lends itself to having
test-specific ucall implementations in some form. How are you thinking
vm_create() should decide what implementation to use? With this series
in place it could be something like:

  vm_create(..., struct ucall_ops *ops)
    ucall_init_ops(ops)

and with the SEV selftests in their current form it would look something
like:

  sev_vm_create(...)
    vm_create_with_ucall(..., ops=ucall_ops_pio_vmgexit)
      ucall_init_ops(ops)

is that sort of what you're thinking, or something else?

> 
> > > I also don't like having to differentiate between a "shared" and "regular" ucall.
> > > I kind of like having to explicitly pass the ucall object being used, but that
> > > puts undue burden on simple single-vCPU tests.
> > 
> > I tried to avoid it, but I got hung up on that fact that pre-allocating
> > arrays/lists of ucall structs needs to be done for each VM, and so we'd
> > end up needing some way for a guest to identify which pool it's ucall
> > struct should be allocated from. But you've gotten around that by just
> > sync_global_to_guest()'ing for each pool at the time ucall_init() is
> > called, so the guest only ever sees it's particular pool. Then the switch
> > from writing GVA to writing GPA solves the translation problem. Nice.
> > 
> > > 
> > > The inability to read guest private memory is really the only issue, and that can
> > > be easily solved without completely revamping the ucall framework, and without
> > > having to update a huge pile of tests to make them place nice with private memory.
> > 
> > I think the first 5 patches in this series are still relevant cleanups
> > vs. having a complete standalone ucall implementation for each arch, and Andrew
> > has also already started looking at other header cleanups related to
> > patch #1, so maybe Paolo would still like to queue those. Would also
> > provide a better starting point for having a centralized allocator for
> > the ucall structs, which you hinted at wanting below.
> > 
> > But the subsequent patches that add the ucall_shared() interfaces should
> > probably be set aside for now in favor of your proposal.
> > 
> > > 
> > > This would also be a good opportunity to clean up the stupidity of tests having to
> > > manually call ucall_init(), drop the unused/pointless @arg from ucall_init(), and
> > > maybe even fix arm64's lurking landmine of not being SMP safe (the address is shared
> > > by all vCPUs).
> > 
> > I thought you *didn't* want to update a huge pile of tests :) I suppose
> > it's unavoidable, since with your proposal, having something like ucall_init()
> > being called at some point is required, as opposed to the current
> > implementation where it is optional. Are you intending to have it be
> > called automatically by vm_create*()?
> 
> Yeah, I was thinking it could be done at the lowest level vm_create() helper.
> We'll need to expand vm_create() (or add yet another layer to avoid modifying a
> pile of tests) to allow opting out of initializing ucall, e.g. sev_migrate_tests.c
> needs to create multiple concurrent VMs, but happily doesn't need ucall support.

Why does sev_migrate_tests need to opt out? Couldn't it use
ucall_ops_pio_vmgexit like that SEV case above?

I ask because there is a ucall() in the exception handling code where
some unhandled exceptions result in the guest automatically issuing a
ucall(UCALL_UNHANDLED), so even when tests don't use ucall() they
might still rely on it if they enable exception handling. So that might
be an argument for always setting up at least the default ucall_ops_pio
implementation and creating a pool just in case. (or an argument for
dropping the UCALL_HANDLED handling).

> 
> > > To reduce the burden on tests and avoid ordering issues with creating vCPUs,
> > > allocate a ucall struct for every possible vCPU when the VM is created and stuff
> > > the GPA of the struct in the struct itself so that the guest can communicate the
> > > GPA instead of the GVA.  Then confidential VMs just need to make all structs shared.
> > 
> > So a separate call like:
> > 
> >   ucall_make_shared(vm->ucall_list)
> > 
> > ? Might need some good documentation/assertions to make sure it gets
> > called at the right place for confidential VMs, and may need some extra
> > hooks in SEV selftest implementation for switching from private to shared
> > after the memory has already been allocated, but seems reasonable.
> 
> Again, I was thinking that it would be done unconditionally by ucall_init(), i.e.
> would be automatically handled by the selftest framework and would Just Work for
> individual tests.

Ok, I'll have to think that through more. Currently with the SEV
selftests as they we have:

  sev_vm_create(policy, npages)
    vm = vm_create(...)
    vm_set_memory_encryption(vm, encrypt_by_default, enc_bit)
    //vm_vaddr_alloc_shared() can be used now

The ucall struct allocations would need to go through
vm_vaddr_alloc_shared() to make sure the selftest library tracks/maps
the pages as shared, but that vm_set_memory_encryption() happens too
late if the ucall_init() stuff is done in vm_create(). It should be
possible to pass the vm_set_memory_encryption() arguments directly to
vm_create() to allow for what you're proposing, but I guess we'd need
a new vm_create() wrapper that handles both the
vm_set_memory_encryption() args, along with the ucall_ops above,
something like:

  sev_vm_create(policy, npages)
    vm = vm_create_coco(..., encrypt_by_default, enc_bit/shared_bit, ucall_ops)

Or were you thinking something else? Just trying to get an idea of how
this will all need to tie in with the SEV selftests and what needs to
change on that end.
