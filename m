Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A0A78D0AE
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Aug 2023 01:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241172AbjH2Xj6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Aug 2023 19:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241198AbjH2Xjj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Aug 2023 19:39:39 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6C11AD;
        Tue, 29 Aug 2023 16:39:32 -0700 (PDT)
X-QQ-mid: bizesmtp77t1693352354trr4f354
Received: from linux-lab-host.localdomain ( [116.30.128.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 30 Aug 2023 07:39:12 +0800 (CST)
X-QQ-SSF: 01200000000000E0Y000000A0000000
X-QQ-FEAT: znfcQSa1hKYLaqwov7t04VUjtxnwtZct0kx84QhKLVXJX3mGDVdnB0DlQjMFW
        cenqdDiczUbcqFuxVq2xo99CfyFXuePwW98AbMwlHuGSlS4HdsmO+Ht1JON+roV1r4uEVdH
        q/HjPYb1q4pIlRJ61CpCoI6jV7AffalHlf8g32J4s3+Rb/4B6UzbTG0WxClXwcKScBzUC9j
        yG+fyNTUk8ilEepfgK2dfCu42hhiU7dZzd0A60FPmO3RLm1+e01WS1PwFqDmWKnCnSuDS2x
        Qa+skqqd43yIbYHiZH41975Hca96dzM2PZHvfBFTcPbY791cueRw4Amh3RHchvJKyuT2eS7
        jS9DnzqTZNQItIk3uwpkRL1M7G3Lg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17496907355055251835
From:   Zhangjin Wu <falcon@tinylab.org>
To:     david.laight@aculab.com
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org,
        thomas@t-8ch.de, w@1wt.eu
Subject: RE: [RFC] tools/nolibc: replace duplicated -ENOSYS return with single -ENOSYS return
Date:   Wed, 30 Aug 2023 07:39:12 +0800
Message-Id: <20230829233912.63097-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <6819b8e273dc44e18f14be148549b828@AcuMS.aculab.com>
References: <6819b8e273dc44e18f14be148549b828@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, David

> From: David Laight
> > Sent: 27 August 2023 22:52
> > 
> > ...
> > > Of course, we can also use the __stringify() trick to do so, but it is
> > > expensive (bigger size, worse performance) to unstringify and get the number
> > > again, the expensive atoi() 'works' for the numeric __NR_*, but not work for
> > > (__NR_*_base + offset) like __NR_* definitions (used by ARM and MIPS), a simple
> > > interpreter is required for such cases and it is more expensive than atoi().
> > >
> > >     /* not for ARM and MIPS */
> > >
> > >     static int atoi(const char *s);
> > >     #define __get_nr(name)          __nr_atoi(__stringify(__NR_##name))
> > >     #define __nr_atoi(str)          (str[0] == '_' ? -1L : ___nr_atoi(str))
> > >     #define ___nr_atoi(str)         (str[0] == '(' ? -1L : atoi(str))
> > >
> > > Welcome more discussion or let's simply throw away this direction ;-)
> > 
> > While it will look horrid the it ought to be possible to
> > get the compiler to evaluate the string.
> ...
> > So something that starts:
> > #define dig(c) (c < '0' || c > '9' ? 999999 : c - '0')
> > 	str[0] == '_' ? -1 :
> > 	str[0] != '(' ? str[1] == ' ' ? dig(str[0]) :
> > 		str[2] == '1' ? (dig(str[0]) * 10 + dig(str[1]) :
> > Any unexpected character will expand the 99999 and generate
> > an over-large result.
> 
> See https://godbolt.org/z/rear4c1hj
> 
> That will convert "1234" or "(1234 + 5678)" (or shorter numbers)
> as a compile-time constant.
>

Thanks very much, it works perfectly.

I tuned it for more complicated cases, including ((0x900000+0x0f0000)+5) used
by ARM+OABI (not used by nolibc), now, it should work for all of the
architectures: https://godbolt.org/z/a7hxWj83E ;-)

To get fast building, we can provide different versions for different
architectures. A simple test shows, only two versions (as you mentioned above,
one is "1234" converting, another is "(1234 + 5678)" calculating) are enough
for current nolibc supported architectures and the building of nolibc-test.c is
not slow.

With the __stringify() based __is_nr_defined() macro and this new __nrtoi()
macro based __get_nr() macro, there is no need to redefine the old NOLIBC__NR_*
macros, as a result, all of the duplicated -ENOSYS return lines and even all of
the #ifdef's from sys.h could be dropped and even no need to add them for new
future syscalls, and also, the old syscall() macro can return -ENOSYS at the
runtime instead of any compiling failures.

For the sys_* definitions, to avoid forgetting passing the arguments, instead
of using __VA_ARGS__, perhaps we should simply passing all of the arguments.

Best Regards,
Zhangjin

> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
