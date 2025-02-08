Return-Path: <linux-kselftest+bounces-26107-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A526A2D7D8
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 18:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28B161889032
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 17:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8470241131;
	Sat,  8 Feb 2025 17:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPeaTVp9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DB7241103;
	Sat,  8 Feb 2025 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739037211; cv=none; b=e8NDHKn8Msv+Wy4N+z4vNhKxyoGybQdoROWmbvD7NbmPx4YxAOC9ftDN7OV3flwBtANX/nN7lnvDqDRvdp827oI3nXiXru5My+7eMYaEX2o4cP5z/667rOYFPzERwJex7bQRSMynjjmQmtSg5Xt58SETrkIBjCVCqPyZ7RFcnAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739037211; c=relaxed/simple;
	bh=u5KQrgj4hl5hhrtdAGh+wetosNfiX2i3D4EhPgaEPow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTfRVuQISrlX5nGdO7DZDqiVSsKwIz+vPjBI4TAYuIfJJUV4xbhYwo4X0Yq7uFGfCX799jI3SBQKwPZeJrKBLYWM7lrvh+nJ/g4cvG/iWH8pgYQwRJyLpIfyHIPhWrJKvEOVJlKFJcxOj74fy24UaMwzaGTWduXRgmDKmcgHhzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPeaTVp9; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6f77b9e0a34so23124817b3.2;
        Sat, 08 Feb 2025 09:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739037209; x=1739642009; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GWCLWUGpRzNN38qDSRAHapFkwtjzVMbT+fgTsmO02GE=;
        b=KPeaTVp9sm8v7DGs39uvOBwy4BX+EzJD+yxE3Hkjqit5qBVfnCJKAidSE4ke3IRkXb
         Kw8tngQR+Hq+pKzLRY71quNQzgy8jspsnKqLHpBwtANyANDlxBQnneCWAFH2zIeLxw/n
         xQgAhmg0CCRh7kqDJjmJQ7D3/Z2y1JW1k24o4S3L8rLCImlgraA+94BOiuf8Eyc9BPbA
         SsTQaV1qsYX8zSNbyHU+XYybHDNys2i3xsKa4CIZqeNGvoadJCHudiqZQb1OjiTdf/pj
         ocAxuuZKStIfnfUMF5XCTibrrtD0qy69+PoXp+MTTEmTgtjrMhRaT+F4ECrDtFNJboih
         U9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739037209; x=1739642009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWCLWUGpRzNN38qDSRAHapFkwtjzVMbT+fgTsmO02GE=;
        b=s/XKzo6Ou1Gmem0NDEd357+nCqTnxSd41O70Mb9RG3W8I6hos+KQuIkKKHFKYd7zCk
         WTJET8DH++kIyApTkSrYqsP/H4+nSaBaKOwCdy2kHONqwLRzQaoocVVdsfM4fMdG6LpM
         TFaKdRJKsMiSlHpC1l8sKyWNxP6K4LYtf54FXTu2dKK0EcZTzi3NmIrrHO3KnS6IgS+s
         Stl3m6FuWyBVrn9ll5DjMkuak/a5dXGHyrqUDYE2mHjFFaVKOLznHcwV133vg1dci6Jk
         60OojKoiE3zF8cxaG58hgCm38/F5cDaaHdj19zbOZCExtdTEA6cQH+5LHE/JPrsbIA6M
         j4jA==
X-Forwarded-Encrypted: i=1; AJvYcCUeim5oZ7LuSuu6an3U+nEgRG8LB7P2UrFiK7UNYoePgbvAdFX0o0k8LJOnEUYRudmnsrx39h/VgyRc3oU=@vger.kernel.org, AJvYcCV5gLhbvLBhujTniF9fgvbgRUVGi3PWeZ9utPmaLwG2jGqyg9JXHcEbe3FUfxLntCuoViU3sXVWFy/F4fWoftmd@vger.kernel.org
X-Gm-Message-State: AOJu0YwGI9fSDibo9ypFsmgT+XIXUB/7sEXtHLPKT7VioZ2Dc5rH13Pp
	2PSAvuF26WXAa0TYGv4HGYWSHMDZoZaHZCrVcbWpd363Wb6yRw0z
X-Gm-Gg: ASbGncvel0dOArrKBk+2epvwtgMqrxA6QlfYHPjFNK7K35g14dOWmHHLkmh8lI5Tt8b
	zmunrIldcev68ab0W0VUT3WBIyO/AdRnQNjrDdB72LgwxT/7hhdO9JpouTKC0LefDoWElEfj6NL
	N3QyF7phkexieWrlZwyR6xZhpZNZaehGQr1TGsU6d35Pu+e2ADtoB+i1wrZZIuBCf9uh/tN7eZb
	nFAVseXHY21NdQpNWITamTrkSfJxZMozm691X/aaiUlFwJBm7H7uwwSFlPxMjox+JxRqLSThh2d
	zXkfxc6s+haiN/Tu8OsPHx+OQVrQgqakuV/xKKdGOWMsZ6xOEQs=
X-Google-Smtp-Source: AGHT+IGharplEze0gu0SCa8jNPf4PFwFx7r6QQdncnkwjNrUp7r48urY21da4KyUfmTiooRho9XVbw==
X-Received: by 2002:a05:690c:74c3:b0:6f6:cd43:5468 with SMTP id 00721157ae682-6f9b2a2165amr71225727b3.33.1739037208799;
        Sat, 08 Feb 2025 09:53:28 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f99fceff39sm9570747b3.19.2025.02.08.09.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 09:53:28 -0800 (PST)
Date: Sat, 8 Feb 2025 12:53:27 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: David Gow <davidgow@google.com>, John Hubbard <jhubbard@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/3] bitmap: convert self-test to KUnit
Message-ID: <Z6eaDuXnT_rjVSNS@thinkpad>
References: <20250207-bitmap-kunit-convert-v1-0-c520675343b6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-bitmap-kunit-convert-v1-0-c520675343b6@gmail.com>

On Fri, Feb 07, 2025 at 03:14:01PM -0500, Tamir Duberstein wrote:
> This is one of just 3 remaining "Test Module" kselftests (the others
> being printf and scanf), the rest having been converted to KUnit.
> 
> I tested this using:
> 
> $ tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=1 bitmap.
> 
> I've already sent out a conversion series for each of printf[0] and scanf[1].
> 
> There was a previous attempt[2] to do this in July 2024. Please bear
> with me as I try to understand and address the objections from that
> time. I've spoken with Muhammad Usama Anjum, the author of that series,
> and received their approval to "take over" this work. Here we go...

Take over means that you'd at least add the Co-developed-by tag.

> 
> On 7/26/24 11:45 PM, John Hubbard wrote:
> > 
> > This changes the situation from "works for Linus' tab completion
> > case", to "causes a tab completion problem"! :)
> > 
> > I think a tests/ subdir is how we eventually decided to do this [1],
> > right?
> > 
> > So:
> > 
> >     lib/tests/bitmap_kunit.c
> > 
> > [1] https://lore.kernel.org/20240724201354.make.730-kees@kernel.org
> 
> This is true and unfortunate, but not trivial to fix because new
> kallsyms tests were placed in lib/tests in commit 84b4a51fce4c
> ("selftests: add new kallsyms selftests")  *after* the KUnit filename
> best practices were adopted.
> 
> I propose that the KUnit maintainers blaze this trail using
> `string_kunit.c` which currently still lives in lib/ despite the KUnit
> docs giving it as an example at lib/tests/.
> 
> On 7/27/24 12:24 AM, Shuah Khan wrote:
> > 
> > This change will take away the ability to run bitmap tests during
> > boot on a non-kunit kernel.
> > 
> > Nack on this change. I wan to see all tests that are being removed
> > from lib because they have been converted - also it doesn't make
> > sense to convert some tests like this one that add the ability test
> > during boot.
> 
> This point was also discussed in another thread[3] in which:
> 
> On 7/27/24 12:35 AM, Shuah Khan wrote:
> > 
> > Please make sure you aren't taking away the ability to run these tests during
> > boot. 
> >
> > It doesn't make sense to convert every single test especially when it
> > is intended to be run during boot without dependencies - not as a kunit test
> > but a regression test during boot.
> > 
> > bitmap is one example - pay attention to the config help test - bitmap
> > one clearly states it runs regression testing during boot. Any test that
> > says that isn't a candidate for conversion.
> > 
> > I am going to nack any such conversions.
> 
> The crux of the argument seems to be that the config help text is taken
> to describe the author's intent with the fragment "at boot". I think
 
KUNIT is disabled in defconfig, at least on x86_64. It is also disabled
on my Ubuntu 24.04 machine. If I take your patches, I'll be unable to
boot-test bitmaps. Even worse, I'll be unable to build the standalone
test from sources as a module and load it later.

Or I misunderstand it, and there's a way to build some particular KUNIT
test without enabling KUNIT in config and/or re-compiling the whole kernel?
Please teach me, if so

Unless you give me a way to build and run the test in true
production environment, I'm not going with KUNITs. Sorry.

> this may be a case of confirmation bias: I see at least the following
> KUnit tests with "at boot" in their help text:
> - CPUMASK_KUNIT_TEST

This one doesn't count because the test was not converted, it's
originally written as a KUNIT test. I am happy when people bring new
tests in the most comfortable way for them, and I don't want to push
them to use this framework or another. So I didn't object, and I'm
thankful for this contribution to Sander.

> - BITFIELD_KUNIT

Same here. Plus, it was written long before I took over bitfields.

> - CHECKSUM_KUNIT
> - UTIL_MACROS_KUNIT

> It seems to me that the inference being made is that any test that runs
> "at boot" is intended to be run by both developers and users, but I find
> no evidence that bitmap in particular would ever provide additional
> value when run by users.

This is my evidence: sometimes people report performance or whatever
issues on their systems, suspecting bitmaps guilty. I ask them to run
the bitmap or find_bit test to narrow the problem. Sometimes I need to
test a hardware I have no access to, and I have to (kindly!) ask people
to build a small test and run it. I don't want to ask them to rebuild
the whole kernel, or even to build something else.

https://lore.kernel.org/all/YuWk3titnOiQACzC@yury-laptop/

> There's further discussion about KUnit not being "ideal for cases where
> people would want to check a subsystem on a running kernel", but I find
> no evidence that bitmap in particular is actually testing the running
> kernel; it is a unit test of the bitmap functions, which is also stated
> in the config help text.
> 
> David Gow made many of the same points in his final reply[4], which was
> never replied to.

Nice summary for the discussion. Unfortunately you missed my concerns.
Which are:

Pros:
 - Now we switch to KUNITs because KUNITs are so good

Cons:
 - Wipes git history;
 - Bloats the test's source code;
 - Adds dependencies;
 - Doesn't run on most popular distros and defconfig;

So, no.

Thanks,
Yury

> Link: https://lore.kernel.org/all/20250207-printf-kunit-convert-v2-0-057b23860823@gmail.com/T/#u [0]
> Link: https://lore.kernel.org/all/20250207-scanf-kunit-convert-v4-0-a23e2afaede8@gmail.com/T/#u [1]
> Link: https://lore.kernel.org/all/20240726110658.2281070-1-usama.anjum@collabora.com/T/#u [2]
> Link: https://lore.kernel.org/all/327831fb-47ab-4555-8f0b-19a8dbcaacd7@collabora.com/T/#u [3]
> Link: https://lore.kernel.org/all/CABVgOSmMoPD3JfzVd4VTkzGL2fZCo8LfwzaVSzeFimPrhgLa5w@mail.gmail.com/ [4]
> 
> Thanks for your attention.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> Tamir Duberstein (3):
>       bitmap: remove _check_eq_u32_array
>       bitmap: convert self-test to KUnit
>       bitmap: break kunit into test cases
> 
>  MAINTAINERS                           |   2 +-
>  arch/m68k/configs/amiga_defconfig     |   1 -
>  arch/m68k/configs/apollo_defconfig    |   1 -
>  arch/m68k/configs/atari_defconfig     |   1 -
>  arch/m68k/configs/bvme6000_defconfig  |   1 -
>  arch/m68k/configs/hp300_defconfig     |   1 -
>  arch/m68k/configs/mac_defconfig       |   1 -
>  arch/m68k/configs/multi_defconfig     |   1 -
>  arch/m68k/configs/mvme147_defconfig   |   1 -
>  arch/m68k/configs/mvme16x_defconfig   |   1 -
>  arch/m68k/configs/q40_defconfig       |   1 -
>  arch/m68k/configs/sun3_defconfig      |   1 -
>  arch/m68k/configs/sun3x_defconfig     |   1 -
>  arch/powerpc/configs/ppc64_defconfig  |   1 -
>  lib/Kconfig.debug                     |  24 +-
>  lib/Makefile                          |   2 +-
>  lib/{test_bitmap.c => bitmap_kunit.c} | 454 +++++++++++++---------------------
>  tools/testing/selftests/lib/bitmap.sh |   3 -
>  tools/testing/selftests/lib/config    |   1 -
>  19 files changed, 195 insertions(+), 304 deletions(-)
> ---
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> change-id: 20250207-bitmap-kunit-convert-92d3147b2eee
> 
> Best regards,
> -- 
> Tamir Duberstein <tamird@gmail.com>

