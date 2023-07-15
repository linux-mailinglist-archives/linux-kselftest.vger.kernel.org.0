Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D382D75473C
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jul 2023 09:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjGOHYz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Jul 2023 03:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGOHYy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Jul 2023 03:24:54 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8882235B3;
        Sat, 15 Jul 2023 00:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1689405891; bh=+x+OBsCkEs63wx4/L6coA3g29HgWPJzDjcoTmoesRQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WYacgvwA2hjXbvY0r8To3ttma0vgqHDk8I+HK/tsqeyrvUVICy9K2y33UTlKLi5yH
         UitXHcVQwTD4rUuYwxD18WVZ6E6Xv3EWWvRycsSE8XSAQCNzKHWb4eDUfGi8Mxhivk
         F/7i1SIXXhoLVEX7qMSoyiTmeo6c6PLRBsYfsD8U=
Date:   Sat, 15 Jul 2023 09:24:50 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, w@1wt.eu
Subject: Re: [PATCH v3 02/11] tools/nolibc: add new crt.h with _start_c
Message-ID: <34b21ba5-7b59-4b3b-9ed6-ef9a3a5e06f7@t-8ch.de>
References: <63476acf-9e65-4ab0-8e9b-bc35b12710d5@t-8ch.de>
 <20230714094723.140603-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714094723.140603-1-falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-07-14 17:47:23+0800, Zhangjin Wu wrote:
> > On 2023-07-14 13:58:13+0800, Zhangjin Wu wrote:

> [..]

> > I was also not able to reproduce the issue.
> >
> 
> Thanks very much for your 'reproduce' result, It is so weird, just
> rechecked the toolchain, 13.1.0 from https://mirrors.edge.kernel.org/ is
> ok, gcc 9, gcc 10.3 not work.
> 
> But even in the page of 13.1.0 [1], we still see this line:
> 
>     Most optimizations are completely disabled at -O0 or if an -O level is not set on the command line, even if individual optimization flags are specified.
> 
> Not sure if "individual optimization flags" also means the optimize()
> flags in gcc attributes. or the doc is not updated yet?
> 
> And further found gcc 11.1.0 is ok, gcc 10.4 still not work, so, gcc
> 11.1.0 may changed something to let the "individual optimization flags"
> work with -O0.
> 
> We may need to at least document this issue in some files, -O0 is not such a
> frequently-used option, not sure if we still need -O0 work with the older gcc <
> 11.1.0 ;-)

It seems we can avoid the issue by enforcing optimizations for _start:

diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index f5614a67f05a..b9d8b8861dc4 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -161,12 +161,9 @@
  * 2) The deepest stack frame should be zero (the %rbp).
  *
  */
-void __attribute__((weak, noreturn, optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
+void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_stack_protector _start(void)

> 
> Willy, I'm not sure if the issues solved by the commit 7f8548589661
> ("tools/nolibc: make compiler and assembler agree on the section around
> _start") still exist after we using _start_c()?
> 
> Thomas, because we plan to move the stackprotector init to _start_c(), If using
> pure assembly _start, we may also not need the __no_stack_protector macro too?

It would probably not needed anymore in this case.

Thomas
