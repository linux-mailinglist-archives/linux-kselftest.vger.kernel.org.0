Return-Path: <linux-kselftest+bounces-28950-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E44A5F5C8
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 14:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E43A13AC704
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 13:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2BD2676F9;
	Thu, 13 Mar 2025 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Fya+B5uv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2C0267707
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 13:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741871977; cv=none; b=ilh+mJpHA/P+Crrzf45MGCO0F05rnxcQ3dJeRb8/qIfQlsvEaICUmgfKEBJctKZfHnixG01AnAXLymNG/3A+mJFl/Dp+tWiRnL87uQuFwJhhe6qixrD9hck1uh7/1nSPkidabYou/gzVlS3CwrLabr5d7iZ0NQjIfFsziIjdpGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741871977; c=relaxed/simple;
	bh=Gdz8UJhWShBn1LGKb52FUKgFJdhhJNGhVtNjQr+Ljhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQuRI4ys2/wXAKOYhMAou80cXr2q9cV3krZpHeFXiY1Vi+QpiEByUIfMSqsCiMOroEK3hp0aBO864YSyX3c+fadYwGJcsFxETAyolZAo7aRIaQRTGGx3I5lHab5hSC+62LvI64xYY9RYlOcDnVxDzp6TfcSR0y7HFgvJwVuzR8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Fya+B5uv; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac27cb35309so155393366b.2
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 06:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1741871974; x=1742476774; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SLwI9+XgDvx6y1QmCRm2s349AXzMPGhMLML8/FN0xLk=;
        b=Fya+B5uvMaBWg05/ZRaooO28oARMieTKejYuRJHRQIjyrXOuvQoFXtsyZGxHLoiqGL
         3dxTmbWsHoc/LO3ACZs+ovLFovc85/cZDAFlz4Dr+Np2mRFz+D/XMy6Yy9Fdx2qs84ny
         rp5uIw5CRIrGOkqHeFwdv8DUsSLZ0RAdaeJqNgnjynazmIg3FDYRa0vOpHiRwZFKJH5/
         G3CEBRjEzjPipxd+Xx25UTJa6oXICPZLQ+CcujMNWwKjyhV7QnxyM0+/J8XoKLvkDpQp
         C9w2NQYJDA9rpmIe5YofDyga9OrNItLRekWl+/h9p0E9oAN+c48I94bUQRMPo8p4ISfU
         YbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741871974; x=1742476774;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SLwI9+XgDvx6y1QmCRm2s349AXzMPGhMLML8/FN0xLk=;
        b=O7JOx2Vlm487xTlid8K/cuux2QDcrA6X5YidjzAAQ/5ATpBawcACDN72soWx5XLayJ
         Rrfipl+mVop5iGXle+HBpG4QndkBtfXyjPNVE0YW7cFAviTNCR3O4hnVc/iHWWUo87TW
         a1UirtMa/vY2qdNggQ6r9I5oEYb8TaTorocYe2PFE0yn+J7iJHsWeQSfkUUYjjzlYiU2
         SgYZWGDfBeYJMDkPviHDxKoc0e2iB0u7db2GF7pdd4sGFG76Z/Ft5yZvZ3BW8EQBqqle
         8TTApVj+JTp8oQyqX1G0OPd/X2QJJGlIqkhuDObK7Sng58iQ/QfBHHZGgwHiGpHuw0tC
         Zxdw==
X-Forwarded-Encrypted: i=1; AJvYcCXyUKx7uuYEqtRxZv5Otf3Q3pq/+g/hpo7iouZT3zNvDzORTpSX8wFhOUq+nqNh1sl2eskUDpJEn6jdIKaTDEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbyK8NSnhu5l/BxyqVEH5rF87Gmtpx2HhSg/XFLmBCxQcI76Wh
	e7B9bQIMwk4Y4ebOFGbmjXM0fpHFpxBGfUSvk4vhWftcXPMBf34OnaVxxz46ZHw=
X-Gm-Gg: ASbGncv32i8hfKLXXWp9QHPOuS1W/rgzxC/gTht5yzmU9wP0Xu8kKWxQC91Zte/IWjr
	eyy3qxFFNjGQBMSqmvNJM6ALEAwWaKTjAaW90EJ0/0p+hhcSLy+XXGn0z9veuPOk266rNaj2hhn
	b09QpqxS71s3xxeDL7VvcOzl7A7RTcbpKWNX7X4uMcbN3obDIfoRjdRXG5TlmPZwpYsBhpikRXC
	+MmFMfdAfIOn9SFZ1SqEMCHdT+8L+tp335cjxvyV4ADcz3kzDfi1Y6fAlujjGRxwFmWlF0S6Dzy
	JW2EVGfsY3IB5YaKk0CBeQfUj66ki1A5
X-Google-Smtp-Source: AGHT+IF3RjvN3caMGccSNmH1eaKCAyeC0UKLdIujqC0Ubvi5/eGttJVhWRGqhwIRTen+UtV+e2lwpQ==
X-Received: by 2002:a17:907:7da8:b0:ac1:dd6f:f26c with SMTP id a640c23a62f3a-ac2b9ede2f5mr1499361666b.46.1741871973986;
        Thu, 13 Mar 2025 06:19:33 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::59a5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147ead1dsm81138266b.58.2025.03.13.06.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 06:19:33 -0700 (PDT)
Date: Thu, 13 Mar 2025 14:19:32 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v3 08/17] riscv: misaligned: add a function to check
 misalign trap delegability
Message-ID: <20250313-4bea400c5770a5a5d3d70b38@orel>
References: <20250310151229.2365992-1-cleger@rivosinc.com>
 <20250310151229.2365992-9-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310151229.2365992-9-cleger@rivosinc.com>

On Mon, Mar 10, 2025 at 04:12:15PM +0100, Clément Léger wrote:
> Checking for the delegability of the misaligned access trap is needed
> for the KVM FWFT extension implementation. Add a function to get the
> delegability of the misaligned trap exception.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> ---
>  arch/riscv/include/asm/cpufeature.h  |  5 +++++
>  arch/riscv/kernel/traps_misaligned.c | 17 +++++++++++++++--
>  2 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
> index ad7d26788e6a..8b97cba99fc3 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -69,12 +69,17 @@ int cpu_online_unaligned_access_init(unsigned int cpu);
>  #if defined(CONFIG_RISCV_SCALAR_MISALIGNED)
>  void unaligned_emulation_finish(void);
>  bool unaligned_ctl_available(void);
> +bool misaligned_traps_can_delegate(void);
>  DECLARE_PER_CPU(long, misaligned_access_speed);
>  #else
>  static inline bool unaligned_ctl_available(void)
>  {
>  	return false;
>  }
> +static inline bool misaligned_traps_can_delegate(void)
> +{
> +	return false;
> +}
>  #endif
>  
>  bool check_vector_unaligned_access_emulated_all_cpus(void);
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
> index db31966a834e..a67a6e709a06 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -716,10 +716,10 @@ static int cpu_online_check_unaligned_access_emulated(unsigned int cpu)
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
> @@ -761,6 +761,7 @@ static int cpu_online_sbi_unaligned_setup(unsigned int cpu __always_unused)
>  {
>  	return 0;
>  }
> +
>  #endif
>  
>  int cpu_online_unaligned_access_init(unsigned int cpu)
> @@ -773,3 +774,15 @@ int cpu_online_unaligned_access_init(unsigned int cpu)
>  
>  	return cpu_online_check_unaligned_access_emulated(cpu);
>  }
> +
> +bool misaligned_traps_can_delegate(void)
> +{
> +	/*
> +	 * Either we successfully requested misaligned traps delegation for all
> +	 * CPUS or the SBI does not implemented FWFT extension but delegated the
> +	 * exception by default.
> +	 */
> +	return misaligned_traps_delegated ||
> +	       all_cpus_unaligned_scalar_access_emulated();
> +}
> +EXPORT_SYMBOL_GPL(misaligned_traps_can_delegate);
> \ No newline at end of file

Check your editor settings.

> -- 
> 2.47.2

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

