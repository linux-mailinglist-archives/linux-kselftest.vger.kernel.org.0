Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368D16C743C
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 00:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjCWXoZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 19:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjCWXoY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 19:44:24 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CF27EFE;
        Thu, 23 Mar 2023 16:44:19 -0700 (PDT)
Date:   Thu, 23 Mar 2023 23:44:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1679615057;
        bh=RI5ocGFEEsxcupBslhNsOWQFWljVe9IxGeY5B4BEkzY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ktXoOzQGOa2NPonXMcMgpQ8sh1OAkTFV/BQ3EYAxbxYkoLCqxLRGPbDIm7PD5GObt
         vypxz4uUAcs3wZSH6HgK6Kv9vuveU3zSiwpC1x4AORHfrqQPBkDUhcxTTSrK7d5+6Q
         gAFWEJrBYcBIiEMGHnCcwHQyrh1K5uevjGKuIAcA=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 8/8] tools/nolibc: x86_64: add stackprotector support
Message-ID: <fc50ed30-4152-4806-9eed-09a8b164afe6@t-8ch.de>
References: <20230223-nolibc-stackprotector-v2-0-4c938e098d67@weissschuh.net>
 <20230223-nolibc-stackprotector-v2-8-4c938e098d67@weissschuh.net>
 <ZBy0ZNYcHFlZWN32@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZBy0ZNYcHFlZWN32@1wt.eu>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Willy,

On Thu, Mar 23, 2023 at 09:19:48PM +0100, Willy Tarreau wrote:
> On Mon, Mar 20, 2023 at 03:41:08PM +0000, Thomas Weißschuh wrote:
> > Enable the new stackprotector support for x86_64.
> (...)
> > diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> > index 8f069ebdd124..543555f4cbdc 100644
> > --- a/tools/testing/selftests/nolibc/Makefile
> > +++ b/tools/testing/selftests/nolibc/Makefile
> > @@ -80,6 +80,8 @@ CFLAGS_STACKPROTECTOR = -DNOLIBC_STACKPROTECTOR \
> >  			$(call cc-option,-mstack-protector-guard=global) \
> >  			$(call cc-option,-fstack-protector-all)
> >  CFLAGS_i386 = $(CFLAGS_STACKPROTECTOR)
> > +CFLAGS_x86_64 = $(CFLAGS_STACKPROTECTOR)
> > +CFLAGS_x86 = $(CFLAGS_STACKPROTECTOR)
> >  CFLAGS_s390 = -m64
> >  CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables \
> >  		$(call cc-option,-fno-stack-protector) \
> 
> This change is making it almost impossible for me to pass external CFLAGS
> without forcefully disabling the automatic detection of stackprot. I need
> to do it for some archs (e.g. "-march=armv5t -mthumb") or even to change
> optimization levels.
> 
> I figured that the simplest way to recover that functionality for me
> consists in using a dedicated variable to assign stack protector per
> supported architecure and concatenating it to the per-arch CFLAGS like
> this:
> 
>   diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
>   index 543555f4cbdc..bbce57420465 100644
>   --- a/tools/testing/selftests/nolibc/Makefile
>   +++ b/tools/testing/selftests/nolibc/Makefile
>   @@ -79,13 +79,13 @@ endif
>    CFLAGS_STACKPROTECTOR = -DNOLIBC_STACKPROTECTOR \
>                           $(call cc-option,-mstack-protector-guard=global) \
>                           $(call cc-option,-fstack-protector-all)
>   -CFLAGS_i386 = $(CFLAGS_STACKPROTECTOR)
>   -CFLAGS_x86_64 = $(CFLAGS_STACKPROTECTOR)
>   -CFLAGS_x86 = $(CFLAGS_STACKPROTECTOR)
>   +CFLAGS_STKP_i386 = $(CFLAGS_STACKPROTECTOR)
>   +CFLAGS_STKP_x86_64 = $(CFLAGS_STACKPROTECTOR)
>   +CFLAGS_STKP_x86 = $(CFLAGS_STACKPROTECTOR)
>    CFLAGS_s390 = -m64
>    CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables \
>                   $(call cc-option,-fno-stack-protector) \
>   -               $(CFLAGS_$(ARCH))
>   +               $(CFLAGS_STKP_$(ARCH)) $(CFLAGS_$(ARCH))
>    LDFLAGS := -s
>    
>    help:
> 
> And now with this it works again for me on all archs, with all of them
> showing "SKIPPED" for the -fstackprotector line except i386/x86_64 which
> show "OK".
> 
> Are you OK with this approach ? And if so, do you want to respin it or
> do you want me to retrofit it into your 3 patches that introduce this
> change (it's easy enough so I really don't care) ?

Looks good to me.

If nothing else needs to be changed feel free to fix it up on your side.

Thanks,
Thomas
