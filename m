Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BD8571D7C
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Jul 2022 16:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbiGLO7C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Jul 2022 10:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiGLO6y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Jul 2022 10:58:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88AEE0B7;
        Tue, 12 Jul 2022 07:58:50 -0700 (PDT)
Received: from [192.168.42.12] (92.40.179.87.threembb.co.uk [92.40.179.87])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: gtucker)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E86546601A32;
        Tue, 12 Jul 2022 15:58:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657637929;
        bh=HBR+7cjhP4fVVEqyGTg8INVtO0X5hd7bY9eUZpzH2nM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Q7rZKrTNV+Bxgj3CTfgaTU+5x3dUl1sIVHGaLeRM0FJ23MoSv7LZI4RysqlU85Omi
         /AYgxbWhuVFZ/EHfnstKlP2dZPF8Cpl4GFrapkGJckAIBVLX7qhd5W1iGG+NH/+jzs
         3ESowFMqxOhwglqVaSvjj/nojOdX4yoDnr2umIYoGSj9/pZnGclyf15YiLEi5lDXLY
         63lXYjZYOhLLKVTmbs6AP/reucI43smThber+Dof80LW/780hL8YqcMNr/wi3F73yV
         LpIUM0soaHTjOZ8Pki5FPJ5lEknM75nJlQsBFyBvnYT//4bqD6eS0yV/ratirl4t93
         1H4uaMKsNh+cg==
Message-ID: <950e172d-b45b-af70-972b-146c10b69714@collabora.com>
Date:   Tue, 12 Jul 2022 15:57:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 3/4] selftests: drop KSFT_KHDR_INSTALL make target
Content-Language: en-US
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>, Tim.Bird@sony.com,
        kernel@collabora.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <cover.1657614127.git.guillaume.tucker@collabora.com>
 <4a66bf3227825bbf9007ffc9c10e52fad9ae453f.1657614127.git.guillaume.tucker@collabora.com>
 <CADYN=9L6-ESg=mxAwXCPwcO1RTE1S5DvigpvL13+tLMWs0wB-g@mail.gmail.com>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
In-Reply-To: <CADYN=9L6-ESg=mxAwXCPwcO1RTE1S5DvigpvL13+tLMWs0wB-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/07/2022 10:59, Anders Roxell wrote:
> On Tue, 12 Jul 2022 at 10:29, Guillaume Tucker
> <guillaume.tucker@collabora.com> wrote:
>>
>> Drop the KSFT_KHDR_INSTALL make target now that all use-cases have
>> been removed from the other kselftest Makefiles.
>>
>> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
>> ---
>>  tools/testing/selftests/Makefile |  1 -
>>  tools/testing/selftests/lib.mk   | 38 --------------------------------
>>  2 files changed, 39 deletions(-)
>>
>> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
>> index 619451e82863..e060777239a4 100644
>> --- a/tools/testing/selftests/Makefile
>> +++ b/tools/testing/selftests/Makefile
>> @@ -143,7 +143,6 @@ endif
>>  # Prepare for headers install
>>  include $(top_srcdir)/scripts/subarch.include
>>  ARCH           ?= $(SUBARCH)
>> -export KSFT_KHDR_INSTALL_DONE := 1
>>  export BUILD
>>  export KHDR_INCLUDES
>>
>> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
>> index 2a2d240cdc1b..df5f853951f2 100644
>> --- a/tools/testing/selftests/lib.mk
>> +++ b/tools/testing/selftests/lib.mk
>> @@ -30,45 +30,7 @@ TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
>>  TEST_GEN_PROGS_EXTENDED := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS_EXTENDED))
>>  TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
>>
>> -ifdef KSFT_KHDR_INSTALL
>> -top_srcdir ?= ../../../..
>> -include $(top_srcdir)/scripts/subarch.include
>> -ARCH           ?= $(SUBARCH)
>> -
>> -# set default goal to all, so make without a target runs all, even when
>> -# all isn't the first target in the file.
>> -.DEFAULT_GOAL := all
>> -
>> -# Invoke headers install with --no-builtin-rules to avoid circular
>> -# dependency in "make kselftest" case. In this case, second level
>> -# make inherits builtin-rules which will use the rule generate
>> -# Makefile.o and runs into
>> -# "Circular Makefile.o <- prepare dependency dropped."
>> -# and headers_install fails and test compile fails.
>> -# O= KBUILD_OUTPUT cases don't run into this error, since main Makefile
>> -# invokes them as sub-makes and --no-builtin-rules is not necessary,
>> -# but doesn't cause any failures. Keep it simple and use the same
>> -# flags in both cases.
>> -# Note that the support to install headers from lib.mk is necessary
>> -# when test Makefile is run directly with "make -C".
>> -# When local build is done, headers are installed in the default
>> -# INSTALL_HDR_PATH usr/include.
>> -.PHONY: khdr
>> -.NOTPARALLEL:
>> -khdr:
>> -ifndef KSFT_KHDR_INSTALL_DONE
>> -ifeq (1,$(DEFAULT_INSTALL_HDR_PATH))
>> -       $(MAKE) --no-builtin-rules ARCH=$(ARCH) -C $(top_srcdir) headers_install
>> -else
>> -       $(MAKE) --no-builtin-rules INSTALL_HDR_PATH=$$OUTPUT/usr \
>> -               ARCH=$(ARCH) -C $(top_srcdir) headers_install
>> -endif
>> -endif
>> -
>> -all: khdr $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
>> -else
>>  all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
>> -endif
>>
>>  define RUN_TESTS
>>         BASE_DIR="$(selfdir)";                  \
> 
> Should this be removed as well, since 'khdr' gets droped from file the lib.mk ?
> 
> diff --git a/tools/testing/selftests/landlock/Makefile
> b/tools/testing/selftests/landlock/Makefile
> index 1313e44e8fb9..99f88c52d61a 100644
> --- a/tools/testing/selftests/landlock/Makefile
> +++ b/tools/testing/selftests/landlock/Makefile
> @@ -13,9 +13,6 @@ include ../lib.mk
> 
>  khdr_dir = $(top_srcdir)/usr/include
> 
> -$(khdr_dir)/linux/landlock.h: khdr
> -        @:
> -
>  $(OUTPUT)/true: true.c
>   $(LINK.c) $< $(LDLIBS) -o $@ -static


Good point, however I think I'll drop it in PATCH 1/4 "selftests:
drop khdr make target" as it's already dropped there.  Ideally,
the khdr dependency mentioned in this PATCH 3/4 should probably
also be removed in PATCH 1/4.  I'll send a v3 with this.

Thanks,
Guillaume
