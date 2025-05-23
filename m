Return-Path: <linux-kselftest+bounces-33669-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBCBAC29CD
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 20:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8271A1BA71B6
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 18:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F1729B200;
	Fri, 23 May 2025 18:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="rhEIa+hf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A0E296D0A
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 18:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748025049; cv=none; b=l3ap3AvRoZuJcnL44CkY+UJJtVlY1Az1Z3c9kBw5Hz9J18eKkdIXxjDl4ZJxw6Pxq1mal2oSHYYDInm4Ni1ejNtzb5w+lOOoxB5NtMW91ynij26+TykgILh1J2segERKzsLFlXiBmuPj9Xby/ppmwQg15/ZIZjZSDQsWtWXKFYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748025049; c=relaxed/simple;
	bh=JbUIjDHozqFZ2+ZIIgiUMiStVmYqgccKErpZffZ0FfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upEdq5CH78xKJMjoIsFmqGr5Q1GqwWCid20CXWhmUyu971BYhNhw464utLpWK/gUuHngzHM6i9qwSqWnN7p+Q2YI/K6bKpA4zFJI6v3OUOwK97z7U7vNrsBS3JBIQmb1oI7SXhO595CMgr58p19R2TqecOFLhe7jr1qukWG+QLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=rhEIa+hf; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b170c99aa49so93658a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 11:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1748025047; x=1748629847; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gWbUHPNgvAgT5G9XCmvjzlBHTlpN3kX1yERm+5eFQko=;
        b=rhEIa+hf27Y0eogw4f14fmL/RUgsPCjErP4boL5tqlV8qiJU5oNRGebUrW3BfBg/pl
         HcXzZRCbqoSNCxHmt5M/FEFoY1vQIAA6gMLKstDImwuioj4yJOyHcPMujIPE8CuC3Rk4
         lkWcWTRYa1V5brIK/1fGVlHa7Bhyqf5ZHS4762XOzAg9nL1gAkAbunOSfhjyz2FMTimR
         9WHgPUMo+OOTOGAxDz4nXBQflbBr40xR1HDB2OB6DAkp0RfSjT/F3wE8KXMMvXV/43wD
         5f0TZVNHIaevd7EJhxS7SD3x+qXkh4caexYLB3t/x5pf92rZqDsiWfotAhwq/uEtN45Q
         8IOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748025047; x=1748629847;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gWbUHPNgvAgT5G9XCmvjzlBHTlpN3kX1yERm+5eFQko=;
        b=CFOLMpYF8V3XQxje+P+0r6NT2CGpBIHEUnmzXrh578hwix+ZFq0gOj4mEo7QdQLcT5
         0gFvd70dy83s6H9XLgqNlt0sJoMvI4F0GJ+R7Gils2roCZC99SJq3KmKTO3DaibiCyg2
         po4qI8tOyOzDb4GJBGcuPdAQGZOmCdgDrV0WdWsYHHCImHQt/HxIzPQZ0Pp2iCY8gIr9
         pA565AS2Rz8FC3HcPMfI1BbyRZktW2OnGBq7XMTEBf6rGkNdemfB6LMfapjeC36RPiLv
         igEJj1V346f14Q5+X+nFuYSJl9YPbZZFSEgaR2j+piwcp39t6xdq+TGp9Zl/ihe6NKTn
         aL2g==
X-Forwarded-Encrypted: i=1; AJvYcCWAInMpjKKijS2JyweY4yzeCMV6RcEQP5fVoYAL9HLyWo154qyWDSd1LzVqQ1aIx/IBj5V/S9AxeKF7mpwZ5Rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO/D7ifTxBFYvdAImJsGRVJIpglzg+U78WgMxwMpwxF0gErWQU
	ahQy9bCddGUnkMKtjsh/UJJNfDprAMROJE+Tqqfyag9eKIX/6av+FFHJjPHURfJxTXM=
X-Gm-Gg: ASbGnctKOt5VZmRpGNunIggclDL51zpAzWbvfXYJ/UT1ADjs6CQTDREmHILmw71av7m
	3Mwwx/Hba6fw7pNAOMJVxYjs2+c/BX2vWPijrKRO2nPSbeeCwJenMnMhBB3H3p5q4xhK8LpfbyS
	5N1Mq3wSiIuHlACqnzvK+JJX/AyFRZRCJuA0Is1SQOQ9ysfEFIyi3x2gEzopZ9ZEpoABAXk1OiX
	mKiCBueYRP7SA5zMaLh6UKPyMtp2OpAlZn7IJNra9pFnROgf17t5aMJESQdEWqrzRsMZYpBALVl
	tDDA9uFSsflmxj+oP7FfOl2rpB8RDFQz4t7rVblwJvFEGEY=
X-Google-Smtp-Source: AGHT+IF6EgWK2eUC5Xu5iRop7pXN3/Fhxf1IfDgAGTEelKq535OUbR+gaTA3ptsvLBrT9R7jy18zfQ==
X-Received: by 2002:a17:90b:17c1:b0:310:c46c:ee6b with SMTP id 98e67ed59e1d1-31111a4c866mr121461a91.33.1748025046448;
        Fri, 23 May 2025 11:30:46 -0700 (PDT)
Received: from ghost ([2601:647:6700:64d0:bb2c:c7d9:9014:13ab])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-310f7eb53a9sm1014559a91.12.2025.05.23.11.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 11:30:45 -0700 (PDT)
Date: Fri, 23 May 2025 11:30:42 -0700
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
Subject: Re: [PATCH v8 09/14] riscv: misaligned: move emulated access
 uniformity check in a function
Message-ID: <aDC-0qe5STR7ow4m@ghost>
References: <20250523101932.1594077-1-cleger@rivosinc.com>
 <20250523101932.1594077-10-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250523101932.1594077-10-cleger@rivosinc.com>

On Fri, May 23, 2025 at 12:19:26PM +0200, Clément Léger wrote:
> Split the code that check for the uniformity of misaligned accesses
> performance on all cpus from check_unaligned_access_emulated_all_cpus()
> to its own function which will be used for delegation check. No
> functional changes intended.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  arch/riscv/kernel/traps_misaligned.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
> index f1b2af515592..7ecaa8103fe7 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -645,6 +645,18 @@ bool __init check_vector_unaligned_access_emulated_all_cpus(void)
>  }
>  #endif
>  
> +static bool all_cpus_unaligned_scalar_access_emulated(void)
> +{
> +	int cpu;
> +
> +	for_each_online_cpu(cpu)
> +		if (per_cpu(misaligned_access_speed, cpu) !=
> +		    RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED)
> +			return false;
> +
> +	return true;
> +}

This ends up wasting time when !CONFIG_RISCV_SCALAR_MISALIGNED since it
will always return false in that case. Maybe there is a way to simplify
the ifdefs and still have performant code, but I don't think this is a
big enough problem to prevent this patch from merging.

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Charlie Jenkins <charlie@rivosinc.com>

> +
>  #ifdef CONFIG_RISCV_SCALAR_MISALIGNED
>  
>  static bool unaligned_ctl __read_mostly;
> @@ -683,8 +695,6 @@ static int cpu_online_check_unaligned_access_emulated(unsigned int cpu)
>  
>  bool __init check_unaligned_access_emulated_all_cpus(void)
>  {
> -	int cpu;
> -
>  	/*
>  	 * We can only support PR_UNALIGN controls if all CPUs have misaligned
>  	 * accesses emulated since tasks requesting such control can run on any
> @@ -692,10 +702,8 @@ bool __init check_unaligned_access_emulated_all_cpus(void)
>  	 */
>  	on_each_cpu(check_unaligned_access_emulated, NULL, 1);
>  
> -	for_each_online_cpu(cpu)
> -		if (per_cpu(misaligned_access_speed, cpu)
> -		    != RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED)
> -			return false;
> +	if (!all_cpus_unaligned_scalar_access_emulated())
> +		return false;
>  
>  	unaligned_ctl = true;
>  	return true;
> -- 
> 2.49.0
> 

