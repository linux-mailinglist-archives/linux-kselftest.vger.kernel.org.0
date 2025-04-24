Return-Path: <linux-kselftest+bounces-31533-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0DEA9AB43
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 13:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D7174A26DA
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 11:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484FB202C2D;
	Thu, 24 Apr 2025 11:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Efqg4ej0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B55F1E1DE5
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 11:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745492455; cv=none; b=ZpR1tZpcxbb+0Hz9p8JbOPeXzeAGs8uCAh0sliWEJyQFbsKq/pB42JR222bSs3R80t0dBSuJE4WX/XU2Z8FqXqlbM+kDuaeElEWPPPPMY4MS5v5FgrQWCgbQpxxLbcjMqB4H9XIv6Gag3RNLAZGB4K3Oqh1AuNcgEPPhAMig/0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745492455; c=relaxed/simple;
	bh=ilVhurOAgxRINQp4J4plZnQ/Sve+oq9bjuZtm3BKBho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvC/6QPzI8D2uGEGLKZBk+6PWGQIXS7t4jaMO8B0CBDSMbcMmeDYlzRkr0J0wAjQnqZs3Po+TA0prftS7EcB4CHWx/RF+J2fXddDdMlA6Ir7dJXf40ObgAi2tJjP0ypZ/tPZ+qe5Ymll5AmEoU/iwKQ5gSzRfqTBsr3Il5OfZXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Efqg4ej0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso8438555e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 04:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1745492451; x=1746097251; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zHHJnHHyOrnNtHHA6vr6DrZ0IO7tPD+NYSLx8YKZu70=;
        b=Efqg4ej0lfczL7FUZMe+hb4klNfVw/eDNsSA+9s0AdXbElMqmfSag5n8/TalQ4w67U
         rYN0sFThg8wrStkkiUfwGCTGnU6FCTOK27qaeiA5YrPR1prbXomZx3wkyWFhhULs6p+s
         e+rDC7xWWv5L8pP0W2VgLErtPHmcCWM89Av8+km5aujoYhqgM5pDHkZcHMlV1CRGzMct
         o824a2B4a24tvH/2Z6ozeTJbefOZ4O6ACD+9hCcd20FUkvOnS5gIhuCu6ob2/Npc8G3u
         5rjNFcXH3GTFfIMZw3F38cnncuzVp0g+eM3lKdBqPJhljMeoFyhvG1snvHKaWPaYAmaX
         nFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745492451; x=1746097251;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zHHJnHHyOrnNtHHA6vr6DrZ0IO7tPD+NYSLx8YKZu70=;
        b=jUAg8wcj1D7qmAsIW1d4wcWI6SWf6chRL9gbqCaUVUVspxVosPSD0qi81QUWe5kssl
         UATpM+nMAed0Qad6n0iZstCSEcSK0nuO+BPgaIfvljsdZQHzWF2QXbi0ljaL5WvMNHr/
         KeUDH0InEisqlAYe3GazHBemvJS9IqMt+ntmntWkOUZWsY16Ky34dHTiPGzWxGfVFP/S
         nj28NVWOv3GRs/9rLBVoSj7xdqLkvcIgbIbFAjkBI8ZXqSp6aHKYzpBlkDD1WZfrlD5v
         HaOoWYDdm7IXzm2wLJc9WBxvP8vwZDdSnf8DWq4G1S/4ZfqvS2c7sX6HJ6C2aDpGW4A8
         vxcA==
X-Forwarded-Encrypted: i=1; AJvYcCVUPC7B8sOJRrwjc4+eRwT0gXDVub9pLp2cWS/p/ZwYNxRveCQq2QOp6DxuQAJ8qQAlIclVtQFs50krSPpddyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFAUyD+EtsA6/XpYw4fKBvulgaUcihCFzHt7oQ1WPFIi1cRwlR
	2miXwSw3J3Jhqnpz4vYi9VHdPRVAV2oPBcvdDfA2IDnSnrrRSy69HbIzlXkoYLI=
X-Gm-Gg: ASbGnctsKlXfsrN1n5xxQmuUvdFeqN31ibITeHAPSaIwkEnAqZBwiifrrSV3WXWd/7D
	u0g0DRTmOL4JWRqlNqZKHrsTY7D9m9UODizpvIKh2nkyWtCAfm5HnjUIU9uE+S+jx3PaaaN+S4K
	0tyouq6u3vpFq6sXuj8OniXNvS+c4Z1hU6eEDm3+jGsV17SUFrAIqE43LE240jJY5sJH/ayAoRB
	02/p1Hw1lK2TCgtouDqlse+Ycn7YXTyVOmEAEAP9AQEXZ6CXp1GSP/lC8BM1eG14ba3t160gwk6
	AUc6aQYNhFUop7o44n0ErJB/PHcryApiyfBRV2E=
X-Google-Smtp-Source: AGHT+IGP6Ut82q/OqGuYzCaYu8ri2NvYSY5EYxmJ9hg0Kbk3eysivoE/mXbwZrGhC5aaW7QaraDYhg==
X-Received: by 2002:a05:600c:3b9a:b0:439:9424:1b70 with SMTP id 5b1f17b1804b1-4409bd8a761mr17964535e9.30.1745492451468;
        Thu, 24 Apr 2025 04:00:51 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::f716])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2d8479sm16884645e9.29.2025.04.24.04.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 04:00:51 -0700 (PDT)
Date: Thu, 24 Apr 2025 13:00:50 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v5 03/13] riscv: sbi: add FWFT extension interface
Message-ID: <20250424-c85c9d2f189fe4470038b519@orel>
References: <20250417122337.547969-1-cleger@rivosinc.com>
 <20250417122337.547969-4-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250417122337.547969-4-cleger@rivosinc.com>

On Thu, Apr 17, 2025 at 02:19:50PM +0200, Clément Léger wrote:
> This SBI extensions enables supervisor mode to control feature that are
> under M-mode control (For instance, Svadu menvcfg ADUE bit, Ssdbltrp
> DTE, etc). Add an interface to set local features for a specific cpu
> mask as well as for the online cpu mask.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  arch/riscv/include/asm/sbi.h | 17 +++++++++++
>  arch/riscv/kernel/sbi.c      | 57 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 74 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 7ec249fea880..c8eab315c80e 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -503,6 +503,23 @@ int sbi_remote_hfence_vvma_asid(const struct cpumask *cpu_mask,
>  				unsigned long asid);
>  long sbi_probe_extension(int ext);
>  
> +int sbi_fwft_set(u32 feature, unsigned long value, unsigned long flags);
> +int sbi_fwft_local_set_cpumask(const cpumask_t *mask, u32 feature,
> +			       unsigned long value, unsigned long flags);

I'm confused by the naming that includes 'local' and 'cpumask' together
and...

> +/**
> + * sbi_fwft_local_set() - Set a feature on all online cpus
> + * @feature: The feature to be set
> + * @value: The feature value to be set
> + * @flags: FWFT feature set flags
> + *
> + * Return: 0 on success, appropriate linux error code otherwise.
> + */
> +static inline int sbi_fwft_local_set(u32 feature, unsigned long value,
> +				     unsigned long flags)
> +{
> +	return sbi_fwft_local_set_cpumask(cpu_online_mask, feature, value, flags);

...that something named with just 'local' is applied to all online cpus.
I've always considered 'local' functions to only affect the calling cpu.

Thanks,
drew

