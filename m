Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576A775DC76
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jul 2023 14:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjGVMUT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 22 Jul 2023 08:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGVMUT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 22 Jul 2023 08:20:19 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3BE89B;
        Sat, 22 Jul 2023 05:20:17 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36MCK93g017357;
        Sat, 22 Jul 2023 14:20:09 +0200
Date:   Sat, 22 Jul 2023 14:20:09 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     thomas@t-8ch.de, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 02/14] selftests/nolibc: add macros to enhance
 maintainability
Message-ID: <20230722122009.GE17311@1wt.eu>
References: <cover.1689759351.git.falcon@tinylab.org>
 <0415392c9c2b0a7249563abd79599a475019b508.1689759351.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0415392c9c2b0a7249563abd79599a475019b508.1689759351.git.falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 19, 2023 at 09:19:10PM +0800, Zhangjin Wu wrote:
> The kernel targets share the same kernel make operations, the same
> .config file, the same kernel image, add MAKE_KERNEL, KERNEL_CONFIG and
> KERNEL_IMAGE for them.
> 
> Many targets share the same logging related settings, let's add common
> variables RUN_OUT, LOG_OUT and REPORT_RUN_OUT for them.
> 
> The qemu run/rerun targets share the same qemu system run command, add
> QEMU_SYSTEM_RUN for them.
> 
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  tools/testing/selftests/nolibc/Makefile | 41 ++++++++++++++++---------
>  1 file changed, 27 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> index 0cd17de2062c..8c531518bb9f 100644
> --- a/tools/testing/selftests/nolibc/Makefile
> +++ b/tools/testing/selftests/nolibc/Makefile
> @@ -166,45 +166,58 @@ endif
>  libc-test: nolibc-test.c
>  	$(QUIET_CC)$(CC) -o $@ $<
>  
> +# common macros for logging
> +RUN_OUT = $(CURDIR)/run.out
> +LOG_OUT = > "$(RUN_OUT)"
> +REPORT_RUN_OUT = $(REPORT) "$(RUN_OUT)"
> +
>  # local libc-test
>  run-libc-test: libc-test
> -	$(Q)./libc-test > "$(CURDIR)/run.out" || :
> -	$(Q)$(REPORT) $(CURDIR)/run.out
> +	$(Q)./libc-test $(LOG_OUT) || :
> +	$(Q)$(REPORT_RUN_OUT)

Sorry but I don't find that this improves maintainability, quite the
opposite in fact. One reason is that you never visually expect that
some shell indirection delimiters are hidden in a macro that seems
to only convey a name. Sure there are valid use cases for this, but
I think that here it's just adding too much abstraction and it makes
it quite hard to unfold all of this mentally.

Please try to keep the number of macros to the minimum that needs to
be replaced or forced by the user. Here I'm not seeing a compelling
reason for a user to want to force LOG_OUT to something else. Also
makefile macros are generally a pain to debug, which is another
reason for not putting too many of them.

I noticed that your next patch changes LOG_OUT to tee, it could have
done it everywhere and wouldn't affect readability as much.

Thanks,
Willy
