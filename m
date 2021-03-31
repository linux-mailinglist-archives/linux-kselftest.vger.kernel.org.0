Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1874C34952D
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Mar 2021 16:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhCYPSD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 Mar 2021 11:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhCYPRx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 Mar 2021 11:17:53 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AE3C061761
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Mar 2021 08:17:53 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso2266285otq.3
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Mar 2021 08:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EPhq8X0xhYyGxzLncqihu1TYBV4JibjwwPfDPM36hqE=;
        b=us6aw6OlE2KUAf0pq5BNsKs9E6wrt4m3eXA2HFHqv/r8VcNJ6/mx4SdkGM9uuW4L6a
         +I2iVx2sCO/gqvw5jOi6vpBWS8dwLBXOm4Z5RvXhmh80RKrAKyddL19nPGerUC1QPXJE
         e+Er+Q5cjde6I3pqM1+9UYXq8g180VxArqzpFP6yD4SqRFZU8zhWXm/K2aKOSanl8LLh
         H+pid5FLXkTBWbxX2zyS1dfTe+DtUjQ8XF1vtyJF4LaS2UHcyX/d904OtShVOOFTakoO
         JNtpuTW9wkPdFnhUu4wJrpYgkorzxjiqE7r91RJnPtgRZxXdy5b0XuLjA4YuoEWVk/xJ
         fOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EPhq8X0xhYyGxzLncqihu1TYBV4JibjwwPfDPM36hqE=;
        b=alVjq89ZvU7crJQWL+/ZBNZpGoNlbJt/ZYCPSw72y7gcqrarcZLZo7l/QOrKUL9X6X
         9We2MyYpl0J0cQMWmFOR2OlgjlNWhL+7ylHRD+DUE+5z1TwPqv+Q/NQefacNnbvXrOjT
         KS3Du3G9bwV9mVL9UDFeWfW8ghgaPFfVy9aWxskQbudIxq2NSFOI8JdogZrar/2QwWe7
         Lu0xBKIOWgkaC5LW+nUL+0lCvdi6caEq18ryD7/behGQmBVfhrZBOFbvdjWZNWe0RCsA
         gUeaz1FzMrK/YXhlTO6Doaq2i2l1/UO0D1jDtcinpbdGmVL9wIdlWjDp6EbaBR7fj9q9
         JLeQ==
X-Gm-Message-State: AOAM532/n2wfif1MdUv96rI3lhOk/P8EvLiwUk7J/+OP/+pelww75v/t
        9y9kHmyUejngJ7apVNZpyYmHjaT40SF1PF3hZaz2bQ==
X-Google-Smtp-Source: ABdhPJyH16XdSLbGz0m89PmIPDxVI59W+R0R5Ha0Wyqx7UpY85UnbxEqwt+1W3MSp8ENn3IFVJG82NOesTsIbm8PLb0=
X-Received: by 2002:a05:6830:148c:: with SMTP id s12mr8235464otq.251.1616685471859;
 Thu, 25 Mar 2021 08:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210324112503.623833-1-elver@google.com> <20210324112503.623833-8-elver@google.com>
 <YFs2XHqepwtlLinx@hirez.programming.kicks-ass.net> <YFs4RDKfbjw89tf3@hirez.programming.kicks-ass.net>
 <YFs84dx8KcAtSt5/@hirez.programming.kicks-ass.net> <YFtB+Ta9pkMg4C2h@hirez.programming.kicks-ass.net>
 <YFtF8tEPHrXnw7cX@hirez.programming.kicks-ass.net> <CANpmjNPkBQwmNFO_hnUcjYGM=1SXJy+zgwb2dJeuOTAXphfDsw@mail.gmail.com>
 <CACT4Y+aKmdsXhRZi2f3LsX3m=krdY4kPsEUcieSugO2wY=xA-Q@mail.gmail.com> <20210325141820.GA1456211@gmail.com>
In-Reply-To: <20210325141820.GA1456211@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 25 Mar 2021 16:17:40 +0100
Message-ID: <CANpmjNNcYSGCC7587YzMzX1UpDvTA8ewAJRsKFdzQRdmWEO7Yw@mail.gmail.com>
Subject: Re: [PATCH v3 07/11] perf: Add breakpoint information to siginfo on SIGTRAP
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Matt Morehouse <mascasa@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Ian Rogers <irogers@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 25 Mar 2021 at 15:18, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Dmitry Vyukov <dvyukov@google.com> wrote:
>
> > On Wed, Mar 24, 2021 at 3:05 PM Marco Elver <elver@google.com> wrote:
> > >
> > > On Wed, 24 Mar 2021 at 15:01, Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > One last try, I'll leave it alone now, I promise :-)
> > >
> > > This looks like it does what you suggested, thanks! :-)
> > >
> > > I'll still need to think about it, because of the potential problem
> > > with modify-signal-races and what the user's synchronization story
> > > would look like then.
> >
> > I agree that this looks inherently racy. The attr can't be allocated
> > on stack, user synchronization may be tricky and expensive. The API
> > may provoke bugs and some users may not even realize the race problem.
>
> Yeah, so why cannot we allocate enough space from the signal handler
> user-space stack and put the attr there, and point to it from
> sig_info?
>
> The idea would be to create a stable, per-signal snapshot of whatever
> the perf_attr state is at the moment the event happens and the signal
> is generated - which is roughly what user-space wants, right?

I certainly couldn't say how feasible this is. Is there infrastructure
in place to do this? Or do we have to introduce support for stashing
things on the signal stack?

From what we can tell, the most flexible option though appears to be
just some user settable opaque data in perf_event_attr, that is copied
to siginfo. It'd allow user space to store a pointer or a hash/key, or
just encode the relevant information it wants; but could also go
further, and add information beyond perf_event_attr, such as things
like a signal receiver filter (e.g. task ID or set of threads which
should process the signal etc.).

So if there's no strong objection to the additional field in
perf_event_attr, I think it'll give us the simplest and most flexible
option.

Thanks,
-- Marco

> Thanks,
>
>         Ingo
