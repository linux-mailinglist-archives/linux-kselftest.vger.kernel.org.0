Return-Path: <linux-kselftest+bounces-24325-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EA6A0B1D1
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 09:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C6861887FE0
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 08:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E35123499B;
	Mon, 13 Jan 2025 08:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ars8z+AH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD6023315A
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 08:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736758443; cv=none; b=C1DcFjvjnVrnKPfH99pasJD8i55qxmreIvfkMECNvO7h5xq9R3W0oR5gfY/c6fINnleKXoKlhLAgeUpUmG6v61mJDX2ys/L4x3jTDe81NztwpHrq3/gOAFnuGEeSIZx36X2klI3ATc2fKZ/KarlRVKi7r2W8t917uzIRLmGUqnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736758443; c=relaxed/simple;
	bh=8KIk020yR2Ka06d1okI1R9aNEP5xeWNNv7rGAsAygco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fm1+noOzr7Q15Pu4ZnpMqaSbGC7rXmCkv+lqdVCLZJxkoa5RfBWron/c9dDGMOEf93plbDRvO8KiCTd6/EfjcrU8tOMApo/Bxx6J5r+nZAqpmDIRyAzXpGj3UzAGynzquDU2s2n5vppINK3Yg1gEPsxwz8z9sMAhZLpc0fPGfKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ars8z+AH; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa679ad4265so964180066b.0
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 00:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1736758440; x=1737363240; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pdlz8or/j2SZsqBQFu80d2cIXQqxqGv/i2pD+MRAWJ4=;
        b=ars8z+AHWO5a9phSfhL7uNOt5QF1Ir3mh9uo5yhRe4sC90Spwr7fAttLcpZsR6n3wL
         zGwEGnEwqmynLY6IsfosDWrHP9y1bFDwjl/URdzKbTjFIpZeLba4vy72eU3kZlVDTIg0
         QW6ydiHuZ9WzhndC9EU4qjybmflEKd2bkKsaXN9eQ8Rk+tf65j5eC8bZEsA8Wqt3/x4m
         q7Us0Y/xXIW3CR3EvXh88M1n8zAifSGrO3GpdA7ZAUntgM2Pey3HY7OxpGfx2cbUzUn9
         xPTRGAXxKcXeRwI8DmCe/T4uynEWtPhjEPuxHh2ZbiSioyJWDg4OZrimRCT2V9cndtfb
         ssOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736758440; x=1737363240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pdlz8or/j2SZsqBQFu80d2cIXQqxqGv/i2pD+MRAWJ4=;
        b=wx86L8cZpXHJ5oGXPtqW0QXKiANiG3NB7FcOutXRrogOP4DiZPnLW4K3+VAS6oebtE
         Ts/rXjSzPLs3phlAE31YC5WePPxhNh8G6tDiR3uMV/M91kZV6NI5PuFIW++u8RBSN+Ty
         Y2Uzd44nvIkjcLE69ubDAdVMyR+lcr8rxb9YCNEkEzmdxYBSCte0d4OYuYP3/5mdHY4h
         RNFekDDo9+cAJO9Q3i0QJnkygCacGEVlvTT4mCQxvX+N1k7hu6i/1lKBUDi//V7DqV3U
         goEc/3efNAXUHl9ScEHbPKFK0P2eCdHPszfPD7BJcedNHv2e63dOBv+agqch4GCqO8Nl
         lzbg==
X-Forwarded-Encrypted: i=1; AJvYcCXlzzIOuyjQ6+/pdjfACHjJHb5U4cdaajmmUhjESfRQmChNfm6OPBFIBCxmpJ0Sxhr8Ljzc+l8CA5n+sfwTNFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe5kAINCSvR+qGJwQhYJPdkV4HVChI5/aK3EXKDqPPmvqzLmEN
	wUXLXSSxr8KaKtugHVGexxhT8nXu/LIED4eJYZaysShxHguWtz0iZAI8XSyjGsg=
X-Gm-Gg: ASbGncvbDp+BjeYD1FJX1DbwpxzTvlFk/BZq41gdhCxFF3lgsQLEZSCU3kGtzXKMo4k
	WtoNAOlixcA/baOothIDK9LoczcF4R0Y3RQvznSFasPlXbK+SNMmdDMPVgdqlrOjn12xfzInbrL
	Tbp42e5qQnjG/u0FZRgx5CUN+nN7NdQoF6gMRUZ5NSRFticmOFDCgsPKlT31z7xjlmeiFjrd+P7
	PgfQAh7jThVi2QRtGfzR4JH1GWevAA0WiAEhoCwIuMxho7PCdnN1sJkCA+mqdyUqHfSSz5LKYHB
	rZjDh/n6EFNH0d0/I1ctRBCM5gB5M3KCmHx55XbM2g==
X-Google-Smtp-Source: AGHT+IGrUXeyMcpjKt8l6r7fafi2mX5rutzDSKCfV7zy1dqdywkWqv2gi/08sBQDRIu3dr8UvuvhZw==
X-Received: by 2002:a17:907:9447:b0:aa5:b1bb:10db with SMTP id a640c23a62f3a-ab2c3c2833bmr1266276866b.1.1736758440035;
        Mon, 13 Jan 2025 00:54:00 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95624c1sm474230466b.131.2025.01.13.00.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 00:53:59 -0800 (PST)
Date: Mon, 13 Jan 2025 09:53:58 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: alexghiti@rivosinc.com, andybnac@gmail.com, aou@eecs.berkeley.edu, 
	charlie@rivosinc.com, cleger@rivosinc.com, conor.dooley@microchip.com, 
	conor@kernel.org, corbet@lwn.net, evan@rivosinc.com, jesse@rivosinc.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-riscv@lists.infradead.org, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	samuel.holland@sifive.com, shuah@kernel.org
Subject: Re: [PATCH v3 1/3] RISC-V: Enable cbo.clean/flush in usermode
Message-ID: <20250113-62458ced6e6997eca091f325@orel>
References: <20250113083635.73826-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113083635.73826-1-cuiyunhui@bytedance.com>

On Mon, Jan 13, 2025 at 04:36:33PM +0800, Yunhui Cui wrote:
> Enabling cbo.clean and cbo.flush in user mode makes it more
> convenient to manage the cache state and achieve better performance.
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  arch/riscv/kernel/cpufeature.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index c0916ed318c2..60d180b98f52 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -30,6 +30,7 @@
>  #define NUM_ALPHA_EXTS ('z' - 'a' + 1)
>  
>  static bool any_cpu_has_zicboz;
> +static bool any_cpu_has_zicbom;
>  
>  unsigned long elf_hwcap __read_mostly;
>  
> @@ -87,6 +88,8 @@ static int riscv_ext_zicbom_validate(const struct riscv_isa_ext_data *data,
>  		pr_err("Zicbom disabled as cbom-block-size present, but is not a power-of-2\n");
>  		return -EINVAL;
>  	}
> +
> +	any_cpu_has_zicbom = true;
>  	return 0;
>  }
>  
> @@ -944,6 +947,11 @@ void __init riscv_user_isa_enable(void)
>  		current->thread.envcfg |= ENVCFG_CBZE;
>  	else if (any_cpu_has_zicboz)
>  		pr_warn("Zicboz disabled as it is unavailable on some harts\n");
> +
> +	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICBOM))
> +		current->thread.envcfg |= ENVCFG_CBCFE;
> +	else if (any_cpu_has_zicbom)
> +		pr_warn("Zicbom disabled as it is unavailable on some harts\n");
>  }
>  
>  #ifdef CONFIG_RISCV_ALTERNATIVE
> -- 
> 2.39.2
>

Please use a cover letter with a changelog or at least changelogs under
the '---' of each patch.

Thanks,
drew

