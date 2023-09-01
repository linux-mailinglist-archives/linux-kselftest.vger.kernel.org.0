Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC7C79028C
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Sep 2023 21:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350291AbjIATs6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Sep 2023 15:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236606AbjIATs6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Sep 2023 15:48:58 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA87010FB;
        Fri,  1 Sep 2023 12:48:53 -0700 (PDT)
X-QQ-mid: bizesmtp75t1693597700tvurg4sl
Received: from linux-lab-host.localdomain ( [119.123.130.254])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 02 Sep 2023 03:48:19 +0800 (CST)
X-QQ-SSF: 01200000000000E0Y000000A0000000
X-QQ-FEAT: jXjag1m6xl7V8vq+Tnca4THfX4IQyAbZCcaSwMnXfVrKGFdfMm8RciDVjTSNF
        VgfZCgWLj8yjvPbVPvfTsn6nfkMkU9QDJCj7YkAkF3wSIVT3sxcjo/9Q05Gc3g5Xrkg+Gab
        W0SZSaWnA2CEsPIh2jmvwFeKLxEsWMBc9fqlbQAnF4751Rc8vSv1/NpnENhCzfIIBInSbw4
        ZNEmUrRToyPHJomXLhIOr08WYSycawyiK45Le+wpYdvM/63yZBKYnmh2wsHjdEQ/FUnsPDq
        Qv3pQzkHCo2gvi+M/AbB2ooucYerdqV3BpJvOSwIV0baCMQ6ufqMsbgyvsWwGkJ3pp1piDp
        pohrZp6MLFgdwqc3UHv3snrtV1Lzyc3ITla+14qRsPb40JnEcAh9qIQqdNEfA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13888216478072652093
From:   Zhangjin Wu <falcon@tinylab.org>
To:     david.laight@aculab.com
Cc:     ammarfaizi2@gnuweeb.org, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tanyuan@tinylab.org, thomas@t-8ch.de, w@1wt.eu
Subject: RE: [RFC] tools/nolibc: replace duplicated -ENOSYS return with single -ENOSYS return
Date:   Sat,  2 Sep 2023 03:48:18 +0800
Message-Id: <20230901194818.6495-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <f7f06eb4a5b44ce29718341e28c823f8@AcuMS.aculab.com>
References: <f7f06eb4a5b44ce29718341e28c823f8@AcuMS.aculab.com>
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

> ...
> > We also need this style of checking for the delta logic in __atoi_add(). have
> > randomly tried different clang and gcc versions, seems all of them work
> > correctly, but the compiling speed is not that good if we want to support the
> > worst cases like "((0x900000 + 0x0f0000) + 5)", the shorter one
> > "((0x900000+0x0f0000)+5)" is used by ARM+OABI (not supported by nolibc
> > currently), therefore, we can strip some tailing branches but it is either not
> > that fast, of course, the other architectures/variants can use faster
> > __atoi_add() versions with less branches and without hex detection, comparison
> > and calculating.
> 
> If there are only a few prefix offsets then the code can be optimised
> to explicitly detect them - rather than decoding arbitrary hex values.
> After all it only needs to decode the values that actually appear.
> 
> The code also needs a compile-time assert that the result
> is constant (__buitin_constant_p() will do the check.
> But you can't use _Static_assert() to report the error
> because that requires an 'integer constant expression'.
>

Thanks a lot, your above suggestion inspired me a lot.

I have explored ARM and MIPS again and found their __NR_* definitions
have only a 'dynamic' part, that is the right part:

    arch/mips/include/generated/uapi/asm/unistd_o32.h:#define __NR_io_uring_register (__NR_Linux + 427)
    arch/mips/include/generated/uapi/asm/unistd_o32.h:#define __NR_open_tree (__NR_Linux + 428)
    arch/mips/include/generated/uapi/asm/unistd_o32.h:#define __NR_move_mount (__NR_Linux + 429)
    arch/mips/include/generated/uapi/asm/unistd_o32.h:#define __NR_fsopen (__NR_Linux + 430)
    arch/mips/include/generated/uapi/asm/unistd_o32.h:#define __NR_fsconfig (__NR_Linux + 431)

    arch/arm/include/generated/uapi/asm/unistd-eabi.h:#define __NR_io_uring_setup (__NR_SYSCALL_BASE + 425)
    arch/arm/include/generated/uapi/asm/unistd-eabi.h:#define __NR_io_uring_enter (__NR_SYSCALL_BASE + 426)
    arch/arm/include/generated/uapi/asm/unistd-eabi.h:#define __NR_io_uring_register (__NR_SYSCALL_BASE + 427)
    arch/arm/include/generated/uapi/asm/unistd-eabi.h:#define __NR_open_tree (__NR_SYSCALL_BASE + 428)
    arch/arm/include/generated/uapi/asm/unistd-eabi.h:#define __NR_move_mount (__NR_SYSCALL_BASE + 429)

The left part: __NR_Linux and __NR_SYSCALL_BASE are always defined, so,
we can get their values directly, without the need of stringify and
unstringify, as a result, the delta addition work becomes:

    base + __atoi_from(str, sizeof(#base) + 3)

And we can simply convert our old __atoi() to __atoi_from(), change the
fixed 0 'from' to a dynamic 'from'. and a simple __get_from() can help
us to get the right offset for more complicated cases, such as:
(__NR_Linux+1), (__NR_Linux + 1).

So, the new __atoi_add() becomes:

    __atoi_add(str, base):

    --> __atoi_add(__stringify(__NR_open_tree), __NR_Linux)
    --> __atoi_add("(4000 + 428)", 4000)
    --> __atoi_from("(4000 + 428)", sizeof(#4000) + 3) + 4000
    --> __atoi_from("(4000 + 428)", 8) + 4000
                      ~~~~   ^     /    ~~~~
		      base    \___/     base
		              from
    --> 428 + 4000
    --> 4428

It is very fast and the cost time is deterministic. It also works for
the most complicated case we have mentioned:

    __atoi_add("((0x900000+0x0f0000)+5)", (0x900000+0x0f0000))

    --> __atoi_from("((0x900000+0x0f0000)+5)", sizeof(#(0x900000+0x0f0000)) + 1) + (0x900000+0x0f0000)
                                          ^                   /
					   \_________________/
    --> ...
    --> 5 + (0x900000+0x0f0000)

So, the calculating of the most complicated part can be simply skipped,
we only need to convert the minimal 'dynamic' part from string to
integer and since the 'dynamic' part is not that big, most of them may
be less than 1000 in the not long future, only 4 characters and
therefore only 4-level depth branches for __atoi_from(), so, even with
hex 'dynamic' part conversion (but we may don't need it any more), the
compile speed is also very fast.

A simple local test on most of the architectures shows, the compile
speed is very near to the one with our old proposed NOLIBC__NR_* macros
for every __NR_* (defined as (-1L) when __NR_* not defined) and their
generated binary size is the same, so, we are near the ultimate solution,
but still need more tests. Thanks again for your positive suggestion!

Best regards,
Zhangjin

> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
