Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991DD28E623
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Oct 2020 20:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387851AbgJNSQY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Oct 2020 14:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387801AbgJNSQY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Oct 2020 14:16:24 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794FAC0613D2
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Oct 2020 11:16:24 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l15so290780wmh.1
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Oct 2020 11:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4hg2v/GYJHdaSA1mdU/demCJi+L5+geP2CWSqLJ/Oes=;
        b=Bl7s3LEfpCQle3+U7qJbpebW/VwHltBgH7AbG4T9b2Gl0iK4kvwRI2ouEsK5/GhbwI
         +pgV6LkFWeG12P2jAuyYeJHTTNlytEiJyAtj1BlXrurDq6bxjWTmepySsREbGgvgonHO
         dw/yTE2kIfeSTWA2bf2D+T7KOpG3xfSziGIlKea6C3X0nKkafXQXbzdcbmBU68NbBQpP
         3CrZqtbYOb9A72W92agOP3hLy3dRasxw+U2DMoDTC8jI/hkWF7O+O4diS+relc2MCgH3
         hlOGhXpCowsgWL7Qz/UGknr+LpVZNO7gVquNlkIgO+6k0ZTm5Zx65V9WicHmzdr7hOip
         ZyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4hg2v/GYJHdaSA1mdU/demCJi+L5+geP2CWSqLJ/Oes=;
        b=M2cZ6dcej17bG06mmt6kKsVKHgJJ0ksdSA+FtMpSe7PUjqDeHMlwBe1GSM2G3CIlGO
         J/oN8WldBrknpBbsmraxD/lAKTZ7x9zdqTbrSczqEKeVH9A4A0IpdwJYjgpC6NOklLOT
         qRkEuYW/Xgry02umDQfcr0u4vOS1iqBxbR/LhOrpI4NsjPgegCnFKwwH/GgqcG+edVIR
         HY1QiC9+z50AM4NoyPsXZ2aFvrNndFVkSjOoXf4NtjxMbKNuq4UThZAnJMDW2jfOB2Wx
         4tqI51hobmWsmnOeVfXNChbhKxKANHo/nsyjR+haaNvl/DOgLw2T58xQnATLDWPfwo3t
         2Fnw==
X-Gm-Message-State: AOAM530kAVAQvxEn41jA5ExeKaKZ23o7jnrgm4RmHwWkpP9N07b+fFHn
        3HBP694LfL+nTcg4bY52h5eBR4yXCo8HIKPD1fNJhA==
X-Google-Smtp-Source: ABdhPJxo167Rwvisc1S5kBbvo1EVU+JRvgzYnOKtYLjOzhMmx/1GQrPr3717fqlNPbum0uumMSuBHmVZ9hbZhjS2K6Y=
X-Received: by 2002:a7b:c181:: with SMTP id y1mr160947wmi.58.1602699382955;
 Wed, 14 Oct 2020 11:16:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200729201146.537433-1-vitor@massaru.org> <20200729203908.GD2655@hirez.programming.kicks-ass.net>
 <CADQ6JjW-=SNjV-abGpGA9NfHD4yGG_bD5FmvW99W-Vo06twkbw@mail.gmail.com>
 <20200804132517.GK2657@hirez.programming.kicks-ass.net> <CADQ6JjWzze-VAmg_b9EkS4iVySt5pw8V4FSxYpDFAj8jvBxuGA@mail.gmail.com>
 <20200804142344.GM2674@hirez.programming.kicks-ass.net> <CADQ6JjWbCsyWxZKQ5=kkxx8hkaW=mbCjDodPXDAv5vH-=tVvEQ@mail.gmail.com>
 <CAFd5g46DzWRzp9yXkpHbtyJuv236E=z7OaWeqXnfuiy6CTBL4A@mail.gmail.com>
In-Reply-To: <CAFd5g46DzWRzp9yXkpHbtyJuv236E=z7OaWeqXnfuiy6CTBL4A@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 14 Oct 2020 11:16:10 -0700
Message-ID: <CAP-5=fXhFG9sTMcfd1qJmMDNJWqOGky=jFtWNWg8U8-dkRp=dQ@mail.gmail.com>
Subject: Re: [PATCH] lib: kunit: add test_min_heap test conversion to KUnit
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vitor Massaru Iha <vitor@massaru.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 12, 2020 at 2:03 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Tue, Aug 4, 2020 at 9:22 AM Vitor Massaru Iha <vitor@massaru.org> wrote:
> >
> > Hi Peter,
> >
> > On Tue, Aug 4, 2020 at 11:23 AM <peterz@infradead.org> wrote:
> > >
> > > On Tue, Aug 04, 2020 at 10:46:21AM -0300, Vitor Massaru Iha wrote:
> > > > On Tue, Aug 4, 2020 at 10:25 AM <peterz@infradead.org> wrote:
> > > > > On Wed, Jul 29, 2020 at 06:57:17PM -0300, Vitor Massaru Iha wrote:
> > > > >
> > > > > > The results can be seen this way:
> > > > > >
> > > > > > This is an excerpt from the test.log with the result in TAP format:
> > > > > > [snip]
> > > > > > ok 5 - example
> > > > > >     # Subtest: min-heap
> > > > > >     1..6
> > > > > >     ok 1 - test_heapify_all_true
> > > > > >     ok 2 - test_heapify_all_false
> > > > > >     ok 3 - test_heap_push_true
> > > > > >     ok 4 - test_heap_push_false
> > > > > >     ok 5 - test_heap_pop_push_true
> > > > > >     ok 6 - test_heap_pop_push_false
> > > > > > [snip]
> > >
> > > So ^ is TAP format?
> >
> > Yep, you can see the spec here: https://testanything.org/tap-specification.html
> >
> > >
> > > > > I don't care or care to use either; what does dmesg do? It used to be
> > > > > that just building the self-tests was sufficient and any error would
> > > > > show in dmesg when you boot the machine.
> > > > >
> > > > > But if I now have to use some damn tool, this is a regression.
> > > >
> > > > If you don't want to, you don't need to use the kunit-tool. If you
> > > > compile the tests as builtin and run the Kernel on your machine
> > > > the test result will be shown in dmesg in TAP format.
> > >
> > > That's seems a lot more verbose than it is now. I've recently even done
> > > a bunch of tests that don't print anything on success, dmesg is clutter
> > > enough already.
> >
> > What tests do you refer to?
> >
> > Running the test_min_heap.c, I got this from dmesg:
> >
> > min_heap_test: test passed
> >
> > And running min_heap_kunit.c:
> >
> > ok 1 - min-heap
>
> Gentle poke. I think Vitor was looking for a response. My guess is
> that Ian was waiting for a follow up patch.

There were some issues in the original patch, they should be easy to
fix. I'm more concerned that Peter's issues are addressed about the
general direction of the patch, verbosity and testing frameworks. I
see Vitor followed up with Peter but I'm not sure that means the
approach has been accepted.

Thanks,
Ian
