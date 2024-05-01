Return-Path: <linux-kselftest+bounces-9223-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F1C8B8EC3
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 19:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90723B20BB9
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 17:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31FB17BA3;
	Wed,  1 May 2024 17:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="pskqzGJO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A976817591
	for <linux-kselftest@vger.kernel.org>; Wed,  1 May 2024 17:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714583183; cv=none; b=DrzMqrHsHr+KkEUEJbQNiG3XMUk92j8/dnjbJ/kasNUkj+H0UAvg5wZcu9L+t4XGLbPoy9IYEXJzCYysu17XLsQ6zkQB8mXeD4jVYPmNg2m0asBO5CU7BDGMhLMKL9+rmh6FNW8BfuuQrdgHh92RaS7kN2D/nRfP6FyWQsrsCyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714583183; c=relaxed/simple;
	bh=pqU7oYGJgnj9NuhHq21MW2iYlmXEJsCtkyhRbZQMx0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLWMcl9XlAGqlAiIozOXQQzu9Dkym/KBOHR0SRYiXUIaIO6EoK3I2s5Dnx7P6TVMwA3QjPKJs/F0VFU25xT18zcKz0yK/FWv1OJoClyYW38JA6BPqO9Bkdmrn9xEC0tLWzkbO326kFbeUpLgSlF8KcYb5pHQh1rbpU326FqkHI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=pskqzGJO; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2b3374e08cfso439337a91.2
        for <linux-kselftest@vger.kernel.org>; Wed, 01 May 2024 10:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714583182; x=1715187982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ulUTnrt0/o6KrpYj4/lKXwggI1Tcz4XFzc+8cliUI0c=;
        b=pskqzGJOaoD4BIUPmMgmZijLoimhceT6AA89Byuqf5OmPWuyi2gxFvdjI3/X03PuT2
         EiwArqrECy9mcOB3xfJJ+1lze8cCIfiwxbuvkiiQsE3reif3c9wshk39vjGz7oRUyVKs
         oP7nYrbhpvOv4rAj8cgKbAcxJNF8RhsGArvXSW3vW8+IQWd4eqGw04cdmA+n8qwlJF1f
         +CDjKde9V11tnI0tbFVfymVf39gmimnXqG35VXjWnnYhkZkR+v/7u5DZKNx77prWM36C
         Gz8sN8tqZ4Tp9hB3twsSbnTOHXhUnx6MkpgfUw134PNlQ6N1Cxf+IqdBWPZZ/LSFngnU
         jn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714583182; x=1715187982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulUTnrt0/o6KrpYj4/lKXwggI1Tcz4XFzc+8cliUI0c=;
        b=dd0JdV/9eQQ4OTq03zdb+25d744bo8VEn869IoE+zN+ZaMd6x0xqUeMmsAabopU7fC
         6P+1Yh/Xbw+qc7xg8EAlvr8w0ul179dQNAb/c+at5IywoCezDCHEm0lc9dvJp/JlCeas
         XkdB1z/7Wos+iTXOu5gSXouXtWLHrfTqskP95afJn5CjA8jisfw0WSaCY6wP8AHy3FuU
         fez0rVxHE7oP9qx4DhSBxOsQs4O73raS3HDC9xVKPLbdVuXIutE+2xjigHWwLwZjh72q
         Pl8DqmEZceECkQkqhgVQjiz78hmqrD6zJAW1dPWAIOFTj/yAT6G9hx0Z0liRbVV7Ql4I
         mRiA==
X-Forwarded-Encrypted: i=1; AJvYcCWT2uBI00WMuks6TQTei9E5c/uI3goTGL0XrpZUi3eaB7SuA9Y5e9HEUiLA2e/WMWQwPGXbQdh88s3xtr+YfpC1SsTi7vhqUnjZPSldYWZQ
X-Gm-Message-State: AOJu0YzX7mWyJk3/2n/pCM4EjhLymX4Hq0FAEhhOflIV+J64q72gvraf
	hK+ap+ongqt8FlFC3l/HEciwuDBGLOasDxP7EyD04iqmcrk3/zsJc7ozpgMXMeo=
X-Google-Smtp-Source: AGHT+IGbQ99FfsOuQfbPD1HKb4OFUev7bCmbhruunbIFw2+vddc7cv9+d7D2Uj+7TUiDOOY0K6p1lQ==
X-Received: by 2002:a17:90a:f493:b0:2b2:d001:db41 with SMTP id bx19-20020a17090af49300b002b2d001db41mr2837033pjb.40.1714583181995;
        Wed, 01 May 2024 10:06:21 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:1dcc:e03e:dc61:895d])
        by smtp.gmail.com with ESMTPSA id db5-20020a17090ad64500b002a53b33afa3sm1593854pjb.8.2024.05.01.10.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 10:06:21 -0700 (PDT)
Date: Wed, 1 May 2024 10:06:18 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 05/16] riscv: Extend cpufeature.c to detect vendor
 extensions
Message-ID: <ZjJ2irS2ornhzeYc@ghost>
References: <20240426-dev-charlie-support_thead_vector_6_9-v4-0-b692f3c516ec@rivosinc.com>
 <20240426-dev-charlie-support_thead_vector_6_9-v4-5-b692f3c516ec@rivosinc.com>
 <20240501-pelican-throwaway-da84be7dac30@spud>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501-pelican-throwaway-da84be7dac30@spud>

On Wed, May 01, 2024 at 12:19:34PM +0100, Conor Dooley wrote:
> On Fri, Apr 26, 2024 at 02:29:19PM -0700, Charlie Jenkins wrote:
> > @@ -353,6 +336,10 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
> >  		bool ext_long = false, ext_err = false;
> >  
> >  		switch (*ext) {
> > +		case 'x':
> > +		case 'X':
> > +			pr_warn_once("Vendor extensions are ignored in riscv,isa. Use riscv,isa-extensions instead.");
> > +			continue;
> 
> Yeah, so this is not right - you need to find the end of the extension
> before containing - for example if I had a system with
> rv64imafdcxconorkwe, you get something like:
> [    0.000000] CPU with hartid=0 is not available
> [    0.000000] Falling back to deprecated "riscv,isa"
> [    0.000000] Vendor extensions are ignored in riscv,isa. Use riscv,isa-extensions instead.
> [    0.000000] riscv: base ISA extensions acdefikmnorw
> [    0.000000] riscv: ELF capabilities acdfim
> 
> kwe are all pretty safe letters, but suppose one was a v..
> I think you can just yoink the code from the s/z case:

Oh right, I forgot about that.

> 
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 20bc9ba6b7a2..4daedba7961f 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -338,8 +338,19 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
>  		switch (*ext) {
>  		case 'x':
>  		case 'X':
> -			pr_warn_once("Vendor extensions are ignored in riscv,isa. Use riscv,isa-extensions instead.");
> -			continue;
> +			if (acpi_disabled)
> +				pr_warn_once("Vendor extensions are ignored in riscv,isa. Use riscv,isa-extensions instead.");
> +			/*
> +			 * To skip an extension, we find its end.
> +			 * As multi-letter extensions must be split from other multi-letter
> +			 * extensions with an "_", the end of a multi-letter extension will
> +			 * either be the null character or the "_" at the start of the next
> +			 * multi-letter extension.
> +			 */
> +			for (; *isa && *isa != '_'; ++isa)
> +				;
> +			ext_err = true;
> +			break;
>  		case 's':
>  			/*
>  			 * Workaround for invalid single-letter 's' & 'u' (QEMU).
> 
> You'll note that I made the dt property error dt only, this function
> gets called for ACPI too. I think the skip is pretty safe there though
> at the moment, we've not established any meanings yet for vendor stuff
> on ACPI.
> I think breaking is probably better than using continue - we get the _
> skip from outside the switch statement out of that. And ye, I am lazy
> so I kept it as a for loop.

Awesome, thanks!

- Charlie

> 
> Cheers,
> Conor.



