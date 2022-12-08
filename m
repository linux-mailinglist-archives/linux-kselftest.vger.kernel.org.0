Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD53D6475DE
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Dec 2022 20:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiLHTCE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Dec 2022 14:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiLHTCD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Dec 2022 14:02:03 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE498DBF5
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Dec 2022 11:02:02 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id gt4so802001pjb.1
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Dec 2022 11:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+qj/hgsudAsSQeQjwLgM7Er96xTBcPfba5POCbUPtwA=;
        b=OZuydJPyQ7RHibQ69DK8aLxuHXUNvSGO5obZIQv0KYH19XsbkQC1aG0MlCb9PZfWCX
         WANqzP3qFui9udWh/088tR7qgAyIVZwDGFo6GozIXGCty6MttKLjyVr6Wzvr+QVAH/AF
         6CxPB1pZJI35PWxIXsUk570n/LIoeqNl0mKpWtUxBSngeOqY8WIEIU+b2qKpqC3mmnRL
         Dve6GGtJOchEaa/us9OjD0lEqWy44kquFqcZs3uIXXlcOMAgUVCnkwQK7KWcE65oXveM
         9+OVSAKOLGY8YdAZ+y4D4olEzaD3AMRaIj6tQqRenz46uiGZ8DQ8PpV10U+fjEiVoNcZ
         6j8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qj/hgsudAsSQeQjwLgM7Er96xTBcPfba5POCbUPtwA=;
        b=5ydTXMM4+epaWe3pVzE3GdV7aipaTK5ioCYH5OquBnnj05x4tebs/+3pYb0SoG7LoS
         IURMuB85g3/rZkrS8ztdBlM7k7yRf0eQr+2vuqc/pQit81YvAQnTER3U1o5ea8bXfemL
         9x32dvFpFTs+vgaBrrMJ97p4AfCo0OWZJkOM8RHx6kA2pu+VouF+gssHPLgeLbOoyhAd
         DsumqQMHfmj9JHVTB874rhc5LaIEE55++2ycInpiV+WQhVukElG67wAiLWi6DQBlm4at
         OV4o2Az81iIsUsGvNnWgILjLsKb9SOziRZLlJlOYUdCX9S0Na0IXKkO0gnCWpCjpV8F4
         bu/w==
X-Gm-Message-State: ANoB5pnJ0NiCB6r/A8EQOxrOeAJF4gcrdC1GK39gZQ00aw7IDWjCPu6t
        JDzy4+ZB2OuBdU4zGg9Kut3JbA==
X-Google-Smtp-Source: AA0mqf4AGgSjtYnu5c8NEL23WDXyqgRNekWyEeU6QVFPhXeyxHMI+VeQ/2t+hiPXrAUk+4iEU+mr5g==
X-Received: by 2002:a17:902:7402:b0:189:58a8:282 with SMTP id g2-20020a170902740200b0018958a80282mr1565905pll.3.1670526121972;
        Thu, 08 Dec 2022 11:02:01 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id u17-20020a170902e81100b0018996404dd5sm5999822plg.109.2022.12.08.11.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 11:02:01 -0800 (PST)
Date:   Thu, 8 Dec 2022 19:01:57 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Ricardo Koller <ricarkol@google.com>
Cc:     Oliver Upton <oliver.upton@linux.dev>,
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
Message-ID: <Y5I0paok+dvTtrkt@google.com>
References: <20221207214809.489070-1-oliver.upton@linux.dev>
 <20221207214809.489070-3-oliver.upton@linux.dev>
 <Y5EoZ5uwrTF3eSKw@google.com>
 <Y5EtMWuTaJk9I3Bd@google.com>
 <Y5EutGSjkRmdItQb@google.com>
 <Y5Exwzr6Ibmmthl0@google.com>
 <Y5IxNTKRnacfSsLt@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5IxNTKRnacfSsLt@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 08, 2022, Ricardo Koller wrote:
> On Thu, Dec 08, 2022 at 12:37:23AM +0000, Oliver Upton wrote:
> > On Thu, Dec 08, 2022 at 12:24:20AM +0000, Sean Christopherson wrote:
> > > > Even still, that's just a kludge to make ucalls work. We have other
> > > > MMIO devices (GIC distributor, for example) that work by chance since
> > > > nothing conflicts with the constant GPAs we've selected in the tests.
> > > > 
> > > > I'd rather we go down the route of having an address allocator for the
> > > > for both the VA and PA spaces to provide carveouts at runtime.
> > > 
> > > Aren't those two separate issues?  The PA, a.k.a. memslots space, can be solved
> > > by allocating a dedicated memslot, i.e. doesn't need a carve.  At worst, collisions
> > > will yield very explicit asserts, which IMO is better than whatever might go wrong
> > > with a carve out.
> > 
> > Perhaps the use of the term 'carveout' wasn't right here.
> > 
> > What I'm suggesting is we cannot rely on KVM memslots alone to act as an
> > allocator for the PA space. KVM can provide devices to the guest that
> > aren't represented as memslots. If we're trying to fix PA allocations
> > anyway, why not make it generic enough to suit the needs of things
> > beyond ucalls?
> 
> One extra bit of information: in arm, IO is any access to an address (within
> bounds) not backed by a memslot. Not the same as x86 where MMIO are writes to
> read-only memslots.  No idea what other arches do.

I don't think that's correct, doesn't this code turn write abort on a RO memslot
into an io_mem_abort()?  Specifically, the "(write_fault && !writable)" check will
match, and assuming none the the edge cases in the if-statement fire, KVM will
send the write down io_mem_abort().

	gfn = fault_ipa >> PAGE_SHIFT;
	memslot = gfn_to_memslot(vcpu->kvm, gfn);
	hva = gfn_to_hva_memslot_prot(memslot, gfn, &writable);
	write_fault = kvm_is_write_fault(vcpu);
	if (kvm_is_error_hva(hva) || (write_fault && !writable)) {
		/*
		 * The guest has put either its instructions or its page-tables
		 * somewhere it shouldn't have. Userspace won't be able to do
		 * anything about this (there's no syndrome for a start), so
		 * re-inject the abort back into the guest.
		 */
		if (is_iabt) {
			ret = -ENOEXEC;
			goto out;
		}

		if (kvm_vcpu_abt_iss1tw(vcpu)) {
			kvm_inject_dabt(vcpu, kvm_vcpu_get_hfar(vcpu));
			ret = 1;
			goto out_unlock;
		}

		/*
		 * Check for a cache maintenance operation. Since we
		 * ended-up here, we know it is outside of any memory
		 * slot. But we can't find out if that is for a device,
		 * or if the guest is just being stupid. The only thing
		 * we know for sure is that this range cannot be cached.
		 *
		 * So let's assume that the guest is just being
		 * cautious, and skip the instruction.
		 */
		if (kvm_is_error_hva(hva) && kvm_vcpu_dabt_is_cm(vcpu)) {
			kvm_incr_pc(vcpu);
			ret = 1;
			goto out_unlock;
		}

		/*
		 * The IPA is reported as [MAX:12], so we need to
		 * complement it with the bottom 12 bits from the
		 * faulting VA. This is always 12 bits, irrespective
		 * of the page size.
		 */
		fault_ipa |= kvm_vcpu_get_hfar(vcpu) & ((1 << 12) - 1);
		ret = io_mem_abort(vcpu, fault_ipa);
		goto out_unlock;
	}
