Return-Path: <linux-kselftest+bounces-27991-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2E7A4B545
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Mar 2025 23:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2F077A5697
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Mar 2025 22:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C23A1EEA54;
	Sun,  2 Mar 2025 22:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="pAUO5yLz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8091C5D50;
	Sun,  2 Mar 2025 22:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740954289; cv=none; b=Eo8KcjW6YTZtPnd5aZ5ZLdrfAux97U2L4X+NZY/uXSIbk1/YeXTqzZymue94DLWASt1J0EeXrWr5CrYavXEurtBmuH9i2HCO6BojdMgsj2OREpTUFXOv4SwWxrwGg+cUt8kyKVcu8bO/jq8Ylz/hnwBsQg0ZHd63y68Z3YaiVZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740954289; c=relaxed/simple;
	bh=/hlDwvxLYyxxaCdGAumRss9X64xeO1ztGhDkk6sK0to=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJHs3dnLk5gj0DaW7pm8WizSuEmmTYf3CnnLRYWXDORSClstzJJF/nVEztIuX2i4YTyFgBa7rZMN8WV++WKCbYZmwwDmhB+OXD3HMrqviw1JeK/AJZT2V93teT9mwezrLSw46ncNr2MB2EQMboCF+DIB3ROl4Yb6AaywE6Ey2a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=pAUO5yLz; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1740954283;
	bh=/hlDwvxLYyxxaCdGAumRss9X64xeO1ztGhDkk6sK0to=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pAUO5yLz0rLqLnTSUiXtT6af/tLaDefSVgDUG1acgkvj3UNGHGizyrtb9wacM2ZEi
	 ax4mZpA3MBb3ghzG6IINTD4D7wH+CuBbDHEY+AHOGPER5EMl7Ihxkm3kaCaizyZJAH
	 +1rTpe9KyhGbjeFPoXTnwnJAvn2osHzd432A564E=
Date: Sun, 2 Mar 2025 23:24:43 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Louis Taylor <louis@kragniz.eu>
Cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: add support for openat(2)
Message-ID: <d0ed3b0d-4b7d-40cb-bbce-1f2a6605db7f@t-8ch.de>
References: <20250302202528.4169024-1-louis@kragniz.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250302202528.4169024-1-louis@kragniz.eu>

Hi Louis,

On 2025-03-02 20:25:23+0000, Louis Taylor wrote:
> openat is useful to avoid needing to construct relative paths, so expose
> a wrapper for using it directly.

Can you say what you are using nolibc for? I'm curious :-)

> Signed-off-by: Louis Taylor <louis@kragniz.eu>
> ---
>  tools/include/nolibc/sys.h                   | 29 ++++++++++++++++++++
>  tools/testing/selftests/nolibc/nolibc-test.c | 22 +++++++++++++++
>  2 files changed, 51 insertions(+)
> 
> diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> index 8f44c33b1213..e5ff34df4aee 100644
> --- a/tools/include/nolibc/sys.h
> +++ b/tools/include/nolibc/sys.h
> @@ -765,6 +765,35 @@ int mount(const char *src, const char *tgt,
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
> +#ifdef __NR_openat
> +	return my_syscall4(__NR_openat, dirfd, path, flags, mode);
> +#else
> +	return __nolibc_enosys(__func__, dirfd, path, flags, mode);
> +#endif

All architectures support openat(), so the #else could be dropped.

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
> +		mode = va_arg(args, int);

mode_t instead of int?

> +		va_end(args);
> +	}
> +
> +	return __sysret(sys_openat(dirfd, path, flags, mode));
> +}
>  
>  /*
>   * int open(const char *path, int flags[, mode_t mode]);
> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> index 79c3e6a845f3..97ded6c76f99 100644
> --- a/tools/testing/selftests/nolibc/nolibc-test.c
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -1028,6 +1028,26 @@ int test_rlimit(void)
>  	return 0;
>  }
>  
> +int test_openat(void)

static.

> +{
> +	int dev;
> +	int null;
> +
> +	dev = openat(AT_FDCWD, "/dev", O_DIRECTORY);
> +	if (dev < 0)
> +		return -1;
> +
> +	null = openat(dev, "null", 0);
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
> @@ -1116,6 +1136,8 @@ int run_syscall(int min, int max)
>  		CASE_TEST(mmap_munmap_good);  EXPECT_SYSZR(1, test_mmap_munmap()); break;
>  		CASE_TEST(open_tty);          EXPECT_SYSNE(1, tmp = open("/dev/null", 0), -1); if (tmp != -1) close(tmp); break;
>  		CASE_TEST(open_blah);         EXPECT_SYSER(1, tmp = open("/proc/self/blah", 0), -1, ENOENT); if (tmp != -1) close(tmp); break;
> +		CASE_TEST(openat_fdcwd);      EXPECT_SYSNE(1, tmp = openat(AT_FDCWD, "/dev/null", 0), -1); if (tmp != -1) close(tmp); break;

AT_FDCWD is already used in test_openat(). What additional value does
the test above add?

> +		CASE_TEST(openat_dir);        EXPECT_SYSNE(1, test_openat(), -1); break;
>  		CASE_TEST(pipe);              EXPECT_SYSZR(1, test_pipe()); break;
>  		CASE_TEST(poll_null);         EXPECT_SYSZR(1, poll(NULL, 0, 0)); break;
>  		CASE_TEST(poll_stdout);       EXPECT_SYSNE(1, ({ struct pollfd fds = { 1, POLLOUT, 0}; poll(&fds, 1, 0); }), -1); break;
> -- 
> 2.45.2
> 

