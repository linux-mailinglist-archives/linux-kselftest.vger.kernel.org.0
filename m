Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABA3519348C
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Mar 2020 00:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgCYX03 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Mar 2020 19:26:29 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:50567 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbgCYX02 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Mar 2020 19:26:28 -0400
Received: by mail-pj1-f67.google.com with SMTP id v13so1700388pjb.0
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Mar 2020 16:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l+rxsfJdm0pMWVSL8Cwqx9YZjRtZV7LirGrxygW1T+I=;
        b=T5Qtp5XYn5CYWlMaK0R8K/DeiEM5Iuo3kdJcttk8CP+O5s3wuwr3dkgYe7hIUWV9ws
         kyoc8AsH+rLWAJmWxIIpL+oFFeBxMCmLOmdwmavFD623LYmjYcNHJybMgOXfzySt0Jrg
         A6HV7GwF+zd6CUsWG9D23gqWul7SMmwQP0UVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l+rxsfJdm0pMWVSL8Cwqx9YZjRtZV7LirGrxygW1T+I=;
        b=rJmKK5YzdCTRdWZErdeJAJ6RTraF1OtuXuJSX1FiHKHIjhCrC6PG/nJRPi9Betxawy
         TGubiUBQMEdXoY/e+1PePtVeRvdGbr+H8sIjTv3hUKXv49aZ4ogU0maSwdS5GJo5xTk/
         DwqY+SZE+ZFERjoOclQ6gM0vRIHlf3C8kqK69JHQrfUPknAi66FplIxLEHhdV0uhtcbk
         bHmFAU+jk/t6R4Pxkp44QKNCEMRWi3twFzVnm+eL2qcOhbWsPB54XcldHMXmo7iFlScV
         uUMVmbogRrYLTxAo6tvcNycEimZNMwsYgcxE21lZfUc78Wl5XPtzBTyEOZIE+3CZ8D+D
         Lf3A==
X-Gm-Message-State: ANhLgQ2nNPK9SybbYzQkAPBnKgalACaTUsJ4QSsqNqJ0XKa7jjbv9X0N
        kuUiV2r8w8kBp89oxZnss7dTeA==
X-Google-Smtp-Source: ADFU+vv6NVn42B5/CmzW/EHGOiTv5qi4qoLdQ4nsxPuo23Svqmn87kpZkw9gctTj5dnpzQY61Savlw==
X-Received: by 2002:a17:902:b198:: with SMTP id s24mr5318549plr.89.1585178787913;
        Wed, 25 Mar 2020 16:26:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d84sm182058pfd.197.2020.03.25.16.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 16:26:26 -0700 (PDT)
Date:   Wed, 25 Mar 2020 16:26:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     luto@amacapital.net, wad@chromium.org, shuah@kernel.org,
        mpe@ellerman.id.au, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] selftests: Fix seccomp to support relocatable build
 (O=objdir)
Message-ID: <202003251626.D47C4B3@keescook>
References: <20200325231602.12964-1-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325231602.12964-1-skhan@linuxfoundation.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 25, 2020 at 05:16:02PM -0600, Shuah Khan wrote:
> Fix seccomp relocatable builds. This is a simple fix to use the
> right lib.mk variable TEST_GEN_PROGS. Local header dependency
> is addressed in a change to lib.mk as a framework change that
> enforces the dependency without requiring changes to individual
> tests.
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

Thanks for getting this fixed. :)

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
> Changes since v3:
> Simplified logic based on comments from Kees and Michael
> 
>  tools/testing/selftests/seccomp/Makefile | 17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/testing/selftests/seccomp/Makefile b/tools/testing/selftests/seccomp/Makefile
> index 1760b3e39730..0ebfe8b0e147 100644
> --- a/tools/testing/selftests/seccomp/Makefile
> +++ b/tools/testing/selftests/seccomp/Makefile
> @@ -1,17 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
> -all:
> -
> -include ../lib.mk
> -
> -.PHONY: all clean
> -
> -BINARIES := seccomp_bpf seccomp_benchmark
>  CFLAGS += -Wl,-no-as-needed -Wall
> +LDFLAGS += -lpthread
>  
> -seccomp_bpf: seccomp_bpf.c ../kselftest_harness.h
> -	$(CC) $(CFLAGS) $(LDFLAGS) $< -lpthread -o $@
> -
> -TEST_PROGS += $(BINARIES)
> -EXTRA_CLEAN := $(BINARIES)
> -
> -all: $(BINARIES)
> +TEST_GEN_PROGS := seccomp_bpf seccomp_benchmark
> +include ../lib.mk
> -- 
> 2.20.1
> 

-- 
Kees Cook
