Return-Path: <linux-kselftest+bounces-11045-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4FC8D6978
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 21:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE2FAB22C26
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 19:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B84217C7DE;
	Fri, 31 May 2024 19:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c+stuysy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ADF80C0C
	for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 19:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717182710; cv=none; b=oUebHjLW+rJWK3Ix/681Y92sRyUojX5ILvLsWAhXwOa0z+RMtefLJCRS7X/2f1UxsTDrcTuz8OwJatJHMhy52SEv7KtCgvtzrcUllVQ483KFj1SXPYIdTAtMLIh4ErIBXv5RcFiqe2Ms+HsKcyRiLg2B/xvGt3rvJYozmD3DItI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717182710; c=relaxed/simple;
	bh=sgtQujDi/xwJoTvozQThnGUOv2FF51IL2+0TqRg8OEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPM7zAMpmtpcQBPt6g1fn+63YZ2LtT0YxOeEKPB7Zb7L1rjLmqKHkvP3lKXny6hv0LhkK7geoEI2F4g7/9jQ9d0vEootbRFXwRBnjo5xhkp8iSMXH6CVggbUta3eyafgMUdQXbwJCxgT3fCJCB/dI3zQxHYnttcVacSSuqMiuRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c+stuysy; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: jthoughton@google.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717182706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H/R5IQbpE5t+x2dR39LRiJBqiBXfmFPbwxdtpnn5hGs=;
	b=c+stuysyrYtChztUjj8bfOLa+pidnwFeuWOXm8J8IFP59C7O1SPwkzhQYX7vXUlN1P6bs5
	FvYG4eEtw8I3Z1F5NDtIKLP4wlgV4ZNL+EPxaYtUlojUk2IX9MNoL7r3xWNfltbQiD1hec
	SsERK6rU5wdZ1zfN5Rp0Z+kjvAVliNw=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: pbonzini@redhat.com
X-Envelope-To: aou@eecs.berkeley.edu
X-Envelope-To: ankita@nvidia.com
X-Envelope-To: anup@brainfault.org
X-Envelope-To: atishp@atishpatra.org
X-Envelope-To: axelrasmussen@google.com
X-Envelope-To: maobibo@loongson.cn
X-Envelope-To: catalin.marinas@arm.com
X-Envelope-To: dmatlack@google.com
X-Envelope-To: rientjes@google.com
X-Envelope-To: chenhuacai@kernel.org
X-Envelope-To: james.morse@arm.com
X-Envelope-To: corbet@lwn.net
X-Envelope-To: maz@kernel.org
X-Envelope-To: mpe@ellerman.id.au
X-Envelope-To: npiggin@gmail.com
X-Envelope-To: palmer@dabbelt.com
X-Envelope-To: paul.walmsley@sifive.com
X-Envelope-To: rananta@google.com
X-Envelope-To: ryan.roberts@arm.com
X-Envelope-To: seanjc@google.com
X-Envelope-To: shahuang@redhat.com
X-Envelope-To: shuah@kernel.org
X-Envelope-To: suzuki.poulose@arm.com
X-Envelope-To: zhaotianrui@loongson.cn
X-Envelope-To: will@kernel.org
X-Envelope-To: yuzhao@google.com
X-Envelope-To: yuzenghui@huawei.com
X-Envelope-To: kvm-riscv@lists.infradead.org
X-Envelope-To: kvm@vger.kernel.org
X-Envelope-To: kvmarm@lists.linux.dev
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-doc@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-kselftest@vger.kernel.org
X-Envelope-To: linux-mips@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-riscv@lists.infradead.org
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
X-Envelope-To: loongarch@lists.linux.dev
Date: Fri, 31 May 2024 12:11:33 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: James Houghton <jthoughton@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Ankit Agrawal <ankita@nvidia.com>, Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Bibo Mao <maobibo@loongson.cn>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	James Morse <james.morse@arm.com>, Jonathan Corbet <corbet@lwn.net>,
	Marc Zyngier <maz@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Sean Christopherson <seanjc@google.com>,
	Shaoqin Huang <shahuang@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Tianrui Zhao <zhaotianrui@loongson.cn>,
	Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
	Zenghui Yu <yuzenghui@huawei.com>, kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev
Subject: Re: [PATCH v4 6/7] KVM: arm64: Relax locking for kvm_test_age_gfn
 and kvm_age_gfn
Message-ID: <Zlog5Yk_Pjq0jQhC@linux.dev>
References: <20240529180510.2295118-1-jthoughton@google.com>
 <20240529180510.2295118-7-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529180510.2295118-7-jthoughton@google.com>
X-Migadu-Flow: FLOW_OUT

On Wed, May 29, 2024 at 06:05:09PM +0000, James Houghton wrote:

[...]

> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index 9e2bbee77491..eabb07c66a07 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -1319,10 +1319,8 @@ static int stage2_age_walker(const struct kvm_pgtable_visit_ctx *ctx,
>  	data->young = true;
>  
>  	/*
> -	 * stage2_age_walker() is always called while holding the MMU lock for
> -	 * write, so this will always succeed. Nonetheless, this deliberately
> -	 * follows the race detection pattern of the other stage-2 walkers in
> -	 * case the locking mechanics of the MMU notifiers is ever changed.
> +	 * This walk may not be exclusive; the PTE is permitted to change
> +	 * from under us.
>  	 */
>  	if (data->mkold && !stage2_try_set_pte(ctx, new))
>  		return -EAGAIN;

It is probably worth mentioning that if there was a race to update the
PTE then the GFN is most likely young, so failing to clear AF probably
isn't even consequential.

-- 
Thanks,
Oliver

