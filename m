Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013EA771086
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Aug 2023 18:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjHEQXv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Aug 2023 12:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjHEQXv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Aug 2023 12:23:51 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7671A4206;
        Sat,  5 Aug 2023 09:23:44 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 375GNRag023372;
        Sat, 5 Aug 2023 18:23:27 +0200
Date:   Sat, 5 Aug 2023 18:23:27 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuan Tan <tanyuan@tinylab.org>,
        Zhangjin Wu <falcon@tinylab.org>
Subject: Re: [PATCH v3 14/14] selftests/nolibc: enable compiler warnings
Message-ID: <20230805162327.GB15284@1wt.eu>
References: <20230803-nolibc-warnings-v3-0-bcc1a096ae02@weissschuh.net>
 <20230803-nolibc-warnings-v3-14-bcc1a096ae02@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230803-nolibc-warnings-v3-14-bcc1a096ae02@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 03, 2023 at 09:28:58AM +0200, Thomas Weiﬂschuh wrote:
> It will help the developers to avoid cruft and detect some bugs.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  tools/testing/selftests/nolibc/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> index b82d29b6c37f..e8d09cbee2ab 100644
> --- a/tools/testing/selftests/nolibc/Makefile
> +++ b/tools/testing/selftests/nolibc/Makefile
> @@ -79,7 +79,7 @@ endif
>  CFLAGS_s390 = -m64
>  CFLAGS_mips = -EL
>  CFLAGS_STACKPROTECTOR ?= $(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all))
> -CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \
> +CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 -W -Wall -Wextra \
>  		$(call cc-option,-fno-stack-protector) \
>  		$(CFLAGS_$(ARCH)) $(CFLAGS_STACKPROTECTOR)
>  LDFLAGS :=

I'm now getting this with gcc < 9:

  nolibc-test.c: In function 'test_pipe':
  nolibc-test.c:811:10: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
    if (len != strlen(msg))
            ^
The reason is that len is ssize_t and strlen() is size_t. I tried different
approaches here but the cleanest remains turning len to size_t (we don't
use its sign anyway), so I'll do that one as well.

Cheers,
Willy
