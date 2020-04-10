Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09BA31A4B2D
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Apr 2020 22:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgDJUdY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Apr 2020 16:33:24 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37021 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgDJUdY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Apr 2020 16:33:24 -0400
Received: by mail-pg1-f194.google.com with SMTP id r4so1433986pgg.4
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Apr 2020 13:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3VeSa8pV4LRZev++4MmnF0GN7JR51rFLh2o6ZJifmAs=;
        b=jrzlTQ4zdnZt7yMEIDuwDMWO3hz3GVEpyJPo5quceb4/5aZLT5RQmyhbVKwifjEEUG
         hURrfWz3QIOt/M/ZYhkHMhC6hKM11ZkN4eNEJM+OnVnsoZKW6aWbFSXinKOjgS1VdfLc
         XzE74MI0cKHp4GYbHA/Z7kI+HejX/8cS+hYqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3VeSa8pV4LRZev++4MmnF0GN7JR51rFLh2o6ZJifmAs=;
        b=rXGg82qZVcT+YyNrdc7guPqVRcaJ3M2EuV41GhuzVOJvba0q1dpdhzAQCfemDug+/q
         LHMCCvMFE1IijitY1hYoDJ0+EYA8i/qeYmtewAP4y/Amwu20b7QnbT4nIsk3+l+nP6Cb
         Sa1wC483Z16flfxjgBZ+79yqxtCt3+r6Cu+3H07HZLwQIQZKlqC/FDXtqiZwev0crs2k
         ltrHZzyOyCCFcxvL/BzZ9DmM7PpF8Mvsv4rY9ujN7VVqXD1dQiO9RKMfKN2Sa1oAtCMj
         L+BdayChE5u7KGMVBHQf3HYML1kmC2LZJi33Y5gaRwoZ8+JJOtszhxsGBqBBwl3CEeAq
         WZww==
X-Gm-Message-State: AGi0PuY2sMrnyo6uZbZWg5XSBdue5XFFPS4IAa3Q3zXK6maLGeK57aLP
        kCov6vr9WZoGEyeQ66I7bz37KnmIy7Y=
X-Google-Smtp-Source: APiQypKwWhdj3p5I+4a9Tpd3IaQXmZGUjW4MMH2e1m01FpwA4MOY4JVpvA3oJd2g521/IWyAeRdhzA==
X-Received: by 2002:a63:cd03:: with SMTP id i3mr5827120pgg.395.1586550801789;
        Fri, 10 Apr 2020 13:33:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c15sm2214815pgk.66.2020.04.10.13.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 13:33:20 -0700 (PDT)
Date:   Fri, 10 Apr 2020 13:33:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/runner: allow to properly deliver signals to
 tests
Message-ID: <202004101330.1E1963B5C2@keescook>
References: <20200410100259.GA457752@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410100259.GA457752@xps-13>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 10, 2020 at 12:02:59PM +0200, Andrea Righi wrote:
> While running seccomp_bpf, kill_after_ptrace() gets stuck if we run it
> via /usr/bin/timeout (that is the default), until the timeout expires.
> 
> This is because /usr/bin/timeout is preventing to properly deliver
> signals to ptrace'd children (SIGSYS in this case).
> 
> This problem can be easily reproduced by running:
> 
>  $ sudo make TARGETS=seccomp kselftest
>  ...
> 
>  # [ RUN      ] TRACE_syscall.skip_a#
>  not ok 1 selftests: seccomp: seccomp_bpf # TIMEOUT
> 
> The test is hanging at this point until the timeout expires and then it
> reports the timeout error.
> 
> Prevent this problem by passing --foreground to /usr/bin/timeout,
> allowing to properly deliver signals to children processes.

Interesting! This seems a poor behavior on "timeout"'s part. Is it
setting a signal mask? Hmpf. Thanks for tracking this down!  This seems
like the best solution now, so:

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> 
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> ---
>  tools/testing/selftests/kselftest/runner.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
> index e84d901f8567..676b3a8b114d 100644
> --- a/tools/testing/selftests/kselftest/runner.sh
> +++ b/tools/testing/selftests/kselftest/runner.sh
> @@ -33,7 +33,7 @@ tap_timeout()
>  {
>  	# Make sure tests will time out if utility is available.
>  	if [ -x /usr/bin/timeout ] ; then
> -		/usr/bin/timeout "$kselftest_timeout" "$1"
> +		/usr/bin/timeout --foreground "$kselftest_timeout" "$1"
>  	else
>  		"$1"
>  	fi
> -- 
> 2.25.1
> 

-- 
Kees Cook
