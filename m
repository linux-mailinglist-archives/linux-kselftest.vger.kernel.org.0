Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCEF712148
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 May 2023 09:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242500AbjEZHjK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 May 2023 03:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242497AbjEZHjG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 May 2023 03:39:06 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8985BE5C;
        Fri, 26 May 2023 00:38:39 -0700 (PDT)
Date:   Fri, 26 May 2023 09:38:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1685086686; bh=XF+6CWufNGDLAepILx3DPCFSMetSIOD/MFKEUY0aVMA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nHCXqA+KwC8J23idZZf74otMGC+51r7iNTtbC1LYSbXCbhvuYpe5xkALXPGSDmhPG
         G/akZUunNRNaAXDX/1XQ+uT9SIAGcZdzflBOTogmUQPMoe0rF6V5gMGXhEsAazevsQ
         Z4QY4nf78CubV4LF+vzo/93N248sKhuOh2M/AdGY=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     w@1wt.eu, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Subject: Re: [PATCH 13/13] tools/nolibc: sys_gettimeofday: riscv: use
 __NR_clock_gettime64 for rv32
Message-ID: <29e4b23d-27cb-4101-bfe9-c6b412222578@t-8ch.de>
References: <cover.1684949267.git.falcon@tinylab.org>
 <e35cf1de35fdb0a236064ff645ae4734d32bacd4.1684949845.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e35cf1de35fdb0a236064ff645ae4734d32bacd4.1684949845.git.falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-05-25 02:03:32+0800, Zhangjin Wu wrote:
> rv32 uses the generic include/uapi/asm-generic/unistd.h and it has no
> __NR_gettimeofday and __NR_clock_gettime after kernel commit d4c08b9776b3
> ("riscv: Use latest system call ABI"), use __NR_clock_gettime64 instead.
> 
> This code is based on src/time/gettimeofday.c of musl and
> sysdeps/unix/sysv/linux/clock_gettime.c of glibc.
> 
> Both __NR_clock_gettime and __NR_clock_gettime64 are added for
> sys_gettimeofday() for they share most of the code.
> 
> Notes:
> 
> * Both tv and tz are not directly passed to kernel clock_gettime*
>   syscalls, so, it isn't able to check the pointer automatically with the
>   get_user/put_user helpers just like kernel gettimeofday syscall does.
>   instead, we emulate (but not completely) such checks in our new
>   __NR_clock_gettime* branch of nolibc.
> 
> * kernel clock_gettime* syscalls can not get tz info, just like musl and
>   glibc do, we set tz to zero to avoid a random number.
> 
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  tools/include/nolibc/sys.h | 46 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> index 2642b380c6aa..ad38cc3856be 100644
> --- a/tools/include/nolibc/sys.h
> +++ b/tools/include/nolibc/sys.h
> @@ -26,6 +26,7 @@
>  
>  #include "arch.h"
>  #include "errno.h"
> +#include "string.h"
>  #include "types.h"
>  
>  
> @@ -51,6 +52,11 @@
>   * should not be placed here.
>   */
>  
> +/*
> + * This is the first address past the end of the text segment (the program code).
> + */
> +
> +extern char etext;
>  
>  /*
>   * int brk(void *addr);
> @@ -554,7 +560,47 @@ long getpagesize(void)
>  static __attribute__((unused))
>  int sys_gettimeofday(struct timeval *tv, struct timezone *tz)
>  {
> +#ifdef __NR_gettimeofday
>  	return my_syscall2(__NR_gettimeofday, tv, tz);
> +#elif defined(__NR_clock_gettime) || defined(__NR_clock_gettime64)
> +#ifdef __NR_clock_gettime
> +	struct timespec ts;
> +#else
> +	struct timespec64 ts;
> +#define __NR_clock_gettime __NR_clock_gettime64
> +#endif
> +	int ret;
> +
> +	/* make sure tv pointer is at least after code segment */
> +	if (tv != NULL && (char *)tv <= &etext)
> +		return -EFAULT;

To me the weird etext comparisions don't seem to be worth it, to be
honest.

> +
> +	/* set tz to zero to avoid random number */
> +	if (tz != NULL) {
> +		if ((char *)tz > &etext)
> +			memset(tz, 0, sizeof(struct timezone));
> +		else
> +			return -EFAULT;
> +	}
> +
> +	if (tv == NULL)
> +		return 0;
> +
> +	ret = my_syscall2(__NR_clock_gettime, CLOCK_REALTIME, &ts);
> +	if (ret)
> +		return ret;
> +
> +	tv->tv_sec = (time_t) ts.tv_sec;
> +#ifdef __NR_clock_gettime64

Nitpick:

While this ifdef works and is correct its logic is a bit indirect.
If it is copied to some other function in the future it may be incorrect
there.

Without the #ifdef the compiler should still be able to optimize the
code away.

> +	if (tv->tv_sec != ts.tv_sec)
> +		return -EOVERFLOW;
> +#endif
> +
> +	tv->tv_usec = ts.tv_nsec / 1000;
> +	return 0;
> +#else
> +#error None of __NR_gettimeofday, __NR_clock_gettime and __NR_clock_gettime64 defined, cannot implement sys_gettimeofday()
> +#endif
>  }
>  
>  static __attribute__((unused))
> -- 
> 2.25.1
> 
