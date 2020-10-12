Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E1528C3BB
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Oct 2020 23:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731903AbgJLVDJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Oct 2020 17:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731847AbgJLVDI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Oct 2020 17:03:08 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB68C0613D0
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Oct 2020 14:03:08 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id n9so2155052pgt.8
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Oct 2020 14:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b/TAN4DgDbRq78KqjsPZvJBxycvwlCcdCcdTr+Ek7Og=;
        b=P+n28kBusJXK2wX8qUVrbwldVwyq54gUynSy7mBzZ9CQt7v340G5/ZkQkl2QVkngvZ
         66PjP02ma9k+2+AJ0ci3ZnvC5c720Vhtn51PlaCcyXBQHG/ond0nQFbbeh2TqbhNFtTI
         +6XaOrqijFTUAuHph0GU7zKOA3JLrLRqd2UamYfYe+pvQPSroChvZCtL1dgIgdBx/weo
         TqvpCARRsPxKRIN2cCA7gheHrJkhvw0RoSEH+Fge/ZcDjX1R6ruPhAIoFSAvoGdPqPLr
         hxwrFlEBNAKVpJxfGZm5g8NfHalTD6RhlIVz597pyZEa6AmD2RtK7A0WFHuSQWYE3MsO
         D/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b/TAN4DgDbRq78KqjsPZvJBxycvwlCcdCcdTr+Ek7Og=;
        b=lEzFy/5ecGoeOQuveuMajndT42z5hzeWVoE70iytlh4OqNoZz8zMQ4LjTBMKluxTKK
         jlXt7U21v3c2M/6eXIRHxMB8E/1QEL9QwQvKvoKZ1Y4L8Vr/SijuX9RUlSrMNIuM9+me
         1PY28UHCPhovN8lJBz4ViMhI8Lq70ynjiLI2oZvXF7Hpry/54aguHcU50mmDakXcR2HI
         W7S5b06Sbjtsb+AvJyo0epA4RA6rYlHiVD3Xo6Ni/8S916h72pgPqAZaGRuw/kiFwu1v
         22cNyzQduyYHbbd/7+1LUtw0WlpvWwSEqNL5MdrbL6ZGIdw9Nyl8x84MYnNfasuVQ9p2
         LFwg==
X-Gm-Message-State: AOAM533jjF9kjwcSlyORMXdP/MKpy4WxB0Ro4t9n9P9dU8TfVegGBxa+
        DWnb//Y4iHtmVElXlEn7NsNal1JMl8vke3L+oplsDg==
X-Google-Smtp-Source: ABdhPJwIqtkqX0s+O7rGfHATFdJHihF17V4UMLnv5pGyiTA1XTsNZtRMs/y29n25CQKI5VwrwyLp6EpyeDim8He9q+c=
X-Received: by 2002:a17:90a:7144:: with SMTP id g4mr20595295pjs.80.1602536587672;
 Mon, 12 Oct 2020 14:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200729201146.537433-1-vitor@massaru.org> <20200729203908.GD2655@hirez.programming.kicks-ass.net>
 <CADQ6JjW-=SNjV-abGpGA9NfHD4yGG_bD5FmvW99W-Vo06twkbw@mail.gmail.com>
 <20200804132517.GK2657@hirez.programming.kicks-ass.net> <CADQ6JjWzze-VAmg_b9EkS4iVySt5pw8V4FSxYpDFAj8jvBxuGA@mail.gmail.com>
 <20200804142344.GM2674@hirez.programming.kicks-ass.net> <CADQ6JjWbCsyWxZKQ5=kkxx8hkaW=mbCjDodPXDAv5vH-=tVvEQ@mail.gmail.com>
In-Reply-To: <CADQ6JjWbCsyWxZKQ5=kkxx8hkaW=mbCjDodPXDAv5vH-=tVvEQ@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 12 Oct 2020 14:02:56 -0700
Message-ID: <CAFd5g46DzWRzp9yXkpHbtyJuv236E=z7OaWeqXnfuiy6CTBL4A@mail.gmail.com>
Subject: Re: [PATCH] lib: kunit: add test_min_heap test conversion to KUnit
To:     Peter Zijlstra <peterz@infradead.org>,
        Vitor Massaru Iha <vitor@massaru.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 4, 2020 at 9:22 AM Vitor Massaru Iha <vitor@massaru.org> wrote:
>
> Hi Peter,
>
> On Tue, Aug 4, 2020 at 11:23 AM <peterz@infradead.org> wrote:
> >
> > On Tue, Aug 04, 2020 at 10:46:21AM -0300, Vitor Massaru Iha wrote:
> > > On Tue, Aug 4, 2020 at 10:25 AM <peterz@infradead.org> wrote:
> > > > On Wed, Jul 29, 2020 at 06:57:17PM -0300, Vitor Massaru Iha wrote:
> > > >
> > > > > The results can be seen this way:
> > > > >
> > > > > This is an excerpt from the test.log with the result in TAP format:
> > > > > [snip]
> > > > > ok 5 - example
> > > > >     # Subtest: min-heap
> > > > >     1..6
> > > > >     ok 1 - test_heapify_all_true
> > > > >     ok 2 - test_heapify_all_false
> > > > >     ok 3 - test_heap_push_true
> > > > >     ok 4 - test_heap_push_false
> > > > >     ok 5 - test_heap_pop_push_true
> > > > >     ok 6 - test_heap_pop_push_false
> > > > > [snip]
> >
> > So ^ is TAP format?
>
> Yep, you can see the spec here: https://testanything.org/tap-specification.html
>
> >
> > > > I don't care or care to use either; what does dmesg do? It used to be
> > > > that just building the self-tests was sufficient and any error would
> > > > show in dmesg when you boot the machine.
> > > >
> > > > But if I now have to use some damn tool, this is a regression.
> > >
> > > If you don't want to, you don't need to use the kunit-tool. If you
> > > compile the tests as builtin and run the Kernel on your machine
> > > the test result will be shown in dmesg in TAP format.
> >
> > That's seems a lot more verbose than it is now. I've recently even done
> > a bunch of tests that don't print anything on success, dmesg is clutter
> > enough already.
>
> What tests do you refer to?
>
> Running the test_min_heap.c, I got this from dmesg:
>
> min_heap_test: test passed
>
> And running min_heap_kunit.c:
>
> ok 1 - min-heap

Gentle poke. I think Vitor was looking for a response. My guess is
that Ian was waiting for a follow up patch.
