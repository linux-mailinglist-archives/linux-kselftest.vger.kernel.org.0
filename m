Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486F44EE3D4
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Apr 2022 00:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242265AbiCaWKj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Mar 2022 18:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242094AbiCaWKi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Mar 2022 18:10:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422C7488A6;
        Thu, 31 Mar 2022 15:08:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4415B82056;
        Thu, 31 Mar 2022 22:08:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99132C340F0;
        Thu, 31 Mar 2022 22:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648764526;
        bh=qUwqbyrT79WFFwJHFexh9R65/YdUtP4GEs6ZjNLnytc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ivHaOR3SU+xG0hlCfmksPSwx6cgrL0akm2HENyGok/ev8xYDzfQ0Ephky0FBwjRG5
         H9chOBfH6+fIGiJQ3vqu1kZ23Zi5mHhb6eWMOLwNnW1C09oHZyAJmAUSGdWEwOOxI6
         /AeVkZo69AoczAQzIcnAjWTKOKnzM6+V985WalYEHcSmbDndNeI6ozaYGPniLDhOVZ
         85Ch+3rnf1eDx4hKh/iHeiI+RVXT6kOZ08Fb28Sg6X5BGQw/crtVn4HSbdp7jqlM92
         RPOWCH5z16O47nr3CSKISPlDhg/4MhqNBT5/Pb2zfJgWn1eoXPcIs/UOmawOuLA/BR
         oJscVqyBeLYYQ==
Date:   Thu, 31 Mar 2022 15:08:43 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Grigory Vasilyev <h0tc0d3@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yury Norov <yury.norov@gmail.com>, Yonghong Song <yhs@fb.com>,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] Fix kernel build with LLVM=1
Message-ID: <YkYma7wwps8LZJnH@dev-arch.thelio-3990X>
References: <20220331215659.3800-1-h0tc0d3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331215659.3800-1-h0tc0d3@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Grigory,

On Fri, Apr 01, 2022 at 12:56:58AM +0300, Grigory Vasilyev wrote:
> The wrong logic is using 1 as a suffix instead of -1.
> So the build script tries to find clang1 file instead of clang.
> 
> GEN     Makefile
> HOSTCC  scripts/basic/fixdep
> /bin/sh: line 1: clang1: command not found
> make[2]: *** [/build/linux/scripts/Makefile.host:95: scripts/basic/fixdep] Error 127
> make[1]: *** [/build/linux/Makefile:564: scripts_basic] Error 2
> make: *** [Makefile:219: __sub-make] Error 2

I am confused by this error, what is your build command? The supported
uses of LLVM= are:

$ make LLVM=1

to use clang, ld.lld, etc.

$ make LLVM=-1

to use clang-1, ld.lld-1, etc.

$ make LLVM=/path/to/

to use /path/to/clang, /path/to/ld.lld, etc.

I do not really understand how based on the current logic you are ending
up with clang1.

$ make -skj"$(nproc)" LLVM=1 distclean defconfig all

works for me here:

$ git show -s --format='%h ("%s")'
478f74a3d808 ("Merge tag 'random-5.18-rc1-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/crng/random")

$ head -1 init/.main.o.cmd
cmd_init/main.o := clang -Wp,-MMD,init/.main.o.d ...

Please provide more information, as this change should not be necessary.

It could be GNU make related?

$ make --version
GNU Make 4.3
Built for x86_64-pc-linux-gnu
Copyright (C) 1988-2020 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

> Fixes: b8321ed4a40c("Merge tag 'kbuild-v5.18-v2'")
> 
> Signed-off-by: Grigory Vasilyev <h0tc0d3@gmail.com>
> Reported-by: Grigory Vasilyev <h0tc0d3@gmail.com>

Normally, you do not add a "Reported-by" for a patch you send, just for
the future.

> ---
>  Makefile                       | 4 ++--
>  tools/scripts/Makefile.include | 4 ++--
>  tools/testing/selftests/lib.mk | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 18ecb49f1af6..efca890d4ea3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -426,8 +426,8 @@ HOST_LFS_LIBS := $(shell getconf LFS_LIBS 2>/dev/null)
>  ifneq ($(LLVM),)
>  ifneq ($(filter %/,$(LLVM)),)
>  LLVM_PREFIX := $(LLVM)
> -else ifneq ($(filter -%,$(LLVM)),)
> -LLVM_SUFFIX := $(LLVM)
> +else ifneq (,$(findstring -, $(LLVM)))
> +LLVM_SUFFIX := $(filter -%, $(LLVM))
>  endif
>  
>  HOSTCC	= $(LLVM_PREFIX)clang$(LLVM_SUFFIX)
> diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
> index 0efb8f2b33ce..c7a56d7f0bad 100644
> --- a/tools/scripts/Makefile.include
> +++ b/tools/scripts/Makefile.include
> @@ -54,8 +54,8 @@ endef
>  ifneq ($(LLVM),)
>  ifneq ($(filter %/,$(LLVM)),)
>  LLVM_PREFIX := $(LLVM)
> -else ifneq ($(filter -%,$(LLVM)),)
> -LLVM_SUFFIX := $(LLVM)
> +else ifneq (,$(findstring -, $(LLVM)))
> +LLVM_SUFFIX := $(filter -%, $(LLVM))
>  endif
>  
>  $(call allow-override,CC,$(LLVM_PREFIX)clang$(LLVM_SUFFIX))
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index 2a2d240cdc1b..42af066cf39e 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -3,8 +3,8 @@
>  ifneq ($(LLVM),)
>  ifneq ($(filter %/,$(LLVM)),)
>  LLVM_PREFIX := $(LLVM)
> -else ifneq ($(filter -%,$(LLVM)),)
> -LLVM_SUFFIX := $(LLVM)
> +else ifneq (,$(findstring -, $(LLVM)))
> +LLVM_SUFFIX := $(filter -%, $(LLVM))
>  endif
>  
>  CC := $(LLVM_PREFIX)clang$(LLVM_SUFFIX)
> -- 
> 2.35.1
> 
