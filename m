Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF82B72536F
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jun 2023 07:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjFGFiG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 01:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjFGFiE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 01:38:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEEB19AE;
        Tue,  6 Jun 2023 22:38:03 -0700 (PDT)
Received: from [192.168.10.48] (unknown [119.152.150.198])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0AE0F6606EEC;
        Wed,  7 Jun 2023 06:37:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686116281;
        bh=f1FBPoNEcIA/RvJGHRkui9e4p0KP/htHwb3NWS5C6Vo=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=RqWuz7dmAksyq7kNhCW7jH2xEUBFNlEXFcdkOy5tJx6sppe4KZKiZXOuzcTjL2uNi
         6CKyglBlAuCGTMstK50tH70sJrgkw0BuMc7bPUAlRTOxIceQmp30IsJUcDL/qNyz3/
         xCsZ9G8plPr8vHpuKC8YWoDNeVTFUrnaiPtfjUS9ds1hJ8+TACSKsGYe5reTmR8x8U
         NZO5jDLWNmhNuQo0fu6vN62wrnTbqXvgbaTUWC9K0AD3Jr4h/h33YpvNpJUuUD5yK/
         dlUTlpfkWDk1wvfKphK8xmu/7jYh82AGBncS/CJVJiCb77P7bbDs9bTHjuEibluBTM
         4hF1TZ86vOKnA==
Message-ID: <dc6651ad-3796-b7ab-a2fe-98b535d48ed2@collabora.com>
Date:   Wed, 7 Jun 2023 10:37:54 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 11/11] selftests: error out if kernel header files are
 not yet built
To:     John Hubbard <jhubbard@nvidia.com>
References: <20230606071637.267103-1-jhubbard@nvidia.com>
 <20230606071637.267103-12-jhubbard@nvidia.com>
 <8e208e0f-699c-2c34-d66e-bf6d488a7a1e@collabora.com>
 <14573e7e-f2ad-ff34-dfbd-3efdebee51ed@nvidia.com>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <14573e7e-f2ad-ff34-dfbd-3efdebee51ed@nvidia.com>
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

On 6/7/23 1:10 AM, John Hubbard wrote:
> On 6/6/23 00:38, Muhammad Usama Anjum wrote:
> ...
>>> +kernel_header_files:
>>> +	@ls $(KHDR_DIR)/linux/*.h >/dev/null 2>/dev/null;                      \
>>> +	if [ $$? -ne 0 ]; then                                                 \
>>> +            RED='\033[1;31m';                                                  \
>>> +            NOCOLOR='\033[0m';                                                 \
>>> +            echo;                                                              \
>>> +            echo -e "$${RED}error$${NOCOLOR}: missing kernel header files.";   \
>>> +            echo "Please run this and try again:";                             \
>>> +            echo;                                                              \
>>> +            echo "    cd $(top_srcdir)";                                       \
>>> +            echo "    make headers";                                           \
>>> +            echo;                                                              \
>>> +	    exit 1; \
>>> +	fi
>> Thank you for adding this. This is outputting error for every selftest
>> directory. We should try to make it even better by just aborting the
>> Make-ing process the first time headers aren't detected. We can do this now
>> or later, fine by me.
>>
> OK, I see. Yes, this can be improved by adding the same mechanism to the 
> selftests/Makefile, that is in selftests/mm/Makefile.
> 
> I'd like to keep both, because as I mentioned earlier, mm folks like to
> run just that one Makefile, sometimes, and selftests/mm/Makefile is not
> invoking the top level Makefile. Rather, it includes lib.mk--which the
> top level Makefile does *not* include.
> 
> Arguably, using includes instead of recursive Make, would improve this
> framework: reduce duplication such as the above. But that's a larger
> project and just food for thought at this point.
> 
> Anyway, this works nicely on my system, and I'll attach it as a patch
> also in case you want to try it out. What do you think of this:
Nice patch. Thanks. Lets add this patch as well. Please add the tag for
this new patch:

Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 90a62cf75008..bdca160063d8 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -144,10 +144,12 @@ ifneq ($(KBUILD_OUTPUT),)
>    abs_objtree := $(realpath $(abs_objtree))
>    BUILD := $(abs_objtree)/kselftest
>    KHDR_INCLUDES := -isystem ${abs_objtree}/usr/include
> +  KHDR_DIR := ${abs_objtree}/usr/include
>  else
>    BUILD := $(CURDIR)
>    abs_srctree := $(shell cd $(top_srcdir) && pwd)
>    KHDR_INCLUDES := -isystem ${abs_srctree}/usr/include
> +  KHDR_DIR := ${abs_srctree}/usr/include
>    DEFAULT_INSTALL_HDR_PATH := 1
>  endif
>  
> @@ -161,7 +163,7 @@ export KHDR_INCLUDES
>  # all isn't the first target in the file.
>  .DEFAULT_GOAL := all
>  
> -all:
> +all: kernel_header_files
>  	@ret=1;							\
>  	for TARGET in $(TARGETS); do				\
>  		BUILD_TARGET=$$BUILD/$$TARGET;			\
> @@ -172,6 +174,23 @@ all:
>  		ret=$$((ret * $$?));				\
>  	done; exit $$ret;
>  
> +kernel_header_files:
> +	@ls $(KHDR_DIR)/linux/*.h >/dev/null 2>/dev/null;                          \
> +	if [ $$? -ne 0 ]; then                                                     \
> +            RED='\033[1;31m';                                                  \
> +            NOCOLOR='\033[0m';                                                 \
> +            echo;                                                              \
> +            echo -e "$${RED}error$${NOCOLOR}: missing kernel header files.";   \
> +            echo "Please run this and try again:";                             \
> +            echo;                                                              \
> +            echo "    cd $(top_srcdir)";                                       \
> +            echo "    make headers";                                           \
> +            echo;                                                              \
> +	    exit 1;                                                                \
> +	fi
> +
> +.PHONY: kernel_header_files
> +
>  run_tests: all
>  	@for TARGET in $(TARGETS); do \
>  		BUILD_TARGET=$$BUILD/$$TARGET;	\
> 
> 
> 
> thanks,

-- 
BR,
Muhammad Usama Anjum
