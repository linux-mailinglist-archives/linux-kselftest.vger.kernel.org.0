Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60A3A1A3B91
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Apr 2020 22:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgDIUvD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Apr 2020 16:51:03 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37908 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgDIUvD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Apr 2020 16:51:03 -0400
Received: by mail-pj1-f68.google.com with SMTP id t40so1761376pjb.3
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Apr 2020 13:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NYSmk/A/oYsPVcQZiy0i2Kr1+eIUI6HUDP7UyaIG2jA=;
        b=mM1ELKScD+F66Ky2O8m+YzG5pEQQjnW1xgDEuvi2K0ELKUIa4eTQEIr3EtIFKkuigv
         +b5XDLu2VZ+36J1kDIndhFjfXDWdMRH72UG6YrLqzd2oaLpzm1AAThFVub4wX0P8cJVY
         O8ZYlREHvDZJV9t1VnW37eEgYazBIFsszCJHLQ2L4VwGUer01GZR2Uni8KaFRthYs0jz
         9s7zGIEnczYhlvxrf+6J7UGaSQmzyIYjagAr3/SP2eoOTFCthsJaPFy2T2TNH12kKtOp
         SFvNlFGwgvllyKCJ2T7Dc9ZIOK52IF7jayjfopXf/wdhatH4QGmoHyG0wmXSoyoWYdHJ
         fNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NYSmk/A/oYsPVcQZiy0i2Kr1+eIUI6HUDP7UyaIG2jA=;
        b=hBgpg2fBeAR6SJKyXK2gZ8kTVZzm7WD4AlN81BnV/Z5iChgTcgrH73s8YvjyXf4yMY
         bM7egpWG2LzCf46iVv4ITpnNxnlqplq7YhGJQyQco47TF551KNUL5B45kVg7oljmM/Mo
         S4qPdSKIn6iCorQKLxLqVXHsGka+qwhjkPSs6TwajWnHimUIRVAAjpqW/i8MQfruAQab
         UOoEp8X7vZjdaIt8KzGQVJhschLa7BG5smuXPqZyD0cy/RwyOPd6qk1j2Trkv6PDCh66
         YhE12a6dzgceM6YJzd155O3/BXwq348FyZqVqGPjujrJles39yg2IVEh6RXznj0BfzUv
         YZuQ==
X-Gm-Message-State: AGi0PuaWOk4bVy+TvdrNX3m+uHeFTXxaiDOu0MkS9bqLVEFzT0XfI/QZ
        0z4aEnYPi+3jG9s4Ic2cKJQkiDkpq7V1/H+cg9JSmiOjZ8U=
X-Google-Smtp-Source: APiQypKmop+g0pYnFgdjdBG+jo7DDrDxdQo/kfbWnG8Nqioz94Dl0tazg5FGQA1A5+srC+417v7eOBd/Eitg+aKUpI8=
X-Received: by 2002:a17:90a:7302:: with SMTP id m2mr1458734pjk.7.1586465461849;
 Thu, 09 Apr 2020 13:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200408205024.22119-1-l.rubusch@gmail.com> <CAFd5g47O07Gk6BixQV6iQpcERU_xVbBtRaUyXGaOO7Axcma+iQ@mail.gmail.com>
 <CAFXKEHY0pBmUhEMAVgOJ+zzaxWxEFcGQqa7ry+qF30wWs5=B4w@mail.gmail.com> <CAFd5g47037poE7w6GUasV90-BNBMcg0+uCQjikqpCuYwDJ4euw@mail.gmail.com>
In-Reply-To: <CAFd5g47037poE7w6GUasV90-BNBMcg0+uCQjikqpCuYwDJ4euw@mail.gmail.com>
From:   Lothar Rubusch <l.rubusch@gmail.com>
Date:   Thu, 9 Apr 2020 22:50:25 +0200
Message-ID: <CAFXKEHYU-t2Xt_Q9-CN=G_v17_jj1mO1bBcA7mtYFq0zxyus2Q@mail.gmail.com>
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

On Thu, Apr 9, 2020 at 10:00 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Wed, Apr 8, 2020 at 2:17 PM Lothar Rubusch <l.rubusch@gmail.com> wrote:
> >
> > On Wed, Apr 8, 2020 at 10:56 PM Brendan Higgins
> > <brendanhiggins@google.com> wrote:
> > >
> > > On Wed, Apr 8, 2020 at 1:50 PM Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > > >
> > > > Fix warnings at 'make htmldocs', and formatting issues in the resulting
> > > > documentation.
> > > >
> > > > - test.h: Fix some typos in kernel-doc parameter description.
> > > >
> > > > - Documentation/*.rst: Fixing formatting issues, and a duplicate label
> > > >   issue, since using sphinx.ext.autosectionlabel in conf.py, referes to
> > > >   headers are generated automatically and sphinx will not complain about
> > > >   identical headers among documents anymore.
> > > >
> > > >   The downside is, automatically generated header labels within one
> > > >   document now cannot be overwritten manually anymore. Thus duplicate
> > > >   headers within one document have to have different wording, i.e. this
> > > >   patch modifies some headers.
> > > >
> > > > - Documentation/api/*: Flipping over to a page "API" containing a single
> > > >   link to another page "API" seems like a formatting issue. The patch
> > > >   removes one level of indirection.
> > > >
> > > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > >
> > > A couple of minor comments, but other than that:
> > >
> > > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> > >
> > > Thanks!
> > >
> > > > ---
> > > >  Documentation/dev-tools/kunit/api/index.rst | 16 ----------------
> > > >  Documentation/dev-tools/kunit/index.rst     |  4 ++--
> > > >  Documentation/dev-tools/kunit/start.rst     | 13 ++++++++-----
> > > >  Documentation/dev-tools/kunit/usage.rst     |  4 ++--
> > > >  include/kunit/test.h                        |  5 +++--
> > > >  5 files changed, 15 insertions(+), 27 deletions(-)
> > > >  delete mode 100644 Documentation/dev-tools/kunit/api/index.rst
> > > >
> > > > diff --git a/Documentation/dev-tools/kunit/api/index.rst b/Documentation/dev-tools/kunit/api/index.rst
> > > > deleted file mode 100644
> > > > index 9b9bffe5d41a..000000000000
> > > > --- a/Documentation/dev-tools/kunit/api/index.rst
> > > > +++ /dev/null
> > > > @@ -1,16 +0,0 @@
> > > > -.. SPDX-License-Identifier: GPL-2.0
> > > > -
> > > > -=============
> > > > -API Reference
> > > > -=============
> > > > -.. toctree::
> > > > -
> > > > -       test
> > > > -
> > > > -This section documents the KUnit kernel testing API. It is divided into the
> > > > -following sections:
> > > > -
> > > > -================================= ==============================================
> > > > -:doc:`test`                       documents all of the standard testing API
> > > > -                                  excluding mocking or mocking related features.
> > > > -================================= ==============================================
> > >
> > > Let's hold off on this. We have some other pages we would like to add
> > > to this directory soonish.
> >
> > Sure! I appologize, I just missed your last mail that you guys still
> > plan something in the API section of the document.
> > So I leave the API page as is, no problem!
>
> No worries, we have let that go longer than I would like. So that's
> our fault, not yours :-)
>
> > > > diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
> > > > index e93606ecfb01..640bba1f4896 100644
> > > > --- a/Documentation/dev-tools/kunit/index.rst
> > > > +++ b/Documentation/dev-tools/kunit/index.rst
> > > > @@ -10,7 +10,7 @@ KUnit - Unit Testing for the Linux Kernel
> > > >         start
> > > >         usage
> > > >         kunit-tool
> > > > -       api/index
> > > > +       api/test
> > > >         faq
> > > >
> > > >  What is KUnit?
> > > > @@ -88,6 +88,6 @@ How do I use it?
> > > >
> > > >  *   :doc:`start` - for new users of KUnit
> > > >  *   :doc:`usage` - for a more detailed explanation of KUnit features
> > > > -*   :doc:`api/index` - for the list of KUnit APIs used for testing
> > > > +*   :doc:`api/test` - for the list of KUnit APIs used for testing
> > > >  *   :doc:`kunit-tool` - for more information on the kunit_tool helper script
> > > >  *   :doc:`faq` - for answers to some common questions about KUnit
> > > > diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> > > > index e1c5ce80ce12..bb112cf70624 100644
> > > > --- a/Documentation/dev-tools/kunit/start.rst
> > > > +++ b/Documentation/dev-tools/kunit/start.rst
> > > > @@ -32,15 +32,17 @@ test targets as well. The ``.kunitconfig`` should also contain any other config
> > > >  options required by the tests.
> > > >
> > > >  A good starting point for a ``.kunitconfig`` is the KUnit defconfig:
> > > > +
> > > >  .. code-block:: bash
> > > >
> > > >         cd $PATH_TO_LINUX_REPO
> > > >         cp arch/um/configs/kunit_defconfig .kunitconfig
> > > >
> > > >  You can then add any other Kconfig options you wish, e.g.:
> > > > +
> > > >  .. code-block:: none
> > > >
> > > > -        CONFIG_LIST_KUNIT_TEST=y
> > > > +       CONFIG_LIST_KUNIT_TEST=y
> > > >
> > > >  :doc:`kunit_tool <kunit-tool>` will ensure that all config options set in
> > > >  ``.kunitconfig`` are set in the kernel ``.config`` before running the tests.
> > > > @@ -54,8 +56,8 @@ using.
> > > >     other tools (such as make menuconfig) to adjust other config options.
> > > >
> > > >
> > > > -Running the tests
> > > > ------------------
> > > > +Running the tests (KUnit Wrapper)
> > > > +---------------------------------
> > > >
> > > >  To make sure that everything is set up correctly, simply invoke the Python
> > > >  wrapper from your kernel repo:
> > > > @@ -105,8 +107,9 @@ have config options ending in ``_KUNIT_TEST``.
> > > >  KUnit and KUnit tests can be compiled as modules: in this case the tests in a
> > > >  module will be run when the module is loaded.
> > > >
> > > > -Running the tests
> > > > ------------------
> > > > +
> > > > +Running the tests (w/o KUnit Wrapper)
> > > > +-------------------------------------
> > > >
> > > >  Build and run your kernel as usual. Test output will be written to the kernel
> > > >  log in `TAP <https://testanything.org/>`_ format.
> > > > diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> > > > index 473a2361ec37..3c3fe8b5fecc 100644
> > > > --- a/Documentation/dev-tools/kunit/usage.rst
> > > > +++ b/Documentation/dev-tools/kunit/usage.rst
> > > > @@ -595,7 +595,7 @@ able to run one test case per invocation.
> > > >  KUnit debugfs representation
> > > >  ============================
> > > >  When kunit test suites are initialized, they create an associated directory
> > > > -in /sys/kernel/debug/kunit/<test-suite>.  The directory contains one file
> > > > +in ``/sys/kernel/debug/kunit/<test-suite>``.  The directory contains one file
> > > >
> > > >  - results: "cat results" displays results of each test case and the results
> > > >    of the entire suite for the last test run.
> > > > @@ -604,4 +604,4 @@ The debugfs representation is primarily of use when kunit test suites are
> > > >  run in a native environment, either as modules or builtin.  Having a way
> > > >  to display results like this is valuable as otherwise results can be
> > > >  intermixed with other events in dmesg output.  The maximum size of each
> > > > -results file is KUNIT_LOG_SIZE bytes (defined in include/kunit/test.h).
> > > > +results file is KUNIT_LOG_SIZE bytes (defined in ``include/kunit/test.h``).
> > > > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > > > index 9b0c46a6ca1f..16d548b795b5 100644
> > > > --- a/include/kunit/test.h
> > > > +++ b/include/kunit/test.h
> > > > @@ -175,7 +175,7 @@ struct kunit_suite {
> > > >         void (*exit)(struct kunit *test);
> > > >         struct kunit_case *test_cases;
> > > >
> > > > -       /* private - internal use only */
> > > > +       /* private: internal use only */
> > > >         struct dentry *debugfs;
> > > >         char *log;
> > > >  };
> > > > @@ -232,7 +232,8 @@ void __kunit_test_suites_exit(struct kunit_suite **suites);
> > > >   * kunit_test_suites() - used to register one or more &struct kunit_suite
> > > >   *                      with KUnit.
> > > >   *
> > > > - * @suites: a statically allocated list of &struct kunit_suite.
> > > > + * @...: a statically allocated list of &struct kunit_suite, assigned
> > > > + *           to the pointer @suites.
> > > >   *
> > > >   * Registers @suites with the test framework. See &struct kunit_suite for
> > >
> > > Can you change the @suites param here to match @...?
> >
> > You mean, in "Registers @suites with the test framework" to something
> > rather like "Registers @... with"?
> > Hum, franckly I think, in the documentation it reads better having the
> > name "suites", that's why I tried to
> > append a hint, that a passed list of struct kunit_suite initializes
> > the pointer "suites". Then further in the doc
> > refered as suites, I think it becomes clear. But let me know. Shall I
> > use @... instead?
>
> I agree that it doesn't read as well, but I like having the proper
> syntax highlighting and consistent naming over a mix and match.

I'll have another look on the syntax highlighting, leave out the api page
removal and then resubmit. No problem. Thank you for all your patience!!
I really appreciate if I can contribute to something!


> Another alternative would be to replace `...` with `suites...` and
> then @suites should work.
>
> Either way is fine with me; it's a nasty macro anyway.

Yeah, that's what I read in the kernel-doc perl, too. Changing '...'
to 'suites...'
is a code change, though. Possible, but IMHO would be a different patch.
Actually, should we fix up the code for having a nicer documentation?!!

Somehow this feels like the next patches should go rather to sphinx/kernel-doc.
Anyway, this patch is all about documentation.
A code change must be tested and verified and IMHO might be a different story.

Happy Easter!
L
