Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14BF7E12C1
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Nov 2023 10:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjKEJ12 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 5 Nov 2023 04:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKEJ11 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 5 Nov 2023 04:27:27 -0500
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8292AB7;
        Sun,  5 Nov 2023 01:27:23 -0800 (PST)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3A59R0i9002306;
        Sun, 5 Nov 2023 10:27:00 +0100
Date:   Sun, 5 Nov 2023 10:27:00 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, Zhangjin Wu <falcon@tinylab.org>,
        Yuan Tan <tanyuan@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: add script to run testsuite
Message-ID: <ZUdf5J2kVZSxDaWd@1wt.eu>
References: <20231105-nolibc-run-tests-v1-1-b59ff770a978@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231105-nolibc-run-tests-v1-1-b59ff770a978@weissschuh.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Nov 05, 2023 at 10:23:05AM +0100, Thomas Weiﬂschuh wrote:
> The script can run the testsuite for multiple architectures and provides
> an overall test report.
> 
> Furthermore it can automatically download crosstools from
> mirrors.kernel.org if requested by the user.
> 
> Example execution:
> 
> $ ./run-tests.sh
> i386:          162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> x86_64:        162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> arm64:         162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> arm:           162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> mips:          162 test(s): 161 passed,   1 skipped,   0 failed => status: warning
> ppc:           162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> ppc64:         162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> ppc64le:       162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> riscv:         162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> s390:          162 test(s): 161 passed,   1 skipped,   0 failed => status: warning
> loongarch:     162 test(s): 161 passed,   1 skipped,   0 failed => status: warning
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
(...)


Really nice, much cleaner than my old ugly scripts ;-)
Thanks for this, Thomas!

Acked-by: Willy Tarreau <w@1wt.eu>

Willy
