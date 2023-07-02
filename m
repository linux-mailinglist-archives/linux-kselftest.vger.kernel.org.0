Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48775744EAC
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Jul 2023 18:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjGBQvl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 2 Jul 2023 12:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjGBQvk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 2 Jul 2023 12:51:40 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1CBCB18B;
        Sun,  2 Jul 2023 09:51:38 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 362GpRrH016840;
        Sun, 2 Jul 2023 18:51:27 +0200
Date:   Sun, 2 Jul 2023 18:51:27 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: Re: [PATCH v5 1/5] tools/nolibc: fix up #error compile failures with
 -ENOSYS
Message-ID: <20230702165127.GC16233@1wt.eu>
References: <cover.1687176996.git.falcon@tinylab.org>
 <1a823ba7b250ba5190f802dfc4428d4e248f71b3.1687176996.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a823ba7b250ba5190f802dfc4428d4e248f71b3.1687176996.git.falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin,

On Mon, Jun 19, 2023 at 08:24:15PM +0800, Zhangjin Wu wrote:
> Compiling nolibc for rv32 got such errors:
> 
>     In file included from nolibc/sysroot/riscv/include/nolibc.h:99,
>                      from nolibc/sysroot/riscv/include/errno.h:26,
>                      from nolibc/sysroot/riscv/include/stdio.h:14,
>                      from tools/testing/selftests/nolibc/nolibc-test.c:12:
>     nolibc/sysroot/riscv/include/sys.h:946:2: error: #error Neither __NR_ppoll nor __NR_poll defined, cannot implement sys_poll()
>       946 | #error Neither __NR_ppoll nor __NR_poll defined, cannot implement sys_poll()
>           |  ^~~~~
>     nolibc/sysroot/riscv/include/sys.h:1062:2: error: #error None of __NR_select, __NR_pselect6, nor __NR__newselect defined, cannot implement sys_select()
>      1062 | #error None of __NR_select, __NR_pselect6, nor __NR__newselect defined, cannot implement sys_select()
> 
> If a syscall is not supported by a target platform, 'return -ENOSYS' is
> better than '#error', which lets the other syscalls work as-is and
> allows developers to fix up the test failures reported by nolibc-test
> one by one later.
> 
> This converts all of the '#error' to 'return -ENOSYS', so, all of the
> '#error' failures are fixed.

Yeah, I like this! Initially we wanted the ifdef to spot include file
issues (which were the major concern at the beginning), and the selftest
was very limited. But now the coverage has significantly improved, the
major concern is cross-platform support and we know we won't get all of
it at once, so -ENOSYS is far better.

Thanks for this!
Willy
