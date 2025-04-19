Return-Path: <linux-kselftest+bounces-31198-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEBDA942C3
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Apr 2025 12:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9E5918916B0
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Apr 2025 10:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADE31C8609;
	Sat, 19 Apr 2025 10:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="G8haLCrt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147BC1CB31D;
	Sat, 19 Apr 2025 10:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745057500; cv=none; b=RH83AB721baetnhlQ2cxXrd64yz8tNJK8pmr7SbYDumHCkNGtKGlJAOnS62GdPSoYRdynW2b+tYto/F9VMbpW1VjP7ReC7PemaVyl8mIvCsYF+mFRd9wMifaYVWS2dlbqaSZKe1oxQp7ECVYKB++RjM50clAPC4e6HgUcfDvMU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745057500; c=relaxed/simple;
	bh=hir2wURXayqxPKZLrLn7n5UlblAEvVxE8hdXXV/GQCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jv7Pn1xix2XRlP76t1VZDAhwnLkgBC5I7pwbDk8bA3qxBYnD3sn26NTgpw6VLzkSWX0w1aihG/sKPOsvX20DGZ2Pkzn8AGXDHBYSVKQZ0Xk8xDsuq/p1fITMOqcILlB9EysarTk/w6rfG8UQcLky8D4HDc8lRmYdcVsNQk8ca9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=G8haLCrt; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1745057495;
	bh=hir2wURXayqxPKZLrLn7n5UlblAEvVxE8hdXXV/GQCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G8haLCrtFsKnE9XwewLQhvcq9ImDFA1fypKhAPEi8T6Xlk2pScJloqHqpXMF3Kujl
	 hasvyr+kBR60qSjkBaaT6Kuiyyzt2yOTShweiKV2zeghGfBzKDVLYP/nRJxFIZIqXv
	 9rObCSOdSdaG1/ePqYHoG3YYZmfuj6qx82VUZ+kY=
Date: Sat, 19 Apr 2025 12:11:35 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/6] tools/nolibc: properly align dirent buffer
Message-ID: <7ce6cd20-e20a-4bfa-b893-995ce6585d03@t-8ch.de>
References: <20250416-nolibc-ubsan-v1-0-c4704bb23da7@weissschuh.net>
 <20250416-nolibc-ubsan-v1-3-c4704bb23da7@weissschuh.net>
 <20250419091140.GC31874@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250419091140.GC31874@1wt.eu>

On 2025-04-19 11:11:40+0200, Willy Tarreau wrote:
> On Wed, Apr 16, 2025 at 08:40:18PM +0200, Thomas Weißschuh wrote:
> > As byte buffer is overlaid with a 'struct dirent64'.
> > it has to satisfy the structs alignment requirements.
> > 
> > Fixes: 665fa8dea90d ("tools/nolibc: add support for directory access")
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> 
> Oh good catch! I already faced crashes in other programs due to AVX
> memcpy when doing similar casts without thinking about alignment.
> 
> > @@ -58,6 +58,7 @@ int closedir(DIR *dirp)
> >  static __attribute__((unused))
> >  int readdir_r(DIR *dirp, struct dirent *entry, struct dirent **result)
> >  {
> > +	__attribute__((aligned(__alignof__(struct linux_dirent64))))
> >  	char buf[sizeof(struct linux_dirent64) + NAME_MAX + 1];
> 
> I tend to find it more readable when the attribute is on the same line as
> the type on variables declaration, often at the end of the line, to keep
> declarations alignes, even if that makes longer lines. If alignment concerns
> come back often, we could maybe have __nolibc_align(<align>) and maybe even
> __nolibc_align_as(<type>) to slightly shorten the lines. Just an idea.

Sounds good, the attribute soup is annoying.

> In any case: Acked-by: Willy Tarreau <w@1wt.eu>

Thanks!


Thomas

