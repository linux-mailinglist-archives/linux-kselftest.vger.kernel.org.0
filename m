Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3B7B195EA0
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Mar 2020 20:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgC0T2I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Mar 2020 15:28:08 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42487 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbgC0T2I (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Mar 2020 15:28:08 -0400
Received: by mail-pf1-f193.google.com with SMTP id 22so4958103pfa.9
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Mar 2020 12:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ciBC3j8wG4a8pHJA61Krk7wdzxQIPFblhY8Mnmnqr/E=;
        b=dZbWG7+WmyxKjt8o1CFjmawcgYb9EEMCzsYlcILxxPtiGer6uV+HnUYpVcY1RNBFRG
         RjwL4s2vQk6bvP8QSj2WiIANCPx4nfL86AVwKtE/T3vgBWCwO+W6gCzZsM50wBfPNP02
         pVt3JhCwHQK0kEFTi5SLljHXMhHno/WK55SKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ciBC3j8wG4a8pHJA61Krk7wdzxQIPFblhY8Mnmnqr/E=;
        b=VmYF6yBFQOi5LTEGcrRmzaNST6pTFGIJJIH8pIjrNm7W82yrHm6G4C4NcvgBgkMtjg
         LWxdVNte+Wc5IGkJi0Jm6LU0wU6D9ebZ8dNVIjEgY8lpz2rlob7XtwJt2tBmUjGUDBnf
         uk/Q2LtCR0iQxclGSjvgo4He+jgZ90acW4aizvyaQNdX+btYRe7zMDGa86GgAzSQloyW
         ZuhdI7Ve4AEmZnGpjAlUhW5eoVMm91vuEiqjmBRy0w4TJM+10bBqzc3JCXDwP/nYahel
         e8uOrYSR4EzlEbY1tmlYUDg8kypbNd7B4T6RUgnoEZvHF2853uwYIqIItNOEr8+OlpM8
         4npg==
X-Gm-Message-State: ANhLgQ1yd6q3hSBUIBOr3hTpNfmp/1nUxqBn740MoazAceetpMIY/S2z
        imEsZR0Cwabr/wqWwxRKtDRTXQ==
X-Google-Smtp-Source: ADFU+vuchbCxcDuvMI0oXv3NR9kDEcIvh5PdrH4MH/b2GxywfhrWBKPCrJOWYzpn/J65ZJciM9QCVg==
X-Received: by 2002:aa7:9a01:: with SMTP id w1mr759393pfj.256.1585337286979;
        Fri, 27 Mar 2020 12:28:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u21sm4342053pjy.8.2020.03.27.12.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 12:28:06 -0700 (PDT)
Date:   Fri, 27 Mar 2020 12:28:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/runner: avoid using timeout when timeout is
 disabled
Message-ID: <202003271208.0D9A3A48CC@keescook>
References: <20200327093620.GB1223497@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327093620.GB1223497@xps-13>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 27, 2020 at 10:36:20AM +0100, Andrea Righi wrote:
> Avoid using /usr/bin/timeout unnecessarily if timeout is set to 0
> (disabled) in the "settings" file for a specific test.

That seems to be a reasonable optimization, sure.

> NOTE: without this change (and adding timeout=0 in the corresponding
> settings file - tools/testing/selftests/seccomp/settings) the
> seccomp_bpf selftest is always failing with a timeout event during the
> syscall_restart step.

This, however, is worrisome. I think there is something else wrong here.
I will investigate why the output of seccomp_bpf is weird when running
under the runner scripts. Hmmm. The output looks corrupted...

-Kees

> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> ---
>  tools/testing/selftests/kselftest/runner.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
> index e84d901f8567..2cd3c8def0f6 100644
> --- a/tools/testing/selftests/kselftest/runner.sh
> +++ b/tools/testing/selftests/kselftest/runner.sh
> @@ -32,7 +32,7 @@ tap_prefix()
>  tap_timeout()
>  {
>  	# Make sure tests will time out if utility is available.
> -	if [ -x /usr/bin/timeout ] ; then
> +	if [ -x /usr/bin/timeout ] && [ $kselftest_timeout -gt 0 ] ; then
>  		/usr/bin/timeout "$kselftest_timeout" "$1"
>  	else
>  		"$1"
> -- 
> 2.25.1
> 

-- 
Kees Cook
