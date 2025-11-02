Return-Path: <linux-kselftest+bounces-44623-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53238C28C88
	for <lists+linux-kselftest@lfdr.de>; Sun, 02 Nov 2025 10:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 776FA3A6749
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Nov 2025 09:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764C823B609;
	Sun,  2 Nov 2025 09:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Xk1tG+uS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E851D5AD4;
	Sun,  2 Nov 2025 09:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762075649; cv=none; b=GYip4G2gAO5C7RElm+1LskB0gWhDuInluTv6SNeA1EPukjXJBt9+U/PAYpq9vroFi0Q9f6m4J6fFAu7ZLKP8/sZDkqQf/PQPaKB/BNwwD0Fc+B+bG3Dzwt1WDTTAA/40Na/M6/BWtKozdrV3a/qs/xLvYbsloHETLqyWjabK+JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762075649; c=relaxed/simple;
	bh=5/t+u6S0RZ/ZdbJcm2QPTjj6ZhGQkT3awnqRJK/joV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fx/ojNlVBva8seNYXA3dmkLYJ9LgODoaQNqJdqQOyfD1ZNcxt6eOimSBWE6/TXtmQ2/kYVkk+fXb86DCgTrBIr2BGtQ1JXPjW2+WkXryaeyqZGHfyaLxrY0znN2KaUWVEvALwtHo5j7+8FN+qTYIOcCebl7jmQ8QLee9QXqbXVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Xk1tG+uS; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1762075639;
	bh=5/t+u6S0RZ/ZdbJcm2QPTjj6ZhGQkT3awnqRJK/joV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xk1tG+uSMRvZ/axB/v133dvvklZvX0G3rHCsVwpxez5Outoy4SekkTOjQYPZc+NTJ
	 nOC9ENFRgqLfmZC56UrLoDWhznYzbE/3gFuKvqkVX+6H1kXUUaqFLJfVNSJhkRKxi7
	 p6mshOQCosumnTk+ZTgixhW25f2ZgIhT0/LYTCSo=
Date: Sun, 2 Nov 2025 10:27:18 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 08/12] tools/nolibc: gettimeofday(): avoid libgcc 64-bit
 divisions
Message-ID: <69c383ef-0d05-4f9a-bdd1-85dbf3d0100b@t-8ch.de>
References: <20251029-nolibc-uapi-types-v1-0-e79de3b215d8@weissschuh.net>
 <20251029-nolibc-uapi-types-v1-8-e79de3b215d8@weissschuh.net>
 <20251102083156.GA10797@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251102083156.GA10797@1wt.eu>

On 2025-11-02 09:31:56+0100, Willy Tarreau wrote:
> On Wed, Oct 29, 2025 at 05:02:58PM +0100, Thomas Weißschuh wrote:
> > timespec::tv_nsec is going to be 64-bit wide even on 32-bit
> > architectures. As not all architectures support 64-bit division
> > instructions, calls to libgcc (__divdi3()) may be emitted by the
> > compiler which are not provided by nolibc.
> > 
> > As tv_nsec is guaranteed to always fit into an uint32_t, perform a
> > 32-bit division instead.
> >
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >  tools/include/nolibc/sys/time.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/include/nolibc/sys/time.h b/tools/include/nolibc/sys/time.h
> > index 33782a19aae9..6dd3705c6c9d 100644
> > --- a/tools/include/nolibc/sys/time.h
> > +++ b/tools/include/nolibc/sys/time.h
> > @@ -33,7 +33,7 @@ int sys_gettimeofday(struct timeval *tv, struct timezone *tz)
> >  	ret = sys_clock_gettime(CLOCK_REALTIME, &tp);
> >  	if (!ret && tv) {
> >  		tv->tv_sec = tp.tv_sec;
> > -		tv->tv_usec = tp.tv_nsec / 1000;
> > +		tv->tv_usec = (uint32_t)tp.tv_nsec / 1000;
> >  	}
> 
> Good catch! I'm wondering if this one shouldn't be marked as a build
> fix for 5e7392dc82ed ("tools/nolibc: fall back to sys_clock_gettime()
> in gettimeofday()") so that it can be backported.

Right now timespec::tv_nsec is of type 'long', so it should only be
64-bits on architectures which have native 64-bit division instructions. 
But marking it as fix shouldn't hurt either.


Thomas

