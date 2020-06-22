Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8782042BE
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jun 2020 23:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbgFVVdS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Jun 2020 17:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730594AbgFVVdR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Jun 2020 17:33:17 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5BDC061796
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Jun 2020 14:33:17 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x207so9010109pfc.5
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Jun 2020 14:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=48FKT2aNWMCF7CnKbQrKlzmt9BG2SQkryuha/wRgHcU=;
        b=VmiajD07pDP5KDQbZ3QiMj0D7fvgmF7J9dUgGw4/Z6unPCcSGSusWg6ohdomzmxmI3
         eRuyd0vbRPT2EQpDxIjpTwFqfF64NxhmvV7bKkwPP02I4FE3uNvwp35LX7rFGtb2rwoZ
         BsYJA45tDwD7hi7TNIYukJGtXsBlIZ1+YHBF0YSeGSrsjrcRooOwW6ZONbujKIy6Le9S
         8eeqzyEMHc6H9gkOrZHFsHvdJJEHwspka5F3arDEeTuKWE/7J1+/n1d0PuR9lKVMvulB
         6RvrFt5ukQdhht2wH8IXYfYMIFJ8mNhIbmy6pyoICNqqEnuDSRbLAw79a0GxaHeGVOex
         zNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=48FKT2aNWMCF7CnKbQrKlzmt9BG2SQkryuha/wRgHcU=;
        b=QEP2rRAW1hxVp7NLa3Lqsog9b6z50WeZKwJtXtBFjb5MlrRzrsuv3xTcckZCtBM+Cg
         gnKQQCB34xaOfUgPsHpWnITGthe3N+l6IMAwOXymEg6Gf8MyZo30jjzmJ77R5p3MN992
         vJ2idi59xrJaKPz64DWOck2Wwuo1zJ6R/Jh/tgQcoorvolZE2unwchFwSfJXkJxtVicF
         5mGL25/bHSl2swOxwjHoG3rK74nJOz/dbVYVwjLbaKEiz7ViYX/2AUXP7U9nDnvPbKuM
         2EOV58jg7fF0CBuslG6WVZLf+bKT0DgeaVoDbFGDC4NpbzzQCME0xU0HvFJCWkEqqN1Q
         /fvw==
X-Gm-Message-State: AOAM533Q1mWtArSWDc24WHKnnLPuPAx/JcfRHD05ppae/j2tXZOTZMBh
        Qt8uHoHpEO3NlxUaAILY33W6Or4GZd8VaEeITI4qHA==
X-Google-Smtp-Source: ABdhPJwhDlpWz0+PUiWIW28s6ahSX1TxyWf94XwDdj1zzNw6tcGSacG5OaH+oulNadzX/yULBfSnKEFDPP63CcyRSVM=
X-Received: by 2002:a63:6e0e:: with SMTP id j14mr1129571pgc.384.1592861596328;
 Mon, 22 Jun 2020 14:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200620054944.167330-1-davidgow@google.com>
In-Reply-To: <20200620054944.167330-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 22 Jun 2020 14:33:05 -0700
Message-ID: <CAFd5g45PFE2nUWhs0RW=-sqk+fUqFxTnjOwbHZh=0LKx=1DdAA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: Add naming guidelines
To:     David Gow <davidgow@google.com>, "Theodore Ts'o" <tytso@mit.edu>,
        "Bird, Timothy" <Tim.Bird@sony.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

I imagine +Theodore Ts'o might have some thoughts on this.

+Bird, Timothy - Figured you might be interested since I think this
might pertain to the KTAP discussion.

On Fri, Jun 19, 2020 at 10:50 PM David Gow <davidgow@google.com> wrote:
>
> As discussed in [1], KUnit tests have hitherto not had a particularly
> consistent naming scheme. This adds documentation outlining how tests
> and test suites should be named, including how those names should be
> used in Kconfig entries and filenames.
>
> [1]:
> https://lore.kernel.org/linux-kselftest/202006141005.BA19A9D3@keescook/t/=
#u
>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
> This is a first draft of some naming guidelines for KUnit tests. Note
> that I haven't edited it for spelling/grammar/style yet: I wanted to get
> some feedback on the actual naming conventions first.
>
> The issues which came most to the forefront while writing it were:
> - Do we want to make subsystems a more explicit thing (make the KUnit
>   framework recognise them, make suites KTAP subtests of them, etc)
>   - I'm leaning towards no, mainly because it doesn't seem necessary,
>     and it makes the subsystem-with-only-one-suite case ugly.
>
> - Do we want to support (or encourage) Kconfig options and/or modules at
>   the subsystem level rather than the suite level?
>   - This could be nice: it'd avoid the proliferation of a large number
>     of tiny config options and modules, and would encourage the test for
>     <module> to be <module>_kunit, without other stuff in-between.
>
> - As test names are also function names, it may actually make sense to
>   decorate them with "test" or "kunit" or the like.
>   - If we're testing a function "foo", "test_foo" seems like as good a
>     name for the function as any. Sure, many cases may could have better
>     names like "foo_invalid_context" or something, but that won't make
>     sense for everything.
>   - Alternatively, do we split up the test name and the name of the
>     function implementing the test?
>
> Thoughts?

Overall it looks pretty good. I would like to see some examples
fleshed out a bit more or at least say how things like subsystem names
are used, but otherwise this looks good to me.

>  Documentation/dev-tools/kunit/index.rst |   1 +
>  Documentation/dev-tools/kunit/style.rst | 139 ++++++++++++++++++++++++
>  2 files changed, 140 insertions(+)
>  create mode 100644 Documentation/dev-tools/kunit/style.rst
>
> diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-=
tools/kunit/index.rst
> index e93606ecfb01..117c88856fb3 100644
> --- a/Documentation/dev-tools/kunit/index.rst
> +++ b/Documentation/dev-tools/kunit/index.rst
> @@ -11,6 +11,7 @@ KUnit - Unit Testing for the Linux Kernel
>         usage
>         kunit-tool
>         api/index
> +        style
>         faq
>
>  What is KUnit?
> diff --git a/Documentation/dev-tools/kunit/style.rst b/Documentation/dev-=
tools/kunit/style.rst
> new file mode 100644
> index 000000000000..9363b5607262
> --- /dev/null
> +++ b/Documentation/dev-tools/kunit/style.rst
> @@ -0,0 +1,139 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +Test Style and Nomenclature
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
> +Subsystems, Suites, and Tests
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +
> +In order to make tests as easy to find as possible, they're grouped into=
 suites
> +and subsystems. A test suite is a group of tests which test a related ar=
ea of
> +the kernel, and a subsystem is a set of test suites which test different=
 parts
> +of the same kernel subsystem or driver.
> +
> +Subsystems
> +----------
> +
> +Every test suite must belong to a subsystem. A subsystem is a collection=
 of one
> +or more KUnit test suites which test the same driver or part of the kern=
el. A
> +rule of thumb is that a test subsystem should match a single kernel modu=
le. If
> +the code being tested can't be compiled as a module, in many cases the s=
ubsystem
> +should correspond to a directory in the source tree or an entry in the
> +MAINTAINERS file. If unsure, follow the conventions set by tests in simi=
lar
> +areas.
> +
> +Test subsystems should be named after the code being tested, either afte=
r the
> +module (wherever possible), or after the directory or files being tested=
. Test
> +subsystems should be named to avoid ambiguity where necessary.
> +
> +If a test subsystem name has multiple components, they should be separat=
ed by
> +underscores. Do not include "test" or "kunit" directly in the subsystem =
name

nit: Embolden "Do not".

> +unless you are actually testing other tests or the kunit framework itsel=
f.
> +
> +Example subsystems could be:
> +
> +* ``ext4``
> +* ``apparmor``
> +* ``kasan``

Maybe add some examples that exercise the "multiple components ...
separated by underscores". Some negative examples might also be good
since we currently violate this rule.

> +.. note::
> +        The KUnit API and tools do not explicitly know about subsystems.=
 They're
> +        simply a way of categorising test suites and naming modules whic=
h
> +        provides a simple, consistent way for humans to find and run tes=
ts. This
> +        may change in the future, though.

I think we should have some way to enshrine this in KUnit, if not via
code, I think we should at least say how the convention is used.

> +Suites
> +------
> +
> +KUnit tests are grouped into test suites, which cover a specific area of
> +functionality being tested. Test suites can have shared initialisation a=
nd
> +shutdown code which is run for all tests in the suite.
> +Not all subsystems will need to be split into multiple test suites (e.g.=
 simple drivers).
> +
> +Test suites are named after the subsystem they are part of. If a subsyst=
em
> +contains several suites, the specific area under test should be appended=
 to the
> +subsystem name, separated by an underscore.
> +
> +The full test suite name (including the subsystem name) should be specif=
ied as
> +the ``.name`` member of the ``kunit_suite`` struct, and forms the base f=
or the
> +module name (see below).
> +
> +Example test suites could include:
> +
> +* ``ext4_inode``
> +* ``kunit_try_catch``
> +* ``apparmor_property_entry``
> +* ``kasan``
> +
> +Tests

nit: "Test Cases".

> +-----
> +
> +Individual tests consist of a single function which tests a constrained
> +codepath, property, or function. In the test output, individual tests' r=
esults
> +will show up as subtests of the suite's results.
> +
> +Tests should be named after what they're testing. This is often the name=
 of the
> +function being tested, with a description of the input or codepath being=
 tested.
> +As tests are C functions, they should be named and written in accordance=
 with
> +the kernel coding style.

Can you add an example?

> +.. note::
> +        As tests are themselves functions, their names cannot conflict w=
ith
> +        other C identifiers in the kernel. This may require some creativ=
e
> +        naming. It's a good idea to make your test functions `static` to=
 avoid
> +        polluting the global namespace.
> +
> +Should it be necessary to refer to a test outside the context of its tes=
t suite,
> +the *fully-qualified* name of a test should be the suite name followed b=
y the
> +test name, separated by a colon (i.e. ``suite:test``).
> +
> +Test Kconfig Entries
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Every test suite should be tied to a Kconfig entry.
> +
> +This Kconfig entry must:
> +
> +* be named ``CONFIG_<name>_KUNIT_TEST``: where <name> is the name of the=
 test
> +  suite.
> +* be listed either alongside the config entries for the driver/subsystem=
 being
> +  tested, or be under [Kernel Hacking]=E2=86=92[Kernel Testing and Cover=
age]
> +* depend on ``CONFIG_KUNIT``
> +* be visible only if ``CONFIG_KUNIT_ALL_TESTS`` is not enabled.
> +* have a default value of ``CONFIG_KUNIT_ALL_TESTS``.
> +* have a brief description of KUnit in the help text
> +* include "If unsure, say N" in the help text
> +
> +Unless there's a specific reason not to (e.g. the test is unable to be b=
uilt as
> +a module), Kconfig entries for tests should be tristate.
> +
> +An example Kconfig entry:
> +
> +.. code-block:: none
> +
> +        config FOO_KUNIT_TEST
> +                tristate "KUnit test for foo" if !KUNIT_ALL_TESTS
> +                depends on KUNIT
> +                default KUNIT_ALL_TESTS
> +                help
> +                    This builds unit tests for foo.
> +
> +                    For more information on KUnit and unit tests in gene=
ral, please refer
> +                    to the KUnit documentation in Documentation/dev-tool=
s/kunit
> +
> +                    If unsure, say N
> +
> +
> +Test Filenames
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Where possible, test suites should be placed in a separate source file i=
n the
> +same directory as the code being tested.
> +
> +This file should be named ``<suite>_kunit.c``. It may make sense to stri=
p
> +excessive namespacing from the source filename (e.g., ``firmware_kunit.c=
`` instead of
> +``<drivername>_firmware.c``), but please ensure the module name does con=
tain the
> +full suite name.
> +
> +
> --
> 2.27.0.111.gc72c7da667-goog
>
