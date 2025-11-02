Return-Path: <linux-kselftest+bounces-44621-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D567FC28C3B
	for <lists+linux-kselftest@lfdr.de>; Sun, 02 Nov 2025 09:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8876E3AF750
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Nov 2025 08:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462B8261388;
	Sun,  2 Nov 2025 08:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="jkcXSI0t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F38718A6DB;
	Sun,  2 Nov 2025 08:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762072844; cv=none; b=o/2sfEEdRJ1K1BVuTx3r2SL9DbwZQaseXs9A47O+V5SilITRuPk3P/i4YsqUeROcbB/nGiFjR8ZBmeys3yI1kj3i67SlRotQ9aOJuiLrGcxlq2sqzdmgh1jeQpmg80V6dWqELLT2SL+J/Y7iElhHZ8ZrByEDPOo27WoHpnyxyng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762072844; c=relaxed/simple;
	bh=8/7YRVB8kXLPWGK+kRATwiT9HE2yomN6mR7oFtYeQLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/Vp2RnQ4zTadaFm3Gib+yEisD0dsayK6uYM7VhB5wPeMzsQLneFJldrYdNej6tjqSLFFVwz9rGWou4lEQDsFwt3yfmxcvpq7820Z5t1dklKHCkHICjoXXo0DcjTLELGiTd0PhUUb1hbaz2EaLCvavPQsFayCUahv1VUzpAFVkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=jkcXSI0t; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1762072840; bh=U0RE4xr3kCt68Mi4iC1bjiP8PsRMJ4Q3rbSgk84uo/4=;
	h=From:Message-ID:From;
	b=jkcXSI0t+zzQQbZkZ6Fg5qd/86RIZ+2CH1r3RftGH/Hihf6hgTt0YAaxQ0jyhiPZG
	 aMKYxgHeSgZ8KgM7KkPazJZkFhuOIs6cHl3pmPDjmJOwlY8vlD8vEg1pMfMZQXWzNZ
	 h4tks4A5OZCmYlHtdwhOPChKQLcIkIq9SM3kCm/4=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 2F7F6C06B5;
	Sun, 02 Nov 2025 09:40:40 +0100 (CET)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 5A28edAp010919;
	Sun, 2 Nov 2025 09:40:39 +0100
Date: Sun, 2 Nov 2025 09:40:39 +0100
From: Willy Tarreau <w@1wt.eu>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        shuah <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 09/12] tools/nolibc: use a custom struct timespec
Message-ID: <20251102084039.GC10797@1wt.eu>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251102083622.GB10797@1wt.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sun, Nov 02, 2025 at 09:36:22AM +0100, Willy Tarreau wrote:
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

OK like Arnd, I just saw with the last commit that this one will not
harm. That's good.

Willy

