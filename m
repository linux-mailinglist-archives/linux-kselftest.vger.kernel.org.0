Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49AD73BC6FC
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jul 2021 09:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhGFHRZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jul 2021 03:17:25 -0400
Received: from mail-vs1-f50.google.com ([209.85.217.50]:44916 "EHLO
        mail-vs1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbhGFHRZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jul 2021 03:17:25 -0400
Received: by mail-vs1-f50.google.com with SMTP id o12so315089vsr.11;
        Tue, 06 Jul 2021 00:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hTMRldGz8RN6GdcUqOfOAyODqtBNTkUTJPVSR996zFY=;
        b=t6dLtHaK4HZquC1/EAK6Qc4MnTOvtvEgphRBP7gWABM8JbDW1EFwWtSFhryAFouorq
         /GGELy2rHBjsY267PZ2nwzSxX7Laqn+Q8ptElQS1Xd7FMvzGXuCQQOag2MEhgPC1Z6nR
         SlW/Hiy36KqzLRPmuwRnfmAxmDWcyalWZ7ALSuJg5q3YN4ej3FFyBx67FcNdvLNnasJP
         aXHfBjhY7vg72nxeu2twfxD3+F5L3Y9BGzcCwGeiF3HMxelhlNazZITGOi4BulnRREqI
         ENR4M5eeByOPizECQHAJpLNuVlKcc6MYGbtOU84tu0jeWvag7tiNoXC2T/lVYPUQr8+N
         V8iQ==
X-Gm-Message-State: AOAM531dvlytkCNuL3w93Pzl4vMzRAXsXIxCXIytmumIPK8bCl9fMSLW
        gBKTf76ihFfQ8vHf54oHJlFIqnVdSk1igiKV1n4=
X-Google-Smtp-Source: ABdhPJzFH7L46qe+Zc2K3BEQAmfa8UbDuGihEqiGJmyL9FDnJPn6BVWv2sI9g2V+e4yxbLX8lHz4Qo6KyX5iFqsdftg=
X-Received: by 2002:a67:770d:: with SMTP id s13mr13037763vsc.40.1625555686463;
 Tue, 06 Jul 2021 00:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210705114633.1500710-1-geert@linux-m68k.org> <YOMc2PZTur+qyhH9@smile.fi.intel.com>
In-Reply-To: <YOMc2PZTur+qyhH9@smile.fi.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 6 Jul 2021 09:14:35 +0200
Message-ID: <CAMuHMdWeRyK3iq7DNaw81OJvT6YwX8Eem1nrYfV9DzX10Xcomw@mail.gmail.com>
Subject: Re: [PATCH] math: Make RATIONAL tristate
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Trent Piepho <tpiepho@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Andy,

On Mon, Jul 5, 2021 at 4:53 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, Jul 05, 2021 at 01:46:33PM +0200, Geert Uytterhoeven wrote:
> > All but one symbols that select RATIONAL are tristate, but RATIONAL
> > itself is bool.  Change it to tristate, so the rational fractions
> > support code can be modular if no builtin code relies on it.
> >
> > While at it, add support for compile-testing and provide a help text.
>
> ...
>
> > Exposed by commit b6c75c4afceb8bc0 ("lib/math/rational: add Kunit test
> > cases") and CONFIG_KUNIT_ALL_TESTS=m.
> >
> > I'm not so happy RATIONAL_KUNIT_TEST selects RATIONAL, as test code
> > should depend on the presence of the feature to test.  Else enabling
> > a test may add unneeded code to a production kernel.
> > Perhaps the "if COMPILE_TEST" should be dropped, making RATIONAL
> > visible, so RATIONAL_KUNIT_TEST can depend on RATIONAL instead?
>
> ...
>
> > +     tristate "Rational fractions support" if COMPILE_TEST
>
> Making it tristate is okay, but visible (even for COMPILE_TEST)... why?
> Just on purpose to be dependent on for test case? I understand your
> justification above, but it will bring all hidden symbols to be unhidden
> (due to test cases) and this is not the right thing to do in my opinion.

OK.  Will drop in v2.

> Why not to complain to KUnit people to fix their infra to avoid tests that
> tries non-selected feature(s)?

I guess the audience is listening...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
