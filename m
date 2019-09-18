Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A27A3B698E
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2019 19:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387955AbfIRRdM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Sep 2019 13:33:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41401 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387956AbfIRRdM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Sep 2019 13:33:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id x15so235115pgg.8
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Sep 2019 10:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=StXZgvnpam5WSnONqlrjqogHFGTPbRU5H/9svC301oA=;
        b=lNaWea2wHOahDQ2SfFBEJNTwvRJljZ4vfQbq1ncbftO9Zkv25xpQBvDpPyJodgNuw4
         mHq+zrLWIxf7vRwCCMTLqRdnOgqg2cZ4AT/l55ydHN4lfLuZSWD07dTf9gpzVZQl6Mm1
         Kgu4GZVwHJ54b9H1o6YWs1PVGML1cN4NkWxFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=StXZgvnpam5WSnONqlrjqogHFGTPbRU5H/9svC301oA=;
        b=C6rLwFc/qbjJvfb6+wwHJQ/Kg63RoPBfbiIJVZM8z22GWrBSooBAzj4o07yMxdhOLt
         Ci/mQ3/3s4pAM0n2J2ZwLAa7ipfjr2IGa6XDphcArpj1Ww5DAPt8rKi3DZkez8JYS3CT
         krgzPI9e2ZvFmFVHgii/RyeFZcoM1fAVekZ4rYVWxkWApLeJZsfBeHbjUCWhyEmIpAHY
         Nh2HkB3nhBAIRTqoXXeVrbQrTkFQXNWCLB4MR/BZaSjK+GqwJEAW93e71NcNCcut0yAS
         /ZzxKJU4BMnrBEGSqEPo+v56XpFPAAl5ceWXXsOo+Zk9exn7pKR2iC07fxHG+WtxEdBX
         b6Xg==
X-Gm-Message-State: APjAAAXFg5quDbBd7smo0AXzCTI4/ArM21WzGqus9vjl1WFv1FioRXpN
        84TrYLXyfPJbHpGPk5SkGYkDbKNVY+E=
X-Google-Smtp-Source: APXvYqxrOTpzIrp2OPEtn9cpjFNxJvtrf/xJEOP7epK4jBWFUlgjdtb/SPs45Kv0fjkV9EwxrCQXJw==
X-Received: by 2002:a17:90a:b309:: with SMTP id d9mr5124022pjr.8.1568827991873;
        Wed, 18 Sep 2019 10:33:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z19sm5832575pgv.35.2019.09.18.10.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 10:33:10 -0700 (PDT)
Date:   Wed, 18 Sep 2019 10:33:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tyler Hicks <tyhicks@canonical.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        luto@amacapital.net, jannh@google.com, wad@chromium.org,
        shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Tycho Andersen <tycho@tycho.ws>, stable@vger.kernel.org
Subject: Re: [PATCH 2/4] seccomp: add two missing ptrace ifdefines
Message-ID: <201909181031.1EE73B4@keescook>
References: <20190918084833.9369-1-christian.brauner@ubuntu.com>
 <20190918084833.9369-3-christian.brauner@ubuntu.com>
 <20190918091512.GA5088@elm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190918091512.GA5088@elm>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 18, 2019 at 11:15:12AM +0200, Tyler Hicks wrote:
> On 2019-09-18 10:48:31, Christian Brauner wrote:
> > Add tw missing ptrace ifdefines to avoid compilation errors on systems
> > that do not provide PTRACE_EVENTMSG_SYSCALL_ENTRY or
> > PTRACE_EVENTMSG_SYSCALL_EXIT or:
> > 
> > gcc -Wl,-no-as-needed -Wall  seccomp_bpf.c -lpthread -o seccomp_bpf
> > In file included from seccomp_bpf.c:52:0:
> > seccomp_bpf.c: In function ‘tracer_ptrace’:
> > seccomp_bpf.c:1792:20: error: ‘PTRACE_EVENTMSG_SYSCALL_ENTRY’ undeclared (first use in this function); did you mean ‘PTRACE_EVENT_CLONE’?
> >   EXPECT_EQ(entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY
> >                     ^
> > ../kselftest_harness.h:608:13: note: in definition of macro ‘__EXPECT’
> >   __typeof__(_expected) __exp = (_expected); \
> >              ^~~~~~~~~
> > seccomp_bpf.c:1792:2: note: in expansion of macro ‘EXPECT_EQ’
> >   EXPECT_EQ(entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY
> >   ^~~~~~~~~
> > seccomp_bpf.c:1792:20: note: each undeclared identifier is reported only once for each function it appears in
> >   EXPECT_EQ(entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY
> >                     ^
> > ../kselftest_harness.h:608:13: note: in definition of macro ‘__EXPECT’
> >   __typeof__(_expected) __exp = (_expected); \
> >              ^~~~~~~~~
> > seccomp_bpf.c:1792:2: note: in expansion of macro ‘EXPECT_EQ’
> >   EXPECT_EQ(entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY
> >   ^~~~~~~~~
> > seccomp_bpf.c:1793:6: error: ‘PTRACE_EVENTMSG_SYSCALL_EXIT’ undeclared (first use in this function); did you mean ‘PTRACE_EVENTMSG_SYSCALL_ENTRY’?
> >     : PTRACE_EVENTMSG_SYSCALL_EXIT, msg);
> >       ^
> > ../kselftest_harness.h:608:13: note: in definition of macro ‘__EXPECT’
> >   __typeof__(_expected) __exp = (_expected); \
> >              ^~~~~~~~~
> > seccomp_bpf.c:1792:2: note: in expansion of macro ‘EXPECT_EQ’
> >   EXPECT_EQ(entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY
> >   ^~~~~~~~~
> > 
> > Fixes: 6a21cc50f0c7 ("seccomp: add a return code to trap to userspace")
> 
> I think this Fixes line is incorrect and should be changed to:
> 
> Fixes: 201766a20e30 ("ptrace: add PTRACE_GET_SYSCALL_INFO request")
> 
> With that changed,
> 
> Reviewed-by: Tyler Hicks <tyhicks@canonical.com>

This is actually fixed in -next already (and, yes, with the Fixes line
Tyler has mentioned):

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=next&id=69b2d3c5924273a0ae968d3818210fc57a1b9d07

-- 
Kees Cook
