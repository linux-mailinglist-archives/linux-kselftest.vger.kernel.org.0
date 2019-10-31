Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B603EB462
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2019 16:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfJaP6g (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Oct 2019 11:58:36 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44431 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbfJaP6g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Oct 2019 11:58:36 -0400
Received: by mail-pl1-f194.google.com with SMTP id q16so2876433pll.11
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2019 08:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tNvlzAm3gfpJfZsRGUo9jJZ/vY/4iXl5KVOhYMqSiL0=;
        b=dkwyQgWV/YhS6kyje6q4s/b7juq3J2jbBtklAjsIJF8xpCtIhACAVjICh3nArZupNR
         7SGswhXPc7KcrLJ60dwVJ2JEcnJbjD5damVVMIyz6tzZYf4aP/rQokvvwcoWBk6ZN72/
         cOewys1t51tDbgZBC4unrdSrlxQuEwcjHdyeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tNvlzAm3gfpJfZsRGUo9jJZ/vY/4iXl5KVOhYMqSiL0=;
        b=q7StUIDa9ea1aoymWzaOHDKnAfUUTxh9AhXEj28P9nGwyCWIRCJM1aLnBAOsAeqBuj
         JRimw/M1BOx54Hpjn9XfjQGWCUS8xZWod1ZQLfFGM5BhlA7wZAojy3O9/GdYWQHKyguA
         s1HlzoEwItzj2dzdrdkEZYWGh6VcsOkEGN0viFCK2rCCDo6nkxoSvFN/ejqM9MM2qK4v
         mXuyHLgv2M5na9fMl4tJ0odzzwlEzQanHrv6zftlGPvGxg858IsOhgdf+BIbVInDrfxE
         wPXK3bQ8Ws4pqai2HSOM1p1X6unLKxC6nfUm0rodp3CUJcmJGfQSmK+YPuAQVjJ0tLhE
         Quqw==
X-Gm-Message-State: APjAAAV1yW8P07ELZBMG0Ci2B8JEGp3jkcEF6m4MVQk8F/7K6W2Y4D+3
        sZdohmqb10z6vLApKq2Sv4Nx1g==
X-Google-Smtp-Source: APXvYqxGOzaYTE5AAvD6fBlWwRERuAOtTWtWv6RCE4Jpy4HzOWL7KpK8I23QTwvN/f/gDZ6u5Ie6+g==
X-Received: by 2002:a17:902:6ac8:: with SMTP id i8mr7504691plt.30.1572537515013;
        Thu, 31 Oct 2019 08:58:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j22sm3469799pff.42.2019.10.31.08.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 08:58:34 -0700 (PDT)
Date:   Thu, 31 Oct 2019 08:58:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, jaswinder.singh@linaro.org,
        Jun Takahashi <takahashi.jun_s@aa.socionext.com>
Subject: Re: [BUGFIX PATCH] selftests: breakpoints: Fix a typo of function
 name
Message-ID: <201910310857.81DFF3A6@keescook>
References: <157252457993.20908.6741530756091861014.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157252457993.20908.6741530756091861014.stgit@devnote2>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 31, 2019 at 09:23:00PM +0900, Masami Hiramatsu wrote:
> Since commit 5821ba969511 ("selftests: Add test plan API to kselftest.h
> and adjust callers") accidentally introduced 'a' typo in the front of
> run_test() function, breakpoint_test_arm64.c became not able to be
> compiled.
> 
> Remove the 'a' from arun_test().
> 
> Fixes: 5821ba969511 ("selftests: Add test plan API to kselftest.h and adjust callers")
> Reported-by: Jun Takahashi <takahashi.jun_s@aa.socionext.com>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>

Argh, apologies! Yes, thank you for catching this.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  .../selftests/breakpoints/breakpoint_test_arm64.c  |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c b/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
> index 58ed5eeab709..ad41ea69001b 100644
> --- a/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
> +++ b/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
> @@ -109,7 +109,7 @@ static bool set_watchpoint(pid_t pid, int size, int wp)
>  	return false;
>  }
>  
> -static bool arun_test(int wr_size, int wp_size, int wr, int wp)
> +static bool run_test(int wr_size, int wp_size, int wr, int wp)
>  {
>  	int status;
>  	siginfo_t siginfo;
> 

-- 
Kees Cook
