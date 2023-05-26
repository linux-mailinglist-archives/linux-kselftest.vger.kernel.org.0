Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C941E7120B8
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 May 2023 09:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjEZHPP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 May 2023 03:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjEZHPP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 May 2023 03:15:15 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDF0114;
        Fri, 26 May 2023 00:15:13 -0700 (PDT)
Date:   Fri, 26 May 2023 09:15:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1685085311; bh=rEZjZ7jb112xctWDeTzmzbvGkTYxGoBvCV4K9U7x4Hk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WDvP36KkQDB/msyE6X9PkQOMhUADIby45vq3TxdlP5SKnqWYJYDKLVN8940oQU5Xt
         snRCrStgmWdheBAeetdgxvwrS6ajR/r5rPA4tzQti1PzuSXiD8iotOU/IwPy5jWEGH
         oYRiMtqWVGPA3rl4VZwFBnzyj9pg3Xv74JBjLkqs=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     w@1wt.eu, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Subject: Re: [PATCH 09/13] tools/nolibc: sys_poll: riscv: use
 __NR_ppoll_time64 for rv32
Message-ID: <78d91061-1bcd-4031-89e1-706c3f49d762@t-8ch.de>
References: <cover.1684949267.git.falcon@tinylab.org>
 <ec5af2ae25264eddce4b50380bfd24f9490eca75.1684949268.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec5af2ae25264eddce4b50380bfd24f9490eca75.1684949268.git.falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-05-25 01:57:24+0800, Zhangjin Wu wrote:
> rv32 uses the generic include/uapi/asm-generic/unistd.h and it has no
> __NR_ppoll after kernel commit d4c08b9776b3 ("riscv: Use latest system
> call ABI"), use __NR_ppoll_time64 instead.
> 
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  tools/include/nolibc/std.h   | 1 +
>  tools/include/nolibc/sys.h   | 7 ++++++-
>  tools/include/nolibc/types.h | 6 ++++++
>  3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/include/nolibc/std.h b/tools/include/nolibc/std.h
> index 83c0b0cb9564..221385c0e823 100644
> --- a/tools/include/nolibc/std.h
> +++ b/tools/include/nolibc/std.h
> @@ -32,6 +32,7 @@ typedef   signed long         off_t;
>  typedef   signed long     blksize_t;
>  typedef   signed long      blkcnt_t;
>  typedef   signed long        time_t;
> +typedef     long long       time64_t;
>  typedef     long long        loff_t;
>  
>  #endif /* _NOLIBC_STD_H */
> diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> index 0ff77c0a06d7..08d38175bd7b 100644
> --- a/tools/include/nolibc/sys.h
> +++ b/tools/include/nolibc/sys.h
> @@ -923,8 +923,13 @@ int pivot_root(const char *new, const char *old)
>  static __attribute__((unused))
>  int sys_poll(struct pollfd *fds, int nfds, int timeout)
>  {
> -#if defined(__NR_ppoll)
> +#if defined(__NR_ppoll) || defined(__NR_ppoll_time64)
> +#ifdef __NR_ppoll
>  	struct timespec t;
> +#else
> +	struct timespec64 t;
> +#define __NR_ppoll __NR_ppoll_time64
> +#endif
>  
>  	if (timeout >= 0) {
>  		t.tv_sec  = timeout / 1000;
> diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
> index 15b0baffd336..ee914391439c 100644
> --- a/tools/include/nolibc/types.h
> +++ b/tools/include/nolibc/types.h
> @@ -203,6 +203,12 @@ struct stat {
>  	time_t    st_ctime;   /* time of last status change */
>  };
>  
> +/* needed by time64 syscalls */
> +struct timespec64 {
> +	time64_t	tv_sec;		/* seconds */
> +	long		tv_nsec;	/* nanoseconds */
> +};

A question to you and Willy, as it's also done the same for other types:

What is the advantage of custom definitions over using the one from the
kernel (maybe via a typedef).

From linux/time_types.h:

struct __kernel_timespec {
	__kernel_time64_t tv_set;
	long long tv_nsec;
};

> +
>  /* WARNING, it only deals with the 4096 first majors and 256 first minors */
>  #define makedev(major, minor) ((dev_t)((((major) & 0xfff) << 8) | ((minor) & 0xff)))
>  #define major(dev) ((unsigned int)(((dev) >> 8) & 0xfff))
> -- 
> 2.25.1
> 
