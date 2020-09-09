Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE52262A76
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Sep 2020 10:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgIIIhH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Sep 2020 04:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgIIIhC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Sep 2020 04:37:02 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69466C061756
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Sep 2020 01:37:01 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id y15so1485418wmi.0
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Sep 2020 01:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BhyBPgB9vs4GX0WG0TB0f4M/oPN9+cSShKiQ6+MBT10=;
        b=OPN9vAK9sNgPp5A/WCtYKZk4EXN1Xv0wFzNPosFQBrGLKCNlgDFMXSLTi1DzTXcVvQ
         U5mDF/rrsVKk3hj4upMkQ5Xu1yelPahQ3J3SjNu7gPE6TlyM5fwq1GNOiSRLh3WT2MN9
         uJnP16gsogLc9kRrF/MY8ctXVS/nt59oIcTjh4apsEQcJAOa7fZ2I80LdFK8s6Zip30a
         qIaYdbcw8KjjcfPwWG7haVmyFwgYW7+J5eHtdcJEXIUqW05F7kRcUh0UyJ5mdkPcsrat
         IniktyEOHY3TTukZNwemyKmcTbIqc+D69GiOb5YjGOwN+EEg5iFhXdswjOAI5DcweYD0
         Ornw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BhyBPgB9vs4GX0WG0TB0f4M/oPN9+cSShKiQ6+MBT10=;
        b=NL5eWoxshGyxpqyXCh++boLKsO5vlURw8tqagQWvz9BSH/3KoDfbrXTiySTbz3tHNi
         NCtliEmqBH9Bps7Qz93xug55PrAKBFM8IAndFJm0abHHd0d3yG47ATR/pQq53ZjBXiRb
         ynMJ98+6dJs32ex/yC1CFBahYbaUHDNTXOcu8P3ba8H8cQOtXMQ1tq2N71btahW/H0ZP
         R8bU+5nTWd2o22KSQeuArQq/5LOimRSL/QDjWlqPodxREtHriHMxdbAHOjH/4OJRKJcU
         Z1LipN9XNLGu/EmtI2KwxDuFaH8GiKbZq6EASUFjOjnd21M6OuGvTO0QM69eDeW//nuH
         6IYA==
X-Gm-Message-State: AOAM530MhGn/qw3riijbAtb78Oc3zTvnr0DpQJcAVaFXdvUlDJv4qcrW
        ty0GXhssTj6nXjIhZ3VEJnopog==
X-Google-Smtp-Source: ABdhPJzu82wH9CRZsiCU2R+ocLOX+gu3BxWXYAGsPmOfOmqbjHOVa4PINfNYscUgauOLun5/lvakdw==
X-Received: by 2002:a7b:ce86:: with SMTP id q6mr2557860wmj.163.1599640619750;
        Wed, 09 Sep 2020 01:36:59 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id a127sm2812203wmh.34.2020.09.09.01.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 01:36:58 -0700 (PDT)
Date:   Wed, 9 Sep 2020 10:36:53 +0200
From:   Marco Elver <elver@google.com>
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Randy Dunlap <rd.dunlab@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Tim Bird <Tim.Bird@sony.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: kunit: Add naming guidelines
Message-ID: <20200909083653.GA620870@elver.google.com>
References: <20200909051631.2960347-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909051631.2960347-1-davidgow@google.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 08, 2020 at 10:16PM -0700, David Gow wrote:
> As discussed in [1], KUnit tests have hitherto not had a particularly
> consistent naming scheme. This adds documentation outlining how tests
> and test suites should be named, including how those names should be
> used in Kconfig entries and filenames.
> 
> [1]:
> https://lore.kernel.org/linux-kselftest/202006141005.BA19A9D3@keescook/t/#u
> 
> Signed-off-by: David Gow <davidgow@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> ---
> 
> This is v2 of the KUnit test nomenclature guidelines. The guidelines have
> changed a bit in response to the discussion on the v1 thread which came
> about after plumbers. The major change is that the filename suffix is
> now "_test", with "_kunit" permitted where it conflicts. There are also
> some other exceptions carved out around existing tests, and very
> non-unit-like tests.
> 
> Changelog:
> 
> v2:
> - Rewrote the filename section to use "_test" as a suffix, and focus on
>   module names, not filenames.
> - Add a motivating introduction, which also calls out existing tests and
>   tests which cause problems when run automatically (long running,
>   flaky tests) as reasons to avoid the guidelines.
> - Talk about including the type of test in the suite name, but only if
>   theres an actual confict. (And update the example for this).
> 
> v1:
> https://lore.kernel.org/linux-kselftest/20200702071416.1780522-1-davidgow@google.com/
> - Fixed a bit of space/tab confusion in the index (Thanks, Randy)
> - Added some more examples (and some test case examples).
> - Added some examples of what not to call subsystems and suites.
> - No longer explicitly require "If unsure, put N" in Kconfig entries.
> - Minor formatting changes
> 
> RFC:
> https://lore.kernel.org/linux-kselftest/20200620054944.167330-1-davidgow@google.com/T/#u
> - Initial version
> 
> 
> The result is a little bit weaker than the previous versions, but
> hopefully will let us get the areas we agree on down.
> 
> -- David
> 
> 
>  Documentation/dev-tools/kunit/index.rst |   1 +
>  Documentation/dev-tools/kunit/style.rst | 207 ++++++++++++++++++++++++
>  2 files changed, 208 insertions(+)
>  create mode 100644 Documentation/dev-tools/kunit/style.rst
> 
> diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
> index e93606ecfb01..c234a3ab3c34 100644
> --- a/Documentation/dev-tools/kunit/index.rst
> +++ b/Documentation/dev-tools/kunit/index.rst
> @@ -11,6 +11,7 @@ KUnit - Unit Testing for the Linux Kernel
>  	usage
>  	kunit-tool
>  	api/index
> +	style
>  	faq
>  
>  What is KUnit?
> diff --git a/Documentation/dev-tools/kunit/style.rst b/Documentation/dev-tools/kunit/style.rst
> new file mode 100644
> index 000000000000..c001ea1cd87d
> --- /dev/null
> +++ b/Documentation/dev-tools/kunit/style.rst
> @@ -0,0 +1,207 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===========================
> +Test Style and Nomenclature
> +===========================
> +
> +To make finding, writing, and using KUnit tests as simple as possible, it's
> +strongly encouraged that they are named and written according to the guidelines
> +below. While it's possible to write KUnit tests which do not follow these rules,
> +they may break some tooling, may conflict with other tests, and may not be run
> +automatically by testing systems.
> +
> +It's recommended that you only deviate from these guidelines when:
> +
> +1. Porting tests to KUnit which are already known with an existing name, or
> +2. Writing tests which would cause serious problems if automatically run (e.g.,
> +   nonderministically producing false positives or negatives, or taking an

s/nonderministically/nondeterministically/ (or non-deterministically?)

> +   extremely long time to run).
[...]
> +Test File and Module Names
> +==========================
> +
> +KUnit tests can often be compiled as a module. These modules should be named
> +after the test suite, followed by ``_test``. If this is likely to conflict with
> +non-KUnit tests, the suffic ``_kunit`` can also be used.

s/suffic/suffix/

> +The easiest way of achieving this is to name the file containing the test suite
> +``<suite>_test.c`` (or, as above, ``<suite>_kunit.c``). This file should be
> +placed next to the code under test.
> +
> +If the suite name contains some or all of the name of the test's parent
> +directory, it may make sense to modify the source filename to reduce redundancy.
> +For example, a ``foo_firmware`` suite could be in the ``foo/firmware_test.c``
> +file.

Reviewed-by: Marco Elver <elver@google.com>

Thank you!
