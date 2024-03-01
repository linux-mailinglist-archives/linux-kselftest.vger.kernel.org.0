Return-Path: <linux-kselftest+bounces-5696-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B1386DD08
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 09:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1ECC1F21957
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 08:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95D669DED;
	Fri,  1 Mar 2024 08:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="nGoccN7C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BB769DE5
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Mar 2024 08:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709281577; cv=none; b=metaG3YsIexMSPLBOO4i/IyMut4uqcviEvjqKKaVAOkpu6ZNHWf/oaAT51YRModcmiYdqKR45nZ8fiibP58pT8M4IftIbatf1wqO6CY5DG9fzOK0+UFPCjjCo5iLhmuDvAdLpqxGXzU0dneLqlYA15tcxaOGBstFxZRw//yeUsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709281577; c=relaxed/simple;
	bh=rGugC4CtKyBNC9wfpMo8MLd50utveTzcgNmmqGOwzrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LZ4zHM2CbMFN+jsSpbPS3h8LZfNKpy3o3SNCWm4PXsf6I+JZYkSDrQOTP8/9V2UHhE5z86EzSM2Vr4oaVH9VAzEbWzNHvum6WrQAV+4HJQjZ4S8fNYl7dU/9D77d/srn3GL+kQT5n9ZRCg6nK9lC6yuQVIPRtiwbtKx8t+vhYkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=nGoccN7C; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5a0c7c87dc6so19627eaf.1
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Mar 2024 00:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709281574; x=1709886374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f0O2fV0WbAx46xM1Y6qPjUuO/OeNoTHA0KPqbfE4bGA=;
        b=nGoccN7CErqYXvwaklzhOj1brNmcnCXh6XJTx1evZ0OXdE0dfsLfrfIWF4ePNNeWrQ
         uZGTmeMbk/Ki+Wg6lixyv5BEvX5fztrVHXFWbuixWVd7cSR7ydQXt42AlUFi0hiEt0Le
         7D234beEwEK28uNPVwXrw0naedz9oGOOgj6zRdFSTJMMDJX4dtWVZmEbdJcqNiA2IZMS
         Z77JDQaCtMXe+b+RoCJg6Kp0JevfWqqzjBHudfQ9OZySX9q8XAt9GFbSMbwrcL6ijUkE
         uOnkBTr5JJgcxtoBiASdYb2494Vqox2awB3QQlRZVM0L3D7tQj0GVAb+W7mff84fFqyu
         G/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709281574; x=1709886374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f0O2fV0WbAx46xM1Y6qPjUuO/OeNoTHA0KPqbfE4bGA=;
        b=TyeOK8UJdy6gRcSv2nwIR+riUqo2DKj/R4ks/6FqJPNkLCF5U7MtQuybZP0MfCyUGS
         tJSUSX0azsa7pFuD7DaCi7zVrEITP9QoLzKHMZfzFgmwyhdDOsxF/kYpFv+S9uOUu1wB
         B0V58XpbeIEScquQlkNJVbtSmAkmaQtoUd94I+biQMf5kLGqkRBJeBL/VpPXAkp/kFdF
         s4fONt3Xl8YaIHYvTme799GVOnuN5hMz6A4V8AKfqRhKMdEd7C2iLZRkGXPXGSY2afa2
         lTI6lSQEDdIu+6kZUFw+6AG11fG0r5cmom+ZvsLCgcHEKXgLyNQ2pwJygNAroaw3qeWd
         I2/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQmf8KDVEwYAM86j3pAPWzIVF6YAchhjgPNXsXD1GwJCJXx9fm7HipW//nlEmyZGpNBjQwvinlKgKOkbRN8u1269Q4uJs5krgtFC0dz4cJ
X-Gm-Message-State: AOJu0Yx+WC6FbxF9aWXziFMUC0H/IzEj9DJ5wBKCpLCrSFBusrW1Al8O
	xdSrCdkuAbI2EKQ56HH9SvSIq2qaUT6g548rqBk2o8iEpWMtB+yjx2t+3M+29co=
X-Google-Smtp-Source: AGHT+IEO2VE95MaGXRr6VmSeAK9U9lNiLgxplCLbWJe649iHowWVgQB/IkCDcUSOog4HOG7PQm9Yjw==
X-Received: by 2002:a05:6820:41:b0:5a0:4216:c5f0 with SMTP id v1-20020a056820004100b005a04216c5f0mr887748oob.0.1709281573977;
        Fri, 01 Mar 2024 00:26:13 -0800 (PST)
Received: from ?IPV6:2a01:e0a:999:a3a0:1070:febd:b4af:e79a? ([2a01:e0a:999:a3a0:1070:febd:b4af:e79a])
        by smtp.gmail.com with ESMTPSA id r7-20020aa78b87000000b006e13e202914sm2449292pfd.56.2024.03.01.00.26.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 00:26:13 -0800 (PST)
Message-ID: <9c466c89-3788-4473-a657-1f117cd5e5ab@rivosinc.com>
Date: Fri, 1 Mar 2024 09:25:56 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/15] RISC-V: Fix the typo in Scountovf CSR name
To: Atish Patra <atishp@rivosinc.com>, linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, linux-kselftest@vger.kernel.org,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alexghiti@rivosinc.com>,
 kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Guo Ren <guoren@kernel.org>,
 kvm-riscv@lists.infradead.org, Atish Patra <atishp@atishpatra.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 Shuah Khan <shuah@kernel.org>, Andrew Jones <ajones@ventanamicro.com>
References: <20240229010130.1380926-1-atishp@rivosinc.com>
 <20240229010130.1380926-2-atishp@rivosinc.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20240229010130.1380926-2-atishp@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 29/02/2024 02:01, Atish Patra wrote:
> The counter overflow CSR name is "scountovf" not "sscountovf".
> 
> Fix the csr name.
> 
> Fixes: 4905ec2fb7e6 ("RISC-V: Add sscofpmf extension support")
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/include/asm/csr.h         | 2 +-
>  arch/riscv/include/asm/errata_list.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index 510014051f5d..603e5a3c61f9 100644
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
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> index ea33288f8a25..cd49eb025ddf 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -114,7 +114,7 @@ asm volatile(ALTERNATIVE(						\
>  
>  #define ALT_SBI_PMU_OVERFLOW(__ovl)					\
>  asm volatile(ALTERNATIVE(						\
> -	"csrr %0, " __stringify(CSR_SSCOUNTOVF),			\
> +	"csrr %0, " __stringify(CSR_SCOUNTOVF),				\
>  	"csrr %0, " __stringify(THEAD_C9XX_CSR_SCOUNTEROF),		\
>  		THEAD_VENDOR_ID, ERRATA_THEAD_PMU,			\
>  		CONFIG_ERRATA_THEAD_PMU)				\


Reviewed-by: Clément Léger <cleger@rivosinc.com>

Thanks,

Clément

