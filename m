Return-Path: <linux-kselftest+bounces-13206-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DB7927CF3
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 20:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946791F22672
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 18:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BE56CDA1;
	Thu,  4 Jul 2024 18:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmObUB3R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99489101DB;
	Thu,  4 Jul 2024 18:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720117415; cv=none; b=pF4cIaHaPpBCoU1IZ2ZqTFZwxIcrUpiv1IF/h/Ti1EUztgW0wSBBCCVe5O0S1MwaVdRUdMn5WbbRnhnBVkkV1kE6GGmUUrA9DrfQVi5jn99IOMKpArKP5ABu8MhsZHDMVBO4mFaK/uETZYBAL79xawAEkBNPX7OB6NO8eAuU8MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720117415; c=relaxed/simple;
	bh=1gOMpOWjLezCyg/YwRnvdCDadwOiGFbKKqb9FaVZ1Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdUOcOwaQTr0qdo4hO1BVqNSNktHMwQCbzWWtjoATg2JLLuWHshEHS2COF+B59F+2LS7L2Nz70xpYUtChXFvHv6jeKFTZYamAD3nD0eDtiDyN9/sME7dKcCuB47wiWxtV5Mnvz5XL4DVBDpIGZdz9ELbpP7gxxWAjCCBfDGdluE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmObUB3R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC49C3277B;
	Thu,  4 Jul 2024 18:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720117415;
	bh=1gOMpOWjLezCyg/YwRnvdCDadwOiGFbKKqb9FaVZ1Ps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jmObUB3RXWpAOTziKIxShAXrbMDwPQg0Tyo4OIbrWNc3fDBChvEuX5UyqJmjEcVSv
	 tLiU9KKNsazbubPe2iv4yg2HhOnD0RBcCDaxO1ykVaJlG6sLrryjVVIN+aK5fxZGpB
	 6cCLOtJS4V6T2L9UZfRuTaMTQDTPH6YqDv1bLzL0y65SRgQ5tm9ssVAyOiNCKtC2zP
	 WZXbcizFwioyD3s55m7GcKZiHI21+CE3xQRtlOS1V4n/fFIOHfeCU6vAMFtNKciOY/
	 g+oUFYw7gd4jKosZJ56dIVxarhPzlXzyEDAHQaM8F4HhvhBMjPG23n6Mii/hdsQkvp
	 blsEC0/Ue7wJA==
Date: Thu, 4 Jul 2024 11:23:32 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Justin Stitt <justinstitt@google.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] selftests: introduce and use SELFTESTS_CC_IS_CLANG
 instead of LLVM
Message-ID: <20240704182332.GB300903@thelio-3990X>
References: <20240704030452.88793-1-jhubbard@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704030452.88793-1-jhubbard@nvidia.com>

On Wed, Jul 03, 2024 at 08:04:52PM -0700, John Hubbard wrote:
> Current practice in the selftests Makefiles is to use $(LLVM) as a way
> to decide if clang is being used as the compiler (and/or the linker
> front end). Unfortunately, this does not cover all of the use cases:
> 
> 1) CC could have been set within selftests/lib.mk, by inferring it from
> LLVM==1, or
> 
> 2) CC could have been set externally, such as when cross compiling.
> 
> Solution: In order to allow subsystem selftests to more accurately
> control clang-specific behavior, such as compiler options, provide a new
> Makefile variable: SELFTESTS_CC_IS_CLANG. If $(CC) contains an
> invocation of clang in any form, then SELFTESTS_CC_IS_CLANG will be
> non-empty.
> 
> SELFTESTS_CC_IS_CLANG does not specify which linker is being used.
> However, it can still help with linker options, because $(CC) is often
> used to do both the compile and link steps (often in the same step).
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
> 
> Hi,
> 
> If this looks reasonable, I'll break it up into separate patches and
> post it as a non-RFC.

Aside from the polarity issue with the checks as you already noted, this
seems reasonable to me and matches what I had in mind.

>  tools/testing/selftests/bpf/Makefile       |  2 +-
>  tools/testing/selftests/fchmodat2/Makefile | 12 +++++++-----
>  tools/testing/selftests/hid/Makefile       |  2 +-
>  tools/testing/selftests/lib.mk             | 15 +++++++++++++++
>  tools/testing/selftests/openat2/Makefile   | 16 +++++++++-------
>  5 files changed, 33 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index dd49c1d23a60..6b924297ab71 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -55,7 +55,7 @@ progs/test_sk_lookup.c-CFLAGS := -fno-strict-aliasing
>  progs/timer_crash.c-CFLAGS := -fno-strict-aliasing
>  progs/test_global_func9.c-CFLAGS := -fno-strict-aliasing
>  
> -ifneq ($(LLVM),)
> +ifeq ($(SELFTESTS_CC_IS_CLANG),)
>  # Silence some warnings when compiled with clang
>  CFLAGS += -Wno-unused-command-line-argument
>  endif
> diff --git a/tools/testing/selftests/fchmodat2/Makefile b/tools/testing/selftests/fchmodat2/Makefile
> index 4373cea79b79..d00b01be5d96 100644
> --- a/tools/testing/selftests/fchmodat2/Makefile
> +++ b/tools/testing/selftests/fchmodat2/Makefile
> @@ -2,14 +2,16 @@
>  
>  CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined $(KHDR_INCLUDES)
>  
> +TEST_GEN_PROGS := fchmodat2_test
> +
> +include ../lib.mk
> +
>  # gcc requires -static-libasan in order to ensure that Address Sanitizer's
>  # library is the first one loaded. However, clang already statically links the
>  # Address Sanitizer if -fsanitize is specified. Therefore, simply omit
>  # -static-libasan for clang builds.
> -ifeq ($(LLVM),)
> +# This check must be done after including ../lib.mk, in order to pick up the
> +# correct value of SELFTESTS_CC_IS_CLANG.
> +ifeq ($(SELFTESTS_CC_IS_CLANG),)
>      CFLAGS += -static-libasan
>  endif
> -
> -TEST_GEN_PROGS := fchmodat2_test
> -
> -include ../lib.mk
> diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
> index 2b5ea18bde38..734a53dc8ad9 100644
> --- a/tools/testing/selftests/hid/Makefile
> +++ b/tools/testing/selftests/hid/Makefile
> @@ -27,7 +27,7 @@ CFLAGS += -I$(OUTPUT)/tools/include
>  LDLIBS += -lelf -lz -lrt -lpthread
>  
>  # Silence some warnings when compiled with clang
> -ifneq ($(LLVM),)
> +ifeq ($(SELFTESTS_CC_IS_CLANG),)
>  CFLAGS += -Wno-unused-command-line-argument
>  endif
>  
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index 429535816dbd..f321ad5a1d0c 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -43,6 +43,21 @@ else
>  CC := $(CROSS_COMPILE)gcc
>  endif # LLVM
>  
> +# SELFTESTS_CC_IS_CLANG allows subsystem selftests to more accurately control
> +# clang-specific behavior, such as compiler options. If CC is an invocation of
> +# clang in any form, then SELFTESTS_CC_IS_CLANG will be non-empty. Notes:
> +#
> +# 1) CC could have been set above, by inferring it from LLVM==1, or externally,
> +# from the CC shell environment variable.
> +#
> +# 2) SELFTESTS_CC_IS_CLANG does not specify which linker is being used. However,
> +#    it can still help with linker options, if clang or gcc is used for the
> +#    linker front end.
> +SELFTESTS_CC_IS_CLANG :=
> +ifeq ($(findstring clang,$(CC)),clang)
> +    SELFTESTS_CC_IS_CLANG := 1
> +endif
> +
>  ifeq (0,$(MAKELEVEL))
>      ifeq ($(OUTPUT),)
>  	OUTPUT := $(shell pwd)
> diff --git a/tools/testing/selftests/openat2/Makefile b/tools/testing/selftests/openat2/Makefile
> index 185dc76ebb5f..7acb85a8f2ac 100644
> --- a/tools/testing/selftests/openat2/Makefile
> +++ b/tools/testing/selftests/openat2/Makefile
> @@ -3,16 +3,18 @@
>  CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined
>  TEST_GEN_PROGS := openat2_test resolve_test rename_attack_test
>  
> +LOCAL_HDRS += helpers.h
> +
> +include ../lib.mk
> +
> +$(TEST_GEN_PROGS): helpers.c
> +
>  # gcc requires -static-libasan in order to ensure that Address Sanitizer's
>  # library is the first one loaded. However, clang already statically links the
>  # Address Sanitizer if -fsanitize is specified. Therefore, simply omit
>  # -static-libasan for clang builds.
> -ifeq ($(LLVM),)
> +# This check must be done after including ../lib.mk, in order to pick up the
> +# correct value of SELFTESTS_CC_IS_CLANG.
> +ifeq ($(SELFTESTS_CC_IS_CLANG),)
>      CFLAGS += -static-libasan
>  endif
> -
> -LOCAL_HDRS += helpers.h
> -
> -include ../lib.mk
> -
> -$(TEST_GEN_PROGS): helpers.c
> 
> base-commit: 9a5cd459be8a425d70cda1fa1c89af7875a35d17
> -- 
> 2.45.2
> 
> 

