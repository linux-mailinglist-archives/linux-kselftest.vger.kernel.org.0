Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEB36475C0
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Dec 2022 19:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiLHSrZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Dec 2022 13:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiLHSrX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Dec 2022 13:47:23 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA7284274
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Dec 2022 10:47:22 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id fy4so2129879pjb.0
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Dec 2022 10:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j7cHwl40udJhj8Y5X5w0jT3sEs53ZGdIUSJNwRYVu/w=;
        b=Kk0pmB/xVnaM5ZpgSosT/bmJl6omVaUQZP2piO1stBvkhoJj09JAMEnLa5p0gtxaGp
         VB7g+dz6WsXuzFyafcY8UNr3vvtXehmmHe02Mm9nFxmyuMsh/wLMv8H3DERotIKWi6AO
         znLK5EtaINJvDL0b5Oo99YEUgZo45VxCAEobT8jJtFugipi/9yBthEL78JaKdg08Xbph
         pXkMrQOicMZtmPej55vRfzNvlAHJWxAl6d+e88VeYqBJThVpJ8xmvTsam41HzLJ8vSx+
         pcYvIRTsXUGU4NF/+rQgmSnF2q0eoUpL4dRNVUkSoHlur/WtaG74BlpZUGwEzD/yuL7l
         GLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7cHwl40udJhj8Y5X5w0jT3sEs53ZGdIUSJNwRYVu/w=;
        b=ZSfPKyVoF11iUNGWgGWPkkIA4/IueWmlQJkGuGPzjkidk0F0dZA+SN26AD0V4XR4Pv
         KhTjcl1NvYiPiq1eJCKaZIn3Md/M+nwhJW5tpYLVnxK9jAmhI5W1KgnMz9N39bxJaP1h
         fW7qNQ3mx3T03S2KfQaiiELhFAu5xumSYHTCE26pzbjeoi/CQxDdrxzb8bu/kbE0kbpe
         0XoOFjr8fZqx5x4Z1GmJVY1qT5Uv6Rzte1EVMGvsUc2qEFX4MKKjDdfBBcLaTmCuIyfm
         FQTW1y3f+lmOdX6V488cVAZJ2+IZcMMsKdY3pi+hwSVWzYMZV8RdIz6SX8mREt9TdFFX
         9Rvg==
X-Gm-Message-State: ANoB5pmpwB8Js9rNiU2vOFAK1Ith7xyCaHql4I6hzibQHZ1wEOX4DfVs
        np45lXrrMwQ04ipwHM9XmKfIqg==
X-Google-Smtp-Source: AA0mqf6vd6AxHTUbjUvIEUAz0NQ7pMMjNAHpvKix0UHaCOnCHjNJp+LLTMFG9Y68lb2WJ+Cv0Q2hGg==
X-Received: by 2002:a17:90a:fd0d:b0:219:828e:ba2 with SMTP id cv13-20020a17090afd0d00b00219828e0ba2mr1498746pjb.0.1670525241105;
        Thu, 08 Dec 2022 10:47:21 -0800 (PST)
Received: from google.com (220.181.82.34.bc.googleusercontent.com. [34.82.181.220])
        by smtp.gmail.com with ESMTPSA id ay22-20020a17090b031600b001fd6066284dsm13381pjb.6.2022.12.08.10.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 10:47:20 -0800 (PST)
Date:   Thu, 8 Dec 2022 10:47:17 -0800
From:   Ricardo Koller <ricarkol@google.com>
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     Sean Christopherson <seanjc@google.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] KVM: selftests: Setup ucall after loading program
 into guest memory
Message-ID: <Y5IxNTKRnacfSsLt@google.com>
References: <20221207214809.489070-1-oliver.upton@linux.dev>
 <20221207214809.489070-3-oliver.upton@linux.dev>
 <Y5EoZ5uwrTF3eSKw@google.com>
 <Y5EtMWuTaJk9I3Bd@google.com>
 <Y5EutGSjkRmdItQb@google.com>
 <Y5Exwzr6Ibmmthl0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5Exwzr6Ibmmthl0@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 08, 2022 at 12:37:23AM +0000, Oliver Upton wrote:
> On Thu, Dec 08, 2022 at 12:24:20AM +0000, Sean Christopherson wrote:
> > On Thu, Dec 08, 2022, Oliver Upton wrote:
> > > On Wed, Dec 07, 2022 at 11:57:27PM +0000, Sean Christopherson wrote:
> > > > > diff --git a/tools/testing/selftests/kvm/aarch64/page_fault_test.c b/tools/testing/selftests/kvm/aarch64/page_fault_test.c
> > > > > index 92d3a91153b6..95d22cfb7b41 100644
> > > > > --- a/tools/testing/selftests/kvm/aarch64/page_fault_test.c
> > > > > +++ b/tools/testing/selftests/kvm/aarch64/page_fault_test.c
> > > > > @@ -609,8 +609,13 @@ static void setup_memslots(struct kvm_vm *vm, struct test_params *p)
> > > > >  				    data_size / guest_page_size,
> > > > >  				    p->test_desc->data_memslot_flags);
> > > > >  	vm->memslots[MEM_REGION_TEST_DATA] = TEST_DATA_MEMSLOT;
> > > > > +}
> > > > > +
> > > > > +static void setup_ucall(struct kvm_vm *vm)
> > > > > +{
> > > > > +	struct userspace_mem_region *region = vm_get_mem_region(vm, MEM_REGION_TEST_DATA);
> > > > >  
> > > > > -	ucall_init(vm, data_gpa + data_size);
> > > > > +	ucall_init(vm, region->region.guest_phys_addr + region->region.memory_size);
> > > > 
> > > > Isn't there a hole after CODE_AND_DATA_MEMSLOT?  I.e. after memslot 0?
> > > 
> > > Sure, but that's only guaranteed in the PA space.
> > > 
> > > > The reason
> > > > I ask is because if so, then we can do the temporarily heinous, but hopefully forward
> > > > looking thing of adding a helper to wrap kvm_vm_elf_load() + ucall_init().
> > > > 
> > > > E.g. I think we can do this immediately, and then at some point in the 6.2 cycle
> > > > add a dedicated region+memslot for the ucall MMIO page.
> > > 
> > > Even still, that's just a kludge to make ucalls work. We have other
> > > MMIO devices (GIC distributor, for example) that work by chance since
> > > nothing conflicts with the constant GPAs we've selected in the tests.
> > > 
> > > I'd rather we go down the route of having an address allocator for the
> > > for both the VA and PA spaces to provide carveouts at runtime.
> > 
> > Aren't those two separate issues?  The PA, a.k.a. memslots space, can be solved
> > by allocating a dedicated memslot, i.e. doesn't need a carve.  At worst, collisions
> > will yield very explicit asserts, which IMO is better than whatever might go wrong
> > with a carve out.
> 
> Perhaps the use of the term 'carveout' wasn't right here.
> 
> What I'm suggesting is we cannot rely on KVM memslots alone to act as an
> allocator for the PA space. KVM can provide devices to the guest that
> aren't represented as memslots. If we're trying to fix PA allocations
> anyway, why not make it generic enough to suit the needs of things
> beyond ucalls?

One extra bit of information: in arm, IO is any access to an address (within
bounds) not backed by a memslot. Not the same as x86 where MMIO are writes to
read-only memslots.  No idea what other arches do.

> 
> --
> Thanks,
> Oliver

I think that we should use these proposed changes, and then move to an ideal
solution.  These are the changes I propose:

1. add an arch specific API for allocating MMIO physical ranges:
vm_arch_mmio_region_add(vm, npages).  The x86 version creates a read-only
memslot, and the arm one allocates physical space without a memslot in it.

2. Then change all IO related users (including ucall) to use
vm_arch_mmio_region_add(). Ex:

	pa = vm_arch_mmio_region_add(vm, npages);
	ucall_init(vm, pa);

page_fault_test needs to be adapted to use vm_arch_mmio_region_add() as well.

Thanks,
Ricardo
