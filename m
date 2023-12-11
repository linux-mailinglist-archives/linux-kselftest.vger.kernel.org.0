Return-Path: <linux-kselftest+bounces-1519-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D34580C7AB
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 12:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA41A28157F
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 11:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F97347A2;
	Mon, 11 Dec 2023 11:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="sRrefK8Y"
X-Original-To: linux-kselftest@vger.kernel.org
X-Greylist: delayed 445 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Dec 2023 03:08:31 PST
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [IPv6:2a00:1098:ed:100::25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8A9B0;
	Mon, 11 Dec 2023 03:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702292463;
	bh=wib/6cysoLS1GsZLFc9O493Nd0EM/CV957JsOjYbBew=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=sRrefK8Yr5bj87ARlFcoM3qcvIMPxtbiqX9y9jFqY23cE3yDxMkxj+5ccVJgqwbKj
	 R528HS8yn4UkqP6hCznbTvGkmmlwjdio3U+IoBFnYcrFPWv0TgYAaPVryigG/I6LVv
	 JRh1hd2NDy5gYta04N7q+hpOohGWFbh00ufdy9QmvDqgZaV9GtyhNOfPV/3J9vOiaR
	 FrFGIjWDsHSrVhY5s/1USXPp4sUMM1jT6HjloCzsR79g+Oh7qzWWaPhWtNF8p6wiFA
	 I1qyA0qOcnsgQZcqSxongHbvAVzJR35M2MFdpWjUBhkQnQhPPVcbZdpBoR7ikI29/w
	 J1AEQjJ2jgbAA==
Received: from [100.96.234.34] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5BC693781417;
	Mon, 11 Dec 2023 11:00:57 +0000 (UTC)
Message-ID: <0b35fcbd-ce8c-4c12-9725-01f18ade9fc0@collabora.com>
Date: Mon, 11 Dec 2023 16:00:53 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Anders Roxell
 <anders.roxell@linaro.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Revert "selftests: error out if kernel header files are
 not yet built"
To: John Hubbard <jhubbard@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20231209020144.244759-1-jhubbard@nvidia.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20231209020144.244759-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/9/23 7:01 AM, John Hubbard wrote:
> This reverts commit 9fc96c7c19df ("selftests: error out if kernel header
> files are not yet built").
I don't think whole of this commit needs to be reverted. Lets leave the
warning message as it is and just remove the condition to abort the
compilation.

> 
> It turns out that requiring the kernel headers to be built as a
> prerequisite to building selftests, does not work in many cases. For
> example, Peter Zijlstra writes:
> 
> "My biggest beef with the whole thing is that I simply do not want to use
> 'make headers', it doesn't work for me.
> 
> I have a ton of output directories and I don't care to build tools into
> the output dirs, in fact some of them flat out refuse to work that way
> (bpf comes to mind)." [1]
> 
> Therefore, stop erroring out on the selftests build. Additional patches
> will be required in order to change over to not requiring the kernel
> headers.
> 
> [1] https://lore.kernel.org/20231208221007.GO28727@noisy.programming.kicks-ass.net
> 
> Cc: Anders Roxell <anders.roxell@linaro.org>
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  tools/testing/selftests/Makefile | 21 +----------------
>  tools/testing/selftests/lib.mk   | 40 +++-----------------------------
>  2 files changed, 4 insertions(+), 57 deletions(-)
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 3b2061d1c1a5..8247a7c69c36 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -155,12 +155,10 @@ ifneq ($(KBUILD_OUTPUT),)
>    abs_objtree := $(realpath $(abs_objtree))
>    BUILD := $(abs_objtree)/kselftest
>    KHDR_INCLUDES := -isystem ${abs_objtree}/usr/include
> -  KHDR_DIR := ${abs_objtree}/usr/include
>  else
>    BUILD := $(CURDIR)
>    abs_srctree := $(shell cd $(top_srcdir) && pwd)
>    KHDR_INCLUDES := -isystem ${abs_srctree}/usr/include
> -  KHDR_DIR := ${abs_srctree}/usr/include
>    DEFAULT_INSTALL_HDR_PATH := 1
>  endif
>  
> @@ -174,7 +172,7 @@ export KHDR_INCLUDES
>  # all isn't the first target in the file.
>  .DEFAULT_GOAL := all
>  
> -all: kernel_header_files
> +all:
>  	@ret=1;							\
>  	for TARGET in $(TARGETS); do				\
>  		BUILD_TARGET=$$BUILD/$$TARGET;			\
> @@ -185,23 +183,6 @@ all: kernel_header_files
>  		ret=$$((ret * $$?));				\
>  	done; exit $$ret;
>  
> -kernel_header_files:
> -	@ls $(KHDR_DIR)/linux/*.h >/dev/null 2>/dev/null;                          \
> -	if [ $$? -ne 0 ]; then                                                     \
> -            RED='\033[1;31m';                                                  \
> -            NOCOLOR='\033[0m';                                                 \
> -            echo;                                                              \
> -            echo -e "$${RED}error$${NOCOLOR}: missing kernel header files.";   \
> -            echo "Please run this and try again:";                             \
> -            echo;                                                              \
> -            echo "    cd $(top_srcdir)";                                       \
> -            echo "    make headers";                                           \
> -            echo;                                                              \
> -	    exit 1;                                                                \
> -	fi
> -
> -.PHONY: kernel_header_files
> -
>  run_tests: all
>  	@for TARGET in $(TARGETS); do \
>  		BUILD_TARGET=$$BUILD/$$TARGET;	\
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index 118e0964bda9..aa646e0661f3 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -44,26 +44,10 @@ endif
>  selfdir = $(realpath $(dir $(filter %/lib.mk,$(MAKEFILE_LIST))))
>  top_srcdir = $(selfdir)/../../..
>  
> -ifeq ("$(origin O)", "command line")
> -  KBUILD_OUTPUT := $(O)
> +ifeq ($(KHDR_INCLUDES),)
> +KHDR_INCLUDES := -isystem $(top_srcdir)/usr/include
>  endif
>  
> -ifneq ($(KBUILD_OUTPUT),)
> -  # Make's built-in functions such as $(abspath ...), $(realpath ...) cannot
> -  # expand a shell special character '~'. We use a somewhat tedious way here.
> -  abs_objtree := $(shell cd $(top_srcdir) && mkdir -p $(KBUILD_OUTPUT) && cd $(KBUILD_OUTPUT) && pwd)
> -  $(if $(abs_objtree),, \
> -    $(error failed to create output directory "$(KBUILD_OUTPUT)"))
> -  # $(realpath ...) resolves symlinks
> -  abs_objtree := $(realpath $(abs_objtree))
> -  KHDR_DIR := ${abs_objtree}/usr/include
> -else
> -  abs_srctree := $(shell cd $(top_srcdir) && pwd)
> -  KHDR_DIR := ${abs_srctree}/usr/include
> -endif
> -
> -KHDR_INCLUDES := -isystem $(KHDR_DIR)
> -
>  # The following are built by lib.mk common compile rules.
>  # TEST_CUSTOM_PROGS should be used by tests that require
>  # custom build rule and prevent common build rule use.
> @@ -74,25 +58,7 @@ TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
>  TEST_GEN_PROGS_EXTENDED := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS_EXTENDED))
>  TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
>  
> -all: kernel_header_files $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) \
> -     $(TEST_GEN_FILES)
> -
> -kernel_header_files:
> -	@ls $(KHDR_DIR)/linux/*.h >/dev/null 2>/dev/null;                      \
> -	if [ $$? -ne 0 ]; then                                                 \
> -            RED='\033[1;31m';                                                  \
> -            NOCOLOR='\033[0m';                                                 \
> -            echo;                                                              \
> -            echo -e "$${RED}error$${NOCOLOR}: missing kernel header files.";   \
> -            echo "Please run this and try again:";                             \
> -            echo;                                                              \
> -            echo "    cd $(top_srcdir)";                                       \
> -            echo "    make headers";                                           \
> -            echo;                                                              \
> -	    exit 1; \
> -	fi
> -
> -.PHONY: kernel_header_files
> +all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
>  
>  define RUN_TESTS
>  	BASE_DIR="$(selfdir)";			\

-- 
BR,
Muhammad Usama Anjum

