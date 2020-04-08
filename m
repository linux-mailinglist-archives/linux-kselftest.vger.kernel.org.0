Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26D1C1A2909
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Apr 2020 21:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgDHTDP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Apr 2020 15:03:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43349 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgDHTDP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Apr 2020 15:03:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id l1so909866pff.10
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Apr 2020 12:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ovmZLNaPWUOEPw32o5QBfhgsv7qFCQIg+Bh0oPyXYNA=;
        b=hBOiCmzhYF5NeFXnbIcn4ZBr1IpF//9dgspPn/t0gRv6KOgQvRyRTS62Y8AQIITUdc
         Fk9rMc9F3B2C8uzdaLEvew0tUmpeB3pbu5DpHHLUlhcO6garvgSoyT/vbKHlyqtYTQUU
         kqJIAAi4xLmchS6ulrbQJYRayOGHgSc3z37/wX3WWg3a0ecZVHTyrWKx9ehsqqcDz94r
         SXR9Esi/9TgGLJFpnfo1fSP54qkL1cUwYJgqLRJP7Lead1fZih6FDbjdfudjsNAJsvr7
         /CYNp7ATvZ8aUGXKUEuf1AfP/gLkwAaK0rW7P+4noiLcpEEvZf4Fj8FmQNOFszWlxMis
         2MEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ovmZLNaPWUOEPw32o5QBfhgsv7qFCQIg+Bh0oPyXYNA=;
        b=XF5Aiz8oyRFoWAqv5ReH9JvpsXcFxaqprv/+YrKopTeaohM0k6Rvb/BQ1x7Um9EvMk
         9gqwEMfJk/BKeRkgMPdg1oU2p4/oz9xIJD5gEo36+VYSeOOt6oTsnuPNxVEmBCLMlNCb
         QwXJ6Hypk9O6Y5Wa9cwCqzS22VBVFqqiz04o5IYP+3jpbBKCY4YZKVu4yzBnjwmsvAxc
         j0Ayut3/WRRTVr2QXysba92CTkuy5g8W/fMPXKPb+u50t9GXOr7I8POaBHoLhAPuXXH6
         aKghSUSPrcYeTfbih7SXddWhpravedDEn4MrhEnjF4uwAbr5TCDMEfwz2vWm0fcSJgDW
         Wrow==
X-Gm-Message-State: AGi0PuZnoo5NxJOUnnAfp2sjbbyTuYnKMZXJ7X48dHpPW4nX8dWqT+JI
        6WdMa+QocxHniP+tPK+lfmHS+9KMN9gOAq5zpNzyG0Y1
X-Google-Smtp-Source: APiQypKNzWzMxi2k+hCjcNriiOf9Gqc2r9NuYZ0y0lqCZ/GWCvO4dJbD1jEKHGbRTUt/CxI8wVzpG4zY86ec5QexX0w=
X-Received: by 2002:a63:d049:: with SMTP id s9mr7942691pgi.384.1586372593847;
 Wed, 08 Apr 2020 12:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200406214130.21224-1-l.rubusch@gmail.com> <CAFd5g448Qz0bGkNCPR+zS-gH-T9A64L1tExgKb_-jQO3bysGOA@mail.gmail.com>
 <CAFXKEHYvE5N4go9KvBbMOaCWTT3vsb8M-G1JXTeKNsYBP0R1bg@mail.gmail.com>
In-Reply-To: <CAFXKEHYvE5N4go9KvBbMOaCWTT3vsb8M-G1JXTeKNsYBP0R1bg@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 8 Apr 2020 12:03:02 -0700
Message-ID: <CAFd5g44L7Ho1zc8cunfC_T-OGgdkTMngX8LW_Jt83WRKL2M5QA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: test.h - fix warnings
To:     Lothar Rubusch <l.rubusch@gmail.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 7, 2020 at 3:30 PM Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> On Tue, Apr 7, 2020 at 10:49 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > On Mon, Apr 6, 2020 at 2:41 PM Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > >
> > > Fix several sphinx warnings at 'make htmldocs'
> > > - privately declared members not correctly declared as such
> > > - 'suits' actually is not a function parameter, change declaration to fix
> > >   warning but keep information in comment
> > >
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> >
> > Thanks for taking care of this!
> >
> > > ---
> > >  include/kunit/test.h | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > > index 9b0c46a6ca1f..fe4ea388528b 100644
> > > --- a/include/kunit/test.h
> > > +++ b/include/kunit/test.h
> > > @@ -175,7 +175,7 @@ struct kunit_suite {
> > >         void (*exit)(struct kunit *test);
> > >         struct kunit_case *test_cases;
> > >
> > > -       /* private - internal use only */
> > > +       /* private: internal use only. */
> > >         struct dentry *debugfs;
> > >         char *log;
> > >  };
> > > @@ -232,7 +232,7 @@ void __kunit_test_suites_exit(struct kunit_suite **suites);
> > >   * kunit_test_suites() - used to register one or more &struct kunit_suite
> > >   *                      with KUnit.
> > >   *
> > > - * @suites: a statically allocated list of &struct kunit_suite.
> > > + * suites - a statically allocated list of &struct kunit_suite.
> >
> > So, I am pretty sure you can name the variadic arguments and then that
> > gives you a valid parameter to use with kernel doc. Can you try that
> > out?
> >
> You mean the warning "Excess function parameter 'suites' description
> in 'kunit_test_suites'"?

Yep, I just tried it out locally and it should work.

> Honestly, due to the TODO in the same comment section, It seemed to me kind of a
> work-in-progress situation which I didn't dare to interfere.

Don't worry about that. Addressing that TODO is going to take some time.

> > >   *
> > >   * Registers @suites with the test framework. See &struct kunit_suite for
> >
> > Also, if my suggestion ends up not working, you should change this
> > line to match.
> >
>
> Sure, sounds interesting I can try to figure out. Thank you for the answer.

Thanks!
