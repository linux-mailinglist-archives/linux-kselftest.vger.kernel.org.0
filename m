Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2982771569
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Aug 2023 15:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjHFNoM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 6 Aug 2023 09:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjHFNoL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 6 Aug 2023 09:44:11 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 426E1E7;
        Sun,  6 Aug 2023 06:43:59 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 376Dhm1A019399;
        Sun, 6 Aug 2023 15:43:48 +0200
Date:   Sun, 6 Aug 2023 15:43:48 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        thomas@t-8ch.de
Subject: Re: [PATCH] tools/nolibc: fix up size inflate regression
Message-ID: <20230806134348.GA19145@1wt.eu>
References: <20230806131921.52453-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230806131921.52453-1-falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Aug 06, 2023 at 09:19:21PM +0800, Zhangjin Wu wrote:
> As reported and suggested by Willy, the inline __sysret() helper
> introduces three types of conversions and increases the size:

Thanks Zhangjin. A few things:

> --- a/tools/include/nolibc/compiler.h
> +++ b/tools/include/nolibc/compiler.h
> @@ -22,4 +22,13 @@
>  #  define __no_stack_protector __attribute__((__optimize__("-fno-stack-protector")))
>  #endif /* defined(__has_attribute) */
>  
> +/*
> + * from include/linux/compiler.h
> + *
> + * Whether 'type' is a signed type or an unsigned type. Supports scalar types,
> + * bool and also pointer types.
> + */
> +#define is_signed_type(type)   (((type)(-1)) < (type)1)
> +#define is_unsigned_type(type) (!is_signed_type(type))

These names may conflict with application's local definitions. And since
there's a single call place we should probably just inline it instead.

> +#define __sysret(arg)                                                           \
> +({                                                                              \
> +	__typeof__(arg) __sysret_arg = (arg);                                   \
> +	if (is_signed_type(__typeof__(arg))) {                                  \
> +		if (__sysret_arg < 0) {                                         \
> +			SET_ERRNO(-(int)__sysret_arg);                          \
> +			__sysret_arg = -1L;                                     \
> +		}                                                               \
> +	} else {                                                                \
> +		if ((unsigned long)__sysret_arg >= (unsigned long)-MAX_ERRNO) { \
> +			SET_ERRNO(-(int)__sysret_arg);                          \
> +			__sysret_arg = -1L;                                     \
> +		}                                                               \
> +	}                                                                       \
> +	__sysret_arg;                                                           \
> +})

I also found during my tests that this one can return a build error if
the arg has "const" in its type, due to the error assignment. We need
to think about reworking it as a ternary evaluation, it will be more
reliable even if less readable. But let's not change this now, I'm on
the changelog already.

>  /* Functions in this file only describe syscalls. They're declared static so
>   * that the compiler usually decides to inline them while still being allowed
> @@ -94,7 +101,7 @@ void *sbrk(intptr_t inc)
>  	if (ret && sys_brk(ret + inc) == ret + inc)
>  		return ret + inc;
>  
> -	return (void *)__sysret(-ENOMEM);
> +	return (void *)__sysret((unsigned long)-ENOMEM);

I noticed that one as well during my tests, but if we're purist, we're
supposed to use (void*) for the cast and not (unsigned long), and it
should allow to get rid of the outer cast.

Regards,
Willy
