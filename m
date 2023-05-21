Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08EE070ADB4
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 May 2023 13:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjEULrK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 May 2023 07:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjEUKkV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 May 2023 06:40:21 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0751A8;
        Sun, 21 May 2023 03:36:04 -0700 (PDT)
Date:   Sun, 21 May 2023 12:36:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1684665362; bh=DHkS6vR075WOjYryzPWplYp9E9UCb+89BMbbIW7FyiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B4j6MrFveCJ/eL/P6OzEPwPxvEcIStVL2HPwsp65qDZTBbuEp8VMEP+fnMdzfZbf2
         p9HOisqOhrsIQUphD72u//kAtFUBo21iub42AsIJuSvOwgng4FF31iLnDhIsqVsKjR
         keVBHoPhVpG12mpW7Qa4Dht4CO5uXEHOGs6gjsak=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH 7/7] tools/nolibc: simplify stackprotector compiler flags
Message-ID: <ccd8a189-0ca1-4462-8478-87b6c6ccb066@t-8ch.de>
References: <20230521-nolibc-automatic-stack-protector-v1-0-dad6c80c51c1@weissschuh.net>
 <20230521-nolibc-automatic-stack-protector-v1-7-dad6c80c51c1@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230521-nolibc-automatic-stack-protector-v1-7-dad6c80c51c1@weissschuh.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-05-21 11:36:35+0200, Thomas Weißschuh wrote:
> Now that nolibc enable stackprotector support automatically when the
> compiler enables it we only have to get the -fstack-protector flags
> correct.
> 
> The cc-options are structured so that -fstack-protector-all is only
> enabled if -mstack-protector=guard works, as that is the only mode
> supported by nolibc.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  tools/testing/selftests/nolibc/Makefile | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> index bd41102ea299..445c352b1b33 100644
> --- a/tools/testing/selftests/nolibc/Makefile
> +++ b/tools/testing/selftests/nolibc/Makefile
> @@ -76,20 +76,11 @@ else
>  Q=@
>  endif
>  
> -CFLAGS_STACKPROTECTOR = -DNOLIBC_STACKPROTECTOR \
> -			$(call cc-option,-mstack-protector-guard=global) \
> -			$(call cc-option,-fstack-protector-all)
> -CFLAGS_STKP_i386 = $(CFLAGS_STACKPROTECTOR)
> -CFLAGS_STKP_x86_64 = $(CFLAGS_STACKPROTECTOR)
> -CFLAGS_STKP_x86 = $(CFLAGS_STACKPROTECTOR)
> -CFLAGS_STKP_arm64 = $(CFLAGS_STACKPROTECTOR)
> -CFLAGS_STKP_arm = $(CFLAGS_STACKPROTECTOR)
> -CFLAGS_STKP_mips = $(CFLAGS_STACKPROTECTOR)
> -CFLAGS_STKP_riscv = $(CFLAGS_STACKPROTECTOR)
> -CFLAGS_STKP_loongarch = $(CFLAGS_STACKPROTECTOR)
> +CFLAGS_STACKPROTECTOR = $(call cc-option,-mstack-protector-guard=global -fstack-protector-all)
>  CFLAGS_s390 = -m64
>  CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \
>  		$(call cc-option,-fno-stack-protector) \
> +		$(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all)) \
>  		$(CFLAGS_STKP_$(ARCH)) $(CFLAGS_$(ARCH))
>  LDFLAGS := -s

I noticed, of course after having sent the series, that the cleanup here
was not done properly.

CFLAGS_STACKPROTECTOR and CFLAGS_STKP should be deleted completely.

This will be fixed in v2, or feel free to fix it up when applying the
series.
