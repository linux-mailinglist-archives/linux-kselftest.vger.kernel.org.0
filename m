Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1E61A2AE7
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Apr 2020 23:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgDHVRE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Apr 2020 17:17:04 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35514 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbgDHVRE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Apr 2020 17:17:04 -0400
Received: by mail-pg1-f194.google.com with SMTP id k5so3921995pga.2
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Apr 2020 14:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o5qALla+Cdg3Nye9Y3RDRDSCtIDMk56uRW/kTihzASY=;
        b=cm6HCeo0q8bKTd1o+ZciChsdIhw7i+ztLpR+tH2x3+ezJS01pF78fc4DhJfTLGYBGD
         dxbpQkb6H07S4HSxoI5XecdYWfIrpJvSZ2IKt/JRCshcXgGzndCvDTqf+dOYV5URZuR6
         bNgbd5BN0oQVyhVnK6Uz2V2Hnx0gWpDYQDzVnaNgollrXAmJQS7ZETN3n+TGN97lfjgv
         XPadVOg0cOV4ru+Fme2SJKDubyMFJKnYHnMSA/q41X5wxWat3cQHQChYCZ++Uq1NszMz
         CHqRmEfnpXvSGVQ+740a9Wjf0Ox/95dP6yRHO/jT2YVIxRxFA0PVL0rThAhJYFXAJQUE
         P9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o5qALla+Cdg3Nye9Y3RDRDSCtIDMk56uRW/kTihzASY=;
        b=fs9nFsAXPncEEP+4uwE2kwOE5rWU2N1Q9Q9F1a6sLp/q9YiFipP7EBBaFPHu8YYTJ9
         n+ODSdTOOMpvBf+9v3pvXZfRirLruY6sb3CXWPapfZj3YfV1uZ03vWxKaV3TbT32tBhl
         pwxSMnYCB/pziM78nHCZRATNPoAQ6iRId4WcWnSaVZ5oZWqdsusrZd6NsxdF4P8ouBOF
         5B8qOtI127VrEdRU1myu8x6cl0kHwv1pDbdhyaFEcvROb14DudNexsC3XxlFhLMDCVnE
         KBN0i3V3OOR8zbxBiraFmiqfUgi6JDZ2K/sOMUipZ5QomU/RPpYOAvgwUJe1iJ42lWNj
         BR2Q==
X-Gm-Message-State: AGi0PuYxccqbxVWgYDRLLp10Zo109P4U44trYeJoa3g7wf72l7M/HK0m
        aLIt0ff1laSKHV29oMsXyMkPbLY9ntIZrUfFGLw=
X-Google-Smtp-Source: APiQypKSH2cYUAj6xpAQ//UhhApA+vb+r4Ldfo8EuiHwrKlU2TuSoil2PMjtre9XT4qJTDA/aLTE0ci2PQKXyWUuzmE=
X-Received: by 2002:aa7:97a6:: with SMTP id d6mr10148686pfq.154.1586380619921;
 Wed, 08 Apr 2020 14:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200408205024.22119-1-l.rubusch@gmail.com> <CAFd5g47O07Gk6BixQV6iQpcERU_xVbBtRaUyXGaOO7Axcma+iQ@mail.gmail.com>
In-Reply-To: <CAFd5g47O07Gk6BixQV6iQpcERU_xVbBtRaUyXGaOO7Axcma+iQ@mail.gmail.com>
From:   Lothar Rubusch <l.rubusch@gmail.com>
Date:   Wed, 8 Apr 2020 23:16:23 +0200
Message-ID: <CAFXKEHY0pBmUhEMAVgOJ+zzaxWxEFcGQqa7ry+qF30wWs5=B4w@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: test.h - fix warnings
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 8, 2020 at 10:56 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Wed, Apr 8, 2020 at 1:50 PM Lothar Rubusch <l.rubusch@gmail.com> wrote:
> >
> > Fix warnings at 'make htmldocs', and formatting issues in the resulting
> > documentation.
> >
> > - test.h: Fix some typos in kernel-doc parameter description.
> >
> > - Documentation/*.rst: Fixing formatting issues, and a duplicate label
> >   issue, since using sphinx.ext.autosectionlabel in conf.py, referes to
> >   headers are generated automatically and sphinx will not complain about
> >   identical headers among documents anymore.
> >
> >   The downside is, automatically generated header labels within one
> >   document now cannot be overwritten manually anymore. Thus duplicate
> >   headers within one document have to have different wording, i.e. this
> >   patch modifies some headers.
> >
> > - Documentation/api/*: Flipping over to a page "API" containing a single
> >   link to another page "API" seems like a formatting issue. The patch
> >   removes one level of indirection.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
>
> A couple of minor comments, but other than that:
>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
>
> Thanks!
>
> > ---
> >  Documentation/dev-tools/kunit/api/index.rst | 16 ----------------
> >  Documentation/dev-tools/kunit/index.rst     |  4 ++--
> >  Documentation/dev-tools/kunit/start.rst     | 13 ++++++++-----
> >  Documentation/dev-tools/kunit/usage.rst     |  4 ++--
> >  include/kunit/test.h                        |  5 +++--
> >  5 files changed, 15 insertions(+), 27 deletions(-)
> >  delete mode 100644 Documentation/dev-tools/kunit/api/index.rst
> >
> > diff --git a/Documentation/dev-tools/kunit/api/index.rst b/Documentation/dev-tools/kunit/api/index.rst
> > deleted file mode 100644
> > index 9b9bffe5d41a..000000000000
> > --- a/Documentation/dev-tools/kunit/api/index.rst
> > +++ /dev/null
> > @@ -1,16 +0,0 @@
> > -.. SPDX-License-Identifier: GPL-2.0
> > -
> > -=============
> > -API Reference
> > -=============
> > -.. toctree::
> > -
> > -       test
> > -
> > -This section documents the KUnit kernel testing API. It is divided into the
> > -following sections:
> > -
> > -================================= ==============================================
> > -:doc:`test`                       documents all of the standard testing API
> > -                                  excluding mocking or mocking related features.
> > -================================= ==============================================
>
> Let's hold off on this. We have some other pages we would like to add
> to this directory soonish.

Sure! I appologize, I just missed your last mail that you guys still
plan something in the API section of the document.
So I leave the API page as is, no problem!


> > diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
> > index e93606ecfb01..640bba1f4896 100644
> > --- a/Documentation/dev-tools/kunit/index.rst
> > +++ b/Documentation/dev-tools/kunit/index.rst
> > @@ -10,7 +10,7 @@ KUnit - Unit Testing for the Linux Kernel
> >         start
> >         usage
> >         kunit-tool
> > -       api/index
> > +       api/test
> >         faq
> >
> >  What is KUnit?
> > @@ -88,6 +88,6 @@ How do I use it?
> >
> >  *   :doc:`start` - for new users of KUnit
> >  *   :doc:`usage` - for a more detailed explanation of KUnit features
> > -*   :doc:`api/index` - for the list of KUnit APIs used for testing
> > +*   :doc:`api/test` - for the list of KUnit APIs used for testing
> >  *   :doc:`kunit-tool` - for more information on the kunit_tool helper script
> >  *   :doc:`faq` - for answers to some common questions about KUnit
> > diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> > index e1c5ce80ce12..bb112cf70624 100644
> > --- a/Documentation/dev-tools/kunit/start.rst
> > +++ b/Documentation/dev-tools/kunit/start.rst
> > @@ -32,15 +32,17 @@ test targets as well. The ``.kunitconfig`` should also contain any other config
> >  options required by the tests.
> >
> >  A good starting point for a ``.kunitconfig`` is the KUnit defconfig:
> > +
> >  .. code-block:: bash
> >
> >         cd $PATH_TO_LINUX_REPO
> >         cp arch/um/configs/kunit_defconfig .kunitconfig
> >
> >  You can then add any other Kconfig options you wish, e.g.:
> > +
> >  .. code-block:: none
> >
> > -        CONFIG_LIST_KUNIT_TEST=y
> > +       CONFIG_LIST_KUNIT_TEST=y
> >
> >  :doc:`kunit_tool <kunit-tool>` will ensure that all config options set in
> >  ``.kunitconfig`` are set in the kernel ``.config`` before running the tests.
> > @@ -54,8 +56,8 @@ using.
> >     other tools (such as make menuconfig) to adjust other config options.
> >
> >
> > -Running the tests
> > ------------------
> > +Running the tests (KUnit Wrapper)
> > +---------------------------------
> >
> >  To make sure that everything is set up correctly, simply invoke the Python
> >  wrapper from your kernel repo:
> > @@ -105,8 +107,9 @@ have config options ending in ``_KUNIT_TEST``.
> >  KUnit and KUnit tests can be compiled as modules: in this case the tests in a
> >  module will be run when the module is loaded.
> >
> > -Running the tests
> > ------------------
> > +
> > +Running the tests (w/o KUnit Wrapper)
> > +-------------------------------------
> >
> >  Build and run your kernel as usual. Test output will be written to the kernel
> >  log in `TAP <https://testanything.org/>`_ format.
> > diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> > index 473a2361ec37..3c3fe8b5fecc 100644
> > --- a/Documentation/dev-tools/kunit/usage.rst
> > +++ b/Documentation/dev-tools/kunit/usage.rst
> > @@ -595,7 +595,7 @@ able to run one test case per invocation.
> >  KUnit debugfs representation
> >  ============================
> >  When kunit test suites are initialized, they create an associated directory
> > -in /sys/kernel/debug/kunit/<test-suite>.  The directory contains one file
> > +in ``/sys/kernel/debug/kunit/<test-suite>``.  The directory contains one file
> >
> >  - results: "cat results" displays results of each test case and the results
> >    of the entire suite for the last test run.
> > @@ -604,4 +604,4 @@ The debugfs representation is primarily of use when kunit test suites are
> >  run in a native environment, either as modules or builtin.  Having a way
> >  to display results like this is valuable as otherwise results can be
> >  intermixed with other events in dmesg output.  The maximum size of each
> > -results file is KUNIT_LOG_SIZE bytes (defined in include/kunit/test.h).
> > +results file is KUNIT_LOG_SIZE bytes (defined in ``include/kunit/test.h``).
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index 9b0c46a6ca1f..16d548b795b5 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -175,7 +175,7 @@ struct kunit_suite {
> >         void (*exit)(struct kunit *test);
> >         struct kunit_case *test_cases;
> >
> > -       /* private - internal use only */
> > +       /* private: internal use only */
> >         struct dentry *debugfs;
> >         char *log;
> >  };
> > @@ -232,7 +232,8 @@ void __kunit_test_suites_exit(struct kunit_suite **suites);
> >   * kunit_test_suites() - used to register one or more &struct kunit_suite
> >   *                      with KUnit.
> >   *
> > - * @suites: a statically allocated list of &struct kunit_suite.
> > + * @...: a statically allocated list of &struct kunit_suite, assigned
> > + *           to the pointer @suites.
> >   *
> >   * Registers @suites with the test framework. See &struct kunit_suite for
>
> Can you change the @suites param here to match @...?

You mean, in "Registers @suites with the test framework" to something
rather like "Registers @... with"?
Hum, franckly I think, in the documentation it reads better having the
name "suites", that's why I tried to
append a hint, that a passed list of struct kunit_suite initializes
the pointer "suites". Then further in the doc
refered as suites, I think it becomes clear. But let me know. Shall I
use @... instead?

Just give me a brief answer to this mail, then I adjust the patch and
quickly resubmit.

Best,
L
