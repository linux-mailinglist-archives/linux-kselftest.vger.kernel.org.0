Return-Path: <linux-kselftest+bounces-34481-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F374AD225C
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 17:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C5BB3A3FDF
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 15:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E573770B;
	Mon,  9 Jun 2025 15:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="GqzrPSDA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C37214B959;
	Mon,  9 Jun 2025 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749482736; cv=none; b=Orj5Qu6+F0pAfmpxe/8hlYpkwllJO/EDvBCE5YTKtnKHrn4SrcNXIzUhF7RYrwbc1Eb0FQ/EsucCQDVydnzmTo5fDaN7YzJzH+oX5EuVa7BnDfn6VlXuZI4qWjl/Zz+wBPQ8dwzUPCaz3vBX/Gaim9FwMZYoJn+5OqNQB7Ds1QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749482736; c=relaxed/simple;
	bh=CIWnEzhNhJo0RogzKpqhhp4pyACFAjdWXagyylxLBdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2zL1ahwZ82082WxVSS0kZHd6/Vy8f99XOuhvwiYa68FDBboHrxtsri2HLVgNQkhzrZAYT9usY6tUE1nxqvjipWJAEFTDfLa3cwRXgNLEIeHDOesCXh5fQ79EXQAlTe/EzCpNpoaFzhXbz3KVhgsGjBatQtZUWd1FuukPZahORk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=GqzrPSDA; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1749482732;
	bh=CIWnEzhNhJo0RogzKpqhhp4pyACFAjdWXagyylxLBdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GqzrPSDAc+2cNjXJ73v0xcZncXH1FX0qP3TnLlCNSCaQiYDH606YRzcr5TtQNkck2
	 frr2/wlJXkF79nGu9LYxn0kYncohzivO1dlIGJyO5zFwLfW8kQfnNs1P+tHudX0YnQ
	 pc07Az6dxYrWq54Qxd/4KoKDHiegGe1KZL9LBu3A=
Date: Mon, 9 Jun 2025 17:25:31 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Mark Brown <broonie@kernel.org>
Cc: Willy Tarreau <w@1wt.eu>, Christian Brauner <brauner@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] tools/nolibc: Provide vfork()
Message-ID: <2ece41af-9500-447c-8203-5c57024e39f9@t-8ch.de>
References: <20250609-arm64-gcs-vfork-exit-v1-0-baad0f085747@kernel.org>
 <20250609-arm64-gcs-vfork-exit-v1-1-baad0f085747@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609-arm64-gcs-vfork-exit-v1-1-baad0f085747@kernel.org>

Hi Mark,

On 2025-06-09 16:08:56+0100, Mark Brown wrote:
> To allow testing of vfork() support in the arm64 basic-gcs test provide an
> implementation for nolibc, using the vfork() syscall if one is available
> and otherwise clone3(). We implement in terms of clone3() since the order
> of the arguments for clone() varies between architectures.

Thanks for the patch!

Do you want to take this series through your tree?

> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/include/nolibc/sys.h | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> index 9556c69a6ae1..e056da010f64 100644
> --- a/tools/include/nolibc/sys.h
> +++ b/tools/include/nolibc/sys.h
> @@ -22,6 +22,7 @@
>  #include <linux/time.h>
>  #include <linux/auxvec.h>
>  #include <linux/fcntl.h> /* for O_* and AT_* */
> +#include <linux/sched.h> /* for clone_args */
>  #include <linux/stat.h>  /* for statx() */
>  
>  #include "errno.h"
> @@ -340,6 +341,34 @@ pid_t fork(void)
>  	return __sysret(sys_fork());
>  }
>  
> +#ifndef sys_vfork
> +static __attribute__((unused))
> +pid_t sys_vfork(void)
> +{
> +#ifdef __NR_vfork
> +	return my_syscall0(__NR_vfork);
> +#elif defined(__NR_clone3)
> +	/*
> +	 * clone() could be used but has different argument orders per
> +	 * architecture.
> +	 */
> +	struct clone_args args = {
> +		.flags		= CLONE_VM | CLONE_VFORK,
> +		.exit_signal	= SIGCHLD,
> +	};
> +
> +	return my_syscall2(__NR_clone3, &args, sizeof(args));
> +#else
> +	return __nolibc_enosys(__func__);
> +#endif
> +}
> +#endif
> +
> +static __attribute__((unused))
> +pid_t vfork(void)
> +{
> +	return __sysret(sys_vfork());
> +}

Could you also add a test to nolibc-test.c?
Maybe extend test_fork() with a flag to use either fork() or vfork().
And maybe change the exit() in the test to _exit(); not that it would
make a difference for nolibc (yet).

>  
>  /*
>   * int fsync(int fd);
> 
> -- 
> 2.39.5
> 

