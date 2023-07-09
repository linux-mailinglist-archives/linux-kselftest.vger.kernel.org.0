Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989B074C846
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Jul 2023 23:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjGIVAq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 9 Jul 2023 17:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjGIVAq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 9 Jul 2023 17:00:46 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21B811C;
        Sun,  9 Jul 2023 14:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1688936443; bh=i/i0SbwFNl82wivugo29PcbwTwUwrR/WslbHxkZwClc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BBUa/fdWIVhuEbJc5lYvH7nntb+LPgf/20rNY6UZ5Ua8pCZvcbl83VnBTUn3XQp6f
         02s8ILkEQfo+lz0BBHEB/O2ZcsV+UcQ92zMXsVV2h8u4kzuwIZwJKsCbHGSjfLJTYC
         E/3t5QYDNeW9CszN8j8A0BIixIfGEWgPdMWAT/kY=
Date:   Sun, 9 Jul 2023 23:00:40 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     w@1wt.eu, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 04/12] tools/nolibc: crt.h: add _start_c
Message-ID: <90fdd255-32f4-4caf-90ff-06456b53dac3@t-8ch.de>
References: <cover.1688828139.git.falcon@tinylab.org>
 <ccc8c9b850c03ef236ab05e919fea2bf9af2556a.1688828139.git.falcon@tinylab.org>
 <4e23cc1c-2fe0-413e-9fe1-a9428c0861b9@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e23cc1c-2fe0-413e-9fe1-a9428c0861b9@t-8ch.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-07-09 20:49:10+0200, Thomas Weißschuh wrote:
> On 2023-07-08 23:29:58+0800, Zhangjin Wu wrote:

> [..]

> > ---
> >  tools/include/nolibc/crt.h | 44 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> > 
> > diff --git a/tools/include/nolibc/crt.h b/tools/include/nolibc/crt.h
> > index 221b7c5346ca..b269294e9664 100644
> > --- a/tools/include/nolibc/crt.h
> > +++ b/tools/include/nolibc/crt.h
> > @@ -13,4 +13,48 @@

> [..]

> >  const unsigned long *_auxv __attribute__((weak));
> >  
> > +int main(int argc, char *argv[], char **envp);
> 
> This will lead to conflicting declarations if the users use a different
> signature. I'm not (yet?) sure how to work around this.
> 
> Also how is the case handled where main() returns "void"?
> I'm not sure how this is currently handled or if the compiler takes core
> of returning 0 in this case.

I looked into this some more.

The diff below allows it to accept different signatures for main().
(Maybe you can improve the naming)

Implicit return values seem to be handled by the compiler automatically.
In C89 mode we get garbage values, in C2X/C23 we get zero.
As per the respective C specs.


diff --git a/tools/include/nolibc/crt.h b/tools/include/nolibc/crt.h
index b269294e9664..dba40bc9413f 100644
--- a/tools/include/nolibc/crt.h
+++ b/tools/include/nolibc/crt.h
@@ -13,7 +13,6 @@
 char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
-int main(int argc, char *argv[], char **envp);
 static void exit(int);
 
 void _start_c(long *sp)
@@ -21,6 +20,7 @@ void _start_c(long *sp)
 	int argc, i;
 	char **argv;
 	char **envp;
+	int _nolibc_main_alias(int, char**, char**) __asm__("main");
 
 	/*
 	 * sp  :  argc          <-- argument count, required by main()
@@ -54,7 +54,7 @@ void _start_c(long *sp)
 	_auxv = (void *)(envp + i + 1);
 
 	/* go to application */
-	exit(main(argc, argv, envp));
+	exit(_nolibc_main_alias(argc, argv, envp));
 }
 
 #endif /* _NOLIBC_CRT_H */
