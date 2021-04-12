Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D4035CF68
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Apr 2021 19:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241780AbhDLR1c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Apr 2021 13:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241093AbhDLR1c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Apr 2021 13:27:32 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F02AC061574
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Apr 2021 10:27:12 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id b17so11705784ilh.6
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Apr 2021 10:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=04z2vHYC/VawzRBpIQPFgkdWCLPb8KfUuAYE/6SRxHQ=;
        b=SipRrj+/MS06zuKpho3NfK2AgpmwfuO/eKphP+Dv+P1nd22l7Fc2btN/7mT0AmLPlW
         aycZ8CvCHHIHmpB598zv68puxIIe2+aY0KtNR+67QadvcYiJ252TqJW0jWNhRksESmdJ
         K2Lh+IEDAO2YySbz3Wse0lgE1oevAhU6ZazUhvvBhUPQnL/x+eZAYHLpQUV+zHdmrKVc
         CooBdU4lLjXBQBl9R5+YrB41VlOqqD8bo1mVUk5EQBfDCYtOtzng/KKWW2HmHTOCyLbh
         aCX1l66ba8JZqMY27dO6W7qrlv379QIqbAa9nDhk4caWpaDtqbCDj0Ag9lIPEnm90xhQ
         abyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=04z2vHYC/VawzRBpIQPFgkdWCLPb8KfUuAYE/6SRxHQ=;
        b=MhsfGW1KF4Hea6mG0KfLIJABxxDA7HSeFDA0KGTuV13beNcuBTY+6QrhZrDDnGoSv/
         fXuDo4EtlHMfhK/0HG5kP2GN3fBBPDZZNFDjaOheinRhsEKH3z2DjzWZNL01FDyMzan4
         b6bV+n1vR7SiQHqikEPFsK0cl9Bqs4n+d630FlqtfyfDCncNZD77NdKThdpyv1Rxsf7y
         sFrd5aXBKHP4O+0arWC75rSz/PgQ6cpMXm5dKOB/RFEotkLXC0YuhS+xvtqpQbq9OyE+
         fnCJdBw8Oc17shIa5XMJYmAlyiT6s6ktAAVMzhFidzP7V4X8d1vITj/3Z97Ql4nRR2qK
         nLrQ==
X-Gm-Message-State: AOAM532AbKPNaeIRzUYFWrNZqSjs3iZI/7d6DlL+6WDUwXKzK91w9b9X
        z2tEG6hh2wF2YBtU4J/AVzE5tna/RjeB3rAsnDreuQ==
X-Google-Smtp-Source: ABdhPJz9WKunG+AR5V1q18CsLUMSSaByHwUJ7zDSzpILg9AVfFalHb7amenEpMlnwb13/qZwMFlhTYkBLAQaGuPV0JM=
X-Received: by 2002:a92:6011:: with SMTP id u17mr24448637ilb.274.1618248431352;
 Mon, 12 Apr 2021 10:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210409180105.3825069-1-dlatypov@google.com> <CABVgOSnjE8PBF9TyBRtX26i1t51=XCy6x=rg8C-Hv-zyvc7D6w@mail.gmail.com>
In-Reply-To: <CABVgOSnjE8PBF9TyBRtX26i1t51=XCy6x=rg8C-Hv-zyvc7D6w@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 12 Apr 2021 10:27:00 -0700
Message-ID: <CAGS_qxrEt=nLSMx7Vvs5qw0jjMTiv4G1Jt4Y-JtptSGa4DQSBw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: add tips for running KUnit
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

hOn Fri, Apr 9, 2021 at 9:10 PM David Gow <davidgow@google.com> wrote:
>
> Thanks for writing this: it's good to have these things documented at last!
>
> There are definitely a few things this document points out which still
> need deciding, which does make this document lean a bit into "design
> discussion" territory in a few of the notes. This doesn't bother me --
> it's an accurate description of the state of things -- but I wouldn't
> want this documentation held up too long because of these sorts of
> TODOs (and can definitely see how having too many of them might
> discourage KUnit use a bit). Particularly things like the
> ".kunitconfig" fragment file feature stuff: I feel that's something
> better discussed on patches adding/using the feature than in the
> documentation / reviews of the documentation, so I'd rather drop or
> simplify those '..note:'s than bokeshed about it here (something I'm a
> little guilty of below).

I don't think we'll actually make progress on any of those in the near
future though.
So I figured it'd be best to accurately represent the state of the
world ~somewhere.

But it did feel a bit strange to do it here, so I'm not against removing it.

>
> Otherwise, a few minor comments and nitpicks:
>
> -- David
>
> On Sat, Apr 10, 2021 at 2:01 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > This is long overdue.
> >
> > There are several things that aren't nailed down (in-tree
> > .kunitconfig's), or partially broken (GCOV on UML), but having them
> > documented, warts and all, is better than having nothing.
> >
> > This covers a bunch of the more recent features
> > * kunit_filter_glob
> > * kunit.py run --kunitconfig
> > * kunit.py run --alltests
> > * slightly more detail on building tests as modules
> > * CONFIG_KUNIT_DEBUGFS
> >
> > By my count, the only headline features now not mentioned are the KASAN
> > integration and KernelCI json output support (kunit.py run --json).
> >
> > And then it also discusses how to get code coverage reports under UML
> > and non-UML since this is a question people have repeatedly asked.
> >
> > Non-UML coverage collection is no differnt from normal, but we should
> > probably explicitly call thsi out.
>
> Nit: typos in 'different' and 'this'.
Fixed.
>
> >
> > As for UML, I was able to get it working again with two small hacks.*
> > E.g. with CONFIG_KUNIT=y && CONFIG_KUNIT_ALL_TESTS=y
> >   Overall coverage rate:
> >     lines......: 15.1% (18294 of 120776 lines)
> >     functions..: 16.8% (1860 of 11050 functions)
> >
> > *Switching to use gcc/gcov-6 and not using uml_abort().
> > I've documented these hacks in "Notes" but left TODOs for
> > brendanhiggins@google.com who tracked down the runtime issue in GCC.
> > To be clear: these are not issues specific to KUnit, but rather to UML.
>
> (We should probably note where uml_abort() needs to be replaced if
> we're mentioning this, though doing so below in the more detailed
> section may be more useful.)

Updated to
*Using gcc/gcov-6 and not using uml_abort() in os_dump_core().

I figured we'd be more precise in the documentation itself.

>
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
> >  Documentation/dev-tools/kunit/index.rst       |   1 +
> >  .../dev-tools/kunit/running_tips.rst          | 278 ++++++++++++++++++
> >  Documentation/dev-tools/kunit/start.rst       |   2 +
> >  3 files changed, 281 insertions(+)
> >  create mode 100644 Documentation/dev-tools/kunit/running_tips.rst
> >
> > diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
> > index 848478838347..7f7cf8d2ab20 100644
> > --- a/Documentation/dev-tools/kunit/index.rst
> > +++ b/Documentation/dev-tools/kunit/index.rst
> > @@ -14,6 +14,7 @@ KUnit - Unit Testing for the Linux Kernel
> >         style
> >         faq
> >         tips
> > +       running_tips
> >
> >  What is KUnit?
> >  ==============
> > diff --git a/Documentation/dev-tools/kunit/running_tips.rst b/Documentation/dev-tools/kunit/running_tips.rst
> > new file mode 100644
> > index 000000000000..d38e665e530f
> > --- /dev/null
> > +++ b/Documentation/dev-tools/kunit/running_tips.rst
> > @@ -0,0 +1,278 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +============================
> > +Tips For Running KUnit Tests
> > +============================
> > +
> > +Using ``kunit.py run`` ("kunit tool")
> > +=====================================
> > +
> > +Running from any directory
> > +--------------------------
> > +
> > +It can be handy to create a bash function like:
> > +
> > +.. code-block:: bash
> > +
> > +       function run_kunit() {
> > +         ( cd "$(git rev-parse --show-toplevel)" && ./tools/testing/kunit/kunit.py run $@ )
> > +       }
> > +
> > +.. note::
> > +       Early versions of ``kunit.py`` (before 5.6) didn't work unless run from
> > +       the kernel root, hence the use of a subshell and ``cd``.
> > +
> > +Running a subset of tests
> > +-------------------------
> > +
> > +``kunit.py run`` accepts an optional glob argument to filter tests. Currently
> > +this only matches against suite names, but this may change in the future.
> > +
> > +Say that we wanted to run the sysctl tests, we could do so via:
> > +
> > +.. code-block:: bash
> > +
> > +       $ echo -e 'CONFIG_KUNIT=y\nCONFIG_KUNIT_ALL_TESTS=y' > .kunit/.kunitconfig
> > +       $ ./tools/testing/kunit/kunit.py run 'sysctl*'
> > +
> > +We're paying the cost of building more tests than we need this way, but it's
> > +easier than fiddling with ``.kunitconfig`` files or commenting out
> > +``kunit_suite``'s.
> > +
> > +However, if we wanted to define a set of tests in a less ad hoc way, the next
> > +tip is useful.
> > +
> > +Defining a set of tests
> > +-----------------------
> > +
> > +``kunit.py run`` (along with ``build``, and ``config``) supports a
> > +``--kunitconfig`` flag. So if you have a set of tests that you want to run on a
> > +regular basis (especially if they have other dependencies), you can create a
> > +specific ``.kunitconfig`` for them.
> > +
> > +E.g. kunit has own for its tests:
>
> Nit: 'one' for its tests (or 'its own' for its tests?)
Fixed, meant to be "one"
>
> > +
> > +.. code-block:: bash
> > +
> > +       $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit/.kunitconfig
> > +
> > +Alternatively, if you're following the convention of naming your
> > +file ``.kunitconfig``, you can just pass in the dir, e.g.
> > +
> > +.. code-block:: bash
> > +
> > +       $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit
> > +
> > +.. note::
> > +       This is a relatively new feature (5.12+) so we don't have any
> > +       conventions yet about on what files should be checked in versus just
> > +       kept around locally. But if the tests don't have any dependencies
> > +       (beyond ``CONFIG_KUNIT``), it's probably not worth writing and
> > +       maintaining a ``.kunitconfig`` fragment.  Running with
> > +       ``CONFIG_KUNIT_ALL_TESTS=y`` is probably easier.
>
> I think the rule of thumb for checked-in .kunitconfig files should be
> an explicit endorsement by the maintainer that these are the tests for
> a particular subsystem.

Hmm, I'm not sure we want to prescribe a granularity here.
If we had something like a "How-to-Test-Cmd" in MAINTAINERS, I'd feel
more justified in doing so.

But atm, I feel the line should be "use it if it's useful, check it in
if you think it's useful to 'enough' other people."

>
> > +
> > +.. note::
> > +       Having ``.kunitconfig`` fragments in a parent and child directory is
> > +       iffy. There's discussion about adding an "import" statement in these
> > +       files to make it possible to have a top-level config run tests from all
> > +       child directories. But that would mean ``.kunitconfig`` files are no
> > +       longer just simple .config fragments.
> > +
> > +       One alternative would be to have kunit tool recursively combine configs
> > +       automagically, but tests could theoretically depend on incompatible
> > +       options, so handling that would be tricky.
> > +
> > +Running with ``allyesconfig``
> > +-----------------------------
> > +
> > +.. code-block:: bash
> > +
> > +       $ ./tools/testing/kunit/kunit.py run --alltests
> > +
> > +This will try and use ``allyesconfig``, or rather ``allyesconfig`` with a list
> Excessively pedantic nit: 'try to use'
Done.

> > +of UML-incompatible configs turned off. That list is maintained in
> > +``tools/testing/kunit/configs/broken_on_uml.config``.
> > +
> > +.. note::
> > +       This will take a *lot* longer to run and might be broken from time to
> > +       time, especially on -next. It's not recommended to use this unless you
> > +       need to or are morbidly curious.
>
> Given that it's been the plan to run this for KernelCI, I'm not sure
> we should discourage it in general to quite this
> extent. I think it is broken at the moment, though, so that's
> nevertheless worth noting.

It was broken for me when I tried as I was writing this up, haven't
checked again yet.
I think until KernelCI uses it regularly, it's not going to be as easy
to keep it working.

So IMO,
* KernelCI and other automation should try and use it
* we shouldn't necessarily encourage a human to go and try it at this time
  * or maybe never: this basically eliminates one of the biggest
selling points: the fast edit/compile/test cycle that KUnit on UML
has.

So how about something like:

This will take a *lot* longer to run and might be broken from time to time.
You'll probably be better off just building and running the tests you
care about if you need to do so more than once.

>
> > +
> > +Generating code coverage reports under UML
> > +------------------------------------------
> > +
> > +.. note::
> > +       TODO(brendanhiggins@google.com): There are various issues with UML and
> > +       versions of gcc 7 and up. You're likely to run into missing ``.gcda``
> > +       files or compile errors. We know one `faulty GCC commit
> > +       <https://github.com/gcc-mirror/gcc/commit/8c9434c2f9358b8b8bad2c1990edf10a21645f9d>`_
> > +       but not how we'd go about getting this fixed. The compile errors still
> > +       need some investigation.
> > +
> > +.. note::
> > +       TODO(brendanhiggins@google.com): for recent versions of Linux
> > +       (5.10-5.12, maybe earlier), there's a bug with gcov counters not being
> > +       flushed in UML. This translates to very low (<1%) reported coverage. This is
> > +       related to the above issue and can be worked around by replacing the
> > +       one call to ``uml_abort()`` with a plain ``exit()``.
>
> Can we be more specific than 'the one call' here? I know there is only
> one call, but maybe noting that it's in arch/um/os-Linux/util.c will
> make this clearer.

Yeah, here's only one call, so I thought leaving it more vague in case
the file gets renamed or w/e would be safer.

But yeah, if adding something more here makes it more clear, I can do that.
Hmm, looks like the function that calls it, os_dump_core(void) is
currently unique.
Thoughts on referring to that instead of the filename (I'm not sure
that either is meaningfully less likely to change)?

>
> > +
> > +
> > +This is different from the "normal" way of getting coverage information that is
> > +documented in Documentation/dev-tools/gcov.rst.
> > +
> > +Instead of enabling ``CONFIG_GCOV_KERNEL=y``, we can set these options:
> > +
> > +.. code-block:: none
> > +
> > +       CONFIG_DEBUG_KERNEL=y
> > +       CONFIG_DEBUG_INFO=y
> > +       CONFIG_GCOV=y
> > +
> > +
> > +Putting it together into a copy-pastable sequence of commands:
> > +
> > +.. code-block:: bash
> > +
> > +       # Append coverage options to the current config
> > +       $ echo -e "CONFIG_DEBUG_KERNEL=y\nCONFIG_DEBUG_INFO=y\nCONFIG_GCOV=y" >> .kunit/.kunitconfig
> > +       $ ./tools/testing/kunit/kunit.py run
> > +       # Extract the coverage information from the build dir (.kunit/)
> > +       $ lcov -t "my_kunit_tests" -o coverage.info -c -d .kunit/
> > +
> > +       # From here on, it's the same process as with CONFIG_GCOV_KERNEL=y
> > +       # E.g. can generate an HTML report in a tmp dir like so:
> > +       $ genhtml -o /tmp/coverage_html coverage.info
> > +
> > +
> > +If your installed version of gcc doesn't work, you can tweak the steps:
> > +
> > +.. code-block:: bash
> > +
> > +       # need to edit tools/testing/kunit/kunit_kernel.py to call make with 'CC=/usr/bin/gcc-6'
> > +       $ $EDITOR tools/testing/kunit/kunit_kernel.py
> > +
> > +       $ lcov -t "my_kunit_tests" -o coverage.info -c -d .kunit/ --gcov-tool=/usr/bin/gcov-6
> > +
> > +
> > +Running tests manually
> > +======================
> > +
> > +Running tests without using ``kunit.py run`` is also an important use case.
> > +Currently it's your only option if you want to test on architectures other than
> > +UML.
> > +
> > +As running the tests under UML is fairly straightforward (configure and compile
> > +the kernel, run the ``./linux`` binary), this section will focus on testing
> > +non-UML architectures.
> > +
> > +
> > +Running built-in tests
> > +----------------------
> > +
> > +When setting tests to ``=y``, the tests will run as part of boot and print
> > +results to dmesg in TAP format. So you just need to add your tests to your
> > +``.config``, build and boot your kernel as normal.
> > +
> > +So if we compiled our kernel with:
> > +
> > +.. code-block:: none
> > +
> > +       CONFIG_KUNIT=y
> > +       CONFIG_KUNIT_EXAMPLE_TEST=y
> > +
> > +Then we'd see output like this in dmesg signaling the test ran and passed:
> > +
> > +.. code-block:: none
> > +
> > +       TAP version 14
> > +       1..1
> > +           # Subtest: example
> > +           1..1
> > +           # example_simple_test: initializing
> > +           ok 1 - example_simple_test
> > +       ok 1 - example
> > +
> > +Running tests as modules
> > +------------------------
> > +
> > +Depending on the tests, you can build them as loadable modules.
> > +
> > +For example, we'd change the config options from before to
> > +
> > +.. code-block:: none
> > +
> > +       CONFIG_KUNIT=y
> > +       CONFIG_KUNIT_EXAMPLE_TEST=m
> > +
> > +Then after booting into our kernel, we can run the test via
> > +
> > +.. code-block:: none
> > +
> > +       $ modprobe kunit-example-test
> > +
> > +This will then cause it to print TAP output to stdout.
> > +
> > +.. note::
> > +       The ``modprobe`` will *not* have a non-zero exit code if any test
> > +       failed (as of 5.13). But ``kunit.py parse`` would, see below.
> > +
> > +.. note::
> > +       You can set ``CONFIG_KUNIT=m`` as well, however, some features will not
> > +       work and thus some tests might break. Ideally tests would specify they
> > +       depend on ``KUNIT=y`` in their ``Kconfig``'s, but this is an edge case
> > +       most test authors won't think about.
> > +       As of 5.13, the only difference is that ``current->kunit_test`` will
> > +       not exist.
> > +
> > +Pretty-printing results
> > +-----------------------
> > +
> > +You can use ``kunit.py parse`` to parse dmesg for test output and print out
> > +results in the same familiar format that ``kunit.py run`` does.
>
> This also should work for the debugfs files below, so maybe reword
> this to either mention that or not explicitly mention dmesg above.

This won't work, actually :/
`kunit.py parse` expects a TAP version header, which doesn't get shown
in debugfs.

It'll just print out the "no tests run!" message.

>
> > +
> > +.. code-block:: bash
> > +
> > +       $ ./tools/testing/kunit/kunit.py parse /var/log/dmesg
> > +
> > +
> > +Retrieving per suite results
> > +----------------------------
> > +
> > +Regardless of how you're running your tests, you can enable
> > +``CONFIG_KUNIT_DEBUGFS`` to expose per-suite TAP-formatted results:
> > +
> > +.. code-block:: none
> > +
> > +       CONFIG_KUNIT=y
> > +       CONFIG_KUNIT_EXAMPLE_TEST=m
> > +       CONFIG_KUNIT_DEBUGFS=y
> > +
> > +The results for each suite will be exposed under
> > +``/sys/kernel/debug/kunit/<suite>/results``.
> > +So using our example config:
> > +
> > +.. code-block:: bash
> > +
> > +       $ modprobe kunit-example-test > /dev/null
> > +       $ cat /sys/kernel/debug/kunit/example/results
> > +       ... <TAP output> ...
> > +
> > +       # After removing the module, the corresponding files will go away
> > +       $ modprobe -r kunit-example-test
> > +       $ cat /sys/kernel/debug/kunit/example/results
> > +       /sys/kernel/debug/kunit/example/results: No such file or directory
> > +
> > +Generating code coverage reports
> > +--------------------------------
> > +
> > +See Documentation/dev-tools/gcov.rst for details on how to do this.
> > +
> > +The only vaguely KUnit-specific advice here is that you probably want to build
> > +your tests as modules. That way you can isolate the coverage from tests from
> > +other code executed during boot, e.g.
> > +
> > +.. code-block:: bash
> > +
> > +       # Reset coverage counters before running the test.
> > +       $ echo 0 > /sys/kernel/debug/gcov/reset
> > +       $ modprobe kunit-example-test
> > diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> > index 0e65cabe08eb..aa56d7ca6bfb 100644
> > --- a/Documentation/dev-tools/kunit/start.rst
> > +++ b/Documentation/dev-tools/kunit/start.rst
> > @@ -236,5 +236,7 @@ Next Steps
> >  ==========
> >  *   Check out the :doc:`tips` page for tips on
> >      writing idiomatic KUnit tests.
> > +*   Check out the :doc:`running_tips` page for tips on
> > +    how to make running KUnit tests easier.
> >  *   Optional: see the :doc:`usage` page for a more
> >      in-depth explanation of KUnit.
> >
> > base-commit: de2fcb3e62013738f22bbb42cbd757d9a242574e
> > --
> > 2.31.1.295.g9ea45b61b8-goog
> >
