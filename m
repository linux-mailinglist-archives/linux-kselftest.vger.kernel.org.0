Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0611070A856
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 May 2023 15:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjETNc6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 20 May 2023 09:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjETNc5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 20 May 2023 09:32:57 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FDF7F7;
        Sat, 20 May 2023 06:32:55 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 34KDWbtl027582;
        Sat, 20 May 2023 15:32:37 +0200
Date:   Sat, 20 May 2023 15:32:37 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>, linux@weissschuh.net
Cc:     aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, shuah@kernel.org
Subject: Re: [PATCH] selftests/nolibc: Fix up compile error for rv32
Message-ID: <20230520133237.GA27501@1wt.eu>
References: <20230520-nolibc-stackprotector-riscv-v1-1-d8912012a034@weissschuh.net>
 <20230520120254.66315-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230520120254.66315-1-falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Thomas, Zhangjin,

I've merged your latest patches in my branch 20230520-nolibc-rv32+stkp2,
which was rebased to integrate the updated commit messages and a few
missing s-o-b from mine. Please have a look:

   https://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git

However, Thomas, I noticed something puzzling me. While I tested with
gcc-9.5 (that I have here along my toolchains) I found that it would
systematically fail:

  sysroot/x86/include/stackprotector.h:46:1: warning: 'no_stack_protector' attribute directive ignored [-Wattributes]
     46 | {
        | ^
  !!Stack smashing detected!!
  qemu: uncaught target signal 6 (Aborted) - core dumped
  0 test(s) passed.

The reason is that it doesn't support the attribute "no_stack_protector".
Upon closer investigation, I noticed that _start() on x86_64 doens't have
it, yet it works on more recent compilers! So I don't understand why it
works with more recent compilers.

I managed to avoid the crash by enclosing the __stack_chk_init() function
in a #pragma GCC optimize("-fno-stack-protector") while removing the
attribute (though Clang and more recent gcc use this attribute so we
shouldn't completely drop it either).

I consider this non-critical as we can expect that regtests are run with
a reasonably recent compiler version, but if in the long term we can find
a more reliable detection for this, it would be nice.

For example I found that gcc defines __SSP_ALL__ to 1 when
-fstack-protector is used, and 2 when -fstack-protector-all is used.
With clang, it's 1 and 3 respectively. Maybe we should use that and
drop NOLIBC_STACKPROTECTOR, that would be one less variable to deal
with: the code would automatically adapt to whatever cflags the user
sets on the compiler, which is generally better.

Regards,
Willy
