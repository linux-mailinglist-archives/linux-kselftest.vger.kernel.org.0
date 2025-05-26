Return-Path: <linux-kselftest+bounces-33767-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D354DAC3BDD
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 10:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D00F3A6FB9
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 08:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FFC1EBFF7;
	Mon, 26 May 2025 08:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="IS2wliyk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF331DFE12
	for <linux-kselftest@vger.kernel.org>; Mon, 26 May 2025 08:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748248900; cv=none; b=jY3u5vicj9FEKDGAZ0woBqP1NXXcFRhuqskCoI8upln0JrXR3HiBx0IRGjg9PikBKhmTmNBm6PEq/pFoWGu4tlBc0ATonVTKYLUFyqYUhPljJGPq29s6nGM6R8/x7KAlhlCs9oGsTHEEuW3fmUtIb2PBHtKNcwm60++/HwMnglc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748248900; c=relaxed/simple;
	bh=AfxOAmXX1HdyQc0nVIo6KqK7evO8C9QirK7XVJr4/KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Piz0M7K4uOxIVhvBCGAzq6KQDrPsNEU6InniDHCeNyakkGXT/3JmhnUlFUvl5H9LVvKTLqR3MrE5Aya17iFKvC/HlphrIhJ/jcNP3Bpxi7nUv2dBZf2QXhibbkYa2t/zmYFl32gI9odZJmOK0P4Z+FmBkG0lKIb9cAYHflhfQKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=IS2wliyk; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60477f1a044so1277838a12.0
        for <linux-kselftest@vger.kernel.org>; Mon, 26 May 2025 01:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1748248895; x=1748853695; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lgi+BI+UxQxxje7YEG6nl3Jn6VhfFhFL9BZoJyhkgXs=;
        b=IS2wliykKG0JexCU4dAuudzmJDVbE//5gSgXk16sewo1lWnES+4bQtkGITnENjAUtu
         Q83sWWdR+5JmPjg/k6zDofVl3ZAL88VJq8AzewWF8IUMLizCdOmAunLIpV5udJGxjquZ
         yGVjlFfNGx2c5cnhprO+f3zZXGzieiDPl0EYohxwcl8yaCxNH58gFpcmRV24cwIKQvLd
         2HsCk5vKoe6hcjNl1Le08FUTAsaYFe1/p4sj2xB2ACkvcHo0RktKonXTtHBfbo3qsvlm
         oKnB9zwYhXDCWC+XtrB4SIliiI9aE0sx/VZpD1c/baDa3ci1WdmPThLHu63aPRr6UauO
         FMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748248895; x=1748853695;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lgi+BI+UxQxxje7YEG6nl3Jn6VhfFhFL9BZoJyhkgXs=;
        b=QbeGQH1lPyYkQFcRiOgHRAtxL9nINQc3DW+rGGPzNioSHnUcebvnAMt+Fc3nL50Yol
         7BuhN5L4ZeUSQ3q4fd25ZT8JSDoE9UKYh41i6fGwxTPEKirRT6iu0VtHt3Ie8eRdGGL4
         NANisyOqIP+rySaWWLIBlWehojyLSYQ/fxwgQrIpT/1wlcsgsIqOO2pxyaN2hWQ4PqXL
         8IeP+VldgZ0m/aLB1o7CzX+mmTwZMLS2dSIqYM2v/+xPjd1WuTwJkX9vFiGzWY06H6/W
         1adHHiuAEt7E9WgvDqzSneRcZsgAlvGos29WdCFuXLs58OtDyAG6xcfPCV0UzdwRA58N
         3UWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrBbcsO3rTsCI7T90OyTNi/IbrucchOWxLrTM/lgc2kO78ChHvdGp9s1MS/mOtyYYSRuUbGSrvhuvN4dpaq5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUp7CI5F83DtDZOKfGt6jFguMfTMDrodL2+mm5ibY1xSdRA/Fg
	JHya3bHAh7AToTHmQOOqsvqWKDZNnHn4O59YzThMpfd/RprfdBdlxR9bDt1aDWxR5SM=
X-Gm-Gg: ASbGncuSQDfFCnkK+EJBKZ8W/9UVxeruZjh6Ghcid052lTeGSOc2tYEyMJGctgI8ENJ
	cCdDHJ4ucIFw60qhKYmp/4avYgk5Yp2t/4bpK57fQ/d2Ksy1Pm5q1dLETNSimV7Aqh18G6R1GRM
	5P3EHM7rYq2h+iuqV1iAtBMZ68mrEPYdr9zuMjT8uQZZNto9eGxQ3z5VvP/rhzKX+aFIJPcgVPl
	CUrQfoVslRYNBgtFZaeICnVcM1QxgVeIGvhtLLGfixCltZNmJoMx1IyruIjMdERj4Oi79vHeg0k
	gSuIuIB/09L0wMGHmtUEEE1eq1/8hfSGaLGaPxSTYtOBxunS5a+Aa8skQawBEN2QMx3Ox9yEyCn
	ywDfu
X-Google-Smtp-Source: AGHT+IG8/VYDbfxt/MCOP+EaLwsXzbrnjfrXlbSUZYq06meSDTM4WfgPl2nsylybH23Wd9Lf5xvIZg==
X-Received: by 2002:a05:6402:4404:b0:602:1b8b:2902 with SMTP id 4fb4d7f45d1cf-602d9bf086amr6150523a12.15.1748248894652;
        Mon, 26 May 2025 01:41:34 -0700 (PDT)
Received: from localhost (cst2-173-28.cust.vodafone.cz. [31.30.173.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-604b79dc22fsm1148466a12.14.2025.05.26.01.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 01:41:34 -0700 (PDT)
Date: Mon, 26 May 2025 10:41:33 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Charlie Jenkins <charlie@rivosinc.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	Samuel Holland <samuel.holland@sifive.com>, Deepak Gupta <debug@rivosinc.com>
Subject: Re: [PATCH v8 09/14] riscv: misaligned: move emulated access
 uniformity check in a function
Message-ID: <20250526-baaca3f03adcac2b6488f040@orel>
References: <20250523101932.1594077-1-cleger@rivosinc.com>
 <20250523101932.1594077-10-cleger@rivosinc.com>
 <aDC-0qe5STR7ow4m@ghost>
 <b2afb9c7-a3d2-4bf6-bfaa-d804358ccd88@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2afb9c7-a3d2-4bf6-bfaa-d804358ccd88@rivosinc.com>

On Fri, May 23, 2025 at 09:21:51PM +0200, Clément Léger wrote:
> 
> 
> On 23/05/2025 20:30, Charlie Jenkins wrote:
> > On Fri, May 23, 2025 at 12:19:26PM +0200, Clément Léger wrote:
> >> Split the code that check for the uniformity of misaligned accesses
> >> performance on all cpus from check_unaligned_access_emulated_all_cpus()
> >> to its own function which will be used for delegation check. No
> >> functional changes intended.
> >>
> >> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> >> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> >> ---
> >>  arch/riscv/kernel/traps_misaligned.c | 20 ++++++++++++++------
> >>  1 file changed, 14 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
> >> index f1b2af515592..7ecaa8103fe7 100644
> >> --- a/arch/riscv/kernel/traps_misaligned.c
> >> +++ b/arch/riscv/kernel/traps_misaligned.c
> >> @@ -645,6 +645,18 @@ bool __init check_vector_unaligned_access_emulated_all_cpus(void)
> >>  }
> >>  #endif
> >>  
> >> +static bool all_cpus_unaligned_scalar_access_emulated(void)
> >> +{
> >> +	int cpu;
> >> +
> >> +	for_each_online_cpu(cpu)
> >> +		if (per_cpu(misaligned_access_speed, cpu) !=
> >> +		    RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED)
> >> +			return false;
> >> +
> >> +	return true;
> >> +}
> > 
> > This ends up wasting time when !CONFIG_RISCV_SCALAR_MISALIGNED since it
> > will always return false in that case. Maybe there is a way to simplify
> > the ifdefs and still have performant code, but I don't think this is a
> > big enough problem to prevent this patch from merging.
> 
> Yeah I though of that as well but the amount of call to this function is
> probably well below 10 times so I guess it does not really matters in
> that case to justify yet another ifdef ?

Would it need an ifdef? Or can we just do

 if (!IS_ENABLED(CONFIG_RISCV_SCALAR_MISALIGNED))
    return false;

at the top of the function?

While the function wouldn't waste much time since it's not called much and
would return false on the first check done in the loop, since it's a
static function, adding the IS_ENABLED() check would likely allow the
compiler to completely remove it and all the branches depending on it.

Thanks,
drew

> 
> > 
> > Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
> > Tested-by: Charlie Jenkins <charlie@rivosinc.com>
> 
> Thanks,
> 
> Clément
> 
> > 
> >> +
> >>  #ifdef CONFIG_RISCV_SCALAR_MISALIGNED
> >>  
> >>  static bool unaligned_ctl __read_mostly;
> >> @@ -683,8 +695,6 @@ static int cpu_online_check_unaligned_access_emulated(unsigned int cpu)
> >>  
> >>  bool __init check_unaligned_access_emulated_all_cpus(void)
> >>  {
> >> -	int cpu;
> >> -
> >>  	/*
> >>  	 * We can only support PR_UNALIGN controls if all CPUs have misaligned
> >>  	 * accesses emulated since tasks requesting such control can run on any
> >> @@ -692,10 +702,8 @@ bool __init check_unaligned_access_emulated_all_cpus(void)
> >>  	 */
> >>  	on_each_cpu(check_unaligned_access_emulated, NULL, 1);
> >>  
> >> -	for_each_online_cpu(cpu)
> >> -		if (per_cpu(misaligned_access_speed, cpu)
> >> -		    != RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED)
> >> -			return false;
> >> +	if (!all_cpus_unaligned_scalar_access_emulated())
> >> +		return false;
> >>  
> >>  	unaligned_ctl = true;
> >>  	return true;
> >> -- 
> >> 2.49.0
> >>
> 

