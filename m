Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64CB1485B3A
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jan 2022 23:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244698AbiAEWDD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jan 2022 17:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244694AbiAEWC7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jan 2022 17:02:59 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CC7C061201
        for <linux-kselftest@vger.kernel.org>; Wed,  5 Jan 2022 14:02:58 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id s1so373940pga.5
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Jan 2022 14:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YKCFFRAciZpcdqJmTFTjz+wKvbhjzm225M4aIDaCuiU=;
        b=fW9ulu/h4JJhF3zfksJLWMb/bqR8giX/dFE0CouDR+T4lybi6lRauIYAouP9mYL2XX
         YguWms/IVaiZ3ZDCwIsKnjiIpWbcleacvZ/EO7P0mqySNH9ebGIcBvSMfi/iaLmwASwe
         2TlHkMJirJyvPG3B30LCRQ1HdqX38PzwsH4j8PyaMwKJiOg8OC8vWl1TGwkY5wOioE2K
         GqaN3SZNTMLLsyolLb/ExYbL9PgCKZxj1oaZkD2S2bVAWDfqROpz0mplyuwiV1bqPgo4
         xWF2cFWOwG70irBz41p2OphNPPmUXrSGaQUwvoSs6suQBfsw7AgL669rhPB5Uu7wAo7P
         nsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YKCFFRAciZpcdqJmTFTjz+wKvbhjzm225M4aIDaCuiU=;
        b=WPdD18q47XW+YRfmdAvbcx1S3Vj4xbmsiLF/UsW+H027hfAHKEwYGUEdUVpqPn0qAa
         grTGjCbZ81cWuEYdny20n/viwK6AIv75lGLb0NtSbNXKi+OCs+KYEDEyiP+RRs0rqdnP
         DDHrMmFAZTUUzrdwMmiat4upvc8JgVXEgh1mHCTXcPuViqp0x7wtQC1MGdWk6obCTY3I
         KVjSQyifKC3lya1ct1NqTZVWA0Jh20cV+0IHutR6mxmo3H0thSH9HMRMVBlvhBIoi8EP
         97UjnI9bjiNhaoCPMS/3n6svZAKdz15wfJk1dSrp172b/NgYL179plMwRnhQpi37CoXz
         kZfg==
X-Gm-Message-State: AOAM531GX+b2Bxk9G9g2v3sBxIbKUYR0oiw/kiADNJ2bYcny9mkUZnfi
        IQIJ+yEduwjAbYzrPxnyBSVBrg==
X-Google-Smtp-Source: ABdhPJy1j3iKKZs35n/KzJTCkqL0HcCrjjmYG6bssNBIFzGISkV5H8QpwsTR9BEo9HcizmPRobCqBQ==
X-Received: by 2002:a62:7c58:0:b0:4bb:314b:86b9 with SMTP id x85-20020a627c58000000b004bb314b86b9mr57302956pfc.84.1641420177751;
        Wed, 05 Jan 2022 14:02:57 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 36sm20676pgq.94.2022.01.05.14.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 14:02:57 -0800 (PST)
Date:   Wed, 5 Jan 2022 22:02:53 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Michael Roth <michael.roth@amd.com>
Cc:     linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
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
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu
Subject: Re: [RFC PATCH 00/10] KVM: selftests: Add support for
 test-selectable ucall implementations
Message-ID: <YdYVjfMqf+GjsU+p@google.com>
References: <20211210164620.11636-1-michael.roth@amd.com>
 <Yc4gcJdhxthBKUUd@google.com>
 <20220104233517.kxjbdw4t7taymab5@amd.com>
 <YdTjnRZQID5IabK0@google.com>
 <20220105170244.jwr6i2erecbhx3fz@amd.com>
 <YdXYuaoXJux6lHrF@google.com>
 <20220105191107.qx67wf2coc3q6giu@amd.com>
 <YdX0SRoBXReggrVA@google.com>
 <20220105213519.g746jzf756nax562@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105213519.g746jzf756nax562@amd.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 05, 2022, Michael Roth wrote:
> On Wed, Jan 05, 2022 at 07:40:57PM +0000, Sean Christopherson wrote:
> > As for ucall_init(), I think the best approach would be to make kvm_vm_elf_load()
> > a static and replace all calls with:
> > 
> > 	kvm_vm_load_guest(vm);
> > 
> > where its implementation is:
> > 
> >   void kvm_vm_load_guest(struct kvm_vm *vm)
> >   {
> >   	kvm_vm_elf_load(vm, program_invocation_name);
> > 
> > 	ucall_init(vm);
> >   }
> > 
> > The logic being that if a test creates a VM but never loads any code into the guest,
> > e.g. kvm_create_max_vcpus, then it _can't_ make ucalls.
> 
> Makes sense. And if different ops are needed for vmgexit()/tdcall() it
> could be something like (if based on patches 1-5 of this series, and
> extending vm_guest_mode as you suggested earlier):
> 
>    void kvm_vm_load_guest(struct kvm_vm *vm)
>    {
> 
>      kvm_vm_elf_load(vm, program_invocation_name);
>   
>      if (vm->mode == VM_MODE_SEV)
>   	    ucall_init_ops(vm, ucall_ops_pio_vmgexit);
>      else (vm->vm_type == VM_MODE_TDX)

I don't think we want to do this here, but instead down in the arch-specific
ucall_init().  Also, not sure if I was clear before (can't tell what you interpreted
based on the above snippet), but I think we'll want VM_MODE_SEV etc... to be
modifiers on top of the VA/PA stuff.

>   	    ucall_init_ops(vm, ucall_ops_pio_tdcall);
>      else
>   	    ucall_init_ops(vm, ucall_ops_pio);
> 
> Shame we have to update all the kvm_vm_elf_load() call-sites, but
> they'd end up potentially breaking things if left as-is anyway.
> 
> Were you planning on sending patches for these changes, or should I incorporate
> your prototype and take a stab at the other changes as part of v2 of this
> series?

Nope, all yours.  Thanks!
