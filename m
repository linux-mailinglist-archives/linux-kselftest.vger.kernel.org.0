Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EADB10313C
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2019 02:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfKTBnP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Nov 2019 20:43:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59428 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfKTBnP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Nov 2019 20:43:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UTiuO7gn/Df76JiaANzCArrDiduen89Wrcnv7dJpIJ4=; b=L/6bUTZx6MGWE8OKAug9kKP4V
        6NNQYm+dW4RCA29AM3DoQqBodyKhF611k+sc7FFV8n7TG6cH/mv4rHVW6L+uc34c/SKwvcN1hgEQU
        uxnTiq1SLNJc+yQiFCnKPWXkXUFyRonMtzafpm7k3OGmIxBcOTwDpxcK2R8lxTZDw/t7MeE74gqpT
        qAMEuSqWp0FzuDP+lpusXSQQEi2v+c+dTT1nk0t4aGGQYsSlFQlzwRXTsW+owkskdem4SOkzfrQyT
        27ZM7ZSnOCYRGeP5jxvGA6Wb8fZ6SFrLUXWhMtAjnxw0T0pa0WMZl8aYZlSgDBGINxHWsSBbyyOgH
        OW0K06EGw==;
Received: from [2601:1c0:6280:3f0::5a22]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iXF1V-0007C7-No; Wed, 20 Nov 2019 01:43:13 +0000
Subject: Re: [PATCH linux-kselftest/test v4] Documentation: kunit: add
 documentation for kunit_tool
To:     Brendan Higgins <brendanhiggins@google.com>, shuah@kernel.org,
        davidgow@google.com
Cc:     kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, tytso@mit.edu
References: <20191120011700.227543-1-brendanhiggins@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5151cb8f-c98f-9185-b575-83d70351a54d@infradead.org>
Date:   Tue, 19 Nov 2019 17:43:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191120011700.227543-1-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/19/19 5:17 PM, Brendan Higgins wrote:
> Add documentation for the Python script used to build, run, and collect
> results from the kernel known as kunit_tool. kunit_tool
> (tools/testing/kunit/kunit.py) was already added in previous commits.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: David Gow <davidgow@google.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/dev-tools/kunit/index.rst      |  1 +
>  Documentation/dev-tools/kunit/kunit-tool.rst | 57 ++++++++++++++++++++
>  Documentation/dev-tools/kunit/start.rst      |  5 +-
>  3 files changed, 62 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/dev-tools/kunit/kunit-tool.rst
> 
> diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
> index 26ffb46bdf99d..c60d760a0eed1 100644
> --- a/Documentation/dev-tools/kunit/index.rst
> +++ b/Documentation/dev-tools/kunit/index.rst
> @@ -9,6 +9,7 @@ KUnit - Unit Testing for the Linux Kernel
>  
>  	start
>  	usage
> +	kunit-tool
>  	api/index
>  	faq
>  
> diff --git a/Documentation/dev-tools/kunit/kunit-tool.rst b/Documentation/dev-tools/kunit/kunit-tool.rst
> new file mode 100644
> index 0000000000000..50d46394e97e3
> --- /dev/null
> +++ b/Documentation/dev-tools/kunit/kunit-tool.rst
> @@ -0,0 +1,57 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=================
> +kunit_tool How-To
> +=================
> +
> +What is kunit_tool?
> +===================
> +
> +kunit_tool is a script (``tools/testing/kunit/kunit.py``) that aids in building
> +the Linux kernel as UML (`User Mode Linux
> +<http://user-mode-linux.sourceforge.net/>`_), running KUnit tests, parsing
> +the test results and displaying them in a user friendly manner.
> +
> +What is a kunitconfig?
> +======================
> +
> +It's just a defconfig that kunit_tool looks for in the base directory.
> +kunit_tool uses it to generate a .config as you might expect. In addition, it
> +verifies that the generated .config contains the CONFIG options in the
> +kunitconfig; the reason it does this is so that it is easy to be sure that a
> +CONFIG that enables a test actually ends up in the .config.
> +
> +How do I use kunit_tool?
> +========================
> +
> +If a kunitconfig is present at the root directory, all you have to do is:
> +
> +.. code-block:: bash
> +
> +	./tools/testing/kunit/kunit.py run
> +
> +However, you most likely want to use it with the following options:
> +
> +.. code-block:: bash
> +
> +	./tools/testing/kunit/kunit.py run --timeout=30 --jobs=`nproc --all`
> +
> +- ``--timeout`` sets a maximum amount of time to allow tests to run.
> +- ``--jobs`` sets the number of threads to use to build the kernel.
> +
> +If you just want to use the defconfig that ships with the kernel, you can
> +append the ``--defconfig`` flag as well:
> +
> +.. code-block:: bash
> +
> +	./tools/testing/kunit/kunit.py run --timeout=30 --jobs=`nproc --all` --defconfig
> +
> +.. note::
> +	This command is particularly helpful for getting started because it
> +	just works. No kunitconfig needs to be present.
> +
> +For a list of all the flags supported by kunit_tool, you can run:
> +
> +.. code-block:: bash
> +
> +	./tools/testing/kunit/kunit.py run --help
> diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> index aeeddfafeea20..f4d9a4fa914f8 100644
> --- a/Documentation/dev-tools/kunit/start.rst
> +++ b/Documentation/dev-tools/kunit/start.rst
> @@ -19,7 +19,10 @@ The wrapper can be run with:
>  
>  .. code-block:: bash
>  
> -   ./tools/testing/kunit/kunit.py run
> +	./tools/testing/kunit/kunit.py run --defconfig
> +
> +For more information on this wrapper (also called kunit_tool) checkout the
> +:doc:`kunit-tool` page.
>  
>  Creating a kunitconfig
>  ======================
> 


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
