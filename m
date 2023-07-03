Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556DD7459DE
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jul 2023 12:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjGCKOK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jul 2023 06:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGCKOK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jul 2023 06:14:10 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EA1DD;
        Mon,  3 Jul 2023 03:14:07 -0700 (PDT)
X-QQ-mid: bizesmtp62t1688379232tkl6910g
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 03 Jul 2023 18:13:51 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: +ynUkgUhZJmRgMk64lNbZvav6NA7MhEGUtOANAStIGSLiFHATIZ01J/qbTMxh
        LmahML3fuiEGq78NrYI0qrWi3uraDQj5ug3lHYzbbD+UkEaXq4Z6jAdLvi4oFizHTmcsYqI
        /CeFtQP9xAEC+AqN0RjhrLvlnyQIFvB9VQ9QYMH2kAKIzyP0cfpCGMYqrbhXz9IULKrXSRb
        y4ql2CbfJm05AoLvNgwLPLAhLtB2hl7u0BoytYsfTgQp3BcJIAh8PBaRBhp3+pIyPgEoBSK
        AeyQ4J2yP3bRHATN7W+Vj95Q9nKpsshpSMoBjJvO5iu4p+0QAUXTYgDLwlJoBuaBRlW01JW
        J+Gq4DqT40KnfFje70Jfh6W6kANcVjTRLyEWRet+y61442zeerDCNanTNmbHZmrIEjK+1mJ
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13818321821494681635
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, david.laight@aculab.com, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, thomas@t-8ch.de
Subject: Re: [PATCH v5 09/14] tools/nolibc: add missing my_syscall6() for mips
Date:   Mon,  3 Jul 2023 18:13:50 +0800
Message-Id: <20230703101350.493374-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230702185549.GH16233@1wt.eu>
References: <20230702185549.GH16233@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

> Hi Zhangjin,
> 
> On Wed, Jun 28, 2023 at 09:37:29PM +0800, Zhangjin Wu wrote:
> > It is able to pass the 6th argument like the 5th argument via the stack
> > for mips, let's add a new my_syscall6() now, see [1] for details:
> > 
> >   The mips/o32 system call convention passes arguments 5 through 8 on
> >   the user stack.
> > 
> > Both mmap() and pselect6() require my_syscall6().
> 
> Very interesting, I didn't manage to make it work previously. Did you
> test it to confirm that it works ? I guess so but since you didn't
> mention, I preferred to ask.
>

Yes, I'm curious too ;-) 

we did add the mmap test cases and run it for mips, as Thomas
suggested, we pass a none-zero pa_offset to mmap() to make sure the 6th
argument is used.

I just re-tested it for mips and printed something like this:

    44 mmap_bad = <0xffffffff> EINVAL                                [OK]
    45 munmap_bad = -1 EINVAL                                        [OK]
    46 mmap_munmap_good
    pa_offset: 8192
    length: 1
    file_size: 12287
     = 0                                          [OK]
    47 open_tty = 3                                                  [OK]
    48 open_blah = -1 ENOENT                                         [OK]

And I also checked the mips support of musl, it evan provide a
__syscall7, so, it should be ok ;-)

The only difference is, musl provide a different clobber list for
'__mips_isa_rev >= 6', I didn't look into the details yet:
https://elixir.bootlin.com/musl/latest/source/arch/mips/syscall_arch.h

Best regards,
Zhangjin

> Thanks!
> Willy
