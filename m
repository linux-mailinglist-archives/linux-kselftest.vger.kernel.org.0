Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D79214AC9
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Jul 2020 09:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgGEHBM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 5 Jul 2020 03:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbgGEHBM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 5 Jul 2020 03:01:12 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CB6C061794
        for <linux-kselftest@vger.kernel.org>; Sun,  5 Jul 2020 00:01:12 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d194so13589124pga.13
        for <linux-kselftest@vger.kernel.org>; Sun, 05 Jul 2020 00:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nTHtSjVLQHeLSy0uqm8S4L9uEdI8s7cHTYuNr/RgjU4=;
        b=ZYUgITlCyYLwvoccNm5Op0BVJOu48KNGbkGelaKJSplcATNZjAyMv4yUD22K4JLAvF
         o2jccECA9kTPkAwq7NQRm0+nLKYroBEYw0LeqKIm8/nf8ZQv4OUdVSrg/qhCpyP71Qtt
         xuHPXc519c8Svisi7KdcUBxlw0dchUydJkCgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nTHtSjVLQHeLSy0uqm8S4L9uEdI8s7cHTYuNr/RgjU4=;
        b=p6vntKNziLG1aHI3ypPtL7WCrqmmEq1/BXnqwrF0buumevGKMoVz2LA4BqL9Mn1uwj
         98gy/UbVjMHGhqKgc2PWeeBUZip4fMY3f/k8DVA6AGAJ2Jxh9oYnEy6PPBreYuV+MhAe
         NiE0I9osQR4q2kMtgXbVm6lGOJFHi2VaYIUghfJgcxhVUP4l2Q4nUk8B/wDlGrLtu1Vy
         9uCXqJdy03p8xuuMZFkxz2r8vC97HJFI498UbL012VEuPjK9FMk8f5Ujz4JArnNjqMNG
         Z6XO/hQlaFKP0pZK9/4ggXP88oCcYMTrzr4rKRUN0viphVD0jsQjtZyI9z2nKsmMOQPB
         LPjQ==
X-Gm-Message-State: AOAM532/wsQXx7oc/hqcmMZLK8gcrrxfRxHoakiBfywVx/s/L61DJzVo
        IUvLDA0RKKaj2L2ZByYG/7YtYA==
X-Google-Smtp-Source: ABdhPJyEd3dqAnjdX5X0B1CLAKee5RybaEyD8kgsnX6V5YlPld+U/ysl/B0SAcaccskQ2/uMT+wjbg==
X-Received: by 2002:a62:7650:: with SMTP id r77mr28964787pfc.235.1593932471622;
        Sun, 05 Jul 2020 00:01:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j16sm15909514pfr.100.2020.07.05.00.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 00:01:10 -0700 (PDT)
Date:   Sun, 5 Jul 2020 00:01:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Oleg Nesterov <oleg@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] selftests/seccomp: Check ENOSYS under tracing
Message-ID: <202007050000.40DCED12@keescook>
References: <20200705061232.4151319-1-keescook@chromium.org>
 <20200705061232.4151319-4-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200705061232.4151319-4-keescook@chromium.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jul 04, 2020 at 11:12:32PM -0700, Kees Cook wrote:
> There should be no difference between -1 and other negative syscalls
> while tracing.
> 
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Will Drewry <wad@chromium.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Keno Fischer <keno@juliacomputing.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 966dec340ea8..bf6aa06c435c 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -1973,6 +1973,32 @@ FIXTURE_TEARDOWN(TRACE_syscall)
>  	teardown_trace_fixture(_metadata, self->tracer);
>  }
>  
> +TEST(negative_ENOSYS)
> +{
> +	/* Untraced negative syscalls should return ENOSYS. */
> +	errno = 0;
> +	EXPECT_EQ(-1, syscall(-1));
> +	EXPECT_EQ(errno, ENOSYS);
> +	errno = 0;
> +	EXPECT_EQ(-1, syscall(-101));
> +	EXPECT_EQ(errno, ENOSYS);
> +}
> +
> +TEST_F(TRACE_syscall, negative_ENOSYS)
> +{
> +	/*
> +	 * There should be no difference between an "internal" skip
> +	 * and userspace asking for syscall "-1".
> +	 */
> +	errno = 0;
> +	EXPECT_EQ(-1, syscall(-1));
> +	EXPECT_EQ(errno, ENOSYS);
> +	/* And no difference for "still not valid but not -1". */
> +	errno = 0;
> +	EXPECT_EQ(-1, syscall(-101));
> +	EXPECT_EQ(errno, ENOSYS);
> +}
> +

I realized after sending this that the second function could just be:

+TEST_F(TRACE_syscall, negative_ENOSYS)
+{
+	negative_ENOSYS(_metadata);
+}

:)

>  TEST_F(TRACE_syscall, syscall_allowed)
>  {
>  	/* getppid works as expected (no changes). */
> -- 
> 2.25.1
> 

-- 
Kees Cook
