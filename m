Return-Path: <linux-kselftest+bounces-31199-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FF7A942CB
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Apr 2025 12:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8B231897783
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Apr 2025 10:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF04B1C8630;
	Sat, 19 Apr 2025 10:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="tfAmHOBu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47A4185B72;
	Sat, 19 Apr 2025 10:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745058369; cv=none; b=ZuGYq8TSCuVBxbNTv+xp2GFQAnYRBZXy3IJL9ErhUirJQxARcX4jJrILvuin6utJncilrjjCslMIlznQ7To8msagsRo9e4NR+arUIGrKSpm2Je7xCYS33sXz6TPwfGwFQlssSgsV+ANfgrJ5ULpTMsqbIBzMQR3JSW06Z4GlKRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745058369; c=relaxed/simple;
	bh=eb2tYNLCkVsRN5DbcuDq/MwKOfRhfrfDhugt+IQSpX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FT2VgJVGkafFO0YaHG6hK1JAjNbcy+SgJ2uUkSRdKV9z5bTcPiYvPPXjR2UdAjqZC0hjo//XcA5vTqXG+MRkWAMSsi55McmsiyVuXKS945ulw1/2/OPJcNSF6M/DgqUdUIHN/c4ZgKUYPysFy/R5QUa7Oqf2JZqRUvgIjFUus8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=tfAmHOBu; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1745058361;
	bh=eb2tYNLCkVsRN5DbcuDq/MwKOfRhfrfDhugt+IQSpX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tfAmHOBuwt4hcTpLv4IBEyPoRNYWyZ4KeZUE9FwbI5zL18fSHJ7MY+75Y8PKEgIQn
	 YRB4AsDs8+vW8By2uPaIxWYHCxzCMsuqO9Q6S5HVHasCLtUYsftBPzcjQvGXb+i74N
	 /+WwqliVNyQvusBE9Xxu0r5IQroFY4LaXJsLiaH0=
Date: Sat, 19 Apr 2025 12:26:01 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 4/6] tools/nolibc: fix integer overflow in i{64,}toa_r()
 and
Message-ID: <73b72524-95d2-44ef-8176-67c74c37cc36@t-8ch.de>
References: <20250416-nolibc-ubsan-v1-0-c4704bb23da7@weissschuh.net>
 <20250416-nolibc-ubsan-v1-4-c4704bb23da7@weissschuh.net>
 <20250419094008.GD31874@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250419094008.GD31874@1wt.eu>

On 2025-04-19 11:40:08+0200, Willy Tarreau wrote:
> On Wed, Apr 16, 2025 at 08:40:19PM +0200, Thomas Weißschuh wrote:
> > In twos complement the most negative number can not be negated.
> 
> well, if we're picky, that's not really an int overflow since it's only
> used as an unsigned in the end, so -2^(N-1) == 2^(N-1) in twos complement.

It is used as unsigned, but at the point of the cast it's still signed.
From ccpreference:

The unary minus invokes undefined behavior due to signed integer
overflow when applied to INT_MIN, LONG_MIN, or LLONG_MIN, on typical
(2's complement) platforms.

https://en.cppreference.com/w/c/language/operator_arithmetic

> 
> > @@ -271,16 +271,12 @@ int utoa_r(unsigned long in, char *buffer)
> >  static __attribute__((unused))
> >  int itoa_r(long in, char *buffer)
> >  {
> > -	char *ptr = buffer;
> > -	int len = 0;
> > -
> >  	if (in < 0) {
> > -		in = -in;
> > -		*(ptr++) = '-';
> > -		len++;
> > +		*(buffer++) = '-';
> > +		return 1 + utoa_r(-(unsigned long)in, buffer);
> >  	}
> > -	len += utoa_r(in, ptr);
> > -	return len;
> > +
> > +	return utoa_r(in, buffer);
> >  }
> 
> At -Os it's OK but at -O2 it inflates it a little bit and at -O3 it
> significantly inflates the function (175 -> 320 bytes) due to the two
> calls that get inlined. Have you tried to check if ubsan is happy
> with just this?
> 
> -		in = -in;
> +		in = -(unsigned long)in;

That seems to work. Let's use it.

Thanks!

> Otherwise this variant doesn't inflate it for me and keeps the spirit
> of the original one (i.e. single call):
> 
>   int itoa_r3(long in, char *buffer)
>   {
>         unsigned long uin = in;
>         int len = 0;
> 
>         if ((long)uin < 0) {
>                 uin = -uin;
>                 *(buffer++) = '-';
>                 len++;
>         }
>         len += utoa_r(uin, buffer);
>         return len;
>   }
> 
> I'm also seeing a way to make it even smaller than the original by
> changing utoa_r() so that it takes the original buffer in a 3rd
> argument and emits the difference at the end as the length. This
> allows to always perform a tail call, though I'm not sure we really
> need it. 

Thomas

