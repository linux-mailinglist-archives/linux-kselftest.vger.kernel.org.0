Return-Path: <linux-kselftest+bounces-48340-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB699CFAB39
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 20:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F906317C66D
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 18:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D1E2D7810;
	Tue,  6 Jan 2026 18:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="oZP7TVlL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5382F2C2368;
	Tue,  6 Jan 2026 18:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767724350; cv=none; b=BV0b81Kh5RQyhxiTGFuwfJQIOnI7ZiyCLewsmxzKbfwrw4KcFY1gu+QdNddXTcGMuU4CE2GTdNhdgS7HN3VqTS5+Cvddlu6JXc/RGVcm7ZuZYe80DLwDZhy9S70sFu3ZQHqVRcuPMiTVqFCDVT+Fn3BSSgBfwoU7VTI8nz2kxXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767724350; c=relaxed/simple;
	bh=BCiacOQAofNPJa3tKat+maLPfPlv0wVxKju9SD+KP14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZPynI/gb1YukFBaWJHQu01vX/2ELPFDV0ILBokSOAw0oRCT1dyiutxKVL0E4U7SYVBllNPpUV2IKqBGhQ8kpzXRb1Nn3tgs5OcNQGLCZT/hbIpnewtZ3o1/0Lzd4jFNGT6QZvCWyqt0Jv5RoeJWpFg2gd01CAHMfl90mwIcJq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=oZP7TVlL; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1767724346;
	bh=BCiacOQAofNPJa3tKat+maLPfPlv0wVxKju9SD+KP14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oZP7TVlLgsNKnh+ImE45y1p9zUi7R/mkcYGYmb9ImElnN66xL+YqnsZ4l7g6HRgqX
	 3pEvVyL99/UShbJJILURW19eIoOQLXngzPkN5OwtfAfnz2Fd95InC+vF2/yqzW9F7u
	 08C0jmEjL0L8XkA7W+1A3EZcWNevOm38ZvJn14J4=
Date: Tue, 6 Jan 2026 19:32:25 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: fix sparc32 tests with -mcpu=v9
Message-ID: <e7eca29c-dca1-49c0-88ae-ece904209d1b@t-8ch.de>
References: <20260104-nolibc-sparc32-fix-v1-1-e341b06cbdb7@weissschuh.net>
 <CAMuHMdUHBm_oiyeUumRc=avp+QCiCLZAfi0BvLwToAM3TumGmQ@mail.gmail.com>
 <18bb48f2-b5aa-42a6-bc09-4773e1907670@t-8ch.de>
 <CAMuHMdWBs5nGWEyvu7F+kWB4dMwEOvtqzdYnT+NE3YtU48udwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWBs5nGWEyvu7F+kWB4dMwEOvtqzdYnT+NE3YtU48udwg@mail.gmail.com>

Hi Geert,

On 2026-01-06 14:36:23+0100, Geert Uytterhoeven wrote:
> On Tue, 6 Jan 2026 at 12:47, Thomas Weißschuh <linux@weissschuh.net> wrote:
> > On 2026-01-06 12:40:12+0100, Geert Uytterhoeven wrote:
> > > On Sun, 4 Jan 2026 at 23:14, Thomas Weißschuh <linux@weissschuh.net> wrote:
> >
> > (...)
> >
> > > > --- a/tools/testing/selftests/nolibc/Makefile.nolibc
> > > > +++ b/tools/testing/selftests/nolibc/Makefile.nolibc
> > > > @@ -117,7 +117,7 @@ DEFCONFIG_riscv32    = rv32_defconfig
> > > >  DEFCONFIG_riscv64    = defconfig
> > > >  DEFCONFIG_s390x      = defconfig
> > > >  DEFCONFIG_loongarch  = defconfig
> > > > -DEFCONFIG_sparc32    = sparc32_defconfig
> > > > +DEFCONFIG_sparc32    = sparc64_defconfig
> > >
> > > How can we test sparc32 using a 64-bit kernel?
> >
> > CONFIG_COMPAT=y
> 
> FWIW, testing 32-bit userland on a 64-bit kernel is something completely
> different...

I can't really follow. We are testing the userspace nolibc here and
assume that the kernel component already works correctly. Whether that
is a native 32-bit kernel, 64-bit kernel with CONFIG_COMPAT=y or even
qemu-user-sparc doesn't really matter in my opinion. What am I missing?

> > Please note that this changed in (the now committed) v2 anyways:
> > https://lore.kernel.org/lkml/20260106-nolibc-sparc32-fix-v2-1-7c5cd6b175c2@weissschuh.net/
> 
> Sorry, I hadn't noticed the newer version, as the latter does not
> include some keywords to trigger my interest ;-)

Now I am left wondering about the specific keyword that triggered on v1
but not v2 :-)


Thomas

