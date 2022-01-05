Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1DF485BB3
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jan 2022 23:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245064AbiAEWdZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jan 2022 17:33:25 -0500
Received: from mail-dm6nam10on2047.outbound.protection.outlook.com ([40.107.93.47]:33159
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245052AbiAEWdY (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jan 2022 17:33:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+CmWPgxdoEAdmqiJ7JtNgtbC0y+9hAGo//53QGcAPoFnKHI3BjGwoWqoMemh4qt1ZFh5amI/ejsc+GFy7ACkYmZrIdlSpFA9hXumoST5HlNkZfuuSpcHI3m/PAeQiRxftVKA3Tow5InbS5c6HKEkDtZT2tDX7qDGN5cqQac06zV4l1SK97X0BsCzXCqsEfg7A1RGyDBq5nICJUJLusM4YN7A6E7IwArBpz6OEgovW+RtnsXotNxvHnSTMIli1DwATTyIySN6onSgEO23ywDdb4LUrMBevjSld5E/NUJh9x8M386SEnfz3r1WiqpRwPFDzVytGX/G+QGET5nCC3XKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mI9fGJNSDSeDVRj3b/ragI3b4Qd32j/j/dczaV02WTE=;
 b=a2QNRk44XEVUvQidcKv2pp3SHuHtL/dQuBKB9tdPXZmAg01Ewqv9tOXEsYX/IdhPnAUyQnDlWA+aR/lI+J7lQ6YpPMvh5MGR8NQoOGT3qxNZyNp1tEsQrgSkE8Ey/0FuhFdQ/zN5yZyPdbp8PDdL0tSNfyEN/NtF5BKNGSNQaf5T1M5sLFo4RGriGF97tWvVcid6tjdj7l6GU88fkRlQs8JIq4sCg49naMg5WvvU+Cu+k9A2F3C7Lv+t1Dg2JiLS/+gkZTEWyedwXWBrsDHmcAM/rnIVY7cl3QtR3Ixx/2f3zLKAK+L6l5SKhrGXKTwXa1rvnj7zj8B2g1V1PZadiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mI9fGJNSDSeDVRj3b/ragI3b4Qd32j/j/dczaV02WTE=;
 b=mIeClyOGlOY1SMTUfc8pXv3RNonsXkMLsPk1zeIopV7dT7Ltj7HPfXbqHdK0TjdaUwFdI5oLIAitqvi9c978+VQ+qwWHzgdQMrZ0tPLR7l6M4WKAZk3BjZ5ouNb1Ko0H6EUGf+UAWsy7c0wdX8LxMadBldaV8+Ngj9gX32Q2OXU=
Received: from MWHPR14CA0069.namprd14.prod.outlook.com (2603:10b6:300:81::31)
 by CY4PR12MB1125.namprd12.prod.outlook.com (2603:10b6:903:43::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 22:33:22 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:81:cafe::a5) by MWHPR14CA0069.outlook.office365.com
 (2603:10b6:300:81::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Wed, 5 Jan 2022 22:33:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Wed, 5 Jan 2022 22:33:22 +0000
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 5 Jan
 2022 16:33:20 -0600
Date:   Wed, 5 Jan 2022 16:32:45 -0600
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
Message-ID: <20220105223245.2qebwfphyf2t43ni@amd.com>
References: <20211210164620.11636-1-michael.roth@amd.com>
 <Yc4gcJdhxthBKUUd@google.com>
 <20220104233517.kxjbdw4t7taymab5@amd.com>
 <YdTjnRZQID5IabK0@google.com>
 <20220105170244.jwr6i2erecbhx3fz@amd.com>
 <YdXYuaoXJux6lHrF@google.com>
 <20220105191107.qx67wf2coc3q6giu@amd.com>
 <YdX0SRoBXReggrVA@google.com>
 <20220105213519.g746jzf756nax562@amd.com>
 <YdYVjfMqf+GjsU+p@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YdYVjfMqf+GjsU+p@google.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f6923fe-8589-4b0b-c689-08d9d09b6160
X-MS-TrafficTypeDiagnostic: CY4PR12MB1125:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB11259BE39B3698FA1D27E922954B9@CY4PR12MB1125.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PCq4HRz4CI/hhEzfpCKMnAsUwcDb5sYJ8S28ARQzEuaCfdJeYXWKKdW8DZzcatPnLYMmMkQd97IyBy4AeXMdaZpjrKdB17OIuWVkFsKX/Fjgnvn+mHrysiSEqqRXOuDlPBvi9QQZgIqOl4iBM6QJJGGVth48ci55IH+1G3Q8NhJfXVNY66o1CAEWb8+mn0s120F/46fN1OQ/hdIJprHaNnLXlBXFFEaYRzrV3VetdJJjNyPtw/3pwupKy6WYN7hD9FElaa6c3Nb9yMWKNExUrzMlD7y5RIghrCkBxaG2cf/LpbHscbLpWu2MTTaJGSJF65Ip1EuuWdA4UwpcDaxnSkSidGiWnu0r8RqWR7tLTjR5Wx/PjeSyU6fSbBzixI8hjv5KL6LNQk7+YonzsFmMvPQDUyl2pMu0lT2DrPBdFgdmTtuokCFjf7LWUNI8u+THq9CwdckcchXKqTOBuGkVELG7L1QEtsunw5WCZP2rPeghn1gqdwbq46nImqUmR30VYT1j19hQ8CPmPXAFHiI4HOhyFozsT1WQTU+1yS7P4UGUYQUjtuMqmQmGfP0xKtvOBSYRxzRY87mcJZ3Zs6lEjLss7r6oIvskpliP4FQ9oxa3UFb/QH5SzqrBQJJWZsUiK5hQSECRKTpVsYYrPUOCpHMvKETAh8Hu9UUbkAIzPc7sqjErUqk9S9kP9OaveZEbDeAWYYjD9MLxB0eUJTaSMNUrXj57uhkR2LTbQsAEe9kHY9XH3mvPWle86JooDLuhTZp6Bmg52yNWktQK4cvv2O7alvRN9q2EYoFBHnZxjdY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(40470700002)(46966006)(1076003)(47076005)(508600001)(16526019)(186003)(81166007)(40460700001)(36756003)(54906003)(8936002)(36860700001)(83380400001)(26005)(86362001)(316002)(336012)(426003)(6666004)(8676002)(7416002)(4326008)(2906002)(356005)(2616005)(70586007)(70206006)(44832011)(5660300002)(6916009)(82310400004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 22:33:22.0157
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f6923fe-8589-4b0b-c689-08d9d09b6160
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1125
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 05, 2022 at 10:02:53PM +0000, Sean Christopherson wrote:
> On Wed, Jan 05, 2022, Michael Roth wrote:
> > On Wed, Jan 05, 2022 at 07:40:57PM +0000, Sean Christopherson wrote:
> > > As for ucall_init(), I think the best approach would be to make kvm_vm_elf_load()
> > > a static and replace all calls with:
> > > 
> > > 	kvm_vm_load_guest(vm);
> > > 
> > > where its implementation is:
> > > 
> > >   void kvm_vm_load_guest(struct kvm_vm *vm)
> > >   {
> > >   	kvm_vm_elf_load(vm, program_invocation_name);
> > > 
> > > 	ucall_init(vm);
> > >   }
> > > 
> > > The logic being that if a test creates a VM but never loads any code into the guest,
> > > e.g. kvm_create_max_vcpus, then it _can't_ make ucalls.
> > 
> > Makes sense. And if different ops are needed for vmgexit()/tdcall() it
> > could be something like (if based on patches 1-5 of this series, and
> > extending vm_guest_mode as you suggested earlier):
> > 
> >    void kvm_vm_load_guest(struct kvm_vm *vm)
> >    {
> > 
> >      kvm_vm_elf_load(vm, program_invocation_name);
> >   
> >      if (vm->mode == VM_MODE_SEV)
> >   	    ucall_init_ops(vm, ucall_ops_pio_vmgexit);
> >      else (vm->vm_type == VM_MODE_TDX)
> 
> I don't think we want to do this here, but instead down in the arch-specific
> ucall_init().  Also, not sure if I was clear before (can't tell what you interpreted
> based on the above snippet), but I think we'll want VM_MODE_SEV etc... to be
> modifiers on top of the VA/PA stuff.

Ok, something like this (with additional ones added as-needed)?

  #define VM_MODE_DEFAULT VM_MODE_PXXV48_4K
  +#define SEV_VM_MODE_DEFAULT SEV_VM_MODE_PXXV48_4K

  enum vm_guest_mode {
    ...
    VM_MODE_PXXV48_4K,
    ...
    NUM_VM_MODES,
  + SEV_VM_MODE_PXXV48_4K,
  + NUM_VM_MODES_EXTENDED,
  }

> 
> >   	    ucall_init_ops(vm, ucall_ops_pio_tdcall);
> >      else
> >   	    ucall_init_ops(vm, ucall_ops_pio);
> > 
> > Shame we have to update all the kvm_vm_elf_load() call-sites, but
> > they'd end up potentially breaking things if left as-is anyway.
> > 
> > Were you planning on sending patches for these changes, or should I incorporate
> > your prototype and take a stab at the other changes as part of v2 of this
> > series?
> 
> Nope, all yours.  Thanks!

Thanks for the suggestions!
