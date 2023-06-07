Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13C17270A7
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jun 2023 23:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjFGVlV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 17:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbjFGVlT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 17:41:19 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4751FEB;
        Wed,  7 Jun 2023 14:41:17 -0700 (PDT)
Date:   Wed, 7 Jun 2023 23:41:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1686174075; bh=k1LN+P1OrnEuCtY5mNXGFc8mHGM41YmXWnusFCK8Ito=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n3gIjf5J7A+HkRFvT9Eh57idzGUaN1U6Zh5ew+amecHo0lvyQlaSc9sD3EAccTLFv
         7KjCkdQ+Qz3LEJEYRNG+D0DNGR3iyNWfCd/rSAnGccr/8tVeRCWxcuM4qH+MOeZpuI
         Q5TmE+OijMNbIKmXKJO11uE9cZpp6tfYz532qsMA=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     w@1wt.eu, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 0/3] tools/nolibc: add a new syscall helper
Message-ID: <87e7a391-b97b-4001-b12a-76d20790563e@t-8ch.de>
References: <cover.1686135913.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1686135913.git.falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-06-07 19:28:58+0800, Zhangjin Wu wrote:
> Willy, Thomas
> 
> This is the revision of the v2 syscall helpers [1], it is based on
> 20230606-nolibc-rv32+stkp7a of [2]. It doesn't conflict with the v4 of
> -ENOSYS patchset [3], so, it is ok to simply merge both of them.
> 
> This revision mainly applied Thomas' method, removed the __syscall()
> helper and replaced it with __sysret() instead, because __syscall()
> looks like _syscall() and syscall(), it may mixlead the developers.
> 
> Changes from v2 -> v3:
> 
> * tools/nolibc: sys.h: add a syscall return helper
> 
>   * The __syscall() is removed.
> 
>   * Align the code style of __sysret() with the others, and use
>     __inline__ instead of inline (like stdlib.h) to let it work with
>     the default -std=c89 in tools/testing/selftests/nolibc/Makefile
> 
> * tools/nolibc: unistd.h: apply __sysret() helper
> 
>   As v2.
> 
> * tools/nolibc: sys.h: apply __sysret() helper
> 
>   replaced __syscall() with __sysret() and merged two separated patches of v2 to one.
> 
> Did run-user tests for rv32 (with [3]), rv64 and arm64.
> 
> BTW, two questions for Thomas,
> 
> * This commit 659a49abc9c2 ("tools/nolibc: validate C89 compatibility")
>   enables -std=c89, why not gnu11 used by kernel ? ;-)

Because nolibc needs to support whatever its users need.
As nolibc is header-only all of it needs to work everywhere.
C89 should work for everybody :-)

The kernel on the other hand is compiled standalone and is not limited
by its users.

See the discussion here:

https://lore.kernel.org/all/20230328-nolibc-c99-v2-0-c989f2289222@weissschuh.net/
https://lore.kernel.org/all/20230328-nolibc-c99-v1-1-a8302fb19f19@weissschuh.net/

> * Do we need to tune the order of the macros in unistd.h like this:
> 
>     #define _syscall(N, ...) __sysret(my_syscall##N(__VA_ARGS__))
>     #define _syscall_n(N, ...) _syscall(N, __VA_ARGS__)
>     #define __syscall_narg(_0, _1, _2, _3, _4, _5, _6, N, ...) N
>     #define _sycall_narg(...) __syscall_narg(__VA_ARGS__, 6, 5, 4, 3, 2, 1, 0)
>     #define syscall(...) _syscall_n(_sycall_narg(__VA_ARGS__), ##__VA_ARGS__)
> 
>   Before, It works but seems not put in using order:
> 
>     #define _syscall(N, ...) __sysret(my_syscall##N(__VA_ARGS__))
>     #define _sycall_narg(...) __syscall_narg(__VA_ARGS__, 6, 5, 4, 3, 2, 1, 0)
>     #define __syscall_narg(_0, _1, _2, _3, _4, _5, _6, N, ...) N
>     #define _syscall_n(N, ...) _syscall(N, __VA_ARGS__)
>     #define syscall(...) _syscall_n(_sycall_narg(__VA_ARGS__), ##__VA_ARGS__)

Not sure it makes a big difference.
If you want to change it, go for it.

> Thanks.
> 
> Best regards,
> Zhangjin
> 
> ---
> [1]: https://lore.kernel.org/linux-riscv/cover.1686036862.git.falcon@tinylab.org/
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git
> [3]: https://lore.kernel.org/linux-riscv/cover.1686128703.git.falcon@tinylab.org/T/#t
> 
> Zhangjin Wu (3):
>   tools/nolibc: sys.h: add a syscall return helper
>   tools/nolibc: unistd.h: apply __sysret() helper
>   tools/nolibc: sys.h: apply __sysret() helper
> 
>  tools/include/nolibc/sys.h    | 364 +++++-----------------------------
>  tools/include/nolibc/unistd.h |  11 +-
>  2 files changed, 55 insertions(+), 320 deletions(-)

For the full series:

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>

Thanks,
Thomas
