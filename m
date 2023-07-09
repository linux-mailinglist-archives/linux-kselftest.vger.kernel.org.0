Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AB674C1A4
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Jul 2023 11:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjGIJQ1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 9 Jul 2023 05:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjGIJQ0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 9 Jul 2023 05:16:26 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 698E2B8;
        Sun,  9 Jul 2023 02:16:25 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3699Flap018530;
        Sun, 9 Jul 2023 11:15:47 +0200
Date:   Sun, 9 Jul 2023 11:15:47 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, thomas@t-8ch.de
Subject: Re: [PATCH v6 13/15] selftests/nolibc: add mmap_bad test case
Message-ID: <20230709091547.GD9321@1wt.eu>
References: <cover.1688739492.git.falcon@tinylab.org>
 <fdc400ae881aa3819978d43cea7004df7b276551.1688739493.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdc400ae881aa3819978d43cea7004df7b276551.1688739493.git.falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 07, 2023 at 11:05:49PM +0800, Zhangjin Wu wrote:
> The length argument of mmap() must be greater than 0, passing a zero
> length argument expects failure with -EINVAL.

This one doesn't work for me on x86_64 kernel 5.15.112, qemu userland:

  46 mmap_bad = <0x0> EEXIST  != (<0xffffffffffffffff> EINVAL)    [FAIL]

This EEXIST actually is the errno from the previous test. If I run
the test natively it's OK:

  $ ./nolibc-test syscall:46
  Running test 'syscall'
  46 mmap_bad = <0xffffffffffffffff> EINVAL                        [OK]
  Errors during this test: 0

I'll queue it anyway for now but it would be nice that we figure what's
happening (even if we need to adjust or drop the test if it's a false
positive) so that we don't get used to "ah this is a normal error".

Willy
