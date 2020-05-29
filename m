Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5841E75A5
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 May 2020 07:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbgE2FwW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 May 2020 01:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgE2FwW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 May 2020 01:52:22 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0188FC08C5C8
        for <linux-kselftest@vger.kernel.org>; Thu, 28 May 2020 22:52:21 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id y198so743725pfb.4
        for <linux-kselftest@vger.kernel.org>; Thu, 28 May 2020 22:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h4tm8V5uFxYnwzK9siWKmg26ctSppcNlyJSzTpDlWPk=;
        b=bD+ngeexaCAMKJhxvK7o0CjvhGq7KEg3PaSxi2NnHCgyyrZBU/EkhY+2v9hIDDWXPq
         tUMvw6QupCHQHW1wOQ0O1A+NvFGVK+mNH7bqcrIsUaO1sWgw+aDgFIgwrF1a/cp5xMCw
         lTLCR4MdqA2kOuwZIZmm5cwIWlA3UzyiCZi6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h4tm8V5uFxYnwzK9siWKmg26ctSppcNlyJSzTpDlWPk=;
        b=p+zvF018Pu3BagOginFdzCv3+NApBCyz7BhAOC9Kr2S0KCsYYNIKrK/TqdUZ6cA2gi
         1TG9FvQV7I0f7wPpNmIqZAArNI56FT/afTCkTsHSoxwUvcimZoaeBnOTpxgsG1cgNdDK
         hE4u7SKBJJCCM1I4L8sqszUbp2YF9CcYNnVNwVm2TPQ2SJbiN0tE/ZM3z+okv0raDjNq
         ffCg//Rg60Wz4yAYo4dRWHuemNptVdzJms3mMmijjC4DM3a1clFxcfbPCBHc/ELQWTme
         rIkTeZD0CbQUrLBuvTQG5Ddvmrg039+d2WU2e4RwpKVS9DnrfYpVTcmGdTZf1x7gzDOz
         sMvQ==
X-Gm-Message-State: AOAM532EmCOogiK9Mzu7/2nFBFqe9WPe8U+jolsTaB7p3yDcZ9Jk0IuM
        gJvp86YNZ7dbBRqkQAECf668Ig==
X-Google-Smtp-Source: ABdhPJy1PDGtyg4/nT4CXLd09BR+6f0Jy08cCbgw5PBgkzaekl0QgUkn2QMqBAAyuLWjecVAxGYaSw==
X-Received: by 2002:a63:7016:: with SMTP id l22mr6579160pgc.284.1590731540555;
        Thu, 28 May 2020 22:52:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u4sm9887974pjf.3.2020.05.28.22.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 22:52:19 -0700 (PDT)
Date:   Thu, 28 May 2020 22:52:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Subject: Re: [PATCH 2/4] lib: Make test_sysctl initialized as module
Message-ID: <202005282250.5E37391@keescook>
References: <159067751438.229397.6746886115540895104.stgit@devnote2>
 <159067753624.229397.13771427935697541820.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159067753624.229397.13771427935697541820.stgit@devnote2>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 28, 2020 at 11:52:16PM +0900, Masami Hiramatsu wrote:
> test_sysctl.c is expected to be used as a module, but since
> it does not use module_init(), it never be registered as
> a module and not appeared under /sys/module/.
> In the result, the selftests/sysctl/sysctl.sh always fails
> to find the test module and is skipped.
> 
> This makes test_sysctl.c initialized as a module by module_init()
> and allow sysctl.sh to find the test module is loaded.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  lib/test_sysctl.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/test_sysctl.c b/lib/test_sysctl.c
> index 566dad3f4196..ec4d0f03475d 100644
> --- a/lib/test_sysctl.c
> +++ b/lib/test_sysctl.c
> @@ -149,7 +149,7 @@ static int __init test_sysctl_init(void)
>  	}
>  	return 0;
>  }
> -late_initcall(test_sysctl_init);
> +module_init(test_sysctl_init);

This is the only part I think we need to double check. As a non-module,
module_init() becomes device_initcall() not late_initcall().

I don't see any notes in the commit log for the original driver that
mention why this needs to be late_initcall(), though, so I *think* it's
safe. Luis?

-- 
Kees Cook
