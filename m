Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1E718522B
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Mar 2020 00:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgCMXSG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Mar 2020 19:18:06 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40975 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgCMXSG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Mar 2020 19:18:06 -0400
Received: by mail-pf1-f195.google.com with SMTP id z65so6190427pfz.8
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Mar 2020 16:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5ldfOi5ONLbPwzyRrxGXEvBjlKjPPvku4R0mnSJkLVE=;
        b=Fm0aJIBLLWT6DaaZbI9PQAulKV6KQqmYdmWI7JjyHtFTMW7gs7aqhkl7b2LuLRtSkd
         /c+SrNqnS7qp9lST7sRRQDadN8CcZP7cWKn6mU3g2AcEsFWAW1bqtKepu4PDLagnQxnf
         hAP/FX3UKzzVhJ91P9KaIkl/sAD3QWGy+v6OU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5ldfOi5ONLbPwzyRrxGXEvBjlKjPPvku4R0mnSJkLVE=;
        b=EgpCgUDaha8SmH06Ej5vB0j99UF3dnjmpS63NAoy7Cnt52hxN9P+d8JQJAKR7rKO4L
         LDRtosyVtwbmelYGRJC7W+zvKz1KKiVjeYlQY29cid4OM5+5qlgAcrpWZXRCiAqjm+Av
         BBik8OAmLNSGgKw+fJXE5ZFIf4XKFChF8ZpsMVZ/D54tiqbZTlkP53CC8XGCiXjl0NgB
         q1dnKVGtVF6mbXv46frD5WZmjpN24XHsmgfKpCooTYj+uFm5YxukvIPsj7y6PHdhHEso
         4/jK5VFenO+QdDYTi2MZn+Qucu43Kt9y6LhBhHh1cLrgiLNOFwiCj+ceE11fhaCMx9QC
         fyeQ==
X-Gm-Message-State: ANhLgQ2qhPauLEsOf82qTX7VjwrSIdvCGRmQr7JC7CJ52xdMuznmrz19
        VF0iPGJs8sV2w78/Mo8U3npJsA==
X-Google-Smtp-Source: ADFU+vs2gW1Jr/RUSgdC70UiRNwBxLRo2xZ2n+fKy8IdDt4Cr7wxF7y0z64FvaehW2RHASU+siQkcg==
X-Received: by 2002:aa7:86d2:: with SMTP id h18mr13869948pfo.313.1584141485099;
        Fri, 13 Mar 2020 16:18:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y15sm35693731pfl.149.2020.03.13.16.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 16:18:04 -0700 (PDT)
Date:   Fri, 13 Mar 2020 16:18:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     shuah@kernel.org, luto@amacapital.net, wad@chromium.org,
        daniel@iogearbox.net, kafai@fb.com, yhs@fb.com, andriin@fb.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        khilman@baylibre.com, mpe@ellerman.id.au,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v3] selftests: Fix seccomp to support relocatable build
 (O=objdir)
Message-ID: <202003131615.D132E9E9@keescook>
References: <20200313212404.24552-1-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313212404.24552-1-skhan@linuxfoundation.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 13, 2020 at 03:24:04PM -0600, Shuah Khan wrote:
> Fix seccomp relocatable builds. This is a simple fix to use the right
> lib.mk variable TEST_GEN_PROGS with dependency on kselftest_harness.h
> header, and defining LDFLAGS for pthread lib.
> 
> Removes custom clean rule which is no longer necessary with the use of
> TEST_GEN_PROGS. 
> 
> Uses $(OUTPUT) defined in lib.mk to handle build relocation.
> 
> The following use-cases work with this change:
> 
> In seccomp directory:
> make all and make clean
> 
> From top level from main Makefile:
> make kselftest-install O=objdir ARCH=arm64 HOSTCC=gcc \
>  CROSS_COMPILE=aarch64-linux-gnu- TARGETS=seccomp
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
> 
> Changes since v2:
> -- Using TEST_GEN_PROGS is sufficient to generate objects.
>    Addresses review comments from Kees Cook.
> 
>  tools/testing/selftests/seccomp/Makefile | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/seccomp/Makefile b/tools/testing/selftests/seccomp/Makefile
> index 1760b3e39730..a0388fd2c3f2 100644
> --- a/tools/testing/selftests/seccomp/Makefile
> +++ b/tools/testing/selftests/seccomp/Makefile
> @@ -1,17 +1,15 @@
>  # SPDX-License-Identifier: GPL-2.0
> -all:
> -
> -include ../lib.mk
> +CFLAGS += -Wl,-no-as-needed -Wall
> +LDFLAGS += -lpthread
>  
>  .PHONY: all clean

Isn't this line redundant to ../lib.mk's?

>  
> -BINARIES := seccomp_bpf seccomp_benchmark
> -CFLAGS += -Wl,-no-as-needed -Wall
> +include ../lib.mk
> +
> +# OUTPUT set by lib.mk
> +TEST_GEN_PROGS := $(OUTPUT)/seccomp_bpf $(OUTPUT)/seccomp_benchmark
>  
> -seccomp_bpf: seccomp_bpf.c ../kselftest_harness.h
> -	$(CC) $(CFLAGS) $(LDFLAGS) $< -lpthread -o $@
> +$(TEST_GEN_PROGS): ../kselftest_harness.h
>  
> -TEST_PROGS += $(BINARIES)
> -EXTRA_CLEAN := $(BINARIES)
> +all: $(TEST_GEN_PROGS)

And isn't this one too?

I think if those are removed it should all still work? Regardless:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

>  
> -all: $(BINARIES)
> -- 
> 2.20.1
> 

-- 
Kees Cook
