Return-Path: <linux-kselftest+bounces-7174-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D350889857A
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 12:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86ACF1F24950
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 10:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A9480BF7;
	Thu,  4 Apr 2024 10:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ls25L0vf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC3680623
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Apr 2024 10:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712228201; cv=none; b=q0xDVErSzOy5Lmrl9vgiWISj44Wx7Nn4Favj0sHbmEiROvuzaXEODKx9dKZRbAhmEVMs974ZhYZEE84XwYGOCtrMYzKuCrA0hgZcYkPacwFyn5mB50oWrP9c73o1JS3rdIZIIYUgjioGdKufuNsKmpL3bsj+q5HdZuga/iDO1QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712228201; c=relaxed/simple;
	bh=ILJL7HVZXiFmQJJigk5doa9mj2osaYbOmdnt4D25RYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5clm5lf7hLQN40cbpKngl5qUxS2l7aTGvfDDjjAvYWcPZcVYGgNoPvbspC2+WmksHLeTJh8RK81Viy6ypvfGZeT3otL6Xv+DuFghuXW9ApQHbBEwhh2wjuX5vrJT1eqkJ339QaOWFjnQSP0tWTaj7B8Mx9mwLiWOP+cFoY9/sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ls25L0vf; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3416df43cabso560466f8f.3
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Apr 2024 03:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712228198; x=1712832998; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EFHFiM3SNW59iwbZR58YbB15YVKnaSxrhFOdislttik=;
        b=ls25L0vf8AIRxamXmlvbryDGvwgL6FELj8Kc/p9WXITVooxCUcq3h6CSkdjN13lBXI
         RsEHJkOqC7ueTL37LjjW7vf6VuIgcPZbxodGleL8KM83g/OVLGkTmrM+7wWidbF65W1X
         aOd/rQwYOXsTkjwn0k7fB1l5iidi3SpHGwTjuBmuMpXexC3MJEzgCtxJtJIzlHUqQA8X
         hfGDEQKJDSlAY1rl6X0Wlx9FNEuYvCnHB9H3CtgZ6Yb4Ze79ZWynrhpV8ZB2s0epx3Fb
         0OLauckwBZZQ23IGiCUtzY6mN2mZ6QyeYtqEYs0c5EvFkCMb1cep6+q6Ofu3gpTCpnFd
         Vw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712228198; x=1712832998;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EFHFiM3SNW59iwbZR58YbB15YVKnaSxrhFOdislttik=;
        b=afXyvrpCJatCAZou/gWhpa9oo9UXyXfhoUeqnrnafbJDbG8b6RqtnK5Gaab5Aw2i66
         diSxIj6Z2xm4oumXqbmmOMIxJqpPavHQnJFvEQRswcO5f8rse36VokwBdhTFqMJlFohA
         844UIWMIHuBZve0wBQB9ZGkgF6nzWVQ6lyda5EYMth8wDDc8fkcFTvKBj7pcVMP5KrhB
         YOeMos207jCbCLMwvuURY4RgSaM5k6BdK87SmyZPxhR6oewekgIoxobxyvz5wIQufd+s
         i1WpkP1qi6UvW1veK5H1S7sq4+PyZSlKeW1bs5hzXK9+odkn3NEWE3mtBN9bsdsY7404
         pq5A==
X-Forwarded-Encrypted: i=1; AJvYcCWMrG3gbmXn5TiKSVl1M/ETJrQNkj3s+LxysVIyh3YbzLp1tuDPbNer0jnyy6i0NZLXx3ss9q6dK6dxKhNmgKK+N+5xw96Ix/1dnsp5DB+6
X-Gm-Message-State: AOJu0YzyXvaQxDkexgqfNQILVTPja8qfIVaaBdoE5AnZ/4RhIFVUuYtd
	q5mQJ+skS+UgQ29WXUo6DqEJsUXh7rrSyEQ2GS+sMERiIevFOXhy/id9d/PCrL4=
X-Google-Smtp-Source: AGHT+IENSyz17ALt9X+5ZUYzaEpWJFzo0+v4zqkPSZygVwnsdSsHijcp2D+46t60iJ6/39PaQMtB1w==
X-Received: by 2002:a05:6000:1805:b0:343:7158:aace with SMTP id m5-20020a056000180500b003437158aacemr1379890wrh.17.1712228198219;
        Thu, 04 Apr 2024 03:56:38 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id f10-20020a0560001b0a00b00341dbb4a3a7sm19705617wrz.86.2024.04.04.03.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 03:56:37 -0700 (PDT)
Date: Thu, 4 Apr 2024 12:56:36 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, 
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Anup Patel <anup@brainfault.org>, Ajay Kaher <akaher@vmware.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Alexey Makhalov <amakhalov@vmware.com>, 
	Juergen Gross <jgross@suse.com>, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Will Deacon <will@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v5 01/22] RISC-V: Fix the typo in Scountovf CSR name
Message-ID: <20240404-9c750d13d89168feb5ff34de@orel>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
 <20240403080452.1007601-2-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240403080452.1007601-2-atishp@rivosinc.com>

On Wed, Apr 03, 2024 at 01:04:30AM -0700, Atish Patra wrote:
> The counter overflow CSR name is "scountovf" not "sscountovf".
> 
> Fix the csr name.
> 
> Fixes: 4905ec2fb7e6 ("RISC-V: Add sscofpmf extension support")
> Reviewed-by: Clément Léger <cleger@rivosinc.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/include/asm/csr.h | 2 +-
>  drivers/perf/riscv_pmu_sbi.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index 2468c55933cd..9d1b07932794 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -281,7 +281,7 @@
>  #define CSR_HPMCOUNTER30H	0xc9e
>  #define CSR_HPMCOUNTER31H	0xc9f
>  
> -#define CSR_SSCOUNTOVF		0xda0
> +#define CSR_SCOUNTOVF		0xda0
>  
>  #define CSR_SSTATUS		0x100
>  #define CSR_SIE			0x104
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 8cbe6e5f9c39..3e44d2fb8bf8 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -27,7 +27,7 @@
>  
>  #define ALT_SBI_PMU_OVERFLOW(__ovl)					\
>  asm volatile(ALTERNATIVE_2(						\
> -	"csrr %0, " __stringify(CSR_SSCOUNTOVF),			\
> +	"csrr %0, " __stringify(CSR_SCOUNTOVF),				\
>  	"csrr %0, " __stringify(THEAD_C9XX_CSR_SCOUNTEROF),		\
>  		THEAD_VENDOR_ID, ERRATA_THEAD_PMU,			\
>  		CONFIG_ERRATA_THEAD_PMU,				\
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

