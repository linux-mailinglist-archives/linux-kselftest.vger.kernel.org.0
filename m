Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887504566A2
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Nov 2021 00:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbhKRX5F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Nov 2021 18:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbhKRX5F (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Nov 2021 18:57:05 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB67C06174A
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Nov 2021 15:54:04 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso9647445pji.0
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Nov 2021 15:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZwKIUkuJyjkmpEJDiI3rT9nP/nucv2Qu5EAF8Rqqq1Y=;
        b=OW9EyW0SubYptcTcH8YTlAZhwhx7VV+j/MXj1IWjlOW5gggelRVD5LRYztbJILHNzm
         wt1K6z1RA63WRiXeqZSKgAHpP7qh+wtt71uzl7NwsCIaYoR7q+16LGjjH6c9g6z98vTz
         O4QWbC3INNPqKnKpRMY8bxzIfCJAGs0v+kymg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZwKIUkuJyjkmpEJDiI3rT9nP/nucv2Qu5EAF8Rqqq1Y=;
        b=BCyFSfbVTM9jhaotQFPtoACQbY+uub6IAj//6A/rKivbRZ63LSG4donOr9Dp+RhIx1
         3044ANhlkQGR8HyMz930XmCuU+r33c6/M+piQt+84/aW8yJlw89lmlH6gyb2X5csNM9f
         3UG81k9pG1o1bXvs8jvK28Jss2qeZhJaMdDLsmc8CbrAvlri2hlzl3DKulOViaQcKUdJ
         C1OS9Z68sBGqb4h9CYv0ZedZzvxNWTe1rfnKAyIvYg6dRD7kyyyGaiQRERpMm9VqwSyb
         ZM4dlRBeCMV8IUHj6Dr73dbSLTqzkmGuigbbqt1HoDO1f3a+EMm2K3AkTrjdpIRE50Rf
         GA1w==
X-Gm-Message-State: AOAM530bLI26+ALwYyuGVbs1xh+oXbEOxUcjVdHysdz7MfnMA/8CPOsd
        0W6OfKFFUQq/hHdhLR5x55ur1g==
X-Google-Smtp-Source: ABdhPJw1GONVXR9tdAKLV4BSBsXTfKktrcP8bxkeM65wyKeGr7Hy1J63j+5TgFCl+lgpqdq8i4nL+Q==
X-Received: by 2002:a17:903:18b:b0:142:12ba:8513 with SMTP id z11-20020a170903018b00b0014212ba8513mr69977904plg.69.1637279643706;
        Thu, 18 Nov 2021 15:54:03 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mg17sm602086pjb.17.2021.11.18.15.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 15:54:03 -0800 (PST)
Date:   Thu, 18 Nov 2021 15:54:02 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, Kyle Huey <me@kylehuey.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Righi <andrea.righi@canonical.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Robert O'Callahan <rocallahan@gmail.com>,
        Oliver Sang <oliver.sang@intel.com>, lkp@lists.01.org,
        lkp@intel.com
Subject: Re: [PATCH 1/2] signal: Don't always set SA_IMMUTABLE for forced
 signals
Message-ID: <202111181553.A4FDEB1@keescook>
References: <CAP045AqjHRL=bcZeQ-O+-Yh4nS93VEW7Mu-eE2GROjhKOa-VxA@mail.gmail.com>
 <87k0h6334w.fsf@email.froward.int.ebiederm.org>
 <202111171341.41053845C3@keescook>
 <CAHk-=wgkOGmkTu18hJQaJ4mk8hGZc16=gzGMgGGOd=uwpXsdyw@mail.gmail.com>
 <CAP045ApYXxhiAfmn=fQM7_hD58T-yx724ctWFHO4UAWCD+QapQ@mail.gmail.com>
 <CAHk-=wiCRbSvUi_TnQkokLeM==_+Tow0GsQXnV3UYwhsxirPwg@mail.gmail.com>
 <CAP045AoqssLTKOqse1t1DG1HgK9h+goG8C3sqgOyOV3Wwq+LDA@mail.gmail.com>
 <202111171728.D85A4E2571@keescook>
 <87h7c9qg7p.fsf_-_@email.froward.int.ebiederm.org>
 <877dd5qfw5.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dd5qfw5.fsf_-_@email.froward.int.ebiederm.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 18, 2021 at 04:04:58PM -0600, Eric W. Biederman wrote:
> 
> Recently to prevent issues with SECCOMP_RET_KILL and similar signals
> being changed before they are delivered SA_IMMUTABLE was added.
> 
> Unfortunately this broke debuggers[1][2] which reasonably expect to be
> able to trap synchronous SIGTRAP and SIGSEGV even when the target
> process is not configured to handle those signals.
> 
> Update force_sig_to_task to support both the case when we can
> allow the debugger to intercept and possibly ignore the
> signal and the case when it is not safe to let userspace
> known about the signal until the process has exited.
> 
> Reported-by: Kyle Huey <me@kylehuey.com>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Cc: stable@vger.kernel.org
> [1] https://lkml.kernel.org/r/CAP045AoMY4xf8aC_4QU_-j7obuEPYgTcnQQP3Yxk=2X90jtpjw@mail.gmail.com
> [2] https://lkml.kernel.org/r/20211117150258.GB5403@xsang-OptiPlex-902
> Fixes: 00b06da29cf9 ("signal: Add SA_IMMUTABLE to ensure forced siganls do not get changed")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  kernel/signal.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 7c4b7ae714d4..02058c983bd6 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1298,6 +1298,12 @@ int do_send_sig_info(int sig, struct kernel_siginfo *info, struct task_struct *p
>  	return ret;
>  }
>  
> +enum sig_handler {
> +	HANDLER_CURRENT, /* If reachable use the current handler */
> +	HANDLER_SIG_DFL, /* Always use SIG_DFL handler semantics */
> +	HANDLER_EXIT,	 /* Only visible as the proces exit code */

Oh, I just noticed this typo "proces" -> "process"

-Kees

-- 
Kees Cook
