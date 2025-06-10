Return-Path: <linux-kselftest+bounces-34610-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF43FAD3F55
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 18:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97E597ABD14
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 16:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B70242D95;
	Tue, 10 Jun 2025 16:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="CfCoWXmP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E5E242D92;
	Tue, 10 Jun 2025 16:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749573742; cv=none; b=Hdv8ECuanTQgsmUOdIGfQqEhI3pjj3GMnVxPpC8CaXTuYs5/sv/wK5XUG5il66MBfwc8+WGNX19bY2xllDWnUGWQEbZzOCmv/MZVDVffnTMGLRPq4xQ8GhbtG6dn9eol7dDSuDDjP/osn9PNT4VAVQkfSW3+H1HuA6GwzG4FZ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749573742; c=relaxed/simple;
	bh=hS9bew/V9dOguSA0Tn0RisCGc1oHuJaDh8mlmT55Dlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brstHWGlzDk6r4sUv/gI2F8R70emLPyRWmsYtHM9nKeWx9mWpfv58BKNHYw16z9+2f1x0yO2zg+oiBiqzd8Q93Abr5uYkIIoT2a01HT+pL5FjI+v7QZXx0eJXMoWVq9YyT3uLP6T2BDed+dqW90dDjJZDJ1NB9B7tGpN6E0FITM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=CfCoWXmP; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1749573733;
	bh=hS9bew/V9dOguSA0Tn0RisCGc1oHuJaDh8mlmT55Dlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CfCoWXmP9M9d2PUtc3aKPyBuRWWT8BMhuiSPV2cuX1PYHPHiO/K5CSh9KXk007Jfz
	 XXmnmnncq/sEDQDzP52wwGhIe4CzhCS10deNuG0GpSwyakhXpx2PPS8YKNuQKMWuOy
	 akbGSb17qyCAzrv5C/6OyAz3FljQe5nMRaei+JLA=
Date: Tue, 10 Jun 2025 18:42:13 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Mark Brown <broonie@kernel.org>
Cc: Willy Tarreau <w@1wt.eu>, Christian Brauner <brauner@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/4] tools/nolibc: Provide vfork()
Message-ID: <5ce6fcb4-be3d-461b-9b17-495eff6ea2d5@t-8ch.de>
References: <20250610-arm64-gcs-vfork-exit-v2-0-929443dfcf82@kernel.org>
 <20250610-arm64-gcs-vfork-exit-v2-2-929443dfcf82@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610-arm64-gcs-vfork-exit-v2-2-929443dfcf82@kernel.org>

On 2025-06-10 13:29:45+0100, Mark Brown wrote:
> To allow testing of vfork() support in the arm64 basic-gcs test provide an
> implementation for nolibc, using the vfork() syscall if one is available
> and otherwise clone3(). We implement in terms of clone3() since the order
> of the arguments for clone() varies between architectures.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/include/nolibc/sys.h | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> index aabac97a7fb0..5932ae8828a1 100644
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
> @@ -340,6 +341,32 @@ pid_t fork(void)
>  	return __sysret(sys_fork());
>  }
>  
> +static __attribute__((unused))
> +pid_t sys_vfork(void)
> +{
> +#if defined(__NR_vfork)
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

It seems that on SPARC __NR_vfork has the same non-standard return value
as __NR_fork. It therefore needs the same special handling in arch-sparc.h.
Maybe with a helper to avoid the duplication.

If you want I can fix this up when applying.
Otherwise the series looks good.

> +
> +static __attribute__((unused))
> +pid_t vfork(void)
> +{
> +	return __sysret(sys_vfork());
> +}
>  
>  /*
>   * int fsync(int fd);
> 
> -- 
> 2.39.5
> 

