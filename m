Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8492B174C18
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Mar 2020 07:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbgCAGjf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 1 Mar 2020 01:39:35 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43710 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgCAGjf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 1 Mar 2020 01:39:35 -0500
Received: by mail-qk1-f194.google.com with SMTP id q18so7105737qki.10
        for <linux-kselftest@vger.kernel.org>; Sat, 29 Feb 2020 22:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3vMiqgqrTzNOns9tPGStxdXw3VsNXtcnvGdYEqnF7WI=;
        b=uigv0ukeQk6L1xGAaG9zsLq0Hf/aCjLtTWnwjAowPansSH38LcfJha2ytFwRFzHTBO
         MORDKB0ahQBrsBDvQ1KDy6ECljLXB91prPacbqckjAI29pyPCMmHjUAZWs8H0yTLA3ky
         9n8NUpjlefsvmZewQuKgMd+qLaTVXnKyMXDQ/gRfAy+X5g4IcHwjBTUalG9+RsCPwMbY
         NjURC/jcepaMCeQXlEPQuxOEG6zn0VsA6ZidamhGP9OUqGfFAaq5dZfR6FnoQGX9ktN4
         WtiaWF69csP/SNKZiqaYlzM6U+98R0Q/g8NkIEp3quS4QjGhk/3O3fwl/FsZkqLFaalO
         dBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3vMiqgqrTzNOns9tPGStxdXw3VsNXtcnvGdYEqnF7WI=;
        b=Zw4fzfJN1KgmxJTqaKa6iZ3Aa9MZ8Xq8rNvmi/Hjxmd20Sy47N8s3YbM2Y5zIFOjnD
         tSierOZqB1bHjXATAnhHYqrlDn7+9GbL9q1g6qWEegnWehNrW5dGT295iC0BOzyoD7M/
         TMJtsGchDg9x+a6nXwUSG0q9flwq49+X4IEg16g7UvTZJprYCT2NJmmD7UDDe3o7sJTO
         onisNlfqc4kfRjaH/qazxq0t49/x12+RRkMHUkM3xJpvmbcpDWz+2CeLU+aTouY52CyA
         LGKvDI23MTnDlldjt7RzK84oHC1OcvGwZaqqBMRHbwLhwu3r0QFLKJqT1134adQZc5yC
         zC0A==
X-Gm-Message-State: APjAAAX71glcqU80lBF7Ne15gd0c5JgpyXka+NoDTdePjZcNmUjjmUwp
        7kNn6Yf6AUoQ1v66Ja2qA4ssF7Wz5zdCEAPXVJgbpw==
X-Google-Smtp-Source: APXvYqzJDtPI/Dw6AapENwdGNYeXdu95wuDXGOjoQGKY45dZnz92J1JJy/hetlHT1u0pcKpSQL8PLSWAC0j2AabNZrI=
X-Received: by 2002:a37:7c47:: with SMTP id x68mr11627985qkc.8.1583044773747;
 Sat, 29 Feb 2020 22:39:33 -0800 (PST)
MIME-Version: 1.0
References: <20200227024301.217042-1-trishalfonso@google.com>
 <CACT4Y+Z_fGz2zVpco4kuGOVeCK=jv4zH0q9Uj5Hv5TAFxY3yRg@mail.gmail.com> <CAKFsvULZqJT3-NxYLsCaHpxemBCdyZN7nFTuQM40096UGqVzgQ@mail.gmail.com>
In-Reply-To: <CAKFsvULZqJT3-NxYLsCaHpxemBCdyZN7nFTuQM40096UGqVzgQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 1 Mar 2020 07:39:22 +0100
Message-ID: <CACT4Y+YTNZRfKLH1=FibrtGj34MY=naDJY6GWVnpMvgShSLFhg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] Port KASAN Tests to KUnit
To:     Patricia Alfonso <trishalfonso@google.com>,
        Kees Cook <keescook@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Feb 29, 2020 at 2:56 AM Patricia Alfonso
<trishalfonso@google.com> wrote:
> On Thu, Feb 27, 2020 at 6:19 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > .On Thu, Feb 27, 2020 at 3:44 AM Patricia Alfonso
> > > -       pr_info("out-of-bounds in copy_from_user()\n");
> > > -       unused = copy_from_user(kmem, usermem, size + 1);
> >
> > Why is all of this removed?
> > Most of these tests are hard earned and test some special corner cases.
> >
> I just moved it inside IS_MODULE(CONFIG_TEST_KASAN) instead because I
> don't think there is a way to rewrite this without it being a module.

You mean these are unconditionally crashing the machine? If yes,
please add a comment about this.

Theoretically we could have a notion of "death tests" similar to gunit:
https://stackoverflow.com/questions/3698718/what-are-google-test-death-tests
KUnit test runner wrapper would need to spawn a separete process per
each such test. Under non-KUnit test runner these should probably be
disabled by default and only run if specifically requested (a-la
--gunit_filter/--gunit_also_run_disabled_tests).
Could also be used to test other things that unconditionally panic,
e.g. +Kees may be happy for unit tests for some of the
hardening/fortification features.
I am not asking to bundle this with this change of course.
