Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD601FBC00
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jun 2020 18:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730239AbgFPQmL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Jun 2020 12:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729427AbgFPQmK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Jun 2020 12:42:10 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D59C061573
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jun 2020 09:42:10 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e1so21517322wrt.5
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jun 2020 09:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zeIRDbki8eAEIk+7HXowXKMtfqVt+J6tH/sWX1xK3DM=;
        b=JFSc6uG5pmk3/Vr83FZLLOOUFVW5lJtO0nzFRsKhO8JI4hUlwN2CTHoHVRlKGio3NW
         CB8IK304y41nrZf/y717ppqjUIQY1dopLUMdDtbYDw9Wv41lMP3seAlfxmdxme99WSt7
         S3uR+1D3iXjqppFKheQLeV00DkFUbxZFdJoKS6g6CT63kXIwwS++Y4PykU6+jzv/+bPG
         Ba2lAi73WCHjOLwJVajjYGDZ0ehAs7014XwmgB6xfhFOswN5Z2BJQ4+pElwgz1z3tYwr
         s0k7MkKbTdLFkqMf2TvGjBrgvuN6f0Zjtk3tb0nSADee2AC2v6tww20WVJEEEXfpYzJM
         +X3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zeIRDbki8eAEIk+7HXowXKMtfqVt+J6tH/sWX1xK3DM=;
        b=nKRvg71m1B9jNW+Zwis5CmMNqLXFDn1sDM8GMxeZSQovhsVmCCHCPvId0T+fK2vLlK
         U4QZoe23gXmUWzdNXiBmGbFjaZ5jikPj2acEkOlnFTxGeytaH+1ve0IjrO9v+CQGuhVy
         FWrAJdZhXiyaqhoyX5ejYIweUuiUKfqzJv3S0ZWO9h1ZwXY8MrTXdsW2CyGb6W7qVjIg
         WRjkDvUittr455jc9untFz5r1wkdrz5bG9n8sQco1LbZLDxi74RvDenrU1QOi1wyHnJ9
         JBQmrv8TYSLaXkS1OqVM4IbyppXUQwaD9mpauJbSFIg3yxXI0DzbUYV/rNF2Khe7ftRE
         DLvA==
X-Gm-Message-State: AOAM533CvSDbY6iZiQvZFHlmgbWEDdhbH/cnd0V/uK6crByqYbEUQMFc
        kbP8vrl9aMbLpa+o/oRGblmC50DzfJE=
X-Google-Smtp-Source: ABdhPJyTG41jRrlGa2/YUUoJk2nj0unVyz16OOEqPU1c20cxuHIcnqk8fdLm7LrhFd+In7r5PMyAIQ==
X-Received: by 2002:adf:a306:: with SMTP id c6mr3966178wrb.122.1592325728672;
        Tue, 16 Jun 2020 09:42:08 -0700 (PDT)
Received: from google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id t14sm31349034wrb.94.2020.06.16.09.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 09:42:07 -0700 (PDT)
Date:   Tue, 16 Jun 2020 18:42:02 +0200
From:   Marco Elver <elver@google.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, shuah@kernel.org, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] torture: Pass --kmake-arg to all make invocations
Message-ID: <20200616164202.GA208325@google.com>
References: <20200616094924.159539-1-elver@google.com>
 <20200616160524.GW2723@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616160524.GW2723@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.13.2 (2019-12-18)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 16 2020 at 09:05AM -0700, Paul E. McKenney wrote:

> On Tue, Jun 16, 2020 at 11:49:24AM +0200, Marco Elver wrote:
> > We need to pass the arguments provided to --kmake-arg to all make
> > invocations. In particular, the make invocations generating the configs
> > need to see the final make arguments, e.g. if config variables depend on
> > particular variables that are passed to make.
> > 
> > For example, when using '--kcsan --kmake-arg CC=clang-11', we would lose
> > CONFIG_KCSAN=y due to 'make oldconfig' not seeing that we want to use a
> > compiler that supports KCSAN.
> > 
> > Signed-off-by: Marco Elver <elver@google.com>
> 
> Queued and pushed, thank you!
> 
> Would the following patch make sense, at least until such time
> as some other compiler supports KCSAN?
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 88bcaa730b6d40ddf69b09ed6f0a14803d087d99
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Tue Jun 16 09:02:34 2020 -0700
> 
>     torture: Make --kcsan default to using Clang 11
>     
>     Currently, Clang 11 is the only compiler that can support KCSAN.
>     Therefore, as a convenience to the KCSAN user, this commit causes
>     --kcsan to specify Clang 11 unless a "CC=" argument was already
>     specified via the --kmake-arg argument.

As soon as more compilers support KCSAN (e.g. clang-12, etc...) we run
the risk of actually inconveniencing ourselves more because then we
really need to say '--kmake-arg CC=clang-1X' to not use the old
compiler. Or revert this in time.

My command-line looks more like this right now:

	kvm.sh ... --kmake-arg "CC="${HOME}/local/<gcc-or-clang>-11.kcsan/local/bin/<gcc-or-clang>" ...

I think the safer alternative would be to error if CONFIG_KCSAN=y is not
in the config, and simply suggest "Did you forget to switch your
compiler with '--kmake-arg CC=<cc-that-supports-kcsan>'?" (of course, a
'gcc' in $PATH that supports KCSAN would also be fine -- see below).
Eventually, when the default compilers support KCSAN, this will resolve
itself gracefully.

Also, I'm going to send a series later this week to re-enable GCC
support. ;-)

Thanks,
-- Marco
