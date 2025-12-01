Return-Path: <linux-kselftest+bounces-46795-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4030FC96ADB
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 11:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34C1D4E0F7C
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 10:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7E2303A00;
	Mon,  1 Dec 2025 10:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="q/6B0RMA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063CC30215C;
	Mon,  1 Dec 2025 10:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764585312; cv=none; b=Ba+oQPbfPOX4mhsLZPJTkC5pJ5MiXUVSNyVT3a1B3LjoKvf5lWsIRnGRzsJN2q2kTMa+ktWjKvQOEUNzGlgqqkaOYTgppsx1DQFg4J6Gr7WMF6J5p2HKv93p8smKPjM/OzHu/a0OjL+ELGA3nY71hrJ/DxSQbWBeGx1ACIShluo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764585312; c=relaxed/simple;
	bh=hOlqDdp8O4Se3D3EvXm7kD3K1oIdyZimjI5ZlhY1fhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8KJcHXPG+XP43t0VU6M2auOPGa2SKdAlkQSNVbsYZLS+EuW1w1rUEQ1Y1d32cT/HN7dIwwCOcRYptyUWIxAnIURFQYNXkwM9Pc1zUlVZjJi6/2rSklTsHkQiGeZkFn8dNMhjq130yekGFDekS7oWEGxCsxtQ1aQB2sn38eUT0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=q/6B0RMA; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1764585305; bh=ZgvYeW4VV1AyuJ27SBnPuj5hdWOI341nSp1FS2WLePE=;
	h=From:Message-ID:From;
	b=q/6B0RMAPNEBzaH6EdL9TkGr/V6hwjlPQsfRQLrldN8LkzBB+xiMgARBPgwQjsFRm
	 a6qMjwI7s9e2R/g3wMi77lHpHfCovP4Uik8L0gYyOJCMTX6QFM3rZCRSPqxoZ9Wsp/
	 kVFfqmEO9tApG3HOKATxvzVyubKszpDEHLQwJbro=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 8A9E5C0847;
	Mon, 01 Dec 2025 11:35:05 +0100 (CET)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 5B1AZ59q023881;
	Mon, 1 Dec 2025 11:35:05 +0100
Date: Mon, 1 Dec 2025 11:35:05 +0100
From: Willy Tarreau <w@1wt.eu>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        shuah <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 09/13] tools/nolibc: always use 64-bit time types
Message-ID: <20251201103505.GA23859@1wt.eu>
References: <20251122-nolibc-uapi-types-v2-0-b814a43654f5@weissschuh.net>
 <20251122-nolibc-uapi-types-v2-9-b814a43654f5@weissschuh.net>
 <20251130105842.GD31522@1wt.eu>
 <75e632e3-3353-414d-9b8a-8bf9ca46b5a4@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75e632e3-3353-414d-9b8a-8bf9ca46b5a4@app.fastmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Arnd,

On Mon, Dec 01, 2025 at 08:45:00AM +0100, Arnd Bergmann wrote:
> On Sun, Nov 30, 2025, at 11:58, Willy Tarreau wrote:
> > On Sat, Nov 22, 2025 at 05:59:15PM +0100, Thomas Weißschuh wrote:
> 
> >>  struct timespec {
> >> -	__kernel_old_time_t	tv_sec;
> >> -	long			tv_nsec;
> >> +	time_t	tv_sec;
> >> +	int64_t	tv_nsec;
> >>  };
> >>  #define _STRUCT_TIMESPEC
> >>  
> >> +/* Never use with system calls */
> >>  struct timeval {
> >> -	__kernel_old_time_t	tv_sec;
> >> -	__kernel_suseconds_t	tv_usec;
> >> +	time_t	tv_sec;
> >> +	int64_t	tv_usec;
> >>  };
> >
> > It seems to me that glibc continues to make the effort of using a long
> > for tv_usec and tv_nsec. At least I'm seeing how that can make a
> > difference for application code given that these fields are constantly
> > multiplied or divided, forcing them to 64-bit when we know they'll never
> > be larger than 1 billion is extra burden for the application. Another
> > reason might be that the definition really changed from long to suseconds_t
> > in timeval a while ago, it's possible that it's used as a long in various
> > APIs (or even just printf formats).
> >
> > IMHO it would be cleaner to keep it as a long here, or do you have a
> > particular reason for wanting int64_t (which BTW already forced a cast
> > in sys_gettimeofday()) ?
> 
> As far as I can tell, it's the other way round for suseconds_t,
> which in glibc is defined as
> 
> #if __TIMESIZE == 64 && __WORDSIZE == 32
> # define __TIME_T_TYPE          __SQUAD_TYPE
> # define __SUSECONDS_T_TYPE     __SQUAD_TYPE
> #else
> # define __TIME_T_TYPE          __SLONGWORD_TYPE
> # define __SUSECONDS_T_TYPE     __SLONGWORD_TYPE
> #endif
> 
> so this one is explicitly the same width as tv_sec, which has all
> the issues you listed, but avoids the need for padding.

Ah we seem to just have checked different versions then,
as in mine there was still some extra padding left depending
on the endianness :-)

> As far as I remember, the one reason for having a 'long tv_nsec'
> with complex padding in glibc and musl is that this is actually
> required by both Unix[1] and C11/C11 [2] standards.

That's what I found as well and was my initial compatibility
concern (e.g. referencing &tv->tv_nsec as a long).

> C23 has updated the definition and does allow int64_t tv_nsec.

So it purposely breaks existing apps or does it apply only to those
compiled with -mstd=c23 ?

> I think it makes sense for nolibc to just follow the kernel's
> definition here.

Given the very narrow range of existing code that can be impacted,
I'm fine, but in general I try to remain extremely cautious about
portability: as a general rule, ifdefs needed to address possible
incompatibilities, if any, should rather be in the libc code itself
and not in the user application. I just ran a quick check and don't
have code using &tv_usec nor &tv_nsec so here the risk remains quite
low.

Thanks,
Willy

