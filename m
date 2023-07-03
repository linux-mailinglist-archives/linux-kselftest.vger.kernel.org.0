Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5631745772
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jul 2023 10:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjGCIhT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jul 2023 04:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjGCIhS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jul 2023 04:37:18 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AFEE50;
        Mon,  3 Jul 2023 01:37:09 -0700 (PDT)
X-QQ-mid: bizesmtp77t1688373413t8yeuy3h
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 03 Jul 2023 16:36:52 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: cbck7jzG4waxmtAyZOM8J8Vsk/O4lRHB8gEo7BxRdBy9c92QqQQ4tlBc7MY9E
        KAm4AlasFZ94a+Plz1Tc4zhbDw9VdqGMVSwXdRq/LGR8CslVesPAIiuK4/+Dx7yUlHm1/Ww
        EcxZWW+2L23J96t2HzAb9wggbf5SowHJS7L+9UAB/GgxFr0Rcs19VRsre7fQnONONJAR+iP
        TAYvAdoIO+/6bF4ESE0/4wL3WDYOcsQK/pDbeAbjCeN3sVKVJHxWbuyQvfwuWZZuVi/xfyw
        aMIS3mh6uT1bt5WWWu/pOljmrTjkKPCEaP5oeYr55WwvX71brL+RO3OPGlUTuQpgFqIuhKk
        XOZE3hrfN9A5LZ0kBFZl1WW06EImp3GJDu0x8RMUdkMnoWMRpddF4O1WxdDSN9bD35RpZP2
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12812962611774565405
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu, arnd@arndb.de, david.laight@aculab.com, thomas@t-8ch.de
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 10/14] tools/nolibc: __sysret: support syscalls who return a pointer
Date:   Mon,  3 Jul 2023 16:36:51 +0800
Message-Id: <20230703083651.491785-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230702191733.GI16233@1wt.eu>
References: <20230702191733.GI16233@1wt.eu>
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

> On Wed, Jun 28, 2023 at 09:39:56PM +0800, Zhangjin Wu wrote:
> > To support syscalls (e.g. mmap()) who return a pointer and to allow the
> > pointer as big as possible, we should convert the negated errno value to
> > unsigned long (uintptr_t), otherwise, in signed long, a potential big
> > pointer (whose highest bit is 1) will be treated as a failure.
> > 
> > tools/include/nolibc/errno.h defines the MAX_ERRNO, let's use it
> > directly.
> 
> It might or might not work, it's an ABI change that, if validated, at
> least needs a much more detailed explanation. What matters is not what
> errno values we're willing to consider as an error, but what the
> *syscalls* themselves return as an error. If a syscall says "< 0 is an
> error equal to -errno", it means that we must treat it as an error,
> and extract its value to get errno. If that errno is larger than
> MAX_ERRNO it just means we don't know what the error is.
>

Yes, we do need to find a 'spec' or 'standard' to follow.

welcome suggestions from Arnd, Thomas and also David.

> Syscalls that return pointer use that -MAX_ERRNO range to encode errors
> (such as mmap()). I just do not know if there is a convention saying that
> other ones also restrict themselves to that range or not. If you find
> some info which guarantees that it's the case for all of them, then by
> all means let's proceed like this, but in this case it should be mentioned
> in the comment why we think it's valid to do this. For now it's presented
> as an opportunity only.

Currently, I only found a prove-in-use case in musl:

    https://elixir.bootlin.com/musl/latest/source/src/internal/syscall_ret.c:

    #include <errno.h>
    #include "syscall.h"

    long __syscall_ret(unsigned long r)
    {
    	if (r > -4096UL) {
    		errno = -r;
    		return -1;
    	}
    	return r;
    }

Our new implementation (based on the one used by mmap()) is almostly the same
as musl. Not sure if this is enough. I have tried to 'git blame' on
__syscall_ret() of musl to find some clue, but failed, because the function has
been added before importing into its git repo.

> 
> Also, the rest of the commit message regarding uintptr_t (which we don't
> use), bit values and modular arithmetics is extremely confusing and not
> needed at all. What matters is only to know if we need to consider only
> values -MAX_ERRNO..-1 as error or all negative ones. If so, then it's
> obvious that ret >= (unsigned long)-MAX_ERRNO catches them all, as the
> current mmap() function already does with -4095UL.
>

Yes, will clean up the commit message, but at first, let's continue get
more information about which one is ok:

- -MAX_ERRNO..-1 as error, for sys_mmap (we know in nolibc) currently

- all negative ones, for others currently

> I just don't know where to check if we can generalize that test. In the
> worst case we could have two __sys_ret(), the current one and a second
> one for pointers. But I would suspect we could generalize due to ptrace,
> as there it makes sense to be able to detect failures, even unknown ones.
> I just need something more convincing than an intuition for a commit
> message and to take such a change :-/
>

Of course, must be clear enough.

Best regards,
Zhangjin

> Thanks!
> Willy
