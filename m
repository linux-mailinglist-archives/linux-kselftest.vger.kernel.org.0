Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0365674501D
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Jul 2023 20:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjGBS4q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 2 Jul 2023 14:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjGBS4l (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 2 Jul 2023 14:56:41 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31A6DCE;
        Sun,  2 Jul 2023 11:56:20 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 362Itnlj017400;
        Sun, 2 Jul 2023 20:55:49 +0200
Date:   Sun, 2 Jul 2023 20:55:49 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     thomas@t-8ch.de, arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 09/14] tools/nolibc: add missing my_syscall6() for mips
Message-ID: <20230702185549.GH16233@1wt.eu>
References: <cover.1687957589.git.falcon@tinylab.org>
 <5089ddd75a7cb01486f664c025876c803fe26d5b.1687957589.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5089ddd75a7cb01486f664c025876c803fe26d5b.1687957589.git.falcon@tinylab.org>
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

On Wed, Jun 28, 2023 at 09:37:29PM +0800, Zhangjin Wu wrote:
> It is able to pass the 6th argument like the 5th argument via the stack
> for mips, let's add a new my_syscall6() now, see [1] for details:
> 
>   The mips/o32 system call convention passes arguments 5 through 8 on
>   the user stack.
> 
> Both mmap() and pselect6() require my_syscall6().

Very interesting, I didn't manage to make it work previously. Did you
test it to confirm that it works ? I guess so but since you didn't
mention, I preferred to ask.

Thanks!
Willy
