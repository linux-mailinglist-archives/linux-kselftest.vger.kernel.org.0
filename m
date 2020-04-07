Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 305A31A183A
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Apr 2020 00:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgDGWai (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Apr 2020 18:30:38 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:34737 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgDGWai (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Apr 2020 18:30:38 -0400
Received: by mail-pj1-f66.google.com with SMTP id q16so1519701pje.1
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Apr 2020 15:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y5B4wxSp02uuFivz7ODBtuslpEN2qFSLVxuus0MTRZI=;
        b=g+cLm4wFKGfTjBLaTqj9Vw2LvdSG3yyGeKcR+yC9FMrSkOLJEq9No9D8cbxID2xG7P
         Dnc9swLrPSQrJnFWGO4pokRaj0SWKxLdn1QX5ypxZSN3qE7hX2YKNCkIQo+f7dcxjINM
         7j47dHfP1PqlNfUSzmSb16+poyLMhlzjH0BF+DgjSPHkbHmfA7hpwiZkoq6za+H6/ftA
         0ckMaHW/aD1uOkg4SFiVfyd0HyVGyIqHznIJ+oQmXXA5D9OZtRjQIi/5zhojOU/ENjYF
         2sSsBLhgKtyiBT0b4H+6LZPujAq31yaLROlz8D3CIqY41M1iPLcoWo6PkG4ms4Trc5G4
         mNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y5B4wxSp02uuFivz7ODBtuslpEN2qFSLVxuus0MTRZI=;
        b=NUTm7nBnTd6greLpNl63MdowDbWuRj3eKp8KkKO9ahJ+aEB6/H7sBYjUBlUNKLiX0k
         Yj8/jUmd3Ym82WmOyJfnndza213MFk1D4kcAQ4P10SAhy0aJ6tS9LQQQnS1HA+3P1OI2
         6gbrwKcJm8PpYcycKmmNQrjnFRArvnT83iOx07nfxBRNTRCaw/hWTkLooxC6arBrPsH6
         YyIr0eghn6TGzNiB+JHZ7RxUD/n6I2/YkdobVGs25wqE0x/qmEEiXEEdQhUccsjrbU42
         0dcqT9hI3Hsz8B5ZWCZwYL8E2pBAen04HtAeSGq1zk3EXBAz+0Pmj5IPBu92euOZu7Kg
         RRYQ==
X-Gm-Message-State: AGi0PuZTi4VS9FNsuEuXq3vzL1OChEKVDxB0FSdhnRkxZKoU7J+DoR0n
        sLccFaloy9p/R3plQ8AsgSfFcssigVUhrZzsM1s=
X-Google-Smtp-Source: APiQypJpmPf3MioORTeWu4IjYX4Y39mg6ICX+MxsHMYqBDAm5awW/piILGOXuMKl7+rWhMExLao5r2TBFaKG+21XDC4=
X-Received: by 2002:a17:902:61:: with SMTP id 88mr4564119pla.30.1586298637887;
 Tue, 07 Apr 2020 15:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200406214130.21224-1-l.rubusch@gmail.com> <CAFd5g448Qz0bGkNCPR+zS-gH-T9A64L1tExgKb_-jQO3bysGOA@mail.gmail.com>
In-Reply-To: <CAFd5g448Qz0bGkNCPR+zS-gH-T9A64L1tExgKb_-jQO3bysGOA@mail.gmail.com>
From:   Lothar Rubusch <l.rubusch@gmail.com>
Date:   Wed, 8 Apr 2020 00:30:01 +0200
Message-ID: <CAFXKEHYvE5N4go9KvBbMOaCWTT3vsb8M-G1JXTeKNsYBP0R1bg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: test.h - fix warnings
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 7, 2020 at 10:49 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Mon, Apr 6, 2020 at 2:41 PM Lothar Rubusch <l.rubusch@gmail.com> wrote:
> >
> > Fix several sphinx warnings at 'make htmldocs'
> > - privately declared members not correctly declared as such
> > - 'suits' actually is not a function parameter, change declaration to fix
> >   warning but keep information in comment
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
>
> Thanks for taking care of this!
>
> > ---
> >  include/kunit/test.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index 9b0c46a6ca1f..fe4ea388528b 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -175,7 +175,7 @@ struct kunit_suite {
> >         void (*exit)(struct kunit *test);
> >         struct kunit_case *test_cases;
> >
> > -       /* private - internal use only */
> > +       /* private: internal use only. */
> >         struct dentry *debugfs;
> >         char *log;
> >  };
> > @@ -232,7 +232,7 @@ void __kunit_test_suites_exit(struct kunit_suite **suites);
> >   * kunit_test_suites() - used to register one or more &struct kunit_suite
> >   *                      with KUnit.
> >   *
> > - * @suites: a statically allocated list of &struct kunit_suite.
> > + * suites - a statically allocated list of &struct kunit_suite.
>
> So, I am pretty sure you can name the variadic arguments and then that
> gives you a valid parameter to use with kernel doc. Can you try that
> out?
>
You mean the warning "Excess function parameter 'suites' description
in 'kunit_test_suites'"?
Honestly, due to the TODO in the same comment section, It seemed to me kind of a
work-in-progress situation which I didn't dare to interfere.

> >   *
> >   * Registers @suites with the test framework. See &struct kunit_suite for
>
> Also, if my suggestion ends up not working, you should change this
> line to match.
>

Sure, sounds interesting I can try to figure out. Thank you for the answer.
L
