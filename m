Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0FF46FA6D
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 06:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbhLJFeC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 00:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbhLJFeC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 00:34:02 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08025C0617A2
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Dec 2021 21:30:28 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id p2so14830695uad.11
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Dec 2021 21:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5hCKNhr+N3aRE4TeZ4dmNr8ley6v5C5wqgEQb4s30Q4=;
        b=iQgMOCSLz9SS4IWrk/FzfxExr2aIfeS9xN3EGvy6V/IjLF74Wri5xzn1RP9tZVerwJ
         Y++0yklmturORly0Whpx9RT0sSGI8AioobZDCyvguGtv1LnVNzmQ3Ub/wbKXQhBPKPN6
         X69XcWrVVh0DeKXiwNK87DG47zpMNxVMviSALK4NKThlsfGPrwAvopT8xKBAqJr3qtx5
         IYQLAeZI/1dnwO+ret222XKDPXg9VIq59N1cHPnGbmObsMWcGAzBNGa+X/2cyF2g10AU
         Ln7Ln9hD/y7t7mAx9VckuufMuhyYf0Ygte3Xnl02iP74wl5GHYTZQdFvEIrEH0Weix/2
         D3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5hCKNhr+N3aRE4TeZ4dmNr8ley6v5C5wqgEQb4s30Q4=;
        b=rFkXeP3ajLr7+jLBw9LSosKkSsp8cPaPu/BnTIwlmOfDdb4Hx4HV2uSDzF8Bkokoga
         dCOFXrL24L9mVufoXh3MYig1SZD7DIaHEbBaY0L7SRi1ZVsVCtDYhY8oIwaLC1L5SkfS
         bHR36H7Judg0jwuKcB1vxExOR8zQbnuIyN7mEQqxYoxJoc8uG9UTeQy3597NdHH3LlbY
         tZ8c/OgeX4SkezXwlBLIowZpcx+yFrgnOckksKsLYRamqI/kmV0ka/HhXfvNu8wXq5nc
         StSYDu1CEpojY3fUxtSKhMWPW+04t2PoySKF0HwwfLKbNnkZMTCP8yP6TvOO518HVYrV
         hZ2w==
X-Gm-Message-State: AOAM532xl0As+adbk1O1/eXznog933/AP7vWb/lfJDuXjGe0Jqvf2dLl
        MgpIKVMPk5n0yW9Gy1c4sNVDoQ3IZCdF17KiVoPvJAWrYSU=
X-Google-Smtp-Source: ABdhPJytWdpr+5GVixp3wbavdd65D/fumd/ljQzxELdll8T/RsGDDZvzAthQoPKemVhtyuJfY1ChjuTDc747jRXKO9Y=
X-Received: by 2002:a67:f84b:: with SMTP id b11mr14661114vsp.38.1639114226847;
 Thu, 09 Dec 2021 21:30:26 -0800 (PST)
MIME-Version: 1.0
References: <20211207054019.1455054-1-sharinder@google.com>
 <20211207054019.1455054-2-sharinder@google.com> <BYAPR13MB250396DFE4C15CF64C0834A7FD6E9@BYAPR13MB2503.namprd13.prod.outlook.com>
In-Reply-To: <BYAPR13MB250396DFE4C15CF64C0834A7FD6E9@BYAPR13MB2503.namprd13.prod.outlook.com>
From:   Harinder Singh <sharinder@google.com>
Date:   Fri, 10 Dec 2021 11:00:15 +0530
Message-ID: <CAHLZCaGwa3K2oMceQ4pcF1yHpeMjN+GvToYmffGQ8oK1CEF9kg@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] Documentation: KUnit: Rewrite main page
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

Thanks for your comments.

See my comments below.

On Tue, Dec 7, 2021 at 10:41 PM <Tim.Bird@sony.com> wrote:
>
> See one additional suggestion below.
>  -- Tim
>
>
> > -----Original Message-----
> > From: Harinder Singh <sharinder@google.com>
> >
> > Add a section on advantages of unit testing, how to write unit tests,
> > KUnit features and Prerequisites.
> >
> > Signed-off-by: Harinder Singh <sharinder@google.com>
> > ---
> >  Documentation/dev-tools/kunit/index.rst | 166 +++++++++++++-----------
> >  1 file changed, 88 insertions(+), 78 deletions(-)
> >
> > diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/de=
v-tools/kunit/index.rst
> > index cacb35ec658d..ebf4bffaa1ca 100644
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
> > @@ -16,82 +17,91 @@ KUnit - Unit Testing for the Linux Kernel
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
> > +This section details the kernel unit testing framework.
> > +
> > +Introduction
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +KUnit (Kernel unit testing framework) provides a common framework for
> > +unit tests within the Linux kernel. Using KUnit, you can define groups
> > +of test cases called test suites. The tests either run on kernel boot
> > +if built-in, or load as a module. KUnit automatically flags and report=
s
> > +failed test cases in the kernel log. The test results appear in `TAP
> > +(Test Anything Protocol) format <https://testanything.org/>`_. It is i=
nspired by
> > +JUnit, Python=E2=80=99s unittest.mock, and GoogleTest/GoogleMock (C++ =
unit testing
> > +framework).
> > +
> > +KUnit tests are part of the kernel, written in the C (programming)
> > +language, and test parts of the Kernel implementation (example: a C
> > +language function). Excluding build time, from invocation to
> > +completion, KUnit can run around 100 tests in less than 10 seconds.
> > +KUnit can test any kernel component, for example: file system, system
> > +calls, memory management, device drivers and so on.
> > +
> > +KUnit follows the white-box testing approach. The test has access to
> > +internal system functionality. KUnit runs in kernel space and is not
> > +restricted to things exposed to user-space.
> > +
> > +In addition, KUnit has kunit_tool, a script (``tools/testing/kunit/kun=
it.py``)
> > +that configures the Linux kernel, runs KUnit tests under QEMU or UML (=
`User Mode
> > +Linux <http://user-mode-linux.sourceforge.net/>`_), parses the test re=
sults and
> > +displays them in a user friendly manner.
> > +
> > +Features
> > +--------
> > +
> > +- Provides a framework for writing unit tests.
> > +- Runs tests on any kernel architecture.
> > +- Runs a test in milliseconds.
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
> > +A unit test tests a single unit of code in isolation. A unit test is t=
he finest
> > +granularity of testing and allows all possible code paths to be tested=
 in the
> > +code under test. This is possible if the code under test is small and =
does not
> > +have any external dependencies outside of the test's control like hard=
ware.
> > +
> > +
> > +Write Unit Tests
> > +----------------
> > +
> > +To write good unit tests, there is a simple but powerful pattern:
> > +Arrange-Act-Assert. This is a great way to structure test cases and
> > +defines an order of operations.
> > +
> > +- Arrange inputs and targets: At the start of the test, arrange the da=
ta
> > +  that allows a function to work. Example: initialize a statement or
> > +  object.
> > +- Act on the target behavior: Call your function/code under test.
> > +- Assert expected outcome: Verify the result (or resulting state) as e=
xpected
> > +  or not.
>
> Verify the result (or resulting state) as expected or not ->
>    Verify that the result (or resulting state) is as expected or not
>

Done

>
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
> > 2.34.1.400.ga245620fadb-goog
>

Regards,
Harinder Singh
