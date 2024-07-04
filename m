Return-Path: <linux-kselftest+bounces-13197-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D1D927316
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 11:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C86228CC57
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 09:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8561A4F2D;
	Thu,  4 Jul 2024 09:31:38 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1332A171A7;
	Thu,  4 Jul 2024 09:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720085497; cv=none; b=AReX6EEZRkrpfmtWqk4/pYWJ2cWrzi02ZY7hisxfwptCKJTJEu6c5EaRSC2FcXUpTrXDX8pscJEp6vS2IzUBMu0YJFwk2EqA/FpZBa0/Meq+77ZgOo/UL9QfkHqjO3K7JsLCkG9vGCYvj2pZr5PiPBdXq5+RIShuYCHft1HfGEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720085497; c=relaxed/simple;
	bh=6JvIoGeJYxTilGdyGLvutd4vO5hzpifvREfdh9Tlzy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oRiB/L0TpxZzasuYemmdU3b8VZfaU2P4PmxAemcRoUw/iTtJn6TcH5WtCazGYNMqenSBULC7jqZartGPrBPe3/ozp9ljFZ3p87oVudSLX4byDkZvkjlQOgbZsk7LqUqaK5NGEY+i+H7xRJTk9wSRiYxgLehqjLIckVKJ3irJubE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74E3ADA7;
	Thu,  4 Jul 2024 02:32:00 -0700 (PDT)
Received: from [10.1.29.168] (XHFQ2J9959.cambridge.arm.com [10.1.29.168])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FF323F766;
	Thu,  4 Jul 2024 02:31:34 -0700 (PDT)
Message-ID: <92b7375f-7239-4fbd-bedd-b3b8d55bf7a1@arm.com>
Date: Thu, 4 Jul 2024 10:31:32 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] selftests: introduce and use SELFTESTS_CC_IS_CLANG
 instead of LLVM
Content-Language: en-GB
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
 LKML <linux-kernel@vger.kernel.org>
References: <20240704030452.88793-1-jhubbard@nvidia.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240704030452.88793-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/07/2024 04:04, John Hubbard wrote:
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

I'm makefile-illiterate so not really qualified to review. But the concept
certainly looks fine to me.

Thanks,
Ryan

> 
> thanks,
> John Hubbard
> 
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


