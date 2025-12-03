Return-Path: <linux-kselftest+bounces-46953-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E603CA16C6
	for <lists+linux-kselftest@lfdr.de>; Wed, 03 Dec 2025 20:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A692E30084CA
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Dec 2025 19:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56E0336ECE;
	Wed,  3 Dec 2025 19:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="EOCPlSSw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8420A335BA0;
	Wed,  3 Dec 2025 19:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764789821; cv=none; b=SDGg94iRYuDnxyc7cHXrqxHfzIV7cTbbSc/CQ5fl5UHCr15OB5DBicq8TqIxK3COpr7jECMY4pARmUfpHN3WhnEFVMmbCY47MJVE3gGY0Oi7diuCyUzgIrL4BZH9g3grfiAQTp0h6duOzcYXUvPiUL0IadYNo1maKQhcTubFRrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764789821; c=relaxed/simple;
	bh=TMWtvWPGpxL3s9iRB27lhAzUZ2qihLwfbsB4NolYr5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LeAxPhTKiKAjdNPBZKvdNhxejwXdijnhX6fAly7S3zJ1wfZeQdXRndK+C7EN3Ej+ChwtyF8vzwWE3pboIS76CEN64Ib+/q9v2fK5PNfU4ekrAcZkcwSTrDdYGwk3DoCuJqIQFTxfcTKHswsdIc6LvFcUSdam8IUNZaFewmdttsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=EOCPlSSw; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1764789810; bh=NQ1wWltMXyA263gxuY+AJSRFpv7mh9pwQcLgjz9Zm88=;
	h=From:Message-ID:From;
	b=EOCPlSSwFMrelcVSd4lHj0RxQo117UtKq92xMajZzvy9Ojr+DH24PVMMs+qih9sG8
	 TqSr0I3p4nL1chVY169Mo5Yww9cROfPMqrj2D8YV86JuuMl5i45rOm9aTYdb4X+5sQ
	 Fd0Mzhsyvkj1T//xUU2xiFpXxtdp5ygjijaZgUHI=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 95824C095D;
	Wed, 03 Dec 2025 20:23:30 +0100 (CET)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 5B3JNUvm013008;
	Wed, 3 Dec 2025 20:23:30 +0100
Date: Wed, 3 Dec 2025 20:23:30 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 12/13] tools/nolibc: add __nolibc_static_assert()
Message-ID: <20251203192330.GA12995@1wt.eu>
References: <20251122-nolibc-uapi-types-v2-0-b814a43654f5@weissschuh.net>
 <20251122-nolibc-uapi-types-v2-12-b814a43654f5@weissschuh.net>
 <20251130110856.GE31522@1wt.eu>
 <57a98a13-4d88-4d83-b9f4-77a0a665be8a@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57a98a13-4d88-4d83-b9f4-77a0a665be8a@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Dec 03, 2025 at 08:19:13PM +0100, Thomas Weiﬂschuh wrote:
> On 2025-11-30 12:08:56+0100, Willy Tarreau wrote:
> > On Sat, Nov 22, 2025 at 05:59:18PM +0100, Thomas Weiﬂschuh wrote:
> > > Add a wrapper for _Static_assert() to use within nolibc.
> > > While _Static_assert() itself was only standardized in C11,
> > > in GCC and clang dialects it is also available in older standards.
> > > 
> > > If it turns out that _Static_assert can't be used in some contexts,
> > > this wrapper can be adapted.
> > > 
> > > Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> > > ---
> > >  tools/include/nolibc/compiler.h | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/tools/include/nolibc/compiler.h b/tools/include/nolibc/compiler.h
> > > index 87090bbc53e0..ef247e916552 100644
> > > --- a/tools/include/nolibc/compiler.h
> > > +++ b/tools/include/nolibc/compiler.h
> > > @@ -47,4 +47,6 @@
> > >  #  define __nolibc_fallthrough do { } while (0)
> > >  #endif /* __nolibc_has_attribute(fallthrough) */
> > >  
> > > +#define __nolibc_static_assert(_t) _Static_assert(_t, "")
> > 
> > I'm not super fan of raising the bar to adoption by introducing forced
> > C11-isms, especially when they're only used to perform extra safety
> > checks that likely remain fine after you've checked them once. What
> > about instead:
> > 
> > +#if __STDC_VERSION__ >= 201112L
> > +# define __nolibc_static_assert(_t) _Static_assert(_t, "")
> > +#endif
> > +# define __nolibc_static_assert(_t) do { } while (0)
> > +#else
> > 
> > Note that this won't work out of code blocks but we very likely don't
> > care. And if we'd care, we could always switch to __asm__("") which
> > works everywhere.
> >  
> > What do you think ?
> 
> That works. But it won't be evaluated when not building with C11.
> Which would not make it trigger when building nolibc-test.
> So I don't want to guard it behind __STDC_VERSION__. But so far I was
> not able to find a better, more dynamic guard. I'll look again.
> Non-standard _Static_assert() is supported since GCC 4.6 and clang 3.0.

Fine, then we can just have a compiler version check as well, even a rough
one, since we don't reallly care about static asserts for pretty old or
uncommon versions, but for the modern ones that are used by developers
and test systems.

I'd suggest going the easy route for now by checking for GCC major >= 5
or clang major >= 3 and be done with it.

Willy

