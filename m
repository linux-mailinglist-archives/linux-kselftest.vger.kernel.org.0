Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD5B76FA08
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 08:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbjHDG0H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 02:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjHDGZ6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 02:25:58 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC58A19B0;
        Thu,  3 Aug 2023 23:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1691130353; bh=45MJVMKJk1GZcqHTwtBKEjFvu2Hae66l2ac+fMNg8zY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nYT3oRr645A17UrzNlKw6xtX5TNurUR1il/OGJ76s6e2cNitYMsuCqITymjqgcyGs
         jCazVyBsN8ty7HWkN5HCcAv2dXCxExxj+4ryLZwa3cBhAZB+EglVyuiDoXzborLgoW
         JNd1wkU3mIQ2AP2Zr0JjN5PipFGYMmmUqvmRL9TE=
Date:   Fri, 4 Aug 2023 08:25:52 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     w@1wt.eu, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org
Subject: Re: [PATCH v1 2/3] selftests/nolibc: fix up O= option support
Message-ID: <20b43e63-fcf9-4e36-a983-5ed3211efc7e@t-8ch.de>
References: <cover.1691073180.git.falcon@tinylab.org>
 <759307255e4ca3b37b67321d333967a21122c422.1691073180.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <759307255e4ca3b37b67321d333967a21122c422.1691073180.git.falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-08-03 22:45:52+0800, Zhangjin Wu wrote:
> To avoid pollute the source code tree and avoid mrproper for every
> architecture switch, the O= argument must be supported.
> 
> Both IMAGE and .config are from the building directory, let's use
> objtree instead of srctree for them.
> 
> If no O= option specified, means building kernel in source code tree,
> objtree should be srctree in such case.
> 
> Suggested-by: Willy Tarreau <w@1wt.eu>
> Link: https://lore.kernel.org/lkml/ZK0AB1OXH1s2xYsh@1wt.eu/
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  tools/testing/selftests/nolibc/Makefile | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> index 51fef5e6a152..af590aee063a 100644
> --- a/tools/testing/selftests/nolibc/Makefile
> +++ b/tools/testing/selftests/nolibc/Makefile
> @@ -9,6 +9,9 @@ ifeq ($(srctree),)
>  srctree := $(patsubst %/tools/testing/selftests/,%,$(dir $(CURDIR)))
>  endif
>  
> +# add objtree for O= argument, required by IMAGE and .config
> +objtree ?= $(srctree)

Isn't this already set by the included tools/scripts/Makefile.include?

Also I'm not entirely if O= works as intended currently.
When using O=foo in the $LINUX/tools/testing/selftests/nolibc directory
the build instead is happening in $LINUX/foo. But the Makefile first
validates that $LINUX/tools/testing/selftests/nolibc/foo exists.

It seems we need to pass $(COMMAND_O) to the recursive calls to $(MAKE),
too?

> +
>  ifeq ($(ARCH),)
>  include $(srctree)/scripts/subarch.include
>  ARCH = $(SUBARCH)
> @@ -217,12 +220,12 @@ kernel: initramfs
>  
>  # run the tests after building the kernel
>  run: kernel
> -	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
> +	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(objtree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
>  	$(Q)$(REPORT) $(CURDIR)/run.out
>  
>  # re-run the tests from an existing kernel
>  rerun:
> -	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
> +	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(objtree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
>  	$(Q)$(REPORT) $(CURDIR)/run.out
>  
>  # report with existing test log
> -- 
> 2.25.1
> 
