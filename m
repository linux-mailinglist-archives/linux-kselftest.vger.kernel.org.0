Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C123674C71B
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Jul 2023 20:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjGISdq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 9 Jul 2023 14:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjGISdp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 9 Jul 2023 14:33:45 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7012123;
        Sun,  9 Jul 2023 11:33:42 -0700 (PDT)
X-QQ-mid: bizesmtp62t1688927603tclsk3kn
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 10 Jul 2023 02:33:22 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: FCwU1VixZy9c9Sh7mKzbIInPmpaFf5dRU/cduiTKcBYHZo6BQDkVsomfwpohQ
        O5XocE0E67aRtZ7OORO3AAgJRZohbgOhUFxCytVpRHWs7OgO6PEWZDxSyGmNm6x7Y3Xb++t
        ZRjLpCQVB90bHS5bbETtpkuTCrBYz7T9SvRx+CM9oEOLwZV5m3GIl98Y10Y7iDmG7c+0w+u
        utJRuK3L9dmaSIOLug5AQpGH+ZJPtsEaVg6clKnaXGRThvZa958rx8RSOy/I5gF+n5pFhvd
        qYKgOwABgrH62IPVmzpOivvjbfZst1Cb/qvXexpMl2eUkQVKR68CFSQFP6oeOqCOIWmlekV
        o/WjJaVnEZoJ1LIXwo=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11853465242003201255
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, david.laight@aculab.com, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, thomas@t-8ch.de
Subject: Re: [PATCH v6 13/15] selftests/nolibc: add mmap_bad test case
Date:   Mon, 10 Jul 2023 02:33:22 +0800
Message-Id: <20230709183322.96859-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230709091547.GD9321@1wt.eu>
References: <20230709091547.GD9321@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

> On Fri, Jul 07, 2023 at 11:05:49PM +0800, Zhangjin Wu wrote:
> > The length argument of mmap() must be greater than 0, passing a zero
> > length argument expects failure with -EINVAL.
> 
> This one doesn't work for me on x86_64 kernel 5.15.112, qemu userland:
> 
>   46 mmap_bad = <0x0> EEXIST  != (<0xffffffffffffffff> EINVAL)    [FAIL]
>

Just rerun 'run-user' on x86_64 with kernel 5.11.0-41-generic, it is ok.

The failure is very interesting, and also rechecked the kernel mmap code:

    unsigned long do_mmap(struct file *file, unsigned long addr,
                        unsigned long len, unsigned long prot,
                        unsigned long flags, unsigned long pgoff,
                        unsigned long *populate, struct list_head *uf)
    {
        ...
        if (!len)
                return -EINVAL; 
        ...
    }

    $ git blame -L 1202,1202 mm/mmap.c
    e37609bb36f70 (Piotr Kwapulinski 2015-06-24 16:58:39 -0700 1202)        if (!len)

    $ git show e37609bb36f706c954e82e580e2e790e9d5caef8:Makefile 
    VERSION = 4
    PATCHLEVEL = 1
    SUBLEVEL = 0
    EXTRAVERSION =

So, the kernel side should be ok from v4.1?

For qemu-user, I have rechecked the following version:

    $ qemu-x86_64 --version
    qemu-x86_64 version 4.2.1 (Debian 1:4.2-3ubuntu6.18)

    $ qemu-x86_64 --version
    qemu-x86_64 version 7.0.0 (Debian 1:7.0+dfsg-7ubuntu2.6~backport20.04.202306190332~ubuntu20.04.1)

    $ build/x86_64/pc/qemu/v8.0.2/qemu-x86_64 --version
    qemu-x86_64 version 8.0.2 (v8.0.2-dirty)

all of them work well, as a comparison, what's your qemu-user version?

> This EEXIST actually is the errno from the previous test. If I run
> the test natively it's OK:
> 
>   $ ./nolibc-test syscall:46
>   Running test 'syscall'
>   46 mmap_bad = <0xffffffffffffffff> EINVAL                        [OK]
>   Errors during this test: 0
> 
> I'll queue it anyway for now but it would be nice that we figure what's
> happening (even if we need to adjust or drop the test if it's a false
> positive) so that we don't get used to "ah this is a normal error".
>

Yes, if there is a failure, we should figure out why. It is ok for me to remove
this one or let's find another errno condition before we find the root cause of
the reported failure. 

Thanks,
Zhangjin
 
> Willy
