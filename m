Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6BC771615
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Aug 2023 18:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjHFQhU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 6 Aug 2023 12:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHFQhT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 6 Aug 2023 12:37:19 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF06111D;
        Sun,  6 Aug 2023 09:37:16 -0700 (PDT)
X-QQ-mid: bizesmtp90t1691339815tf3mfofw
Received: from linux-lab-host.localdomain ( [116.30.130.12])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 07 Aug 2023 00:36:54 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: XBN7tc9DADInN8U5ppsCisi3RZ5SA9E9aHrNLARhnRb83W5yceAnL7ygRBtPo
        VRi6xhmYy0FF45PiA9HVB3ovZHaIf4Ca6GWqwkqLspm4G7vv8GmEtyXZyT81U8+LHlqathU
        +hLY4bqSMNJRHAkz/PyzVpJk63lMirWrArQNpSspKfGRJa+hulIZSQifTdsrD4uRnkjFkrU
        FRZCEkdJ+HIbvviyToJDsB4nhhzv4ejKL0JAnZrHi1akmEbEpF9CWzuK2By3XsTOVC4PrHz
        kjoqORd+TYtZi7Nnk/xb5644gYX0nCwryE6nHisddkyJOJOZeg14QkWlPWNv6OKVwTuK/dP
        Dqf9+ihqImDzQtkhfWnPlYAVrJM4A==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18061832696655097200
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, david.laight@aculab.com, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        thomas@t-8ch.de
Subject: Re: [PATCH] tools/nolibc: fix up size inflate regression
Date:   Mon,  7 Aug 2023 00:36:49 +0800
Message-Id: <20230806163649.185843-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230806134348.GA19145@1wt.eu>
References: <20230806134348.GA19145@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

> On Sun, Aug 06, 2023 at 09:19:21PM +0800, Zhangjin Wu wrote:
> > As reported and suggested by Willy, the inline __sysret() helper
> > introduces three types of conversions and increases the size:
> 
> Thanks Zhangjin. A few things:
> 
> > --- a/tools/include/nolibc/compiler.h
> > +++ b/tools/include/nolibc/compiler.h
> > @@ -22,4 +22,13 @@
> >  #  define __no_stack_protector __attribute__((__optimize__("-fno-stack-protector")))
> >  #endif /* defined(__has_attribute) */
> >  
> > +/*
> > + * from include/linux/compiler.h
> > + *
> > + * Whether 'type' is a signed type or an unsigned type. Supports scalar types,
> > + * bool and also pointer types.
> > + */
> > +#define is_signed_type(type)   (((type)(-1)) < (type)1)
> > +#define is_unsigned_type(type) (!is_signed_type(type))
> 
> These names may conflict with application's local definitions. And since
> there's a single call place we should probably just inline it instead.
>

Let's remove them and define a new one with __ prefix in sys.h, it is
not readable if we simply 'inline' the comparison in the already complex
macro ;-)

> > +#define __sysret(arg)                                                           \
> > +({                                                                              \
> > +	__typeof__(arg) __sysret_arg = (arg);                                   \
> > +	if (is_signed_type(__typeof__(arg))) {                                  \
> > +		if (__sysret_arg < 0) {                                         \
> > +			SET_ERRNO(-(int)__sysret_arg);                          \
> > +			__sysret_arg = -1L;                                     \
> > +		}                                                               \
> > +	} else {                                                                \
> > +		if ((unsigned long)__sysret_arg >= (unsigned long)-MAX_ERRNO) { \
> > +			SET_ERRNO(-(int)__sysret_arg);                          \
> > +			__sysret_arg = -1L;                                     \
> > +		}                                                               \
> > +	}                                                                       \
> > +	__sysret_arg;                                                           \
> > +})
> 
> I also found during my tests that this one can return a build error if
> the arg has "const" in its type, due to the error assignment. We need
> to think about reworking it as a ternary evaluation, it will be more
> reliable even if less readable. But let's not change this now, I'm on
> the changelog already.
>

The __auto_type in new enough version does work well with 'const', but
for the old version, we need to restoring the 'long' type and the
conversion ;-(

> >  /* Functions in this file only describe syscalls. They're declared static so
> >   * that the compiler usually decides to inline them while still being allowed
> > @@ -94,7 +101,7 @@ void *sbrk(intptr_t inc)
> >  	if (ret && sys_brk(ret + inc) == ret + inc)
> >  		return ret + inc;
> >  
> > -	return (void *)__sysret(-ENOMEM);
> > +	return (void *)__sysret((unsigned long)-ENOMEM);
> 
> I noticed that one as well during my tests, but if we're purist, we're
> supposed to use (void*) for the cast and not (unsigned long), and it
> should allow to get rid of the outer cast.
>

To accept "void *", more conversions are required ...

A new 'ugly' version are ready for review soon, it compiles and get less size
on gcc-4.8 too ;-)

Thanks,
Zhangjin

> Regards,
> Willy
