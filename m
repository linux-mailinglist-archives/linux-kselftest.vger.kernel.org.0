Return-Path: <linux-kselftest+bounces-38710-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CFEB2167B
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 22:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C4D54E2D46
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 20:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7C427AC35;
	Mon, 11 Aug 2025 20:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dymVH1vS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116F22DEA73
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 20:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754944309; cv=none; b=kI3jkvhtXGyafXIvkPggV+tfvL+PMt4OTv0r8z374lxcDfHOlZ+AElEt6SAaijBrjjo8h/7T432MRn2RVz3+3c7FEoYVKu+zRzKspm2R9B4z5mmrg66SZ9SzcU8nShH81RLUMJbEH7Z1K3I8sMBkOiz/scfvfqqVJNhga8WuRyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754944309; c=relaxed/simple;
	bh=Ai9dRBB8d4qu8dpG1ZynZAmHiwFhduIg+msvbg5/33U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JfPBf8+F64YjCWwQZ6iu6ZZdngp9IoCMc83gEBor6Bw6ytQyHe7ZGQXUIVlIIBgB/FfJjec5by4lgxUOOIZn5mLMJT7SWiH6cfvOsYqwmjNoLa7I41nEgOf8YWawPRQgLKel2Djtdye8eGptwyB44u6z+nBCwmXj9DA1Koluyi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dymVH1vS; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3214765a5b9so8721705a91.3
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 13:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754944307; x=1755549107; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7WPa8tBYD0OIFVoOwEGWHIpLPHlyJLpRoOr4RtfmOy0=;
        b=dymVH1vSPydD38I+BZRdBHjfy63rJZHdJzhu0YA7SVKS+2uF+jYRT5ndShL8jTQW8W
         L2JWr3CejJI12HLY9GFs2ZlRa7CQ74Wiq+Fh6hsTk50ppQI5s27A4gYeAC2+Lg6OaING
         aaGcYf1pNgWKJSIDAsRptw+nicIFJ2IPsXl/e2bnp5JRJ7GCiik9+u3/O7L/+wXTDCwz
         p+zCirbFAFydin0E7DX+e7v6QhVpHkmX6QzXd8exHmGXTIZ08m8FpBWD3qCXC2Qu+9E6
         D0Epr3GR7Vb0kJ8qXfyATa7mYeN7gSf+vrOhoKQWMUQa+ngF/kKxPELtqhiwiJYqCkEe
         0AhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754944307; x=1755549107;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7WPa8tBYD0OIFVoOwEGWHIpLPHlyJLpRoOr4RtfmOy0=;
        b=hwaTX9M15W2FkTsgniTtrMim08zGGh/klVJJSda30pcr5sewoUBc6aONbcrkZsNkYy
         FSrHRenrHXDBd83DS41beJVGTQfC5PKyilPkFHA74iLadcnyR39VRZfWra2D7HhBQ21r
         xqFJ0sHILPZVXDfuC/J2VrMuxyMP5VDhDTDlpTTSew9GDNMq4nPFJPKEH7r4VJTJBnVt
         3MZrgy6KfEkEC8dkuHmdkFuu+bkvxtTsvhQhdrXSNRgbGR9dwbYEEt7Qu6hlmOGm7ANC
         KCdp9t7uTF3CU5aZwjmo4nvX1v1IktAbdYBIZB3S74ATzPu6nRltuQRnTqPOF48/C6na
         Hitg==
X-Gm-Message-State: AOJu0Yy5NUTj57HVndsq02nBSxyzA2wUENzIgulbm3EUvQZv6dVuFzjM
	mt5QkLImTWlriCNJF5R6LO5YZGs59CSGidoViRq19cLOgBW+h27kS2PO0Y2KnmtctIj7AdEiZil
	h7uJVRA==
X-Google-Smtp-Source: AGHT+IErurXH4r/vEnE82E5glNmqFN3IjwjAl/TkthZARr9isGFZACAN2fT6DPnkUBWY4U/+Lvqq61eiYl4=
X-Received: from pjmm7.prod.google.com ([2002:a17:90b:5807:b0:31f:210e:e35d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:534e:b0:313:db0b:75db
 with SMTP id 98e67ed59e1d1-321c0b6ea3bmr1398427a91.33.1754944307421; Mon, 11
 Aug 2025 13:31:47 -0700 (PDT)
Date: Mon, 11 Aug 2025 13:31:45 -0700
In-Reply-To: <20250807201628.1185915-9-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com> <20250807201628.1185915-9-sagis@google.com>
Message-ID: <aJpTMVV-F0z8iyb4@google.com>
Subject: Re: [PATCH v8 08/30] KVM: selftests: TDX: Update load_td_memory_region()
 for VM memory backed by guest memfd
From: Sean Christopherson <seanjc@google.com>
To: Sagi Shahar <sagis@google.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Ackerley Tng <ackerleytng@google.com>, 
	Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Erdem Aktas <erdemaktas@google.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 07, 2025, Sagi Shahar wrote:
> From: Ackerley Tng <ackerleytng@google.com>
> 
> If guest memory is backed by restricted memfd
> 
> + UPM is being used, hence encrypted memory region has to be
>   registered
> + Can avoid making a copy of guest memory before getting TDX to
>   initialize the memory region
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>  .../selftests/kvm/lib/x86/tdx/tdx_util.c      | 38 +++++++++++++++----
>  1 file changed, 30 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> index bb074af4a476..e2bf9766dc03 100644
> --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> @@ -324,6 +324,21 @@ static void tdx_td_finalize_mr(struct kvm_vm *vm)
>  	tdx_ioctl(vm->fd, KVM_TDX_FINALIZE_VM, 0, NULL);
>  }
>  
> +/*
> + * Other ioctls
> + */
> +
> +/*
> + * Register a memory region that may contain encrypted data in KVM.
> + */

Drop these comments.

> +static void register_encrypted_memory_region(struct kvm_vm *vm,
> +					     struct userspace_mem_region *region)

This is a comically bad helper.  Any person that is at all familiar with KVM's
CoCo support, or that simply reads KVM's documentation, will expect this to
invoke KVM_MEMORY_ENCRYPT_REG_REGION.  And this is obviously doing much more than
"registering" an encrypted region.  Not to mention this helper doesn't need to
exist; it has _one_ caller, and the code is quite self-explanatory.

> +{
> +	vm_set_memory_attributes(vm, region->region.guest_phys_addr,
> +				 region->region.memory_size,
> +				 KVM_MEMORY_ATTRIBUTE_PRIVATE);
> +}
> +
>  /*
>   * TD creation/setup/finalization
>   */
> @@ -459,28 +474,35 @@ static void load_td_memory_region(struct kvm_vm *vm,
>  	if (!sparsebit_any_set(pages))
>  		return;
>  
> +	if (region->region.guest_memfd != -1)
> +		register_encrypted_memory_region(vm, region);
> +
>  	sparsebit_for_each_set_range(pages, i, j) {
>  		const uint64_t size_to_load = (j - i + 1) * vm->page_size;
>  		const uint64_t offset =
>  			(i - lowest_page_in_region) * vm->page_size;
>  		const uint64_t hva = hva_base + offset;
>  		const uint64_t gpa = gpa_base + offset;
> -		void *source_addr;
> +		void *source_addr = (void *)hva;
>  
>  		/*
>  		 * KVM_TDX_INIT_MEM_REGION ioctl cannot encrypt memory in place.
>  		 * Make a copy if there's only one backing memory source.
>  		 */
> -		source_addr = mmap(NULL, size_to_load, PROT_READ | PROT_WRITE,
> -				   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> -		TEST_ASSERT(source_addr,
> -			    "Could not allocate memory for loading memory region");
> -
> -		memcpy(source_addr, (void *)hva, size_to_load);
> +		if (region->region.guest_memfd == -1) {

Oh, here's the "if".

> +			source_addr = mmap(NULL, size_to_load, PROT_READ | PROT_WRITE,
> +					   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> +			TEST_ASSERT(source_addr,
> +				    "Could not allocate memory for loading memory region");
> +
> +			memcpy(source_addr, (void *)hva, size_to_load);
> +			memset((void *)hva, 0, size_to_load);
> +		}
>  
>  		tdx_init_mem_region(vm, source_addr, gpa, size_to_load);
>  
> -		munmap(source_addr, size_to_load);
> +		if (region->region.guest_memfd == -1)
> +			munmap(source_addr, size_to_load);
>  	}
>  }
>  
> -- 
> 2.51.0.rc0.155.g4a0f42376b-goog
> 

