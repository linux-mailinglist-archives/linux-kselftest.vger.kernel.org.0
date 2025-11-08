Return-Path: <linux-kselftest+bounces-45161-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1092C42CD1
	for <lists+linux-kselftest@lfdr.de>; Sat, 08 Nov 2025 13:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5506F3B1D49
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Nov 2025 12:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3AC1C84C6;
	Sat,  8 Nov 2025 12:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="ciAphf8u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD232B9B9;
	Sat,  8 Nov 2025 12:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762605209; cv=none; b=rGQW8fWQsgD5Br2jNpVUSZq/+BB8p66EMqbrSBNXqE4t6TfR0BXM358zm7qo8JybAGyS+UHIs8EDOwl4B3EjRd/YGZDRjcKjFcKs+Jstf1cZXIgdG/aHoZ8YBKj9xyhOh6lrZDZJj7gD0liMxt3HqNoNS443/uUxk1e1RWsIo8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762605209; c=relaxed/simple;
	bh=Rf9GJLGm/E16pRMnrmp+CBN32IvBJ0hD79MnJ1t7U5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CG+vr5jcItlLbm4InUDv14D3tFiIcxQrVM6IGVfKGrKQJw/em0efANZt066mjmyXJ0kJ1W8xnWu4mrI1FhsL0QDBZEpy8E+dK8Zd5k0Dr7vMSDiRAYUi7TW6Tyu81CiYiD5ruOvFK/7NdoQJTVU0FKpOf9IE38H/orrTywmC8NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=ciAphf8u; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1762605198; bh=i1/L4seNKaCr4KLY1JyXJE9sVlBA0J4FPORuvVZULoA=;
	h=From:Message-ID:From;
	b=ciAphf8uk6z691+PIsZBjpFLprn75paLigOmUQPACgNfJWYsDNoXPznUQa6/Va44g
	 D23FLScTsx3ilyw50bgHr+ltSjrGG+hRQFiuzKW1DByNrubkeC3kLCpBUGq1SbHHSU
	 KgVlAi7d1k29l5avy8AX43zmVUjXufC2W8h6gHoI=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 96FADC094F;
	Sat, 08 Nov 2025 13:33:18 +0100 (CET)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 5A8CXIdF006902;
	Sat, 8 Nov 2025 13:33:18 +0100
Date: Sat, 8 Nov 2025 13:33:18 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: add support for fchdir()
Message-ID: <20251108123318.GA6898@1wt.eu>
References: <20251107-nolibc-fchdir-v1-1-4a1ab8141f68@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251107-nolibc-fchdir-v1-1-4a1ab8141f68@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Thomas,

On Fri, Nov 07, 2025 at 03:13:38PM +0100, Thomas Weiﬂschuh wrote:
> Add support for the file descriptor based variant of chdir().
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
>  tools/include/nolibc/sys.h                   | 13 +++++++++++++
>  tools/testing/selftests/nolibc/nolibc-test.c |  2 ++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> index c5564f57deec88b8aa70291fcf6f9ca4dbc1d03f..a4b0fdb9b641230174f5e62d62762f59af81a00e 100644
> --- a/tools/include/nolibc/sys.h
> +++ b/tools/include/nolibc/sys.h
> @@ -118,6 +118,7 @@ void *sbrk(intptr_t inc)
>  
>  /*
>   * int chdir(const char *path);
> + * int fchdir(int fildes);
>   */
>  
>  static __attribute__((unused))
> @@ -132,6 +133,18 @@ int chdir(const char *path)
>  	return __sysret(sys_chdir(path));
>  }
>  
> +static __attribute__((unused))
> +int sys_fchdir(int fildes)
> +{
> +	return my_syscall1(__NR_fchdir, fildes);
> +}
> +
> +static __attribute__((unused))
> +int fchdir(int fildes)
> +{
> +	return __sysret(sys_fchdir(fildes));
> +}
> +
>  
>  /*
>   * int chmod(const char *path, mode_t mode);
> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> index 29de21595fc95341c2aa975375a8d471cb3933fc..5927a84466cc0ede3b99611e134a8c6b8ab91e72 100644
> --- a/tools/testing/selftests/nolibc/nolibc-test.c
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -1343,6 +1343,8 @@ int run_syscall(int min, int max)
>  		CASE_TEST(dup3_0);            tmp = dup3(0, 100, 0);  EXPECT_SYSNE(1, tmp, -1); close(tmp); break;
>  		CASE_TEST(dup3_m1);           tmp = dup3(-1, 100, 0); EXPECT_SYSER(1, tmp, -1, EBADF); if (tmp != -1) close(tmp); break;
>  		CASE_TEST(execve_root);       EXPECT_SYSER(1, execve("/", (char*[]){ [0] = "/", [1] = NULL }, NULL), -1, EACCES); break;
> +		CASE_TEST(fchdir_stdin);      EXPECT_SYSER(1, fchdir(STDIN_FILENO), -1, ENOTDIR); break;
> +		CASE_TEST(fchdir_badfd);      EXPECT_SYSER(1, fchdir(-1), -1, EBADF); break;
>  		CASE_TEST(file_stream);       EXPECT_SYSZR(1, test_file_stream()); break;
>  		CASE_TEST(fork);              EXPECT_SYSZR(1, test_fork(FORK_STANDARD)); break;
>  		CASE_TEST(getdents64_root);   EXPECT_SYSNE(1, test_getdents64("/"), -1); break;
> 
> ---
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> change-id: 20251107-nolibc-fchdir-2645c298a538

Looks good to me!

Acked-by: Willy Tarreau <w@1wt.eu>
Willy

