Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60AC54AA522
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Feb 2022 01:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378600AbiBEAvc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Feb 2022 19:51:32 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:33429 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378193AbiBEAvb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Feb 2022 19:51:31 -0500
Received: by mail-wr1-f50.google.com with SMTP id e3so235411wra.0
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Feb 2022 16:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+kPloqKO1KO25u/0GdWv0wKux8vVdRY/SXvc99NBLRA=;
        b=FAnneMznrfb4GJPaMgaKUGveEE5vvi5nQtjVkQ3Fbdxs4mGdY/dV0xc0pdqX3xLwmQ
         pcfV3YKuQy6VGq+S2UN/zIaYb/1paxGGCMVHlc36QMMW91yqTqvhSK3Xo30rt3Z18SBV
         NmAMzQZFI5yePNcewowgTjU5uwLhQQoVrnwNqiKbyymqXtVy2ZSavFCeo9tZnieBBmnQ
         i8B1Bm7K+VMXzr0P7V+Vys3cSVvpHhu6mBLusA0cQTapY46JRL7+zjoxa8n9ngyCRSun
         Mcg6FRdVMJaUGF5uVB3+X2LUdszVnnOpONIXw3j6pagRedCXqVHRyh/aH8uDVMDX3fZS
         n/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+kPloqKO1KO25u/0GdWv0wKux8vVdRY/SXvc99NBLRA=;
        b=Klpz7EB5hLRQ2HAk9Xn2G5W9amk0y800p0IR4QuWs93MQmx5mqcwriuG/fBOiON/yS
         vd7RUDd3TfkG1YFcyI+IPGapRM4JEvKoAKg6ZFWzfNgfwL4me52FZFNI5Gor7o9w1Bzs
         5TC4IEZqmwNCss8tf4IOgPfLkx2kGHZv4wiswj5w+CuMzgU8ygz3QxQn5j8m4z1x5T8M
         SL2CSwqA8oPIbQNoWvzPvuaadwt5ZXodEj2FSVo537f1W41uhRWPfDQQrrDT2lzQ2j1m
         q34lKDSAn47vOq6fZJeKIneE67Nl7V2Nvlun14wCid1adHIla8mHvwbLkT1kCE5TcK47
         3+ow==
X-Gm-Message-State: AOAM530ZXf/V1hrlN4KZ5WsWj6mMxbPdccGjqZ0jMGYNZ3w95eQzwAv2
        ORIYlNKJ8PfEc+JwB70srFlDfPgCd/bqSywfkwdrGQ==
X-Google-Smtp-Source: ABdhPJyBLKLtjyIP0bLhi9jeap7QmUf7cWNL4xj+G/QpCPCri8NaT1rm5gKK5ZcoAIsyxY6dB9Ify7grO9yLJDIdjPc=
X-Received: by 2002:a05:6000:1a50:: with SMTP id t16mr1081375wry.571.1644022257448;
 Fri, 04 Feb 2022 16:50:57 -0800 (PST)
MIME-Version: 1.0
References: <20220204203248.2981902-1-frowand.list@gmail.com>
 <CABVgOS=JUxV6PRUZvTQhisSP+p34+K9Z6yT7HkXu6qeqtak1tw@mail.gmail.com> <f4317040-df10-02cb-90bb-59f993de1e41@gmail.com>
In-Reply-To: <f4317040-df10-02cb-90bb-59f993de1e41@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 5 Feb 2022 08:50:45 +0800
Message-ID: <CABVgOSm5A8TEa65H-D+LAF2Dm-J+T49FpAzgKP3Zxd7PQbfsLw@mail.gmail.com>
Subject: Re: [PATCH 1/1] Documentation: dev-tools: clarify KTAP specification wording
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, Rae Moar <rmoar@google.com>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Rae Moar <rmr167@gmail.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Daniel Latypov <dlatypov@google.com>, kernelci@groups.io,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Feb 5, 2022 at 8:18 AM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 2/4/22 5:13 PM, David Gow wrote:
> > On Sat, Feb 5, 2022 at 4:32 AM <frowand.list@gmail.com> wrote:
> >>
> >> From: Frank Rowand <frank.rowand@sony.com>
> >>
> >> Clarify some confusing phrasing.
> >
> > Thanks for this! A few comments below:
> >
> >>
> >> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> >> ---
> >>
> >> One item that may result in bikeshedding is that I added the spec
> >> version to the title line.
> >
> > This is fine by me.
> >
> >>
> >>  Documentation/dev-tools/ktap.rst | 12 ++++++------
> >>  1 file changed, 6 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
> >> index 878530cb9c27..3b7a26816930 100644
> >> --- a/Documentation/dev-tools/ktap.rst
> >> +++ b/Documentation/dev-tools/ktap.rst
> >> @@ -1,8 +1,8 @@
> >>  .. SPDX-License-Identifier: GPL-2.0
> >>
> >> -========================================
> >> -The Kernel Test Anything Protocol (KTAP)
> >> -========================================
> >> +===================================================
> >> +The Kernel Test Anything Protocol (KTAP), version 1
> >> +===================================================
> >>
> >>  TAP, or the Test Anything Protocol is a format for specifying test results used
> >>  by a number of projects. It's website and specification are found at this `link
> >> @@ -186,7 +186,7 @@ starting with another KTAP version line and test plan, and end with the overall
> >>  result. If one of the subtests fail, for example, the parent test should also
> >>  fail.
> >>
> >> -Additionally, all result lines in a subtest should be indented. One level of
> >> +Additionally, all lines in a subtest should be indented. One level of
> >
> > The original reason for this is to accommodate "unknown" lines which
> > were not generated by the test itself (e.g, a KASAN report or BUG or
> > something). These are awkward, as sometimes they're a useful thing to
> > have as part of the test result, and sometimes they're unrelated spam.
> > (Additionally, I think kselftest will indent these, as it indents the
> > full results in a separate pass afterwards, but KUnit won't, as the
> > level of nesting is done during printing.)
> >
> > Personally, I'd rather leave this as is, or perhaps call out "unknown"
> > lines explicitly, e.g:
> > Additionally, all lines in a subtest (except for 'unknown' lines)
> > should be indented...
>
> Only listing result lines as being indented is not consistent with
> the "Example KTAP output" section.  The example shows:
>
>    Version line           - indented
>    Plan line              - indented
>    Test case result lines - indented
>    Diagnostic lines       - indented
>    Unknown lines          - not shown in the example
>
> So there seem to be at least 4 types of lines that are indented for a
> nested test.

Agreed.

>
> The TAP standard (I'll use version 14 for my examples) does not allow
> unknown lines (TAP 14 calls them "Anything else").  It says "is
> incorrect", and "When the `pragma +strict` is enabled, incorrect test
> lines SHOULD result in the test set being a failure, ...".  TAP 14
> calls for the opposite behavior if `pragma -strict` is set.

Are you reading the same version 14 spec as me?

https://github.com/TestAnything/Specification/blob/tap-14-specification/specification.md

I can find these lines in the version 13 spec, but not TAP14, which
doesn't mention "Anything else" lines at all...

Not that it matters... I'll just follow along with version 13.

>
> TAP 14 goes on to say "`Test::Harness` silently ignores incorrect lines,
> but will become more stringent in the futures.
>
> It seems to me that KTAP "Unknown lines" are fundamentally different
> than TAP 14 "Anything else" lines.  Tests that generate KTAP output
> may print their results to the system console (or log), in which
> case kernel messages (or for the system log the messages may even
> come from non-kernel sources) either directly triggered by a test or
> from a task that is totally unrelated to the test may exist in the KTAP
> data stream.  So I would agree that "Unknown lines" are not indented.
> Even if the "Unknown line" is directly triggered by the test.

I do think that KTAP "unknown lines" and TAP "anything else" lines
cover similar ground, the big difference being that in KTAP they're
explicitly permitted, rather than "incorrect".  I guess how similar
they are is as much a matter of perspective as anything...

I'd agree that "unknown lines" don't _need_ to be indented, but I
wouldn't call it an error to indent them if that's something a test
harness does.

>
> But I think the KTAP specification should say that "Diagnostic lines"
> are emitted by the test (or the test harness), and thus must be
> indented when related to a nested test.
>
> And as you suggest, "Unknown lines" should be explicitly called out
> as not being part of "lines in a subtest", thus do not need to be
> indented.
>
> Does that sound good?
>

Agreed on both counts. Sounds great, thanks!

Cheers,
-- David

> >
> > Thoughts?
> >
> >>  indentation is two spaces: "  ". The indentation should begin at the version
> >>  line and should end before the parent test's result line.
> >>
> >> @@ -225,8 +225,8 @@ Major differences between TAP and KTAP
> >>  --------------------------------------
> >>
> >>  Note the major differences between the TAP and KTAP specification:
> >> -- yaml and json are not recommended in diagnostic messages
> >> -- TODO directive not recognized
> >> +- yaml and json are not recommended in KTAP diagnostic messages
> >> +- TODO directive not recognized in KTAP
> >>  - KTAP allows for an arbitrary number of tests to be nested
> >>
> >
> > Looks good here, cheers.
> >
> >
> >>  The TAP14 specification does permit nested tests, but instead of using another
> >> --
> >> Frank Rowand <frank.rowand@sony.com>
> >>
>
