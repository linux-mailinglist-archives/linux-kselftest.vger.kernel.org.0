Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890CA71389B
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 May 2023 10:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjE1IAL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 28 May 2023 04:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjE1IAK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 28 May 2023 04:00:10 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2B49DF;
        Sun, 28 May 2023 01:00:08 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 34S7xt8x001992;
        Sun, 28 May 2023 09:59:55 +0200
Date:   Sun, 28 May 2023 09:59:55 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, thomas@t-8ch.de
Subject: Re: [PATCH 00/13] tools/nolibc: riscv: Add full rv32 support
Message-ID: <20230528075955.GE1956@1wt.eu>
References: <cover.1684949267.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1684949267.git.falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,SORTED_RECIPS,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin,

On Thu, May 25, 2023 at 01:33:14AM +0800, Zhangjin Wu wrote:
> Hi, Willy
> 
> Thanks very mush for your kindly review, discuss and suggestion, now we
> get full rv32 support ;-)
> 
> In the first series [1], we have fixed up the compile errors about
> _start and __NR_llseek for rv32, but left compile errors about tons of
> time32 syscalls (removed after kernel commit d4c08b9776b3 ("riscv: Use
> latest system call ABI")) and the missing fstat in nolibc-test.c [2],
> now we have fixed up all of them.

(...)

I have read the comments that others made on the series and overall
agree. I've seen that you intend to prepare a v2. I think we must
first decide how to better deal with emulated syscalls as I said in
an earlier message. Probably that we should just add a specific test
case for EFAULT in nolibc-test since it's the only one (I think) that
risks to trigger crashes with emulated syscalls. We could also imagine
dealing with the signal ourselves but I'm not that keen on going to
implement signal() & longjmp() for now :-/

Regardless, in order to clean the things up and relieve you from the
non-rv32 stuff, I've just reverted the two patches that your series
reverts (1 & 2), and added the EOVERFLOW one (3). I'm pushing this to
branch 20230528-nolibc-rv32+stkp5.

Regards,
Willy
