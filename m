Return-Path: <linux-kselftest+bounces-35261-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B16EADE65A
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 11:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D40327A3E36
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 09:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D2A27FD45;
	Wed, 18 Jun 2025 09:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHcfHKiM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3611126C1E
	for <linux-kselftest@vger.kernel.org>; Wed, 18 Jun 2025 09:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750237968; cv=none; b=nTHMMozfMoaBboIaMbPDS/TAfp3yYAEwKFqBaKKbkeQcR1SQ1DWgm9oqtHZD6/tcDzjLXMuDdexPtnmYyqwsq5bPrb0hARRPaX1clVkN5YSE1SIgtQWbCWrjb+Ssp4EOvycqMWGmDnlLm+YUodjuQaCQIwKAV7wdPa0trbWy4Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750237968; c=relaxed/simple;
	bh=MZHW6OwYCMSQZN32gvKbhi1xYAcw88sow8aVth6pGaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBq9pWgXnPejNxy423PVsdOknSw/xtu1zaTEQyVs6bgYBzp1z1CTKivvBdeClgpCC0g3fR8NYYuUpbG7GaBzRa0jHRzTBSNPUEbSwHsKJ9zwxdcpQ+cMr5iKq3G+y330FknjVQGtphBWVsCifp+lf0r/O5VmnGkEnx46nCv0g+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHcfHKiM; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-adb2bd27c7bso988994066b.2
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Jun 2025 02:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750237965; x=1750842765; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfnCtqQeir//58+p9X6NrWrwClhcxwGgse0Y99gdo6A=;
        b=WHcfHKiM/PmE2A+7IhAG+Zb2SPTvpGZrbq8druGF06PF2mX6Y+xb+1ZL0MlUmwKHew
         xfZidqxIgIUZCFGWljiiTP19nkfAJGvElJHIhprf8RLjG1a3xcgl+J/q61iR5OeyEYiJ
         DVnreveiibb0aX+lp9/O0EnAqpuS/3BR4ZP2OXjjyfM/w/zfgXI5d5BzsO+NGfp8B5Ct
         OG5ZBMXVnCjdEaYgJKQo828AaGXz0ocyDaOzdz9aLvVj11Ce6DSb0im6TNv5mjVE+iFc
         cmSjRbrjT2Z4yPMvhGjRs+MDrFLpwMMm/E2bK0+ypq5TRG0xnTSq9UXyD0uprLL37vae
         gEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750237965; x=1750842765;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QfnCtqQeir//58+p9X6NrWrwClhcxwGgse0Y99gdo6A=;
        b=XzELqwEpqIsRBUUewAudZT2jrAzVjpoAKxlcU/RebMffWald9LsZoWrbi29kDbPo/N
         aBKCr7IvfZLZ90TtTQCpu2HOzTOQ0HSEPkp/YXkD0ooc5mnv4npWHsmuNt0Q71if/+/T
         /m599pC/pK5Zn4rMSiBm7dKFMvDqLeLk+5d17aVcgrVCI9dYP6s7pxsR3LPUSzuIQhp1
         obk8YcHtI6765ltHb7izbrBI3Jf9a6b+Fl3lS9CjlCOHkG8fn1MuZMe61rmmChfcC6Wu
         0JRu6B78dOj7eoW17xLv+YUFdbIJWUN1d8KUhi78lOIpv3j1HGjXXMNYcd7Hz+hzgpUd
         xR+g==
X-Forwarded-Encrypted: i=1; AJvYcCVzJNGPKOQLHdH4H8yKqCioqrR025EAYmu1hkGJbNyxXL1HV/LhIp+hHogtTMPJXvE3XPXiQquckuFBHySKgmA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa1ossUKWufFxHNgQzfrLEL/M2fjLDYXEU3PSZAbQwfkpb49vH
	u9uok3Mppys1IF6s+rbut+g25ltvllMPGHqARujafOToXB0qIU/0pFre
X-Gm-Gg: ASbGncvDgdl1dtf5d88+H5s2Cxw2kQ8guuU/Lsozl1UM6kGLRP/yPN6srDpytRwC1oa
	82uMWhFORl/RrUA/IooTiUivFqD28RVf/fo5DIMco3P3aH6c2dji/CgW/6ldnr4WVBi9jS4UUIH
	DAptx4wJDgs8AVVL6IUIh1UvUyfqAEGm3rk5x1nP69Bklc3dJBTobYGcUs1giOeKn+u9CYNHMjT
	DJAhZWGogW9qImg3zsKt4aNjXOxRfs8hrTV0LIiD03OXa3u1ivyCatto86Y7cwoCom0btkV4lE/
	/F9Rq7B7pIMBdlZMLfamqkVA8EkaaMQP/YLKxD3NH3GFqoi8p2ZC8oE2YKiPDg==
X-Google-Smtp-Source: AGHT+IFKkvQkuRoAh34s7/gpn5d1RqMTgiG7/JHYqTpAkHRR2DmJl502dBFjSicEmsfkR0MnjLEYbA==
X-Received: by 2002:a17:906:f597:b0:ad1:e7f0:d8e5 with SMTP id a640c23a62f3a-adfad31a6b6mr1770877366b.16.1750237964633;
        Wed, 18 Jun 2025 02:12:44 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec88fed6esm1015407866b.103.2025.06.18.02.12.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jun 2025 02:12:44 -0700 (PDT)
Date: Wed, 18 Jun 2025 09:12:43 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	shuah@kernel.org, kees@kernel.org, luto@amacapital.net,
	wad@chromium.org, linux-kselftest@vger.kernel.org,
	usama.anjum@collabora.com, skhan@linuxfoundation.org
Subject: Re: [PATCH 3/3] selftests: harness: Add kselftest harness selftest
 with variant
Message-ID: <20250618091243.qh6ndqgu4mmo5go3@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250616122338.32678-1-richard.weiyang@gmail.com>
 <20250616122338.32678-4-richard.weiyang@gmail.com>
 <20250617093230-7c07d08b-5956-4a78-863c-f35cc300815c@linutronix.de>
 <20250617235748.pbw2mrpneol6gajb@master>
 <20250618074357-cb331853-aa30-43b1-8a2a-e193fd98eb90@linutronix.de>
 <20250618081653.y5xbkoeaab324nof@master>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618081653.y5xbkoeaab324nof@master>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Jun 18, 2025 at 08:16:53AM +0000, Wei Yang wrote:
[...]
>>
>>TH_LOG("test function %d", variant->value);
>>
>
>Got it, thanks.
>
>>Also please note that my earlier comment about the patch prefix
>>"selftests: harness:" should only apply to the patches really related to the
>>harness.
>>Not patch 2, which should use "selftests: kselftest:".
>>
>
>Hmm.. for patch 2, Muhammad mentioned it not comply with TAP guideline.
>
>So I plan to drop it in next version.
>

If I misunderstand that, please let me know.

-- 
Wei Yang
Help you, Help me

