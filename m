Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5371A2AB5
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Apr 2020 22:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbgDHU41 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Apr 2020 16:56:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38000 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729034AbgDHU40 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Apr 2020 16:56:26 -0400
Received: by mail-pf1-f194.google.com with SMTP id c21so3002453pfo.5
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Apr 2020 13:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MvCFCDSYuLWm2avQPTX7xhoPY1ZYQ1doKH0hM1asDtU=;
        b=uo9473Z0UV60+s6YggKaqUWrjYkXI1Ghdg/Ri5W4zuVc+jev88N/sT8zKEKwF+VSj6
         /ps8NJbTxieO3AQv2Ysn+cxj51aDo4efBzXUZqd0n7kM8b6gAgV/3/CGzr+4qhhGFWDC
         k/4N8eUas9RiOili2+cE2AXEs/mK1XgofXPorQ++C2U/lbbU0YGKnD31VOzbguH0FoG8
         GdbTSLctEoLJj56r81Uu1SKALbyje2EzG8agR4dHxn0BLgoCAyeUm9pdABfmd9iPsgu3
         KbpGLxD7E/InAHcajbUfArTzP3cTcE7/x5C5fyoKZsvdENx8fo/as4eGu7G6PySzUMM/
         6ujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MvCFCDSYuLWm2avQPTX7xhoPY1ZYQ1doKH0hM1asDtU=;
        b=NnynslVdIOjRnObbFPrptwntAtEV0lM3S4iXUql5JbDccwIn0NhaN2H1lb1lCZwIEK
         UyeoGQnitDxnmRNet51r3a+iftAs5moxKDNs7DjRWDLwGhsO4r3qjRERYETp2wcXWh4m
         b8vv7EWnp9b2c4+e6kvS2u7J55yFNW6S8GKcqsCym6NG29+OIpUb0/lyZKQr/0rbOo0N
         rypVKbB5yx4Lhg4llW9JLrAyaptR0DP72CRdMKUEq1dlFwuBJGe3dqqAd6//WMj0JjOr
         2lqbk4tPOHDxhXMG0OnCoRthGLhIxuZRzUj1BzdrsgAlFOsXYbals3DQTMvOlLU2AGyn
         Sw6g==
X-Gm-Message-State: AGi0PubVCqlS1BubDwSN/KftUIxjXK+H7zqgTQ4yHLG4Lf4EDVNllFbU
        hfDj0SVq04ds6jgIFVN8yY62zCY13yQCcW/ghzMppg==
X-Google-Smtp-Source: APiQypLLlGTCdzsuAq+pfSePDC8fTUjPf4BPR43c2iJtFlkUcGmR3GF+X1cuxz8pUSpoNiWa6alDDHGYV1W2WtPCTHA=
X-Received: by 2002:aa7:9a5d:: with SMTP id x29mr9111777pfj.284.1586379384667;
 Wed, 08 Apr 2020 13:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200408205024.22119-1-l.rubusch@gmail.com>
In-Reply-To: <20200408205024.22119-1-l.rubusch@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 8 Apr 2020 13:56:13 -0700
Message-ID: <CAFd5g47O07Gk6BixQV6iQpcERU_xVbBtRaUyXGaOO7Axcma+iQ@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: test.h - fix warnings
To:     Lothar Rubusch <l.rubusch@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 8, 2020 at 1:50 PM Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> Fix warnings at 'make htmldocs', and formatting issues in the resulting
> documentation.
>
> - test.h: Fix some typos in kernel-doc parameter description.
>
> - Documentation/*.rst: Fixing formatting issues, and a duplicate label
>   issue, since using sphinx.ext.autosectionlabel in conf.py, referes to
>   headers are generated automatically and sphinx will not complain about
>   identical headers among documents anymore.
>
>   The downside is, automatically generated header labels within one
>   document now cannot be overwritten manually anymore. Thus duplicate
>   headers within one document have to have different wording, i.e. this
>   patch modifies some headers.
>
> - Documentation/api/*: Flipping over to a page "API" containing a single
>   link to another page "API" seems like a formatting issue. The patch
>   removes one level of indirection.
>
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>

A couple of minor comments, but other than that:

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!

> ---
>  Documentation/dev-tools/kunit/api/index.rst | 16 ----------------
>  Documentation/dev-tools/kunit/index.rst     |  4 ++--
>  Documentation/dev-tools/kunit/start.rst     | 13 ++++++++-----
>  Documentation/dev-tools/kunit/usage.rst     |  4 ++--
>  include/kunit/test.h                        |  5 +++--
>  5 files changed, 15 insertions(+), 27 deletions(-)
>  delete mode 100644 Documentation/dev-tools/kunit/api/index.rst
>
> diff --git a/Documentation/dev-tools/kunit/api/index.rst b/Documentation/dev-tools/kunit/api/index.rst
> deleted file mode 100644
> index 9b9bffe5d41a..000000000000
> --- a/Documentation/dev-tools/kunit/api/index.rst
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -.. SPDX-License-Identifier: GPL-2.0
> -
> -=============
> -API Reference
> -=============
> -.. toctree::
> -
> -       test
> -
> -This section documents the KUnit kernel testing API. It is divided into the
> -following sections:
> -
> -================================= ==============================================
> -:doc:`test`                       documents all of the standard testing API
> -                                  excluding mocking or mocking related features.
> -================================= ==============================================

Let's hold off on this. We have some other pages we would like to add
to this directory soonish.

> diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
> index e93606ecfb01..640bba1f4896 100644
> --- a/Documentation/dev-tools/kunit/index.rst
> +++ b/Documentation/dev-tools/kunit/index.rst
> @@ -10,7 +10,7 @@ KUnit - Unit Testing for the Linux Kernel
>         start
>         usage
>         kunit-tool
> -       api/index
> +       api/test
>         faq
>
>  What is KUnit?
> @@ -88,6 +88,6 @@ How do I use it?
>
>  *   :doc:`start` - for new users of KUnit
>  *   :doc:`usage` - for a more detailed explanation of KUnit features
> -*   :doc:`api/index` - for the list of KUnit APIs used for testing
> +*   :doc:`api/test` - for the list of KUnit APIs used for testing
>  *   :doc:`kunit-tool` - for more information on the kunit_tool helper script
>  *   :doc:`faq` - for answers to some common questions about KUnit
> diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> index e1c5ce80ce12..bb112cf70624 100644
> --- a/Documentation/dev-tools/kunit/start.rst
> +++ b/Documentation/dev-tools/kunit/start.rst
> @@ -32,15 +32,17 @@ test targets as well. The ``.kunitconfig`` should also contain any other config
>  options required by the tests.
>
>  A good starting point for a ``.kunitconfig`` is the KUnit defconfig:
> +
>  .. code-block:: bash
>
>         cd $PATH_TO_LINUX_REPO
>         cp arch/um/configs/kunit_defconfig .kunitconfig
>
>  You can then add any other Kconfig options you wish, e.g.:
> +
>  .. code-block:: none
>
> -        CONFIG_LIST_KUNIT_TEST=y
> +       CONFIG_LIST_KUNIT_TEST=y
>
>  :doc:`kunit_tool <kunit-tool>` will ensure that all config options set in
>  ``.kunitconfig`` are set in the kernel ``.config`` before running the tests.
> @@ -54,8 +56,8 @@ using.
>     other tools (such as make menuconfig) to adjust other config options.
>
>
> -Running the tests
> ------------------
> +Running the tests (KUnit Wrapper)
> +---------------------------------
>
>  To make sure that everything is set up correctly, simply invoke the Python
>  wrapper from your kernel repo:
> @@ -105,8 +107,9 @@ have config options ending in ``_KUNIT_TEST``.
>  KUnit and KUnit tests can be compiled as modules: in this case the tests in a
>  module will be run when the module is loaded.
>
> -Running the tests
> ------------------
> +
> +Running the tests (w/o KUnit Wrapper)
> +-------------------------------------
>
>  Build and run your kernel as usual. Test output will be written to the kernel
>  log in `TAP <https://testanything.org/>`_ format.
> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> index 473a2361ec37..3c3fe8b5fecc 100644
> --- a/Documentation/dev-tools/kunit/usage.rst
> +++ b/Documentation/dev-tools/kunit/usage.rst
> @@ -595,7 +595,7 @@ able to run one test case per invocation.
>  KUnit debugfs representation
>  ============================
>  When kunit test suites are initialized, they create an associated directory
> -in /sys/kernel/debug/kunit/<test-suite>.  The directory contains one file
> +in ``/sys/kernel/debug/kunit/<test-suite>``.  The directory contains one file
>
>  - results: "cat results" displays results of each test case and the results
>    of the entire suite for the last test run.
> @@ -604,4 +604,4 @@ The debugfs representation is primarily of use when kunit test suites are
>  run in a native environment, either as modules or builtin.  Having a way
>  to display results like this is valuable as otherwise results can be
>  intermixed with other events in dmesg output.  The maximum size of each
> -results file is KUNIT_LOG_SIZE bytes (defined in include/kunit/test.h).
> +results file is KUNIT_LOG_SIZE bytes (defined in ``include/kunit/test.h``).
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 9b0c46a6ca1f..16d548b795b5 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -175,7 +175,7 @@ struct kunit_suite {
>         void (*exit)(struct kunit *test);
>         struct kunit_case *test_cases;
>
> -       /* private - internal use only */
> +       /* private: internal use only */
>         struct dentry *debugfs;
>         char *log;
>  };
> @@ -232,7 +232,8 @@ void __kunit_test_suites_exit(struct kunit_suite **suites);
>   * kunit_test_suites() - used to register one or more &struct kunit_suite
>   *                      with KUnit.
>   *
> - * @suites: a statically allocated list of &struct kunit_suite.
> + * @...: a statically allocated list of &struct kunit_suite, assigned
> + *           to the pointer @suites.
>   *
>   * Registers @suites with the test framework. See &struct kunit_suite for

Can you change the @suites param here to match @...?

Thanks!
