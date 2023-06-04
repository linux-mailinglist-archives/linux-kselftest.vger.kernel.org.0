Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A95372175C
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jun 2023 15:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjFDNU1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 4 Jun 2023 09:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjFDNU0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 4 Jun 2023 09:20:26 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E121B8;
        Sun,  4 Jun 2023 06:20:24 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 354DKBHP002547;
        Sun, 4 Jun 2023 15:20:11 +0200
Date:   Sun, 4 Jun 2023 15:20:11 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Zhangjin Wu <falcon@tinylab.org>, thomas@t-8ch.de
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: nolibc patches, still possible for 6.5 ?
Message-ID: <ZHyPi29q3MKiNAQZ@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Paul,

Thomas and Zhangjin have provided significant nolibc cleanups, and
fixes, as well as preparation work to later support riscv32.

These consist in the following main series:
  - generalization of stackprotector to other archs that were not
    previously supported (riscv, mips, loongarch, arm, arm64)

  - general cleanups of the makefile, test report output, deduplication
    of certain tests

  - slightly better compliance of some tests performed on certain syscalls
    (e.g. no longer pass (void*)1 to gettimeofday() since glibc hates it).

  - add support for nanoseconds in stat() and statx()

  - fixes for some syscalls (e.g. ppoll() has 5 arguments not 4)

  - fixes around limits.h and  INT_MAX / INT_FAST64_MAX

I rebased the whole series on top of your latest dev branch (d19a9ca3d5)
and it works fine for all archs.

I don't know if you're still planning on merging new stuff in this area
for 6.5 or not (since I know that it involves new series of tests on your
side as well), but given that Zhangjin will engage into deeper changes
later for riscv32 that will likely imply to update more syscalls to use
the time64 ones, I would prefer to split the cleanups from the hard stuff,
but I'll let you judge based on the current state of what's pending for
6.5.

In any case I'm putting all this here for now (not for merge yet):

   git://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git 20230604-nolibc-rv32+stkp6

I'd like Thomas and Zhangjin to perform a last check to confirm they're
OK with this final integration.

Thanks!
Willy
