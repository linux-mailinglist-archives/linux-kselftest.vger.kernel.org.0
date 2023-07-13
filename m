Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03289752B4B
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 22:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjGMUCh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 16:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjGMUCg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 16:02:36 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FAE2D50
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 13:02:34 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id e9e14a558f8ab-34637e55d9dso793575ab.1
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 13:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1689278554; x=1689883354;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ivegnJY0e81uEIcQL/+AUl0jNxUcDJZGfjh6X1XgJhc=;
        b=JTrnUxXTNaCRk1hGgR6DtGad2KLIFReAkYi9F7WIKUOzXx42wJZ3S4NmDSDoamVNU8
         4VITMcTzxgFrXo++/Y+Bn7tgflSkX9cpQHTInqz4yfFwk+Xq6503c1f//0Ha7eBnr2Z8
         Oo02Y22OTpugOdXnAgu5ICTSYgWKFrl/8SXfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689278554; x=1689883354;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ivegnJY0e81uEIcQL/+AUl0jNxUcDJZGfjh6X1XgJhc=;
        b=CDMmQ6EU1pvOJ/oJMZhAe7wsPAIwJAuZZB8Ul8yTH8mdwtt3HsBlxLN6SDFfL+nXmc
         uJV3s7IwK4zRO2YbHDYF/LLpPVCmVwb1NoSEVChfeBc50YkNamu3B9aV/MQvx31zWi9h
         qEbRaySRIbUGdUBQPg8YGBftVEWmdT6dyCJZALUqXmP400R+yMZEM1xRyJoYiBx5OflZ
         E9T8olMxsiHobc/wIZBX7JdwvxQLOIAJoNVTLUkKPKE/EIRdFMczymbZq6kT+KqadwHZ
         ZDruahiP13Zmo80WPj7jso1cz2wVw1hL40msJEGh17l0GjO4ELzP9FzfsXDibUXOmBAa
         AAkA==
X-Gm-Message-State: ABy/qLZiINoACn+lFgX6ffbd3nyvge1HeJ17IX/AwWTtBbZX5xh+3HiN
        prbruVRSaTZs0VizgKkAYbEOGg==
X-Google-Smtp-Source: APBJJlHq+cSUbxM0oZMtNU+5ue5zTRSKurMgx9UQi6A/mnWzTQ5s9cLiX4TBStF4ZPFbC0YbeNKUXg==
X-Received: by 2002:a05:6602:3ce:b0:780:c6bb:ad8d with SMTP id g14-20020a05660203ce00b00780c6bbad8dmr3203165iov.0.1689278554210;
        Thu, 13 Jul 2023 13:02:34 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id z25-20020a02ceb9000000b0042b39f1c3d2sm2129524jaq.144.2023.07.13.13.02.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 13:02:33 -0700 (PDT)
Message-ID: <8d944238-1a9a-e93e-fdab-54e74fa12e11@linuxfoundation.org>
Date:   Thu, 13 Jul 2023 14:02:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] selftests: Fix arm64 test installation
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230710-kselftest-fix-arm64-v1-1-48e872844f25@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230710-kselftest-fix-arm64-v1-1-48e872844f25@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/10/23 08:04, Mark Brown wrote:
> The recent change fc96c7c19df ("selftests: error out if kernel header
> files are not yet built") to generate an error message when building
> kselftests without having installed the headers is generating spurious
> failures during the install step which breaks the arm64 selftests (and
> only the arm64 selftests):
> 
> Emit Tests for arm64
> make[5]: *** [../../lib.mk:81: kernel_header_files] Error 1
> make[5]: *** [../../lib.mk:81: kernel_header_files] Error 1
> make[5]: *** [../../lib.mk:81: kernel_header_files] Error 1
> make[5]: *** [../../lib.mk:81: kernel_header_files] Error 1
> make[5]: *** [../../lib.mk:81: kernel_header_files] Error 1
> make[5]: *** [../../lib.mk:81: kernel_header_files] Error 1
> make[5]: *** [../../lib.mk:81: kernel_header_files] Error 1
> make[4]: *** [Makefile:26: all] Error 2
> 
> Presumably the arm64 tests are doing something unusual in their build
> setup which could be adjusted but I didn't immediately see it and since
> this is having a serious impact on test coverage in automation let's
> just revert for now.
> 
> This is causing failures in KernelCI with the command:
> 
>     make KBUILD_BUILD_USER=KernelCI FORMAT=.xz ARCH=arm64 HOSTCC=gcc CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- CC="ccache aarch64-linux-gnu-gcc" O=/tmp/kci/linux/build -C/tmp/kci/linux -j10 kselftest-gen_tar
> 
> and also when building using tuxmake.
> 
> Full log: https://storage.kernelci.org/mainline/master/v6.5-rc1/arm64/defconfig/gcc-10/logs/kselftest.log
> 
> Fixes: 9fc96c7c19df ("selftests: error out if kernel header files are not yet built")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   tools/testing/selftests/Makefile | 21 +--------------------
>   tools/testing/selftests/lib.mk   | 40 +++-------------------------------------
>   2 files changed, 4 insertions(+), 57 deletions(-)
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 666b56f22a41..405683b8cb39 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -146,12 +146,10 @@ ifneq ($(KBUILD_OUTPUT),)
>     abs_objtree := $(realpath $(abs_objtree))
>     BUILD := $(abs_objtree)/kselftest
>     KHDR_INCLUDES := -isystem ${abs_objtree}/usr/include
> -  KHDR_DIR := ${abs_objtree}/usr/include
>   else
>     BUILD := $(CURDIR)
>     abs_srctree := $(shell cd $(top_srcdir) && pwd)
>     KHDR_INCLUDES := -isystem ${abs_srctree}/usr/include
> -  KHDR_DIR := ${abs_srctree}/usr/include
>     DEFAULT_INSTALL_HDR_PATH := 1
>   endif
>   
> @@ -165,7 +163,7 @@ export KHDR_INCLUDES
>   # all isn't the first target in the file.
>   .DEFAULT_GOAL := all
>   
> -all: kernel_header_files
> +all:
>   	@ret=1;							\
>   	for TARGET in $(TARGETS); do				\
>   		BUILD_TARGET=$$BUILD/$$TARGET;			\
> @@ -176,23 +174,6 @@ all: kernel_header_files
>   		ret=$$((ret * $$?));				\
>   	done; exit $$ret;
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
>   run_tests: all
>   	@for TARGET in $(TARGETS); do \
>   		BUILD_TARGET=$$BUILD/$$TARGET;	\
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index d17854285f2b..05400462c779 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -44,26 +44,10 @@ endif
>   selfdir = $(realpath $(dir $(filter %/lib.mk,$(MAKEFILE_LIST))))
>   top_srcdir = $(selfdir)/../../..
>   
> -ifeq ("$(origin O)", "command line")
> -  KBUILD_OUTPUT := $(O)
> +ifeq ($(KHDR_INCLUDES),)
> +KHDR_INCLUDES := -isystem $(top_srcdir)/usr/include
>   endif
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
>   # The following are built by lib.mk common compile rules.
>   # TEST_CUSTOM_PROGS should be used by tests that require
>   # custom build rule and prevent common build rule use.
> @@ -74,25 +58,7 @@ TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
>   TEST_GEN_PROGS_EXTENDED := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS_EXTENDED))
>   TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
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
>   define RUN_TESTS
>   	BASE_DIR="$(selfdir)";			\
> 
> ---
> base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
> change-id: 20230710-kselftest-fix-arm64-c023160018d7
> 
> Best regards,

Thank you. Will apply the patch for the next rc

thanks,
-- Shuah
