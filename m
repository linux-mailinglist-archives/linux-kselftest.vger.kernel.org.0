Return-Path: <linux-kselftest+bounces-27989-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD266A4B516
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Mar 2025 23:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA255188E141
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Mar 2025 22:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A231D5CC5;
	Sun,  2 Mar 2025 22:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="kL2MSUia"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2B41EB9EF;
	Sun,  2 Mar 2025 22:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740952995; cv=none; b=lZgKHX/ya3k37211I62rWC4A16gm+3DDQJCbymi3F8jqtNYWvFFAG8hHzxEEaWnudyRexKq8vApGOtnNpqCtuoZC4Dej0UW21eFR55YIr1ay0t/2gzJmIWEmHJnmThP8kginKsxqpqkEBpAUwevefObvd0Q0NAty/doyy8zODHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740952995; c=relaxed/simple;
	bh=X3Oi7SmifOfnACnk6HXp/r98e88xQlGHmGmpB5IQCA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfFskYWA7ys1jn6v508NV1TDEVLqWm5Z4gW2UeeQYzK7djSM++he8QTt9/uboERkNiCGR4V7llk8Ux7xchfVZdtAqUdYqxxc0A21wzg7kvsF4hkNjljizvLpfACSI0hzhFI9qllSzIA/0JnMPgjvOXTd9oiutxA6AaXZTW90WMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=kL2MSUia; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1740952561;
	bh=X3Oi7SmifOfnACnk6HXp/r98e88xQlGHmGmpB5IQCA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kL2MSUiaL7zWpljLHyDr5g51GmjgO8dtCUftGCBzQ7uoq3DWHCC1/WgMpzfj2T6Qe
	 TW6UqcO3fpULW9yoavs2cVzpSboP9ZSkX9SSDKLNi64g9kl2fNJjt5eA/m3gwi/5fd
	 vNxJGU89eQDSq6Chl9EDOac9bGUNKP9IE5rOK0Zg=
Date: Sun, 2 Mar 2025 22:56:01 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: only run constructor tests on nolibc
Message-ID: <8dde4be5-0b37-4e45-bea3-8cdadeb23e7a@t-8ch.de>
References: <20250212-nolibc-test-constructor-v1-1-c963875b3da4@weissschuh.net>
 <20250216093940.GA2192@1wt.eu>
 <670b08a4-9bc5-4700-94bb-272fda5c59d7@t-8ch.de>
 <20250222093851.GA13258@1wt.eu>
 <b36e1946-fda8-4893-b081-7ac9b4933947@t-8ch.de>
 <20250301110735.GA18621@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250301110735.GA18621@1wt.eu>

Hi Willy!

On 2025-03-01 12:07:35+0100, Willy Tarreau wrote:
> [..]

> OK so I've tested the patch below which does what we want, except that
> it reveals that the order is still not granted. Actually I haven't found
> what dictates it. On one machine (gcc-9.5, ld-2.26) I'm getting:
> 
>   $ ./nolibc-test|grep cst
>   17 linkage_cst = 0                                              [FAIL]
>   18 linkage_cst_ord = 0                                          [FAIL]

Apparently no constructors are executed at all.
Can you show the default linkerscript used?

gcc -static -o /dev/null /dev/null -Wl,--verbose

> On this same machine, using another toolchain relying on ld-2.27 gives me
> this:
> 
>   $ ./nolibc-test|grep cst
>   17 linkage_cst = 1                                                [OK]
>   18 linkage_cst_ord = 33                                          [FAIL]
> 
> And I'm getting this as well on another machine with various toolchains
> such as gcc-9.5+ld-2.34. The nolibc toolchains fail similarly on gcc-5.5
> (ld-2.27) and gcc-6.5 (ld-2.32), but work for gcc-7.5 with ld-2.32, while
> other combinations do work:
> 
>   $ ./nolibc-test|grep -i cst
>   17 linkage_cst = 1                                                [OK]
>   18 linkage_cst_ord = 18                                           [OK]
> 
> All of this is a bit confusing.
> 
> I continue not to understand what could guarantee an implicit execution
> order since for me it solely depends on how things are linked, so the
> purpose of the test remains uncertain to me and I think we'd rather not
> try to enforce any ordering that might work only by pure luck.

I don't think anything guarantees the order. 
It is just what happened to work in my tests so far.

> What do you think ?

Let's get rid of the validation.


Thomas

