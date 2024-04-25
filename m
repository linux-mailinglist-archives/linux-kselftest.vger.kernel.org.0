Return-Path: <linux-kselftest+bounces-8869-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D31638B2677
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 18:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F91A284274
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 16:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D76D381AF;
	Thu, 25 Apr 2024 16:30:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FE2149E0E;
	Thu, 25 Apr 2024 16:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714062613; cv=none; b=MdojujL4AR10YmL4IhmnhyZNf1wHg+jbAKOUUA/A4oA7Ev2LGkZvpIOMZSvKisCDZCnxu2X/DPY9MsifM6Ji5UTAizduwERmjFVQKNaQ2i7HIOLc4Jt6lZ5TxWh9hPdDDp2j1+uPpDdd3C+b35um+AFRXMFq/ucu83Yff66g6C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714062613; c=relaxed/simple;
	bh=4tiu3lluDCUyH1jCN9NdtrvFzD+WUo0RiCTeeEv2v64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVLrBhow2uACifPkUzoLijKDAUQMMd9LjoV5HQhZXRrA473jYQ6wN2LH9QF673/jPf2hODSCShrJdAXgCndF7kIxd2/6UQhWXhHoQhFaEwovHeKZUBH3k8wW6X4JrMB2GcbuayfmEZub8/VFyzgMqkL0Q8dWeGSOv2XQy9vuHdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by mail.home.local (8.17.1/8.17.1/Submit) id 43PGTI2Z017225;
	Thu, 25 Apr 2024 18:29:18 +0200
Date: Thu, 25 Apr 2024 18:29:18 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] tools/nolibc: implement strtol() and friends
Message-ID: <ZiqE3nYSj79rc7il@1wt.eu>
References: <20240425-nolibc-strtol-v1-0-bfeef7846902@weissschuh.net>
 <20240425-nolibc-strtol-v1-2-bfeef7846902@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240425-nolibc-strtol-v1-2-bfeef7846902@weissschuh.net>

Hi Thomas,

On Thu, Apr 25, 2024 at 06:09:27PM +0200, Thomas Weißschuh wrote:
> The implementation always works on uintmax_t values.
> 
> This is inefficient when only 32bit are needed.
> However for all functions this only happens for strtol() on 32bit
> platforms.

That's indeed very useful! I think there's two small bugs below where
the second one hides the first one:

> +static __attribute__((unused))
> +uintmax_t __strtox(const char *nptr, char **endptr, int base, intmax_t lower_limit, uintmax_t upper_limit)
> +{
> +	const char signed_ = lower_limit != 0;
> +	unsigned char neg = 0, overflow = 0;
> +	uintmax_t val = 0, limit, old_val;
> +	char c;
> +
> +	if (base < 0 || base > 35) {
                        ^^^^^^^^^
should be 36 otherwise you won't support [0-9a-z].

> +		SET_ERRNO(EINVAL);
> +		goto out;
> +	}
(...)
> +		if (c > base)
> +			goto out;

This should be "c >= base" otherwise 'z' is accepted in base 35 for
example. I think it could be useful to add one more test covering base
36 to make sure all chars pass ?

> +	if (endptr)
> +		*endptr = (char *)nptr;
> +	return (neg ? -1 : 1) * val;

I just checked to see what the compiler does on this and quite frequently
it emits a multiply while the other approach involving only a negation is
always at least as short:

	return neg ? -val : val;

E.g. here's the test code:

  long fct1(long neg, long val)
  {
        return (neg ? -1 : 1) * val;
  }

  long fct2(long neg, long val)
  {
        return neg ? -val : val;
  }

- on x86_64 with gcc-13.2 -Os:

  0000000000000000 <fct1>:
     0:   f7 df                   neg    %edi
     2:   48 19 c0                sbb    %rax,%rax
     5:   48 83 c8 01             or     $0x1,%rax
     9:   48 0f af c6             imul   %rsi,%rax
     d:   c3                      ret    
  
  000000000000000e <fct2>:
     e:   48 89 f0                mov    %rsi,%rax
    11:   85 ff                   test   %edi,%edi
    13:   74 03                   je     18 <fct2+0xa>
    15:   48 f7 d8                neg    %rax
    18:   c3                      ret    

- on riscv64 with 13.2 -Os:

  0000000000000000 <fct1>:
     0:   c509                    beqz    a0,a 
     2:   557d                    li      a0,-1
     4:   02b50533                mul     a0,a0,a1
     8:   8082                    ret
     a:   4505                    li      a0,1
     c:   bfe5                    j       4
  
  000000000000000e <fct2>:
     e:   c119                    beqz    a0,14
    10:   40b005b3                neg     a1,a1
    14:   852e                    mv      a0,a1
    16:   8082                    ret

So IMHO it would be better to go the simpler way even if these are just a
few bytes (and possibly ones less mul on some slow archs).

Thanks!
Willy

