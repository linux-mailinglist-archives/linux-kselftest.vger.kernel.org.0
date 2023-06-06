Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B67723634
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 06:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjFFEZw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 00:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjFFEZv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 00:25:51 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99781E9;
        Mon,  5 Jun 2023 21:25:47 -0700 (PDT)
X-QQ-mid: bizesmtp83t1686025537tyl56hli
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 06 Jun 2023 12:25:35 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: hoArX50alxEfEPP/uYMrq9xoC2wjjN8NM6dsaYFofGz7MxMU8eJ/Ut1Ckk7Di
        WlXkQq7puxHc6ZLmSXJMLKIQYMO/W7J9KnheGdVjjgOOYD4n1oDW/goqJjYxJ2UxV7z15Nh
        sCKUj5ATFdShH0fZ3Z76met6sziLiFUlLHNrDf2YbO96hOP5V/3r3Bw1lAjYrzzwZ09RQyb
        PZ7e9XDqR/mkBpOF/7WmOOKygOJ0m4AI38D/6F5KbHU1N+PPporQlCwQaJfHlnrTXLcpoC4
        fvWcXRF5lPdUzBbzJ4U5Y8l2Xuhs4UtFZA3RUVASk1v+gFSdAoFKzWx0G8yxlDHY4QjwIw5
        9c8aGuBN3AIVEJDhjG+BNN3gftyjVB7MLKLWUhyCZv0uHPHoBM=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15960807705076664772
From:   Zhangjin Wu <falcon@tinylab.org>
To:     falcon@tinylab.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de, w@1wt.eu
Subject: [PATCH v3 0/3] nolibc: add part2 of support for rv32
Date:   Tue,  6 Jun 2023 12:25:35 +0800
Message-Id: <20230606042535.354118-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685780412.git.falcon@tinylab.org>
References: <cover.1685780412.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Arnd

Because this patchset is a 'big' change derived from the idea of suggestion
from you [3], I do very welcome your feedback about this change, just like
Thomas suggested, this requires more discussion before Willy plan to determine
merge it or not.

The first two convert all compile failures to a return of -ENOSYS, if you do
like it, welcome your Reviewed-by. These two are required by the coming new
time64 syscalls for rv32, because they depends on how we cope with the
unsupported syscalls, returning -ENOSYS is really better than simply fail the
compiling.

Hi, Thomas, If you are happy with them, welcome your Reviewed-by too, thanks.
If the first two are ok, then, I can focus on preparing the left time64
patchsets.

The third one is not that urgent, because some important syscalls are
still missing for rv32. It is added here only for compile test.

Thanks,
Zhangjin

> Hi, Willy
> 
> This is the v3 part2 of support for rv32, differs from the v2 part2 [1],
> we only fix up compile issues in this patchset.
> 
> With the v3 generic part1 [2] and this patchset, we can compile nolibc
> for rv32 now.
> 
> This is based on the idea of suggestions from Arnd [3], instead of
> '#error' on the unsupported syscall on a target platform, a 'return
> -ENOSYS' allow us to compile it at first and then allow we fix up the
> test failures reported by nolibc-test one by one.
> 
> The first two patches fix up all of the compile failures with '-ENOSYS'
> (and '#ifdef' if required):
> 
>   tools/nolibc: fix up #error compile failures with -ENOSYS
>   tools/nolibc: fix up undeclared syscall macros with #ifdef and -ENOSYS
> 
> The last one enables rv32 compile support:
>   
>   selftests/nolibc: riscv: customize makefile for rv32
> 
> The above compile support patch here is only for test currently, as
> Thomas suggested, for a full rv32 support, it should wait for the left
> parts.
> 
> Welcome your feedbacks, will wait for enough discussion on this patchset
> and then send the left parts one by one to fix up the test failures
> about waitid, llseek and time64 syscalls: ppoll_time64, clock_gettime64,
> pselect6_time64.
> 
> So, I do recommend to apply this patchset, it allows us to send the left
> parts independently, otherwise, all of them should be sent out for
> review together. with this patchset, the rv32 users may be able to use
> nolibc although some syscalls still missing :-)
> 
> Or at least we apply the first two, so, I can manually cherry-pick the
> compile support patch to do my local test, and the other platform
> developer may also benefit from them.
> 
> I'm cleaning up the left parts, but still require some time, I plan to
> split them to such parts:
> 
>   * part3: waitid, prepared, will send out later
>   * part4: llseek, prepared, will send out later
>   * part5: time64 syscalls, ppoll_time64 ok, will finish them next week
>            (It is a little hard to split them)
> 
> Best regards,
> Zhangjin
> ---
> 
> [1]: https://lore.kernel.org/linux-riscv/cover.1685387484.git.falcon@tinylab.org/T/#t
> [2]: https://lore.kernel.org/linux-riscv/cover.1685777982.git.falcon@tinylab.org/T/#t
> [3]: https://lore.kernel.org/linux-riscv/5e7d2adf-e96f-41ca-a4c6-5c87a25d4c9c@app.fastmail.com/
> 
> Zhangjin Wu (3):
>   tools/nolibc: fix up #error compile failures with -ENOSYS
>   tools/nolibc: fix up undeclared syscall macros with #ifdef and -ENOSYS
>   selftests/nolibc: riscv: customize makefile for rv32
> 
>  tools/include/nolibc/sys.h              | 38 ++++++++++++++++---------
>  tools/testing/selftests/nolibc/Makefile | 11 +++++--
>  2 files changed, 34 insertions(+), 15 deletions(-)
