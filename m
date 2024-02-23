Return-Path: <linux-kselftest+bounces-5379-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F12861E28
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 21:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4B3A1C22570
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 20:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B056146E76;
	Fri, 23 Feb 2024 20:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tum.de header.i=@tum.de header.b="glkraDI2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from postout1.mail.lrz.de (postout1.mail.lrz.de [129.187.255.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F7D143C7B;
	Fri, 23 Feb 2024 20:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.187.255.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708721542; cv=none; b=pNEfkIqIy5AVVdXmnzBFpU6guQuGndSZ3gjT7k0r22munQpyB4DLIsyOBgxXH572sRibhsyCHcP0uPKkG8hrgAePwcQ1dFy//gGiNhxtEkQL5mDODwkVG5VdzPWa8Zl+sbsdiEoCIk4cb3i3bV0bTEQ5wDUqZ3oZvDhRyWdhxVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708721542; c=relaxed/simple;
	bh=X2Ai3VLTUPX8J6sGlUtCyH2/JCyRJ5egDX0GMxQeImg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5PXtQstjn1bhsn1rKCIARQbnkDqxVD0xHrCZlGLt3+E3435F1gLKrkU0UlhdoYQS6keqZKzBlV3y1ZW8p6iAJHMJ6NPtEySzlbPaKz34/3GEA+8Nt+cXHT5cWxwqBHiBiFdzBxXKmPLZ9JSddvmpTXBz/i5y9PjNjnmzpYjjp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tum.de; spf=pass smtp.mailfrom=tum.de; dkim=pass (2048-bit key) header.d=tum.de header.i=@tum.de header.b=glkraDI2; arc=none smtp.client-ip=129.187.255.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tum.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tum.de
Received: from lxmhs51.srv.lrz.de (localhost [127.0.0.1])
	by postout1.mail.lrz.de (Postfix) with ESMTP id 4ThMdX2XzVzyd5;
	Fri, 23 Feb 2024 21:52:16 +0100 (CET)
Authentication-Results: postout.lrz.de (amavisd-new); dkim=pass (2048-bit key)
	reason="pass (just generated, assumed good)" header.d=tum.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tum.de; h=
	in-reply-to:content-transfer-encoding:content-disposition
	:content-type:content-type:mime-version:references:message-id
	:subject:subject:from:from:date:date:received:received; s=
	tu-postout21; t=1708721535; bh=X2Ai3VLTUPX8J6sGlUtCyH2/JCyRJ5egD
	X0GMxQeImg=; b=glkraDI20d/PkHdSOMkhZ1Cyo8fyNgApNhHI2dm47TQoQz/gk
	Ks5P9govjSJ072vBXE7fKiieMHy/zZcm7Aa2w2Xh2hxCerB8DV5qisPanmUVwqWl
	CVxpw1yujNrr5H+8H9by40mkIXUHE/UB2RtudZnwsAoqOfvXAqcyyboC0kJkYZfq
	eVm1pzgMspeyK+OrVYIpmQl4eQQ55I/SFJF+Ug2ZUai9qTSpG8zuJjfJ08mmISEJ
	zjUE1Gbz4wyBgMQZRWF1jS8/7reaw0leCW35OTYsuRdPne4NW+wKExp656QZihXL
	UzEgvI0T/ksqhnihwa7Ozr1fZGjeRTJ4lJ55Q==
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs51.srv.lrz.de
X-Spam-Flag: NO
X-Spam-Score: -2.881
X-Spam-Level:
Received: from postout1.mail.lrz.de ([127.0.0.1])
	by lxmhs51.srv.lrz.de (lxmhs51.srv.lrz.de [127.0.0.1]) (amavisd-new, port 20024)
	with LMTP id jD_XKX9Z62Rv; Fri, 23 Feb 2024 21:52:15 +0100 (CET)
Received: from pine (unknown [IPv6:2001:a61:2510:5501:544b:4b32:4119:3827])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by postout1.mail.lrz.de (Postfix) with ESMTPSA id 4ThMdW0lTtzyd7;
	Fri, 23 Feb 2024 21:52:15 +0100 (CET)
Date: Fri, 23 Feb 2024 21:52:09 +0100
From: Paul =?utf-8?Q?Heidekr=C3=BCger?= <paul.heidekrueger@tum.de>
To: David Gow <davidgow@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, 
	Mark Brown <broonie@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <linux-kselftest@vger.kernel.org>, 
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <kunit-dev@googlegroups.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] kunit: tool: add 'mte=on' qemu arg on arm64
Message-ID: <v4sojpea3scs4rnigix5gu5dh2xqbzoxk3nlh3yuvktv2xeql4@4cyrbuf4sopq>
References: <20240214124131.990872-1-paul.heidekrueger@tum.de>
 <CABVgOS=n0rCS6ecAAh7BKkZbQQJu7ZHNrMJhkFGDqDG_n-U9bQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABVgOS=n0rCS6ecAAh7BKkZbQQJu7ZHNrMJhkFGDqDG_n-U9bQ@mail.gmail.com>

On 20.02.2024 08:46, David Gow wrote:
> On Wed, 14 Feb 2024 at 20:41, Paul Heidekrüger <paul.heidekrueger@tum.de> wrote:
> >
> > Hi!
> >
> > I was running some KASan tests with kunit.py recently and noticed that
> > when KASan is run in hw tags mode, we manually have to add the required
> > `mte=on` option to kunit_tool's qemu invocation, as the tests will
> > otherwise crash.
> >
> > To make life easier, I was looking into ways for kunit.py to recognise
> > when MTE support was required and set the option automatically.
> >
> > All solutions I could come up with for having kunit_tool conditionally
> > pass `mte=on` to qemu, either entailed duplicate code or required
> > parsing of kernel's config file again. I was working under the
> > assumption that only after configuring the kernel we would know whether
> > the 'mte=on' option was necessary, as CONFIG_ARM64_MTE is not visible
> > before.
> >
> > Only afterwads did I realise that the qemu arm64 config that kunit_tool
> > falls back on, uses the `virt` machine, which supports MTE in any case.
> > So, could it be as easy as just adding the `mte=on` option to
> > kunit_tool's arm64 config? Would this be a welcome addition?
> >
> > What do you think?
> >
> > Many thanks,
> > Paul
> >
> > Signed-off-by: Paul Heidekrüger <paul.heidekrueger@tum.de>
> > ---
> 
> I think this is fine. I'd be a little bit concerned if this were only
> supported in newer qemu versions, but it seems to go back to 6.2, so
> should be okay. I think it's better to just enable it unconditionally
> by default rather than trying to parse the config.
> 
> The KASAN tests seemed to work fine with HW tags in my testing here. I
> do wonder if there's a way to make the tests skip themselves if MTE
> isn't available: is there a way of doing a runtime check for this?

Huh, interesting. Even though "mte=on" isn't set on your side?

I get the following output without the MTE patch.

	➜   ./tools/testing/kunit/kunit.py run --kunitconfig=mm/kasan/.kunitconfig --arch=arm64
	[14:08:11] Configuring KUnit Kernel ...
	[14:08:11] Building KUnit Kernel ...
	Populating config with:
	$ make ARCH=arm64 O=.kunit olddefconfig
	Building with:
	$ make ARCH=arm64 O=.kunit --jobs=8
	[14:08:23] Starting KUnit Kernel (1/1)...
	[14:08:23] ============================================================
	Running tests with:
	$ qemu-system-aarch64 -nodefaults -m 1024 -kernel .kunit/arch/arm64/boot/Image.gz -append 'kunit.enable=1 console=ttyAMA0 kunit_shutdown=reboot' -no-reboot -nographic -serial stdio -machine virt -cpu max,pauth-impdef=on
	[14:08:23] kasan: test: Can't run KASAN tests with KASAN disabled
	[14:08:23]     # kasan:     # failed to initialize (-1)
	[14:08:23] [FAILED] kasan
	[14:08:23] ============================================================
	[14:08:23] Testing complete. Ran 1 tests: failed: 1
	[14:08:24] Elapsed time: 12.374s total, 0.001s configuring, 11.937s building, 0.382s running

Where the mentioned .kunitconfig has the following options set for KASan.

	CONFIG_KUNIT=y
	CONFIG_KUNIT_ALL_TESTS=n

	CONFIG_FTRACE=y
	CONFIG_STACK_TRACER=y 

	CONFIG_KASAN=y
	CONFIG_KASAN_HW_TAGS=y
	CONFIG_KASAN_KUNIT_TEST=y

With the MTE patch from my previous email, everything works just fine.

Based on that, do you have a guess why it's working for you and why it isn't for 
me?

> Regardless, this is:
> Reviewed-by: David Gow <davidgow@google.com>

Thanks! I'll be sending a non-RFC patch shortly.

Many thanks,
Paul


