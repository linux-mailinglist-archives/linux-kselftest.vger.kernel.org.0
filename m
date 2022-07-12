Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52048571650
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Jul 2022 11:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbiGLJ7T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Jul 2022 05:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbiGLJ7S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Jul 2022 05:59:18 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA1F30F4D
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Jul 2022 02:59:16 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id q82so7116566pgq.6
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Jul 2022 02:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E3bJNjTQ0sljopXALlhyXxa+mX72VOlGEbg1L7QIj1E=;
        b=sWuqwMsZhRcRkPdenKadW7Dk/P/7ur4EL9j6sqVJ1bhlRfAY/oc7xmZVG1CiFGk0Ns
         ljYuR0X/umNI2OYd0XO6XR9zETL1IGaw/Zn/J8+VPfgcB/6atpffIZRhjsK0TILzHjdB
         B+LnH2U5prvK022gJ9+wZ32aGjsm2fIaVJPaEjCzDWclbcDTZUzvWp7uEisBBdtPYbLT
         KiWyfu1ocqksvCW4CGzQ2GRXXpi1xWdyRd55/JdRNg/PnoekbukxOj011f5a24tooUea
         Hm2ftl0+N3xge9PtB31Rps2eG7q9Mmp7SWAdl3fPRVZJSN0h+gtJarWOCsKDlCZzqqoN
         Az7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E3bJNjTQ0sljopXALlhyXxa+mX72VOlGEbg1L7QIj1E=;
        b=nqiAMZa2o+PR5ylCalybrks9YggeDESrj86wNVTPCf44s0sLBbdEwUUobdzynQ1hq8
         aritNmoakpfRkNrGtiJaNBZ4RMuBXbGYCw4AMsL65WN/dxzl5ctpF7Y2JWjuWo4TZQ5Y
         /i6g64B2O+WBqSCJMbwHMCj9uE69gUrqbi4Ba2ZIesfbf5GDQXSlVPd3r8KGji1Ah8k/
         Ig/B9WEZgAWltSUg4dxFN0ewN7LX4NvczCQL4I1VbxrpdX/zWz5+Q391KV82lfI0jb6O
         pwhftYQiwZuyDIBu6V6sCMmEV5Tlo/WvZWcEUm6monHaMDkfBtzAGLkrEJhCblKnEEQM
         AOtQ==
X-Gm-Message-State: AJIora8kiTIjGfLabTlfDcGpd/1UmubcTi3FqzIHIIWKXIoHLSJ3iJDe
        H0/a+Pj93bo4bpTA1ksWJprfNPWFxdF+f0RgIFmTXg==
X-Google-Smtp-Source: AGRyM1vSzjtgajGp71G/0ie+k3dbRm2QwTG+7RmZ7o5xoHl2yAHh8E/V3nqMqiFQf9cqXYtzhvIWXeuxZ2AenxkhL2U=
X-Received: by 2002:a65:6a4a:0:b0:40d:dd27:80fd with SMTP id
 o10-20020a656a4a000000b0040ddd2780fdmr20580395pgu.54.1657619956363; Tue, 12
 Jul 2022 02:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1657614127.git.guillaume.tucker@collabora.com> <4a66bf3227825bbf9007ffc9c10e52fad9ae453f.1657614127.git.guillaume.tucker@collabora.com>
In-Reply-To: <4a66bf3227825bbf9007ffc9c10e52fad9ae453f.1657614127.git.guillaume.tucker@collabora.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 12 Jul 2022 11:59:05 +0200
Message-ID: <CADYN=9L6-ESg=mxAwXCPwcO1RTE1S5DvigpvL13+tLMWs0wB-g@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] selftests: drop KSFT_KHDR_INSTALL make target
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>, Tim.Bird@sony.com,
        kernel@collabora.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 12 Jul 2022 at 10:29, Guillaume Tucker
<guillaume.tucker@collabora.com> wrote:
>
> Drop the KSFT_KHDR_INSTALL make target now that all use-cases have
> been removed from the other kselftest Makefiles.
>
> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
> ---
>  tools/testing/selftests/Makefile |  1 -
>  tools/testing/selftests/lib.mk   | 38 --------------------------------
>  2 files changed, 39 deletions(-)
>
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 619451e82863..e060777239a4 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -143,7 +143,6 @@ endif
>  # Prepare for headers install
>  include $(top_srcdir)/scripts/subarch.include
>  ARCH           ?= $(SUBARCH)
> -export KSFT_KHDR_INSTALL_DONE := 1
>  export BUILD
>  export KHDR_INCLUDES
>
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index 2a2d240cdc1b..df5f853951f2 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -30,45 +30,7 @@ TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
>  TEST_GEN_PROGS_EXTENDED := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS_EXTENDED))
>  TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
>
> -ifdef KSFT_KHDR_INSTALL
> -top_srcdir ?= ../../../..
> -include $(top_srcdir)/scripts/subarch.include
> -ARCH           ?= $(SUBARCH)
> -
> -# set default goal to all, so make without a target runs all, even when
> -# all isn't the first target in the file.
> -.DEFAULT_GOAL := all
> -
> -# Invoke headers install with --no-builtin-rules to avoid circular
> -# dependency in "make kselftest" case. In this case, second level
> -# make inherits builtin-rules which will use the rule generate
> -# Makefile.o and runs into
> -# "Circular Makefile.o <- prepare dependency dropped."
> -# and headers_install fails and test compile fails.
> -# O= KBUILD_OUTPUT cases don't run into this error, since main Makefile
> -# invokes them as sub-makes and --no-builtin-rules is not necessary,
> -# but doesn't cause any failures. Keep it simple and use the same
> -# flags in both cases.
> -# Note that the support to install headers from lib.mk is necessary
> -# when test Makefile is run directly with "make -C".
> -# When local build is done, headers are installed in the default
> -# INSTALL_HDR_PATH usr/include.
> -.PHONY: khdr
> -.NOTPARALLEL:
> -khdr:
> -ifndef KSFT_KHDR_INSTALL_DONE
> -ifeq (1,$(DEFAULT_INSTALL_HDR_PATH))
> -       $(MAKE) --no-builtin-rules ARCH=$(ARCH) -C $(top_srcdir) headers_install
> -else
> -       $(MAKE) --no-builtin-rules INSTALL_HDR_PATH=$$OUTPUT/usr \
> -               ARCH=$(ARCH) -C $(top_srcdir) headers_install
> -endif
> -endif
> -
> -all: khdr $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
> -else
>  all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
> -endif
>
>  define RUN_TESTS
>         BASE_DIR="$(selfdir)";                  \

Should this be removed as well, since 'khdr' gets droped from file the lib.mk ?

diff --git a/tools/testing/selftests/landlock/Makefile
b/tools/testing/selftests/landlock/Makefile
index 1313e44e8fb9..99f88c52d61a 100644
--- a/tools/testing/selftests/landlock/Makefile
+++ b/tools/testing/selftests/landlock/Makefile
@@ -13,9 +13,6 @@ include ../lib.mk

 khdr_dir = $(top_srcdir)/usr/include

-$(khdr_dir)/linux/landlock.h: khdr
-        @:
-
 $(OUTPUT)/true: true.c
  $(LINK.c) $< $(LDLIBS) -o $@ -static


Cheers,
Anders
