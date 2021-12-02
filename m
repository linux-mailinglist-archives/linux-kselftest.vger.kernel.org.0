Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7BAE466B92
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Dec 2021 22:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377079AbhLBVWm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Dec 2021 16:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243039AbhLBVV7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Dec 2021 16:21:59 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6877C06174A
        for <linux-kselftest@vger.kernel.org>; Thu,  2 Dec 2021 13:18:36 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id x7so770410pjn.0
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Dec 2021 13:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EBP/wA0riUq0Ehh4ikwK9vvTmgH1MK1/7+RgvBguglo=;
        b=N2aH43V+EmEkAYBQ4ZU8oiQjZUj0ZtxyuKwGaI0XsO5N0jm3Hds3g9qzxVdaTCCKOg
         DIpXFOI5A3QvIoQ0lLFtzAivfMxNAJaUOv/+59P3nvJtyQybbxuK7mTZM5Xh71yxRzrA
         zhEm0+g0xv1BGJOmyXQv54+vOqV8Jhrx40iVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EBP/wA0riUq0Ehh4ikwK9vvTmgH1MK1/7+RgvBguglo=;
        b=nmAyRL3hBBNtKLO1NLb6Ub/TmVoOY09kt3ARZbhXSKdkBBuz1pIZk1LVLvbMkrA9BY
         UXPTyyJaP4bA9UKJbKewpyb4v4LEA/OBpoOQJ+CEkyFUsBt22z8Gmou4+VbfZgv3GMPM
         SA3yxsD4H8rjInl6Lpdtqvvw/xqyQxIu+MZEzrlyjG4VDBb728byWkB+aEuclKL24iJT
         /Xi4zngAt72Xo5xIECPme++8JsXQTkaUa+PFAmvXBeSHl+w5hxG2wDu0GrTqFrjDqVhR
         JCvCir617YPPbhOUv2nWfKCbfa2kl8Lmxjqhl9NT+sNKiJC0ONboUFwziLyBdWbY+Ih9
         JCdA==
X-Gm-Message-State: AOAM530pETMVVAi3T1ZaZSeo01jaKf6obzt3t0e2DvXbw4CNpoxZCQNi
        JpD09Iy3QxpfBHiolt65t+OX9Q==
X-Google-Smtp-Source: ABdhPJy/eTiQgIc3gFRh0X9gTiqG+h8JNywQwRwj9tzI/4pP6ptAyEFgnqcH7Bd2XKPJ9nIag3LPcg==
X-Received: by 2002:a17:90b:4a89:: with SMTP id lp9mr8971160pjb.6.1638479916404;
        Thu, 02 Dec 2021 13:18:36 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o1sm3274138pjs.30.2021.12.02.13.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 13:18:36 -0800 (PST)
Date:   Thu, 2 Dec 2021 13:18:35 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        sjpark@amazon.de, shuah@kernel.org
Subject: Re: [PATCH] selftests/kselftest/runner.sh: Add optional command
 parameters in settings
Message-ID: <202112021310.E1B3208@keescook>
References: <20211202142056.17386-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202142056.17386-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 02, 2021 at 02:20:56PM +0000, Cristian Marussi wrote:
> Some testcases allow for optional commandline parameters but as of now
> there is now way to provide such arguments to the runner script.
> 
> Add support to the per-test-directory "settings" file to provide such
> optional arguments; two new optional fields can now be defined in
> "settings":
> 
>  - args="<options>": general arguments common to all testcase commands in
>    the test directory
> 
>  - <BASENAME_TEST>_args="<options>": custom arguments specific to only one
>    specific testcase command
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> Used to configure the use of a specific rtc device on CI systems with:
>  tools/testing/selftests/rtc/settings:
>    timeout=90
>    rtctest_args="/dev/rtc1"

I like this idea generally, but I have some concern that this is
muddling the test's settings ("do not expect me to finish before
timeout=90") vs the local system's settings ("here is where to find the
rtc to test"). I can't, however, think of a better way to handle this
currently. :P

Is this case common enough that a given test shouldn't, instead, just
take config from environment variables set by the CI?

(Also, will we need to worry in the future about running the same test
multiple times with different system settings? ("try each of these /dev
nodes...")

Is there a patch for the changes to the RTC test?

> ---
>  tools/testing/selftests/kselftest/runner.sh | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
> index a9ba782d8ca0..f877a8571927 100644
> --- a/tools/testing/selftests/kselftest/runner.sh
> +++ b/tools/testing/selftests/kselftest/runner.sh
> @@ -49,6 +49,15 @@ run_one()
>  
>  	# Reset any "settings"-file variables.
>  	export kselftest_timeout="$kselftest_default_timeout"
> +
> +	# Optional arguments for any command, possibly defined in settings
> +	# as args="<options>"
> +	kselftest_args=""
> +
> +	# Optional arguments for this command, possibly defined in settings
> +	# as <$BASENAME_TEST>_args="<options>"
> +	kselftest_cmd_args_ref="kselftest_${BASENAME_TEST}_args"
> +
>  	# Load per-test-directory kselftest "settings" file.
>  	settings="$BASE_DIR/$DIR/settings"
>  	if [ -r "$settings" ] ; then
> @@ -69,7 +78,8 @@ run_one()
>  		echo "# Warning: file $TEST is missing!"
>  		echo "not ok $test_num $TEST_HDR_MSG"
>  	else
> -		cmd="./$BASENAME_TEST"
> +		eval kselftest_cmd_args="\$$kselftest_cmd_args_ref"

nitpit: Just to avoid tripping any future work to gracefully handle
unset variables, maybe this could specify an empty-string default:

		eval kselftest_cmd_args="\${$kselftest_cmd_args_ref:-}"

> +		cmd="./$BASENAME_TEST $kselftest_cmd_args $kselftest_args"
>  		if [ ! -x "$TEST" ]; then
>  			echo "# Warning: file $TEST is not executable"
>  
> -- 
> 2.17.1
> 

-- 
Kees Cook
