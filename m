Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780CD485AC8
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jan 2022 22:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244480AbiAEVft (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jan 2022 16:35:49 -0500
Received: from mail-dm6nam12on2086.outbound.protection.outlook.com ([40.107.243.86]:56513
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244475AbiAEVfp (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jan 2022 16:35:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWvWwztZKOYKbUn8RduOyy3owagwvZ/fH3ijzPHunPo4I8xyVQ+f/fFdRgkJSLN6wC2jnLoysLu34ussvBISzuO/Gs0AnkMksgD1ELNxjJhkGMo5ImPJcSXgSi4TJX+/MGVr3laUUOZ5uPixhUaUcUrfVmjyMbbg1Ea/D0U9qOI9ISCleQcTTSmxRG6Fd+jAxNh7XHzFcvkdV5JWuTS/lSZa71LjCVqNl2M9LJTeDNO8iz6jDLJ1mXdwT6zyaQgfDlh74bxVU9X+d6X8PL6dCz56AKrV27SHpewB1kPyCgOM4jAg1JjcWtsMzmy1wKiEBebmDkzOVdVXjptUcETo/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gv+NXoWxoVuQdXxbNp7fCof1XJIbw+vN3r9cSsMyZxw=;
 b=dJZLUHwyWbpTWnOPcl3YeknNgos609WJLHCDLvoJIwlXyAyrW/d7P4V1HFJgWuIg9BQzVq1VqH5Lu9humpjIRCLu+IMJG/65zIMWeUh7fU7w3bukPGRTvsDi/ccKYcXAo4GbkKz7Tn5T62b8x6uhrqXwPxWVhHhp1lRHrK6zvaC1zFmdoWu7g+bZaB0rjnHYbW3mn8mXw/2EGG5t7isLyszFlsLiDUCpy2BjDqITFBdVHziN2LzLcUsMHxRAFl7GDRzuIKh8ez49+YgyHFkQGXDestI53qk++r9a+hGPFGX/QCBfUT1g3FTP3DjH36OhpDXaXOoZZ5oRcbfUG9+Zfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gv+NXoWxoVuQdXxbNp7fCof1XJIbw+vN3r9cSsMyZxw=;
 b=s3boD5bfyEbEjdvqCy+EWbJKRKQVoe2NzYS7jLCIu/3nHSv5j3lsNOD2P4ic0CbM594bq0p8PH17v21X9Y8te88U482acs8si7IQoJrm4DvdjSf863jyJZ039lJjqDeZeSZlVB4+Minuk5yQeQ34uZ9J1lkQTpeNuEFT3yo3Ilw=
Received: from CO2PR05CA0055.namprd05.prod.outlook.com (2603:10b6:102:2::23)
 by BL1PR12MB5364.namprd12.prod.outlook.com (2603:10b6:208:314::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 21:35:43 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:2:cafe::10) by CO2PR05CA0055.outlook.office365.com
 (2603:10b6:102:2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.4 via Frontend
 Transport; Wed, 5 Jan 2022 21:35:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Wed, 5 Jan 2022 21:35:42 +0000
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 5 Jan
 2022 15:35:41 -0600
Date:   Wed, 5 Jan 2022 15:35:19 -0600
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
Message-ID: <20220105213519.g746jzf756nax562@amd.com>
References: <20211210164620.11636-1-michael.roth@amd.com>
 <Yc4gcJdhxthBKUUd@google.com>
 <20220104233517.kxjbdw4t7taymab5@amd.com>
 <YdTjnRZQID5IabK0@google.com>
 <20220105170244.jwr6i2erecbhx3fz@amd.com>
 <YdXYuaoXJux6lHrF@google.com>
 <20220105191107.qx67wf2coc3q6giu@amd.com>
 <YdX0SRoBXReggrVA@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YdX0SRoBXReggrVA@google.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0cb7c35-5e5f-4a7b-4adc-08d9d093531c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5364:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5364F048D36D0A034F3E85F6954B9@BL1PR12MB5364.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: icilStvPUmzxfmhLP05ZpbxXQ9VxjZume+O5pTCK/bjm6q0DMtjdeXTy6midc/J1X9pQ/McQDEmV5DKIuSVJRYat9eOAvy06J44mNZ+h4ZQP1bzhH7v36EzvEpxNnWh6LwFXGyMb+l0mf6A7IFRsh3xke/BvDsE1j3FZNqqO++kBkvHcNBfcTiy5MKONOA6Vh+J0NuCTpCuMwCQjinH8wrdKW1ngepxm7hV/CTHCciv1TcX+s8GCTiHGlecZt9rWhk71OwggkTo4hxB55ksmp0DWAlIzyUv5O58tDx4rEGkmwN6c2J/mt1hZ917voeXqOXAsiKmck0cISIBXdKBgOmfWi3HUzFO+ZXjFFyUdFpIn+JH+M0gpzxRho4HzS1tMIyr7rFIlkhNt/sIdmmHPkvH4vOKPqVWPmbpe2Fm4L0GBc1q0RY7buQ3jYoKkx77KKlDgkxuLdEi9ZNDvVHcLLxvO3TtOi2yGYsPS/UkmH2j3uF98dspQaCpkraLPbNMcIjmkQcjCYxU/NoavOi5cqYIRkNEATIUqs3kqSN7ShMRmLYWvoXW7PgVH0I1iFvFd2OwJ86DkPTQfmhQFZiwpD3dHq2Jxns8PiQFQgntpODxmHYcqs/99m0L4lqp75bLvJB6HVYSIIVbZ/V4mCIEG8B4QDt+gkBYzSa45m1Wgje30f+s6N4+l51aVBDrleYgDAU2H6opq6mUyPCXlcMFuyMDyDiAzZLG8mJpSTgL3WcVTkFXNU5N/XDcRd+FXlP89seoRXmCBKqlyJOWY8gCod56pvi9sy0RwWSfSWDb29M8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700002)(508600001)(6916009)(4326008)(2906002)(26005)(186003)(7416002)(44832011)(316002)(8936002)(336012)(16526019)(86362001)(426003)(8676002)(54906003)(40460700001)(47076005)(83380400001)(82310400004)(36756003)(36860700001)(81166007)(2616005)(5660300002)(1076003)(6666004)(356005)(70206006)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 21:35:42.1206
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0cb7c35-5e5f-4a7b-4adc-08d9d093531c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5364
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 05, 2022 at 07:40:57PM +0000, Sean Christopherson wrote:
> On Wed, Jan 05, 2022, Michael Roth wrote:
> > On Wed, Jan 05, 2022 at 05:43:21PM +0000, Sean Christopherson wrote:
> > > Because it uses multiple VMs, and my rough sketch only allows for a single VM to
> > > use ucall.  Though I suppose we could simply keep appending to the ucall list for
> > > every VM.  The requirement would then be that all VMs are of the same type, i.e.
> > > utilize the same ucall_ops.
> > 
> > Hmm, maybe I misread your patch. Not supporting multiple VMs was the
> > reason I gave up on having the ucall structs allocated on-demand and
> > went with requiring them to be passed as arguments to ucall().
> > 
> > I thought with your patch you had solved that by having each vm have it's
> > own pool, via vm->ucall_list, and then mapping each pool into each guest
> > separately via:
> > 
> >   ucall_init(vm):
> >     ucall_list = vm->ucall_list
> >     sync_global_to_guest(ucall_list).
> > 
> > then as long as that ucall_init() is done *after* the guest calls
> > kvm_vm_elf_load(), it will end up with a 'ucall_list' global that points
> > to it's own specific vm->ucall_list. Then on the test side it doesn't
> > matter what the 'ucall_list' global is currently set to since you have
> > the GPA and know what vm exited.
> > 
> > Or am I missing something there?
> 
> Ha, that was not at all intented.  But yes, it should work.  I'd rather be lucky
> than good?

:)

> 
> > Although even if that is the case, now that we're proposing doing the
> > ucall_init() inside vm_create(), then we run the risk of a test calling
> > kvm_vm_elf_load() after, which might clobber the guest's copy of
> > ucall_list global if ucall_init() had since been called for another VM.
> > But that could maybe be worked around by having whatever vm_create()
> > variant we use also do the kvm_vm_elf_load() unconditionally as part of
> > creation.
> 
> Will sync_global_to_guest() even work as intended if kvm_vm_elf_load() hasn't
> been called?  If not, then sync_global_{to,from}_guest() should really assert if
> the test hasn't been loaded.

Yah, seems like it would get clobbered by kvm_vm_elf_load() later. And
can't think of any good reason to use sync_global_to_guest() without also
needing kvm_vm_elf_load() at some point, so makes sense to enforce it.

> 
> As for ucall_init(), I think the best approach would be to make kvm_vm_elf_load()
> a static and replace all calls with:
> 
> 	kvm_vm_load_guest(vm);
> 
> where its implementation is:
> 
>   void kvm_vm_load_guest(struct kvm_vm *vm)
>   {
>   	kvm_vm_elf_load(vm, program_invocation_name);
> 
> 	ucall_init(vm);
>   }
> 
> The logic being that if a test creates a VM but never loads any code into the guest,
> e.g. kvm_create_max_vcpus, then it _can't_ make ucalls.

Makes sense. And if different ops are needed for vmgexit()/tdcall() it
could be something like (if based on patches 1-5 of this series, and
extending vm_guest_mode as you suggested earlier):

   void kvm_vm_load_guest(struct kvm_vm *vm)
   {

     kvm_vm_elf_load(vm, program_invocation_name);
  
     if (vm->mode == VM_MODE_SEV)
  	    ucall_init_ops(vm, ucall_ops_pio_vmgexit);
     else (vm->vm_type == VM_MODE_TDX)
  	    ucall_init_ops(vm, ucall_ops_pio_tdcall);
     else
  	    ucall_init_ops(vm, ucall_ops_pio);

Shame we have to update all the kvm_vm_elf_load() call-sites, but
they'd end up potentially breaking things if left as-is anyway.

Were you planning on sending patches for these changes, or should I incorporate
your prototype and take a stab at the other changes as part of v2 of this
series?
