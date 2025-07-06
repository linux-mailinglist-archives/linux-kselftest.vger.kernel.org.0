Return-Path: <linux-kselftest+bounces-36650-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A380AFA3BC
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Jul 2025 10:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A4531899251
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Jul 2025 08:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E15C1E0B86;
	Sun,  6 Jul 2025 08:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="gBszkqQ8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF79254652;
	Sun,  6 Jul 2025 08:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751791488; cv=none; b=MU2SFjamkRJrS7+JHoibkc63phR/WlD7manvDhTpYCvauwpzBnWH63UTxcFE2ZZJTciAfTbklvl0IjjKwgcLJ6xBzoeuJ0LtxiyZKe1IIo2EvnEe9Z/zQVvnLp+GfOHZArUbGJIqJlIyo31Pxsyt35Iq/ClKK2X4qU8da6lCuM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751791488; c=relaxed/simple;
	bh=SrfvA4klo4zj6WDJudJ9E6sL8ZfUxBmkAFhJ20dj/u0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rd0r41l5NY2rBOGKYY3B15WGinoMvUY0dnyUMUln863ivR0gpsdbWM0MFvX78J4zoZnxz2Ntef4AUxz+0UTjncdVH+9oWyoVoVyt3p9UJYA08paJV2qqtOYXUwlesXmB36AfjcfWVlbkzixWmW/lt19Sn7Ii0tNSvFbdNTTgZgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=gBszkqQ8; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1751791483;
	bh=SrfvA4klo4zj6WDJudJ9E6sL8ZfUxBmkAFhJ20dj/u0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gBszkqQ8mVuleOeCdaBkeTcMfoHC7tvlv9FbPL92ih7XflO2PEC4ZXlwoxslRdvEa
	 z6r/DNyy3Ts/woXH7TCFYi4QJKcPeVTFg0qK3mxXgPEDdJo5CO7dASzGmShCePJIk0
	 64/Nf7+K1cuTwYdt6H8MB6w/XRJexjMa63ycBbGw=
Date: Sun, 6 Jul 2025 10:44:42 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: add support for clock_nanosleep() and
 nanosleep()
Message-ID: <a8cf1929-e663-468d-a842-a1a4f4a3b2fe@t-8ch.de>
References: <20250704-nolibc-nanosleep-v1-1-d79c19701952@linutronix.de>
 <20250706062633.GB29601@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250706062633.GB29601@1wt.eu>

On 2025-07-06 08:26:33+0200, Willy Tarreau wrote:
> On Fri, Jul 04, 2025 at 04:19:48PM +0200, Thomas Weißschuh wrote:
> > +static __attribute__((unused))
> > +int sys_clock_nanosleep(clockid_t clockid, int flags, const struct timespec *rqtp,
> > +			struct timespec *rmtp)
> > +{
> > +#if defined(__NR_clock_nanosleep)
> > +	return my_syscall4(__NR_clock_nanosleep, clockid, flags, rqtp, rmtp);
> > +#elif defined(__NR_clock_nanosleep_time64)
> > +	struct __kernel_timespec krqtp, krmtp;
> > +	int ret;
> > +
> > +	__nolibc_timespec_user_to_kernel(rqtp, &krqtp);
> > +	ret = my_syscall4(__NR_clock_nanosleep_time64, clockid, flags, &krqtp, &krmtp);
> > +	if (rmtp)
> > +		__nolibc_timespec_kernel_to_user(&krmtp, rmtp);
> > +	return ret;
> > +#else
> > +	return __nolibc_enosys(__func__, clockid, flags, rqtp, rmtp);
> > +#endif
> 
> I don't know which archs do not have clock_nanosleep, but if it becomes
> needed on some of them, we could probably fall back to pslelect() if
> available, of course, and ignore the clockid.

No architecture should ever run into the #else.
It is mostly for completeness and consistency with other architectures.
As for falling back to pselect(), the clockid is indeed important :-)

> Acked-by: Willy Tarreau <w@1wt.eu>

Thanks!

