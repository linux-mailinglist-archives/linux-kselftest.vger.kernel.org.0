Return-Path: <linux-kselftest+bounces-7929-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF958A449D
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Apr 2024 20:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EDBAB2238F
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Apr 2024 18:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D305822A;
	Sun, 14 Apr 2024 18:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="LbeOESU2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3214029B0;
	Sun, 14 Apr 2024 18:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713119825; cv=none; b=IXqTv8PolsQkuGUVIejRu7agX1u7xrpSOmmNhRLNrmVjMJDPnPsI285EjUs4ucTaSmtAGl6J1FMRQcYy13MCCn+drZGwljADbB9YV9yauozV+0lEFB3PUPaS0k07s/tWSnbJQHILk2OU5rnRypcQb7DBwISIHRvye/4QXAyIqss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713119825; c=relaxed/simple;
	bh=xJFlMWPbhO6+WK3kaxc8AdE1jzxZJmZ4bwMkrBNxlf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVgVINh82NbRfhdGXIjgTNchlmJ3JhVVBg6GitwHTWJ8OgZy2JCpn0SG0jeF2y2h/QqQ0qQOUL6dkwjU1+bTvDZPaICpBli03tdimCYHIt2LCDZEOqZcm8a8Tne9X9U1Wrs3FuMS1UMzKNP/wdqovtQ333sTuWYqJt6ZfowntJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=LbeOESU2; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1713119819;
	bh=xJFlMWPbhO6+WK3kaxc8AdE1jzxZJmZ4bwMkrBNxlf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LbeOESU2jXhtSK6Dkm4COT5DG27t+MR3mxNbvW1J0/Y6uJB77Zc2ci9fbwlZovGPN
	 2HKnhVC8X8LFcK5YrNBz5H47rgZKZeM15GhAUY64cvBt7UReMYntqP9glf5nS3jUGy
	 ogUhQ3sn4j2r1A8lEYXDgn2bDlgyvrxeMxj9Bo4g=
Date: Sun, 14 Apr 2024 20:36:57 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: add support for uname(2)
Message-ID: <03d78f65-c753-4e03-8079-d9ad5a6da125@t-8ch.de>
References: <20240414-nolibc-uname-v1-1-28a1fdbd5c64@weissschuh.net>
 <20240414105646.GA2236@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240414105646.GA2236@1wt.eu>

Hi Willy!

On 2024-04-14 12:56:46+0200, Willy Tarreau wrote:
> On Sun, Apr 14, 2024 at 09:56:23AM +0200, Thomas Weißschuh wrote:
> > All supported kernels are assumed to use struct new_utsname.
> > This is validated in test_uname().
> > 
> > uname(2) can for example be used in ksft_min_kernel_version() from the
> > kernels selftest framework.
> > 
> > Link: https://lore.kernel.org/lkml/20240412123536.GA32444@redhat.com/
> 
> I find it really annoying when other developers waste time trying to
> work around some missing trivial syscalls. I would have bet we already
> had this one, but obviously not.

It's a bit annoying to validate that it works given the fact there are
the structs new_utsname, old_utsname and oldold_utsname...

> That's obviously an ack by me: Acked-by: Willy Tarreau <w@1wt.eu>

Thanks, pushed to nolibc/next.
(With a tiny change to skip the testcase if procfs is not available.

Thomas

