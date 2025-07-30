Return-Path: <linux-kselftest+bounces-38080-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BE1B15F0B
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Jul 2025 13:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C22383B3792
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Jul 2025 11:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BDA29A300;
	Wed, 30 Jul 2025 11:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="YZwzA9gH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE56294A1C;
	Wed, 30 Jul 2025 11:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753873551; cv=none; b=ktqykuy9Mne8AzJ9t8egOOxk0cYLj7s97SWmHfKjeR/KpS8CnDnd3ksBKxh+8bmvMhsCBd753o/mJXozlmxGFoWLOGzz23UY+sMIMRraXGY+DzPgB/HvYVxn6i7hGEnrRhl+frwF6B4/dJvykGnKkpo0EKiID9kgewM4rnNJ3pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753873551; c=relaxed/simple;
	bh=gN/rgofoovU80nYhL5B9i6uDmcuQm71jhYXUwm0kwqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgaYYjp2w+U4DKW4fRCaa/0omgZG5q9x6C6NUaG+Xldwxxf7/lFMt+vuovIW6fgOflApiwPrs1NV2l28jc5RZG4ktPkBXHciyfFAE+n1cnsclrrxsTMRFZnmnOmZcSHKWKaTAPhuyAc1OTZVot6zD5D7GUbqjn5AlllYoqQMvE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=YZwzA9gH; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=0k4CeBRPRQzj6qo4MD4PdQtTm2NxuKCF0igS9Zlaies=; b=YZwzA9gHquDHe/JgfBHz7fTwK9
	+cFmCvuZ8zjF1dviirVbEDhRCXrSOu+hZxA3AjJ5pH1uyd2NPsII5jdfgCm5MM8AG3VnhaKj5oj5u
	qaj0EU9hAzfA+OJkg7uCdcDzbL/7FhxhTLmLUcYp/LE9uc/ZKbBRoDyFUctY7iCedYaWLAHNiwuM+
	PbznVMavEs57qFWdnffOE+/6wSNJfdx75yty4eYR7bkzNSGOFqn5uH/YX1awZ3RE6K7DZqjTBJO1p
	wAx5TnRnmTiGjQfbxYUKFQhCbFeLdxWFbfCN576tfT+VGKdmomeO8go/GkJOIcRbzdATpaeFp9QMP
	w1lEFOnw==;
Received: from 179-125-70-183-dinamico.pombonet.net.br ([179.125.70.183] helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uh4ct-005tWS-CE; Wed, 30 Jul 2025 13:05:39 +0200
Date: Wed, 30 Jul 2025 08:05:32 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dirk VanDerMerwe <dirk.vandermerwe@sophos.com>,
	Vimal Agrawal <vimal.agrawal@sophos.com>,
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	KUnit Development <kunit-dev@googlegroups.com>
Subject: Re: [PATCH v5] char: misc: add test cases
Message-ID: <aIn8fDpGz7MCACQ3@quatroqueijos.cascardo.eti.br>
References: <20250612-misc-dynrange-v5-1-6f35048f7273@igalia.com>
 <CAMuHMdVxTW-6Wpw6qDc_ZoSE-f21WvJ478j+0jQURL+SiM_n7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVxTW-6Wpw6qDc_ZoSE-f21WvJ478j+0jQURL+SiM_n7A@mail.gmail.com>

On Wed, Jul 30, 2025 at 09:08:57AM +0200, Geert Uytterhoeven wrote:
> Hi Thadeu,,
> 
> On Sun, 15 Jun 2025 at 23:31, Thadeu Lima de Souza Cascardo
> <cascardo@igalia.com> wrote:
> >
> > Add test cases for static and dynamic minor number allocation and
> > deallocation.
> >
> > While at it, improve description and test suite name.
> >
> > Some of the cases include:
> >
> > - that static and dynamic allocation reserved the expected minors.
> >
> > - that registering duplicate minors or duplicate names will fail.
> >
> > - that failing to create a sysfs file (due to duplicate names) will
> >   deallocate the dynamic minor correctly.
> >
> > - that dynamic allocation does not allocate a minor number in the static
> >   range.
> >
> > - that there are no collisions when mixing dynamic and static allocations.
> >
> > - that opening devices with various minor device numbers work.
> >
> > - that registering a static number in the dynamic range won't conflict with
> >   a dynamic allocation.
> >
> > This last test verifies the bug fixed by commit 6d04d2b554b1 ("misc:
> > misc_minor_alloc to use ida for all dynamic/misc dynamic minors") has not
> > regressed.
> >
> > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> 
> Thanks for your patch, which is now commit 74d8361be3441dff ("char:
> misc: add test cases") in linus/master stable/master
> 
> > Changes in v5:
> > - Make miscdevice unit test built-in only
> > - Make unit test require CONFIG_KUNIT=y
> 
> Why were these changes made? This means the test is no longer available
> if KUNIT=m, and I can no longer just load the module when I want to
> run the test.
> 

These were made because a bug was found that devices with minor > 255 could
not be opened. So I added a test for that, which used __init functions, so
the test now had to be built-in. The alternative is to make these functions
not __init anymore and export them. Those functions are init_mknod and
init_unlink.

I will see if I can cook an RFC later today.

Cascardo.

> > - Link to v4: https://lore.kernel.org/r/20250423-misc-dynrange-v4-0-133b5ae4ca18@igalia.com
> 
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -2506,8 +2506,8 @@ config TEST_IDA
> >         tristate "Perform selftest on IDA functions"
> >
> >  config TEST_MISC_MINOR
> > -       tristate "miscdevice KUnit test" if !KUNIT_ALL_TESTS
> > -       depends on KUNIT
> > +       bool "miscdevice KUnit test" if !KUNIT_ALL_TESTS
> > +       depends on KUNIT=y
> >         default KUNIT_ALL_TESTS
> >         help
> >           Kunit test for miscdevice API, specially its behavior in respect to
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

