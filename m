Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2081C195E0E
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Mar 2020 20:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgC0TCa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Mar 2020 15:02:30 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40272 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbgC0TCa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Mar 2020 15:02:30 -0400
Received: by mail-pj1-f66.google.com with SMTP id kx8so4136806pjb.5
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Mar 2020 12:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gLHLJMBxOTqwCxIgz1nbKQaYKpREIN6QpIXiV+9902w=;
        b=YDStaEX6FW0zeNHrPj8m5tYTTJAFB0UA+l8BOnvVb0iWm3a2YpwQubFnKtxYdiX6wc
         rdc2I0NTNRFu9hkGqsPXL+f+i9piCA2FERCHSuuvGJefKvUhJcv9F0NLyIqWr80Ca13l
         opXmkVW4bQ0uyg0kgllCYZ2YxRazlzUna1Sf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gLHLJMBxOTqwCxIgz1nbKQaYKpREIN6QpIXiV+9902w=;
        b=R8zIPBcLUdc+RPo1pC8IDnWooagyhxtNkaumE9BxMZNmjVqe/MlWdeSaBWukLiljA9
         LrUoHco8shMIXd9oOTfr3MJDM4J3ZXKkDNKN9dbXr7tGgQIKg1g0tFfdOfMsLl5TpteG
         Rdm4cZONYKszK4H+8C+4UvnupVezVbEZDDAnzCKlzc8Yq9B6SjqyG/TofBGcixnrr6li
         y/96HWO3hjgLPb1CyqfFeaAtclApEJBqIMKbkKuqDH8NyA6O2kzElUagU3awCyStN+Qf
         XmmQ3qF0nuKhnBQU5z9utOvwJMeAEAyEn9wmhhUmT+g3Cw9BeHZXfjUVPCcG4suvLvyy
         03TA==
X-Gm-Message-State: ANhLgQ3cy5SZM64O0kOTLYzqaiEA0qCscuxXOUimhYlibrxVOLtWW3Tt
        axNFjzYAzWaORMTCEqkdViZv2A==
X-Google-Smtp-Source: ADFU+vvwfXD92DVjRTRsBC244V6nBLBIIAKRK9iqmRYmCFZehEyPmSFv30qn1E9v5K5oldZejZ3zow==
X-Received: by 2002:a17:90a:2307:: with SMTP id f7mr926623pje.152.1585335746985;
        Fri, 27 Mar 2020 12:02:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f15sm4696400pfq.100.2020.03.27.12.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 12:02:26 -0700 (PDT)
Date:   Fri, 27 Mar 2020 12:02:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] selftests/harness: fix spelling mistake "SIGARLM"
 -> "SIGALRM"
Message-ID: <202003271202.123FD50@keescook>
References: <20200327090648.13387-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327090648.13387-1-colin.king@canonical.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 27, 2020 at 09:06:48AM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There a few identical spelling mistakes, fix these.

Argh, thanks Colin!

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  tools/testing/selftests/kselftest_harness.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index 2902f6a78f8a..2bb8c81fc0b4 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -705,7 +705,7 @@ static void __timeout_handler(int sig, siginfo_t *info, void *ucontext)
>  	/* Sanity check handler execution environment. */
>  	if (!t) {
>  		fprintf(TH_LOG_STREAM,
> -			"no active test in SIGARLM handler!?\n");
> +			"no active test in SIGALRM handler!?\n");
>  		abort();
>  	}
>  	if (sig != SIGALRM || sig != info->si_signo) {
> @@ -731,7 +731,7 @@ void __wait_for_test(struct __test_metadata *t)
>  	if (sigaction(SIGALRM, &action, &saved_action)) {
>  		t->passed = 0;
>  		fprintf(TH_LOG_STREAM,
> -			"%s: unable to install SIGARLM handler\n",
> +			"%s: unable to install SIGALRM handler\n",
>  			t->name);
>  		return;
>  	}
> @@ -743,7 +743,7 @@ void __wait_for_test(struct __test_metadata *t)
>  	if (sigaction(SIGALRM, &saved_action, NULL)) {
>  		t->passed = 0;
>  		fprintf(TH_LOG_STREAM,
> -			"%s: unable to uninstall SIGARLM handler\n",
> +			"%s: unable to uninstall SIGALRM handler\n",
>  			t->name);
>  		return;
>  	}
> -- 
> 2.25.1
> 

-- 
Kees Cook
