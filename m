Return-Path: <linux-kselftest+bounces-46952-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE3FCA1555
	for <lists+linux-kselftest@lfdr.de>; Wed, 03 Dec 2025 20:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 41B4730021DB
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Dec 2025 19:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEF53328F4;
	Wed,  3 Dec 2025 19:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="TVVKuzfM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390083321CE;
	Wed,  3 Dec 2025 19:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764789558; cv=none; b=O4BFwgx7C8g6FBaV8P3DFM9T9JDlqst4sjbVyR0maOeLwEzn0qaK02mOI7Mek2Vvr/p9G11r/5oog4hwErVGE6dz+IDYCn9uwM59H7u7t08b9HWz/0bWuHruYS6yGGlDtNHXPPAcy2tX7LM3SuEk99FLCGNq7XsUv502tTNHMTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764789558; c=relaxed/simple;
	bh=LWjMFO2ArIhVjjawt2dFkPc/C/ieTIAKqGmlnYV9OD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKpXjhIS/bxUk0OiHcVhKGLEs6bQlxG+Ag5vNPBSSB70DEYNMScrOxYFCmcRPmuTlUwkVuduVONsB3qQAc3rrM2T/hzK2fdNXkFJxSdGyiNFpJZgkZsXdtBiGPltpytuMs3Sa4VMBpD3nvqOyN7YWESrz9ksWL7UM4uesVrCAec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=TVVKuzfM; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1764789553;
	bh=LWjMFO2ArIhVjjawt2dFkPc/C/ieTIAKqGmlnYV9OD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TVVKuzfMJ2ZQ8OOE752xMILPWKtcJ9wpKAlRK6Lpozs2OEunw64clwuw3Qz/ArT5c
	 EW0BviT4To6qTN2kd0KIEHaIb2+weqBLixUIqqvZozvbI0+1xSy0Hq+wSsimuTmvDw
	 Gkf9i04qenXiPirkQ0YBxUYEbV0+w+vbhA3Qjc6E=
Date: Wed, 3 Dec 2025 20:19:13 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 12/13] tools/nolibc: add __nolibc_static_assert()
Message-ID: <57a98a13-4d88-4d83-b9f4-77a0a665be8a@t-8ch.de>
References: <20251122-nolibc-uapi-types-v2-0-b814a43654f5@weissschuh.net>
 <20251122-nolibc-uapi-types-v2-12-b814a43654f5@weissschuh.net>
 <20251130110856.GE31522@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251130110856.GE31522@1wt.eu>

On 2025-11-30 12:08:56+0100, Willy Tarreau wrote:
> On Sat, Nov 22, 2025 at 05:59:18PM +0100, Thomas Weißschuh wrote:
> > Add a wrapper for _Static_assert() to use within nolibc.
> > While _Static_assert() itself was only standardized in C11,
> > in GCC and clang dialects it is also available in older standards.
> > 
> > If it turns out that _Static_assert can't be used in some contexts,
> > this wrapper can be adapted.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >  tools/include/nolibc/compiler.h | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/tools/include/nolibc/compiler.h b/tools/include/nolibc/compiler.h
> > index 87090bbc53e0..ef247e916552 100644
> > --- a/tools/include/nolibc/compiler.h
> > +++ b/tools/include/nolibc/compiler.h
> > @@ -47,4 +47,6 @@
> >  #  define __nolibc_fallthrough do { } while (0)
> >  #endif /* __nolibc_has_attribute(fallthrough) */
> >  
> > +#define __nolibc_static_assert(_t) _Static_assert(_t, "")
> 
> I'm not super fan of raising the bar to adoption by introducing forced
> C11-isms, especially when they're only used to perform extra safety
> checks that likely remain fine after you've checked them once. What
> about instead:
> 
> +#if __STDC_VERSION__ >= 201112L
> +# define __nolibc_static_assert(_t) _Static_assert(_t, "")
> +#endif
> +# define __nolibc_static_assert(_t) do { } while (0)
> +#else
> 
> Note that this won't work out of code blocks but we very likely don't
> care. And if we'd care, we could always switch to __asm__("") which
> works everywhere.
>  
> What do you think ?

That works. But it won't be evaluated when not building with C11.
Which would not make it trigger when building nolibc-test.
So I don't want to guard it behind __STDC_VERSION__. But so far I was
not able to find a better, more dynamic guard. I'll look again.
Non-standard _Static_assert() is supported since GCC 4.6 and clang 3.0.


Thomas

