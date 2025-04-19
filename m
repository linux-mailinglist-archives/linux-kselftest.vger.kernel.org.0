Return-Path: <linux-kselftest+bounces-31195-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B61A942A3
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Apr 2025 11:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BCA6189F7FF
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Apr 2025 09:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19791B6CE3;
	Sat, 19 Apr 2025 09:40:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D10191F77;
	Sat, 19 Apr 2025 09:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745055615; cv=none; b=A4uD7sv6bc2UL1LfojWnjmNe9SqTach2qyEv9zt8vCKK6pH23PVspqN0GkL4K5HZUhWjYT+74xkK0Ga8QUDL68s7PnEHpXjQ9OkZfqsgvZVUTxcfiBttryUR1/Lb2QMtEfNL5RWoARyQlpknM5lhavrjkXACkrlBtHeh0B40B9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745055615; c=relaxed/simple;
	bh=NBKsA6tmDNOYGK/xG/NWENgk0rMx/nH1HY2tHTozM0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aW65QStgHKiU7ZC6TIEiApokiqD/3pTWQ6uDanZZZaVkCZpz92Oz+bMh0jX3bsTvEpxycB/5T40Jt2Iy08LfnZ/0ULvv95TqdBmVEQEI93TdKAsJu7D7v7jdTTdVeI2yBuQg7g+Fw/uP3NMxW4nw9K5RTU1jzvrbYuO31jZefhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 53J9e8lx032278;
	Sat, 19 Apr 2025 11:40:08 +0200
Date: Sat, 19 Apr 2025 11:40:08 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 4/6] tools/nolibc: fix integer overflow in i{64,}toa_r()
 and
Message-ID: <20250419094008.GD31874@1wt.eu>
References: <20250416-nolibc-ubsan-v1-0-c4704bb23da7@weissschuh.net>
 <20250416-nolibc-ubsan-v1-4-c4704bb23da7@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250416-nolibc-ubsan-v1-4-c4704bb23da7@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Apr 16, 2025 at 08:40:19PM +0200, Thomas Weißschuh wrote:
> In twos complement the most negative number can not be negated.

well, if we're picky, that's not really an int overflow since it's only
used as an unsigned in the end, so -2^(N-1) == 2^(N-1) in twos complement.

> @@ -271,16 +271,12 @@ int utoa_r(unsigned long in, char *buffer)
>  static __attribute__((unused))
>  int itoa_r(long in, char *buffer)
>  {
> -	char *ptr = buffer;
> -	int len = 0;
> -
>  	if (in < 0) {
> -		in = -in;
> -		*(ptr++) = '-';
> -		len++;
> +		*(buffer++) = '-';
> +		return 1 + utoa_r(-(unsigned long)in, buffer);
>  	}
> -	len += utoa_r(in, ptr);
> -	return len;
> +
> +	return utoa_r(in, buffer);
>  }

At -Os it's OK but at -O2 it inflates it a little bit and at -O3 it
significantly inflates the function (175 -> 320 bytes) due to the two
calls that get inlined. Have you tried to check if ubsan is happy
with just this?

-		in = -in;
+		in = -(unsigned long)in;

Otherwise this variant doesn't inflate it for me and keeps the spirit
of the original one (i.e. single call):

  int itoa_r3(long in, char *buffer)
  {
        unsigned long uin = in;
        int len = 0;

        if ((long)uin < 0) {
                uin = -uin;
                *(buffer++) = '-';
                len++;
        }
        len += utoa_r(uin, buffer);
        return len;
  }

I'm also seeing a way to make it even smaller than the original by
changing utoa_r() so that it takes the original buffer in a 3rd
argument and emits the difference at the end as the length. This
allows to always perform a tail call, though I'm not sure we really
need it. 
 
Thanks,
Willy

