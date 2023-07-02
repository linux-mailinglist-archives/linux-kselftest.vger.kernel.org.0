Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42952744EBB
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Jul 2023 19:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjGBRUN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 2 Jul 2023 13:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjGBRUN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 2 Jul 2023 13:20:13 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E672C3;
        Sun,  2 Jul 2023 10:20:12 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 362HJxGJ017048;
        Sun, 2 Jul 2023 19:19:59 +0200
Date:   Sun, 2 Jul 2023 19:19:59 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: Re: [PATCH v5 0/5] nolibc: add part2 of support for rv32
Message-ID: <20230702171959.GE16233@1wt.eu>
References: <cover.1687176996.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687176996.git.falcon@tinylab.org>
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

On Mon, Jun 19, 2023 at 08:22:43PM +0800, Zhangjin Wu wrote:
> Hi, Willy
> 
> This is the revision of the v4 part2 of support for rv32 [1], this
> further split the generic KARCH code out of the old rv32 compile patch
> and also add kernel specific KARCH and nolibc specific NARCH for
> tools/include/nolibc/Makefile too.
(...)
> [1]: https://lore.kernel.org/linux-riscv/cover.1686128703.git.falcon@tinylab.org/
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/
> 
> Zhangjin Wu (5):
>   tools/nolibc: fix up #error compile failures with -ENOSYS
>   tools/nolibc: fix up undeclared syscall macros with #ifdef and -ENOSYS

I already queued these two ones to relieve you from them while we
discuss the arch customization.

Thanks,
Willy
