Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF5B4CC3C1
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Mar 2022 18:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbiCCRbo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Mar 2022 12:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbiCCRbn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Mar 2022 12:31:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9555E199D51;
        Thu,  3 Mar 2022 09:30:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C42DB82650;
        Thu,  3 Mar 2022 17:30:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45241C340E9;
        Thu,  3 Mar 2022 17:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646328655;
        bh=GCDTpWwAdbUUe92yPSIjZBhj5yfaiPwzu66bwylkoac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CLQazQPiBOZrP69PhmqDFy7s/3OGcDUji9CNq78GafEhJcptBOq9ejoyBYJ2f546B
         WTlZ8u1FFUpD/OSgSZY6He9snfv0gRmz7lyA01z+f8swbsuntwtgqOlSdC95A9rhzD
         4EHG/xJLnX+ThYlzbEB371mF/DWMhhm1qjhNHHYZhOO7+PHV6EBURX4/QlJg2a/04b
         cK6IxzhArX/HTp+RcLIdMrJ/+byFkhr/Hqjfdh68MR5K6wiC4kB9Fz3hjA/9cu5twz
         SOPBjB6KiiImIA7vzXX5v1kdIK7cVQWHqIsb9S4rGhtqXcJiLS7L+LsHATv9VdVI4o
         g0bbBtjD2FOMg==
Date:   Thu, 3 Mar 2022 10:30:47 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     David Gow <davidgow@google.com>
Cc:     Kees Cook <keescook@chromium.org>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-um@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] um: clang: Strip out -mno-global-merge from USER_CFLAGS
Message-ID: <YiD7R2wRxoWxtVq7@dev-arch.thelio-3990X>
References: <20220303090643.241747-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303090643.241747-1-davidgow@google.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi David,

On Thu, Mar 03, 2022 at 05:06:42PM +0800, David Gow wrote:
> The things built with USER_CFLAGS don't seem to recognise it as a
> compiler option, and print a warning:
> clang: warning: argument unused during compilation: '-mno-global-merge' [-Wunused-command-line-argument]
> 
> Fixes: 744814d2fa ("um: Allow builds with Clang")
> Signed-off-by: David Gow <davidgow@google.com>
> ---
> 
> This warning shows up after merging:
> https://lore.kernel.org/lkml/20220227184517.504931-6-keescook@chromium.org/
> 
> I'm not 100% sure why this is necessary, but it does seem to work. All
> the attempts to get rid of -mno-global-merge entirely have been met with
> skepticism, but I'm guessing that it's not a problem for just the UML
> "user" files, as they shouldn't(?) interact too much with modules.

Thank you for the patch! I think it is correct, as this flag only works
for AArch64 and ARM, as it is only used in Clang::AddAArch64TargetArgs()
and Clang::AddARMTargetArgs() in clang/lib/Driver/ToolChains/Clang.cpp,
which are obviously never called with UML. I am not sure why we do not
see warning during regular kernel builds, maybe something about how UML
objects are compiled exposes this?

Regardless, I would definitely like to clean up this instance of the
warning because I would like to make this warning a hard error so that
we do not get cryptic cc-option failures:

https://github.com/ClangBuiltLinux/linux/issues/1587

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

One small comment below.

>  arch/um/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/um/Makefile b/arch/um/Makefile
> index f2fe63bfd819..320b09cd513c 100644
> --- a/arch/um/Makefile
> +++ b/arch/um/Makefile
> @@ -75,6 +75,10 @@ USER_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -I%,,$(KBUILD_CFLAGS))) \
>  		-D_FILE_OFFSET_BITS=64 -idirafter $(srctree)/include \
>  		-idirafter $(objtree)/include -D__KERNEL__ -D__UM_HOST__
>  
> +ifdef CONFIG_CC_IS_CLANG

Is this ifdef needed?

> +USER_CFLAGS := $(patsubst -mno-global-merge,,$(USER_CFLAGS))
> +endif
> +
>  #This will adjust *FLAGS accordingly to the platform.
>  include $(srctree)/$(ARCH_DIR)/Makefile-os-$(OS)
>  
> -- 
> 2.35.1.616.g0bdcbb4464-goog
> 
