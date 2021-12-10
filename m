Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05A946FA71
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 06:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbhLJFek (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 00:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbhLJFei (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 00:34:38 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4537BC0617A1
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Dec 2021 21:31:04 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id o1so14904261uap.4
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Dec 2021 21:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5dnO6DoTldo672Bf4IZ/drE5RJPde5/hd0z5hMy6L28=;
        b=aCKX4nwQ/MXNNsNbWzOxyRBTFHk2DlkW9q6VLl5Gc0zvetOKzcDoCmDf4oFO79bWPF
         98G+X9VC6xAHklLkd4BeIbV/rHaO4NquWc3xyepuVSFOFzjEsk3woWPsa7SGUXIjGS6H
         0Mw5/K0pnGVFayRhCcdtG2geIzvoSbR1lsE8kROWbYfTen8pt5+/TmOHwbnLpw64ivia
         USQIu+usNPE89mFHbqCt9RcmDeXYWHZPBtUUXSINnS1w5R5T3r2MJgnvylKWVc8S+QtD
         vjN0/CIeD0tNxChY9vIL2B7UdwIbw9LrLPd09B57C1Dl/y9guiJgS0imQ6tlnxEmG/Py
         9gxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5dnO6DoTldo672Bf4IZ/drE5RJPde5/hd0z5hMy6L28=;
        b=YLMpB4H/yB02gXAQqUtUONbacXilYM+rN1x/slNogIaA5igzUpc9JHJ4GA7Bqojo65
         4OmvMHE/WOFOaFp/4ZRoeTaYHfgpziNeQ6WkwRAK7z6n7UbAeBLSwgI/MSVL5M7eEc+Y
         2gFRqw62sCWiDLUIEX2jiCQym253NoBEZeamlmkV2AC9D6KMW5+iHvPXNifsuXTi/TJ5
         54qmW9t/96NQX0dZQzGD0gHxCcbKgBpIxfz8wrlIWW2A0/xW2X/76lVNheJVk2SKKrjg
         3fxw3RMjGRYfajg1inhFhnK8Mh/WKHb5VWt39HcshHJXCJ8y+jBUcKc3qUks07JRPoSn
         xJxA==
X-Gm-Message-State: AOAM533RKlaeR80CCiTej94OR2c5pe78xyjuIS5rNiQGnEz4f3kc7TNh
        QrJjBpHE0X/dxHjvikk6iZTxTBHtRBCy8v87S+MM2g==
X-Google-Smtp-Source: ABdhPJzi3yDl30ztxkI28CVrQ1UOHAY9MibnEmrEH84NijnbK3dfnMnizRD2BbqexGQccLoo4Lk6HjpcpC7imFRPKeY=
X-Received: by 2002:a05:6102:a4a:: with SMTP id i10mr13549047vss.47.1639114262943;
 Thu, 09 Dec 2021 21:31:02 -0800 (PST)
MIME-Version: 1.0
References: <20211207054019.1455054-1-sharinder@google.com>
 <20211207054019.1455054-7-sharinder@google.com> <BYAPR13MB2503578CE24525BEABEEB325FD6E9@BYAPR13MB2503.namprd13.prod.outlook.com>
In-Reply-To: <BYAPR13MB2503578CE24525BEABEEB325FD6E9@BYAPR13MB2503.namprd13.prod.outlook.com>
From:   Harinder Singh <sharinder@google.com>
Date:   Fri, 10 Dec 2021 11:00:51 +0530
Message-ID: <CAHLZCaFbzuGoiFjY3jgaYORTtNdhNZh0ho=8EEfYOzEbQRX-Pg@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] Documentation: KUnit: Restyle Test Style and
 Nomenclature page
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

Thanks for the review comments.

Please see my comments below.

On Wed, Dec 8, 2021 at 12:16 AM <Tim.Bird@sony.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Harinder Singh <sharinder@google.com>
> >
> > Rewrite page to enhance content consistency.
> >
> > Signed-off-by: Harinder Singh <sharinder@google.com>
> > ---
> >  Documentation/dev-tools/kunit/style.rst | 101 ++++++++++++------------
> >  1 file changed, 49 insertions(+), 52 deletions(-)
> >
> > diff --git a/Documentation/dev-tools/kunit/style.rst b/Documentation/de=
v-tools/kunit/style.rst
> > index 8dbcdc552606..8fae192cae28 100644
> > --- a/Documentation/dev-tools/kunit/style.rst
> > +++ b/Documentation/dev-tools/kunit/style.rst
> > @@ -4,37 +4,36 @@
> >  Test Style and Nomenclature
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> >
> > -To make finding, writing, and using KUnit tests as simple as possible,=
 it's
> > +To make finding, writing, and using KUnit tests as simple as possible,=
 it is
> >  strongly encouraged that they are named and written according to the g=
uidelines
> > -below. While it's possible to write KUnit tests which do not follow th=
ese rules,
> > +below. While it is possible to write KUnit tests which do not follow t=
hese rules,
> >  they may break some tooling, may conflict with other tests, and may no=
t be run
> >  automatically by testing systems.
> >
> > -It's recommended that you only deviate from these guidelines when:
> > +It is recommended that you only deviate from these guidelines when:
> >
> > -1. Porting tests to KUnit which are already known with an existing nam=
e, or
> > -2. Writing tests which would cause serious problems if automatically r=
un (e.g.,
> > -   non-deterministically producing false positives or negatives, or ta=
king an
> > -   extremely long time to run).
> > +1. Porting tests to KUnit which are already known with an existing nam=
e.
> > +2. Writing tests which would cause serious problems if automatically r=
un. For
> > +   example, non-deterministically producing false positives or negativ=
es, or
> > +   taking a long time to run.
> >
> >  Subsystems, Suites, and Tests
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> >
> > -In order to make tests as easy to find as possible, they're grouped in=
to suites
> > -and subsystems. A test suite is a group of tests which test a related =
area of
> > -the kernel, and a subsystem is a set of test suites which test differe=
nt parts
> > -of the same kernel subsystem or driver.
> > +To make tests easy to find, they are grouped into suites and subsystem=
s. A test
> > +suite is a group of tests which test a related area of the kernel. A s=
ubsystem
> > +is a set of test suites which test different parts of a kernel subsyst=
em
> > +or a driver.
> >
> >  Subsystems
> >  ----------
> >
> >  Every test suite must belong to a subsystem. A subsystem is a collecti=
on of one
> >  or more KUnit test suites which test the same driver or part of the ke=
rnel. A
> > -rule of thumb is that a test subsystem should match a single kernel mo=
dule. If
> > -the code being tested can't be compiled as a module, in many cases the=
 subsystem
> > -should correspond to a directory in the source tree or an entry in the
> > -MAINTAINERS file. If unsure, follow the conventions set by tests in si=
milar
> > -areas.
> > +test subsystem should match a single kernel module. If the code being =
tested
> > +cannot be compiled as a module, in many cases the subsystem should cor=
respond to
> > +a directory in the source tree or an entry in the ``MAINTAINERS`` file=
. If
> > +unsure, follow the conventions set by tests in similar areas.
> >
> >  Test subsystems should be named after the code being tested, either af=
ter the
> >  module (wherever possible), or after the directory or files being test=
ed. Test
> > @@ -42,9 +41,8 @@ subsystems should be named to avoid ambiguity where n=
ecessary.
> >
> >  If a test subsystem name has multiple components, they should be separ=
ated by
> >  underscores. *Do not* include "test" or "kunit" directly in the subsys=
tem name
> > -unless you are actually testing other tests or the kunit framework its=
elf.
> > -
> > -Example subsystems could be:
> > +unless we are actually testing other tests or the kunit framework itse=
lf. For
> > +example, subsystems could be called:
> >
> >  ``ext4``
> >    Matches the module and filesystem name.
> > @@ -56,13 +54,13 @@ Example subsystems could be:
> >    Has several components (``snd``, ``hda``, ``codec``, ``hdmi``) separ=
ated by
> >    underscores. Matches the module name.
> >
> > -Avoid names like these:
> > +Avoid names as shown in examples below:
> >
> >  ``linear-ranges``
> >    Names should use underscores, not dashes, to separate words. Prefer
> >    ``linear_ranges``.
> >  ``qos-kunit-test``
> > -  As well as using underscores, this name should not have "kunit-test"=
 as a
> > +  This name should not use underscores, not have "kunit-test" as a
>
> This contradicts the preceding sentence.  I believe you have changed the =
sense
> of the recommendation.
>
> This name should not use underscores, not have ->
>    This name should use underscores, and not have
>

Done

> >    suffix, and ``qos`` is ambiguous as a subsystem name. ``power_qos`` =
would be a
>
> suffix, and ``qos`` -> suffix.  Also ``qos``
>
> (The way this sentence was originally structured was quite awkward.  I th=
ink it's
> better to split into two sentences)
>

Done

> >    better name.
> >  ``pc_parallel_port``
> > @@ -70,34 +68,32 @@ Avoid names like these:
> >    be named ``parport_pc``.
> >
> >  .. note::
> > -        The KUnit API and tools do not explicitly know about subsystem=
s. They're
> > -        simply a way of categorising test suites and naming modules wh=
ich
> > -        provides a simple, consistent way for humans to find and run t=
ests. This
> > -        may change in the future, though.
> > +        The KUnit API and tools do not explicitly know about subsystem=
s. They are
> > +        a way of categorising test suites and naming modules which pro=
vides a
> > +        simple, consistent way for humans to find and run tests. This =
may change
> > +        in the future.
> >
> >  Suites
> >  ------
> >
> >  KUnit tests are grouped into test suites, which cover a specific area =
of
> >  functionality being tested. Test suites can have shared initialisation=
 and
>
> 'initialization' seems to be preferred to 'initialisation' in most other
> kernel documentation.  (557 instances of 'initialization' to 58 of 'initi=
alisation')
>
> (I know this isn't part of your patch, but since this is a cleanup and co=
nsistency
> patch, maybe change this as well?)
>

Done

> > -shutdown code which is run for all tests in the suite.
> > -Not all subsystems will need to be split into multiple test suites (e.=
g. simple drivers).
> > +shutdown code which is run for all tests in the suite. Not all subsyst=
ems need
> > +to be split into multiple test suites (for example, simple drivers).
> >
> >  Test suites are named after the subsystem they are part of. If a subsy=
stem
> >  contains several suites, the specific area under test should be append=
ed to the
> >  subsystem name, separated by an underscore.
> >
> >  In the event that there are multiple types of test using KUnit within =
a
> > -subsystem (e.g., both unit tests and integration tests), they should b=
e put into
> > -separate suites, with the type of test as the last element in the suit=
e name.
> > -Unless these tests are actually present, avoid using ``_test``, ``_uni=
ttest`` or
> > -similar in the suite name.
> > +subsystem (for example, both unit tests and integration tests), they s=
hould be
> > +put into separate suites, with the type of test as the last element in=
 the suite
> > +name. Unless these tests are actually present, avoid using ``_test``, =
``_unittest``
> > +or similar in the suite name.
> >
> >  The full test suite name (including the subsystem name) should be spec=
ified as
> >  the ``.name`` member of the ``kunit_suite`` struct, and forms the base=
 for the
> > -module name (see below).
> > -
> > -Example test suites could include:
> > +module name. For example, test suites could include:
> >
> >  ``ext4_inode``
> >    Part of the ``ext4`` subsystem, testing the ``inode`` area.
> > @@ -109,26 +105,27 @@ Example test suites could include:
> >    The ``kasan`` subsystem has only one suite, so the suite name is the=
 same as
> >    the subsystem name.
> >
> > -Avoid names like:
> > +Avoid names, for example:
> >
> >  ``ext4_ext4_inode``
> > -  There's no reason to state the subsystem twice.
> > +  There is no reason to state the subsystem twice.
> >  ``property_entry``
> >    The suite name is ambiguous without the subsystem name.
> >  ``kasan_integration_test``
> >    Because there is only one suite in the ``kasan`` subsystem, the suit=
e should
> > -  just be called ``kasan``. There's no need to redundantly add
> > -  ``integration_test``. Should a separate test suite with, for example=
, unit
> > -  tests be added, then that suite could be named ``kasan_unittest`` or=
 similar.
> > +  just be called as ``kasan``. Do not redundantly add
> > +  ``integration_test``. It should be a separate test suite. For exampl=
e, if the
> > +  unit tests are added, then that suite could be named as ``kasan_unit=
test`` or
> > +  similar.
> >
> >  Test Cases
> >  ----------
> >
> >  Individual tests consist of a single function which tests a constraine=
d
> > -codepath, property, or function. In the test output, individual tests'=
 results
> > -will show up as subtests of the suite's results.
> > +codepath, property, or function. In the test output, an individual tes=
t's
> > +results will show up as subtests of the suite's results.
> >
> > -Tests should be named after what they're testing. This is often the na=
me of the
> > +Tests should be named after what they are testing. This is often the n=
ame of the
> >  function being tested, with a description of the input or codepath bei=
ng tested.
> >  As tests are C functions, they should be named and written in accordan=
ce with
> >  the kernel coding style.
> > @@ -136,7 +133,7 @@ the kernel coding style.
> >  .. note::
> >          As tests are themselves functions, their names cannot conflict=
 with
> >          other C identifiers in the kernel. This may require some creat=
ive
> > -        naming. It's a good idea to make your test functions `static` =
to avoid
> > +        naming. It is a good idea to make your test functions `static`=
 to avoid
> >          polluting the global namespace.
> >
> >  Example test names include:
> > @@ -150,7 +147,7 @@ Example test names include:
> >
> >  Should it be necessary to refer to a test outside the context of its t=
est suite,
> >  the *fully-qualified* name of a test should be the suite name followed=
 by the
> > -test name, separated by a colon (i.e. ``suite:test``).
> > +test name, separated by a colon (``suite:test``).
>
> Please leave the 'i.e.'
>

Done

> >
> >  Test Kconfig Entries
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > @@ -162,16 +159,16 @@ This Kconfig entry must:
> >  * be named ``CONFIG_<name>_KUNIT_TEST``: where <name> is the name of t=
he test
> >    suite.
> >  * be listed either alongside the config entries for the driver/subsyst=
em being
> > -  tested, or be under [Kernel Hacking]=E2=86=92[Kernel Testing and Cov=
erage]
> > -* depend on ``CONFIG_KUNIT``
> > +  tested, or be under [Kernel Hacking]->[Kernel Testing and Coverage]
> > +* depend on ``CONFIG_KUNIT``.
> >  * be visible only if ``CONFIG_KUNIT_ALL_TESTS`` is not enabled.
> >  * have a default value of ``CONFIG_KUNIT_ALL_TESTS``.
> > -* have a brief description of KUnit in the help text
> > +* have a brief description of KUnit in the help text.
> >
> > -Unless there's a specific reason not to (e.g. the test is unable to be=
 built as
> > -a module), Kconfig entries for tests should be tristate.
> > +If we are not able to meet above conditions (for example, the test is =
unable to
> > +be built as a module), Kconfig entries for tests should be tristate.
> >
> > -An example Kconfig entry:
> > +For example, a Kconfig entry might look like:
> >
> >  .. code-block:: none
> >
> > @@ -182,8 +179,8 @@ An example Kconfig entry:
> >               help
> >                 This builds unit tests for foo.
> >
> > -               For more information on KUnit and unit tests in general=
, please refer
> > -               to the KUnit documentation in Documentation/dev-tools/k=
unit/.
> > +               For more information on KUnit and unit tests in general=
,
> > +               please refer to the KUnit documentation in Documentatio=
n/dev-tools/kunit/.
> >
> >                 If unsure, say N.
> >
> > --
> > 2.34.1.400.ga245620fadb-goog
>
> Thanks for the cleanups.
>  -- Tim
>

Regards,
Harinder Singh
