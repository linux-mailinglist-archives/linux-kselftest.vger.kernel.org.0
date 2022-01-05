Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98A4484B93
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jan 2022 01:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbiAEARj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jan 2022 19:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbiAEARi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jan 2022 19:17:38 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772A2C061784
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Jan 2022 16:17:38 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id t187so20087442pfb.11
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Jan 2022 16:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WcIGO88FBRkf9hUL0qdMGoYGpx739zUkPBUodqN3MWM=;
        b=LeiRGbz0sK7JpXF3C7NnCtYs9ShrjKciUAFQMizPRrOsLhFwtX6tNar/peTToHmvIY
         fnttyvxTxelGdnw/0f7d7d5fMcUX6PEjPKncBGbrmLlIcz9Z98wQPJJ3F1Ibuzjftxco
         PzUJDYgg5Y2+sQ5W4vLHnvji8ke3NyfCuHCNkM/WF3JQzZYNCelf06LXN5rt38zvI/S1
         B5Alw58ylSEGYpVYB/KWWTv2Ysaax2rilWpPWVm4ckhJUDOa+8fJq6GI22am7fkjc1qj
         rkxf+FV7opjHHpxOsnFqRjrALY7guT95f2Fkgl5Jle+HnPFBCuj0DBBtWo3rghF5487h
         QlRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WcIGO88FBRkf9hUL0qdMGoYGpx739zUkPBUodqN3MWM=;
        b=sVo4tOSlezIHqOp1b99fAaKtnd7kf/oxTl2WIlcWx5oH7AmWiAtxVr9DZjKvsEL9u/
         dHwKxqrpbCvm/7V1dccq0oyMicq+ySb246eBUg0Kh2pDmu/aRkHC5BEGnVtBucpzZ3KJ
         lygpmQnU0NAjr3pUF3sOlK9xnBFsc3Ym6ETGdoQ2aC0XdvchP53C8+foqDwRrtEU9Qyo
         y5AxLy0tQwDInFZvtDB2/bhWFsF/HmFCKITmX3AUCmlwLqoua0/KVgpJtwrlfOuYYORS
         IKgrgkS1ZW2wiJcVFzP9OFV58q17tYDqihde1C5Y5PFLKekDRZ4IQWfd6N2mQeUF7w14
         TJXg==
X-Gm-Message-State: AOAM531vDsL0Yo9XoDheEAsy6ZfJEXhNYDQhpS0Ogsju9EW7wsGA2WF5
        3Md7vjnNOKM/FQPOy1UsiBZE4A==
X-Google-Smtp-Source: ABdhPJyzPSyiqB8yUls0EgrRzcp2sPqjmLXy8rsKW/dAog4/gPIopkbpB0HEvogtZpDQt0FKolOoCQ==
X-Received: by 2002:a05:6a00:114d:b0:4a2:87bd:37f with SMTP id b13-20020a056a00114d00b004a287bd037fmr53392208pfm.82.1641341857727;
        Tue, 04 Jan 2022 16:17:37 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id r11sm41982136pff.81.2022.01.04.16.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 16:17:37 -0800 (PST)
Date:   Wed, 5 Jan 2022 00:17:33 +0000
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
Message-ID: <YdTjnRZQID5IabK0@google.com>
References: <20211210164620.11636-1-michael.roth@amd.com>
 <Yc4gcJdhxthBKUUd@google.com>
 <20220104233517.kxjbdw4t7taymab5@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104233517.kxjbdw4t7taymab5@amd.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 04, 2022, Michael Roth wrote:
> On Thu, Dec 30, 2021 at 09:11:12PM +0000, Sean Christopherson wrote:
> > not in-kernel.  That is bound to bite someone.  The only issue with SEV is the
> > address, not the VM-Exit mechanism.  That doesn't change with SEV-ES, SEV-SNP,
> > or TDX, as PIO and HLT will both get reflected as #VC/#VE, i.e. the guest side
> > needs to be updated to use VMGEXIT/TDCALL no matter what, at which point having
> > the hypercall request PIO emulation is just as easy as requesting HLT.
> 
> I'm not aware of any #VC handling needed for HLT in the case of
> SEV-ES/SEV-SNP. That was one of the reasons for the SEV tests using
> this ucall implementation.

Ah, you're right, HLT is an "automatic" exit and the CPU takes care of adjusting
RIP.  TDX is the only one that requires a hypercall.

> Of course, at some point, we'd want full support for PIO/MMIO/etc. in the #VC
> handler, but it's not something I'd planned on adding until after the SEV-SNP
> tests, since it seems like we'd need to import a bunch of intruction decoding
> code from elsewhere in the kernel, which is a lot of churn that's not
> immediately necessary for getting at least some basic tests in place. Since
> the HLT implementation is only 20 lines of code it seemed like a reasonable
> stop-gap until we start getting more CoCo tests in place. But the in-kernel
> APIC issue probably needs more consideration...
> 
> Perhaps for *just* PIO, the intruction decoding can be open-coded so it
> can be added to the initial #VC handler implementation, which would avoid the
> need for HLT implementation. I'll take a look at that.

PIO shouldn't require instruction decoding or a #VC handler.  What I was thinking
is that the guest in the selftest would make a direct #VMGEXIT/TDCALL to request
PIO instead of executing an OUT.  

> > I also don't like having to differentiate between a "shared" and "regular" ucall.
> > I kind of like having to explicitly pass the ucall object being used, but that
> > puts undue burden on simple single-vCPU tests.
> 
> I tried to avoid it, but I got hung up on that fact that pre-allocating
> arrays/lists of ucall structs needs to be done for each VM, and so we'd
> end up needing some way for a guest to identify which pool it's ucall
> struct should be allocated from. But you've gotten around that by just
> sync_global_to_guest()'ing for each pool at the time ucall_init() is
> called, so the guest only ever sees it's particular pool. Then the switch
> from writing GVA to writing GPA solves the translation problem. Nice.
> 
> > 
> > The inability to read guest private memory is really the only issue, and that can
> > be easily solved without completely revamping the ucall framework, and without
> > having to update a huge pile of tests to make them place nice with private memory.
> 
> I think the first 5 patches in this series are still relevant cleanups
> vs. having a complete standalone ucall implementation for each arch, and Andrew
> has also already started looking at other header cleanups related to
> patch #1, so maybe Paolo would still like to queue those. Would also
> provide a better starting point for having a centralized allocator for
> the ucall structs, which you hinted at wanting below.
> 
> But the subsequent patches that add the ucall_shared() interfaces should
> probably be set aside for now in favor of your proposal.
> 
> > 
> > This would also be a good opportunity to clean up the stupidity of tests having to
> > manually call ucall_init(), drop the unused/pointless @arg from ucall_init(), and
> > maybe even fix arm64's lurking landmine of not being SMP safe (the address is shared
> > by all vCPUs).
> 
> I thought you *didn't* want to update a huge pile of tests :) I suppose
> it's unavoidable, since with your proposal, having something like ucall_init()
> being called at some point is required, as opposed to the current
> implementation where it is optional. Are you intending to have it be
> called automatically by vm_create*()?

Yeah, I was thinking it could be done at the lowest level vm_create() helper.
We'll need to expand vm_create() (or add yet another layer to avoid modifying a
pile of tests) to allow opting out of initializing ucall, e.g. sev_migrate_tests.c
needs to create multiple concurrent VMs, but happily doesn't need ucall support.

> > To reduce the burden on tests and avoid ordering issues with creating vCPUs,
> > allocate a ucall struct for every possible vCPU when the VM is created and stuff
> > the GPA of the struct in the struct itself so that the guest can communicate the
> > GPA instead of the GVA.  Then confidential VMs just need to make all structs shared.
> 
> So a separate call like:
> 
>   ucall_make_shared(vm->ucall_list)
> 
> ? Might need some good documentation/assertions to make sure it gets
> called at the right place for confidential VMs, and may need some extra
> hooks in SEV selftest implementation for switching from private to shared
> after the memory has already been allocated, but seems reasonable.

Again, I was thinking that it would be done unconditionally by ucall_init(), i.e.
would be automatically handled by the selftest framework and would Just Work for
individual tests.

> > If all architectures have a way to access a vCPU ID, the ucall structs could be
> > stored as a simple array.  If not, a list based allocator would probably suffice.
> 
> I think list allocator is nicer, generating #VCs for both the PIO and the
> cpuid checks for vCPU lookup seems like a lot of extra noise to sift
> through while debugging where an errant test is failing, and doesn't seem to
> have any disadvantage vs. an array.

Ah, right, I forgot that querying the vCPU ID would require a hypercall.
