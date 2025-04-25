Return-Path: <linux-kselftest+bounces-31647-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0BCA9CAD2
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 15:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7521E7B2EA9
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 13:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AE478F4B;
	Fri, 25 Apr 2025 13:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="UFof23l2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F8C61FF2
	for <linux-kselftest@vger.kernel.org>; Fri, 25 Apr 2025 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745589032; cv=none; b=MCFEg1iG5lv5ziMVd35QB4EoMsAVnW91aGBVdhEWk50VHgkM/xHe1TD1bg2gSM30WHCRHx7RfrNCrqwoQpUiib3xbPGgoud2tbSGOYzxb58mQZsraVCiBvGOaxd180vaKWXsNqq2o8i+51rGWc/NQEN0WBC2SBwa0gHS6RyqcXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745589032; c=relaxed/simple;
	bh=D+DjpJkVY50DCH/EIM2jyo+5APpyBQvmmE9jeNvI0IY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ci0PwQwrIMBbnw3gW9SLD91RzNxzjsQP6Hx1rX/lBVH0mj2DEgzDIhJJYES2c7zMllENJGA09r3O048LDi9hZuOE55ZJ9FhrWy+F99r5q8owzdmDrqBr2iZaDj/9j1/hA+3q5Y4JEvA1YQ4PGlUsBI8eq0fmf2HypfQuaWO7Kok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=UFof23l2; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so15201265e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Apr 2025 06:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1745589029; x=1746193829; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUA/m6gOa249NNOmchovOHq5LELqOzlt/ubdwJUo+cU=;
        b=UFof23l2l5NNuW4SRlxc5RyBLx3foa/OACM0JNkbNkWglyp3NrALdiOP13LBxFEOCY
         DPBjBTbQVDK9MRRXCDl+/ikzUejmImiGShFwlLTR9KjMeGVGjUDgPmrGVxx36kAHJI+q
         roV1RMdHSja37GodK2QFW8/zVz/p/La0UoeVyKWJk4OxA2Cl/5MBhwH7lJBd4QDOC+sd
         uxiw5iZiJYfD8+ki7R2gZg5oBsyrV8iYm+H/7Ef+3PGWoyzH4H95+ELGn7+KzQgVvXqc
         lOT0lAYw1Zi17Z8e+bqQHCGjHOZgIrPgH9NfITuXRe1qHX7xWZe3AcvXHP9I2MH/+kAF
         wKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745589029; x=1746193829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUA/m6gOa249NNOmchovOHq5LELqOzlt/ubdwJUo+cU=;
        b=PwIeJd9czoA37302Od2STOTknWyVznrVKtTf6BS4mgfx8Dx7MnLYPYHcvb95tB1xFk
         bXKA5Xo0vnE8m0vXQfVGEC5jL3vpPrIEJPay4KX/iUr0ubQiK5PNBlrQFhWbbTf5FNFW
         TiTDyGbFMESaMt1UuFpKxOXEHohLHZgwfaM6Uc5C5dZdGDFOsHszPHuvV6X6vGQYKlkz
         3KPBsyk8EPrpFXvjzQqIdRUCJcbxE/p9D1M5HNJdvtuVbWXMR+CPsnkvdFbYW+AKazJB
         G8JHGy9gZLe/Isj4Lqds26LJw6X01HfFE5spoQ5Oohv72MJmxEbltbT6Q3vq2x002kJ6
         C48Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCyREv6PXqwmFKfAKZtLStJjjkcpBQpeiVjXjOvtQmUlMUktjHTEG7zDQUDMke9F4AHBWEQxW79DfEuwe3EF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAAVP4uDNmrixPSRgUDGDw6cnMn00svnNMP1h0QRvunpU0K1Sc
	aT0s+A3SX0c/+HoQvC6tL2U25i/pzHCdSmT7hxdLXypVJcsEKWoies0iTr2md5E=
X-Gm-Gg: ASbGncsLpIXR02Y8emsKCOqYM7OF3qE3CTbEceypHy3u0KQQkhmSnr9TYQlmfgUqXYS
	CkbJ4uu34UR6j1knSAfutufQmHtPBgJZ7tNiBgQ0le4EtgsI7eytPErPQFHm6/p2Y69xi5SH9J4
	IBdHgZMUfmbxqpj789FLjMsmGLSqzg1ICV/nMQ88IKmSGoCo38hzMEpzPQqECcZ+ryYcxOu3Z/A
	Xi2HKbebsCkCsPYMynxTeGCBxyg4wsGGa+m3V8kG3Z+vcAOSxIQuR5Rj6tUaHSR77AAZj1pJ/iY
	uO+XQWutfW2ICVwL6PauaTkGTXt1
X-Google-Smtp-Source: AGHT+IF/LMdkzYLBWPyT5ztxJyzb+GPhFh3GxsY5b8ixWQQMljvmNbliBGV7ZjWkl9GsiErnAoI9/g==
X-Received: by 2002:a05:600c:1f82:b0:43d:934:ea97 with SMTP id 5b1f17b1804b1-440a66ab23bmr18288315e9.27.1745589028834;
        Fri, 25 Apr 2025 06:50:28 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::f716])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073c8cab5sm2480265f8f.10.2025.04.25.06.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 06:50:28 -0700 (PDT)
Date: Fri, 25 Apr 2025 15:50:27 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] KVM: riscv: selftests: Add stval to exception
 handling
Message-ID: <20250425-dc44cb547ab5e2f994c94e80@orel>
References: <20250324-kvm_selftest_improve-v1-0-583620219d4f@rivosinc.com>
 <20250324-kvm_selftest_improve-v1-1-583620219d4f@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324-kvm_selftest_improve-v1-1-583620219d4f@rivosinc.com>

On Mon, Mar 24, 2025 at 05:40:29PM -0700, Atish Patra wrote:
> Save stval during exception handling so that it can be decoded to
> figure out the details of exception type.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  tools/testing/selftests/kvm/include/riscv/processor.h | 1 +
>  tools/testing/selftests/kvm/lib/riscv/handlers.S      | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
> index 5f389166338c..f4a7d64fbe9a 100644
> --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> @@ -95,6 +95,7 @@ struct ex_regs {
>  	unsigned long epc;
>  	unsigned long status;
>  	unsigned long cause;
> +	unsigned long stval;
>  };
>  
>  #define NR_VECTORS  2
> diff --git a/tools/testing/selftests/kvm/lib/riscv/handlers.S b/tools/testing/selftests/kvm/lib/riscv/handlers.S
> index aa0abd3f35bb..2884c1e8939b 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/handlers.S
> +++ b/tools/testing/selftests/kvm/lib/riscv/handlers.S
> @@ -45,9 +45,11 @@
>  	csrr  s0, CSR_SEPC
>  	csrr  s1, CSR_SSTATUS
>  	csrr  s2, CSR_SCAUSE
> +	csrr  s3, CSR_STVAL
>  	sd    s0, 248(sp)
>  	sd    s1, 256(sp)
>  	sd    s2, 264(sp)
> +	sd    s3, 272(sp)

We can't add stval without also changing how much stack we allocate at the
top of this macro, but since we need to keep sp 16-byte aligned in order
to call C code (route_exception()) we'll need to decrement -8*36, not
-8*35. Or, we could just switch struct ex_regs to be the kernel's struct
pt_regs which has 36 unsigned longs. The 'badaddr' member is for stval and
the additional long is orig_a0.

>  .endm
>  
>  .macro restore_context

I guess we should restore stval too.

Thanks,
drew

> 
> -- 
> 2.43.0
> 
> 
> -- 
> kvm-riscv mailing list
> kvm-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kvm-riscv

