Return-Path: <linux-kselftest+bounces-28414-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B168A55222
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 18:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BFB6166F89
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 17:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B2E25C6EC;
	Thu,  6 Mar 2025 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="j+nlG+qS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F51825B695;
	Thu,  6 Mar 2025 17:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741280422; cv=none; b=Vrt4O8Os9R0869OXb2fRrUa+AfbHJiO2oneoYZbbziysCa2vORMmy+97Hks7QfVFjSGG3LnHszFr7cf6uzgZqbAx/W9e+lyAjHWMx38d5FZfQIRQ/Rlg6jrQrrHd5uYL4DGXmmyS/RZ7rjILSetjKA28g4MJcdOzZfPcYnj9iO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741280422; c=relaxed/simple;
	bh=QnceLVnf5feN1aKAcL7nUss5U3kRaifnpXy1wKKSbFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYKQsMDaxSB0QonjgPJ+0GjdJ1xSac5ZmmYMVpBATrTJd03RA0ef0/eG0Gei3zYdxofPpy+8oFZkW3ETinZjOdHFrKWWwg50Bmy28jitVp+CMcKwF9Eee+HnkXaLcrkdBeOMA3iqzOF2G86I0xfYimXnebAsoDQR50v55A0kjIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=j+nlG+qS; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1741280418;
	bh=QnceLVnf5feN1aKAcL7nUss5U3kRaifnpXy1wKKSbFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j+nlG+qS2CwYyJbo9TVOSh+8yghMw507glcf+47HIYU0jOMGpzM5sI8ThQcw3lr4d
	 laG3M7bs6fdVefIXMwtKV4oXTvzJlvvZHyLLDufYGW5uti4Q6+RT+bvA1lbXxXPvuc
	 FOv2O9bbIt3dqa0a6gJhd/4z3H5bv0JJiXvmRcjw=
Date: Thu, 6 Mar 2025 18:00:17 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Louis Taylor <louis@kragniz.eu>
Cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] tools/nolibc: mark more test functions as static
Message-ID: <61636d83-8154-4e7b-850b-1c4ed9a2c2f2@t-8ch.de>
References: <20250304075846.66563-1-louis@kragniz.eu>
 <20250304075846.66563-5-louis@kragniz.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304075846.66563-5-louis@kragniz.eu>

On 2025-03-04 07:58:19+0000, Louis Taylor wrote:
> It was mentioned that a new test_ function should be static, so go back
> over existing functions and mark those static as well.

Actually Willy wants these non-static for debugging purposes.
I can't seem to get that into my head -.-
Let's drop this one.

> Signed-off-by: Louis Taylor <louis@kragniz.eu>
> ---
>  tools/testing/selftests/nolibc/nolibc-test.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> index 2a1629938dd6..b5464ca8d050 100644
> --- a/tools/testing/selftests/nolibc/nolibc-test.c
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -807,7 +807,7 @@ static int test_dirent(void)
>  	return 0;
>  }
>  
> -int test_getpagesize(void)
> +static int test_getpagesize(void)
>  {
>  	int x = getpagesize();
>  	int c;
> @@ -836,7 +836,7 @@ int test_getpagesize(void)
>  	return !c;
>  }
>  
> -int test_fork(void)
> +static int test_fork(void)
>  {
>  	int status;
>  	pid_t pid;
> @@ -861,7 +861,7 @@ int test_fork(void)
>  	}
>  }
>  
> -int test_stat_timestamps(void)
> +static int test_stat_timestamps(void)
>  {
>  	struct stat st;
>  
> @@ -883,7 +883,7 @@ int test_stat_timestamps(void)
>  	return 0;
>  }
>  
> -int test_uname(void)
> +static int test_uname(void)
>  {
>  	struct utsname buf;
>  	char osrelease[sizeof(buf.release)];
> @@ -922,7 +922,7 @@ int test_uname(void)
>  	return 0;
>  }
>  
> -int test_mmap_munmap(void)
> +static int test_mmap_munmap(void)
>  {
>  	int ret, fd, i, page_size;
>  	void *mem;
> @@ -980,7 +980,7 @@ int test_mmap_munmap(void)
>  	return !!ret;
>  }
>  
> -int test_pipe(void)
> +static int test_pipe(void)
>  {
>  	const char *const msg = "hello, nolibc";
>  	int pipefd[2];
> @@ -1001,7 +1001,7 @@ int test_pipe(void)
>  	return !!memcmp(buf, msg, len);
>  }
>  
> -int test_rlimit(void)
> +static int test_rlimit(void)
>  {
>  	struct rlimit rlim = {
>  		.rlim_cur = 1 << 20,
> -- 
> 2.45.2
> 

