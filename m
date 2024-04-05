Return-Path: <linux-kselftest+bounces-7278-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A30899CB9
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 14:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC7931C20C65
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 12:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2313A16D30E;
	Fri,  5 Apr 2024 12:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ThBkYjQl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD1016C854
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Apr 2024 12:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712319475; cv=none; b=mM+1Plp5rL45M64LabD7XVl7VAliwcHoMPSgsZeb5bC71YnPMqFlr/ITjSIxo1ozPQgk31qFLOWtFoHzTOPoA/TS50YyUkDqSGwRUdhfiYZqQD6Zbv4qJu88V2tQ/MPwqzEd1CfdLj8OlXZ2eZ0JstLOsoYqRYwRTviqFZO2yg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712319475; c=relaxed/simple;
	bh=ZaMBHOKq748J8AuTwS4EK3v5U+cz98pQBcMrLhGPsgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBM8NSvf+DpZ3jKVuER8UivC80WgEs2kgg9mzG8YuT4sENRBOL9Vh++pDVSbMFHrxb9xbdfnx+X6oWUjC4dDiGKSVQJAXQ5VvCirfs9GCeIWLI9ZGyHu+BmrA3NLH7cN6z5V+l44qx0ARvToLtRZ3FSiUYJ64oSHyRYYBbSMGQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ThBkYjQl; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4162dc4a626so4310565e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Apr 2024 05:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712319470; x=1712924270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0g33fTsVSlizqg1S+bo16IuI7wIXRqKOdHvOtcRNGdQ=;
        b=ThBkYjQl6uV/iBvNVjAaem3u0Bgf/+NRfeJEAMf11QyW1dxqUnsLF3pAskIf8i/5Hq
         DZR7BcLaEX0qeCA/rd81A6QGcTf8KuG9NeR0l070fe9j4Hjs3t8tTxOM+WqZwZHHSRh1
         20jXHLff1tf0cLG5t/2yN/KlxVFH0f3vfefKY/yleZTsxx68EhLiNHFYke2ZfNLjrzu4
         /g7zPuOf6mxxCxs1SpkpuLKqBOcCEKCpb2cLlncGEVPET8Z3FqON/TlsDO2hblCFxJ6w
         uxkFEN25Ml1HgKAcb5SUc594Fz2G68SJHr2FvEvRiJv5vGsQGuCxSBrDaCyUsz7WS13U
         YrmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712319470; x=1712924270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0g33fTsVSlizqg1S+bo16IuI7wIXRqKOdHvOtcRNGdQ=;
        b=OVSJP3AnxqFOFZYWDdgo8NyeVlhs8Rp7nbCUKY7Xq2DverENvTXfCkD3WIW2D2BHYu
         JEnf95rLVNtvaMSy4AL/TEJ3XhNNmupliNXid2Ux1fVi7YKlET86BYV4u+kjbi3Dyr/R
         8lB4EMUNl1NiI8XLUOJr6WYqqU7s3UDTHCkyqvNXPG/auzpgcRS4DQdVgbI0txxPuH93
         sZ+LkVXnBY7AMGIWrRViTP0xQ/puJ6S0cfuBgDwjge/fMziICHhW75Ttc9LvjTJhu3yD
         XC6HdEP33vwORRvX4X+dvlzI7+kIHmDg7tb+qZS6Oc/DRqW73lYBVdUbQIhAWjM1W44I
         CBaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVskukdGBbNXhReMvu82vk0JNfV4LrmWKsqtZmZXjnW94g2rYyWCxsl6PFrhTe5uBWyW96ot7a7Ce7U1QJSael4AIPfcgs4bwbJtgwJh8/G
X-Gm-Message-State: AOJu0Ywvxlez8imNVSE/Wfv8oVVHz5N40tiP9j+t1YP/cdi8oDdMPdPa
	VpqGY0w8AXtGfeKodBx+u9paCTmQLOSmAEOmEtvRDC/uor4DGM1Ixf5j7e3/PZg=
X-Google-Smtp-Source: AGHT+IHSUvbZnvo4yH+jaq8czfWTlAV7G9MX9xSOk1rTV7ws0g9gKf124xz7RpWYcZhefNvu3BhLlw==
X-Received: by 2002:a05:600c:4746:b0:415:431d:7747 with SMTP id w6-20020a05600c474600b00415431d7747mr2014418wmo.7.1712319470607;
        Fri, 05 Apr 2024 05:17:50 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id j10-20020a05600c488a00b004161ea7ed6dsm6093903wmp.38.2024.04.05.05.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 05:17:50 -0700 (PDT)
Date: Fri, 5 Apr 2024 14:17:49 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Ajay Kaher <akaher@vmware.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Alexey Makhalov <amakhalov@vmware.com>, 
	Anup Patel <anup@brainfault.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Juergen Gross <jgross@suse.com>, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Will Deacon <will@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v5 17/22] KVM: riscv: selftests: Add helper functions for
 extension checks
Message-ID: <20240405-dae6363b92b742554e85cf4c@orel>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
 <20240403080452.1007601-18-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403080452.1007601-18-atishp@rivosinc.com>

On Wed, Apr 03, 2024 at 01:04:46AM -0700, Atish Patra wrote:
> __vcpu_has_ext can check both SBI and ISA extensions when the first
> argument is properly converted to SBI/ISA extension IDs. Introduce
> two helper functions to make life easier for developers so they
> don't have to worry about the conversions.
> 
> Replace the current usages as well with new helpers.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  tools/testing/selftests/kvm/include/riscv/processor.h | 10 ++++++++++
>  tools/testing/selftests/kvm/riscv/arch_timer.c        |  2 +-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
> index 3b9cb39327ff..5f389166338c 100644
> --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> @@ -50,6 +50,16 @@ static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t subtype,
>  
>  bool __vcpu_has_ext(struct kvm_vcpu *vcpu, uint64_t ext);
>  
> +static inline bool __vcpu_has_isa_ext(struct kvm_vcpu *vcpu, uint64_t isa_ext)
> +{
> +	return __vcpu_has_ext(vcpu, RISCV_ISA_EXT_REG(isa_ext));
> +}
> +
> +static inline bool __vcpu_has_sbi_ext(struct kvm_vcpu *vcpu, uint64_t sbi_ext)
> +{
> +	return __vcpu_has_ext(vcpu, RISCV_SBI_EXT_REG(sbi_ext));
> +}
> +
>  struct ex_regs {
>  	unsigned long ra;
>  	unsigned long sp;
> diff --git a/tools/testing/selftests/kvm/riscv/arch_timer.c b/tools/testing/selftests/kvm/riscv/arch_timer.c
> index e22848f747c0..6a3e97ead824 100644
> --- a/tools/testing/selftests/kvm/riscv/arch_timer.c
> +++ b/tools/testing/selftests/kvm/riscv/arch_timer.c
> @@ -85,7 +85,7 @@ struct kvm_vm *test_vm_create(void)
>  	int nr_vcpus = test_args.nr_vcpus;
>  
>  	vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
> -	__TEST_REQUIRE(__vcpu_has_ext(vcpus[0], RISCV_ISA_EXT_REG(KVM_RISCV_ISA_EXT_SSTC)),
> +	__TEST_REQUIRE(__vcpu_has_isa_ext(vcpus[0], KVM_RISCV_ISA_EXT_SSTC),
>  				   "SSTC not available, skipping test\n");
>  
>  	vm_init_vector_tables(vm);
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

