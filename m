Return-Path: <linux-kselftest+bounces-42785-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEC8BBF293
	for <lists+linux-kselftest@lfdr.de>; Mon, 06 Oct 2025 22:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F35873C2415
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Oct 2025 20:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DF72550A3;
	Mon,  6 Oct 2025 20:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="c5in1Zd8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7D9846F;
	Mon,  6 Oct 2025 20:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759781678; cv=none; b=h8ZyelD2fZlzyIZBIQkBYm0F0S1gJl4UEk02CLfCdSt9Po2+g4S1x/dnJi6VH4SACkOgqEW6HL/ji0/u4bSCcuz19DlDUA8HTxswMkc7BKQIPpAXaCHug+S1v1fyvSOlQJQSxQzVd13uvDnxSLW9Yaq7QWZTu1N1r/IueOWKsZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759781678; c=relaxed/simple;
	bh=F5heTDPpPUVfFqxG9wFJpQt7FRekFZPQJlePM3gnxM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAm/U6Y8R36wOuCf9oovTptpkVDgxrjaV5pAkwCIGTAjDpz/t0ftoygFyWssMbrhINGhx4PyD9QZ7YmlfGNUCgkXT1RMvC6GEylcnIb0j7ctspDTAE8P1KhRvoIzIzlJCS3KJotn5AhvblN6FJgjPy42p4RpuDPB62/3r0oeAqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=c5in1Zd8; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1759781667;
	bh=F5heTDPpPUVfFqxG9wFJpQt7FRekFZPQJlePM3gnxM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c5in1Zd8DM9zu63rG4XY1fj3D4E6ogskNSKalmeS+IYtBLIroj27+jpxHsvFB0n1G
	 GBiEn/C5awdao2/uOFQK8Uxaf9FQoxd9AGQDfifeDzBfwGH+IPUpQNhwxW4Eq8dcxa
	 aW4iEVbog+p58dSYFueEruX6Z39fAZc6ChEzSmvM=
Date: Mon, 6 Oct 2025 22:14:26 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Willy Tarreau <w@1wt.eu>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, shuah <shuah@kernel.org>, Mark Brown <broonie@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/7] tools/nolibc: remove __nolibc_enosys() fallback from
 time64-related functions
Message-ID: <a5b8344e-8214-4946-8344-f34e969d30b2@t-8ch.de>
References: <20250821-nolibc-enosys-v1-0-4b63f2caaa89@weissschuh.net>
 <20250821-nolibc-enosys-v1-1-4b63f2caaa89@weissschuh.net>
 <cec27d94-c99d-4c57-9a12-275ea663dda8@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cec27d94-c99d-4c57-9a12-275ea663dda8@app.fastmail.com>

Hi Arnd,

On 2025-10-01 09:43:37+0200, Arnd Bergmann wrote:
> On Thu, Aug 21, 2025, at 17:40, Thomas Weißschuh wrote:
> > These fallbacks where added when no explicit fallbacks for time64 was
> > implemented. Now that these fallbacks are in place, the additional
> > fallback to __nolibc_enosys() is superfluous.
> >
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> 
> I just saw these fly by as they made it into mainline and
> I noticed that there is still something wrong here:
> 
> > @@ -39,10 +39,8 @@ int sys_poll(struct pollfd *fds, int nfds, int 
> > timeout)
> >  		t.tv_nsec = (timeout % 1000) * 1000000;
> >  	}
> >  	return my_syscall5(__NR_ppoll_time64, fds, nfds, (timeout >= 0) ? &t 
> > : NULL, NULL, 0);
> > -#elif defined(__NR_poll)
> > -	return my_syscall3(__NR_poll, fds, nfds, timeout);
> >  #else
> > -	return __nolibc_enosys(__func__, fds, nfds, timeout);
> > +	return my_syscall3(__NR_poll, fds, nfds, timeout);
> >  #endif
> >  }
> 
> The change is fine, as there is always at least one of the
> time64 or the old syscalls implemented, for any of the affected
> calls.
> 
> However, the problem here is the default to the old time
> types on 32-bit targets, for two reasons:
> 
>  - this fails when turning off CONFIG_COMPAT_32BIT_TIME

Good point.

>  - the old types are often too short, both for the y2038
>    overflow and for the file system types.

So far this was not something we actively tried to support,
especially with the restriction mentioned below.

> I suspect the problem is that the kernel's uapi/linux/time.h
> still defines the old types as the default, and nolibc
> historically just picks it up from there.

So far we have tried to keep nolibc compatible with the kernel UAPI when
included in any order. This forced us to use 'struct timespec' from
uapi/linux/time.h. With the upcoming implementation of signals in nolibc
this guideline is relaxed a bit, so we should be able to use our own
always-64-bit 'struct timespec'.

> The proper solution I think would be to do the same thing
> that klibc has and use sane defaults for all the types
> along with the modern syscalls. At least __kernel_time_t,
> __kernel_timespec, __kernel_ino_t, __kernel_loff_t and
> probably a few more.

Thanks for the pointers and ack to all of them.
I'll take a look at those.

> We should also consider drop the
> legacy type definitions from uapi/linux/time.h and
> require each libc to define their own.

Can we even just drop them? Or should they also get some backwards
compat guards?


Thomas

