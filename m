Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9D771030AA
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2019 01:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfKTAXn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Nov 2019 19:23:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52374 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbfKTAXm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Nov 2019 19:23:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6oX03oqDu3lBQEvd1fjcqRO4c+4GMv4bNPZooq49HMk=; b=JrfhgjV1KytAaQ0mwUo8SmB3z
        0JuBL6QaXnFpuB80pd0zJfrzuSuJIrd/57NomHB17zeSvsg1lHFVlGccvVaR87L19JohLxe8iPJUA
        PbTW5YIX28UEAlpfs7NGRVk0jURL9s1U3hoVaOzJcQoXJGsbktq4bbfFdSI/IT06hjO0Qdxcvmne2
        +dmesdZEH6dFYoW4xweNWUc62GHTZ2cD0oLnBZeLJzNdYOVxRWMEiHzWtBQRNoXUnRrIRHQizrQDp
        q34YBjTdUAlo0FhFmOBuoYFKP10Lkt8E5MajhbEZrj0ZPPWNtQN5j3UC5zn0DVKOVovEB/apDFSEP
        lZfvql+cw==;
Received: from [2603:3004:32:9a00::f45c]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iXDmT-0006zD-Lh; Wed, 20 Nov 2019 00:23:37 +0000
Subject: Re: [PATCH linux-kselftest/test v2] Documentation: kunit: fix typos
 and gramatical errors
To:     Brendan Higgins <brendanhiggins@google.com>, shuah@kernel.org,
        davidgow@google.com
Cc:     kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, heidifahim@google.com, trishalfonso@google.com,
        Rinat Ibragimov <ibragimovrinat@mail.ru>
References: <20191119233810.207487-1-brendanhiggins@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b102fef3-3faa-1d84-3d46-967655fee98f@infradead.org>
Date:   Tue, 19 Nov 2019 16:23:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191119233810.207487-1-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/19/19 3:38 PM, Brendan Higgins wrote:
> Fix typos and gramatical errors in the Getting Started and Usage guide
> for KUnit.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Link: https://patchwork.kernel.org/patch/11156481/
> Reported-by: Rinat Ibragimov <ibragimovrinat@mail.ru>
> Link: https://github.com/google/kunit-docs/issues/1
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: David Gow <davidgow@google.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/dev-tools/kunit/start.rst |  8 ++++----
>  Documentation/dev-tools/kunit/usage.rst | 24 ++++++++++++------------
>  2 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> index f4d9a4fa914f8..9d6db892c41c0 100644
> --- a/Documentation/dev-tools/kunit/start.rst
> +++ b/Documentation/dev-tools/kunit/start.rst
> @@ -26,7 +26,7 @@ For more information on this wrapper (also called kunit_tool) checkout the
>  
>  Creating a kunitconfig
>  ======================
> -The Python script is a thin wrapper around Kbuild as such, it needs to be
> +The Python script is a thin wrapper around Kbuild. As such, it needs to be
>  configured with a ``kunitconfig`` file. This file essentially contains the
>  regular Kernel config, with the specific test targets as well.
>  
> @@ -62,8 +62,8 @@ If everything worked correctly, you should see the following:
>  followed by a list of tests that are run. All of them should be passing.
>  
>  .. note::
> -   Because it is building a lot of sources for the first time, the ``Building
> -   kunit kernel`` step may take a while.
> +	Because it is building a lot of sources for the first time, the
> +	``Building KUnit kernel`` step may take a while.
>  
>  Writing your first test
>  =======================
> @@ -162,7 +162,7 @@ Now you can run the test:
>  
>  .. code-block:: bash
>  
> -	./tools/testing/kunit/kunit.py
> +	./tools/testing/kunit/kunit.py run
>  
>  You should see the following failure:
>  
> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> index c6e69634e274b..b9a065ab681ee 100644
> --- a/Documentation/dev-tools/kunit/usage.rst
> +++ b/Documentation/dev-tools/kunit/usage.rst
> @@ -16,7 +16,7 @@ Organization of this document
>  =============================
>  
>  This document is organized into two main sections: Testing and Isolating
> -Behavior. The first covers what a unit test is and how to use KUnit to write
> +Behavior. The first covers what unit tests are and how to use KUnit to write
>  them. The second covers how to use KUnit to isolate code and make it possible
>  to unit test code that was otherwise un-unit-testable.
>  
> @@ -174,13 +174,13 @@ Test Suites
>  ~~~~~~~~~~~
>  
>  Now obviously one unit test isn't very helpful; the power comes from having
> -many test cases covering all of your behaviors. Consequently it is common to
> -have many *similar* tests; in order to reduce duplication in these closely
> -related tests most unit testing frameworks provide the concept of a *test
> -suite*, in KUnit we call it a *test suite*; all it is is just a collection of
> -test cases for a unit of code with a set up function that gets invoked before
> -every test cases and then a tear down function that gets invoked after every
> -test case completes.
> +many test cases covering all of a unit's behaviors. Consequently it is common
> +to have many *similar* tests; in order to reduce duplication in these closely
> +related tests most unit testing frameworks - including KUnit - provide the
> +concept of a *test suite*. A *test suite* is just a collection of test cases
> +for a unit of code with a set up function that gets invoked before every test
> +case and then a tear down function that gets invoked after every test case
> +completes.
>  
>  Example:
>  
> @@ -211,7 +211,7 @@ KUnit test framework.
>  .. note::
>     A test case will only be run if it is associated with a test suite.
>  
> -For a more information on these types of things see the :doc:`api/test`.
> +For more information on these types of things see the :doc:`api/test`.
>  
>  Isolating Behavior
>  ==================
> @@ -338,7 +338,7 @@ We can easily test this code by *faking out* the underlying EEPROM:
>  		return count;
>  	}
>  
> -	ssize_t fake_eeprom_write(struct eeprom *this, size_t offset, const char *buffer, size_t count)
> +	ssize_t fake_eeprom_write(struct eeprom *parent, size_t offset, const char *buffer, size_t count)
>  	{
>  		struct fake_eeprom *this = container_of(parent, struct fake_eeprom, parent);
>  
> @@ -454,7 +454,7 @@ KUnit on non-UML architectures
>  By default KUnit uses UML as a way to provide dependencies for code under test.
>  Under most circumstances KUnit's usage of UML should be treated as an
>  implementation detail of how KUnit works under the hood. Nevertheless, there
> -are instances where being able to run architecture specific code, or test
> +are instances where being able to run architecture specific code or test
>  against real hardware is desirable. For these reasons KUnit supports running on
>  other architectures.
>  
> @@ -557,7 +557,7 @@ run your tests on your hardware setup just by compiling for your architecture.
>  .. important::
>     Always prefer tests that run on UML to tests that only run under a particular
>     architecture, and always prefer tests that run under QEMU or another easy
> -   (and monitarily free) to obtain software environment to a specific piece of
> +   (and monetarily free) to obtain software environment to a specific piece of
>     hardware.
>  
>  Nevertheless, there are still valid reasons to write an architecture or hardware
> 


-- 
~Randy
