Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2FBB350518
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Mar 2021 18:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbhCaQuj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Mar 2021 12:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbhCaQuZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Mar 2021 12:50:25 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE43C061574
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Mar 2021 09:50:25 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id m21-20020a9d7ad50000b02901b83efc84a0so19516033otn.10
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Mar 2021 09:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rdpwslgy7i3fT+uqHNLqy9H/4PdpXsKpQtKlUmrnWNs=;
        b=Ic5OrjlK2s8S56gjj/cC3LJo+Zd6eYLbKKzA9nlhzS+DGhcnENAp5/sTGyrer47MYA
         9jRyxQ86yp9rpPZ+tUn/+kXJz+U2C1UJHAiobjQr0bYNm0bDVbAvJ2SmLRgxGgtbkWax
         VfSD5oIAMK3Hx3COMA4PLq4kf3nVuHSkPCetmASTDasMGzABVpnrNEJMtT4fDSIlQ/HX
         iUsEE4faTm3L8AODBS5Ae5F6V27fU+ZyZ7iJgB08v3kNjQxxdARgvkfaCOCXGGq64upm
         +/9NqEPLZlMVahIuuJfiQ6J+ki3DNXHGCitT/FhDo0DHZ1XJTabKI51qyEAN9ZfSspXa
         3+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rdpwslgy7i3fT+uqHNLqy9H/4PdpXsKpQtKlUmrnWNs=;
        b=LwC6kpGZxJYi0nDZbUvg8EJWcWXzOc33itykG5AgcO6JKVyz8P43bxPt8jCpyU/ROL
         fSxp4bRBwuF2gUtJWlV1SOmW73wWB2y/XqNOULYrWspKGZrg/+iUgZcIumz5HumY8yFS
         pmtzzpgk7p5Xt1di84tf70OxZONSoODWLkv7SgTYbtPfumqJeUvX5CoNlHOU7Gc9QFKp
         Es1qL8DXL300CFY93himMxdISO4iD1ixphZWRK5hTriIAVx20GA3ApJ14zUgY3JYWPAf
         c+PiPFSxytAYKY/9CRiV2PF49GGF+t+nd0hCyWEIu5xQgm4r+tUbiHhg/T+YLeu9+ogz
         m5Lw==
X-Gm-Message-State: AOAM533+iZBjxX3mCIHlEwA45EgJ9E30xkPLsJd7m1njjGi8/1+HAtFd
        ZKaIRbRDxZr+9/KYO/Sa1N2YO1bFXUTeh0vDLayJjA==
X-Google-Smtp-Source: ABdhPJwb4gtrTABbnL6uQcyrjzA0brdgMtdN+E7/WammKTa93I0urg9baMlbzu4LK+C3GslQkiMyIoYkVbC7IqUTLbQ=
X-Received: by 2002:a05:6830:148c:: with SMTP id s12mr3484254otq.251.1617209424896;
 Wed, 31 Mar 2021 09:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210324112503.623833-1-elver@google.com> <20210324112503.623833-7-elver@google.com>
 <YFxGb+QHEumZB6G8@elver.google.com> <YGHC7V3bbCxhRWTK@hirez.programming.kicks-ass.net>
 <CANpmjNOPJNhJ2L7cxrvf__tCZpy=+T1nBotKmzr2xMJypd-oJQ@mail.gmail.com> <YGSMXJvLBpQOm3WV@hirez.programming.kicks-ass.net>
In-Reply-To: <YGSMXJvLBpQOm3WV@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Wed, 31 Mar 2021 18:50:12 +0200
Message-ID: <CANpmjNPGmzzg-uv3DGZ+1M+nDNy3WiFU7g3u_CzR-GBju+1Z_Q@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] perf: Add support for SIGTRAP on perf events
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
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
        <linux-kselftest@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 31 Mar 2021 at 16:51, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Mar 31, 2021 at 02:32:58PM +0200, Marco Elver wrote:
> > On Mon, 29 Mar 2021 at 14:07, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > > (and we might already have a problem on some architectures where there
> > > can be significant time between these due to not having
> > > arch_irq_work_raise(), so ideally we ought to double check current in
> > > your case)
> >
> > I missed this bit -- just to verify: here we want to check that
> > event->ctx->task == current, in case the the irq_work runs when the
> > current task has already been replaced. Correct?
>
> Yeah, just not sure what a decent failure would be, silent ignore seems
> undesired, maybe WARN and archs that can trigger it get to fix it ?

I'll go with a WARN and add a comment.

This also revealed there should be a requirement that sigtrap events
must be associated with a task (syzkaller managed to trigger the
warning for cpu events).

Thanks,
-- Marco
