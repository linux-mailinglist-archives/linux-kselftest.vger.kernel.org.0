Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B868E454D9F
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Nov 2021 20:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240324AbhKQTJH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Nov 2021 14:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239293AbhKQTJH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Nov 2021 14:09:07 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8180BC061570
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Nov 2021 11:06:08 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id b15so15648610edd.7
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Nov 2021 11:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6F06jbeyt9mOtQ/ejGOdNSiaeOgainiDjsIp/GYxA8k=;
        b=Gbvyge049vFVIpoykKRpTf08urXrlJlaXoMyMCZAPDYfeFcVS6KIJKOKWEPRHtT8Gc
         pYdbbmJq98pqqk3639W6LrIb7iZ5bCQ3ybAeoYT1+zY6EnzIU5IJRlC1O/ZJdDSWlebe
         Hs8sVftP80dj2Wse/RxMYNv20bC/un1qSZ4to9bt1+q8GFuq8MnGnC7aPtUIHO6uu+4j
         twY1VhWYCnhP6JXqCI0VSKlS7I+Nc7CLzHJO2MWHevisbz0UAagNXGScIVdY4Zzr4h1i
         OJvaVh1b2hYbFzwIo4TJyLmGrQNaCD1nKQh4urU/Y90yIZdR3f3/MMX/XHJT8Egt1/yj
         YOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6F06jbeyt9mOtQ/ejGOdNSiaeOgainiDjsIp/GYxA8k=;
        b=hvh5DNhkXPKypXOlJpMRcPN3W8QGR2UGVEWu6XIXaJ0eDrxQk/GYPN6u9eljvxf63V
         L2BysNo6hdmuXcl+PoankcVesj1uLl3K4aPvphh6iRVC2cE8MIXyg3BFd9I2dCza7rs4
         kNVOgISDjf00QZeetANNsi51SeACVZPGTekaH+w6/Vl6J9SvDjxWZwiAXJepl8i9qVfq
         4Gah9aTm8UyhUntui0REsc1H56aNU3yUf2L6nhPwJrPsJKlYksYvSBr6tj8WRyka0iAW
         +kJhx+H8119N12vLSWBeQxnlPYwsP0uXiWvCv7ovp6wmppXTFhNWZyXY9fj9UmnGpHqs
         65HQ==
X-Gm-Message-State: AOAM530OvGBBYmqCT/TwjnCfKL2EXwwExpKX/XBZmLTx9SNy+WNlF4bm
        XuqENfwIF95QDbVSLEKsbHwpCKdImBoulogyzGZ1Bg==
X-Google-Smtp-Source: ABdhPJxWlFOYJ0DB220x9oOZG7JB4Dhm+0+i6l+k2Fo8gixNzexi1o1ISJkCnmAF6U2ntzqhoR7b5XKlCilOASfM8tk=
X-Received: by 2002:a17:906:140b:: with SMTP id p11mr24651600ejc.116.1637175966957;
 Wed, 17 Nov 2021 11:06:06 -0800 (PST)
MIME-Version: 1.0
References: <CAP045AoMY4xf8aC_4QU_-j7obuEPYgTcnQQP3Yxk=2X90jtpjw@mail.gmail.com>
 <202111171049.3F9C5F1@keescook>
In-Reply-To: <202111171049.3F9C5F1@keescook>
From:   Kyle Huey <me@kylehuey.com>
Date:   Wed, 17 Nov 2021 11:05:51 -0800
Message-ID: <CAP045Apg9AUZN_WwDd6AwxovGjCA++mSfzrWq-mZ7kXYS+GCfA@mail.gmail.com>
Subject: Re: [REGRESSION] 5.16rc1: SA_IMMUTABLE breaks debuggers
To:     Kees Cook <keescook@chromium.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Robert O'Callahan" <rocallahan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 17, 2021 at 10:51 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Nov 17, 2021 at 10:47:13AM -0800, Kyle Huey wrote:
> > rr, a userspace record and replay debugger[0], is completely broken on
> > 5.16rc1. I bisected this to 00b06da29cf9dc633cdba87acd3f57f4df3fd5c7.
> >
> > That patch makes two changes, it blocks sigaction from changing signal
> > handlers once the kernel has decided to force the program to take a
> > signal and it also stops notifying ptracers of the signal in the same
> > circumstances. The latter behavior is just wrong. There's no reason
> > that ptrace should not be able to observe and even change
> > (non-SIGKILL) forced signals.  It should be reverted.
> >
> > This behavior change is also observable in gdb. If you take a program
> > that sets SIGSYS to SIG_IGN and then raises a SIGSYS via
> > SECCOMP_RET_TRAP and run it under gdb on a good kernel gdb will stop
> > when the SIGSYS is raised, let you inspect program state, etc. After
> > the SA_IMMUTABLE change gdb won't stop until the program has already
> > died of SIGSYS.
>
> Ah, hm, this was trying to fix the case where a program trips
> SECCOMP_RET_KILL (which is a "fatal SIGSYS"), and had been unobservable
> before. I guess the fix was too broad...

Perhaps I don't understand precisely what you mean by this, but gdb's
behavior for a program that is SECCOMP_RET_KILLed was not changed by
this patch (the SIGSYS is not observed until after program exit before
or after this change).

- Kyle
