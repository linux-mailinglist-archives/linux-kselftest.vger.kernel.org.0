Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE83745052
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Jul 2023 21:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjGBTRy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 2 Jul 2023 15:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjGBTRx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 2 Jul 2023 15:17:53 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A6C59B;
        Sun,  2 Jul 2023 12:17:46 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 362JHXHa017494;
        Sun, 2 Jul 2023 21:17:33 +0200
Date:   Sun, 2 Jul 2023 21:17:33 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     thomas@t-8ch.de, arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 10/14] tools/nolibc: __sysret: support syscalls who
 return a pointer
Message-ID: <20230702191733.GI16233@1wt.eu>
References: <cover.1687957589.git.falcon@tinylab.org>
 <72d948095d22c3ba4e69d98877addcea49a326c6.1687957589.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72d948095d22c3ba4e69d98877addcea49a326c6.1687957589.git.falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 28, 2023 at 09:39:56PM +0800, Zhangjin Wu wrote:
> To support syscalls (e.g. mmap()) who return a pointer and to allow the
> pointer as big as possible, we should convert the negated errno value to
> unsigned long (uintptr_t), otherwise, in signed long, a potential big
> pointer (whose highest bit is 1) will be treated as a failure.
> 
> tools/include/nolibc/errno.h defines the MAX_ERRNO, let's use it
> directly.

It might or might not work, it's an ABI change that, if validated, at
least needs a much more detailed explanation. What matters is not what
errno values we're willing to consider as an error, but what the
*syscalls* themselves return as an error. If a syscall says "< 0 is an
error equal to -errno", it means that we must treat it as an error,
and extract its value to get errno. If that errno is larger than
MAX_ERRNO it just means we don't know what the error is.

Syscalls that return pointer use that -MAX_ERRNO range to encode errors
(such as mmap()). I just do not know if there is a convention saying that
other ones also restrict themselves to that range or not. If you find
some info which guarantees that it's the case for all of them, then by
all means let's proceed like this, but in this case it should be mentioned
in the comment why we think it's valid to do this. For now it's presented
as an opportunity only.

Also, the rest of the commit message regarding uintptr_t (which we don't
use), bit values and modular arithmetics is extremely confusing and not
needed at all. What matters is only to know if we need to consider only
values -MAX_ERRNO..-1 as error or all negative ones. If so, then it's
obvious that ret >= (unsigned long)-MAX_ERRNO catches them all, as the
current mmap() function already does with -4095UL.

I just don't know where to check if we can generalize that test. In the
worst case we could have two __sys_ret(), the current one and a second
one for pointers. But I would suspect we could generalize due to ptrace,
as there it makes sense to be able to detect failures, even unknown ones.
I just need something more convincing than an intuition for a commit
message and to take such a change :-/

Thanks!
Willy
