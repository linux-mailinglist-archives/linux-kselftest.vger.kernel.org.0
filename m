Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8C36465C3
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Dec 2022 01:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiLHASA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Dec 2022 19:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiLHASA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Dec 2022 19:18:00 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172576150C;
        Wed,  7 Dec 2022 16:17:59 -0800 (PST)
Date:   Thu, 8 Dec 2022 00:17:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1670458677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mM+RUREs8XNQIXR9OLpX5FpMS6Cj+6d+9P8d8/tGhYQ=;
        b=ku/5sjzdHABEj1t0G+fh8i2C1G7TPlKULEuuL0AsGRUb9Ux6kV59QeDru18AX6//yF0gQQ
        qi9glC8ovSUnX0pEdAH+zSKl6LwdATrWKndnT9rxxTgYbq5nvQ5YxEWiKGiwHKt1PKXK4y
        q+b7skuzGcfVu+l+lCWV2z9h/98c+6U=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        Ricardo Koller <ricarkol@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] KVM: selftests: Setup ucall after loading program
 into guest memory
Message-ID: <Y5EtMWuTaJk9I3Bd@google.com>
References: <20221207214809.489070-1-oliver.upton@linux.dev>
 <20221207214809.489070-3-oliver.upton@linux.dev>
 <Y5EoZ5uwrTF3eSKw@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5EoZ5uwrTF3eSKw@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 07, 2022 at 11:57:27PM +0000, Sean Christopherson wrote:
> On Wed, Dec 07, 2022, Oliver Upton wrote:
> > The new ucall infrastructure needs to update a couple of guest globals
> > to pass through the ucall MMIO addr and pool of ucall structs. A
> > precondition of this actually working is to have the program image
> > already loaded into guest memory.
> 
> Ouch.  Might be worth explicitly stating what goes wrong.  Even though it's super
> obvious in hindsight, it still took me a few seconds to understand what
> precondition you were referring to, e.g. I was trying to figure out how selecting
> the MMIO address depended on the guest code being loaded...
> 
> > 
> > Call ucall_init() after kvm_vm_elf_load(). Continue to park the ucall
> > MMIO addr after MEM_REGION_TEST_DATA.
> > 
> > Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
> > ---
> >  tools/testing/selftests/kvm/aarch64/page_fault_test.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/kvm/aarch64/page_fault_test.c b/tools/testing/selftests/kvm/aarch64/page_fault_test.c
> > index 92d3a91153b6..95d22cfb7b41 100644
> > --- a/tools/testing/selftests/kvm/aarch64/page_fault_test.c
> > +++ b/tools/testing/selftests/kvm/aarch64/page_fault_test.c
> > @@ -609,8 +609,13 @@ static void setup_memslots(struct kvm_vm *vm, struct test_params *p)
> >  				    data_size / guest_page_size,
> >  				    p->test_desc->data_memslot_flags);
> >  	vm->memslots[MEM_REGION_TEST_DATA] = TEST_DATA_MEMSLOT;
> > +}
> > +
> > +static void setup_ucall(struct kvm_vm *vm)
> > +{
> > +	struct userspace_mem_region *region = vm_get_mem_region(vm, MEM_REGION_TEST_DATA);
> >  
> > -	ucall_init(vm, data_gpa + data_size);
> > +	ucall_init(vm, region->region.guest_phys_addr + region->region.memory_size);
> 
> Isn't there a hole after CODE_AND_DATA_MEMSLOT?  I.e. after memslot 0?

Sure, but that's only guaranteed in the PA space.

> The reason
> I ask is because if so, then we can do the temporarily heinous, but hopefully forward
> looking thing of adding a helper to wrap kvm_vm_elf_load() + ucall_init().
> 
> E.g. I think we can do this immediately, and then at some point in the 6.2 cycle
> add a dedicated region+memslot for the ucall MMIO page.

Even still, that's just a kludge to make ucalls work. We have other
MMIO devices (GIC distributor, for example) that work by chance since
nothing conflicts with the constant GPAs we've selected in the tests.

I'd rather we go down the route of having an address allocator for the
for both the VA and PA spaces to provide carveouts at runtime. There's
another issue with the new ucall implementation where identity mapping
could stomp on a program segment that I'm fighting with right now which
only further highlights the problems with our (mis)management of address
spaces in selftests.

--
Thanks,
Oliver
