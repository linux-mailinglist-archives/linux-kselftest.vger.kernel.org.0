Return-Path: <linux-kselftest+bounces-44619-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E85C28C2F
	for <lists+linux-kselftest@lfdr.de>; Sun, 02 Nov 2025 09:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8719034772C
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Nov 2025 08:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D816C185955;
	Sun,  2 Nov 2025 08:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="BP0VyPMS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB3DFBF0;
	Sun,  2 Nov 2025 08:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762072328; cv=none; b=OJa9KGXKNN7mFtP+aLMU3Z0C6n3vPXuqGAHLmz0TJseOxJoW8Pltn2Y2Od7aeXygmQZtFVGueqMNk4FwE1WBKlE5EJPsz3AJNAfI0KLNTsuwEDedOFhRjlF0i2ntT78eFjr2bp82yf8gb23vnbZL1qlsf2u91q6nHx2oSOGvzV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762072328; c=relaxed/simple;
	bh=vYRhAjA7W3kFR2bLhP8STj6NFfZv6FBHCN3285VI/ME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Su3oZ3J0wCo2PJQ5BMGzmwsStZmxW8kuPk3A5aDylLGiZ0EdLa/di6jX3ztR2OtUGapOu8TDWMTNIAdb69XDeO3B0RPP/zgIcLtlllQ0diPbAhjQEpaYEfktyg6MVEls6AkEvO9SrFi4TeWsbE9V8XNttNkcevEW72rcyR+HN58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=BP0VyPMS; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1762072317; bh=7d4sVGRXexUqmXe9MeRRWMVLjPWgZT8JdLymR2uMzjc=;
	h=From:Message-ID:From;
	b=BP0VyPMSMJhNdPiAQsXXijburGzjHh1cGJ3b7IUjH/LvkJMV8a+8Rr9KEDT5dgF2p
	 NFMqquZ4om1IPgFo6R1Mhhal12a4ssQfHBnCsC3KLcBQ57ZW4aPbyyXREmxrEomTT+
	 rQiRgTcbh/pcTJqHs6EkOPAZsRLCT2Jh8Qv4NHiM=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 2838FC06B5;
	Sun, 02 Nov 2025 09:31:57 +0100 (CET)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 5A28Vu10010876;
	Sun, 2 Nov 2025 09:31:56 +0100
Date: Sun, 2 Nov 2025 09:31:56 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 08/12] tools/nolibc: gettimeofday(): avoid libgcc 64-bit
 divisions
Message-ID: <20251102083156.GA10797@1wt.eu>
References: <20251029-nolibc-uapi-types-v1-0-e79de3b215d8@weissschuh.net>
 <20251029-nolibc-uapi-types-v1-8-e79de3b215d8@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251029-nolibc-uapi-types-v1-8-e79de3b215d8@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Oct 29, 2025 at 05:02:58PM +0100, Thomas Weiﬂschuh wrote:
> timespec::tv_nsec is going to be 64-bit wide even on 32-bit
> architectures. As not all architectures support 64-bit division
> instructions, calls to libgcc (__divdi3()) may be emitted by the
> compiler which are not provided by nolibc.
> 
> As tv_nsec is guaranteed to always fit into an uint32_t, perform a
> 32-bit division instead.
>
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  tools/include/nolibc/sys/time.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/include/nolibc/sys/time.h b/tools/include/nolibc/sys/time.h
> index 33782a19aae9..6dd3705c6c9d 100644
> --- a/tools/include/nolibc/sys/time.h
> +++ b/tools/include/nolibc/sys/time.h
> @@ -33,7 +33,7 @@ int sys_gettimeofday(struct timeval *tv, struct timezone *tz)
>  	ret = sys_clock_gettime(CLOCK_REALTIME, &tp);
>  	if (!ret && tv) {
>  		tv->tv_sec = tp.tv_sec;
> -		tv->tv_usec = tp.tv_nsec / 1000;
> +		tv->tv_usec = (uint32_t)tp.tv_nsec / 1000;
>  	}

Good catch! I'm wondering if this one shouldn't be marked as a build
fix for 5e7392dc82ed ("tools/nolibc: fall back to sys_clock_gettime()
in gettimeofday()") so that it can be backported.

Acked-by: Willy Tarreau <w@1wt.eu>

Willy

