Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E346489FC
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Dec 2022 22:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiLIVWt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Dec 2022 16:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiLIVWs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Dec 2022 16:22:48 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A263311A0C;
        Fri,  9 Dec 2022 13:22:46 -0800 (PST)
Date:   Fri, 9 Dec 2022 21:22:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1670620964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CnVvyDm8QxAyajwUwqUqBUtv/4sqoRnfMoVGeE9EDJk=;
        b=VvQSAgpV2Gon3rwIJuMH4V8sDbw3cQo8amLdVLY5zVYp7r21DV6rHehDo5WkPqIJLtVGYB
        /NWJwK+KRAx7hIkdRzV2uvhrnyLn3Y8MrF0QAkZ2FSkgSomL4bJ8u49J/oHNwReUS8tuFY
        ikFbLS6qOT2Rg1QVR5KJsuBOq50ULKE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        Ricardo Koller <ricarkol@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] KVM: selftests: Correctly initialize the VA space
 for TTBR0_EL1
Message-ID: <Y5OnH72knmPorYgn@google.com>
References: <20221209015307.1781352-1-oliver.upton@linux.dev>
 <20221209015307.1781352-5-oliver.upton@linux.dev>
 <Y5OeTeq55OgBJbjT@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5OeTeq55OgBJbjT@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 09, 2022 at 08:45:01PM +0000, Sean Christopherson wrote:
> On Fri, Dec 09, 2022, Oliver Upton wrote:
> > An interesting feature of the Arm architecture is that the stage-1 MMU
> > supports two distinct VA regions, controlled by TTBR{0,1}_EL1. As KVM
> > selftests on arm64 only uses TTBR0_EL1, the VA space is constrained to
> > [0, 2^(va_bits)). This is different from other architectures that
> > allow for addressing low and high regions of the VA space from a single
> > page table.
> > 
> > KVM selftests' VA space allocator presumes the valid address range is
> > split between low and high memory based the MSB, which of course is a
> > poor match for arm64's TTBR0 region.
> > 
> > Add a helper that correctly handles both addressing schemes with a
> > comment describing each.
> > 
> > Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
> > ---
> 
> Thanks much!  Looks awesome, especially the comment!
> 
> Reviewed-by: Sean Christopherson <seanjc@google.com>

ty!

> >  .../selftests/kvm/include/kvm_util_base.h     |  1 +
> >  tools/testing/selftests/kvm/lib/kvm_util.c    | 49 ++++++++++++++++---
> >  2 files changed, 44 insertions(+), 6 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
> > index 6cd86da698b3..b193863d754f 100644
> > --- a/tools/testing/selftests/kvm/include/kvm_util_base.h
> > +++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
> > @@ -103,6 +103,7 @@ struct kvm_vm {
> >  	struct sparsebit *vpages_mapped;
> >  	bool has_irqchip;
> >  	bool pgd_created;
> > +	bool has_split_va_space;
> >  	vm_paddr_t ucall_mmio_addr;
> >  	vm_paddr_t pgd;
> >  	vm_vaddr_t gdt;
> > diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> > index a256ec67aff6..53d15f32f220 100644
> > --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> > +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> > @@ -186,6 +186,43 @@ const struct vm_guest_mode_params vm_guest_mode_params[] = {
> >  _Static_assert(sizeof(vm_guest_mode_params)/sizeof(struct vm_guest_mode_params) == NUM_VM_MODES,
> >  	       "Missing new mode params?");
> >  
> > +/*
> > + * Initializes vm->vpages_valid to match the canonical VA space of the
> > + * architecture.
> > + *
> > + * Most architectures split the range addressed by a single page table into a
> > + * low and high region based on the MSB of the VA. On architectures with this
> > + * behavior the VA region spans [0, 2^(va_bits - 1)), [-(2^(va_bits - 1), -1].
> > + *
> > + * arm64 is a bit different from the rest of the crowd, as the low and high
> > + * regions of the VA space are addressed by distinct paging structures
> > + * (TTBR{0,1}_EL1).
> 
> Oooh, they're different CR3s in x86 terminology?

Right, we can have two active table roots at any given time, each
mapping their own portion of the address space.

--
Thanks,
Oliver
