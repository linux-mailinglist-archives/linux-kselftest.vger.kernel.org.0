Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226E246B296
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Dec 2021 06:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhLGFtt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Dec 2021 00:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbhLGFtp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Dec 2021 00:49:45 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7C2C061359
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Dec 2021 21:46:15 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id t13so24305681uad.9
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Dec 2021 21:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0x6oYYrviWBofrqgS9OoLqmV9EK0W9oBz7Z4W3jJ5Es=;
        b=jpk9DqfZJxv+/kjCDAjLzo21cJ+lZV6LTLafyrrDfVbObAVuhC5pEzY/xESknv3Tql
         M5ysJDm5yWDdKXNIia3UZwFIKSzCk2jtMn7k05LGJK7o33Lt20TmRm0h7uWtC+PaXT3X
         SBFqMVb0QLjYlZYisbldJ4W3U1VU6tYQtf8n2alH2mdN0qSUPAov7NmLW5v2nsElNFtS
         tb+607YuZEoNTGB7crdJU3bamNJOwDuScVZBYzreg4a1zYfxwCpYuIdFiPdhs6CTxR//
         OjyKS0+/m50otkiefcYyJ1CJQXVtqa3oyVW2HmdwQgDp4qNdHe70DQZUR5RnmnrWt/CF
         B68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0x6oYYrviWBofrqgS9OoLqmV9EK0W9oBz7Z4W3jJ5Es=;
        b=rD2G8DR5VNJ2UZ5DSw1A7GGxGMVxVph1LdEGQ0OQbEIJSxcHvOovAR3a3wK5su1OXJ
         S+DeDgxx3OG2yS0giuJkoUHFSbCutqvowQWo62hbuhjJsWngU8HrxCF2wuS9uiB49zar
         /fMfBCmcqhkr9iQuXEXtDZhw7idg8dh2CCU9YJU6S+xNrrkiLFwYNhbIXKbHHCqWmAZ9
         2fmzvD0cZ9khTlQuz1wlpE0+7K8ABtzF62cJIdrZZXC5bQ8VtsdSBQC1SoIvMUDNnDoY
         B6EtlnrgRqf8rDTKWCWpgD+3BQWRhCoA8WxtXugogz0btXFlZNozGhkxbS9Elt1gkz/d
         l42w==
X-Gm-Message-State: AOAM533DqaNMjFvlE8x1BxESWRInALYM68dsPpS539rw+wNK5NSLGII5
        zFZjWbrnnvIQYjI3HEBIcEaVBWZn+CpRpFBPOdaOQA==
X-Google-Smtp-Source: ABdhPJzs/m/H8K7Iaw3ZVhcEQnuV65Ix2pKfwFm1IlLLbgJed33yGFKx8DyvURgiWhXiGsVsiHxkfqqKuGMkDJ/BXGg=
X-Received: by 2002:a67:c402:: with SMTP id c2mr42509850vsk.53.1638855974127;
 Mon, 06 Dec 2021 21:46:14 -0800 (PST)
MIME-Version: 1.0
References: <20211203042437.740255-1-sharinder@google.com> <20211203042437.740255-2-sharinder@google.com>
 <BYAPR13MB2503D1D29303C11E2135ED44FD6A9@BYAPR13MB2503.namprd13.prod.outlook.com>
In-Reply-To: <BYAPR13MB2503D1D29303C11E2135ED44FD6A9@BYAPR13MB2503.namprd13.prod.outlook.com>
From:   Harinder Singh <sharinder@google.com>
Date:   Tue, 7 Dec 2021 11:16:03 +0530
Message-ID: <CAHLZCaHKxLK=ohJcjW04FTyzpMys79JGRYV=yBkQ5HQpLRgiKQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] Documentation: KUnit: Rewrite main page
To:     tim.bird@sony.com
Cc:     davidgow@google.com, brendanhiggins@google.com, shuah@kernel.org,
        corbet@lwn.net, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Tim,

Thanks for your suggestions.

I have incorporated your changes  on v2 here:
https://lore.kernel.org/linux-kselftest/20211207054019.1455054-1-sharinder@=
google.com/T/

See comments below.

On Fri, Dec 3, 2021 at 11:02 PM <Tim.Bird@sony.com> wrote:
>
> Here are some suggestions inline below.
>
> > -----Original Message-----
> > From: Harinder Singh <sharinder@google.com>
> > Sent: Thursday, December 2, 2021 9:25 PM
> > To: davidgow@google.com; brendanhiggins@google.com; shuah@kernel.org; c=
orbet@lwn.net
> > Cc: linux-kselftest@vger.kernel.org; kunit-dev@googlegroups.com; linux-=
doc@vger.kernel.org; linux-kernel@vger.kernel.org; Harinder
> > Singh <sharinder@google.com>
> > Subject: [PATCH v1 1/7] Documentation: KUnit: Rewrite main page
> >
> > Add a section on advantages of unit testing, how to write unit tests,
> > KUnit features and Prerequisites.
> >
> > Signed-off-by: Harinder Singh <sharinder@google.com>
> > ---
> >  Documentation/dev-tools/kunit/index.rst | 159 ++++++++++++------------
> >  1 file changed, 81 insertions(+), 78 deletions(-)
> >
> > diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/de=
v-tools/kunit/index.rst
> > index cacb35ec658d..2ddd01d62406 100644
> > --- a/Documentation/dev-tools/kunit/index.rst
> > +++ b/Documentation/dev-tools/kunit/index.rst
> > @@ -1,11 +1,12 @@
> >  .. SPDX-License-Identifier: GPL-2.0
> >
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > -KUnit - Unit Testing for the Linux Kernel
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +KUnit - Linux Kernel Unit Testing
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >  .. toctree::
> >       :maxdepth: 2
> > +     :caption: Contents:
> >
> >       start
> >       usage
> > @@ -16,82 +17,84 @@ KUnit - Unit Testing for the Linux Kernel
> >       tips
> >       running_tips
> >
> > -What is KUnit?
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > -
> > -KUnit is a lightweight unit testing and mocking framework for the Linu=
x kernel.
> > -
> > -KUnit is heavily inspired by JUnit, Python's unittest.mock, and
> > -Googletest/Googlemock for C++. KUnit provides facilities for defining =
unit test
> > -cases, grouping related test cases into test suites, providing common
> > -infrastructure for running tests, and much more.
> > -
> > -KUnit consists of a kernel component, which provides a set of macros f=
or easily
> > -writing unit tests. Tests written against KUnit will run on kernel boo=
t if
> > -built-in, or when loaded if built as a module. These tests write out r=
esults to
> > -the kernel log in `TAP <https://testanything.org/>`_ format.
> > -
> > -To make running these tests (and reading the results) easier, KUnit of=
fers
> > -:doc:`kunit_tool <kunit-tool>`, which builds a `User Mode Linux
> > -<http://user-mode-linux.sourceforge.net>`_ kernel, runs it, and parses=
 the test
> > -results. This provides a quick way of running KUnit tests during devel=
opment,
> > -without requiring a virtual machine or separate hardware.
> This introduction to kunit_tool it not present elsewhere in this patch.
> Are you sure we want to drop this?

Thanks!
This section was a bit outdated, so I added an updated version.

>
> > -
> > -Get started now: Documentation/dev-tools/kunit/start.rst
> > -
> > -Why KUnit?
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > -
> > -A unit test is supposed to test a single unit of code in isolation, he=
nce the
> > -name. A unit test should be the finest granularity of testing and as s=
uch should
> > -allow all possible code paths to be tested in the code under test; thi=
s is only
> > -possible if the code under test is very small and does not have any ex=
ternal
> > -dependencies outside of the test's control like hardware.
>
> The patch just drops these ideas.  I don't think It should.

Restored and reworded the original paragraph to replace the
description of unit testing.

>
> > -
> > -KUnit provides a common framework for unit tests within the kernel.
> > -
> > -KUnit tests can be run on most architectures, and most tests are archi=
tecture
> > -independent. All built-in KUnit tests run on kernel startup.  Alternat=
ively,
> > -KUnit and KUnit tests can be built as modules and tests will run when =
the test
> > -module is loaded.
> > -
> > -.. note::
> > -
> > -        KUnit can also run tests without needing a virtual machine or =
actual
> > -        hardware under User Mode Linux. User Mode Linux is a Linux arc=
hitecture,
> > -        like ARM or x86, which compiles the kernel as a Linux executab=
le. KUnit
> > -        can be used with UML either by building with ``ARCH=3Dum`` (li=
ke any other
> > -        architecture), or by using :doc:`kunit_tool <kunit-tool>`.
>
> You don't replace this note about using kunit with UML with anything.  Wh=
y?
> Is using UML deprecated or something?  Is this note incorrect or misleadi=
ng?

We do not want to suggest that using UML is the only way of running
KUnit. The next version includes brief information about KUnit with
UML. More details about using UML are described in subsequent pages.

> > -
> > -KUnit is fast. Excluding build time, from invocation to completion KUn=
it can run
> > -several dozen tests in only 10 to 20 seconds; this might not sound lik=
e a big
> > -deal to some people, but having such fast and easy to run tests fundam=
entally
> > -changes the way you go about testing and even writing code in the firs=
t place.
> > -Linus himself said in his `git talk at Google
> > -<https://gist.github.com/lorn/1272686/revisions#diff-53c65572127855f1b=
003db4064a94573R874>`_:
> > -
> > -     "... a lot of people seem to think that performance is about doin=
g the
> > -     same thing, just doing it faster, and that is not true. That is n=
ot what
> > -     performance is all about. If you can do something really fast, re=
ally
> > -     well, people will start using it differently."
> > -
> > -In this context Linus was talking about branching and merging,
> > -but this point also applies to testing. If your tests are slow, unreli=
able, are
> > -difficult to write, and require a special setup or special hardware to=
 run,
> > -then you wait a lot longer to write tests, and you wait a lot longer t=
o run
> > -tests; this means that tests are likely to break, unlikely to test a l=
ot of
> > -things, and are unlikely to be rerun once they pass. If your tests are=
 really
> > -fast, you run them all the time, every time you make a change, and eve=
ry time
> > -someone sends you some code. Why trust that someone ran all their test=
s
> > -correctly on every change when you can just run them yourself in less =
time than
> > -it takes to read their test log?
>
> This whole section about speed changing the nature of the activity
> is dropped.  Is that intentional?

We want readers to focus on the "how" of KUnit compared to "why" KUnit
exists. We feel this is now sufficiently justified and this paragraph
is no longer required.

> > +This section details the kernel unit testing framework.
> > +
> > +Introduction
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +KUnit (Kernel unit testing framework) prvoides a common framework for
>
> prvoides -> provides

Fixed

> > +unit tests within the Linux kernel. Using KUnit, you can define groups
> > +of test cases called test suites. The tests either run on kernel boot
> > +if built-in, or load as a module. KUnit automatically flags and report=
s
> > +failed test cases in the kernel log. The test results appear in TAP
> > +(Test Anything Protocol) format. It is inspired by JUnit, Python=E2=80=
=99s
>
> You lost the link to the TAP website here.  You should
> have something like this link in here somewhere.
> `TAP <https://testanything.org/>`_

Done

> > +unittest.mock, and GoogleTest/GoogleMock (C++ unit testing framework).
> > +
> > +KUnit tests are part of the kernel, written in the C (programming)
> > +language, and test parts of the Kernel implementation (example: a C
> > +language function). Excluding build time, from invocation to
> > +completion, KUnit can run around 100 tests in less than 10 seconds.
> > +KUnit can test all kernel components, example: file system, system
>
> all kernel components, example -> any kernel component, for example

Done

> > +calls, memory management, device drivers and so on.
> > +
> > +KUnit follows the white-box testing approach. The test has access to
> > +internal system functionality. KUnit runs in kernel space and is not
> > +restricted to things exposed to user-space.
> > +
> > +Features
> > +--------
> > +
> > +- Perform unit tests.
>
> Perform -> Performs

Replaced this with "Provides a framework for writing unit tests".

> > +- Run tests on any kernel architecture.
> Run tests -> Runs tests

Done

> > +- Runs test in milliseconds.
> Runs test -> Runs a test

Done

> > +
> > +Prerequisites
> > +-------------
> > +
> > +- Any Linux kernel compatible hardware.
> > +- For Kernel under test, Linux kernel version 5.5 or greater.
> > +
> > +Unit Testing
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +A unit test verifies a single code unit. For example: a function or
>
> code unit. For example: a function -> code unit - for example a function

Replaced the whole paragraph.

> > +codepath. The test executes a single test method multiple times with
>
> The test executes -> The test commonly executes

Replaced the whole paragraph.

> > +different parameters. It is recommended to run unit test
> > +independently of any other unit test or code.
>
> It is recommended to run unit test ->
>   It is recommended to structure a unit test so that it can run

Replaced the whole paragraph.

> > +
> > +Write Unit Tests
> > +----------------
> > +
> > +To write good unit tests, there is a simple but powerful pattern:
> > +Arrange-Act-Asert. This is a great way to structure test cases and
> Asert -> Assert

Done

> > +defines an order of operations.
> > +
> > +- Arrange inputs and targets: At the start of the test, arrange the da=
ta
> > +  that allows a function to work. Example: initialize a statement or
> > +  object.
> > +- Act on the target behavior: Call your function/code under test.
> > +- Assert expected outcome: Verify the initial state and result as
> > +  expected or not.
>
> I don't know what "Verify the initial state" means.
>
> Verify the initial state and result as expected or not ->
>    Verify whether the result (or resulting state) is as expected or not.

Done


> > +
> > +Unit Testing Advantages
> > +-----------------------
> > +
> > +- Increases testing speed and development in the long run.
> > +- Detects bugs at initial stage and therefore decreases bug fix cost
> > +  compared to acceptance testing.
> > +- Improves code quality.
> > +- Encourages writing testable code.
> >
> >  How do I use it?
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > -*   Documentation/dev-tools/kunit/start.rst - for new users of KUnit
> > -*   Documentation/dev-tools/kunit/tips.rst - for short examples of bes=
t practices
> > -*   Documentation/dev-tools/kunit/usage.rst - for a more detailed expl=
anation of KUnit features
> > -*   Documentation/dev-tools/kunit/api/index.rst - for the list of KUni=
t APIs used for testing
> > -*   Documentation/dev-tools/kunit/kunit-tool.rst - for more informatio=
n on the kunit_tool helper script
> > -*   Documentation/dev-tools/kunit/faq.rst - for answers to some common=
 questions about KUnit
> > +*   Documentation/dev-tools/kunit/start.rst - for KUnit new users.
> > +*   Documentation/dev-tools/kunit/usage.rst - KUnit features.
> > +*   Documentation/dev-tools/kunit/tips.rst - best practices with
> > +    examples.
> > +*   Documentation/dev-tools/kunit/api/index.rst - KUnit APIs
> > +    used for testing.
> > +*   Documentation/dev-tools/kunit/kunit-tool.rst - kunit_tool helper
> > +    script.
> > +*   Documentation/dev-tools/kunit/faq.rst - KUnit common questions and
> > +    answers.
> > --
> > 2.34.0.384.gca35af8252-goog
>

Regards,
Harinder Singh
