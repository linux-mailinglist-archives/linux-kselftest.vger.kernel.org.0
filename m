Return-Path: <linux-kselftest+bounces-46954-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E3769CA184F
	for <lists+linux-kselftest@lfdr.de>; Wed, 03 Dec 2025 21:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D622E3007E76
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Dec 2025 20:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1548F2857F0;
	Wed,  3 Dec 2025 20:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="BhuJ9Z1Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382FC21CC5B;
	Wed,  3 Dec 2025 20:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764792517; cv=none; b=m4JX2ZUfKjKpNCkgOf70b8G9RFYS9nAUndKPsnhhWCUzUMFjx7kI5O9OB+cyniTNHAmi95Dau4ylhcxPR2f03tr4ly2/ZDiOfQbHbG7rS2Aq8kxuCitmeNXQXB8p3rQRInwi79bYwcgEnQS+Ib7f4NT+x7SrVIPhC6tItgNH+gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764792517; c=relaxed/simple;
	bh=6anUXpGpdwvKIqluoqbklfBuiMpl2f+J/6wkMedwSZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cg3DSkhLW+at3liOFnHxP3NWrUc5IvH1WgFYEkYzjWbUxjpUmYZ7R79eoC2lR77c90lw8hZ95V9Vo2yeajmMDiLC/KXX09vez41bNWI2FHQmGImmnsZnu799E5t7oglfnYCwsEoPWy6aOIKyrcFnxki0yCQwGXVflDtmljpknME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=BhuJ9Z1Z; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1764792512;
	bh=6anUXpGpdwvKIqluoqbklfBuiMpl2f+J/6wkMedwSZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BhuJ9Z1ZEkHYC1U5mMn9ZARciRdghG713e5dqjhRXSjcWG0CXsGjfznjzGj4H5rMV
	 vGWw3sixzx9jTLH+22OUm1px25NEtbGJo8fVDr1Sz/pMFPYPH0AHwXcfLlUU9ZfBtP
	 dEND9QKxrKlSPchsbK4dwqpFx6h59pjAGTEiqkpk=
Date: Wed, 3 Dec 2025 21:08:31 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 12/13] tools/nolibc: add __nolibc_static_assert()
Message-ID: <dcb9023a-8f90-45d8-9294-ee84250571f2@t-8ch.de>
References: <20251122-nolibc-uapi-types-v2-0-b814a43654f5@weissschuh.net>
 <20251122-nolibc-uapi-types-v2-12-b814a43654f5@weissschuh.net>
 <20251130110856.GE31522@1wt.eu>
 <57a98a13-4d88-4d83-b9f4-77a0a665be8a@t-8ch.de>
 <20251203192330.GA12995@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251203192330.GA12995@1wt.eu>

On 2025-12-03 20:23:30+0100, Willy Tarreau wrote:
> On Wed, Dec 03, 2025 at 08:19:13PM +0100, Thomas Weißschuh wrote:
> > On 2025-11-30 12:08:56+0100, Willy Tarreau wrote:
> > > On Sat, Nov 22, 2025 at 05:59:18PM +0100, Thomas Weißschuh wrote:
> > > > Add a wrapper for _Static_assert() to use within nolibc.
> > > > While _Static_assert() itself was only standardized in C11,
> > > > in GCC and clang dialects it is also available in older standards.
> > > > 
> > > > If it turns out that _Static_assert can't be used in some contexts,
> > > > this wrapper can be adapted.
> > > > 
> > > > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > > > ---
> > > >  tools/include/nolibc/compiler.h | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > > 
> > > > diff --git a/tools/include/nolibc/compiler.h b/tools/include/nolibc/compiler.h
> > > > index 87090bbc53e0..ef247e916552 100644
> > > > --- a/tools/include/nolibc/compiler.h
> > > > +++ b/tools/include/nolibc/compiler.h
> > > > @@ -47,4 +47,6 @@
> > > >  #  define __nolibc_fallthrough do { } while (0)
> > > >  #endif /* __nolibc_has_attribute(fallthrough) */
> > > >  
> > > > +#define __nolibc_static_assert(_t) _Static_assert(_t, "")
> > > 
> > > I'm not super fan of raising the bar to adoption by introducing forced
> > > C11-isms, especially when they're only used to perform extra safety
> > > checks that likely remain fine after you've checked them once. What
> > > about instead:
> > > 
> > > +#if __STDC_VERSION__ >= 201112L
> > > +# define __nolibc_static_assert(_t) _Static_assert(_t, "")
> > > +#endif
> > > +# define __nolibc_static_assert(_t) do { } while (0)
> > > +#else
> > > 
> > > Note that this won't work out of code blocks but we very likely don't
> > > care. And if we'd care, we could always switch to __asm__("") which
> > > works everywhere.
> > >  
> > > What do you think ?
> > 
> > That works. But it won't be evaluated when not building with C11.
> > Which would not make it trigger when building nolibc-test.
> > So I don't want to guard it behind __STDC_VERSION__. But so far I was
> > not able to find a better, more dynamic guard. I'll look again.
> > Non-standard _Static_assert() is supported since GCC 4.6 and clang 3.0.
> 
> Fine, then we can just have a compiler version check as well, even a rough
> one, since we don't reallly care about static asserts for pretty old or
> uncommon versions, but for the modern ones that are used by developers
> and test systems.
> 
> I'd suggest going the easy route for now by checking for GCC major >= 5
> or clang major >= 3 and be done with it.

Ack. Let's do that.


Thomas

