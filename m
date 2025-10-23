Return-Path: <linux-kselftest+bounces-43926-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90234C02B4C
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 19:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B22A31AA3541
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 17:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B51309EE2;
	Thu, 23 Oct 2025 17:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LxwnwsQM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFEB347FC6
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Oct 2025 17:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761239769; cv=none; b=DKNYY9kCeKIHmcewl34QgNWHxWWpjT79Y7n8/+gF6etUBEDL03+v1vF2MqLFR8FgDFR5zUNU9xYbr5C5hV2nGyxWbs6qL7yO/RnmNrrljgXjs0FYD7UgK1vps1Sje5VjO2TCn+HGmGiNLoxuNyEIsomGhKLUvb4+LmPsbEdTeV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761239769; c=relaxed/simple;
	bh=3vjklBZDK91NfPPKB/m+mZXiuBD949DF/IdVW5vVnss=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=db66UEGvB0XZy8Vu5UyZYX/4AYdBV5RB7nVDB2bVDLXwcO8ChI9ub5+FcUIk/veOaNmvood4TCdLKogZaHeQRv4a4FPZZQh0DdDiM8Tv5fKgFPFoTFukpdzWOXljrn0lHe1iS64Yq4+Kbu6+N09fjL6sqH997XbzccEtQXSfXB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LxwnwsQM; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2924b3b9d47so10588885ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Oct 2025 10:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761239767; x=1761844567; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/DTN4f9sYvKKbqzH4zMTtt+lW5xHHb7Uewe/2Me0Lwc=;
        b=LxwnwsQMjWRMGpoXy31nd6AyCrOukM0uUMX7deu20qo7q30KMCjEEZDYhkC40aOus+
         dESIMOiz59htetzN1GY+a8d39hT5AwOH2LqpPmPqsN806OVexEEppo/cfCrs6l75beiN
         ttzi/+XVmKZsgLSonurq+SM+UjFV6WqRIckRbo8jONK1rJFyMUSfcdAuL79XjfckdTkx
         qVkqUu7cHFjAXeiAuRtY6BUprhRaLtAviTIC90i+MPxtZzwfBtUGIx+fdAB6fayacJnL
         q3B/8iiudaM1yFOowITDFdKAXmNeWYPPKfIER8Ll0hxwryvbM0KaRrW4lmGmVT92L3Dy
         WoRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761239767; x=1761844567;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/DTN4f9sYvKKbqzH4zMTtt+lW5xHHb7Uewe/2Me0Lwc=;
        b=ToTOdaXcgaes8D6i8SxLmNQ0EFVqBzMDaexpe321EEXmOwbZwbeHOTpdwyi5UrTQsV
         IF0kOrJVSWPRtyeWu//Fw4+V4nbvyibdhP1lfh0Nqbg739/07QmTFWtqekEj1OasquDg
         bYadAar8I4mAWLkC3dxVWMVQVsz6Y/C0Z8uemQDUjXl5l77XQ58fzMipWWVX7SnpoiEq
         9mYN4xS6yfIhLIRQbDosHFLksT17qoje8w/6nX8SooLzIoVoSK+rd3RmfHD5wHvzzgbC
         HLtDQ0Vl34hz0OQBqNh6Z5pm98ACHF8rDsOKC6hGWpOxLcSpAQDlqOrT5t43zsJu0rhu
         MO2w==
X-Forwarded-Encrypted: i=1; AJvYcCWk6hFV+ceaT8Dw8FaFtgLEgJa1bNvyz7zr0RhrT0UCuMPibRBlXFN8/rQXHjIEzS7oMVOWjns6Ydz/8OCOs6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFAv93z7KcGuPEvK2nuJykrubKboO0IikarlOMGHcBXZimCCGD
	gVhwK1tAoBsASFH47xwY33ZJLx9XRcOlApN4aoyn/sF0JvMA1A2r2FJ+DvceJdjO4nQsFh7xVX2
	1EIvNlQ==
X-Google-Smtp-Source: AGHT+IHWPgGmZKfo+3ImlZCUG7AewIscdCvWipQB1xDHXcjZQxceHYcdCY71wfIfELDOVuODkQ3p+Aq3kE8=
X-Received: from pjkm11.prod.google.com ([2002:a17:90a:730b:b0:33b:e0b5:6112])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e88e:b0:267:da75:e0f
 with SMTP id d9443c01a7336-290c9c897bbmr312407025ad.11.1761239766935; Thu, 23
 Oct 2025 10:16:06 -0700 (PDT)
Date: Thu, 23 Oct 2025 10:16:05 -0700
In-Reply-To: <20251013151502.6679-3-jackabt.amazon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013151502.6679-1-jackabt.amazon@gmail.com> <20251013151502.6679-3-jackabt.amazon@gmail.com>
Message-ID: <aPpi1c-8EpWuo87B@google.com>
Subject: Re: [PATCH v2 2/4] KVM: selftests: Fix unaligned mmap allocations
From: Sean Christopherson <seanjc@google.com>
To: Jack Thomson <jackabt.amazon@gmail.com>
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	isaku.yamahata@intel.com, roypat@amazon.co.uk, kalyazin@amazon.co.uk, 
	jackabt@amazon.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Oct 13, 2025, Jack Thomson wrote:
> From: Jack Thomson <jackabt@amazon.com>
> 
> When creating a VM using mmap with huge pages, and the memory amount does
> not align with the underlying page size. The stored mmap_size value does
> not account for the fact that mmap will automatically align the length
> to a multiple of the underlying page size. During the teardown of the
> test, munmap is used. However, munmap requires the length to be a
> multiple of the underlying page size.

What happens when selftests use the wrong map_size?  E.g. is munmap() silently
failing?  If so, then I should probably take this particular patch through
kvm-x86/gmem, otherwise it means we'll start getting asserts due to:

  3223560c93eb ("KVM: selftests: Define wrappers for common syscalls to assert success")

If munmap() isn't failing, then that begs the question of what this patch is
actually doing :-)

> Update the vm_mem_add method to ensure the mmap_size is aligned to the
> underlying page size.
> 
> Signed-off-by: Jack Thomson <jackabt@amazon.com>
> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index c3f5142b0a54..b106fbed999c 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1051,7 +1051,6 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
>  	/* Allocate and initialize new mem region structure. */
>  	region = calloc(1, sizeof(*region));
>  	TEST_ASSERT(region != NULL, "Insufficient Memory");
> -	region->mmap_size = mem_size;
>  
>  #ifdef __s390x__
>  	/* On s390x, the host address must be aligned to 1M (due to PGSTEs) */
> @@ -1060,6 +1059,11 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
>  	alignment = 1;
>  #endif
>  
> +	alignment = max(backing_src_pagesz, alignment);
> +	region->mmap_size = align_up(mem_size, alignment);
> +
> +	TEST_ASSERT_EQ(guest_paddr, align_up(guest_paddr, backing_src_pagesz));
> +
>  	/*
>  	 * When using THP mmap is not guaranteed to returned a hugepage aligned
>  	 * address so we have to pad the mmap. Padding is not needed for HugeTLB
> @@ -1067,12 +1071,6 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
>  	 * page size.
>  	 */
>  	if (src_type == VM_MEM_SRC_ANONYMOUS_THP)
> -		alignment = max(backing_src_pagesz, alignment);
> -
> -	TEST_ASSERT_EQ(guest_paddr, align_up(guest_paddr, backing_src_pagesz));
> -
> -	/* Add enough memory to align up if necessary */
> -	if (alignment > 1)
>  		region->mmap_size += alignment;
>  
>  	region->fd = -1;
> -- 
> 2.43.0
> 

