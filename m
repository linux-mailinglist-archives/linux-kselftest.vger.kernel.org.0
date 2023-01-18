Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C19671B77
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jan 2023 13:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjARMHg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Jan 2023 07:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjARMGu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Jan 2023 07:06:50 -0500
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B3824134;
        Wed, 18 Jan 2023 03:25:18 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 42AAF581DE7;
        Wed, 18 Jan 2023 06:25:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 18 Jan 2023 06:25:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1674041117; x=1674048317; bh=3r
        HztNKFKDzP6FM37wshrSzfwbcQFDaDtmm5ss89k4A=; b=mxJ8Ow5LoW3L4wATqS
        QRZc3mo+g/GkoyDuddkmVm6WUo4ggGW6bSF9USy+3MYpAerT0sGFFX+0wX/Z4TyB
        MueZeyW0+/dxyLd8gBZxmEBbj598ORS+yezgLpM8o6S22Dfuy4CnY230cw4vwVfP
        W4MYnBdh0688rBaZlIurvNVn5T3BJPP59w6BpAEHmE21fzHLb59jS2tbZmIrnWOH
        rzFlh+AIj9STbV7OA+sRfLV6DU/9WW4CzsUKKjJN/JRpP6OLMWS+ZDRoID2shVSW
        iaOzCz/PqkmTsjEa7bwaBbNG0z6j3ES4Qn9DUFkE4j9cTjOA9hxptoxS6rOAf5Jc
        5JWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674041117; x=1674048317; bh=3rHztNKFKDzP6FM37wshrSzfwbcQ
        FDaDtmm5ss89k4A=; b=C+spHhDandahXHFa+N1IYo9iF9EF1hPn2Nh5/XYbXyjW
        I7CBcs6UrA1ERS1xi993zVHrKcobSsQo22TGwkST1h9WcRnLktG81eVxjYVp2ekD
        3qI/leuzV01/6CylFPxXfIhdLkBf1S/lO3XUf64qmUEY46d5cwyWaKXNCGIrCTNJ
        WlIGFcgPuTLL8ROkUydAQJpZUvdoUi7HUwTyp+nTAmm4L9/NClWlL4iF9Ldwybe0
        NX0FUm6lE/N880Kn4YdxDY4V70+IrJB3PWPWc3JmUX7dLH0x9cj29V3URhycxdf0
        H8MxGF4IHT3TXwfgSE5fwlpvRAnSjYs/U45z6pm12A==
X-ME-Sender: <xms:G9fHY_ep1MNRwtvIOOEMd19i0OqlrUclzwsljdwYKAEjA_UsC2jA0Q>
    <xme:G9fHY1Nk6pvM6KeHQ7jq5h30qzvNcusT2e5KFW4AXTSNK3TD5KACjEUayuekKwXdI
    JY1GhhtnH8QbIxOtB4>
X-ME-Received: <xmr:G9fHY4ih02aM9oeJ3OiNr0KHSXCiahDUJ1xdid6Gk2NkrDT3xjS6G_NaV1cS6VrwggYgRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtkedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeegvdevjeehleetkeeigfevkeehtdeklefgleef
    leehuefgveevgfdvieejvedvveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhqvg
    hmuhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:G9fHYw9jfwnpU4Nh4xAVbKbCm4tzw1x4eZ00yL-nE5V1K4GCoS0_hA>
    <xmx:G9fHY7trVA4spyMhA9NVhPpA_nYklvmVkvzKxGv790UAvZgCJzbiew>
    <xmx:G9fHY_F8Bu4CYoL1-3vPRx_UQyXcUQSYo1gFwSmk-COF02pgKlj2MQ>
    <xmx:HdfHY7zYGKxeYUa8MD3orQFQtkqWHaHKrFajIvy7HqohsSp1J9MG0g>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Jan 2023 06:25:14 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 6EBD1104CC6; Wed, 18 Jan 2023 14:25:11 +0300 (+03)
Date:   Wed, 18 Jan 2023 14:25:11 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vishal Annapurve <vannapurve@google.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        shuah@kernel.org, yang.zhong@intel.com, ricarkol@google.com,
        aaronlewis@google.com, wei.w.wang@intel.com,
        kirill.shutemov@linux.intel.com, corbet@lwn.net, hughd@google.com,
        jlayton@kernel.org, bfields@fieldses.org,
        akpm@linux-foundation.org, chao.p.peng@linux.intel.com,
        yu.c.zhang@linux.intel.com, jun.nakajima@intel.com,
        dave.hansen@intel.com, michael.roth@amd.com, qperret@google.com,
        steven.price@arm.com, ak@linux.intel.com, david@redhat.com,
        luto@kernel.org, vbabka@suse.cz, marcorr@google.com,
        erdemaktas@google.com, pgonda@google.com, nikunj@amd.com,
        diviness@google.com, maz@kernel.org, dmatlack@google.com,
        axelrasmussen@google.com, maciej.szmigiero@oracle.com,
        mizhang@google.com, bgardon@google.com, ackerleytng@google.com
Subject: Re: [V2 PATCH 0/6] KVM: selftests: selftests for fd-based private
 memory
Message-ID: <20230118112511.wrljyng2xiz3yktv@box.shutemov.name>
References: <20221205232341.4131240-1-vannapurve@google.com>
 <Y8dG3WDxY2OCGPby@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8dG3WDxY2OCGPby@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 18, 2023 at 01:09:49AM +0000, Sean Christopherson wrote:
> On Mon, Dec 05, 2022, Vishal Annapurve wrote:
> > This series implements selftests targeting the feature floated by Chao via:
> > https://lore.kernel.org/lkml/20221202061347.1070246-10-chao.p.peng@linux.intel.com/T/
> > 
> > Below changes aim to test the fd based approach for guest private memory
> > in context of normal (non-confidential) VMs executing on non-confidential
> > platforms.
> > 
> > private_mem_test.c file adds selftest to access private memory from the
> > guest via private/shared accesses and checking if the contents can be
> > leaked to/accessed by vmm via shared memory view before/after conversions.
> > 
> > Updates in V2:
> > 1) Simplified vcpu run loop implementation API
> > 2) Removed VM creation logic from private mem library
> 
> I pushed a rework version of this series to:
> 
>   git@github.com:sean-jc/linux.git x86/upm_base_support

It still has build issue with lockdep enabled that I mentioned before:

https://lore.kernel.org/all/20230116134845.vboraky2nd56szos@box.shutemov.name/

And when compiled with lockdep, it triggers a lot of warnings about missed
locks, like this:

[   59.632024] kvm: FIXME: Walk the memory attributes of the slot and set the mixed status appropriately
[   59.684888] ------------[ cut here ]------------
[   59.690677] WARNING: CPU: 2 PID: 138 at include/linux/kvm_host.h:2307 kvm_mmu_do_page_fault+0x19a/0x1b0
[   59.693531] CPU: 2 PID: 138 Comm: private_mem_con Not tainted 6.1.0-rc4-00624-g7e536bf3c45c-dirty #1
[   59.696265] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   59.699586] RIP: 0010:kvm_mmu_do_page_fault+0x19a/0x1b0
[   59.700720] Code: d8 1c 00 00 eb e3 65 48 8b 0c 25 28 00 00 00 48 3b 4c 24 50 75 1b 48 83 c4 58 5b 41 5e 41 5f 5d c3 48 81 c0
[   59.704711] RSP: 0018:ffffc90000323c80 EFLAGS: 00010246
[   59.705830] RAX: 0000000000000000 RBX: ffff888103bc8000 RCX: ffffffff8107dff0
[   59.707353] RDX: 0000000000000001 RSI: ffffffff82549d49 RDI: ffffffff825abe77
[   59.708865] RBP: ffffc90000e59000 R08: 0000000000000000 R09: 0000000000000000
[   59.710369] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   59.711859] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000180
[   59.713338] FS:  00007f2e556de740(0000) GS:ffff8881f9d00000(0000) knlGS:0000000000000000
[   59.714978] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   59.716168] CR2: 0000000000000000 CR3: 0000000100e90005 CR4: 0000000000372ee0
[   59.717631] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   59.719086] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   59.721148] Call Trace:
[   59.722661]  <TASK>
[   59.723986]  ? lock_is_held_type+0xdb/0x150
[   59.726501]  kvm_mmu_page_fault+0x41/0x170
[   59.728946]  vmx_handle_exit+0x343/0x750
[   59.731007]  kvm_arch_vcpu_ioctl_run+0x1d12/0x2790
[   59.733319]  kvm_vcpu_ioctl+0x4a6/0x590
[   59.735195]  __se_sys_ioctl+0x6a/0xb0
[   59.736976]  do_syscall_64+0x3d/0x80
[   59.738698]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   59.740743] RIP: 0033:0x7f2e557d8f6b
[   59.741907] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 c7 04 24 10 00 00 00 b0
[   59.747836] RSP: 002b:00007ffe8b84eb50 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   59.750147] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f2e557d8f6b
[   59.751754] RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000007
[   59.753361] RBP: 000000000042f880 R08: 0000000000000007 R09: 0000000000430210
[   59.754952] R10: ca7f9f3d969d5d5c R11: 0000000000000246 R12: 000000000042d2a0
[   59.756596] R13: 0000000100000000 R14: 0000000000422e00 R15: 00007f2e558f7000
[   59.758231]  </TASK>
[   59.758752] irq event stamp: 8637
[   59.759540] hardirqs last  enabled at (8647): [<ffffffff8119ae18>] __up_console_sem+0x68/0x90
[   59.761309] hardirqs last disabled at (8654): [<ffffffff8119adfd>] __up_console_sem+0x4d/0x90
[   59.763022] softirqs last  enabled at (8550): [<ffffffff81123c7a>] __irq_exit_rcu+0xaa/0x130
[   59.764731] softirqs last disabled at (8539): [<ffffffff81123c7a>] __irq_exit_rcu+0xaa/0x130
[   59.766409] ---[ end trace 0000000000000000 ]---

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
