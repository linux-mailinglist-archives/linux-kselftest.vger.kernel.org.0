Return-Path: <linux-kselftest+bounces-44626-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74954C28CDC
	for <lists+linux-kselftest@lfdr.de>; Sun, 02 Nov 2025 10:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05C601892585
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Nov 2025 09:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324551E47A5;
	Sun,  2 Nov 2025 09:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="YdpQeWWe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914D926B755;
	Sun,  2 Nov 2025 09:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762077052; cv=none; b=sXmSExKFOj6B/Cm7q+jy1b2mGlQnlFFteQt841oocruCNe+rV42X4/vo5qKpyAkUuhdxiYcBpzoWiZ/6RyfFk6yCarMEQgWAHMs5ybMH9eYYkztTbqD1rb41fI773/4scRgSawlakH86IIJEOjf2ubC4DXUrAsc6RKv6B1BF7Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762077052; c=relaxed/simple;
	bh=V3nXyyTs8N411vFI1A807MWD5H0OwEqeMrp3UVg39p8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZAGMp+i0Xk9pjE2Uw2hKUnIr6zlja6lqB/Kj2daDDuK15t5kzwInMnyoB5xZ5EW8+e3JZuLUK7DdjyerpyM9xxWnRSqdjuF2XtMtg9E3LWASU7uC3PLIoX7AAY3nyNSXG8VEJA66zmGisVPtsTLa0IWRUSUpNrkHQILDdGYe/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=YdpQeWWe; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1762077047; bh=7r1h4wxsovtzE4D7OcOKGx3p/Y2glZ+izQ3w5Q6w1fE=;
	h=From:Message-ID:From;
	b=YdpQeWWeLc2wSca5lz3SmOJPRrIHTWmIQV1eslbXBl8++ervOJAQNZo6GKnoXRspG
	 nQOUIwEYk+eaQgPPduOKbSmMYfC1Kp92eytcqqCiowBcQTuA0KpxBc1u5fTeBEi5B6
	 A4JKZOUq1wCP+DeeVcKwFJhNZUAxHon+qkl013qI=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id D91F3C06EE;
	Sun, 02 Nov 2025 10:50:47 +0100 (CET)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 5A29olUw018069;
	Sun, 2 Nov 2025 10:50:47 +0100
Date: Sun, 2 Nov 2025 10:50:47 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Arnd Bergmann <arnd@arndb.de>, shuah <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 09/12] tools/nolibc: use a custom struct timespec
Message-ID: <20251102095047.GC26041@1wt.eu>
References: <20251029-nolibc-uapi-types-v1-0-e79de3b215d8@weissschuh.net>
 <20251029-nolibc-uapi-types-v1-9-e79de3b215d8@weissschuh.net>
 <9c8025ad-8c47-470d-89fa-81a19664ba24@app.fastmail.com>
 <20251102083622.GB10797@1wt.eu>
 <0b3e7de4-32b8-44ae-b03a-ec176f45a1c5@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b3e7de4-32b8-44ae-b03a-ec176f45a1c5@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sun, Nov 02, 2025 at 10:41:39AM +0100, Thomas Weißschuh wrote:
> On 2025-11-02 09:36:22+0100, Willy Tarreau wrote:
> > On Thu, Oct 30, 2025 at 03:46:21PM +0100, Arnd Bergmann wrote:
> > > On Wed, Oct 29, 2025, at 17:02, Thomas Weißschuh wrote:
> > > > 
> > > > +struct timespec {
> > > > +	time_t	tv_sec;
> > > > +	long	tv_nsec;
> > > > +};
> > > > +#define _STRUCT_TIMESPEC
> > > > +
> > > > +#include <linux/time.h>
> > > 
> > > Unfortunately this is not the definition we want on big-endian
> > > systems because it puts the tv_nsec field in the wrong place.
> > 
> > Indeed!
> > 
> > > You can either uses the simple (non-POSIX) __kernel_timespec
> > > definition in nolibc with a 64-bit tv_nsec, or copy the more
> > > complicated definition with explicit padding that is used
> > > in musl and glibc.
> > 
> > I think that switching this patch and the next one (10/12) would
> > just do the trick since both fields will become __kernel_time64_t.
> > Or maybe the two should be squashed into a single one.
> 
> Maybe I can make it clearer that this patch does not change anything.
> This custom definition of 'struct timespec' is the same as the one we
> got from linux/time.h before. This is just a preparation for the next
> commit. Merging would also work, but it will be a bit messy to look at.

Yes a slightly improved description in the patch wouldn't hurt. Since
we were two to get caught, it will definitely happen in the future when
people read commits.

Thanks!
Willy

