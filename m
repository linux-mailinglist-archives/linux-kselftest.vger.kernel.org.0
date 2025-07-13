Return-Path: <linux-kselftest+bounces-37207-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 868D0B031E1
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Jul 2025 17:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3F3917C018
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Jul 2025 15:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B34627877D;
	Sun, 13 Jul 2025 15:50:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713A327454
	for <linux-kselftest@vger.kernel.org>; Sun, 13 Jul 2025 15:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752421809; cv=none; b=UN4uSRtAKWKeLbaJ8x3w6meHM5CtqC6kaetYJ2/qqJy3Jeepod1ML+mdm8zFbDBO00QTdiNbKf9CgVlZa7im3VlAe3KvnITSO+7cRYIEur3rIv/jpbo8Q5S8Gmvkjld+OSdoMgqtQXJY1TjlnPVMMpv304GSsMD4/DoHP2QJ+4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752421809; c=relaxed/simple;
	bh=5lQcMsfrXkU3pxpWfl7aN/K/oH/hf8huIh+0U8cF6pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZV6Jqci0bbglXnUWdCakrFHoCz+gyLpc6Hx8TJCNhcO6d6zecf3sZXlY7SPCTIvvlqdM760fHRiSvV/oFljO8vFrkewT/ct/QJOT3480OAa//8W4WtiONMLewsxcPIiH6+GrRQiYzcloRJFKsbajwCKCeuVYD+f0DiPKyKK4AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 56DFo2vt025900;
	Sun, 13 Jul 2025 17:50:02 +0200
Date: Sun, 13 Jul 2025 17:50:02 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Benjamin Berg <benjamin@sipsolutions.net>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 4/4] tools/nolibc: add signal support
Message-ID: <20250713155002.GA25876@1wt.eu>
References: <20250710103950.1272379-1-benjamin@sipsolutions.net>
 <20250710103950.1272379-5-benjamin@sipsolutions.net>
 <f72ddf71-40e4-49d0-92b6-da219e33bd29@t-8ch.de>
 <b1c3684e1e299f787a88c58a063ab4d0485a59a7.camel@sipsolutions.net>
 <3f901ecb-d6d1-4fb4-9159-a6b817b0dd39@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f901ecb-d6d1-4fb4-9159-a6b817b0dd39@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sun, Jul 13, 2025 at 05:02:27PM +0200, Thomas Weißschuh wrote:
> On 2025-07-11 09:25:26+0200, Benjamin Berg wrote:
> > On Fri, 2025-07-11 at 07:40 +0200, Thomas Weißschuh wrote:
> > > On 2025-07-10 12:39:50+0200, Benjamin Berg wrote:
> > > > From: Benjamin Berg <benjamin.berg@intel.com>
> > > > 
> > > > Add support for sigaction() and implement the normal sa_mask helpers.
> > > > 
> > > > On many architectures, linux/signal.h pulls in compatibility
> > > > definitions
> > > > for the old sigaction syscall instead of rt_sigaction. However, the
> > > > kernel can be compiled without support for this compatibility
> > > > syscall
> > > > and it also results in sa_mask to be too small for realtime
> > > > signals.
> > > > 
> > > > To work around this, the includes are handled separately for each
> > > > architecture. This way either linux/signal.h or the asm-generic
> > > > headers
> > > > can be used to get the correct definition for the rt_sigaction
> > > > syscall
> > > > including sigset_t.
> > > 
> > > I checked this against my WIP alpha support and there this scheme
> > > breaks. linux/signal.h provides the old compat types but
> > > the asm-generic variant provides an incorrect SIGCHLD.
> > > 
> > > Any ideas?
> > 
> > I had a quick look, and I don't have a good idea really. For sparc
> > there was at least a #define that permitted to get the correct version.
> > But here, there is nothing.
> > 
> > Probably the best is to just copy in a modified version of signal.h
> > with the correct definitions present. i.e. replace the "ifndef
> > __KERNEL__" sections with something reasonable.
> 
> But then we can just have our own copy for every architecture, no?
> To me that looks like the best solution right now.

I generally agree. Originally in nolibc, lots of stuff was copied and
we only used very little of UAPI. As new architectures were supported,
we took this opportunity for cleaning this up and relying more on UAPI,
but that doesn't mean we need to get rid of our local definitions all
the time, so if that helps, yeah clearly we can have our local copies
and definitions.

Cheers,
Willy

