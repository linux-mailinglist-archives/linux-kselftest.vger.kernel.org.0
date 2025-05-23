Return-Path: <linux-kselftest+bounces-33672-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1505AC29DB
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 20:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE81B1C0711E
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 18:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598A029AAE9;
	Fri, 23 May 2025 18:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="wyGRVvgO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13F8299A80
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 18:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748025547; cv=none; b=gxtS5TCWCPu5k6dme+IokudOGUfRDTIPJJCIMbz+i73gOfm85R3/Dld40TsoFCq6ND2OXcbfhxMEOQmOGIlAhX9E3Wm8UgR5y+W5jTaPclMkIDcsKpCECO0rPEUj+vA9kAsdleFd6uq1CWg9Na/wY23HwVcwOmCUCeixXiN/R9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748025547; c=relaxed/simple;
	bh=sm7CqC4WkQU8Rs7RoFNINgIkwM4zl0GJTRDwvhiASto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIM6UCBehGG2km66WqtDsl3H8jtJsrXR00+Zpze+gxJuyurnPXrKUl+425X9IiZIhnFq+SGbc/niSgkStuxgrizgwA1qAjVb8Aii3zZzqnW5lGl78lEjJrrvlAJQ+eIimGGTUWiSDBYFAkx9lMnMKGfPnRal5ntFOgtCfjXtilQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=wyGRVvgO; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b26f5f47ba1so109647a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 11:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1748025545; x=1748630345; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Brp4+tqBANTAovFCP7pOokKjsZ8jKRtxHJAFYCZnyiw=;
        b=wyGRVvgOlImg/zqqQf0ymijykUY1lSQijEsrkZ1TH5I+UUvFWjlMFStdUg0l51pfae
         bs9CyS5TLewmUF/FqSTDb3yVtDjXW5zE6Hxhs7zePnjOT1XBzmFLgSUkDeT9m8tQ0ZdG
         T0o1qRoUMyVDqhY1MquqC36G+eAqJaTP2w4Cs8UxJyWmdd3nFZRfmDZu7p7jvCSqj42W
         i4LoD8rBSrvb/DEuGVvTpBHiYOP3FIEQB/7aXrPcDHjRyH/MEsKcVAqdAKvk6G09XDiu
         u1HWeZXpKukOfJZXdv3BGOkiXpTowegB7Yql28IAsx/kgFpb+Sk1+aUGFq1a9PaXDUu8
         YG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748025545; x=1748630345;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Brp4+tqBANTAovFCP7pOokKjsZ8jKRtxHJAFYCZnyiw=;
        b=QXDIGW/bM3EIJAaX+8ltQvaJZpPydm6D0sYJq8FQ5IQ9Cs4KP0Vqzb2yD3gXAZGkLa
         vvXtViAJ8vhSjw6p1NGRcpYLDeiQZVnDaHACzeD3dQbR50lGje+1HksZ5gUzeSLRXXD5
         FgTtbb2xj+yQ1CXxWqgHdFFy5ki50ePRCPpG1QhjD/hDciLR8S7FcfX3scZN3fvotPKt
         Jl6avaJSrrudWlHPW1+OjWUD8T22elbXeeZZ7x+OXgb6SmBEjkpvdlFYA/y12yHXhJxO
         vMbV3pH1ML4jCkWnyIvsEuVw14nniQ90fev8JQpF9CSDol6x9alIurbbtEXy+i07Mf3O
         6FPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXFHFotOnNI6JeZxfLwfYnJLhOIr4Oj3sXyXSL7llkxLY6TAvUguubQdy/XzmX2fR7Grn5lOBDR8O/Zhr+X7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAdPkTDyCZej6pptYXT1LUssa7IKQ16p45DTrszHgViymjNIN9
	miC/OaGqM9b1ZsD72+Pin/zko94EpJefjqNwghg74QBSl6qtWtx7G0947Zcb9s9MqOg=
X-Gm-Gg: ASbGnctJTkHVb9wS1LHs0V6FpYL1cT2kWpIxvBdjHWrZ0EaXvkgrz2Wy51tc2/Powf6
	N7wfa0gcOPiDbN3EBuMkGpPKcC9ncATGPiS7Wvx4o5/AU2ad25xpXqNNB/29fWegg+ZzaKbjNXU
	AqFtaG5g5IE5aED5ajqODUl1l6aP8DM9apTxHRPxkucN70j/AzqHpvQ5Wu5KR4VIaXfNGX/SnUc
	sbT2B+Yf8cfnMf7OLKilS1YWQWALc+1VbjQIih3vt7oUJEzomhbV6HC+1HxIponiPyv5/xKdz63
	9zKQasAsaVa2uvr+15f+5b3GXGLkYacIfeB4RlNNO0wRvv0=
X-Google-Smtp-Source: AGHT+IF/W7rgN2cGONT1rL6VsHTy6gKpmlK8jFDydK2LaE8qLgbyfqjrk3Jd1cMhblWh+YfsU/FBoQ==
X-Received: by 2002:a17:903:b8d:b0:224:93e:b5d7 with SMTP id d9443c01a7336-23414fb2593mr7004755ad.34.1748025544999;
        Fri, 23 May 2025 11:39:04 -0700 (PDT)
Received: from ghost ([2601:647:6700:64d0:bb2c:c7d9:9014:13ab])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ed2508sm127432885ad.221.2025.05.23.11.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 11:39:04 -0700 (PDT)
Date: Fri, 23 May 2025 11:39:02 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Deepak Gupta <debug@rivosinc.com>
Subject: Re: [PATCH v8 10/14] riscv: misaligned: add a function to check
 misalign trap delegability
Message-ID: <aDDAxugIa6XhLSSv@ghost>
References: <20250523101932.1594077-1-cleger@rivosinc.com>
 <20250523101932.1594077-11-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250523101932.1594077-11-cleger@rivosinc.com>

On Fri, May 23, 2025 at 12:19:27PM +0200, Clément Léger wrote:
> Checking for the delegability of the misaligned access trap is needed
> for the KVM FWFT extension implementation. Add a function to get the
> delegability of the misaligned trap exception.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Charlie Jenkins <charlie@rivosinc.com>

> ---
>  arch/riscv/include/asm/cpufeature.h  |  6 ++++++
>  arch/riscv/kernel/traps_misaligned.c | 17 +++++++++++++++--
>  2 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
> index 2bfa4ef383ed..fbd0e4306c93 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -81,6 +81,12 @@ static inline bool unaligned_ctl_available(void)
>  
>  #if defined(CONFIG_RISCV_MISALIGNED)
>  DECLARE_PER_CPU(long, misaligned_access_speed);
> +bool misaligned_traps_can_delegate(void);
> +#else
> +static inline bool misaligned_traps_can_delegate(void)
> +{
> +	return false;
> +}
>  #endif
>  
>  bool __init check_vector_unaligned_access_emulated_all_cpus(void);
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
> index 7ecaa8103fe7..93043924fe6c 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -724,10 +724,10 @@ static int cpu_online_check_unaligned_access_emulated(unsigned int cpu)
>  }
>  #endif
>  
> -#ifdef CONFIG_RISCV_SBI
> -
>  static bool misaligned_traps_delegated;
>  
> +#ifdef CONFIG_RISCV_SBI
> +
>  static int cpu_online_sbi_unaligned_setup(unsigned int cpu)
>  {
>  	if (sbi_fwft_set(SBI_FWFT_MISALIGNED_EXC_DELEG, 1, 0) &&
> @@ -763,6 +763,7 @@ static int cpu_online_sbi_unaligned_setup(unsigned int cpu __always_unused)
>  {
>  	return 0;
>  }
> +
>  #endif
>  
>  int cpu_online_unaligned_access_init(unsigned int cpu)
> @@ -775,3 +776,15 @@ int cpu_online_unaligned_access_init(unsigned int cpu)
>  
>  	return cpu_online_check_unaligned_access_emulated(cpu);
>  }
> +
> +bool misaligned_traps_can_delegate(void)
> +{
> +	/*
> +	 * Either we successfully requested misaligned traps delegation for all
> +	 * CPUs, or the SBI does not implement the FWFT extension but delegated
> +	 * the exception by default.
> +	 */
> +	return misaligned_traps_delegated ||
> +	       all_cpus_unaligned_scalar_access_emulated();
> +}
> +EXPORT_SYMBOL_GPL(misaligned_traps_can_delegate);
> -- 
> 2.49.0
> 

