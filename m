Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E320C3FA403
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Aug 2021 08:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbhH1Gai (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 28 Aug 2021 02:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbhH1Gai (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 28 Aug 2021 02:30:38 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D66FC061796
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Aug 2021 23:29:48 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id mw10-20020a17090b4d0a00b0017b59213831so10473209pjb.0
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Aug 2021 23:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kl4oyWPglVRUj2XZDB55NaYF6bwSVxszOpVOFsdxEz8=;
        b=YBbcqVWb/Pb5iJPeInUfgC8ehc+vcyde91b3ruRdnSMIuwbS6t4MTsI6OeyoC++B2b
         gL0fiz87+MBXxxPd9yZuhgbEhYLBHTMobH/HQQhrPJoLObWa/RuLW2tJ4lDX/T3PUPje
         KxF8DAcCfg8XLGnOjxNjfi/D1VXJBEHJ99FVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kl4oyWPglVRUj2XZDB55NaYF6bwSVxszOpVOFsdxEz8=;
        b=sJIVfp+emNX5PyOxSVXWLjdppDVEMaknES8iwOnQ98aN8Ym1x7ZprE4CCpTuEd22B+
         DVsuTg8Dwv+4tB2snoUX2FAnU09e59KTtlneeBFzl91AI92h/IZ6w3v0kDoB+HQidKuu
         8E8bo4stlzUXont6tRZGCuXjPqs3NmvAAi+Qw0O/3kcH5T5XQEQ5o6TGYEX/gDq9G4SE
         XAf6lEDsnr7B8k4PjhgGofAbcaPS34fpVgWNcupEs7dk4wrIFB2WO5363H/Hgddhwkc2
         gi2Hrt9aeiPf1E4nuD1dE8PI7BSXHgGr9yyWJZMFXOJE+wqiVKXBCer+Ci4NZjGmhp+9
         EiMQ==
X-Gm-Message-State: AOAM5329uQuCVxr4Po4Io1/94UvfPQ/eKjxXtfFS8XVInHnM4qB7Xeye
        9nwyMBalH1ELmCCSpHcpB41Nng==
X-Google-Smtp-Source: ABdhPJxx0/QeZcIdxX3mPlRM/oa4o6+SmgT0s/ayJFtgGXtkDG8GbEKCyH+E7UDLWeLKFZo6BxzlTQ==
X-Received: by 2002:a17:902:6b8a:b029:12d:3f99:9e5e with SMTP id p10-20020a1709026b8ab029012d3f999e5emr12265690plk.66.1630132187761;
        Fri, 27 Aug 2021 23:29:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h20sm8379175pfn.173.2021.08.27.23.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 23:29:47 -0700 (PDT)
Date:   Fri, 27 Aug 2021 23:29:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rae Moar <rmoar@google.com>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        dlatypov@google.com, shuah@kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Revert "selftests: Remove KSFT_TAP_LEVEL"
Message-ID: <202108272326.3E57729532@keescook>
References: <20210827225812.3247919-1-rmoar@google.com>
 <20210827225812.3247919-3-rmoar@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827225812.3247919-3-rmoar@google.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 27, 2021 at 10:58:12PM +0000, Rae Moar wrote:
> This reverts commit f41c322f17ec4aa809222dc352439d80862c175b:
> https://lore.kernel.org/linux-kselftest/20190424231236.aWGsEs-_2b6p3DpN3b_4U1xGERmHSv45uBzgjf6RIRk@z/
> 
> This patch removes nested TAP headers in kselftets TAP results and is part
> of a series to alter the format of kselftest TAP results to improve
> compatibility with proposed KTAP specification
> (https://lore.kernel.org/linux-kselftest/CA+GJov6tdjvY9x12JsJT14qn6c7NViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com/).

That would have been nice to have been CCed on. :)

-Kees

> 
> Signed-off-by: Rae Moar <rmoar@google.com>
> Change-Id: I24e74cacfc49a90a068eb30ee1448c097de5297d
> ---
>  tools/testing/selftests/Makefile            | 6 ++++++
>  tools/testing/selftests/kselftest/runner.sh | 1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index fb010a35d61a..3bbfb83e2252 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -122,6 +122,12 @@ else
>  	endif
>  endif
>  
> +# KSFT_TAP_LEVEL is used from KSFT framework to prevent nested TAP header
> +# printing from tests. Applicable to run_tests case where run_tests adds
> +# TAP header prior running tests and when a test program invokes another
> +# with system() call. Export it here to cover override RUN_TESTS defines.
> +export KSFT_TAP_LEVEL=`echo 1`
> +
>  # Prepare for headers install
>  top_srcdir ?= ../../..
>  include $(top_srcdir)/scripts/subarch.include
> diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
> index 9b04aeb26d3a..40ce901cb38d 100644
> --- a/tools/testing/selftests/kselftest/runner.sh
> +++ b/tools/testing/selftests/kselftest/runner.sh
> @@ -2,6 +2,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  #
>  # Runs a set of tests in a given subdirectory.
> +export KSFT_TAP_LEVEL=1
>  export skip_rc=4
>  export timeout_rc=124
>  export logfile=/dev/stdout
> -- 
> 2.33.0.259.gc128427fd7-goog
> 

-- 
Kees Cook
