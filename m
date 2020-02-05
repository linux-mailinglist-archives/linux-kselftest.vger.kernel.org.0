Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53B2E1531F7
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2020 14:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgBENhj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Feb 2020 08:37:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33505 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726575AbgBENhj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Feb 2020 08:37:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580909858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1ZHZKV/jKaOSLjENoe5XZtmnBOqMNMYSGhSaLDt7Q6E=;
        b=TnSvzEoOh1sYcsWezVYdDfooDRdzywLACQixx0YAuCWdZGfFfS90J/JRl8TnGT0QxL0vWd
        74QJV681/IlsjvEumQ2o6LuH84c8bE50Y5bCn9GTcadO+rIESOK2M/vpiWRUk21EOL7Cz8
        p7vHu9DJyYnTwaJAMpSTPHjVMNB4Gh0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-UYhcgnVjMOqT22GpKhfJYQ-1; Wed, 05 Feb 2020 08:37:28 -0500
X-MC-Unique: UYhcgnVjMOqT22GpKhfJYQ-1
Received: by mail-wr1-f71.google.com with SMTP id l1so1210641wrt.4
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Feb 2020 05:37:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=1ZHZKV/jKaOSLjENoe5XZtmnBOqMNMYSGhSaLDt7Q6E=;
        b=LblkZTernVR+99sMskw721M5kRXcfqBeyGF1RVvlfAk3QwdXUrhGN8v6QasnpgO2uV
         WhYTlgh5625p/nX+1G7vWL0cXXwK2aCyMYSq6Bc16ewSlDLMDobg03TTlKYkpifltJZk
         OkGkGVFyH/Nm1faL398LbfbPspvb0EqPTP/KyskZC84ERWxoMpxDP0KQ2OpdL5yp+BoF
         LSHweDtNMsgD15NxC0Fl/dwww8L+MGEbM00gfcVqWPkgUGCrOccXBggJ66aiRydY8m3f
         xbMSHscCcRPJHb3GJo49rfNofLkgsqb16oi4zu5ZFD/n2e82IY/WpuhKuRoWu3P5GxCL
         rnXw==
X-Gm-Message-State: APjAAAUqHISDWOQCl3oGi74Caco9yYkB8mFUjhEWv5sIEPUB8DFZKBCH
        7oiHaSDj/C9wXGnrSgKdbNdSUwJE7h49CURMrs9FFq9urZO1AATylzVMnvsP9CFanbEP8uokSkJ
        ZRkyB3AIree0qVPEesRhs9kkG3FRC
X-Received: by 2002:a1c:9a56:: with SMTP id c83mr5908607wme.79.1580909847567;
        Wed, 05 Feb 2020 05:37:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqwzFfXP0e0I4L4edLOhHxfXyc4Wmj97qyd8lGe4qqcytnp7OMRoH9/s3pDomwcVTc8YqdMMAg==
X-Received: by 2002:a1c:9a56:: with SMTP id c83mr5908575wme.79.1580909847254;
        Wed, 05 Feb 2020 05:37:27 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id k13sm33844114wrx.59.2020.02.05.05.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 05:37:26 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/3] kvm: mmu: Separate generating and setting mmio ptes
In-Reply-To: <20200203230911.39755-2-bgardon@google.com>
References: <20200203230911.39755-1-bgardon@google.com> <20200203230911.39755-2-bgardon@google.com>
Date:   Wed, 05 Feb 2020 14:37:25 +0100
Message-ID: <87sgjpkve2.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Ben Gardon <bgardon@google.com> writes:

> Separate the functions for generating MMIO page table entries from the
> function that inserts them into the paging structure. This refactoring
> will facilitate changes to the MMU sychronization model to use atomic
> compare / exchanges (which are not guaranteed to succeed) instead of a
> monolithic MMU lock.
>
> No functional change expected.
>
> Tested by running kvm-unit-tests on an Intel Haswell machine. This
> commit introduced no new failures.
>
> This commit can be viewed in Gerrit at:
> 	https://linux-review.googlesource.com/c/virt/kvm/kvm/+/2359
>
> Signed-off-by: Ben Gardon <bgardon@google.com>
> Reviewed-by: Oliver Upton <oupton@google.com>
> Reviewed-by: Peter Shier <pshier@google.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index a9c593dec49bf..b81010d0edae1 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -451,9 +451,9 @@ static u64 get_mmio_spte_generation(u64 spte)
>  	return gen;
>  }
>  
> -static void mark_mmio_spte(struct kvm_vcpu *vcpu, u64 *sptep, u64 gfn,
> -			   unsigned int access)
> +static u64 make_mmio_spte(struct kvm_vcpu *vcpu, u64 gfn, unsigned int access)
>  {
> +

Unneded newline.

>  	u64 gen = kvm_vcpu_memslots(vcpu)->generation & MMIO_SPTE_GEN_MASK;
>  	u64 mask = generation_mmio_spte_mask(gen);
>  	u64 gpa = gfn << PAGE_SHIFT;
> @@ -464,6 +464,17 @@ static void mark_mmio_spte(struct kvm_vcpu *vcpu, u64 *sptep, u64 gfn,
>  	mask |= (gpa & shadow_nonpresent_or_rsvd_mask)
>  		<< shadow_nonpresent_or_rsvd_mask_len;
>  
> +	return mask;
> +}
> +
> +static void mark_mmio_spte(struct kvm_vcpu *vcpu, u64 *sptep, u64 gfn,
> +			   unsigned int access)
> +{
> +	u64 mask = make_mmio_spte(vcpu, gfn, access);
> +	unsigned int gen = get_mmio_spte_generation(mask);
> +
> +	access = mask & ACC_ALL;
> +
>  	trace_mark_mmio_spte(sptep, gfn, access, gen);

'access' and 'gen' are only being used for tracing, would it rather make
sense to rename&move it to the newly introduced make_mmio_spte()? Or do
we actually need tracing for both?

Also, I dislike re-purposing function parameters.

>  	mmu_spte_set(sptep, mask);
>  }

-- 
Vitaly

