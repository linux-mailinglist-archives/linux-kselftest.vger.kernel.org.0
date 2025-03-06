Return-Path: <linux-kselftest+bounces-28416-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6154EA55289
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 18:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 034277AAAB7
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 17:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D2925D54C;
	Thu,  6 Mar 2025 17:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="i7ACt7dp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7888525C70C;
	Thu,  6 Mar 2025 17:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741281017; cv=none; b=hP49ZVkjcp++kQG7WCCcQVwQcunSYjtTxum3iV60p+/wENCzx9ydPqqm+QO4ZhfoYvoX2uD7LQqYEqqU9xBKnsQiLmDRfg1CXiIeN5NKbZ6Nn5gyiUXdN2x8eWr1qc6O562FW9SkCiytpj7UdJ+1YT4eQlPQAWitA4+CuaN9mKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741281017; c=relaxed/simple;
	bh=7LvL4Q+QxURG8M6QXVVrH9AvRVyAvW1kOuqrpFU2Sos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxrDlwvVkABF8exOXx27aA8zYrZf6tFOX+P696jfw/tomwPCd4WqflGoQwCRLADodA0UTH/zXXXVx3dl00eY8ohw0NYnwi37+BUdWFTJWQAauSSamrAExKA7bYixyz3clnTqtls9Bb64mBCu/ECVujWi3i4NHnepdmBdUeP7cvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=i7ACt7dp; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1741281012;
	bh=7LvL4Q+QxURG8M6QXVVrH9AvRVyAvW1kOuqrpFU2Sos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i7ACt7dp6+To4598OLUoQtK43VyFy4RGW6AkDWik3dcesvc0c82XAEMJu/ukExAHU
	 3pBFblmd2947RbCcOCwX4XkUCqLBQnp9y/AEjw2g5KPE8X9fKQisTkxvAblYdYY25s
	 q4gV1kdz4LL4+SQ2W4bFz4qwuIJhx0BDPIt3z7+8=
Date: Thu, 6 Mar 2025 18:10:11 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Louis Taylor <louis@kragniz.eu>
Cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/5] tools/nolibc: add support for openat(2)
Message-ID: <8a1fc6ff-e36c-41b5-b959-2d667bb8279a@t-8ch.de>
References: <20250304075846.66563-1-louis@kragniz.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250304075846.66563-1-louis@kragniz.eu>

On 2025-03-04 07:58:15+0000, Louis Taylor wrote:
> openat is useful to avoid needing to construct relative paths, so expose
> a wrapper for using it directly.
> 
> Signed-off-by: Louis Taylor <louis@kragniz.eu>

Looks good. I have some tiny nitpicks inline,
but if you prefer I can also pick it up as-is.

Acked-by: Thomas Weißschuh <linux@weissschuh.net>

> ---
>  tools/include/nolibc/sys.h                   | 25 ++++++++++++++++++++
>  tools/testing/selftests/nolibc/nolibc-test.c | 21 ++++++++++++++++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> index 8f44c33b1213..3cd938f9abda 100644
> --- a/tools/include/nolibc/sys.h
> +++ b/tools/include/nolibc/sys.h
> @@ -765,6 +765,31 @@ int mount(const char *src, const char *tgt,
>  	return __sysret(sys_mount(src, tgt, fst, flags, data));
>  }
>  
> +/*
> + * int openat(int dirfd, const char *path, int flags[, mode_t mode]);
> + */
> +
> +static __attribute__((unused))
> +int sys_openat(int dirfd, const char *path, int flags, mode_t mode)
> +{
> +	return my_syscall4(__NR_openat, dirfd, path, flags, mode);
> +}
> +
> +static __attribute__((unused))
> +int openat(int dirfd, const char *path, int flags, ...)
> +{
> +	mode_t mode = 0;
> +
> +	if (flags & O_CREAT) {
> +		va_list args;
> +
> +		va_start(args, flags);
> +		mode = va_arg(args, mode_t);
> +		va_end(args);
> +	}
> +
> +	return __sysret(sys_openat(dirfd, path, flags, mode));
> +}
>  
>  /*
>   * int open(const char *path, int flags[, mode_t mode]);
> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> index 79c3e6a845f3..2a1629938dd6 100644
> --- a/tools/testing/selftests/nolibc/nolibc-test.c
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -1028,6 +1028,26 @@ int test_rlimit(void)
>  	return 0;
>  }
>  
> +static int test_openat(void)

As mentioned in my other mail, this in fact should not be static.
Sorry for the back and forth.

> +{
> +	int dev;
> +	int null;

Can be on a single line.

> +
> +	dev = openat(AT_FDCWD, "/dev", O_DIRECTORY);
> +	if (dev < 0)
> +		return -1;
> +
> +	null = openat(dev, "null", 0);

As per the standard:

	The argument flags must include one of the following access modes:
	O_RDONLY, O_WRONLY, or O_RDWR.

The other tests don't do it either and on Linux it doesn't matter
because O_RDONLY == 0. But if we are here anyways.

close(dev) could be moved here for some saved lines.

> +	if (null < 0) {
> +		close(dev);
> +		return -1;
> +	}
> +
> +	close(dev);
> +	close(null);
> +
> +	return 0;
> +}
>  
>  /* Run syscall tests between IDs <min> and <max>.
>   * Return 0 on success, non-zero on failure.
> @@ -1116,6 +1136,7 @@ int run_syscall(int min, int max)
>  		CASE_TEST(mmap_munmap_good);  EXPECT_SYSZR(1, test_mmap_munmap()); break;
>  		CASE_TEST(open_tty);          EXPECT_SYSNE(1, tmp = open("/dev/null", 0), -1); if (tmp != -1) close(tmp); break;
>  		CASE_TEST(open_blah);         EXPECT_SYSER(1, tmp = open("/proc/self/blah", 0), -1, ENOENT); if (tmp != -1) close(tmp); break;
> +		CASE_TEST(openat_dir);        EXPECT_SYSNE(1, test_openat(), -1); break;

EXPECT_SYSZR() should work here.

>  		CASE_TEST(pipe);              EXPECT_SYSZR(1, test_pipe()); break;
>  		CASE_TEST(poll_null);         EXPECT_SYSZR(1, poll(NULL, 0, 0)); break;
>  		CASE_TEST(poll_stdout);       EXPECT_SYSNE(1, ({ struct pollfd fds = { 1, POLLOUT, 0}; poll(&fds, 1, 0); }), -1); break;
> -- 
> 2.45.2
> 

