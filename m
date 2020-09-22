Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C33D274959
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Sep 2020 21:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgIVTm5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Sep 2020 15:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgIVTm4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Sep 2020 15:42:56 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31035C0613D0
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Sep 2020 12:42:56 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id b17so1949456pji.1
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Sep 2020 12:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wB/qFGX8XmUfzK3oLzWiQkcCJXYRsY2hOuK2J4pGYAs=;
        b=BPMhh/Zk+TUlwxLYJZnIuyj0f2ZjUzOBRbWK1gmW1aAPuT8Cox5zM0YHm9a0FVGkvI
         vjS+ge8M80UdbQ7UquirMgiOjKwk6UJEl/J8b6yMCt+sMaXIvXNyc0HmcqWf64SDxZ+x
         as/KaEKOj2M7zkPC1OKfh6zQ7XCH6xGX+QRjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wB/qFGX8XmUfzK3oLzWiQkcCJXYRsY2hOuK2J4pGYAs=;
        b=ZBXAbi3/wAn5qGqifAii1+Pn9jUFf2DEgFlGLeIpxS6hbfEU3v5rV9Dl6gRvxfOxI8
         jMrgpX+ocrmKsEoDFkC57MWrlLdHrt6XiPm2WfAuFn4gZhHR7nmAprEfkEwXuuMYpz3L
         aq7w758edEVKGIJMrtfJnCmNdi/vOthpDy5GgdZAa3ldPG/KsL8m3dECe9uQWgNWxRC6
         U6wvKL/YFjaSltmbVNDWCU+E0vrWVZmZXO01tUA+le68zEI+IXkf8t6blEziJNI+BjiD
         ICd5CVoZVH0HK+NNlUgMKQ+0Jy14eWF7InD8jAeYK6yb9O3EhZccnzYdvdqgksivl1fg
         A24A==
X-Gm-Message-State: AOAM533qpAG1ZEAMqHs9PUOmqXUGzupTEAmLWqw0MCka6cbYfsCmNwHK
        a0DvWXCRX5UaMfDmw1OJtEXKUg==
X-Google-Smtp-Source: ABdhPJynNbhn29ibaTycTpo0RdBeBG1zmS/+2YHnU7F0Vl/kXjKUpmpslU3uRPVj7QCDYedjKQy0zg==
X-Received: by 2002:a17:90a:e384:: with SMTP id b4mr4941921pjz.46.1600803775725;
        Tue, 22 Sep 2020 12:42:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s24sm14717204pgv.55.2020.09.22.12.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 12:42:54 -0700 (PDT)
Date:   Tue, 22 Sep 2020 12:42:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>, luto@kernel.org,
        tglx@linutronix.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, willy@infradead.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v6 1/9] kernel: Support TIF_SYSCALL_INTERCEPT flag
Message-ID: <202009221241.4C36E4EB@keescook>
References: <20200904203147.2908430-1-krisman@collabora.com>
 <20200904203147.2908430-2-krisman@collabora.com>
 <20200907101608.ldfhhvcy3vmrkg6b@wittgenstein>
 <87wo14n9ru.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wo14n9ru.fsf@collabora.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 08, 2020 at 12:59:49AM -0400, Gabriel Krisman Bertazi wrote:
> Christian Brauner <christian.brauner@ubuntu.com> writes:
> 
> > On Fri, Sep 04, 2020 at 04:31:39PM -0400, Gabriel Krisman Bertazi wrote:
> >> index afe01e232935..3511c98a7849 100644
> >> --- a/include/linux/sched.h
> >> +++ b/include/linux/sched.h
> >> @@ -959,7 +959,11 @@ struct task_struct {
> >>  	kuid_t				loginuid;
> >>  	unsigned int			sessionid;
> >>  #endif
> >> -	struct seccomp			seccomp;
> >> +
> >> +	struct {
> >> +		unsigned int			syscall_intercept;
> >> +		struct seccomp			seccomp;
> >> +	};
> >
> > If there's no specific reason to do this I'd not wrap this in an
> > anonymous struct. It doesn't really buy anything and there doesn't seem
> > to be  precedent in struct task_struct right now. Also, if this somehow
> > adds padding it seems you might end up increasing the size of struct
> > task_struct more than necessary by accident? (I might be wrong
> > though.)
> 
> Hi Christian,
> 
> Thanks for your review on this and on the other patches of this series.
> 
> I wrapped these to prevent struct layout randomization from separating
> the flags field from seccomp, as they are going to be used together and
> I was trying to reduce overhead to seccomp entry due to two cache misses
> when reading this structure.  Measuring it seccomp_benchmark didn't show
> any difference with the unwrapped version, so perhaps it was a bit of
> premature optimization?

That should not be a thing to think about here. Structure randomization
already has a mode to protect against cache line issues. I would leave
this as just a new member; no wrapping struct.

-- 
Kees Cook
