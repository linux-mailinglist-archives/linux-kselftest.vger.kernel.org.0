Return-Path: <linux-kselftest+bounces-31628-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FE8A9C001
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 09:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C72E75A2270
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 07:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC22D232376;
	Fri, 25 Apr 2025 07:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="BONzwATD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3AC22D7A7
	for <linux-kselftest@vger.kernel.org>; Fri, 25 Apr 2025 07:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745567189; cv=none; b=VOYhVdzjgn06a9xjiYC0nDGl/2CG6hVksH/W2Xim0zC5I0UncjUBRgMU7KGIwn+VDsMBJurnsr0v5gbTcZ48GkC0eNeBy7DgYv5G+UkMVolLnnEKLG76+gvYN7933xskbsh9wv0mqpCp13q7bUwp6QQ1XSUV044s1rDM0+mZ7yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745567189; c=relaxed/simple;
	bh=M2e5e0DbBcCkM53d/193BeEEWoXcJicJMcob4XfVxtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imYs6Xd+8kiQxTsyE2yxbm0AYQKLIfZBSzW55Pgsj1cm2TM1FrzmAn21P4z6mrg7NBnkwoZ0qXZM+wG7VKf0NFZeqQW4m78sjT2cpGjZ1JnChdq7Y02BXReBc3L0MIbvHhIAUgEnl8EqUsSTFXXkrJLDojxOdyG9Efboe+NfV/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=BONzwATD; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso16880325e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Apr 2025 00:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1745567186; x=1746171986; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yalr6Bu93K2GzLCvN0XHCxzUAzn2mCxagWptxLA843Q=;
        b=BONzwATDn/a2Jbfl2U/CRNZi6nvEygafRicZHs3E01vwo9Vk0ZH7vrqo9dHe7NAp51
         gS/di6U0SsI2y61hjPKlZN7hHtXGxxQCTYYAVie4dgOUhY+Q7N3WXWFsB8YN55Q9i2i2
         JTzQUtB+zF67/ain39qAEr9FBYWqwsQRfg+iIHrIaZ3G2odO5yQCBtr0IUMml9EP1bDq
         pZpxlieYZmifYhKjSmNVmUmK+dOcxlcC/l6OdbaAssA4ntsgHsMXAk+SWpAskvjBNyul
         8HHDB+GtNKM9Hs8rpxZeaAHMHyn9jyBJF3Jq+0ww5ss/Yx9ZAH3k/OAESYnYn+todGiu
         X7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745567186; x=1746171986;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yalr6Bu93K2GzLCvN0XHCxzUAzn2mCxagWptxLA843Q=;
        b=X8kl7v2g993oCuhhJ4DKmvfDejUYnM5zbWd+2zzoPyTMHCsVkTbDhCjCRHU46viMj8
         3HOJxSW5rFiAn20QDkGUM3PEvnPCEykjpvDJLyjq/ovxGyHBp5Ata/nLYAFmofUvYb//
         TvgQo0BMTymssB4sFpQUH9TawxujGPuRy4pXLEQRLqw8eejth/ELjvPgjusqHfmyEgjE
         aLdLEtK8Ws1S6lXcyu1hAC/OwwC7Hzq7BOguEqFEyjR9tIITmVRHFqeHnwwWpra+Rwp9
         kDM16F1VS5Gm7u9WikzLeN/RQj5VukT5iM6h78vY3xlssRi7sTIUFXijTU0ktbeDwYH1
         nw6w==
X-Forwarded-Encrypted: i=1; AJvYcCWAY0ydm1SwaVS6UIj7PAknRQnEgOCcoaeNX7vaNnxinWPupCch8G8OI/YhvZr7TqJ9qrdFXtQ7qSkv7K0miYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJrwLYYDBclFT96uK4GDjFmJuqGLz1LT6z677Cn3mlIu9xpMQa
	euMc+IYGenTEMhxmHY34KEhyFg7z5QdtVXepmur90JLynlN727MdKZSRJZLaNC4=
X-Gm-Gg: ASbGncsriceKlNRpz78FV335GnHE3HoFJXna5ViNfRRge4w3p3UjQTaDfathbzvPGgv
	mi/iI3UyoeFtDP7tOoY72sjgQ9k17S3lxj/k4p4p32fqLDMBvrnPfH1LfuRapnKqSDEUD8cu2aN
	PWTsnhrXJrPchIQrMUuVpq1tF+Ba9udyR4l1cTkzc4+VZDzPE/cB0o6UJXtOvq19Oc5KMLO2Lqg
	lScZTZ7xNHawXVTkU7xsxI/0prs83L6WM6QuCkl6kJ3D8QgVmDJnh4sA446LYYlgGwGiJoaMtiO
	BW3VAUkKDpCImAlYlzTDawo8E5Vz
X-Google-Smtp-Source: AGHT+IGuKsjAp/bE7iMICTe5tl7fZLkgjjuJMOyAsBGa6hvpBqMsjN2EfsDi9JbPSKmGTEeYZJEdtA==
X-Received: by 2002:a05:6000:4212:b0:38f:2ddd:a1bb with SMTP id ffacd0b85a97d-3a074e144a6mr901505f8f.8.1745567185228;
        Fri, 25 Apr 2025 00:46:25 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::f716])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e46c23sm1496676f8f.75.2025.04.25.00.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 00:46:24 -0700 (PDT)
Date: Fri, 25 Apr 2025 09:46:24 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	Samuel Holland <samuel.holland@sifive.com>, Deepak Gupta <debug@rivosinc.com>
Subject: Re: [PATCH v6 02/14] riscv: sbi: remove useless parenthesis
Message-ID: <20250425-00fafd9027c5b1be3dd1d78e@orel>
References: <20250424173204.1948385-1-cleger@rivosinc.com>
 <20250424173204.1948385-3-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250424173204.1948385-3-cleger@rivosinc.com>

On Thu, Apr 24, 2025 at 07:31:49PM +0200, Clément Léger wrote:
> A few parenthesis in check for SBI version/extension were useless,
> remove them.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> ---
>  arch/riscv/kernel/sbi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index 1989b8cade1b..1d44c35305a9 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -609,7 +609,7 @@ void __init sbi_init(void)
>  		} else {
>  			__sbi_rfence	= __sbi_rfence_v01;
>  		}
> -		if ((sbi_spec_version >= sbi_mk_version(0, 3)) &&
> +		if (sbi_spec_version >= sbi_mk_version(0, 3) &&
>  		    sbi_probe_extension(SBI_EXT_SRST)) {
>  			pr_info("SBI SRST extension detected\n");
>  			pm_power_off = sbi_srst_power_off;
> @@ -617,8 +617,8 @@ void __init sbi_init(void)
>  			sbi_srst_reboot_nb.priority = 192;
>  			register_restart_handler(&sbi_srst_reboot_nb);
>  		}
> -		if ((sbi_spec_version >= sbi_mk_version(2, 0)) &&
> -		    (sbi_probe_extension(SBI_EXT_DBCN) > 0)) {
> +		if (sbi_spec_version >= sbi_mk_version(2, 0) &&
> +		    sbi_probe_extension(SBI_EXT_DBCN) > 0) {
>  			pr_info("SBI DBCN extension detected\n");
>  			sbi_debug_console_available = true;
>  		}
> -- 
> 2.49.0
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

