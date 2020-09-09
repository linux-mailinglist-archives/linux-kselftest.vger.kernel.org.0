Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1AC2636DB
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Sep 2020 21:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbgIITtR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Sep 2020 15:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbgIITtM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Sep 2020 15:49:12 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED85C061755
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Sep 2020 12:49:11 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t7so1857683pjd.3
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Sep 2020 12:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oqhYmx0NFZNOAJE/eiypbxplY3MuONMIE6qhP6ssddY=;
        b=H0bHFQ3ASMEAVTRUPtHvl7e6oC+0uJShA88H73hKX19wZcyGfPYU3ObDK/Y4120mWt
         ybQL2m65jouKpt/NlMoDXLYE1qWA7pxMuoi0ztnpQ3V6o5/yX8ZXd/2s7TV3MF3ANKJX
         vFku7hYNnUG2uqMyhPP+wCL+4OMsefFwdXQmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oqhYmx0NFZNOAJE/eiypbxplY3MuONMIE6qhP6ssddY=;
        b=PECfFglZg2fKY5LrC4b6B2KuLZye+XhCHT9zPJUS0H4VeKtGuzmLd0m19fPOtVVa6r
         EHxhdLrSY23Ilc1YF3+X3epgXE4MVkkfv0wAHT8wZ0Ta54/fmXBt0BQmacW9JF9oWMWk
         WlBcIzsVjQ6pwVJO+KdvrmdWypSxwrCj6YCFuMisFfvU3rO72W2J3SEdt6P0XUbYsf/z
         wTh2RnDbkHLgN+kLusM5fdiOmnad4yIBFEBRpZ4ksMoQKmakMEZcjvNBY54/VNil8OTz
         IHHtzCG79cr7GKQRLFaZOZOU5z8Wo9pirXUE6lQHKfVC7Y6KgQ46kzboXfxYg0/lmeXx
         ZTOw==
X-Gm-Message-State: AOAM531rFmQY1b8SSnTEY74waKBD2wCFdLEi5u68L5hvMMOc2wGxKOI5
        ypiYfkJ8JqUMckZobZmkQggGYQ==
X-Google-Smtp-Source: ABdhPJxU9aNjxN137DFaJhJ9P+8qFGxNKraARUvOOUlchRyN5dF2XrloEu5kn+x5DFLgaSun59zKsA==
X-Received: by 2002:a17:90a:c83:: with SMTP id v3mr2067243pja.229.1599680951499;
        Wed, 09 Sep 2020 12:49:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f19sm3231001pfj.25.2020.09.09.12.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 12:49:10 -0700 (PDT)
Date:   Wed, 9 Sep 2020 12:49:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/lkdtm: Use "comm" instead of "diff" for dmesg
Message-ID: <202009091247.C10CDA60C@keescook>
References: <202006261358.3E8AA623A9@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006261358.3E8AA623A9@keescook>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On Fri, Jun 26, 2020 at 01:59:43PM -0700, Kees Cook wrote:
> Instead of full GNU diff (which smaller boot environments may not have),
> use "comm" which is more available.
> 
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Link: https://lore.kernel.org/lkml/CA+G9fYtHP+Gg+BrR_GkBMxu2oOi-_e9pATtpb6TVRswv1G1r1Q@mail.gmail.com
> Fixes: f131d9edc29d ("selftests/lkdtm: Don't clear dmesg when running tests")
> Signed-off-by: Kees Cook <keescook@chromium.org>

Shuah, this really needs to land to fix lkdtm tests on busybox. Can
you add this to -next? (Or is it better to direct this to Greg for the
lkdtm tree?)

Thanks!

-Kees

> ---
>  tools/testing/selftests/lkdtm/run.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/lkdtm/run.sh b/tools/testing/selftests/lkdtm/run.sh
> index 8383eb89d88a..5fe23009ae13 100755
> --- a/tools/testing/selftests/lkdtm/run.sh
> +++ b/tools/testing/selftests/lkdtm/run.sh
> @@ -82,7 +82,7 @@ dmesg > "$DMESG"
>  ($SHELL -c 'cat <(echo '"$test"') >'"$TRIGGER" 2>/dev/null) || true
>  
>  # Record and dump the results
> -dmesg | diff --changed-group-format='%>' --unchanged-group-format='' "$DMESG" - > "$LOG" || true
> +dmesg | comm -13 "$DMESG" - > "$LOG" || true
>  
>  cat "$LOG"
>  # Check for expected output
> -- 
> 2.25.1
> 
> 
> -- 
> Kees Cook

-- 
Kees Cook
