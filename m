Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFF15153044
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2020 13:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgBEMAU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Feb 2020 07:00:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28276 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726944AbgBEMAU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Feb 2020 07:00:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580904019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z9OdtqIYUBqoL66r9+oESb2jG/fvhjGyIkGlsqD7Tqs=;
        b=Zu8GloQXevbRztiZNaiP3ZMlDOh5IxvGJjH3niQ5iF+dc1QED9yEdRTpS7N9bog1O0ZTrb
        8VNvj5RbuBEhts5N4Ie+RDNMdxtm1YnSreomfuieRreZnDnwS9o5cX7vIT8iKREYKg7zKb
        ss74HoNb9hXcOtCWY1pW8JXTSgKBzcE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-F1-mmtrQNUK_F6AgANwqWg-1; Wed, 05 Feb 2020 07:00:14 -0500
X-MC-Unique: F1-mmtrQNUK_F6AgANwqWg-1
Received: by mail-wr1-f69.google.com with SMTP id l1so1090367wrt.4
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Feb 2020 04:00:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Z9OdtqIYUBqoL66r9+oESb2jG/fvhjGyIkGlsqD7Tqs=;
        b=L4spYupXaJjc5aylWYaDP6kLYwS/b+Hp8KuRr5jA6E79ID7BWjqgUzYkCNrWfqVfhc
         ugc1qsxuI1bin5LSBz769WyltbgiXb781l+Ivn7w/LTp4XZLJhrjaQXiO63OYenRQpAC
         ijpGn17HnWNE2+2JA1b1rgUe0Luk9+UeauRO9AwZo0VoHkMwVJGPwt+t8MkcZscOdov1
         4y8CWoV55OXHriEhpnwgmSfNU0G44h825DbFqcd2WURH0Wd5drSFk1kZATMKLYCA1/ra
         ojrAOxac0eyt8VS0AuCRWd6ich4qJI05YEh7fZTXJUFFOQyganlMDHfvwbKDQvYvQ7FG
         pbJA==
X-Gm-Message-State: APjAAAWZRzIRxhgwVXyl8Jrz4VoMf3AOmTuLUVhpSR2RMi8dfR5golD1
        2l6nUrOBQLkDWOhYwsiWD0C6uQ+4g7BzQh+qupkdHMvZn6U3rsCpSnWWJE5RN0knxtTXGnXgG2s
        ndJFIdn1YlFKuVKrWyBH98HklMjo/
X-Received: by 2002:a5d:4c89:: with SMTP id z9mr22168465wrs.97.1580904013137;
        Wed, 05 Feb 2020 04:00:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqwSvQyMeJTISB9Ag6NMPuNBbKfC47aIaLnVUfMV7jVwsDN2cT06Yn/Y71CxLRow8+0A6XsFrQ==
X-Received: by 2002:a5d:4c89:: with SMTP id z9mr22168431wrs.97.1580904012809;
        Wed, 05 Feb 2020 04:00:12 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q14sm34679205wrj.81.2020.02.05.04.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 04:00:12 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/3] kvm: mmu: Replace unsigned with unsigned int for PTE access
In-Reply-To: <20200203230911.39755-1-bgardon@google.com>
References: <20200203230911.39755-1-bgardon@google.com>
Date:   Wed, 05 Feb 2020 13:00:11 +0100
Message-ID: <87v9olkzw4.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Ben Gardon <bgardon@google.com> writes:

> There are several functions which pass an access permission mask for
> SPTEs as an unsigned. This works, but checkpatch complains about it.
> Switch the occurrences of unsigned to unsigned int to satisfy checkpatch.
>
> No functional change expected.
>
> Tested by running kvm-unit-tests on an Intel Haswell machine. This
> commit introduced no new failures.
>
> This commit can be viewed in Gerrit at:
> 	https://linux-review.googlesource.com/c/virt/kvm/kvm/+/2358
>
> Signed-off-by: Ben Gardon <bgardon@google.com>
> Reviewed-by: Oliver Upton <oupton@google.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 84eeb61d06aa3..a9c593dec49bf 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -452,7 +452,7 @@ static u64 get_mmio_spte_generation(u64 spte)
>  }
>  
>  static void mark_mmio_spte(struct kvm_vcpu *vcpu, u64 *sptep, u64 gfn,
> -			   unsigned access)
> +			   unsigned int access)
>  {
>  	u64 gen = kvm_vcpu_memslots(vcpu)->generation & MMIO_SPTE_GEN_MASK;
>  	u64 mask = generation_mmio_spte_mask(gen);
> @@ -484,7 +484,7 @@ static unsigned get_mmio_spte_access(u64 spte)
>  }
>  
>  static bool set_mmio_spte(struct kvm_vcpu *vcpu, u64 *sptep, gfn_t gfn,
> -			  kvm_pfn_t pfn, unsigned access)
> +			  kvm_pfn_t pfn, unsigned int access)
>  {
>  	if (unlikely(is_noslot_pfn(pfn))) {
>  		mark_mmio_spte(vcpu, sptep, gfn, access);
> @@ -2475,7 +2475,7 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
>  					     gva_t gaddr,
>  					     unsigned level,
>  					     int direct,
> -					     unsigned access)
> +					     unsigned int access)
>  {
>  	union kvm_mmu_page_role role;
>  	unsigned quadrant;
> @@ -2990,7 +2990,7 @@ static bool kvm_is_mmio_pfn(kvm_pfn_t pfn)
>  #define SET_SPTE_NEED_REMOTE_TLB_FLUSH	BIT(1)
>  
>  static int set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
> -		    unsigned pte_access, int level,
> +		    unsigned int pte_access, int level,
>  		    gfn_t gfn, kvm_pfn_t pfn, bool speculative,
>  		    bool can_unsync, bool host_writable)
>  {
> @@ -3081,9 +3081,10 @@ static int set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
>  	return ret;
>  }
>  
> -static int mmu_set_spte(struct kvm_vcpu *vcpu, u64 *sptep, unsigned pte_access,
> -			int write_fault, int level, gfn_t gfn, kvm_pfn_t pfn,
> -		       	bool speculative, bool host_writable)
> +static int mmu_set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
> +			unsigned int pte_access, int write_fault, int level,
> +			gfn_t gfn, kvm_pfn_t pfn, bool speculative,
> +			bool host_writable)
>  {
>  	int was_rmapped = 0;
>  	int rmap_count;
> @@ -3165,7 +3166,7 @@ static int direct_pte_prefetch_many(struct kvm_vcpu *vcpu,
>  {
>  	struct page *pages[PTE_PREFETCH_NUM];
>  	struct kvm_memory_slot *slot;
> -	unsigned access = sp->role.access;
> +	unsigned int access = sp->role.access;
>  	int i, ret;
>  	gfn_t gfn;
>  
> @@ -3400,7 +3401,8 @@ static int kvm_handle_bad_page(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
>  }
>  
>  static bool handle_abnormal_pfn(struct kvm_vcpu *vcpu, gva_t gva, gfn_t gfn,
> -				kvm_pfn_t pfn, unsigned access, int *ret_val)
> +				kvm_pfn_t pfn, unsigned int access,
> +				int *ret_val)
>  {
>  	/* The pfn is invalid, report the error! */
>  	if (unlikely(is_error_pfn(pfn))) {
> @@ -4005,7 +4007,7 @@ static int handle_mmio_page_fault(struct kvm_vcpu *vcpu, u64 addr, bool direct)
>  
>  	if (is_mmio_spte(spte)) {
>  		gfn_t gfn = get_mmio_spte_gfn(spte);
> -		unsigned access = get_mmio_spte_access(spte);
> +		unsigned int access = get_mmio_spte_access(spte);
>  
>  		if (!check_mmio_spte(vcpu, spte))
>  			return RET_PF_INVALID;
> @@ -4349,7 +4351,7 @@ static void inject_page_fault(struct kvm_vcpu *vcpu,
>  }
>  
>  static bool sync_mmio_spte(struct kvm_vcpu *vcpu, u64 *sptep, gfn_t gfn,
> -			   unsigned access, int *nr_present)
> +			   unsigned int access, int *nr_present)
>  {
>  	if (unlikely(is_mmio_spte(*sptep))) {
>  		if (gfn != get_mmio_spte_gfn(*sptep)) {

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

