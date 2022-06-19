Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF10550DB4
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jun 2022 01:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236615AbiFSX4q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 19 Jun 2022 19:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiFSX4q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 19 Jun 2022 19:56:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E96A1A5;
        Sun, 19 Jun 2022 16:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=/5IadmUJamjDGD60cMZbxHIClJJP6KkcPRaQTlWaQAU=; b=ULnr8UttY4ComEXiDrHVKuZSK+
        DFYvGF5aBSn675cQ+153y7zkX0P8d+DhS18MG7UfCFUGtY8On6GfcETkcvU6j407qS5VuAfeUXGrL
        gL+7mbqqsxhX9zEeW+vZz3UfQoZvwWwPb+emRC6gYKnqkkdZCWMXZxCXWo3Xc5hQ7U9DaD2SfdU2Y
        KZZE6oTgFkGPg2gudyYzgazta4D4cF6iJsSO7iJiiKARcoUpS7xkGdkycPtaybO7mhvVGj/vS26Jx
        rq1NxpfO8MM6RH6rSSTwUPjPrCofJA43Z5J/Zpb1VPAnUBvOlHm2UByqftD+9wv3AYBa7OjW7Li1M
        +bR6/x9g==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o34mT-004iMi-37; Sun, 19 Jun 2022 23:56:37 +0000
Message-ID: <799f42aa-bdb1-6a5a-e5b6-7fa2e56c2f46@infradead.org>
Date:   Sun, 19 Jun 2022 16:56:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] Documentation: kunit: eliminate code-block warnings
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Harinder Singh <sharinder@google.com>,
        Tim Bird <tim.bird@sony.com>
References: <20220401024707.10550-1-rdunlap@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220401024707.10550-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

ping. Any progress on this patch?

Thanks.

On 3/31/22 19:47, Randy Dunlap wrote:
> Fix Sphinx complaints about code-block directive missing an argument.
> For start.rst, add "none" since that is already heavily used in that
> file. For run_wrapper.rst, use the simpler "::" literal block instead.
> 
> dev-tools/kunit/start.rst:83: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.
> 
> dev-tools/kunit/run_wrapper.rst:17: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.
> dev-tools/kunit/run_wrapper.rst:23: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.
> dev-tools/kunit/run_wrapper.rst:31: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.
> dev-tools/kunit/run_wrapper.rst:51: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.
> dev-tools/kunit/run_wrapper.rst:57: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.
> dev-tools/kunit/run_wrapper.rst:78: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.
> dev-tools/kunit/run_wrapper.rst:85: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.
> dev-tools/kunit/run_wrapper.rst:109: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.
> dev-tools/kunit/run_wrapper.rst:116: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.
> dev-tools/kunit/run_wrapper.rst:124: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.
> dev-tools/kunit/run_wrapper.rst:139: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.
> dev-tools/kunit/run_wrapper.rst:162: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.
> 
> Fixes: c48b9ef1f794 ("Documentation: KUnit: Rewrite getting started")
> Fixes: 46201d47d6c4 ("Documentation: kunit: Reorganize documentation related to running tests")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Harinder Singh <sharinder@google.com>
> Cc: Tim Bird <tim.bird@sony.com>
> ---
>  Documentation/dev-tools/kunit/run_wrapper.rst |   24 ++++++++--------
>  Documentation/dev-tools/kunit/start.rst       |    2 -
>  2 files changed, 13 insertions(+), 13 deletions(-)
> 
> --- linux-next-20220331.orig/Documentation/dev-tools/kunit/run_wrapper.rst
> +++ linux-next-20220331/Documentation/dev-tools/kunit/run_wrapper.rst
> @@ -14,13 +14,13 @@ tests, and formats the test results.
>  
>  Run command:
>  
> -.. code-block::
> +::
>  
>  	./tools/testing/kunit/kunit.py run
>  
>  We should see the following:
>  
> -.. code-block::
> +::
>  
>  	Generating .config...
>  	Building KUnit kernel...
> @@ -28,7 +28,7 @@ We should see the following:
>  
>  We may want to use the following options:
>  
> -.. code-block::
> +::
>  
>  	./tools/testing/kunit/kunit.py run --timeout=30 --jobs=`nproc --all
>  
> @@ -48,13 +48,13 @@ test configs for certain subsystems.
>  To use a different ``.kunitconfig`` file (such as one
>  provided to test a particular subsystem), pass it as an option:
>  
> -.. code-block::
> +::
>  
>  	./tools/testing/kunit/kunit.py run --kunitconfig=fs/ext4/.kunitconfig
>  
>  To view kunit_tool flags (optional command-line arguments), run:
>  
> -.. code-block::
> +::
>  
>  	./tools/testing/kunit/kunit.py run --help
>  
> @@ -75,14 +75,14 @@ certain code blocks, arch configs and so
>  
>  To create a ``.kunitconfig``, using the KUnit ``defconfig``:
>  
> -.. code-block::
> +::
>  
>  	cd $PATH_TO_LINUX_REPO
>  	cp tools/testing/kunit/configs/default.config .kunit/.kunitconfig
>  
>  We can then add any other Kconfig options. For example:
>  
> -.. code-block::
> +::
>  
>  	CONFIG_LIST_KUNIT_TEST=y
>  
> @@ -106,14 +106,14 @@ can run part of the KUnit build process
>  When running kunit_tool, from a ``.kunitconfig``, we can generate a
>  ``.config`` by using the ``config`` argument:
>  
> -.. code-block::
> +::
>  
>  	./tools/testing/kunit/kunit.py config
>  
>  To build a KUnit kernel from the current ``.config``, we can use the
>  ``build`` argument:
>  
> -.. code-block::
> +::
>  
>  	./tools/testing/kunit/kunit.py build
>  
> @@ -121,7 +121,7 @@ If we already have built UML kernel with
>  can run the kernel, and display the test results with the ``exec``
>  argument:
>  
> -.. code-block::
> +::
>  
>  	./tools/testing/kunit/kunit.py exec
>  
> @@ -136,7 +136,7 @@ format. When running tests, kunit_tool p
>  a summary. To see the raw test results in TAP format, we can pass the
>  ``--raw_output`` argument:
>  
> -.. code-block::
> +::
>  
>  	./tools/testing/kunit/kunit.py run --raw_output
>  
> @@ -159,7 +159,7 @@ By passing a bash style glob filter to t
>  commands, we can run a subset of the tests built into a kernel . For
>  example: if we only want to run KUnit resource tests, use:
>  
> -.. code-block::
> +::
>  
>  	./tools/testing/kunit/kunit.py run 'kunit-resource*'
>  
> --- linux-next-20220331.orig/Documentation/dev-tools/kunit/start.rst
> +++ linux-next-20220331/Documentation/dev-tools/kunit/start.rst
> @@ -80,7 +80,7 @@ Running Tests (KUnit Wrapper)
>  
>  If everything worked correctly, you should see the following:
>  
> -.. code-block::
> +.. code-block:: none
>  
>  	Generating .config ...
>  	Building KUnit Kernel ...

-- 
~Randy
