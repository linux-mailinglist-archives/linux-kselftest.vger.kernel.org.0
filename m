Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A130362B1E
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Apr 2021 00:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbhDPWfk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Apr 2021 18:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbhDPWfk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Apr 2021 18:35:40 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05712C061756
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Apr 2021 15:35:14 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e14so648612ils.12
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Apr 2021 15:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B51c/BqaHfNTtYzOYpFOVFXi1kqJ4RIBeFUW0+vxzU0=;
        b=D8TMtRN2f+BOmEmMxcgaKyS1tDZSz5xJqlTgs5eb008iewzQgzWpztr+r+TOn4HTKx
         9H0Ou5VEYaqe2v8vv4I5OYxW1A0OvMK9hksHlV6+uier0nu1uvN1g4O92ltk4CY7Y36f
         mzICdTzce4q6PyvciJe1OZH0bRSGlkImohgs4jf0vl15HC2GoF5+wh+oPIrD0H0kBatC
         seIBaceTbS1HYcy5QjbGtE4MF7izCNcqrH8Jz/afnBOeBDLbKXHFAYsmkOZDETgMYvHw
         55XHkD+rmsHwFmBGqCE4AEXNaKyfHivKUA9j2y+KFpVi8miyDc1LJEx3KnyZqqIyLZOi
         Ap8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B51c/BqaHfNTtYzOYpFOVFXi1kqJ4RIBeFUW0+vxzU0=;
        b=t6ZuoetrXHDJHWrI1NIhoDnwgVpCMSzAsPLATSaj0YY80xVIS5lqbe7CW/oJJvzItS
         AjcN2EGEAkzud+yvXC2V/sweYr5fxk2qZG3eAcESDzM7gHDdijJBRUkU4dxQpQ2zR0ET
         kgPMr9xqVIVdMN/DgG59pj2oCLimzM7sRS1CRpQcc50qbu98UFUwAUwyteYU24H5ZjPi
         piM6pyLEmd/Cq1T3Ij+3Zygri2R9KZEomvU4/Xvzw+RJYRV/LIZ0ggQcxUFQHyKkH3R1
         8k6AGy0WRufLHk6CvicXp6pUYrrEL9OPwNfhy/rXh1cLbG5gx/5baJ9SJYcxLM/zhypg
         tdLg==
X-Gm-Message-State: AOAM532jOk1N0qxzlS7UU+LLsS78cGMP2ouCnhbi+w55V/XehkhNro+k
        yh13F9JVKVsZ3+mElHsHZWbEG/Nr6FZqXV8Gq78uFQ==
X-Google-Smtp-Source: ABdhPJxABqSye0Xo12YonCX/iGORjYyWK+4D5e9dXAP7FLcTjFOEup8GVPMUpzTg4T7wSU6cDNuu+q+JGXZaaUmBNaA=
X-Received: by 2002:a92:6011:: with SMTP id u17mr8880229ilb.274.1618612514119;
 Fri, 16 Apr 2021 15:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210416034036.797727-1-davidgow@google.com>
In-Reply-To: <20210416034036.797727-1-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 16 Apr 2021 15:35:03 -0700
Message-ID: <CAGS_qxonv3LZzmTH4A_Fa7+upfe4pZ=zBp97vDx6nVUqTv1Pbw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: Update kunit_tool page
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 15, 2021 at 8:40 PM David Gow <davidgow@google.com> wrote:
>
> The kunit_tool documentation page was pretty minimal, and a bit
> outdated. Update it and flesh it out a bit.
>
> In particular,
> - Mention that .kunitconfig is now in the build directory
> - Describe the use of --kunitconfig to specify a different config
>   framgent
> - Mention the split functionality (i.e., commands other than 'run')
> - Describe --raw_output and kunit.py parse
> - Mention the globbing support
> - Provide a quick overview of other options, including --build_dir and
>   --alltests
>
> Note that this does overlap a little with the new running_tips page. I
> don't think it's a problem having both: this page is supposed to be a
> bit more of a reference, rather than a list of useful tips, so the fact
> that they both describe the same features isn't a problem.
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

Looks good to me. I completely forgot to update this page when adding
blobs about the new features in running_tips.rst...
Two minor, optional nits.

> ---
>  Documentation/dev-tools/kunit/kunit-tool.rst | 132 ++++++++++++++++++-
>  1 file changed, 128 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/kunit-tool.rst b/Documentation/dev-tools/kunit/kunit-tool.rst
> index 29ae2fee8123..0b45affcd65c 100644
> --- a/Documentation/dev-tools/kunit/kunit-tool.rst
> +++ b/Documentation/dev-tools/kunit/kunit-tool.rst
> @@ -22,14 +22,19 @@ not require any virtualization support: it is just a regular program.
>  What is a .kunitconfig?
>  =======================
>
> -It's just a defconfig that kunit_tool looks for in the base directory.
> +It's just a defconfig that kunit_tool looks for in the build directory.

nit: should we mention this is .kunit here?
We don't mention this till the very bottom right now, which seems suboptimal.

I assume most people are going to still be fiddling with that
.kunitconfig rather than passing in --kunitconfig (I know I am).

>  kunit_tool uses it to generate a .config as you might expect. In addition, it
>  verifies that the generated .config contains the CONFIG options in the
>  .kunitconfig; the reason it does this is so that it is easy to be sure that a
>  CONFIG that enables a test actually ends up in the .config.
>
> -How do I use kunit_tool?
> -========================
> +It's also possible to pass a separate .kunitconfig fragment to kunit_tool,
> +which is useful if you have several different groups of tests you wish
> +to run independently, or if you want to use pre-defined test configs for
> +certain subsystems.
> +
> +Getting Started with kunit_tool
> +===============================
>
>  If a kunitconfig is present at the root directory, all you have to do is:
>
> @@ -48,10 +53,129 @@ However, you most likely want to use it with the following options:
>
>  .. note::
>         This command will work even without a .kunitconfig file: if no
> -        .kunitconfig is present, a default one will be used instead.
> +       .kunitconfig is present, a default one will be used instead.
> +
> +If you wish to use a different .kunitconfig file (such as one provided for
> +testing a particular subsystem), you can pass it as an option.
> +
> +.. code-block:: bash
> +
> +       ./tools/testing/kunit/kunit.py run --kunitconfig=fs/ext4/.kunitconfig
>
>  For a list of all the flags supported by kunit_tool, you can run:
>
>  .. code-block:: bash
>
>         ./tools/testing/kunit/kunit.py run --help
> +
> +Configuring, Building, and Running Tests
> +========================================
> +
> +It's also possible to run just parts of the KUnit build process independently,
> +which is useful if you want to make manual changes to part of the process.
> +
> +A .config can be generated from a .kunitconfig by using the ``config`` argument
> +when running kunit_tool:
> +
> +.. code-block:: bash
> +
> +       ./tools/testing/kunit/kunit.py config
> +
> +Similarly, if you just want to build a KUnit kernel from the current .config,
> +you can use the ``build`` argument:
> +
> +.. code-block:: bash
> +
> +       ./tools/testing/kunit/kunit.py build
> +
> +And, if you already have a built UML kernel with built-in KUnit tests, you can
> +run the kernel and display the test results with the ``exec`` argument:
> +
> +.. code-block:: bash
> +
> +       ./tools/testing/kunit/kunit.py exec
> +
> +The ``run`` command which is discussed above is equivalent to running all three
> +of these in sequence.
> +
> +All of these commands accept a number of optional command-line arguments. The
> +``--help`` flag will give a complete list of these, or keep reading this page
> +for a guide to some of the more useful ones.
> +
> +Parsing Test Results
> +====================
> +
> +KUnit tests output their results in TAP (Test Anything Protocol) format.
> +kunit_tool will, when running tests, parse this output and print a summary
> +which is much more pleasant to read. If you wish to look at the raw test
> +results in TAP format, you can pass the ``--raw_output`` argument.
> +
> +.. code-block:: bash
> +
> +       ./tools/testing/kunit/kunit.py run --raw_output
> +
> +.. note::
> +       The raw output from test runs may contain other, non-KUnit kernel log
> +       lines.
> +
> +If you have KUnit results in their raw TAP format, you can parse them and print
> +the human-readable summary with the ``parse`` command for kunit_tool. This
> +accepts a filename for an argument, or will read from standard input.
> +
> +.. code-block:: bash
> +
> +       # Reading from a file
> +       ./tools/testing/kunit/kunit.py parse /var/log/dmesg
> +       # Reading from stdin
> +       dmesg | ./tools/testing/kunit/kunit.py parse
> +
> +This is very useful if you wish to run tests in a configuration not supported
> +by kunit_tool (such as on real hardware, or an unsupported architecture).
> +
> +Filtering Tests
> +===============
> +
> +It's possible to run only a subset of the tests built into a kernel by passing
> +a filter to the ``exec`` or ``run`` commands. For example, if you only wanted
> +to run KUnit resource tests, you could use:
> +
> +.. code-block:: bash
> +
> +       ./tools/testing/kunit/kunit.py run 'kunit-resource*'
> +
> +This uses the standard glob format for wildcards.
> +
> +Other Useful Options
> +====================
> +
> +kunit_tool has a number of other command-line arguments which can be useful
> +when adapting it to fit your environment or needs.
> +
> +Some of the more useful ones are:
> +
> +``--help``
> +       Lists all of the available options. Note that different commands
> +       (``config``, ``build``, ``run``, etc) will have different supported
> +       options. Place ``--help`` before the command to list common options,
> +       and after the command for options specific to that command.
> +
> +``--build_dir``
> +       Specifies the build directory that kunit_tool will use. This is where
> +       the .kunitconfig file is located, as well as where the .config and
> +       compiled kernel will be placed. Defaults to ``.kunit``.
> +
> +``--make_options``
> +       Specifies additional options to pass to ``make`` when compiling a
> +       kernel (with the ``build`` or ``run`` commands). For example, to enable
> +       compiler warnings, you can pass ``--make_options W=1``.
> +
> +``--alltests``
> +       Builds a UML kernel with all config options enabled using
> +       ``make allyesconfig``. This allows you to run as many tests as is
> +       possible, but is very slow and prone to breakage as new options are
> +       added or modified. Most people should add ``CONFIG_KUNIT_ALL_TESTS=1``
> +       to their .kunitconfig instead if they wish to run "all tests".

Should we note here that CONFIG_KUNIT_ALL_TESTS will not select tests
that have unmet dependencies?

> +
> +
> +There are several other options (and new ones are often added), so do check
> +``--help`` if you're looking for something not mentioned here.
> --
> 2.31.1.368.gbe11c130af-goog
>
