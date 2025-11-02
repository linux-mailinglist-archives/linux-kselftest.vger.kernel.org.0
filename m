Return-Path: <linux-kselftest+bounces-44620-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB382C28C38
	for <lists+linux-kselftest@lfdr.de>; Sun, 02 Nov 2025 09:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81EAD1888EEE
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Nov 2025 08:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C5F21CA03;
	Sun,  2 Nov 2025 08:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="djXQRy/e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4B4FBF0;
	Sun,  2 Nov 2025 08:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762072587; cv=none; b=kr/3w1vTC28iFQne1aF5UFEZbpxMc2yg1LPO3zkELXEHpolpilpqZGNo6HK1U63IbE9n29u9/dm0mCWffCOsdB/SYv6Qn3i61+P6SOTtwI7jml6LG4TCRGCbIA1ebvLVizfEL9B4hydBOQjgZl6SU5wnF5EG/aD35AURokJcBrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762072587; c=relaxed/simple;
	bh=Rr+X/NzFOm/v8MdYUGnNPeXygyjNRjtAZYO6isY3K6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdMALDZZ5W5dykQobvqx/lGHZYrZqQCyXuAcZcyceu8pq+Ix/bngV1EInugJWujlZF/16C40ZGr0rNb/XMSzOYlSc0KXQrMd2B6zDki1pV+rhT3Q4+bZ4pig78sqAj8+cHGydbIVu5tS6WD40viZKxZnEBstbLZUKS3BuCvJbO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=djXQRy/e; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1762072583; bh=Q5W1VXsoZv9svlgKpmsInnazutfNA8fY4+hGgSKHsYQ=;
	h=From:Message-ID:From;
	b=djXQRy/eSPFiaxK+4AhMo3jpcZQFK9PXtW8wag69z4GEIPcolGlaIPhzbgoIYSx7Q
	 wfcIZsdlmCLbJXubmF4Jb/nRcPwpoWqd8uzrKh8lmC8830e7irpg4uUvn77Y/atGZa
	 dG1Q+ZB5hsY5AYt4oEj0O5BvqazdbN64vt29Ggpc=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 3ACCAC06B5;
	Sun, 02 Nov 2025 09:36:23 +0100 (CET)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 5A28aMUZ010896;
	Sun, 2 Nov 2025 09:36:22 +0100
Date: Sun, 2 Nov 2025 09:36:22 +0100
From: Willy Tarreau <w@1wt.eu>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        shuah <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 09/12] tools/nolibc: use a custom struct timespec
Message-ID: <20251102083622.GB10797@1wt.eu>
References: <20251029-nolibc-uapi-types-v1-0-e79de3b215d8@weissschuh.net>
 <20251029-nolibc-uapi-types-v1-9-e79de3b215d8@weissschuh.net>
 <9c8025ad-8c47-470d-89fa-81a19664ba24@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c8025ad-8c47-470d-89fa-81a19664ba24@app.fastmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Oct 30, 2025 at 03:46:21PM +0100, Arnd Bergmann wrote:
> On Wed, Oct 29, 2025, at 17:02, Thomas Weißschuh wrote:
> > 
> > +struct timespec {
> > +	time_t	tv_sec;
> > +	long	tv_nsec;
> > +};
> > +#define _STRUCT_TIMESPEC
> > +
> > +#include <linux/time.h>
> 
> Unfortunately this is not the definition we want on big-endian
> systems because it puts the tv_nsec field in the wrong place.

Indeed!

> You can either uses the simple (non-POSIX) __kernel_timespec
> definition in nolibc with a 64-bit tv_nsec, or copy the more
> complicated definition with explicit padding that is used
> in musl and glibc.

I think that switching this patch and the next one (10/12) would
just do the trick since both fields will become __kernel_time64_t.
Or maybe the two should be squashed into a single one.

Willy

