Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFA94858EC
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jan 2022 20:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243368AbiAETL2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jan 2022 14:11:28 -0500
Received: from mail-mw2nam10on2047.outbound.protection.outlook.com ([40.107.94.47]:3265
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243347AbiAETL2 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jan 2022 14:11:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAvodGEUaRNfSmyqTaoX02G5NkoVuB2e1ewWAss8V7nP0HAkkbMJVJBCtoG51niRFu1QJFJqF9SZrHH/9Qa89Kq+O8RBhAJexdBcUFikzdWBePmM7fRYsQClpDM8yTFbKp4BzGchWDimblBJXLs4dQRatZUVKWh3LLQ6/zeDb6VcbDMobvhtRAubLal90mHsjqrq4oOdcjXRl9kWhDMua7FCd4zdt6C6CN52BVbq5V4ds6KdxXaQAFMWnUoCIggJpTRBcR5VExBjFI0N989oSZIk+eor0A+djSLNBhFmlm5389djiEqnKU1B2x/FMDLkonz72JhuTmw6V0DGBHXClQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIuNzDOxSf19yUugB/j54/pT5U/Qyd6/5hcaLDlZG4I=;
 b=JGs+rOquJF/U/qUCwCrPfuyQvj3saj/V+TYclJIVF7MQwUbsB61/G1f7iI7OUPzWDGvd1Ink9TfIANvVhmH/k5nIP/5bFknBsbS7HGIqATjuU0hU4aC+UlXTF4BYoB+X2ok9Qn2eTUT/whJ7w7KXFjjebHRYRJMNsmQ3csT8eAHSfVVLHgwEdXHvM698eshINSpnbqGxQ8VslfpCNSQ9wIRY1k+/pJ2flPEYn9YaWAMvvIFwaCVTus9KeP4HcvSpL818Rp+VMd9Mn5WOx4mzkmwvlrGyoNAwbv8GdTRWLkZJYhgaYmfGa1kqIM9fRDQshXRnOjgBnxlA5e3jjdhkww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIuNzDOxSf19yUugB/j54/pT5U/Qyd6/5hcaLDlZG4I=;
 b=3KOIXDqHGtK3aWfFOYrpVJOrnEOfMGna5owbglIGrOo0nzwCXvLnh+hptKMRouDrRLKxbhv24UKjHrP2Lwc9WzRZi/4f28YavWMIuK6LqbGZS8LzoH5vCShkilkykFkRRhcDwZ5awgn2+8g5He2u7Cbn1dKpX+fd5sSZqeaNtSI=
Received: from DM6PR03CA0009.namprd03.prod.outlook.com (2603:10b6:5:40::22) by
 CH2PR12MB3928.namprd12.prod.outlook.com (2603:10b6:610:23::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.9; Wed, 5 Jan 2022 19:11:24 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::6f) by DM6PR03CA0009.outlook.office365.com
 (2603:10b6:5:40::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9 via Frontend
 Transport; Wed, 5 Jan 2022 19:11:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.9 via Frontend Transport; Wed, 5 Jan 2022 19:11:23 +0000
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 5 Jan
 2022 13:11:23 -0600
Date:   Wed, 5 Jan 2022 13:11:07 -0600
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
Message-ID: <20220105191107.qx67wf2coc3q6giu@amd.com>
References: <20211210164620.11636-1-michael.roth@amd.com>
 <Yc4gcJdhxthBKUUd@google.com>
 <20220104233517.kxjbdw4t7taymab5@amd.com>
 <YdTjnRZQID5IabK0@google.com>
 <20220105170244.jwr6i2erecbhx3fz@amd.com>
 <YdXYuaoXJux6lHrF@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YdXYuaoXJux6lHrF@google.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99a7daec-1492-424c-fdde-08d9d07f2a53
X-MS-TrafficTypeDiagnostic: CH2PR12MB3928:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3928D13D8268280E7A5B3268954B9@CH2PR12MB3928.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rZD0vNzNDti8R4dG8QOSzfCbvHmJo+AH2+m8Wpe2EF1Ckv6NYvjNiDAT6osGSOyI8+fbEve8hwCJj9XyjbOyd7m5uWJFCQSsTAIVo53kL4NlGSfEeq5ieLf2iL5FSgV2/S47BtTf4fyKNDc+GXTtL33yOLP3QruftLZEXZMhtjykE53EJ2dr/pMKARmPbex+wKoP+v2PxBuBdsZHdSU0K6FVwcbkR5B/2g+m1ryDAvw5yDIcrVJHR+1Pq4tEyLHSZrdDLeq7hDtonSCsbYknjYponBe6Un2mqA0E1g7PW51Bay2+FnZia1XdqIBrgflukYQlSuqAH7HDSEIYetQTYn+ysVOVg1Uu+471giIvG3oy6FIhd01pGi/CHuV3U7lODizc74mPJeuNF/rlQPIo7PnrStedQwXlbsb4mUe0/GmSmE2hOKIRCIBk4tMK0y9+QVGQ/lM1tpozk2yMUAZwXy7Bgjk4fFs2rVDu9GDxqvmWDqEI6mncIo/QA4Hm7TJ3qGtjcbdU4kPitMX3Qvy42B8kMit6heuVy+KmKihis1GYBMsoO2WAZlknwPR2U23aP2Pgt52fEiGqXFMwrIMIEsmyyeTMGPNvapl+f2iaDyo9wgZHdnl8pDDpepLmOK4SZDs0MifE8ao1vfFyDIOTWDeelHOPp7PB9KxFkPduL95vLJqTLsjlE9ICh+Ooq/BjgQM/FWCUphuO9yYc8ljvDeI/TAw7qIWNfLNqBvIJ4vM9Q33Fw0GRPB4oVdMQKS6lfJZyHtb6B/EkBU2jUX0UmC9ZCYEnVFg+0NK6QB/vzEA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(40470700002)(36840700001)(1076003)(83380400001)(54906003)(356005)(6916009)(316002)(6666004)(36860700001)(8676002)(82310400004)(26005)(44832011)(2616005)(16526019)(186003)(8936002)(36756003)(336012)(70206006)(70586007)(508600001)(86362001)(2906002)(81166007)(47076005)(7416002)(40460700001)(5660300002)(4326008)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 19:11:23.8426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a7daec-1492-424c-fdde-08d9d07f2a53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3928
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 05, 2022 at 05:43:21PM +0000, Sean Christopherson wrote:
> On Wed, Jan 05, 2022, Michael Roth wrote:
> > On Wed, Jan 05, 2022 at 12:17:33AM +0000, Sean Christopherson wrote:
> > > PIO shouldn't require instruction decoding or a #VC handler.  What I was thinking
> > > is that the guest in the selftest would make a direct #VMGEXIT/TDCALL to request
> > > PIO instead of executing an OUT.  
> > 
> > That seems like a nicer approach. But it sort of lends itself to having
> > test-specific ucall implementations in some form. How are you thinking
> > vm_create() should decide what implementation to use? With this series
> > in place it could be something like:
> > 
> >   vm_create(..., struct ucall_ops *ops)
> >     ucall_init_ops(ops)
> > 
> > and with the SEV selftests in their current form it would look something
> > like:
> > 
> >   sev_vm_create(...)
> >     vm_create_with_ucall(..., ops=ucall_ops_pio_vmgexit)
> >       ucall_init_ops(ops)
> > 
> > is that sort of what you're thinking, or something else?
> 
> I keep forgetting ucall() doesn't have access to the VM.  But, since we're
> restricing ucall() to a single VM, we can have a global that sets ucall_ops during
> ucall_init() based on the VM type, or skip an ops and just open code the behavior
> in x86's ucall() by snapshotting the VM type.  Either way, the goal is to avoid
> having to pass in ucall_ops at the test level.
> 
> > > Yeah, I was thinking it could be done at the lowest level vm_create() helper.
> > > We'll need to expand vm_create() (or add yet another layer to avoid modifying a
> > > pile of tests) to allow opting out of initializing ucall, e.g. sev_migrate_tests.c
> > > needs to create multiple concurrent VMs, but happily doesn't need ucall support.
> > 
> > Why does sev_migrate_tests need to opt out? Couldn't it use
> > ucall_ops_pio_vmgexit like that SEV case above?
> 
> Because it uses multiple VMs, and my rough sketch only allows for a single VM to
> use ucall.  Though I suppose we could simply keep appending to the ucall list for
> every VM.  The requirement would then be that all VMs are of the same type, i.e.
> utilize the same ucall_ops.

Hmm, maybe I misread your patch. Not supporting multiple VMs was the
reason I gave up on having the ucall structs allocated on-demand and
went with requiring them to be passed as arguments to ucall().

I thought with your patch you had solved that by having each vm have it's
own pool, via vm->ucall_list, and then mapping each pool into each guest
separately via:

  ucall_init(vm):
    ucall_list = vm->ucall_list
    sync_global_to_guest(ucall_list).

then as long as that ucall_init() is done *after* the guest calls
kvm_vm_elf_load(), it will end up with a 'ucall_list' global that points
to it's own specific vm->ucall_list. Then on the test side it doesn't
matter what the 'ucall_list' global is currently set to since you have
the GPA and know what vm exited.

Or am I missing something there?

Although even if that is the case, now that we're proposing doing the
ucall_init() inside vm_create(), then we run the risk of a test calling
kvm_vm_elf_load() after, which might clobber the guest's copy of
ucall_list global if ucall_init() had since been called for another VM.
But that could maybe be worked around by having whatever vm_create()
variant we use also do the kvm_vm_elf_load() unconditionally as part of
creation.

> 
> > I ask because there is a ucall() in the exception handling code where
> > some unhandled exceptions result in the guest automatically issuing a
> > ucall(UCALL_UNHANDLED), so even when tests don't use ucall() they
> > might still rely on it if they enable exception handling. So that might
> > be an argument for always setting up at least the default ucall_ops_pio
> > implementation and creating a pool just in case. (or an argument for
> > dropping the UCALL_HANDLED handling).
> 
> The sev_migrate_tests don't even run a guest, hence the quick-and-dirty "solution".
> Though thinking toward the future, that may be too dirty as it would prevent tests
> from having multiple "real" VMs.
> 
> > > > > To reduce the burden on tests and avoid ordering issues with creating vCPUs,
> > > > > allocate a ucall struct for every possible vCPU when the VM is created and stuff
> > > > > the GPA of the struct in the struct itself so that the guest can communicate the
> > > > > GPA instead of the GVA.  Then confidential VMs just need to make all structs shared.
> > > > 
> > > > So a separate call like:
> > > > 
> > > >   ucall_make_shared(vm->ucall_list)
> > > > 
> > > > ? Might need some good documentation/assertions to make sure it gets
> > > > called at the right place for confidential VMs, and may need some extra
> > > > hooks in SEV selftest implementation for switching from private to shared
> > > > after the memory has already been allocated, but seems reasonable.
> > > 
> > > Again, I was thinking that it would be done unconditionally by ucall_init(), i.e.
> > > would be automatically handled by the selftest framework and would Just Work for
> > > individual tests.
> > 
> > Ok, I'll have to think that through more. Currently with the SEV
> > selftests as they we have:
> > 
> >   sev_vm_create(policy, npages)
> >     vm = vm_create(...)
> >     vm_set_memory_encryption(vm, encrypt_by_default, enc_bit)
> >     //vm_vaddr_alloc_shared() can be used now
> > 
> > The ucall struct allocations would need to go through
> > vm_vaddr_alloc_shared() to make sure the selftest library tracks/maps
> > the pages as shared, but that vm_set_memory_encryption() happens too
> > late if the ucall_init() stuff is done in vm_create(). It should be
> > possible to pass the vm_set_memory_encryption() arguments directly to
> > vm_create() to allow for what you're proposing, but I guess we'd need
> > a new vm_create() wrapper that handles both the
> > vm_set_memory_encryption() args, along with the ucall_ops above,
> > something like:
> > 
> >   sev_vm_create(policy, npages)
> >     vm = vm_create_coco(..., encrypt_by_default, enc_bit/shared_bit, ucall_ops)
> > 
> > Or were you thinking something else? Just trying to get an idea of how
> > this will all need to tie in with the SEV selftests and what needs to
> > change on that end.
> 
> Hmm, I was thinking the selftest framework would only need to be told the VM type,
> e.g. DEFAULT, SEV, SEV-ES, SEV-SNP, or TDX, and would then handle setting everything
> up, e.g. enumerating the C-bit location and encrypting memory as needed.
> 
> One thought would be to extend "enum vm_guest_mode" with flags above NUM_VM_MODES
> to specify the VM type.  That way tests that use VM_MODE_DEFAULT would continue to
> work without any updates.

Ok, let me see what that approach looks like on the SEV selftest side.
