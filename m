Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90BB54423E8
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Nov 2021 00:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbhKAXYj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Nov 2021 19:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbhKAXYj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Nov 2021 19:24:39 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282A0C061766
        for <linux-kselftest@vger.kernel.org>; Mon,  1 Nov 2021 16:22:05 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id u17so3950792plg.9
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Nov 2021 16:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1DmJsDZOreKd3PODnjVspgGOYDJOtOgJGhWnyk3NAL0=;
        b=OfmV25Rs/0KiayRA/5l31wf4/dncjDlC4EW7XyT/JaAibTlnL2JNY/ecf8e2UaDk05
         iOYiB9DfDtj0/JtL7xe04CFY9ouJkYJD3naY0EQtJD4g568ULoL9hz9kZJeF5gcWijSS
         4bOkM2qD66dp8biPKFIXT7qklrAu+SMLTH5oburqr0KLsvvha2M/XjKvX2HvKFeFXSdy
         tVRBtRhI6PVl+Y0OdhxTPF4jRo293v0V7zpP+SDuYg+DXlrcfogephCtXDhJqCsVvMAN
         7TbA7jr4cLKnbN+utfdCImhH/tZ1gVIPvOAircJ3WPMTTghZqN0cYTRr+BogRDa4/78l
         6vbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1DmJsDZOreKd3PODnjVspgGOYDJOtOgJGhWnyk3NAL0=;
        b=F8RcM3gFuKHzZp5qbjOY+IbpKAguAea3ukpT0RpI/LYLyvqjNdsHwU8oIfrhwWps0F
         o9dXFgdgozfxvBtO8LitHx1pPTuUmcfoBlw7q5FC4lRnAe2pKsdKhhqgJgBq6bUmx7Zr
         uZH3aIn1Cxwv8iJfGPC2lOrQ2OcVsUslVb6NsAeK0D9Ca0umVRJmek3ks8umZOttbV7P
         M3oBnJ+UOKyckevEgW0vxaktQtBpanCO+ZVTcgxy7eG1SIXQ/pNpZMdgPSzdZIbE5ILT
         BZLmh6SSG2jeEnNKPn2KgOJel3SkOUmHwwNWLcfCXC5Zax0M5KAraFsv3jcseej3ENzF
         GLNg==
X-Gm-Message-State: AOAM531qdHsiK+6iueGyAreeXPGRyeZxak/DC24N+eauGYAFHHh6wAJl
        07bFuWNyW6uEWI9zQhb07YD9Pg==
X-Google-Smtp-Source: ABdhPJwKAbW9or9w/+9imMlYoFGpzkavS1OdIzsCCdVPPYYMFOIxBIv+rSbAKoBh06Z2wGBlsMa0MA==
X-Received: by 2002:a17:903:228c:b0:141:f600:c161 with SMTP id b12-20020a170903228c00b00141f600c161mr6273421plh.10.1635808924335;
        Mon, 01 Nov 2021 16:22:04 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id f11sm6040491pfv.191.2021.11.01.16.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 16:22:03 -0700 (PDT)
Date:   Mon, 1 Nov 2021 23:21:59 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Kieran Bingham <kbingham@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Andrew Jones <drjones@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jessica Yu <jeyu@kernel.org>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Yang Weijiang <weijiang.yang@intel.com>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 6/6] KVM: selftests: test KVM_GUESTDBG_BLOCKIRQ
Message-ID: <YYB2l9bzFhKzobZB@google.com>
References: <20210811122927.900604-1-mlevitsk@redhat.com>
 <20210811122927.900604-7-mlevitsk@redhat.com>
 <137f2dcc-75d2-9d71-e259-dd66d43ad377@redhat.com>
 <87sfwfkhk5.fsf@vitty.brq.redhat.com>
 <b48210a35b3bc6d63beeb33c19b609b3014191dd.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b48210a35b3bc6d63beeb33c19b609b3014191dd.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 01, 2021, Maxim Levitsky wrote:
> On Mon, 2021-11-01 at 16:43 +0100, Vitaly Kuznetsov wrote:
> > Paolo Bonzini <pbonzini@redhat.com> writes:
> > 
> > > On 11/08/21 14:29, Maxim Levitsky wrote:
> > > > Modify debug_regs test to create a pending interrupt
> > > > and see that it is blocked when single stepping is done
> > > > with KVM_GUESTDBG_BLOCKIRQ
> > > > 
> > > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > > ---
> > > >   .../testing/selftests/kvm/x86_64/debug_regs.c | 24 ++++++++++++++++---
> > > >   1 file changed, 21 insertions(+), 3 deletions(-)
> > > 
> > > I haven't looked very much at this, but the test fails.
> > > 
> > 
> > Same here,
> > 
> > the test passes on AMD but fails consistently on Intel:
> > 
> > # ./x86_64/debug_regs 
> > ==== Test Assertion Failure ====
> >   x86_64/debug_regs.c:179: run->exit_reason == KVM_EXIT_DEBUG && run->debug.arch.exception == DB_VECTOR && run->debug.arch.pc == target_rip && run->debug.arch.dr6 == target_dr6
> >   pid=13434 tid=13434 errno=0 - Success
> >      1	0x00000000004027c6: main at debug_regs.c:179
> >      2	0x00007f65344cf554: ?? ??:0
> >      3	0x000000000040294a: _start at ??:?
> >   SINGLE_STEP[1]: exit 8 exception 1 rip 0x402a25 (should be 0x402a27) dr6 0xffff4ff0 (should be 0xffff4ff0)
> > 
> > (I know I'm late to the party).
> 
> Well that is strange. It passes on my intel laptop. Just tested 
> (kvm/queue + qemu master, compiled today) :-(
> 
> It fails on iteration 1 (and there is iteration 0) which I think means that we
> start with RIP on sti, and get #DB on start of xor instruction first (correctly), 
> and then we get #DB again on start of xor instruction again?
> 
> Something very strange. My laptop has i7-7600U.

I haven't verified on hardware, but my guess is that this code in vmx_vcpu_run()

	/* When single-stepping over STI and MOV SS, we must clear the
	 * corresponding interruptibility bits in the guest state. Otherwise
	 * vmentry fails as it then expects bit 14 (BS) in pending debug
	 * exceptions being set, but that's not correct for the guest debugging
	 * case. */
	if (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP)
		vmx_set_interrupt_shadow(vcpu, 0);

interacts badly with APICv=1.  It will kill the STI shadow and cause the IRQ in
vmcs.GUEST_RVI to be recognized when it (micro-)architecturally should not.  My
head is going in circles trying to sort out what would actually happen.  Maybe
comment out that and/or disable APICv to see if either one makes the test pass?
