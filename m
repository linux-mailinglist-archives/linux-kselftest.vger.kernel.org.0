Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB3C15B6BA
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2020 02:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgBMBct (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Feb 2020 20:32:49 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:41564 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbgBMBct (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Feb 2020 20:32:49 -0500
Received: by mail-yb1-f196.google.com with SMTP id j11so2167500ybt.8;
        Wed, 12 Feb 2020 17:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dhnLyLtzCBp+v3ahndWB6rBDN/p24N6aG9EajFLztZg=;
        b=N3BYOuDo9wa34k9lO7AeyCUARyKWoBa8H8aR2LXvx6n+lpd1xv0TnkBFbtsW4M5UT5
         yfFhxtGBXH23Nc85l6JGv83I+1c5l5Xg9UaiF3x0cN9uE3UUZU4HwdUEXzt5lD4By57z
         CwXtPqTY5JWhq8R9wuWE3ldobONCLayhxwQpgsdaN46XOfZJWbDVbnqr1PC9ktfJ8MNc
         mOMEh9BxUNq17PoMdkvxv8mBe0plmRfe0s2kthOQplvDMedy8DdKxBPZcLaSgJvvjO2X
         H2AluanydlHwjoeRBElTU0T/Mea+gIFo2MLkEe0wZgajxDb4fXMsiU6XnbV+B5i+qsZ+
         963g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dhnLyLtzCBp+v3ahndWB6rBDN/p24N6aG9EajFLztZg=;
        b=dQ5Z4EAJ7FVtnWj5GS1XU2uw6nlfUPZoM32MMq4MLqI2rJs5gz+YLXHVUNW6fBQjNS
         84yndlJFLTcDD5Nwrwh4fhdKvo7GH+SC1P03hWWYlH2z5DJMPpTAmURLwSjeZd8Fders
         0Esrm3pLJ9MhJE6fgwMOeiCXU47ylzoTmP9LXUOTcmN6GN1zMR6g7nCMhC89rtii2FPd
         +Y4L0ItcmECXE/8dB6nH28V9LveZJuiw9LitIQlwP5x4aX9AZMSsCAPDpucXHZ8knWe5
         n01cRgDCiIkLZBeraA/7+FA7skP864T4CvDpiAc+4F0OvQclYABwyTQreJObWpBH/UQ/
         P8iQ==
X-Gm-Message-State: APjAAAVBAH6+6Qh9m0RxeZqiQV3EO8Jqr8QKjUKsg3X6hboJQFnsggMu
        gAW/x5J4F+OFhcfo1p2ddg8=
X-Google-Smtp-Source: APXvYqw7GdOeHYyWDPeSu+rx3Sfwr2RzRqSYTjPHe4XQOE1Ngw7dxfc9JZdzuR62A4Abct5mdhLL5w==
X-Received: by 2002:a05:6902:4a8:: with SMTP id r8mr13714586ybs.476.1581557567800;
        Wed, 12 Feb 2020 17:32:47 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id x184sm430687ywg.4.2020.02.12.17.32.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Feb 2020 17:32:47 -0800 (PST)
Subject: Re: [PATCH v2] Documentation: kunit: Make the KUnit documentation
 less UML-specific
To:     David Gow <davidgow@google.com>, brendanhiggins@google.com,
        skhan@linuxfoundation.org, corbet@lwn.net
Cc:     kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tim.Bird@sony.com
References: <20200212230046.84007-1-davidgow@google.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <f99a3d4d-ad65-5fd1-3407-db33f378b1fa@gmail.com>
Date:   Wed, 12 Feb 2020 19:32:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200212230046.84007-1-davidgow@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/12/20 5:00 PM, David Gow wrote:
> Remove some of the outmoded "Why KUnit" rationale, and move some
> UML-specific information to the kunit_tool page. Also update the Getting
> Started guide to mention running tests without the kunit_tool wrapper.
> 
> Signed-off-by: David Gow <davidgow@google.com>
> ---
> Thanks for your comments. I've reinstated the "Why KUnit" section with
> some minor changes.
> 
> Changes since v1[1]:
> - Reinstated the "Why Kunit?" section, minus the comparison with other
>   testing frameworks (covered in the FAQ), and the description of UML.
> - Moved the description of UML into to kunit_tool page.
> - Tidied up the wording around how KUnit is built and run to make it work
>   without the UML description.
> 
> 
> [1]:
> https://lore.kernel.org/linux-kselftest/9c703dea-a9e1-94e2-c12d-3cb0a09e75ac@gmail.com/T/
> 
> 
> 
>  Documentation/dev-tools/kunit/index.rst      | 33 ++++----
>  Documentation/dev-tools/kunit/kunit-tool.rst |  7 ++
>  Documentation/dev-tools/kunit/start.rst      | 80 ++++++++++++++++----
>  3 files changed, 92 insertions(+), 28 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
> index d16a4d2c3a41..ca6cd6dd6ab7 100644
> --- a/Documentation/dev-tools/kunit/index.rst
> +++ b/Documentation/dev-tools/kunit/index.rst
> @@ -17,14 +17,23 @@ What is KUnit?
>  ==============
>  
>  KUnit is a lightweight unit testing and mocking framework for the Linux kernel.
> -These tests are able to be run locally on a developer's workstation without a VM
> -or special hardware.
>  
>  KUnit is heavily inspired by JUnit, Python's unittest.mock, and
>  Googletest/Googlemock for C++. KUnit provides facilities for defining unit test
>  cases, grouping related test cases into test suites, providing common
>  infrastructure for running tests, and much more.
>  
> +KUnit consists of a kernel component, which provides a set of macros for easily
> +writing unit tests. Tests written against KUnit will run on kernel boot if
> +built-in, or when loaded if built as a module. These tests write out results to
> +the kernel log in `TAP <https://testanything.org/>`_ format.
> +
> +To make running these tests (and reading the results) easier, KUnit offsers

                                                                       offers

> +:doc:`kunit_tool <kunit-tool>`, which builds a `User Mode Linux
> +<http://user-mode-linux.sourceforge.net>`_ kernel, runs it, and parses the test
> +results. This provides a quick way of running KUnit tests during development,
> +without requiring a virtual machine or separate hardware.
> +
>  Get started now: :doc:`start`
>  
>  Why KUnit?
> @@ -36,20 +45,11 @@ allow all possible code paths to be tested in the code under test; this is only
>  possible if the code under test is very small and does not have any external
>  dependencies outside of the test's control like hardware.
>  
> -Outside of KUnit, there are no testing frameworks currently
> -available for the kernel that do not require installing the kernel on a test
> -machine or in a VM and all require tests to be written in userspace running on
> -the kernel; this is true for Autotest, and kselftest, disqualifying
> -any of them from being considered unit testing frameworks.
> +KUnit provides a common framework for unit tests within the kernel.
>  
> -KUnit addresses the problem of being able to run tests without needing a virtual
> -machine or actual hardware with User Mode Linux. User Mode Linux is a Linux
> -architecture, like ARM or x86; however, unlike other architectures it compiles
> -to a standalone program that can be run like any other program directly inside
> -of a host operating system; to be clear, it does not require any virtualization
> -support; it is just a regular program.
> -
> -Alternatively, kunit and kunit tests can be built as modules and tests will
> +KUnit tests can be run on most kernel configurations, and most tests are

s/kernel configurations/architectures/


> +architecture independent. All built-in KUnit tests run on kernel startup.
> +Alternatively, KUnit and KUnit tests can be built as modules and tests will
>  run when the test module is loaded.
>  
>  KUnit is fast. Excluding build time, from invocation to completion KUnit can run
> @@ -75,9 +75,12 @@ someone sends you some code. Why trust that someone ran all their tests
>  correctly on every change when you can just run them yourself in less time than
>  it takes to read their test log?
>  
> +
>  How do I use it?
>  ================
>  
>  *   :doc:`start` - for new users of KUnit
>  *   :doc:`usage` - for a more detailed explanation of KUnit features
>  *   :doc:`api/index` - for the list of KUnit APIs used for testing
> +*   :doc:`kunit-tool` - for more information on the kunit_tool helper script
> +*   :doc:`faq` - for answers to some common questions about KUnit
> diff --git a/Documentation/dev-tools/kunit/kunit-tool.rst b/Documentation/dev-tools/kunit/kunit-tool.rst
> index 50d46394e97e..949af2da81e5 100644
> --- a/Documentation/dev-tools/kunit/kunit-tool.rst
> +++ b/Documentation/dev-tools/kunit/kunit-tool.rst
> @@ -12,6 +12,13 @@ the Linux kernel as UML (`User Mode Linux
>  <http://user-mode-linux.sourceforge.net/>`_), running KUnit tests, parsing
>  the test results and displaying them in a user friendly manner.
>  
> +kunit_tool addresses the problem of being able to run tests without needing a

This paragraph was moved from index.rst to here (kunit-tool.rst) and the leading
word changed from 'KUnit' to 'kunit_tool'.

The previous wording and location are better.  The UML kernel can be run without
using kunit_tool (and in fact, I have never used kunit_tool to run my KUnit UML
kernel).

Stating 'kunit_tool' here is conflating the functionality that KUnit provides
with the optional ease of use that kunit_tool provides.


> +virtual machine or actual hardware with User Mode Linux. User Mode Linux is a
> +Linux architecture, like ARM or x86; however, unlike other architectures it
> +compiles the kernel as a standalone Linux executable that can be run like any
> +other program directly inside of a host operating system. To be clear, it does
> +not require any virtualization support: it is just a regular program.
> +
>  What is a kunitconfig?
>  ======================
>  
> diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> index 4e1d24db6b13..e1c5ce80ce12 100644
> --- a/Documentation/dev-tools/kunit/start.rst
> +++ b/Documentation/dev-tools/kunit/start.rst
> @@ -9,11 +9,10 @@ Installing dependencies
>  KUnit has the same dependencies as the Linux kernel. As long as you can build
>  the kernel, you can run KUnit.
>  
> -KUnit Wrapper
> -=============
> -Included with KUnit is a simple Python wrapper that helps format the output to
> -easily use and read KUnit output. It handles building and running the kernel, as
> -well as formatting the output.
> +Running tests with the KUnit Wrapper
> +====================================
> +Included with KUnit is a simple Python wrapper which runs tests under User Mode
> +Linux, and formats the test results.
>  
>  The wrapper can be run with:
>  
> @@ -21,22 +20,42 @@ The wrapper can be run with:
>  
>  	./tools/testing/kunit/kunit.py run --defconfig
>  
> -For more information on this wrapper (also called kunit_tool) checkout the
> +For more information on this wrapper (also called kunit_tool) check out the
>  :doc:`kunit-tool` page.
>  
>  Creating a .kunitconfig
> -=======================
> -The Python script is a thin wrapper around Kbuild. As such, it needs to be
> -configured with a ``.kunitconfig`` file. This file essentially contains the
> -regular Kernel config, with the specific test targets as well.
> -
> +-----------------------
> +If you want to run a specific set of tests (rather than those listed in the
> +KUnit defconfig), you can provide Kconfig options in the ``.kunitconfig`` file.
> +This file essentially contains the regular Kernel config, with the specific
> +test targets as well. The ``.kunitconfig`` should also contain any other config
> +options required by the tests.
> +
> +A good starting point for a ``.kunitconfig`` is the KUnit defconfig:
>  .. code-block:: bash
>  
>  	cd $PATH_TO_LINUX_REPO
>  	cp arch/um/configs/kunit_defconfig .kunitconfig
>  
> -Verifying KUnit Works
> ----------------------
> +You can then add any other Kconfig options you wish, e.g.:
> +.. code-block:: none
> +
> +        CONFIG_LIST_KUNIT_TEST=y
> +
> +:doc:`kunit_tool <kunit-tool>` will ensure that all config options set in
> +``.kunitconfig`` are set in the kernel ``.config`` before running the tests.
> +It'll warn you if you haven't included the dependencies of the options you're
> +using.
> +
> +.. note::
> +   Note that removing something from the ``.kunitconfig`` will not trigger a
> +   rebuild of the ``.config`` file: the configuration is only updated if the
> +   ``.kunitconfig`` is not a subset of ``.config``. This means that you can use
> +   other tools (such as make menuconfig) to adjust other config options.
> +
> +
> +Running the tests
> +-----------------
>  
>  To make sure that everything is set up correctly, simply invoke the Python
>  wrapper from your kernel repo:
> @@ -62,6 +81,41 @@ followed by a list of tests that are run. All of them should be passing.
>  	Because it is building a lot of sources for the first time, the
>  	``Building KUnit kernel`` step may take a while.
>  
> +Running tests without the KUnit Wrapper
> +=======================================
> +
> +If you'd rather not use the KUnit Wrapper (if, for example, you need to
> +integrate with other systems, or use an architecture other than UML), KUnit can
> +be included in any kernel, and the results read out and parsed manually.
> +
> +.. note::
> +   KUnit is not designed for use in a production system, and it's possible that
> +   tests may reduce the stability or security of the system.
> +
> +
> +
> +Configuring the kernel
> +----------------------
> +
> +In order to enable KUnit itself, you simply need to enable the ``CONFIG_KUNIT``
> +Kconfig option (it's under Kernel Hacking/Kernel Testing and Coverage in
> +menuconfig). From there, you can enable any KUnit tests you want: they usually
> +have config options ending in ``_KUNIT_TEST``.
> +
> +KUnit and KUnit tests can be compiled as modules: in this case the tests in a
> +module will be run when the module is loaded.
> +
> +Running the tests
> +-----------------
> +
> +Build and run your kernel as usual. Test output will be written to the kernel
> +log in `TAP <https://testanything.org/>`_ format.
> +
> +.. note::
> +   It's possible that there will be other lines and/or data interspersed in the
> +   TAP output.
> +
> +
>  Writing your first test
>  =======================
>  
> 

Reviewed-by: Frank Rowand <frank.rowand@sony.com>
