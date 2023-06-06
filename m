Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DFE723AD6
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 10:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235857AbjFFIAj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 04:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237191AbjFFIAU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 04:00:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312A82D71;
        Tue,  6 Jun 2023 00:57:54 -0700 (PDT)
Received: from [192.168.10.48] (unknown [119.152.150.198])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 33DCF6606E98;
        Tue,  6 Jun 2023 08:57:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686038272;
        bh=3mvikzsrZ6UUqHFtYoJSndS+MYKtof2+48NtxLq92KI=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=kVLKlUef7fSpaZPOn+iXxXPHzOr7Ff+dAj1OX0Cvym0iDwVQDV0rpmtNtBrWndlRN
         l0EZlowVKOe00KX1u6LUgu0igsYeckNmUCH2YqzzLO4HikM5PbAxwUOKQiJueOT2WX
         IlLUinbeLUTDgsi/XZzvTyAQk2wqa+lFppzCh9gaTO6HlHhhyPKvWFGqxGiAvUpW74
         fUZx7f6aU54I/53kB+dve3V/wFBKZuqKnFIbA76XvHVK0LSW3RkX6SE66+TrfD11b8
         P7je2uYEnUVoNTHVrLP5G85A6n/GqrF4AtICxmt/0yyOQp5fxLmVLDEC2PmSU6pdZR
         fofv2mkKzzLlw==
Message-ID: <59b157ac-d6ee-c122-802c-a44b0f9463a5@collabora.com>
Date:   Tue, 6 Jun 2023 12:57:46 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 11/11] selftests: error out if kernel header files are
 not yet built
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230606071637.267103-1-jhubbard@nvidia.com>
 <20230606071637.267103-12-jhubbard@nvidia.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20230606071637.267103-12-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/6/23 12:16 PM, John Hubbard wrote:
> As per a discussion with Muhammad Usama Anjum [1], the following is how
> one is supposed to build selftests:
> 
>     make headers && make -C tools/testing/selftests/mm
> 
> Change the selftest build system's lib.mk to fail out with a helpful
> message if that prerequisite "make headers" has not been done yet.
> 
> [1] https://lore.kernel.org/all/bf910fa5-0c96-3707-cce4-5bcc656b6274@collabora.com/
> 
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/lib.mk | 36 +++++++++++++++++++++++++++++++---
>  1 file changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index 05400462c779..b8ea03b9a015 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -44,10 +44,22 @@ endif
>  selfdir = $(realpath $(dir $(filter %/lib.mk,$(MAKEFILE_LIST))))
>  top_srcdir = $(selfdir)/../../..
>  
> -ifeq ($(KHDR_INCLUDES),)
> -KHDR_INCLUDES := -isystem $(top_srcdir)/usr/include
> +ifneq ($(KBUILD_OUTPUT),)
> +  # Make's built-in functions such as $(abspath ...), $(realpath ...) cannot
> +  # expand a shell special character '~'. We use a somewhat tedious way here.
> +  abs_objtree := $(shell cd $(top_srcdir) && mkdir -p $(KBUILD_OUTPUT) && cd $(KBUILD_OUTPUT) && pwd)
> +  $(if $(abs_objtree),, \
> +    $(error failed to create output directory "$(KBUILD_OUTPUT)"))
> +  # $(realpath ...) resolves symlinks
> +  abs_objtree := $(realpath $(abs_objtree))
> +  KHDR_DIR := ${abs_objtree}/usr/include
> +else
> +  abs_srctree := $(shell cd $(top_srcdir) && pwd)
> +  KHDR_DIR := ${abs_srctree}/usr/include
>  endif
>  
> +KHDR_INCLUDES := -isystem $(KHDR_DIR)
> +
>  # The following are built by lib.mk common compile rules.
>  # TEST_CUSTOM_PROGS should be used by tests that require
>  # custom build rule and prevent common build rule use.
> @@ -58,7 +70,25 @@ TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
>  TEST_GEN_PROGS_EXTENDED := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS_EXTENDED))
>  TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
>  
> -all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
> +all: kernel_header_files $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) \
> +     $(TEST_GEN_FILES)
> +
> +kernel_header_files:
> +	@ls $(KHDR_DIR)/linux/*.h >/dev/null 2>/dev/null;                      \
> +	if [ $$? -ne 0 ]; then                                                 \
> +            RED='\033[1;31m';                                                  \
> +            NOCOLOR='\033[0m';                                                 \
> +            echo;                                                              \
> +            echo -e "$${RED}error$${NOCOLOR}: missing kernel header files.";   \
> +            echo "Please run this and try again:";                             \
> +            echo;                                                              \
> +            echo "    cd $(top_srcdir)";                                       \
> +            echo "    make headers";                                           \
> +            echo;                                                              \
> +	    exit 1; \
> +	fi
> +
> +.PHONY: kernel_header_files
>  
>  define RUN_TESTS
>  	BASE_DIR="$(selfdir)";			\

-- 
BR,
Muhammad Usama Anjum
