Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774B4721539
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jun 2023 08:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjFDGt6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 4 Jun 2023 02:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFDGt4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 4 Jun 2023 02:49:56 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DD7CA;
        Sat,  3 Jun 2023 23:49:55 -0700 (PDT)
Date:   Sun, 4 Jun 2023 08:49:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1685861394; bh=he7Gt/dLnDRqfFgQJfpayqVRYgxbXUA13XCLFO53RAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p0eoEe82HhoSDGEZUAtAVvxCh2ITgcs+FPkqX15BtOaSmLiV/u1BQ8ClsoM7+zHRw
         aNQU4UOh2M8uNS8/fNCk8xries42PY4dZ8slqKCGg6T0RebULQhalNVwKa0YzehOLD
         JSGgLPvnQejdsHuDjXpq8cSdb/Cvv4WCmk0+L4/E=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     w@1wt.eu, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 00/12] nolibc: add generic part1 of prepare for rv32
Message-ID: <9fd76795-65df-4964-bc80-fb1d4f92c402@t-8ch.de>
References: <cover.1685777982.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1685777982.git.falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-06-03 15:59:29+0800, Zhangjin Wu wrote:
> Hi, Willy
> 
> This is the v3 generic part1 for rv32, all of the found issues of v2
> part1 [1] have been fixed up, several generic patches have been fixed up
> and merged from v2 part2 [2] to this series, the standalone test_fork
> patch [4] is merged with a Reviewed-by line into this series too.
> 
> This series is based on 20230528-nolibc-rv32+stkp5 branch of [5].
> 
> Changes from v2 -> v3:
> 
> * selftests/nolibc: fix up compile warning with glibc on x86_64
> 
>   Use simpler 'long long' conversion instead of old #ifdef ...
>   (Suggestion from Willy)
> 
> * tools/nolibc: add missing nanoseconds support for __NR_statx
> 
>   Split the compound assignment into two single assignments
>   (Suggestion from Thomas)
> 
> * selftests/nolibc: add new gettimeofday test cases
> 
>   Removed the gettimeofday(NULL, &tz)
>   (Suggestion from Thomas)
> 
> All of the commit messages have been re-checked, some missing
> Suggested-by lines are added.
> 
> The whole patchset have been tested on arm, aarch64, rv32 and rv64, no
> regressions (the next compile patchset is required to do rv32 test).
> 
> The nolibc-test has been tested with glibc on x86_64 too.
> 
> Btw, we have found such poll failures on arm (not introduced by this
> patchset), this will be fixed in our coming ppoll_time64 patchset:
> 
> 48 poll_null = -1 ENOSYS                                        [FAIL]
> 49 poll_stdout = -1 ENOSYS                                      [FAIL]
> 50 poll_fault = -1 ENOSYS  != (-1 EFAULT)                       [FAIL]
> 
> And the gettimeofday_null removal patch from Thomas [3] may conflicts
> with the gettimeofday removal and addition patches, but it is not hard
> to fix.
> 
> Best regards,
> Zhangjin
> ---
> 
> [1]: https://lore.kernel.org/linux-riscv/cover.1685362482.git.falcon@tinylab.org/T/#t
> [2]: https://lore.kernel.org/linux-riscv/cover.1685387484.git.falcon@tinylab.org/T/#t
> [3]: https://lore.kernel.org/lkml/20230530-nolibc-gettimeofday-v1-1-7307441a002b@weissschuh.net/
> [4]: https://lore.kernel.org/lkml/61bdfe7bacebdef8aa9195f6f2550a5b0d33aab3.1685426545.git.falcon@tinylab.org/
> [5]: https://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git
> 
> Zhangjin Wu (12):
>   selftests/nolibc: syscall_args: use generic __NR_statx
>   tools/nolibc: add missing nanoseconds support for __NR_statx
>   selftests/nolibc: allow specify extra arguments for qemu
>   selftests/nolibc: fix up compile warning with glibc on x86_64
>   selftests/nolibc: not include limits.h for nolibc
>   selftests/nolibc: use INT_MAX instead of __INT_MAX__
>   tools/nolibc: arm: add missing my_syscall6
>   tools/nolibc: open: fix up compile warning for arm
>   selftests/nolibc: support two errnos with EXPECT_SYSER2()
>   selftests/nolibc: remove gettimeofday_bad1/2 completely
>   selftests/nolibc: add new gettimeofday test cases
>   selftests/nolibc: test_fork: fix up duplicated print
> 
>  tools/include/nolibc/arch-arm.h              | 23 +++++++++++
>  tools/include/nolibc/stdint.h                | 14 +++++++
>  tools/include/nolibc/sys.h                   | 39 +++++++++---------
>  tools/testing/selftests/nolibc/Makefile      |  2 +-
>  tools/testing/selftests/nolibc/nolibc-test.c | 42 ++++++++++++--------
>  5 files changed, 85 insertions(+), 35 deletions(-)

For the full series:

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>

> -- 
> 2.25.1
> 
