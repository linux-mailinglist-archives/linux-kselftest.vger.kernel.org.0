Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE229B4DC
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2019 18:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391671AbfHWQsW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Aug 2019 12:48:22 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42341 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391545AbfHWQsV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Aug 2019 12:48:21 -0400
Received: by mail-pl1-f193.google.com with SMTP id y1so5851064plp.9
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Aug 2019 09:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=shB6SKOCWrivD7S412WveV0DXQGCOHDXUApJqsM/wlA=;
        b=Ompr7qYsU3e4pxkTUvcGDfd4ML8vgFjnLheqC9j82bJxX2WMtGNPBrUA1tpfZZ7kkl
         2MlcYLnijPbPInvIsR6zoBG80ArVaqo/qH8Nz2C1fLluKeQqMKpdn1Isx73kDPRrmtfA
         uzlQbv8SAmt8wmBgLzDRa1pCbkLXVUC7pw3IzF7X6tCUWtvjtpbvC0Rxd012AHX4+phE
         8vFfpItPxvkt5HF2AluYoxPT8xW+p0eqWdqhZxhn3iXjphBqdQMERaOSG3vodu0lrJ5X
         dliaDAtQHPNKh2+Qm2AedTz/hBlaONpPrX2iSmH0iODNpBCdBlLEBbRkV7kNpmjj1hL+
         ogpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=shB6SKOCWrivD7S412WveV0DXQGCOHDXUApJqsM/wlA=;
        b=eCIcgmhry4WptqMJg+eXGs5f0cKHDmo6NMk9VaYoPQyI3ELmr5zdV2ooeRqXxxQ3IB
         n3/j0wazUM8+/3GEEHSLTzOLXezNhDm/lniuyR0o7B7iMbAg4qc5MalPq8zC5y82HMLB
         jqgAY8BCV1FdwXmDZ9CCYrDZdmmrdFqeMAm+IDnyb3Z4pcBP8D+qwEl9L082RskYSEtA
         fiN11UTdkd0hazSTlaUI8VprvKgF6mrhg8mPfcS/99EbxRH+b9yXNjSME3toK7EtEXTa
         MuD0PFtQdxI1Y6DotW1U8uXg76zZ8SjcPGVnclKgoFwfmB3JV1cUa4j3rckeseRr/T8W
         HyOg==
X-Gm-Message-State: APjAAAVqPznl1LfFhfdBPtRw/TJn9rtU7Sn5E+Ta7OoyyNk35kacrdiy
        83pMUQNeZLF9xC4SEX+SFzM5uhFcNc1RXAPfdmdxNQ==
X-Google-Smtp-Source: APXvYqyVqeK74/JWJUZ7pW5UAwhfOe02PTG6GeE5ufM2yWENnaiC/3vIkdv/0Gau1b+w32MpN7Tbr1pv4cTuRxiXwSc=
X-Received: by 2002:a17:902:169:: with SMTP id 96mr5617305plb.297.1566578900191;
 Fri, 23 Aug 2019 09:48:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190820232046.50175-1-brendanhiggins@google.com>
 <20190820232046.50175-2-brendanhiggins@google.com> <7f2c8908-75f6-b793-7113-ad57c51777ce@kernel.org>
In-Reply-To: <7f2c8908-75f6-b793-7113-ad57c51777ce@kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 23 Aug 2019 09:48:08 -0700
Message-ID: <CAFd5g44mRK9t4f58i_YMEt=e9RTxwrrhFY_V2LW_E7bUwR3cdg@mail.gmail.com>
Subject: Re: [PATCH v14 01/18] kunit: test: add KUnit test runner core
To:     shuah <shuah@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Vetter <daniel@ffwll.ch>, Jeff Dike <jdike@addtoit.com>,
        Joel Stanley <joel@jms.id.au>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Knut Omang <knut.omang@oracle.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Petr Mladek <pmladek@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 23, 2019 at 8:33 AM shuah <shuah@kernel.org> wrote:
>
> Hi Brendan,
>
> On 8/20/19 5:20 PM, Brendan Higgins wrote:
> > Add core facilities for defining unit tests; this provides a common way
> > to define test cases, functions that execute code which is under test
> > and determine whether the code under test behaves as expected; this also
> > provides a way to group together related test cases in test suites (here
> > we call them test_modules).
> >
> > Just define test cases and how to execute them for now; setting
> > expectations on code will be defined later.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> > Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> >   include/kunit/test.h | 179 ++++++++++++++++++++++++++++++++++++++++
> >   kunit/Kconfig        |  17 ++++
> >   kunit/Makefile       |   1 +
> >   kunit/test.c         | 191 +++++++++++++++++++++++++++++++++++++++++++
> >   4 files changed, 388 insertions(+)
> >   create mode 100644 include/kunit/test.h
> >   create mode 100644 kunit/Kconfig
> >   create mode 100644 kunit/Makefile
> >   create mode 100644 kunit/test.c
> >
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > new file mode 100644
> > index 0000000000000..e0b34acb9ee4e
> > --- /dev/null
> > +++ b/include/kunit/test.h
> > @@ -0,0 +1,179 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Base unit test (KUnit) API.
> > + *
> > + * Copyright (C) 2019, Google LLC.
> > + * Author: Brendan Higgins <brendanhiggins@google.com>
> > + */
> > +
> > +#ifndef _KUNIT_TEST_H
> > +#define _KUNIT_TEST_H
> > +
> > +#include <linux/types.h>
> > +
> > +struct kunit;
> > +
> > +/**
> > + * struct kunit_case - represents an individual test case.
> > + * @run_case: the function representing the actual test case.
> > + * @name: the name of the test case.
> > + *
> > + * A test case is a function with the signature, ``void (*)(struct kunit *)``
> > + * that makes expectations (see KUNIT_EXPECT_TRUE()) about code under test. Each
> > + * test case is associated with a &struct kunit_suite and will be run after the
> > + * suite's init function and followed by the suite's exit function.
> > + *
> > + * A test case should be static and should only be created with the KUNIT_CASE()
> > + * macro; additionally, every array of test cases should be terminated with an
> > + * empty test case.
> > + *
> > + * Example:
>
> Can you fix these line continuations. It makes it very hard to read.
> Sorry for this late comment. These comments lines are longer than 80
> and wrap.

None of the lines in this commit are over 80 characters in column
width. Some are exactly 80 characters (like above).

My guess is that you are seeing the diff added text (+ ), which when
you add that to a line which is exactly 80 char in length ends up
being over 80 char in email. If you apply the patch you will see that
they are only 80 chars.

>
> There are several comment lines in the file that are way too long.

Note that checkpatch also does not complain about any over 80 char
lines in this file.

Sorry if I am misunderstanding what you are trying to tell me. Please
confirm either way.

Thanks
