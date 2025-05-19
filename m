Return-Path: <linux-kselftest+bounces-33353-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81814ABCB86
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 01:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 653A44A0FE5
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 23:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785D22206BB;
	Mon, 19 May 2025 23:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="HcwjZUjB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BF42206A8
	for <linux-kselftest@vger.kernel.org>; Mon, 19 May 2025 23:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747697527; cv=none; b=OeMhq5tLFZqhkL+9l7az/73XIs8z/vuHrbxNWG1zXBJM2RVMXT37dsup1yQnPlJdim4b1vqcoZqXenJHgIvtCZxP+BotCRoEck5WbeJO7ws5Nuv8axmBkl8peMCyFUw7u1GjOLlf9AUgO79a7nb0v8rFcMHaSlwaDAyvKEPcUAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747697527; c=relaxed/simple;
	bh=MuZecVDV8WFQM7jhq4WavtkULWOpjeUqMx1UI6H0F2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcNT1FW7b/V/nqekSF7RtaIHETMalYXc2loTl0yy4BKOFdmNCqF87nG97F2mcsmQCDvk3v7vFLeHpN9YPlpZKKm9VnI9794JQCLSVMwMgevvIaHCZM8ZtJMVSolpHu7I07zk4wyqwoqlx94X3IS7qVB1sopanPiAPkoOEYQBuG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=HcwjZUjB; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-742b614581dso3524372b3a.3
        for <linux-kselftest@vger.kernel.org>; Mon, 19 May 2025 16:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747697524; x=1748302324; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QOyUGS8X8xHimjiVikyyoBlw5XuU3QFPDBQZu8PO5T8=;
        b=HcwjZUjBu6SW4iaZ4eqWlVd3gnga/+2egklurtWhhJCdJFrAsN+G2+cD1JYcMSSyIb
         0d/pAuTz23KyPXnfRH/D5729EW4MEQiQtRsZAtLe3tDInkSc37aWlBR+cWbaZV7ORKx0
         KmpAZBS+knxTPLX2RdVTbRjXA6rmpBZ5Q2hh9/INAQyPLTOXjbotHLzcHHz89zIAiG7k
         c2QTT0WZm/WCk6qxdCVMobMeTgzgKyx4dlU9pB6V6K6ZVi6QcLAAjgoDgyoxVYZuGPGY
         HnbtRWkDF2HWX/Qs8ffzdeFXjeqqybgC1cTjtS5uu4+KuAjLy+OTalpLd/4k/0MdmlR6
         IC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747697524; x=1748302324;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QOyUGS8X8xHimjiVikyyoBlw5XuU3QFPDBQZu8PO5T8=;
        b=QBr9yZj6MdDtey7QtMh+xFJPe1nnXYsHATkuMQcCY6vQ67Kn2c5+U8eGMcef53Pt2e
         ML9gUIapHiAjnPX+pQmQw73tfnbdL7z+Z/xcZ5XLE/ZU6hWwAHCbmGfrkqVZVtYnnfuP
         SdbkQOX5Go/G7plx+bhe8NwBmCBoKAOnZGG/9dyUqIZ/fU8NXUFcMINSk7QUADp/EPPt
         gWJhX4DU+j3aZCEwSAUPr0RutJWJAAaHw8gIis+yd0PCusX+fjb0fikBHLKxQyAPzaSS
         bsb8D6kCmGMWP9nWLqv+mnhxv7sbOMP+U4jxq9XDi0mXAQoEMnqfD9fZH124qY4Iid+4
         idrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtYY3nUhnDz/FFKLGi0M0DwXlg7G20lRiuAO6s4RcorhhMZufjCeUuKK/UzEWoGviYYjg3RZx7iLnOLJ3WXkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgI26yoyLOuddcGuDKF0pq27rkNcQRmvdtL2/sXUOogFAIBqeg
	lcv3+sZx2lHdf/AhR34a9XvYwRdZTcjFl/OxF0PYafM2ZmnUlMwXUukGvm4fJur5weoNfJc63Hp
	Y9M7xmBk=
X-Gm-Gg: ASbGncuofdLwh4fZX+7GDTDqwZ+56Ud6/gzMbGmr0T3zZssYbG6AszJAsXxMH/+z9Cg
	PsGBKoKbhW3nUP90b5gAJpUkUZ/oCR2YRHu8/RSwthpDk+CckzrSdwTmW3TJsfPcrnhHmr3L0UB
	dHAg9VWW2S4eBcW6094wiFgTsag3YSfBvI+lOMU30ubmyoFSkzaUUwyKYHA3QtQCOr7A81uSnkg
	h1aa78ZDXhhyUVOwh4JjFOeaqaqtoGUSj5OqrIuzq/JiI7TS3+z3x7mDvJURMmkf8G15AjY7Zmk
	Rm0EohrH1mkhnnJwOdF6klMR2Fj6yR97uDJN799GaR94BeA=
X-Google-Smtp-Source: AGHT+IF/UpnfYd87Wg38QzExFJepdbUZBdK8n48P10QCBwcJgibQDw+FN+/Y6470diBydPdUYMEijg==
X-Received: by 2002:a05:6a20:3d1c:b0:1ee:d418:f764 with SMTP id adf61e73a8af0-2170ce33ad3mr22022427637.38.1747697524568;
        Mon, 19 May 2025 16:32:04 -0700 (PDT)
Received: from ghost ([2601:647:6700:64d0:5f9c:a71e:a2da:158d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb0a9893sm6875885a12.72.2025.05.19.16.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 16:32:03 -0700 (PDT)
Date: Mon, 19 May 2025 16:32:01 -0700
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
Subject: Re: [PATCH v7 09/14] riscv: misaligned: move emulated access
 uniformity check in a function
Message-ID: <aCu_ce-kVQsyjrh5@ghost>
References: <20250515082217.433227-1-cleger@rivosinc.com>
 <20250515082217.433227-10-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250515082217.433227-10-cleger@rivosinc.com>

On Thu, May 15, 2025 at 10:22:10AM +0200, Clément Léger wrote:
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
> index e551ba17f557..287ec37021c8 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -647,6 +647,18 @@ bool __init check_vector_unaligned_access_emulated_all_cpus(void)
>  }
>  #endif
>  
> +static bool all_cpus_unaligned_scalar_access_emulated(void)
> +{
> +	int cpu;
> +
> +	for_each_online_cpu(cpu)
> +		if (per_cpu(misaligned_access_speed, cpu) !=

misaligned_access_speed is only defined when
CONFIG_RISCV_SCALAR_MISALIGNED. This function should return false when
!CONFIG_RISCV_SCALAR_MISALIGNED and only use this logic otherwise.

- Charlie

> +		    RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED)
> +			return false;
> +
> +	return true;
> +}
> +
>  #ifdef CONFIG_RISCV_SCALAR_MISALIGNED
>  
>  static bool unaligned_ctl __read_mostly;
> @@ -685,8 +697,6 @@ static int cpu_online_check_unaligned_access_emulated(unsigned int cpu)
>  
>  bool __init check_unaligned_access_emulated_all_cpus(void)
>  {
> -	int cpu;
> -
>  	/*
>  	 * We can only support PR_UNALIGN controls if all CPUs have misaligned
>  	 * accesses emulated since tasks requesting such control can run on any
> @@ -694,10 +704,8 @@ bool __init check_unaligned_access_emulated_all_cpus(void)
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
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

