Return-Path: <linux-kselftest+bounces-29605-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B362A6CA05
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Mar 2025 13:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CD1A3A8CD8
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Mar 2025 12:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1831FAC4D;
	Sat, 22 Mar 2025 12:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="pfVWZLGf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADF31F3BBD
	for <linux-kselftest@vger.kernel.org>; Sat, 22 Mar 2025 12:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742645169; cv=none; b=bAEL75pdSrD/h6rUiIbhIWVg9xkLsoMNarHhUVs/HlmCA9TdyO1Bh0I3NqFkjJdr6qlAMFvBW+Qs3B1ou5etMzRjuVzJdPEgOxftxq1WPyq525LCkMOhNp6MU9REkNb1Wnrcgzfn1lyAp+WUWM6RCyBJLH6fxqvmVT0FNkScGFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742645169; c=relaxed/simple;
	bh=oOwIic0xoWcK/W7bScwvvNxG27FtWKsUDiBHcGLGMEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cd6WAdB4dqwuKHm/DGGevl+Y8E3NJxHcnGFtxrzH6b+quH33/d0PLNIdFpMKfdgY/gWfYZEcQpkZoMlHGlOYRrGMIcQeElBT1EQYLFwZXQ83g4rD47ADEGvlejPmVkxnWicFrgCe/Rp5CNucZ/7dsRmBchcUl/pG+jGV5eNhQ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=pfVWZLGf; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso20777145e9.2
        for <linux-kselftest@vger.kernel.org>; Sat, 22 Mar 2025 05:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1742645166; x=1743249966; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZKCRWgSlF1v0cutxAi8x3LCFESHSHWoNhfvIYKSJItY=;
        b=pfVWZLGfHoQsMmWHi54ghr7KbiyyJFpAMemHA4DI398Vhpz1z/JsE643sFQ1ehK9zl
         Clw4wgHobbHkiCQXGyiU7Eqj6nStsGZz5jalsceV3p31r5hpN89/3D39dBQCN672KKhY
         SlT2poaxnVeXaFVC5PpFbax3DQh5ipvKlna28PGbWmGvwKg60CnFyq4GuSViWAbNAaHE
         b6nQbieQAmhXUuyUeZL+6TAJtCS7BfvAmIsFfE8Xt8GwYRtvBdSwVUzyjIulhBEqH10m
         8CmvdvayXOc0Vo+uLQJ+81AL56LPVMRdXEh24EohL+YfeAwVv85vSlJfwMRS6/HhLA0B
         DoLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742645166; x=1743249966;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKCRWgSlF1v0cutxAi8x3LCFESHSHWoNhfvIYKSJItY=;
        b=GlIf0Fwk6tNv1iC/kdTpTid2AMagJpbUH7QlS9H/4j+J4bJamVVSk5fqKq31s4CZOh
         PMY1wH92xMZmE3YZ58gPzcBUVknOJU4iOlonbmL/dDhA3u5vpW9q4dWU6jfCPTMmRVM3
         V+ijVSiut8d98BIixl7CCtKbhiSzyGYxGqglcJ7qW2xM6aX58scGYUs4Lc70Bg7IsaMi
         dK66u0hz4HGYJ4vTNC8pmcfUK+UdDTeumjMBYcl40Sd/mmm7EOM7E/DK4fDA+dgcY0VE
         KhvWKqJVSsZxdC3t7H6pUih+pVUygpZqcTsBRj4sFa5HI2T4mgD0TQr0/eQStFdO3V13
         W89Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZhWQh+8UActoTbjYmOUCZhR8zUGyC6j1sttz71x64yJ9w2YlWjdwDWMzgOIbeVd1jusLlD6YxrHrBQ6vnHZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhrYUajWTVQI6HzH03qI/fuM3QoOkS++lB33pjRgXSsZjtSoCC
	TOr9VYYS9dPLrCso8aT01/0cpV1lFx12iQsXMZmHGrP50oPCxWkmC+URdmZpP6uXQ45rmMiWqg4
	s
X-Gm-Gg: ASbGncuLk0oOfA1k84yLVTzReU4acQnc55wvnAIYJ7YkJScA3GbpySpe9BWJX6YQtZc
	RQKedtOQqSIaBw44S0irJFKNL65TSeg3bxWYaG+o/T35KkHX0KYorRWMInILIYhz+1WqhoHDMkh
	27/MtV78/NlYGHDcGr5Kdv1VUnvGH4oL3rvY4wd9Dw4xnqnjH79uDWqRBfSuH71QGOvgewoR0OT
	XvZdzVeZ92XDTsTzwi87BBB3/yQ7IR7B3FEaqmt8Ld7B5jSeu1H+75EBiTjnmi72PZwW8AzOHTi
	hbsE05khSGMmwLKJi9KZsOsGx6eVXp03NBIhZPeMd7urEpRbG5DKnQBOHCFGGQinNi8bK2WT5A=
	=
X-Google-Smtp-Source: AGHT+IFTfC3V3Y+aXvtwsAGDzN2r/TELBK33hItKDRr/I6qX4Pf8OQOcC8wMhwn6dPn+tHwLQGn1PA==
X-Received: by 2002:a05:600c:470f:b0:43c:fe15:41e1 with SMTP id 5b1f17b1804b1-43d509e190fmr61771675e9.4.1742645165642;
        Sat, 22 Mar 2025 05:06:05 -0700 (PDT)
Received: from localhost (cst2-173-28.cust.vodafone.cz. [31.30.173.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9ef23esm4932401f8f.81.2025.03.22.05.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 05:06:05 -0700 (PDT)
Date: Sat, 22 Mar 2025 13:06:04 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v4 02/18] riscv: sbi: add new SBI error mappings
Message-ID: <20250322-cce038c88db88dd119a49846@orel>
References: <20250317170625.1142870-1-cleger@rivosinc.com>
 <20250317170625.1142870-3-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250317170625.1142870-3-cleger@rivosinc.com>

On Mon, Mar 17, 2025 at 06:06:08PM +0100, Clément Léger wrote:
> A few new errors have been added with SBI V3.0, maps them as close as
> possible to errno values.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> ---
>  arch/riscv/include/asm/sbi.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index bb077d0c912f..d11d22717b49 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -536,11 +536,20 @@ static inline int sbi_err_map_linux_errno(int err)
>  	case SBI_SUCCESS:
>  		return 0;
>  	case SBI_ERR_DENIED:
> +	case SBI_ERR_DENIED_LOCKED:
>  		return -EPERM;
>  	case SBI_ERR_INVALID_PARAM:
> +	case SBI_ERR_INVALID_STATE:
> +	case SBI_ERR_BAD_RANGE:
>  		return -EINVAL;
>  	case SBI_ERR_INVALID_ADDRESS:
>  		return -EFAULT;
> +	case SBI_ERR_NO_SHMEM:
> +		return -ENOMEM;
> +	case SBI_ERR_TIMEOUT:
> +		return -ETIME;
> +	case SBI_ERR_IO:
> +		return -EIO;
>  	case SBI_ERR_NOT_SUPPORTED:
>  	case SBI_ERR_FAILURE:
>  	default:
> -- 
> 2.47.2
>

I'm not a huge fan sbi_err_map_linux_errno() since the mappings seem a bit
arbitrary, but if we're going to do it, then these look pretty good to me.
Only other thought I had was E2BIG for bad-range, but nah...

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew

