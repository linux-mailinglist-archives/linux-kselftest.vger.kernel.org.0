Return-Path: <linux-kselftest+bounces-38181-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA371B184AD
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 17:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5F5D7B5E7E
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 15:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5DC26D4DE;
	Fri,  1 Aug 2025 15:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="hZ4hDsBJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058262367AD
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Aug 2025 15:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754060961; cv=none; b=N17tL1Ml7Dn6pbJ5lqtpO6b0cs1xPIj6yjQj/AtqNLGGsypZbzdJfcyf+hemW0AGXAy40HGsAHaj126t/u/SnKI411xoVNd94QPbEFnG6KtrklKG+f+UwFs3J0n4ycJ2ZRonWlWCmxGUKXBuuq9HSty/atwTEVILnUCA8WwJ3Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754060961; c=relaxed/simple;
	bh=kK1dgmTZsHkEElXKMPmNcnLYqTgRpHUQEJnHr+zgSTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NADvAKtnjGg4jOYpq/xWhDOCX9+UwESFYyR2MMR6WSU7d+1cLHRBcH5yueWqgi1Qne2bhZU03z4yoWf5t8F06nph4zbZlgxk7GnS04ZNxudzBzX1Z7IGc6xc0yf0es1c8sMf8lJvQyWdziJNqtwx4dpslHMZLjo+vvOhpR3UsAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=hZ4hDsBJ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1754060957;
	bh=kK1dgmTZsHkEElXKMPmNcnLYqTgRpHUQEJnHr+zgSTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hZ4hDsBJoxjqNIrtYINpnmnIbidLeVMokm+RZrjVTEpva8DcEDM62uMDyFfB/JOT9
	 +edAb6ijm836vMdgZtldRU2v+ixzD+eAl85D8k8+klDur0SccQ84kziu9eVCsxDQ1K
	 /M6w/20EDHclp0JL9druvQ0YLpO2qutxEC26iP/M=
Date: Fri, 1 Aug 2025 17:09:17 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: Willy Tarreau <w@1wt.eu>, linux-kselftest@vger.kernel.org, 
	Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH v3 4/4] tools/nolibc: add signal support
Message-ID: <fbd9add3-dd99-4deb-979d-79ecfdae2f6c@t-8ch.de>
References: <20250731201225.323254-1-benjamin@sipsolutions.net>
 <20250731201225.323254-5-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731201225.323254-5-benjamin@sipsolutions.net>

Hi Benjamin,

On 2025-07-31 22:12:25+0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> Add support for sigaction() using the rt_sigaction syscall and implement
> the normal sa_mask helpers.
> 
> For the uapi definitions, everything is copied into nolibc. This avoids
> issues with kernel architecture headers that are not usable with the
> rt_sigaction syscall.
> 
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> 
> ---
> 
> v3:
> - put everything into signal.h and the new asm-signal.h

Hm, did we decide on that? We don't want the per-architecture include
dance, but static overrides should still be fine I think.
Keeping the architecture ifdeffery inside the respective arch header.
And all the generic stuff in a shared header.

> - split out sigset_t tests
> - actually mark signal_check static
> - remove unused string.h include
> - fix SIGUSR2 reset
> - Use integer for signal_check as the signals are emitted from the
>   syscall context.

I don't understand this point, isn't it a signal handler?

> v2:
> - Use newly added macros to check signal emission order
> - Add tests for sigset handling
> - Restore the default handler after signal test
> - make signal_check variable static
> 
> v1:
> - Update architecture support (adding sh)
> - Move sparc sys_rt_sigaction logic into its header
> - Add sig_atomic_t
> - Use new BITSET_* macros
> - Move test into syscall suite
> - Various other small changes
> ---
>  tools/include/nolibc/Makefile                |   1 +
>  tools/include/nolibc/arch-s390.h             |   4 +-
>  tools/include/nolibc/asm-signal.h            | 237 +++++++++++++++++++
>  tools/include/nolibc/signal.h                | 179 ++++++++++++++
>  tools/include/nolibc/sys.h                   |   2 +-
>  tools/include/nolibc/sys/wait.h              |   1 +
>  tools/include/nolibc/time.h                  |   2 +-
>  tools/include/nolibc/types.h                 |   9 +
>  tools/testing/selftests/nolibc/nolibc-test.c | 134 +++++++++++
>  9 files changed, 566 insertions(+), 3 deletions(-)
>  create mode 100644 tools/include/nolibc/asm-signal.h

(...)

> diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> index 295e71d34aba..a790e816565b 100644
> --- a/tools/include/nolibc/sys.h
> +++ b/tools/include/nolibc/sys.h
> @@ -14,7 +14,6 @@
>  
>  /* system includes */
>  #include <linux/unistd.h>
> -#include <linux/signal.h>  /* for SIGCHLD */
>  #include <linux/termios.h>
>  #include <linux/mman.h>
>  #include <linux/fs.h>
> @@ -28,6 +27,7 @@
>  #include "errno.h"
>  #include "stdarg.h"
>  #include "types.h"
> +#include "asm-signal.h" /* for SIGCHLD */

#include "signal.h"

>  /* Syscall return helper: takes the syscall value in argument and checks for an
> diff --git a/tools/include/nolibc/sys/wait.h b/tools/include/nolibc/sys/wait.h
> index 56ddb806da7f..e2aa90cc3cf3 100644
> --- a/tools/include/nolibc/sys/wait.h
> +++ b/tools/include/nolibc/sys/wait.h
> @@ -10,6 +10,7 @@
>  #ifndef _NOLIBC_SYS_WAIT_H
>  #define _NOLIBC_SYS_WAIT_H
>  
> +#include <asm/siginfo.h>

#include "signal.h"

The asm/ usage should be hidden.

>  #include "../arch.h"
>  #include "../std.h"
>  #include "../types.h"

(...)

> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> index 180f0436127a..75b96eaa4c65 100644
> --- a/tools/testing/selftests/nolibc/nolibc-test.c
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -1269,6 +1269,138 @@ int test_namespace(void)
>  	return ret;
>  }
>  
> +int test_sigset_t(int test_idx)
> +{
> +	int llen;
> +	int ret = 0;
> +
> +#ifdef NOLIBC
> +	if (is_nolibc) {

This looks unnecessary. The #ifdef should be sufficient.

> +		sigset_t sigset;
> +

(...)


Looks nice, thanks!

