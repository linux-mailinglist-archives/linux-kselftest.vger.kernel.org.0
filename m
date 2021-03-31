Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F104134D6F4
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Mar 2021 20:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhC2SXR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Mar 2021 14:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbhC2SWs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Mar 2021 14:22:48 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC34C061762
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Mar 2021 11:22:47 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 68-20020a9d0f4a0000b02901b663e6258dso13131228ott.13
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Mar 2021 11:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P+4V7kdgmOSoM2q5m0q378E9m02rDEI4zRk0CO5JIEk=;
        b=ihmdOem+jlQqEIYcjQMemO9yzZ76f8aNqKaq2e8wFi4szCWed/e1VkYakstJEI3Drg
         NaAdM5GWc0knwIVc+ct6Hw2HnP7hY90CMpni9QukM9RxNUdKXO+8UtDrP5hSr3OnGdo3
         SKg0voWbPM4pd5WN6CYz0lwI3i8uBCJ9cypbH1Cf9U6oVSlVmAF/cJilJc+gS1S8l056
         +rctM+5G8Sc+Et8OC9/ZiaHJ6YISl9zzcyHMyx8QAhSYg+ZfYEKNIsYVF8TO4CFqDl6K
         bMRlibkCRKn3uTiSk9PfKBr3QBZq+/VnNjn39AfuF1jjVsf+WQ6k/kEX2sx+aMYVbwJH
         2+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P+4V7kdgmOSoM2q5m0q378E9m02rDEI4zRk0CO5JIEk=;
        b=j5mjBqIN1YnDkpelQbJ6H2eGwJpTnAXEuFt9WTYgwcz29JOgTIifbMipLxDuoTfp1f
         s3HdxVu2Arfkz2Au+75STBMXGmfpVPl0FugkviEoDbVot0k707VnOb6e1SXN7jsaADrs
         goH8eCksLhru9BTCDZWUZlz/qby4kV/KHleBLkbHuqPouzHNZ9aRsmMkT5mhyjzUTdrX
         IuC6fHpbFb8W6zpw3bDu5AZv1fCQlMj1f/DcGGQPqL/5Z1FRWbf3Py8j7rKvwJyIAVHq
         u0F3ovoEaPCt6GDbnXFb8BXXHj0tTPn730npWldyeuNc5hrfajxPnT5BoS3avtJ6QOUx
         eo9w==
X-Gm-Message-State: AOAM531iMasIhFVLaKoVnxrPUO2ojcUeZqwEfei95I41gkDgPPCiAgOn
        xfegaL3v9GWfi1fHZIziE9jn/R3MqhE6qJ1E/051Uw==
X-Google-Smtp-Source: ABdhPJxiVzLFlZAvOj3MGXOk8B4cJRaWtdZ8/zj6Pb9YYwrVffx1QS2Y35JTKZ3UFc6rYjOtTvwKJABEFVgoDhzoe8w=
X-Received: by 2002:a05:6830:148c:: with SMTP id s12mr24623928otq.251.1617042166749;
 Mon, 29 Mar 2021 11:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210324112503.623833-1-elver@google.com> <20210324112503.623833-7-elver@google.com>
 <YFxGb+QHEumZB6G8@elver.google.com> <YGHC7V3bbCxhRWTK@hirez.programming.kicks-ass.net>
 <20210329142705.GA24849@redhat.com>
In-Reply-To: <20210329142705.GA24849@redhat.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 29 Mar 2021 20:22:34 +0200
Message-ID: <CANpmjNN=dpMmanU1mzigUscZQ6_Bx6u4u5mS4Ukhy0PTiexgDA@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] perf: Add support for SIGTRAP on perf events
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
        Dmitry Vyukov <dvyukov@google.com>,
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
        <linux-kselftest@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 29 Mar 2021 at 16:27, Oleg Nesterov <oleg@redhat.com> wrote:
> On 03/29, Peter Zijlstra wrote:
> >
> > On Thu, Mar 25, 2021 at 09:14:39AM +0100, Marco Elver wrote:
> > > @@ -6395,6 +6395,13 @@ static void perf_sigtrap(struct perf_event *event)
> > >  {
> > >     struct kernel_siginfo info;
> > >
> > > +   /*
> > > +    * This irq_work can race with an exiting task; bail out if sighand has
> > > +    * already been released in release_task().
> > > +    */
> > > +   if (!current->sighand)
> > > +           return;
>
> This is racy. If "current" has already passed exit_notify(), current->parent
> can do release_task() and destroy current->sighand right after the check.
>
> > Urgh.. I'm not entirely sure that check is correct, but I always forget
> > the rules with signal. It could be we ought to be testing PF_EXISTING
> > instead.
>
> Agreed, PF_EXISTING check makes more sense in any case, the exiting task
> can't receive the signal anyway.

So, per off-list discussion, it appears that I should ask to clarify:
PF_EXISTING or PF_EXITING?

It appears that PF_EXISTING is what's being suggested, whereas it has
not been mentioned anywhere, nor are its semantics clear. If it is not
simply the negation of PF_EXITING, what are its semantics? And why do
we need it in the case here (instead of something else that already
exists)?

Thanks,
-- Marco
