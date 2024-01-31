Return-Path: <linux-kselftest+bounces-3902-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D78C844B34
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 23:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7451C25748
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 22:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE29C3A8C9;
	Wed, 31 Jan 2024 22:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KSr1X6kH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6FB3A1AC
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jan 2024 22:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706741152; cv=none; b=dY3gBudY2KpIpvkhCpEqgDR1ZhwBENjj/IJxYsUBr8weO2hrc7qqIi5p58S6+TYao4VfwHruAWn+udaW2uKgMz4K3ftCHYFy0TkT9iUr+4SQT4iB0NL+Ziu4I+r8/sGlqs1MKT2P52yJWypTq2jphhkuvh1/0i9jSxJsB5hYfjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706741152; c=relaxed/simple;
	bh=AmunZczr7Dfx6/pExPG2SuXfqHdgyF1ugeSr+E7O7go=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=msFn28N8oDMVuYaRN2qT5ANqtCqPiZfgUds0eFIreVYclAsm9WoEfsFJY38u6ROKPgyHhgj/r52x11MLo/TTKZlbChRYW7veOaRDyI2RXoj60wMBf51yiKQiSS0ruUtx4GwDEkEhSzEwca52ElIqVxoafVZlyVfJn/0CYy0AV58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KSr1X6kH; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-603f93acd7cso6484467b3.0
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Jan 2024 14:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706741149; x=1707345949; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LFZR+caDlnxynR006W8r06MBUXUFwhkI/G9N83P84WQ=;
        b=KSr1X6kHrIQ/BP+R5ebibWU22EhUPy/ug/0p0W6MqElajxbHo4ZiHrf4lbyyjsEVCS
         uunvycOKsQT0UgHurNj7+18jQSIGYNFvdZ43I22f6RkSQVh49hapm+BXRuZgvHtwCIJ1
         MHNJ5aXXC+9TExrXY90ZrfutlDh2NX0pSLsHWVzlzP5dBJbHTASNfBlFQXDbahpKTtjl
         5YsSH6pw6ognzRKgx+95eLf8kdT/By3FPdIpAOAv2UyOQAsz8+hvN83LIFvHiaKREac2
         PG3rlZjovqUuO9sJA11kjpNRqCXRmwjKy9bbBHurWZFiY2GrQT9B2B3h/QgovSFlvmPL
         PTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706741149; x=1707345949;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LFZR+caDlnxynR006W8r06MBUXUFwhkI/G9N83P84WQ=;
        b=FytwIIINqzugSVVSXPyvOGmyQsEaPUJqrENzmyXis1UNE32xl088EQhAvucv3D3hfu
         i80VPJOVGbnRgHJo/qLmoBftfjEyxRZkQNFG1NGLUG3wa7KcAKfntGMaYdNGwyTsIcHM
         rJCts0KS6343XCXAmVmqiGsChQf2S1ZToNhFZovaTciT6gf79kVER/xyXp9glJaeZBn+
         okhfDTjXO/OLHC2vtLCCd0SXhJsI0yIFLFC0jjm4GqFtut4hqoQbN+TyQtXTv6qlnbIO
         WuFmxF52Gd3w9H2M0LAZvux8a7LDbvRgXRpKUpQUonUrLgsO1XnX2DG9ZYcVmGflRJY6
         O/Dw==
X-Gm-Message-State: AOJu0YzSecc/NhwBmjfebMV3SpOSuIX9mIySQldZw5UwcNpFHbWtPpWx
	M6k4veUmeJBy44nvr0lQz/faGW4Kt4z8XT2rvzvp/svxS8omNpKAJgjlwg1JSq2IIvtC6VBvG90
	h1A==
X-Google-Smtp-Source: AGHT+IHbj+iyys3ihZ/6xbW07HHtto50GCqd6T2uQS3vYWtVgZ/I/uUSlscC69aVq4ekwAFGEgKUUC6N6OE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:11c3:b0:dc2:398d:a671 with SMTP id
 n3-20020a05690211c300b00dc2398da671mr827981ybu.10.1706741148737; Wed, 31 Jan
 2024 14:45:48 -0800 (PST)
Date: Wed, 31 Jan 2024 14:45:46 -0800
In-Reply-To: <20231102155111.28821-2-guang.zeng@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231102155111.28821-1-guang.zeng@intel.com> <20231102155111.28821-2-guang.zeng@intel.com>
Message-ID: <ZbrNmoSiufn4RM9K@google.com>
Subject: Re: [RFC PATCH v1 1/8] KVM: selftests: x86: Fix bug in addr_arch_gva2gpa()
From: Sean Christopherson <seanjc@google.com>
To: Zeng Guang <guang.zeng@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Nov 02, 2023, Zeng Guang wrote:
> Fix the approach to get page map from gva to gpa.
> 
> If gva maps a 4-KByte page, current implementation of addr_arch_gva2gpa()
> will obtain wrong page size and cannot derive correct offset from the guest
> virtual address.
> 
> Meanwhile using HUGEPAGE_MASK(x) to calculate the offset within page
> (1G/2M/4K) mistakenly incorporates the upper part of 64-bit canonical
> linear address. That will work out improper guest physical address if
> translating guest virtual address in supervisor-mode address space.

The "Meanwhile ..." is a huge clue that this should be two separate patches.

> Signed-off-by: Zeng Guang <guang.zeng@intel.com>
> ---
>  tools/testing/selftests/kvm/lib/x86_64/processor.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index d8288374078e..9f4b8c47edce 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -293,6 +293,7 @@ uint64_t *__vm_get_page_table_entry(struct kvm_vm *vm, uint64_t vaddr,
>  	if (vm_is_target_pte(pde, level, PG_LEVEL_2M))
>  		return pde;
>  
> +	*level = PG_LEVEL_4K;
>  	return virt_get_pte(vm, pde, vaddr, PG_LEVEL_4K);
>  }
>  
> @@ -496,7 +497,7 @@ vm_paddr_t addr_arch_gva2gpa(struct kvm_vm *vm, vm_vaddr_t gva)
>  	 * No need for a hugepage mask on the PTE, x86-64 requires the "unused"
>  	 * address bits to be zero.
>  	 */
> -	return PTE_GET_PA(*pte) | (gva & ~HUGEPAGE_MASK(level));
> +	return PTE_GET_PA(*pte) | (gva & (HUGEPAGE_SIZE(level) - 1));

I think I would prefer to "fix" HUGEPAGE_MASK() and drop its incorporation of
PHYSICAL_PAGE_MASK.  Regardless of anyone's personal views on whether or not
PAGE_MASK and HUGEPAGE_MASK should only cover physical address bits, (a) the
_one_ usage of HUGEPAGE_MASK is broken and (b) diverging from the kernel for
something like is a terrible idea, and the kernel does:

	#define PAGE_MASK		(~(PAGE_SIZE-1))
	#define HPAGE_MASK		(~(HPAGE_SIZE - 1))
	#define KVM_HPAGE_MASK(x)	(~(KVM_HPAGE_SIZE(x) - 1))

Luckily, there are barely any users in x86, so I think the entirety of the
conversion is this?

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 0f4792083d01..ef895038c87f 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -352,11 +352,12 @@ static inline unsigned int x86_model(unsigned int eax)
 
 #define PAGE_SHIFT             12
 #define PAGE_SIZE              (1ULL << PAGE_SHIFT)
-#define PAGE_MASK              (~(PAGE_SIZE-1) & PHYSICAL_PAGE_MASK)
+#define PAGE_MASK              (~(PAGE_SIZE-1))
+kvm_static_assert((PHYSICAL_PAGE_MASK & PAGE_MASK) == PHYSICAL_PAGE_MASK);
 
 #define HUGEPAGE_SHIFT(x)      (PAGE_SHIFT + (((x) - 1) * 9))
 #define HUGEPAGE_SIZE(x)       (1UL << HUGEPAGE_SHIFT(x))
-#define HUGEPAGE_MASK(x)       (~(HUGEPAGE_SIZE(x) - 1) & PHYSICAL_PAGE_MASK)
+#define HUGEPAGE_MASK(x)       (~(HUGEPAGE_SIZE(x) - 1))
 
 #define PTE_GET_PA(pte)                ((pte) & PHYSICAL_PAGE_MASK)
 #define PTE_GET_PFN(pte)        (PTE_GET_PA(pte) >> PAGE_SHIFT)
diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_tlb_flush.c b/tools/testing/selftests/kvm/x86_64/hyperv_tlb_flush.c
index 05b56095cf76..cc5730322072 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_tlb_flush.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_tlb_flush.c
@@ -623,7 +623,7 @@ int main(int argc, char *argv[])
        for (i = 0; i < NTEST_PAGES; i++) {
                pte = vm_get_page_table_entry(vm, data->test_pages + i * PAGE_SIZE);
                gpa = addr_hva2gpa(vm, pte);
-               __virt_pg_map(vm, gva + PAGE_SIZE * i, gpa & PAGE_MASK, PG_LEVEL_4K);
+               __virt_pg_map(vm, gva + PAGE_SIZE * i, gpa & PHYSICAL_PAGE_MASK, PG_LEVEL_4K);
                data->test_pages_pte[i] = gva + (gpa & ~PAGE_MASK);
        }
 


