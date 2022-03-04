Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823C64CD337
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Mar 2022 12:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239557AbiCDLSC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Mar 2022 06:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239374AbiCDLRw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Mar 2022 06:17:52 -0500
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE79465DE;
        Fri,  4 Mar 2022 03:17:01 -0800 (PST)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 224BGhll019681;
        Fri, 4 Mar 2022 20:16:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 224BGhll019681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1646392604;
        bh=W6k2BHrnNOy39xSqewRMQbMofahKYk5Brxmt9EJz6Nc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V4KSee13/pj6J41xh5A1QLBMfyBErkTPp1VxwGIEumZhUEu2DwO2Jvjs8/nJeWh3h
         jujs38cbATkf1AMXaGaTPPOTE59CUM3KGERTLASxLutu0nDOhbJzum6WZHPvzlPf7z
         ruw/cDuMrlg1Eu2nrezByaMwaV2KyJ+EUBPA/j0mYy3qaoe1qE2t8amX+LfwFW/Z8b
         APg1CgIGIilq0xbWJoYDEfHwSk8IYP1TY4UGlrLkWyNT5Eq3MURPsQMxfGI7xdjX/g
         kMd/H/aBEdbUP9/zaU5DAYMiKR8U+ipH0zk4CJYdXoIU16CrfmygWL+rsPCALEXBke
         Njd/mBcX3vajQ==
X-Nifty-SrcIP: [209.85.215.179]
Received: by mail-pg1-f179.google.com with SMTP id e6so7265729pgn.2;
        Fri, 04 Mar 2022 03:16:44 -0800 (PST)
X-Gm-Message-State: AOAM533Li7GScAIhtHm/7ia+invEHB0RkIZP5iX1idCCW/JWISy3V5qF
        aGTnRHBPeQzXxS73uYmZKSHMMLnUX9dtmUlcNO4=
X-Google-Smtp-Source: ABdhPJx48QClcHXtWeFNvF97kN246Gr70cVbpgO7WkxLIIG015beCFLpkmM0yM5tAUCjgLubUveURZi0kZgLIpYmVHU=
X-Received: by 2002:a05:6a00:c90:b0:4bd:22a:bb1d with SMTP id
 a16-20020a056a000c9000b004bd022abb1dmr42453625pfv.32.1646392603459; Fri, 04
 Mar 2022 03:16:43 -0800 (PST)
MIME-Version: 1.0
References: <20220302234400.782002-1-nathan@kernel.org>
In-Reply-To: <20220302234400.782002-1-nathan@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 4 Mar 2022 20:16:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNARAPqTaO0Zho0VFib6kxjfpbnvrX-ZwcVPQgES5T8z4qQ@mail.gmail.com>
Message-ID: <CAK7LNARAPqTaO0Zho0VFib6kxjfpbnvrX-ZwcVPQgES5T8z4qQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Allow a suffix with $(LLVM)
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Shuah Khan <shuah@kernel.org>, llvm@lists.linux.dev,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 3, 2022 at 8:47 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> The LLVM make variable allows a developer to quickly switch between the
> GNU and LLVM tools. However, it does not handle versioned binaries, such
> as the ones shipped by Debian, as LLVM=1 just defines the tool variables
> with the unversioned binaries.
>
> There was some discussion during the review of the patch that introduces
> LLVM=1 around versioned binaries, ultimately coming to the conclusion
> that developers can just add the folder that contains the unversioned
> binaries to their PATH, as Debian's versioned suffixed binaries are
> really just symlinks to the unversioned binaries in /usr/lib/llvm-#/bin:
>
> $ realpath /usr/bin/clang-14
> /usr/lib/llvm-14/bin/clang
>
> $ PATH=/usr/lib/llvm-14/bin:$PATH make ... LLVM=1
>
> However, that can be cumbersome to developers who are constantly testing
> series with different toolchains and versions. It is simple enough to
> support these versioned binaries directly in the Kbuild system by
> allowing the developer to specify the version suffix with LLVM=, which
> is shorter than the above suggestion:
>
> $ make ... LLVM=-14
>
> It does not change the meaning of LLVM=1 (which will continue to use
> unversioned binaries) and it does not add too much additional complexity
> to the existing $(LLVM) code, while allowing developers to quickly test
> their series with different versions of the whole LLVM suite of tools.
>
> Link: https://lore.kernel.org/r/20200317215515.226917-1-ndesaulniers@google.com/
> Link: https://lore.kernel.org/r/20220224151322.072632223@infradead.org/
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>
> RFC -> v1: https://lore.kernel.org/r/Yh%2FegU1LZudfrgVy@dev-arch.thelio-3990X/
>
> * Tidy up commit message slightly.
>
> * Add tags.
>
> * Add links to prior discussions for context.
>
> * Add change to tools/testing/selftests/lib.mk.
>
> I would like for this to go through the Kbuild tree, please ack as
> necessary.
>
>  Documentation/kbuild/llvm.rst  |  7 +++++++
>  Makefile                       | 24 ++++++++++++++----------
>  tools/scripts/Makefile.include | 20 ++++++++++++--------
>  tools/testing/selftests/lib.mk |  6 +++++-
>  4 files changed, 38 insertions(+), 19 deletions(-)
>
> diff --git a/Documentation/kbuild/llvm.rst b/Documentation/kbuild/llvm.rst
> index d32616891dcf..5805a8473a36 100644
> --- a/Documentation/kbuild/llvm.rst
> +++ b/Documentation/kbuild/llvm.rst
> @@ -60,6 +60,13 @@ They can be enabled individually. The full list of the parameters: ::
>           OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump READELF=llvm-readelf \
>           HOSTCC=clang HOSTCXX=clang++ HOSTAR=llvm-ar HOSTLD=ld.lld
>
> +If your LLVM tools have a suffix and you prefer to test an explicit version rather
> +than the unsuffixed executables, use ``LLVM=<suffix>``. For example: ::
> +
> +       make LLVM=-14
> +
> +will use ``clang-14``, ``ld.lld-14``, etc.
> +
>  The integrated assembler is enabled by default. You can pass ``LLVM_IAS=0`` to
>  disable it.


Perhaps, it might be worth mentioning the difference between
LLVM=1 and LLVM=<suffix>

The current behavior is,
any value other than '1' is regarded as a suffix.



> diff --git a/Makefile b/Makefile
> index a82095c69fdd..963840c00eae 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -424,8 +424,12 @@ HOST_LFS_LDFLAGS := $(shell getconf LFS_LDFLAGS 2>/dev/null)
>  HOST_LFS_LIBS := $(shell getconf LFS_LIBS 2>/dev/null)
>
>  ifneq ($(LLVM),)
> -HOSTCC = clang
> -HOSTCXX        = clang++
> +ifneq ($(LLVM),1)
> +LLVM_SFX := $(LLVM)
> +endif

I am OK with this, but please note LLVM=0
uses 'clang0', 'ld.lld0' instead of disabling
LLVM explicitly.

This might be a small surprise because LLVM_IAS=0
is used to disable the integrated assembler.




If you want handle LLVM=<suffix>
only when <suffix> start with a hyphen,
you can do like this:

ifneq ($(filter -%, $(LLVM)),)
LLVM_SFX := $(LLVM)
endif




In the future, If somebody requests to support
    make LLVM=/path/to/my/own/llvm/dir/
to use llvm tools in that path,
we can expand the code like this:



# "LLVM=foo/bar/" is a syntax sugar of "LLVM=1 LLVM_PFX=foo/bar"
# "LLVM=-foo" is a syntax sugar of "LLVM=1 LLVM_SFX=-foo"

ifneq ($(filter %/, $(LLVM)),)
LLVM_PFX := $(LLVM)
else ifneq ($(filter -%, $(LLVM)),)
LLVM_SFX := $(LLVM)
endif




Lastly, I personally prefer to fully spell LLVM_SUFFIX
as Nick originally suggested:
https://lkml.org/lkml/2020/3/17/1477






-- 
Best Regards
Masahiro Yamada
