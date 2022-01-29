Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46FFA4A2AE0
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jan 2022 02:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241256AbiA2BKe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jan 2022 20:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiA2BKd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jan 2022 20:10:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F080C061714;
        Fri, 28 Jan 2022 17:10:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30A53B826A5;
        Sat, 29 Jan 2022 01:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2337BC340E7;
        Sat, 29 Jan 2022 01:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643418630;
        bh=FzrdKJdnCjC7nrl+Ux42pu7GZuSgeLwr59FvsBIsRaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QqQtJfKZS9cYuQv7K3GIwiSOVcQokzpaKZ0uIZEbNDe7Jrz3mfDbazYg5qUIb7xEB
         n4pHEoHCE151u7TAwshc7GkKh+VQpWaaJuBS+Ap50Y5DukB7oARn3g7E/kVK3R5hux
         UetJdT0CpBu05zCoNPkcOcyjJ1KYY87Zq8GRfVcuR8WIZ3eQ9Zye5ZBiXgrPDeg3P3
         qyEp5V7fXrUMv+ahivEzIK0vKpLAQuC2pC3wSfU9ylK0Q0ffFEVOsvwdt1gmLp7ki7
         P78y9JamzhUpG83byY+tMJwjAUJsnCsxpEn5Jown1hWd6Tf5Rss6DnxZFgP32Zm2kD
         bueUCp0EcrJXg==
Date:   Fri, 28 Jan 2022 18:10:24 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        shuah@kernel.org, ndesaulniers@google.com, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, quentin@isovalent.com, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH bpf-next v2 1/6] tools: Help cross-building with clang
Message-ID: <YfSUAPnZX/wP8U+p@archlinux-ax161>
References: <20211216163842.829836-1-jean-philippe@linaro.org>
 <20211216163842.829836-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216163842.829836-2-jean-philippe@linaro.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jean-Philippe,

On Thu, Dec 16, 2021 at 04:38:38PM +0000, Jean-Philippe Brucker wrote:
> Cross-compilation with clang uses the -target parameter rather than a
> toolchain prefix. Just like the kernel Makefile, add that parameter to
> CFLAGS when CROSS_COMPILE is set.
> 
> Unlike the kernel Makefile, we use the --sysroot and --gcc-toolchain
> options because unlike the kernel, tools require standard libraries.
> Commit c91d4e47e10e ("Makefile: Remove '--gcc-toolchain' flag") provides
> some background about --gcc-toolchain. Normally clang finds on its own
> the additional utilities and libraries that it needs (for example GNU ld
> or glibc). On some systems however, this autodetection doesn't work.
> There, our only recourse is asking GCC directly, and pass the result to
> --sysroot and --gcc-toolchain. Of course that only works when a cross
> GCC is available.
> 
> Autodetection worked fine on Debian, but to use the aarch64-linux-gnu
> toolchain from Archlinux I needed both --sysroot (for crt1.o) and
> --gcc-toolchain (for crtbegin.o, -lgcc). The --prefix parameter wasn't
> needed there, but it might be useful on other distributions.
> 
> Use the CLANG_CROSS_FLAGS variable instead of CLANG_FLAGS because it
> allows tools such as bpftool, that need to build both host and target
> binaries, to easily filter out the cross-build flags from CFLAGS.
> 
> Acked-by: Quentin Monnet <quentin@isovalent.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> Most tools I looked at needed additional changes to support cross-build
> with clang. I've only done the work for bpf tools.
> ---
>  tools/scripts/Makefile.include | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
> index 071312f5eb92..b0be5f40a3f1 100644
> --- a/tools/scripts/Makefile.include
> +++ b/tools/scripts/Makefile.include
> @@ -87,7 +87,18 @@ LLVM_STRIP	?= llvm-strip
>  
>  ifeq ($(CC_NO_CLANG), 1)
>  EXTRA_WARNINGS += -Wstrict-aliasing=3
> -endif
> +
> +else ifneq ($(CROSS_COMPILE),)
> +CLANG_CROSS_FLAGS := --target=$(notdir $(CROSS_COMPILE:%-=%))
> +GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE)gcc))

Apologies for noticing this so late, I only ran into this recently.

This line causes a warning when running 'make clean' when
'$(CROSS_COMPILE)gcc' does not exist in PATH. For example:

$ make -skj"$(nproc)" ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- LLVM=1 LLVM_IAS=0 clean
which: no powerpc-linux-gnu-gcc in ($PATH)

I only have powerpc-linux-gnu binutils in my PATH, not GCC, as I am only
working with clang.

This happens because of the 'resolve_btfids_clean target', which always
runs when running the 'clean' target on an in-tree build (since
$(objtree) = $(srctree)).

I tried looking into the best way to fix this but I am not at all
familiar with the tools/ build system; would you mind taking a look?
I see some machinery at the top of tools/bpf/Makefile for avoiding
running some commands under certain commands but I am unsure how to
shuffle that around to make everything work.

Cheers,
Nathan

> +ifneq ($(GCC_TOOLCHAIN_DIR),)
> +CLANG_CROSS_FLAGS += --prefix=$(GCC_TOOLCHAIN_DIR)$(notdir $(CROSS_COMPILE))
> +CLANG_CROSS_FLAGS += --sysroot=$(shell $(CROSS_COMPILE)gcc -print-sysroot)
> +CLANG_CROSS_FLAGS += --gcc-toolchain=$(realpath $(GCC_TOOLCHAIN_DIR)/..)
> +endif # GCC_TOOLCHAIN_DIR
> +CFLAGS += $(CLANG_CROSS_FLAGS)
> +AFLAGS += $(CLANG_CROSS_FLAGS)
> +endif # CROSS_COMPILE
>  
>  # Hack to avoid type-punned warnings on old systems such as RHEL5:
>  # We should be changing CFLAGS and checking gcc version, but this
> -- 
> 2.34.1
> 
> 
