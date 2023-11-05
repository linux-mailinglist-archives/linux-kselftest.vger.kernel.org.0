Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3CE7E1316
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Nov 2023 11:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjKEKtO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 5 Nov 2023 05:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKEKtN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 5 Nov 2023 05:49:13 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A24C6;
        Sun,  5 Nov 2023 02:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1699181349;
        bh=5SKORb9FIzkRjaKU7RPndo/ilKQp7h3h2ADgE+ZVSeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FFulsfCCdxJnz5d+BqwKvkSeDq7f77UROakZPMGfOCF0JeKfnw6kjJ/JqkpBRuU/n
         hfkJ9TYMSb+XWHvx+zOFOiCq1nP7m7MURc/I/nA1gkKaO0Wywtowt5JDQP6fyYJ6Ka
         BzAuC0SkaV75A4DdbUw+K42qeaCOay0W+a9cqopQ=
Date:   Sun, 5 Nov 2023 11:49:08 +0100
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Shuah Khan <shuah@kernel.org>, Zhangjin Wu <falcon@tinylab.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/6] selftests/nolibc: use XARCH for MIPS
Message-ID: <5f35c048-c0bc-4b16-a655-cea54c9f8cf9@t-8ch.de>
References: <20231105-nolibc-mips-be-v1-0-6c2ad3e50a1f@weissschuh.net>
 <20231105-nolibc-mips-be-v1-3-6c2ad3e50a1f@weissschuh.net>
 <ZUdvO9moDc7X5E54@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZUdvO9moDc7X5E54@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-11-05 11:32:27+0100, Willy Tarreau wrote:
> On Sun, Nov 05, 2023 at 11:09:57AM +0100, Thomas Weißschuh wrote:
> > MIPS has many different configurations prepare the support of additional
> > ones by moving the build of MIPS to the generic XARCH infrastructure.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >  tools/testing/selftests/nolibc/Makefile     | 12 +++++++-----
> >  tools/testing/selftests/nolibc/run-tests.sh |  2 +-
> >  2 files changed, 8 insertions(+), 6 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> > index c5df1617cbc3..15c12f3c27ba 100644
> > --- a/tools/testing/selftests/nolibc/Makefile
> > +++ b/tools/testing/selftests/nolibc/Makefile
> > @@ -40,12 +40,14 @@ objtree ?= $(srctree)
> >  
> >  # configure default variants for target kernel supported architectures
> >  XARCH_powerpc    = ppc
> > +XARCH_mips       = mipso32le
> >  XARCH            = $(or $(XARCH_$(ARCH)),$(ARCH))
> >  
> >  # map from user input variants to their kernel supported architectures
> >  ARCH_ppc         = powerpc
> >  ARCH_ppc64       = powerpc
> >  ARCH_ppc64le     = powerpc
> > +ARCH_mipso32le   = mips
> 
> I *think* that what you called "mipso32le" above corresponds exactly to
> what is commonly called "mips32le" in toolchains or distros, because,
> unless I'm mistaken, "mips32" currently uses the O32 ABI. So that would
> sound more intuitive and natural I think.

Ack.

I did the same for mipso32be -> mips32be.

Thomas
