Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39D6485787
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jan 2022 18:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242466AbiAERnb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jan 2022 12:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242448AbiAERn0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jan 2022 12:43:26 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700E0C061245
        for <linux-kselftest@vger.kernel.org>; Wed,  5 Jan 2022 09:43:26 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id i8so27606132pgt.13
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Jan 2022 09:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d0CM6f3epcJvfBW0AXtigNVn6uvFqm9aqgCZO4wHLDk=;
        b=tl5TRjsO5Xxya025PNLR1EZhjvW5OGtyRhabN1q5A5IArEgVtoWDWrSBJ21dwXsLjJ
         vdZxF+6np6puiGX/osCjuCDHponMy6k+twhvIPmg6JRQaLAHPwiowkDpOK9mWnzy8tCz
         zwVuLsSr/vgUBNcDIhKNzrDZiEuOLE2La4mQeVvt4IZEJRFPAqHUHbdud1JyxFU1GfnJ
         1HabHYkloYIQhFfgVz5SPWmkBXbgKu4uUW8luD/Dsw1gHEFdhjgyp0Ccb0dA4C2TK9kR
         nKW8e9RqTLmvsjL+Bf6mwSW2nqseC+APgxNHzQrXXkfe9oyaKit6o7mlpqem+1X/1wmJ
         YiLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d0CM6f3epcJvfBW0AXtigNVn6uvFqm9aqgCZO4wHLDk=;
        b=W12vBzWd5jhoiGirs3aWtyndpNF0LwU7zKCycG7+V+oGrf+ldcTp0OxgcnuvYvSe+n
         uMgZFuW58aBVuqv6q857LcVCD/NJq3sD/XxDdj6yuuuGiSDGeqVIfroolcTFTeUZ9beB
         QmsgYh5nk1JAPL7IhxtoaUGTLu/KlrkxG/6V17ffjw+GYHMrQh6ORBbkqN6hUQ/lUx2F
         kZYUmuc4h4urVnGh9fk9hzSvx082dHz4iuR4XzPrMTb4e81eocAxO+idAnbSVVOf3Ama
         pVA4SZr+Isrkj2HX6X7vtiVCi+M+BzJnTVueh1chbUTTpfgOici7eVJO4Ub49P43cq/o
         MYag==
X-Gm-Message-State: AOAM532LH8eVrfsu3kfKMoKryeu4kIiq0YbJVrylaY0btzm8FXSLEUDh
        ksX5xdmsuv1fu7etWCGiv8sdcwBhW++Zgw==
X-Google-Smtp-Source: ABdhPJwUZuz0qf9rWN8CepkOkzOr4I60nu3nQPtBtpnE9XlUI3LUblc5PYLxfy2mn11zbjt4rTQZIw==
X-Received: by 2002:a05:6a00:198a:b0:4bb:4621:f074 with SMTP id d10-20020a056a00198a00b004bb4621f074mr56308050pfl.69.1641404605737;
        Wed, 05 Jan 2022 09:43:25 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id r10sm45070777pff.120.2022.01.05.09.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 09:43:25 -0800 (PST)
Date:   Wed, 5 Jan 2022 17:43:21 +0000
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
Message-ID: <YdXYuaoXJux6lHrF@google.com>
References: <20211210164620.11636-1-michael.roth@amd.com>
 <Yc4gcJdhxthBKUUd@google.com>
 <20220104233517.kxjbdw4t7taymab5@amd.com>
 <YdTjnRZQID5IabK0@google.com>
 <20220105170244.jwr6i2erecbhx3fz@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105170244.jwr6i2erecbhx3fz@amd.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 05, 2022, Michael Roth wrote:
> On Wed, Jan 05, 2022 at 12:17:33AM +0000, Sean Christopherson wrote:
> > PIO shouldn't require instruction decoding or a #VC handler.  What I was thinking
> > is that the guest in the selftest would make a direct #VMGEXIT/TDCALL to request
> > PIO instead of executing an OUT.  
> 
> That seems like a nicer approach. But it sort of lends itself to having
> test-specific ucall implementations in some form. How are you thinking
> vm_create() should decide what implementation to use? With this series
> in place it could be something like:
> 
>   vm_create(..., struct ucall_ops *ops)
>     ucall_init_ops(ops)
> 
> and with the SEV selftests in their current form it would look something
> like:
> 
>   sev_vm_create(...)
>     vm_create_with_ucall(..., ops=ucall_ops_pio_vmgexit)
>       ucall_init_ops(ops)
> 
> is that sort of what you're thinking, or something else?

I keep forgetting ucall() doesn't have access to the VM.  But, since we're
restricing ucall() to a single VM, we can have a global that sets ucall_ops during
ucall_init() based on the VM type, or skip an ops and just open code the behavior
in x86's ucall() by snapshotting the VM type.  Either way, the goal is to avoid
having to pass in ucall_ops at the test level.

> > Yeah, I was thinking it could be done at the lowest level vm_create() helper.
> > We'll need to expand vm_create() (or add yet another layer to avoid modifying a
> > pile of tests) to allow opting out of initializing ucall, e.g. sev_migrate_tests.c
> > needs to create multiple concurrent VMs, but happily doesn't need ucall support.
> 
> Why does sev_migrate_tests need to opt out? Couldn't it use
> ucall_ops_pio_vmgexit like that SEV case above?

Because it uses multiple VMs, and my rough sketch only allows for a single VM to
use ucall.  Though I suppose we could simply keep appending to the ucall list for
every VM.  The requirement would then be that all VMs are of the same type, i.e.
utilize the same ucall_ops.

> I ask because there is a ucall() in the exception handling code where
> some unhandled exceptions result in the guest automatically issuing a
> ucall(UCALL_UNHANDLED), so even when tests don't use ucall() they
> might still rely on it if they enable exception handling. So that might
> be an argument for always setting up at least the default ucall_ops_pio
> implementation and creating a pool just in case. (or an argument for
> dropping the UCALL_HANDLED handling).

The sev_migrate_tests don't even run a guest, hence the quick-and-dirty "solution".
Though thinking toward the future, that may be too dirty as it would prevent tests
from having multiple "real" VMs.

> > > > To reduce the burden on tests and avoid ordering issues with creating vCPUs,
> > > > allocate a ucall struct for every possible vCPU when the VM is created and stuff
> > > > the GPA of the struct in the struct itself so that the guest can communicate the
> > > > GPA instead of the GVA.  Then confidential VMs just need to make all structs shared.
> > > 
> > > So a separate call like:
> > > 
> > >   ucall_make_shared(vm->ucall_list)
> > > 
> > > ? Might need some good documentation/assertions to make sure it gets
> > > called at the right place for confidential VMs, and may need some extra
> > > hooks in SEV selftest implementation for switching from private to shared
> > > after the memory has already been allocated, but seems reasonable.
> > 
> > Again, I was thinking that it would be done unconditionally by ucall_init(), i.e.
> > would be automatically handled by the selftest framework and would Just Work for
> > individual tests.
> 
> Ok, I'll have to think that through more. Currently with the SEV
> selftests as they we have:
> 
>   sev_vm_create(policy, npages)
>     vm = vm_create(...)
>     vm_set_memory_encryption(vm, encrypt_by_default, enc_bit)
>     //vm_vaddr_alloc_shared() can be used now
> 
> The ucall struct allocations would need to go through
> vm_vaddr_alloc_shared() to make sure the selftest library tracks/maps
> the pages as shared, but that vm_set_memory_encryption() happens too
> late if the ucall_init() stuff is done in vm_create(). It should be
> possible to pass the vm_set_memory_encryption() arguments directly to
> vm_create() to allow for what you're proposing, but I guess we'd need
> a new vm_create() wrapper that handles both the
> vm_set_memory_encryption() args, along with the ucall_ops above,
> something like:
> 
>   sev_vm_create(policy, npages)
>     vm = vm_create_coco(..., encrypt_by_default, enc_bit/shared_bit, ucall_ops)
> 
> Or were you thinking something else? Just trying to get an idea of how
> this will all need to tie in with the SEV selftests and what needs to
> change on that end.

Hmm, I was thinking the selftest framework would only need to be told the VM type,
e.g. DEFAULT, SEV, SEV-ES, SEV-SNP, or TDX, and would then handle setting everything
up, e.g. enumerating the C-bit location and encrypting memory as needed.

One thought would be to extend "enum vm_guest_mode" with flags above NUM_VM_MODES
to specify the VM type.  That way tests that use VM_MODE_DEFAULT would continue to
work without any updates.
