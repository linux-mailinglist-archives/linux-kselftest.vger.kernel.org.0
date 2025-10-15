Return-Path: <linux-kselftest+bounces-43270-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A14A1BE0FDF
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 00:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F9F3BD2BF
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 22:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CBF31618F;
	Wed, 15 Oct 2025 22:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TlTsnq2I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134242DCF50
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 22:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760569181; cv=none; b=obgneohgNbg2qHJYWlndIO2cRy1aPNsg4UcpGbKikLmVj7I17of6zfGJJiaVN1oxAIk4thjVmt/ACTqG1SL1ZjUmaxZOittcaxNoVGaQVYajg/0nr91yt3N0grK8nMgoKTM7ucul9kZzQO4Zir8jnsOelh3Lpes56HhwXKxlZxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760569181; c=relaxed/simple;
	bh=uhIo156uzC/C4McltMdP+aVo/99Tv7FEMfHjn0Xc2u8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DDfu+Ud/zLtAdY9uaZgustNn6fbWOvlVEOwtq/ejjW0W/smiJWKHmue4og2FtOSEbnzbi01TAqhKnLv44PalEZX+zgAAQiyYz88PfVojKiuDEkW8XxNJNBYGXBsa+w33uWY1vJ27c1uJALPMj+RtepkSBCJRxX+ii9d01YbBTIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TlTsnq2I; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2909e6471a9so856925ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 15:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760569179; x=1761173979; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M2LRH5L+16QIKbxjXKX20mFwNdwlQNo9WYUAb9uwRrg=;
        b=TlTsnq2IE+m97uHZ8IGKTgj+mqd7JcXEXgPM2N49I9GaQorS/0DbcVwvGO7c1zGm5j
         qJYvk/STzAgLzBfnqqcOJFOUiIlg51qKc8Tbc0wMCFF9nLU9kXn3orxcjAZqKhpTFgZT
         bcd4tzBfDmaXE3+/aZP40Dnj0lEOu9XqcJSf44C57/oAI12T6Q82x6JAhA8Ql3w9W6fO
         ye3lCtUtaKjeMzQ/YetEdlvyfjDPSsCEO2W3XRGrhV8FLG96RGd8AiJYik+1lpqLB4B/
         NyXvSM9Y2GVb6LZshU4lwcPWYSLxbSRhlnfIQNV2KgnEmN3CCHkl78DCQ5Le2Wb0NDBE
         Zvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760569179; x=1761173979;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M2LRH5L+16QIKbxjXKX20mFwNdwlQNo9WYUAb9uwRrg=;
        b=EXdczaVzjArym511FO/1JfDs9bfxD81B4LEdvwIS0H1pNxTL3w9AHmNZpcqSwPdKHg
         uKoVkiA+ZOu6CPGHOW4vYoR9YS+Mn4I5jXODZ7n8nIQJxhqDS//CA4x/1/BF43k0A1Bt
         pPgGgJE5OI80/51rPaJfs6MVfgDA0Qxo+PAjqxRqvXqA9sOLNxNKlC2mVTAofl0np4rL
         pYHYfcL0USJxd7JexOCS29Zm9mdUqRPBkDjUp1L3OHkBzb9hxMgkgO59jPi/kDk/3sHV
         vgeywKxFbLluL1hJujVM+gtqcvyci6Tt4y3yUBjBJxyllGxETVJPT+REgwP2mFVzHCDh
         aSPw==
X-Forwarded-Encrypted: i=1; AJvYcCUqJLVqqc0nZbnrB/ochQB/EksodVvHscAzPPZoB3Fbu9q9VmrQZ5PP8jgixdDKaNMLdQG+Bql9ZSBzgdhA5qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPyVRmplbDAADzRCebgu9CtfjoHjUcM4cyfRNUmbtfVrxOqk1X
	yc59Pnb45JK60QZoM+IhLFC9+lRvJocQtV6GwvxLDmtp7zQESRf38gZJMZimQNWyDpJ/C/qADmQ
	YRgZ1qg==
X-Google-Smtp-Source: AGHT+IGoYbQG/kFlbXk1E9FFiTS2zpFW21guzDiQfytJdFWQ7OVs1otemGZlW7GIwzVAo56e8nErvwtJawM=
X-Received: from pljj17.prod.google.com ([2002:a17:902:c3d1:b0:290:28e2:ce6c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3d0e:b0:25c:46cd:1dc1
 with SMTP id d9443c01a7336-2902734491dmr362859195ad.33.1760569179459; Wed, 15
 Oct 2025 15:59:39 -0700 (PDT)
Date: Wed, 15 Oct 2025 15:59:37 -0700
In-Reply-To: <20250917215031.2567566-4-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250917215031.2567566-1-jmattson@google.com> <20250917215031.2567566-4-jmattson@google.com>
Message-ID: <aPAnWWmo555uB0-H@google.com>
Subject: Re: [PATCH 3/4] KVM: selftests: Add VM_MODE_PXXV57_4K VM mode
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Andrew Jones <ajones@ventanamicro.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	"Pratik R. Sampat" <prsampat@amd.com>, Kai Huang <kai.huang@intel.com>, 
	Eric Auger <eric.auger@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 17, 2025, Jim Mattson wrote:
> Add a new VM mode, VM_MODE_PXXV57_4K, to support tests that require
> 5-level paging on x86. This mode sets up a 57-bit virtual address
> space and sets CR4.LA57 in the guest.
> @@ -358,6 +360,25 @@ struct kvm_vm *____vm_create(struct vm_shape shape)
>  		vm->va_bits = 48;
>  #else
>  		TEST_FAIL("VM_MODE_PXXV48_4K not supported on non-x86 platforms");
> +#endif
> +		break;
> +	case VM_MODE_PXXV57_4K:
> +#ifdef __x86_64__
> +		kvm_get_cpu_address_width(&vm->pa_bits, &vm->va_bits);
> +		kvm_init_vm_address_properties(vm);
> +		/*
> +		 * For 5-level paging, KVM requires LA57 to be enabled, which
> +		 * requires a 57-bit virtual address space.
> +		 */
> +		TEST_ASSERT(vm->va_bits == 57,
> +			    "Linear address width (%d bits) not supported for VM_MODE_PXXV57_4K",
> +			    vm->va_bits);
> +		pr_debug("Guest physical address width detected: %d\n",
> +			 vm->pa_bits);
> +		vm->pgtable_levels = 5;
> +		vm->va_bits = 57;
> +#else
> +		TEST_FAIL("VM_MODE_PXXV57_4K not supported on non-x86 platforms");
>  #endif

That's a lot of copy+paste, especially given the #ifdefs.  How about this (untested)?

	case VM_MODE_PXXV48_4K:
	case VM_MODE_PXXV57_4K:
#ifdef __x86_64__
		kvm_get_cpu_address_width(&vm->pa_bits, &vm->va_bits);
		kvm_init_vm_address_properties(vm);

		/*
		 * Ignore KVM support for 5-level paging (vm->va_bits == 57) if
		 * the target mode is 4-level paging (48-bit virtual address
		 * space), as 5-level paging only takes effect if CR4.LA57=1.
		 */
		TEST_ASSERT(vm->va_bits == 57 ||
			    (vm->va_bits == 48 && vm->mode == VM_MODE_PXXV48_4K),
			    "Linear address width (%d bits) not supported",
			    vm->va_bits);
		pr_debug("Guest physical address width detected: %d\n",
			 vm->pa_bits);
		if (vm->mode == VM_MODE_PXXV48_4K) {
			vm->pgtable_levels = 4;
			vm->va_bits = 48;
		} else {
			vm->pgtable_levels = 5;
			vm->va_bits = 57;
		}
#else
		TEST_FAIL("VM_MODE_PXXV{48,57}_4K not supported on non-x86 platforms");
#endif
		break;

