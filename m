Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460A9721D10
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 06:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbjFEESk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 00:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjFEESk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 00:18:40 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 553D5CA;
        Sun,  4 Jun 2023 21:18:38 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3554IMKL005432;
        Mon, 5 Jun 2023 06:18:22 +0200
Date:   Mon, 5 Jun 2023 06:18:22 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: Re: [PATCH 1/4] selftests/nolibc: add a test-report target
Message-ID: <ZH1iDne+PiyZmIIB@1wt.eu>
References: <cover.1685936428.git.falcon@tinylab.org>
 <291c5437db94057a3b045a6f036b02658380b05b.1685936428.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <291c5437db94057a3b045a6f036b02658380b05b.1685936428.git.falcon@tinylab.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 05, 2023 at 11:48:52AM +0800, Zhangjin Wu wrote:
> A standalone test-report target is added to let the run, run-user and
> rerun targets share them.
> 
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  tools/testing/selftests/nolibc/Makefile | 26 ++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> index be4159837494..8149ace2938a 100644
> --- a/tools/testing/selftests/nolibc/Makefile
> +++ b/tools/testing/selftests/nolibc/Makefile
> @@ -127,14 +127,18 @@ nolibc-test: nolibc-test.c sysroot/$(ARCH)/include
>  libc-test: nolibc-test.c
>  	$(QUIET_CC)$(CC) -o $@ $<
>  
> -# qemu user-land test
> -run-user: nolibc-test
> -	$(Q)qemu-$(QEMU_ARCH) ./nolibc-test > "$(CURDIR)/run.out" || :
> +test-report:
>  	$(Q)awk '/\[OK\]$$/{p++} /\[FAIL\]$$/{f++} /\[SKIPPED\]$$/{s++} \
>  	         END{ printf("%d test(s) passed, %d skipped, %d failed.", p, s, f); \
>  	         if (s+f > 0) printf(" See all results in %s\n", ARGV[1]); else print; }' \
>  	         $(CURDIR)/run.out
>  
> +# qemu user-land test
> +_run-user: nolibc-test
> +	$(Q)qemu-$(QEMU_ARCH) ./nolibc-test > "$(CURDIR)/run.out" || :
> +
> +run-user: _run-user test-report
> +

This will not reliably work, there's no ordering here, nothing guarantees
that test-report will run *after* _run-user (e.g. make -j). Another
approach is needed if you want to factor this, but in general creating
sequences in makefiles is difficult and often more painful than having
3 times the same 3 lines.

Willy
