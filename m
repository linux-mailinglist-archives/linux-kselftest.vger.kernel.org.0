Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF69177273A
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Aug 2023 16:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjHGONb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 10:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbjHGONa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 10:13:30 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F335CE53;
        Mon,  7 Aug 2023 07:13:25 -0700 (PDT)
X-QQ-mid: bizesmtp86t1691417575tcjpc2mz
Received: from linux-lab-host.localdomain ( [116.30.130.12])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 07 Aug 2023 22:12:53 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: Fc2LLDWeHZ+nR+5cfJg6QxzjqIcbKDbNzrvy1zplnpYJRlW14iNG274IzKXPX
        4l4rIhkpYAYpOOAuoryivBQEL6g/FUb8T8Uo+Lyp36PEkV+0A+ZHyVAIkcozcGBQ8KZBZdg
        HUowF4+cjZIQx8Lm+6xBmm2lF2atk9nRM7L2jY9RQpHFQU9kxNjmE2UNfFWMlCN2fM0sSFi
        8xFX6o3lmrgsipUSB6cTk3EriP1DF7FZuiLA4qFsK0JxYAZFddpdHCAGwC7ejbzanAQdjUB
        bsma9Qw/Ww4YB41lnxSA0ypYlQJibYh9bCys1hySEqJ5x1G73oOPXtFATGImrkYb8I6OFbt
        b/ZOGwAnLO6fRhzT5x/P4S/lJBKDB4avnj77BLU0SbO+OYSUNHgLZkEmv+CUw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13948958742550991541
From:   Zhangjin Wu <falcon@tinylab.org>
To:     david.laight@aculab.com
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de, w@1wt.eu
Subject: RE: [PATCH v3] tools/nolibc: fix up size inflate regression
Date:   Mon,  7 Aug 2023 22:12:52 +0800
Message-Id: <20230807141252.24482-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <f51e54bcf470451ea36f24640f000e61@AcuMS.aculab.com>
References: <f51e54bcf470451ea36f24640f000e61@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, David

> From: Zhangjin Wu
> > Sent: 07 August 2023 06:58
> ...
> > +/* __auto_type is used instead of __typeof__ to workaround the build error
> > + * 'error: assignment of read-only variable' when the argument has 'const' in
> > + * the type, but __auto_type is a new feature from newer gcc version and it
> > + * only works with 'const' from gcc 11.0 (__GXX_ABI_VERSION = 1016)
> > + * https://gcc.gnu.org/legacy-ml/gcc-patches/2013-11/msg01378.html
> > + */
> 
> You can use typeof((x) + 0) to lose the 'const' flag.
> The only downside is that char/short become int.
>

Great, thanks!

let's use it, and at least kill the branch using fixed 'long' type.

    #if __GXX_ABI_VERSION >= 1016
    #define __typeofdecl(arg) __auto_type
    #else
    #define __typeofdecl(arg) __typeof__(arg)
    #endif

    #define __sysret(arg)                                                    \
    ({                                                                       \
            __typeofdecl((arg) + 0) __ret = (arg);                           \
            if (__is_signed_type(__typeof__(arg))) {                         \
                    if ((long)__ret < 0) {                                   \
                            SET_ERRNO(-(long)__ret);                         \
                            __ret = (__typeof__(arg))-1L;                    \
                    }                                                        \
            } else {                                                         \
                    if ((unsigned long)__ret >= (unsigned long)-MAX_ERRNO) { \
                            SET_ERRNO(-(long)__ret);                         \
                            __ret = (__typeof__(arg))-1L;                    \
                    }                                                        \
            }                                                                \
            __ret;                                                           \
    })

My simple test on nolibc-test shows David's typeof solution does give
the same size result like __auto_type.

what's your suggestion? simply give up the '__auto_type' stuff and use
the generic __typeof__ version?

Willy, could you please test David's typeof solution on the one which
have 3-4% size inflating? or any other big programs using nolibc.

> > +
> > +#if __GXX_ABI_VERSION >= 1016
> > +#define __GXX_HAS_AUTO_TYPE_WITH_CONST_SUPPORT
> > +#endif
> > +
> > +#ifdef __GXX_HAS_AUTO_TYPE_WITH_CONST_SUPPORT
> > +#define __sysret(arg)                                                    \
> > +({                                                                       \
> > +	__auto_type __ret = (arg);                                       \
> > +	if (__is_signed_type(__typeof__(arg))) {                         \
> > +		if (__ret < 0) {                                         \
> > +			SET_ERRNO(-(long)__ret);                         \
> > +			__ret = (__typeof__(arg))(-1L);                  \
> > +		}                                                        \
> > +	} else {                                                         \
> > +		if ((unsigned long)__ret >= (unsigned long)-MAX_ERRNO) { \
> > +			SET_ERRNO(-(long)__ret);                         \
> > +			__ret = (__typeof__(arg))(-1L);                  \
> > +		}                                                        \
> > +	}                                                                \
> > +	__ret;                                                           \
> > +})
> > +
> > +#else  /* ! __GXX_HAS_AUTO_TYPE_WITH_CONST_SUPPORT */
> > +#define __sysret(arg)                                                    \
> > +({                                                                       \
> > +	long __ret = (long)(arg);                                        \
> > +	if (__is_signed_type(__typeof__(arg))) {                         \
> > +		if (__ret < 0) {                                         \
> > +			SET_ERRNO(-__ret);                               \
> > +			__ret = -1L;                                     \
> > +		}                                                        \
> > +	} else {                                                         \
> > +		if ((unsigned long)__ret >= (unsigned long)-MAX_ERRNO) { \
> > +			SET_ERRNO(-__ret);                               \
> > +			__ret = -1L;                                     \
> > +		}                                                        \
> > +	}                                                                \
> > +	(__typeof__(arg))__ret;                                          \
> > +})
> > +#endif /* ! __GXX_HAS_AUTO_TYPE_WITH_CONST_SUPPORT */
> 
> with (retyped so it may be wrong):
> #define is_constexpr(x) sizeof(*(0 ? (void *)((long)(x) * 0) : (int *)0)) == 1)
> and (because even (void *)0 isn't completely constant):
> #define is_pointer(x) (!is_constexpr((typeof(x))0))
> 
> You can probably do:
> #define __sysret(arg) \
> ({ \
> 	typeof((arg) + 0) __ret = arg; \
> 	if (__built_choose_expr(is_pointer(arg), (unsigned long)-(MAX_ERRNO+1), __ret) \
> 			< (__built_choose_expr(is_pointer(arg), (unsigned long)__ret, 0)) { \
> 		SET_ERRNO(-__ret); \
> 		__reg = typeof(ret)-1L; \
> 	} \
> 	__ret; \
> })
> 
> Apart from the annoyance of having to reverse the conditional
> that only has one copy of the check.
> 
> Using two __builtin_choose_expr() saves you having to write two
> comparisons that are valid for both pointer and integer.
>

It works perfectly.

    /*
     * This returns a constant expression while determining if an argument is
     * a constant expression, most importantly without evaluating the argument.
     * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
     * (from include/linux/const.h)
     */

    #define __is_constexpr(x) \
            (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))

    #define __is_pointer(x) (!__is_constexpr((__typeof__(x))0))

    #define __sysret(arg)                                                                      \
    ({                                                                                         \
            __typeofdecl((arg) + 0) __ret = (arg);                                             \
            if (__builtin_choose_expr(__is_pointer(arg), (unsigned long)-(MAX_ERRNO + 1), ((long)__ret)) \
                    < __builtin_choose_expr(__is_pointer(arg), (unsigned long)__ret, 0)) {      \
                    SET_ERRNO(-(long)__ret);                                                   \
                    __ret = (__typeof__(arg))-1L;                                              \
            }                                                                                  \
            __ret;                                                                             \
    })

I have tried the 'is_constexpr()' macro but failed and didn't look into
it, your explanation here [1] is very clear:

    You'll find that (void *)0 isn't 'constant enough' for
    is_constexpr() - so is_constexpr((type)0) can be used
    to detect pointer types.

Best regards,
Zhangjin
---
[1]: https://lore.kernel.org/lkml/a1732bbffd1542d3b9dd34c92f45076c@AcuMS.aculab.com/

> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
