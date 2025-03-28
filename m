Return-Path: <linux-kselftest+bounces-29901-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FC8A752C4
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Mar 2025 00:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F89516FE97
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Mar 2025 23:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75041F180C;
	Fri, 28 Mar 2025 23:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KHsUxg4Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201BF1E1DF2
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Mar 2025 23:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743203310; cv=none; b=tY2Coexx1PS3StogOnPqTmAVQY0pFrGQ47Zh+qokkczUN9QDi6zehRaidfPGrvIxxPdf+taxtRRl711/C2lSx4FGDALgFP8hg2SkFqzCNpqKIYNjpJZQYHiBJ+yManBJ1KghWeGlgE4I5blVI8mmt18cMOdqNHRYBrITt1/e8e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743203310; c=relaxed/simple;
	bh=6OTSMjwfOD26EolJV2LssxJnD/6mI73Gc34GQ+4e+3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wv5YJvBfaSV7nfNIGEJAUg/8l4j6y8iPtwMn4plv6LsfTp3AaPjmjMKqcCZsYoB+AVzaRwtrwmrjlNgHzhDBo+3dJ1pBVeSiUuXGlvnDv7tzdHucn3F8ddAVPqwBDjlrB2Jyr9R6836B3Nv2Oi81FQ3FFmfuoF3YnBf2jHt3Q4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KHsUxg4Z; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3d58908c43fso6982285ab.0
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Mar 2025 16:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1743203308; x=1743808108; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FbB4yJ6F+USSpCKga3bcSTeyR/Rd99H8ZrgamvSh+v4=;
        b=KHsUxg4ZPguGpyDbD3wQUhVPkyVIDZfF/SWvmEpG+K3vjRIV5Aupy1z4xHvWbVDvK5
         9nc1M8gmfHEJRxTZitAyGw2d5ce2fTqAm5Z/30nkkcMdXf3nVPM1/m6qKKjAgVypo2ml
         d1pdauMftC7YsSY70A3Tf/mj23l0CSDqcNKI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743203308; x=1743808108;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FbB4yJ6F+USSpCKga3bcSTeyR/Rd99H8ZrgamvSh+v4=;
        b=MCXY/oVkZqtgVhdrRKSb/Ra01Cbq+3dXRYUUE7EL8v/II9A6NAGNzCpP1xpDlP1yMQ
         vLpB8G1LkCCJ3jfBflZDNa0SyrCi5Zu8fYsVopkkmWfOLJd77Oi8n1IcBbLseBovJVAJ
         4gE+zmsURrWaTFm9roN1MwIwGfDP+WDeaDJ1qEZw48hSEuamhUOAbmkaoL2Eoaf3M0gB
         C5hyzH3ViU5ZK+EGLXzoST1rMTaVjjnyTeFndcWmeWFjFh4wwSyhwXlDyXmQ0xI/xDh4
         2CEM+PXIyeccCAk4wOvE3GTV7Wfsafmfd9QdRtkc/1tBIwbXt8cDhs71BBx41dpdWXo+
         ef4g==
X-Forwarded-Encrypted: i=1; AJvYcCV3hBb4klIc/XaRuCv4Ktr2xvVjWlxdccNoh1E3Aj9xZgBFgAdcnLFX1DRWocetEIvVsXdg3cJ1Jg0Dhpar0no=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuYkLhYaYYk58MtomxYzaU63M2vD5xtVkvADUopRS57aGOwXKG
	h4n5Y3ykiNH1iggVJ6PI57ysy3roz4hw6zee2Gl6BbsD0d1BtsiSALOMkdFklD0=
X-Gm-Gg: ASbGncvawz64rhe7vgb20GEk6XbCAtbtiQ9J84M29wSb3Y4gOKZBDytcSlj5y3TPWRI
	ptqw9NpOoYkdrxjNc4bgcznxUcFFmccv9OBE1bTVAbW6/aEURGA7O3dWXiMwm/Plg+OuuDFD7A2
	anm+Ve3XQyBhLINqoVJlpezF+ZtPNUP0f1WGn4wHNAZzHkw0TAdHiX55G6MGrKvEHkRyFgvuY7V
	Cdva4yD8wAXLMjynq006rDZdDsitgPIugXSH6OtHQOpQuNW70NJrNJmxuptQJ6mTLyMx7JEn+00
	tESyJyJBHEWls6HF7nwczwpnGxlPUkVJxYKk4MmguhZEVxnvh8iqwV4=
X-Google-Smtp-Source: AGHT+IFUySP8TeYFdXm2DTXfPzjGy2dg3a2uSfxvpKOITK7L3F3BtfTwZ8RalSAqFZ31DjT7hhwcbw==
X-Received: by 2002:a05:6e02:2493:b0:3d3:fbf9:194b with SMTP id e9e14a558f8ab-3d5e07e230amr16274035ab.0.1743203308013;
        Fri, 28 Mar 2025 16:08:28 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d5d5ae2636sm7123385ab.46.2025.03.28.16.08.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Mar 2025 16:08:27 -0700 (PDT)
Message-ID: <75ea2dcf-0ba3-4076-9a54-6b39e4e72a3d@linuxfoundation.org>
Date: Fri, 28 Mar 2025 17:08:26 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/16] selftests: vDSO: parse_vdso: Use UAPI headers
 instead of libc headers
To: Mark Brown <broonie@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Shuah Khan
 <shuah@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Andy Lutomirski <luto@kernel.org>, Willy Tarreau <w@1wt.eu>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 llvm@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
References: <20250226-parse_vdso-nolibc-v2-0-28e14e031ed8@linutronix.de>
 <20250226-parse_vdso-nolibc-v2-12-28e14e031ed8@linutronix.de>
 <af553c62-ca2f-4956-932c-dd6e3a126f58@sirena.org.uk>
 <c7bea938-ee3b-477e-9ed0-db29ca02a538@sirena.org.uk>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <c7bea938-ee3b-477e-9ed0-db29ca02a538@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/26/25 07:02, Mark Brown wrote:
> On Thu, Mar 20, 2025 at 01:23:47PM +0000, Mark Brown wrote:
>> On Wed, Feb 26, 2025 at 12:44:51PM +0100, Thomas Weißschuh wrote:
>>> To allow the usage of parse_vdso.c together with a limited libc like
>>> nolibc, use the kernels own elf.h and auxvec.h headers.
> 
>> The vDSO selftests currently fail build for at least arm64 in -next:
> 
> ...
> 
>> a bisect points at this patch, it looks like that's due to the switch to
>> use TOOLS_INCLUDES but I didn't dig into the specifics.
> 
> This bug is now in mainline.  A fix was posted by Thomas the day after
> the original report:
> 
>     https://lore.kernel.org/r/20250321-uapi-consistency-v1-1-439070118dc0@linutronix.de
> 
> but it has apparently slipped through the cracks.

If this is going through tip

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

Otherwise, I can send this up

thanks,
-- Shuah



