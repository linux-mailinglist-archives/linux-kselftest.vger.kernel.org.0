Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498AB62625B
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 20:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiKKTq6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Nov 2022 14:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbiKKTq5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Nov 2022 14:46:57 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FA5814CE
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 11:46:55 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-3775545dc24so52853977b3.7
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 11:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hUXj6QvMvp2Xsk8iWHjCnyx8X7wa/GVmJuhEaVWwu6I=;
        b=eHY7jUV3JXvTwN7MxgMWdEK/0wauFgYNvyL5InzGUHXvPz6LxFghn1ozPFbbADEuvZ
         M7nzfVSDQSJT4sJvL9lvh2Gsbd8yodAv8rjYWpZJooXA6CQftKzg44u6383mPdmBzPbl
         L4rPPP2JX6wC+FwAfjX5NCsf9gGbM4DJWpUsvPQReuXhHh9RkbFeEsOyZRnN7AhyG3Av
         oMXR0nqVOfHOsBdP3IoxsbWxPtuKX3bwgUSGYggMkMs4TCVs1x2gnZHQ5BLyldgNRqWI
         yc0cCh3Abjjh8NPIWIan9kdZ5avpChf7bZgdX5HPZX0mPDtnNC2G08sBDDimugEyfBJO
         jZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hUXj6QvMvp2Xsk8iWHjCnyx8X7wa/GVmJuhEaVWwu6I=;
        b=q56BOWdeN7LxvYooOcBzSBh9bZpfxxibXlVXP+s33BScM45MMd8ssPbDJ5tawnSuKH
         BtNu5RdE/kAwSPCisaRJIr1UTRIb080iJYcRaLi6erZCXTLWMfpoPOBL43GmU+Up1scg
         6uHcQGkei6VMIG0jCgCgFM+NFg0P8v5zxJSCLuUjJTlTrasttn30lW90Y0YbqJ5Oxuvm
         FBnYY4ERh/be9Hmhm3wkHHpS1INV0XVhuSpBYYSj8nQWZEgPp3E4gksRwSokYed3pgg/
         aV8KmWUm1L14UHduoXrFROV42DJxz/IV3Z2e1ZgBTRLagx3tpl8hW8zSFJox4jWqMb1h
         8H6Q==
X-Gm-Message-State: ANoB5plb3uk4Js0up/LRq1vMTJXZEmPCoiUiafcpVQEflaoq/l2xTrvt
        H7fT5Z7mbbJdg7UsJyEgndganoPySPAnK0VFlQfWTw==
X-Google-Smtp-Source: AA0mqf5PU6qyEuVDV/AVBSjMh3yPpQcoM9M9i/Ut9UDBhIamz+qDHxW360zJRUCT6v35yEAIzn1sLOd3QNNbucyWQVM=
X-Received: by 2002:a81:6f83:0:b0:36d:fc95:71af with SMTP id
 k125-20020a816f83000000b0036dfc9571afmr3194883ywc.394.1668196014203; Fri, 11
 Nov 2022 11:46:54 -0800 (PST)
MIME-Version: 1.0
References: <20221023125414.60961-1-bagasdotme@gmail.com> <20221023125414.60961-4-bagasdotme@gmail.com>
In-Reply-To: <20221023125414.60961-4-bagasdotme@gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 11 Nov 2022 11:46:42 -0800
Message-ID: <CAGS_qxp_uR7zQDof-=CWQLbm+8gtb_FbJW-fQfG5E7O76Rh2bw@mail.gmail.com>
Subject: Re: [PATCH 3/7] Documentation: kunit: rewrite the rest of "Getting
 Started" documentation
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Jonathan Corbet <corbet@lwn.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Khalid Masum <khalid.masum.92@gmail.com>,
        Sadiya Kazi <sadiyakazi@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Oct 23, 2022 at 5:55 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> Rewrite the rest of "Getting Started" documentation for clarity. Major
> points:
>
>   * link to "Build directory for the kernel" section of kernel README
>     for the caveats.
>   * To change kernel configurations in .kunitconfig, use configuration
>     interfaces just like configuring normal kernel.
>   * Remove "Next steps" section as it will be placed on the introduction
>     page.
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Meta note: I like a number of the smaller changes across this series,
but some of the others are more debatable.

I personally think it might be easier to land this series by pulling
out some of those smaller changes instead.

> ---
>  Documentation/admin-guide/README.rst    |   2 +
>  Documentation/dev-tools/kunit/start.rst | 210 ++++++++++--------------
>  2 files changed, 93 insertions(+), 119 deletions(-)
>
> diff --git a/Documentation/admin-guide/README.rst b/Documentation/admin-guide/README.rst
> index 9a969c0157f1e5..f3cdc8496da03f 100644
> --- a/Documentation/admin-guide/README.rst
> +++ b/Documentation/admin-guide/README.rst
> @@ -123,6 +123,8 @@ Software requirements
>     you can just update packages when obvious problems arise during
>     build or operation.
>
> +.. _kernel-build-directory:
> +
>  Build directory for the kernel
>  ------------------------------
>
> diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> index cdf043b6550e66..1195d5de53343e 100644
> --- a/Documentation/dev-tools/kunit/start.rst
> +++ b/Documentation/dev-tools/kunit/start.rst
> @@ -4,178 +4,164 @@
>  Getting Started
>  ===============
>
> -This page contains an overview of the kunit_tool and KUnit framework,
> -teaching how to run existing tests and then how to write a simple test case,
> -and covers common problems users face when using KUnit for the first time.
> +This guide is an overview of KUnit framework. It teaches how to run tests
> +with kunit_tool as well as writing a simple test case.

Hmm, this page doesn't actually give an overview of the KUnit
framework (the in-kernel component).
If we're rewording this section, we should probably correct that.

Perhaps instead something like:

This page goes over how to run existing KUnit tests and how to write a
simple test case.

>
> -Installing Dependencies
> -=======================
> -KUnit has the same dependencies as the Linux kernel. As long as you can
> -build the kernel, you can run KUnit.
> +Prerequisites
> +=============
> +No extra dependencies are required in order to use KUnit. See
> +:doc:`/process/changes` for details.

Nice, I like this new wording a lot more.

>
>  Running tests with kunit_tool
>  =============================
> -kunit_tool is a Python script, which configures and builds a kernel, runs
> -tests, and formats the test results. From the kernel repository, you
> -can run kunit_tool:
> +kunit_tool is a wrapper script written in Python. It configures and builds
> +the kernel, runs tests, and formats the results. To run the script:

I don't think readers will know what "a wrapper script" is here.
It's unfortunate that the page about it is called run_wrapper.rst.
Perhaps "helper script" would be less confusing?

>
>  .. code-block:: bash
>
>         ./tools/testing/kunit/kunit.py run
>
>  .. note ::
> -       You may see the following error:
> -       "The source tree is not clean, please run 'make ARCH=um mrproper'"
> +       You may see the following error::
>
> -       This happens because internally kunit.py specifies ``.kunit``
> -       (default option) as the build directory in the command ``make O=output/dir``
> -       through the argument ``--build_dir``.  Hence, before starting an
> -       out-of-tree build, the source tree must be clean.
> +           The source tree is not clean, please run 'make ARCH=um mrproper'
>
> -       There is also the same caveat mentioned in the "Build directory for
> -       the kernel" section of the :doc:`admin-guide </admin-guide/README>`,
> -       that is, its use, it must be used for all invocations of ``make``.
> -       The good news is that it can indeed be solved by running
> -       ``make ARCH=um mrproper``, just be aware that this will delete the
> -       current configuration and all generated files.
> +        This happens because internally kunit_tool passes the default build
> +        directory ``.kunit`` as environment variable to make (which is invoked
> +        as ``make O=.kunit``). A different build directory can be specified by
> +        passing ``--build_dir`` option. Hence, before starting the build,
> +        the source tree must be clean.

The existing section is too long, so making it shorter sounds good to me.

But this new wording almost sounds like it's telling users to try
changing --build_dir to workaround the error?

>
> -If everything worked correctly, you should see the following:
> +       The caveat from the :ref:`kernel-build-directory`
> +        also applies to running kunit_tool.
>
> -.. code-block::
> +If everything worked correctly, you should see the following output::
>
>         Configuring KUnit Kernel ...
>         Building KUnit Kernel ...
>         Starting KUnit Kernel ...
>
> -The tests will pass or fail.
> +.. note ::
> +        Depending on configurations enabled in the kernel, the build process
> +        may take a while.

I don't think this is relevant here.
We're telling users to run kunit.py with no arguments and we haven't
yet told them how to tweak .kunitconfig.

So the thing causing long compiles won't be "configurations enabled in
the kernel."
It'll be the fact we're using an empty build dir (.kunit/) and have to
rebuild everything from scratch.

> +
> +See Documentation/dev-tools/kunit/run_wrapper.rst for details.
> +
> +Selecting tests
> +---------------
> +
> +By default, kunit_tool runs all tests using default configuration (defconfig).

I agree that the existing wording is perhaps too confusing, but this
new one is incorrect/misleading.
What we're running by default is basically defconfig + CONFIG_KUNIT_ALL_TESTS=y.

Given the target audience for this document includes people who have
never done kernel development before, I think we want to be very
careful about misleading them.

> +The following subsections allow you to customize the configuration as well as
> +filtering the test that will be run.
>
>  .. note ::
> -   Because it is building a lot of sources for the first time,
> -   the ``Building KUnit Kernel`` step may take a while.
> +        KUnit by default runs tests for UML architecture (``ARCH=um``). If you
> +        need to run test on other architectures see :ref:`kunit-on-qemu`.
>
> -For detailed information on this wrapper, see:
> -Documentation/dev-tools/kunit/run_wrapper.rst.
> -
> -Selecting which tests to run
> -----------------------------
> -
> -By default, kunit_tool runs all tests reachable with minimal configuration,
> -that is, using default values for most of the kconfig options.  However,
> -you can select which tests to run by:
> -
> -- `Customizing Kconfig`_ used to compile the kernel, or
> -- `Filtering tests by name`_ to select specifically which compiled tests to run.
> -
> -Customizing Kconfig
> -~~~~~~~~~~~~~~~~~~~
> -A good starting point for the ``.kunitconfig`` is the KUnit default config.
> -If you didn't run ``kunit.py run`` yet, you can generate it by running:
> +Kernel configuration
> +~~~~~~~~~~~~~~~~~~~~
> +A good starting point for the ``.kunitconfig`` is the KUnit default config,
> +which can be generated by:
>
>  .. code-block:: bash
>
> -       cd $PATH_TO_LINUX_REPO
> -       tools/testing/kunit/kunit.py config
> -       cat .kunit/.kunitconfig
> +       ./tools/testing/kunit/kunit.py config
>
>  .. note ::
> -   ``.kunitconfig`` lives in the ``--build_dir`` used by kunit.py, which is
> -   ``.kunit`` by default.
> +   ``.kunitconfig`` is located in the directory specified by ``--build_dir``
> +   argument. The default build directory is ``.kunit``.
>
> -Before running the tests, kunit_tool ensures that all config options
> -set in ``.kunitconfig`` are set in the kernel ``.config``. It will warn
> -you if you have not included dependencies for the options used.
> +Before running the tests, kunit_tool ensures that all options set in
> +``.kunitconfig`` are set in the ``.config`` used for kernel build process. It
> +will errored if you have not enabled option dependencies for all selected
> +options.

This new wording has a number of small grammatical errors, so we'd
want to tweak it a bit.

Focusing on the semantic change: I don't know if  ".config used for
kernel build process" is actually much clearer than "kernel .config".
So I would prefer we keep the original wording in this case.

>
>  There are many ways to customize the configurations:
>
> -a. Edit ``.kunit/.kunitconfig``. The file should contain the list of kconfig
> +a. Edit the configuration. ``.kunitconfig`` should contains configuration

I prefer the original wording here. It's more clear what exactly it's
asking you to edit.

I also think reinforcing that the file is located under .kunit/ is important.
Yes, it might not be the right path if the user has changed the
--build_dir, but in the context of this guide (a user running kunit.py
for the first time), it will be correct.

>     options required to run the desired tests, including their dependencies.
> -   You may want to remove CONFIG_KUNIT_ALL_TESTS from the ``.kunitconfig`` as
> -   it will enable a number of additional tests that you may not want.
> -   If you need to run on an architecture other than UML see :ref:`kunit-on-qemu`.

It looks like this change deletes the link to kunit-on-qemu?
I think that's useful to have somewhere in the start page, since some
users will quickly run into the fact that the code they care about
won't work on UML.

> -
> -b. Enable additional kconfig options on top of ``.kunit/.kunitconfig``.
> -   For example, to include the kernel's linked-list test you can run::
> +   As with other kernel configurations, it is recommended to use :doc:`one of
> +   configuration interfaces </kbuild/kconfig>`, passing
> +   ``KCONFIG_CONFIG=.kunit/.kunitconfig`` target variable to make. You may
> +   want to disable ``CONFIG_KUNIT_ALL_TESTS`` as it will enable a number of
> +   additional tests that you may not want to be run.

I feel like mentioning KCONFIG_CONFIG might be useful to have on this page.
But I think the current wording doesn't work for either audience:
a) experienced kernels devs - they already know this information.
b) new kernel devs - they don't know how to use this information.

I think it might be better if this gave a more concrete example like
using `make menuconfig`.

> +
> +b. Add options with ``--kconfig_add``. For example, to include the
> +   linked-list test you can run::

Nice, b) and c) are a lot better.
I didn't realize how verbose these sections had become.

>
>         ./tools/testing/kunit/kunit.py run \
>                 --kconfig_add CONFIG_LIST_KUNIT_TEST=y
>
> -c. Provide the path of one or more .kunitconfig files from the tree.
> -   For example, to run only ``FAT_FS`` and ``EXT4`` tests you can run::
> +c. Pass the path to one or more .kunitconfig files from the tree.
> +   For example, to run only ``FAT_FS`` and ``EXT4`` tests::
>
>         ./tools/testing/kunit/kunit.py run \
>                 --kunitconfig ./fs/fat/.kunitconfig \
>                 --kunitconfig ./fs/ext4/.kunitconfig
>
> -d. If you change the ``.kunitconfig``, kunit.py will trigger a rebuild of the
> -   ``.config`` file. But you can edit the ``.config`` file directly or with
> -   tools like ``make menuconfig O=.kunit``. As long as its a superset of
> -   ``.kunitconfig``, kunit.py won't overwrite your changes.
> -
> -
>  .. note ::
>
> -       To save a .kunitconfig after finding a satisfactory configuration::
> -
> -               make savedefconfig O=.kunit
> -               cp .kunit/defconfig .kunit/.kunitconfig
> +        If you change the ``.kunitconfig``, kunit_tool will resynchronize

nit: I think `rebuild` or `regenerate` would be better.
We recreate the file from scratch, which isn't clear from "resynchronize."

In fact, I might expect that kunit.py is trying to be more clever when
"synchronizing" the files by editing the .config itself.

> +        ``.config``, which can be edited. As long as it is a superset of
> +        ``.kunitconfig``, kunit.py won't overwrite your changes in ``.config``

Perhaps instead this section could be rewritten more like

note::
  You can also edit the ``.config`` file directly. As long as it is a
superset of ``.kunitconfig``, kunit.py won't overwrite your changes.
Otherwise, kunit.py will regenerate the ``.config`` file.

>
>  Filtering tests by name
>  ~~~~~~~~~~~~~~~~~~~~~~~
> -If you want to be more specific than Kconfig can provide, it is also possible
> -to select which tests to execute at boot-time by passing a glob filter
> -(read instructions regarding the pattern in the manpage :manpage:`glob(7)`).
> -If there is a ``"."`` (period) in the filter, it will be interpreted as a
> -separator between the name of the test suite and the test case,
> -otherwise, it will be interpreted as the name of the test suite.
> -For example, let's assume we are using the default config:
> +It is also possible to select which tests to execute at boot-time by passing
> +a glob filter (see :manpage:`glob(7)` for details).
> +If there is a period (``.``) in the filter, it will be interpreted as a
> +separator between the name of the test suite and the test case; otherwise it
> +will be interpreted as the name of the test suite.
>
> -a. inform the name of a test suite, like ``"kunit_executor_test"``,
> -   to run every test case it contains::
> +The complete ways to specify the tests are:

Nit: I don't know what "complete" means here.
I think just "For example:" works better.

> +
> +a. Pass the test suite name to run every case in that test::
>
>         ./tools/testing/kunit/kunit.py run "kunit_executor_test"
>
> -b. inform the name of a test case prefixed by its test suite,
> -   like ``"example.example_simple_test"``, to run specifically that test case::
> +b. Pass the fully qualified name of test case to run the specific case::

Nice, using "Pass" instead of "inform" is a big improvement.

>
>         ./tools/testing/kunit/kunit.py run "example.example_simple_test"
>
> -c. use wildcard characters (``*?[``) to run any test case that matches the pattern,
> -   like ``"*.*64*"`` to run test cases containing ``"64"`` in the name inside
> -   any test suite::
> +c. Use wildcard characters (``*?[``) to run any test case that matches the
> +   pattern.  For example, ``"*.*64*"`` matches test case names that contain
> +   "64" across any test suite::
>
>         ./tools/testing/kunit/kunit.py run "*.*64*"
>
> -Running Tests without the KUnit Wrapper
> -=======================================
> -If you do not want to use the KUnit Wrapper (for example: you want code
> -under test to integrate with other systems, or use a different/
> +Running tests without kunit_tool
> +================================
> +If you do not want to use kunit_tool (e.g. you want the tested code
> +to be integrated with other systems, or use different/

Hmm, the existing wording was a bit wrong, in my opinion.
The "tested code" is kernel code. It doesn't "integrate with other systems."

It's trying to refer to when you want to integrate KUnit tests into
other systems, such as LKFT, KernelCI, IGT, etc.

I don't have a good suggestion of how we can reword this at the moment, though.

>  unsupported architecture or configuration), KUnit can be included in
> -any kernel, and the results are read out and parsed manually.
> +any kernel code. The results can then be read out and parsed manually.

Nit: "any kernel" is more appropriate.
The key point is you can enable and run KUnit tests in ~any kind of
kernel you build.

>
>  .. note ::
>     ``CONFIG_KUNIT`` should not be enabled in a production environment.
>     Enabling KUnit disables Kernel Address-Space Layout Randomization
> -   (KASLR), and tests may affect the state of the kernel in ways not
> -   suitable for production.
> +   (KASLR) and tests may affect the state of the kernel in ways not
> +   suitable for production (like performance issues).
>
> -Configuring the Kernel
> +Configuring the kernel
>  ----------------------
> -To enable KUnit itself, you need to enable the ``CONFIG_KUNIT`` Kconfig
> -option (under Kernel Hacking/Kernel Testing and Coverage in
> -``menuconfig``). From there, you can enable any KUnit tests. They
> -usually have config options ending in ``_KUNIT_TEST``.
> +To enable KUnit itself, you need to enable the ``CONFIG_KUNIT``
> +option (the entry is under
> +:menuselection:`Kernel Hacking -> Kernel Testing and Coverage`).
> +You can enable any tests that you want to be run. These
> +configuration usually have ``_KUNIT_TEST`` suffix.

nit:
These options usually have a ``_KUNIT_TEST`` suffix.

>
> -KUnit and KUnit tests can be compiled as modules. The tests in a module
> -will run when the module is loaded.
> +Just like any other configuration options, KUnit and KUnit tests can be
> +built as modules. The tests in the module will be run when the module is
> +loaded.
>
> -Running Tests (without KUnit Wrapper)
> --------------------------------------
> -Build and run your kernel. In the kernel log, the test output is printed
> -out in the TAP format. This will only happen by default if KUnit/tests
> -are built-in. Otherwise the module will need to be loaded.
> +Running tests
> +-------------

After this change the link to this section becomes start.html#running-tests.
I don't want readers getting a link to that and thinking this is the
"expected" way to run KUnit tests. (People aren't necessarily going to
read the rest of this page).

If we manually define the anchor name, renaming this subsection sounds
good to me, though.

> +Build and run your kernel as usual. If KUnit and the tests are built as
> +modules, these need to be loaded first. The test results are logged (printed
> +out) in the TAP format.

I don't think "logged (printed out)" is clearer than just picking one
of "logged" or "printed out."

>
>  .. note ::
> -   Some lines and/or data may get interspersed in the TAP output.
> +   Some lines and/or data may get interspersed in the output.

I don't think we should make this change.
It's all "output", both the TAP output that we care about and the
random "lines and/or data."

Daniel
