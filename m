Return-Path: <linux-kselftest+bounces-44624-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B9139C28C9D
	for <lists+linux-kselftest@lfdr.de>; Sun, 02 Nov 2025 10:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1A5DF347343
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Nov 2025 09:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF5C26A1C4;
	Sun,  2 Nov 2025 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Y+hRRYup"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33661F03D7;
	Sun,  2 Nov 2025 09:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762076506; cv=none; b=N+YAee10NdGiISkYxmJRCPATTdnS8FbAQRvT8VAhyZqlLGiPhnE4gnSybs1cBu9PuN48+dUgUrDIpF0t6+d4+VRAQbAdBOd3mInNSxH2jfmGwh/Bu7qPVwFZJqYkzmHHvC91QsiTQ+IjWu0ResoTegK1bXSXC8BvIjIdZMwBwRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762076506; c=relaxed/simple;
	bh=hZ30LMpniN8N+2bb7dIk/wUwQ1dChwP4bircMV+nv3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPMHEXj/gAleAmPIGgyoYv5YajhTyEiCLCYqtwU+RtvdFCfEVotbGcJa35UqJnUtuvJXqHFFXVZANrUNNbgmsLyuw8bnki86ULWeFAm/JD/vpVtukxSky1RGGEJVTLAzFJ2IJPsdVFsjWKxwxzvMSMczFtAHtIdtYI/6dnUYlUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Y+hRRYup; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1762076501;
	bh=hZ30LMpniN8N+2bb7dIk/wUwQ1dChwP4bircMV+nv3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y+hRRYup70Jf4oIIcuh8EXt7+bub+8rYNJ4Q78O8dzpomMHQkyajReuMFrkLJKXXG
	 0TirA5wFdzL+zZodUAHKu9NX56CT6Ps8S7zG0lgsDW0s5q9W+WpvUJgE1cJzcaZqy7
	 KZYGORR8fMTeAZhWm+soUK/6hEr5R7AQX8H3ZUZY=
Date: Sun, 2 Nov 2025 10:41:39 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Arnd Bergmann <arnd@arndb.de>, shuah <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 09/12] tools/nolibc: use a custom struct timespec
Message-ID: <0b3e7de4-32b8-44ae-b03a-ec176f45a1c5@t-8ch.de>
References: <20251029-nolibc-uapi-types-v1-0-e79de3b215d8@weissschuh.net>
 <20251029-nolibc-uapi-types-v1-9-e79de3b215d8@weissschuh.net>
 <9c8025ad-8c47-470d-89fa-81a19664ba24@app.fastmail.com>
 <20251102083622.GB10797@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251102083622.GB10797@1wt.eu>

On 2025-11-02 09:36:22+0100, Willy Tarreau wrote:
> On Thu, Oct 30, 2025 at 03:46:21PM +0100, Arnd Bergmann wrote:
> > On Wed, Oct 29, 2025, at 17:02, Thomas Weißschuh wrote:
> > > 
> > > +struct timespec {
> > > +	time_t	tv_sec;
> > > +	long	tv_nsec;
> > > +};
> > > +#define _STRUCT_TIMESPEC
> > > +
> > > +#include <linux/time.h>
> > 
> > Unfortunately this is not the definition we want on big-endian
> > systems because it puts the tv_nsec field in the wrong place.
> 
> Indeed!
> 
> > You can either uses the simple (non-POSIX) __kernel_timespec
> > definition in nolibc with a 64-bit tv_nsec, or copy the more
> > complicated definition with explicit padding that is used
> > in musl and glibc.
> 
> I think that switching this patch and the next one (10/12) would
> just do the trick since both fields will become __kernel_time64_t.
> Or maybe the two should be squashed into a single one.

Maybe I can make it clearer that this patch does not change anything.
This custom definition of 'struct timespec' is the same as the one we
got from linux/time.h before. This is just a preparation for the next
commit. Merging would also work, but it will be a bit messy to look at.


Thomas

