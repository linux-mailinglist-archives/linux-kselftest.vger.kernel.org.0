Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738861A6C83
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Apr 2020 21:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387878AbgDMTdc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Apr 2020 15:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387876AbgDMTdb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Apr 2020 15:33:31 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E47C0A3BDC
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Apr 2020 12:33:31 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t11so2962567pgg.2
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Apr 2020 12:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wb++hV7YxUoaYemj7/SOPnQ3kuE8z1YrQQjb3RbOwHY=;
        b=YK0PiIR2PUpnrP4T+oeKyIGYl1PjUJVUm0Yt6mVrGHjIv0HS8aeTdk7/Qx1lN5IFKw
         rjPtzH7r/K2HOGvwUwD/v7/o/7HdmnaHZjk4g/8v6zEExdHJAreYxY+kPQUsZrFMP1xB
         oYsaHzmzL/nMdsw9Q6RB065qblHEuaHtbmL3dag5xoNPzjZmL4qlWG+6R4gi5gUlq0Js
         lMKfwHGlgdyZYd7QRpW4tEgIuJRyeeQUPwFDV2ZtWTiatFogmxAI7ZWyndn1EbrAVKik
         8KqyTtzQdTr4E6Ql2mEdo2tR/koIlN9czzg3KOM+tP/BNy+jXS3OdPXEqBu8F4zn1npZ
         ED2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wb++hV7YxUoaYemj7/SOPnQ3kuE8z1YrQQjb3RbOwHY=;
        b=tsNZZ13ezV0paRhQiaZHnu+I5FpmPX8k/yjl2HERKdJtBJDeb1Sq4JCPlm5Di8+XPt
         V/KbboxMCDSaJPrUISYbL3qG0BXUTOlo9NZiFseIH0mTqlQn8BHFBS3bqjklVY5fuAjP
         B7sPh5ZZ5OmRtsj2E1u0ZRdpaYTU6fcF+reFPBWWLPAApWcuiuKszUSPT17Ghh+JTVGg
         Pdjt1PPplNeJZdgJmd11JeA8VBV4c/IjC4UUlx1Dtda/SXSxTPXBCo8NGMyCZ0oWcHwq
         VI7F43VM9/Yv3Oh5GBUHhtHlw//mqRnUJQFCJkqvEwESHC+uNTdIUa9PXVB90m4tLARj
         mI/A==
X-Gm-Message-State: AGi0Pub7Ar+USKjMPXFVWlDwJXPTT1fLkvAbMMkYwNBBFVaFaFrd9Iw2
        47zbe4ISPYAAR1S3Dl5LOngVgqJhyMQ=
X-Google-Smtp-Source: APiQypIvtVxQO3ErQzpDgVHBs0D23lKkKHksm1rFAs0D+DZCP1rAzW0LvO2xCRkNXEl8Z+mMWYxA4A==
X-Received: by 2002:a63:5511:: with SMTP id j17mr2762364pgb.4.1586806410213;
        Mon, 13 Apr 2020 12:33:30 -0700 (PDT)
Received: from google.com ([2620:15c:2cb:1:e90c:8e54:c2b4:29e7])
        by smtp.gmail.com with ESMTPSA id y19sm9602554pfe.9.2020.04.13.12.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 12:33:29 -0700 (PDT)
Date:   Mon, 13 Apr 2020 12:33:25 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     Lothar Rubusch <l.rubusch@gmail.com>
Cc:     corbet@lwn.net, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3] Documentation: test.h - fix warnings
Message-ID: <20200413193325.GA74301@google.com>
References: <20200409212737.1943-1-l.rubusch@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409212737.1943-1-l.rubusch@gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 09, 2020 at 09:27:37PM +0000, Lothar Rubusch wrote:
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
> v2: Several documentation fixes
> 
> v3: Do not touch API documentation index
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  Documentation/dev-tools/kunit/start.rst | 13 ++++++++-----
>  Documentation/dev-tools/kunit/usage.rst |  4 ++--
>  include/kunit/test.h                    |  7 ++++---
>  3 files changed, 14 insertions(+), 10 deletions(-)
> 
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
>  	cd $PATH_TO_LINUX_REPO
>  	cp arch/um/configs/kunit_defconfig .kunitconfig
>  
>  You can then add any other Kconfig options you wish, e.g.:
> +
>  .. code-block:: none
>  
> -        CONFIG_LIST_KUNIT_TEST=y
> +	CONFIG_LIST_KUNIT_TEST=y
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
> index 9b0c46a6ca1f..b8a8434443b0 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -175,7 +175,7 @@ struct kunit_suite {
>  	void (*exit)(struct kunit *test);
>  	struct kunit_case *test_cases;
>  
> -	/* private - internal use only */
> +	/* private: internal use only */
>  	struct dentry *debugfs;
>  	char *log;
>  };
> @@ -232,12 +232,13 @@ void __kunit_test_suites_exit(struct kunit_suite **suites);
>   * kunit_test_suites() - used to register one or more &struct kunit_suite
>   *			 with KUnit.
>   *
> - * @suites: a statically allocated list of &struct kunit_suite.
> + * @...: a statically allocated list of &struct kunit_suite, assigned
> + *           to the pointer @suites.

Err...we only have one param. I was fine with changing the name in the
kernel doc to `@...`, or something like `@suites_list...`, but I am not
okay with using both like this. I am posting a diff of what I am
thinking below.

>   *
>   * Registers @suites with the test framework. See &struct kunit_suite for
>   * more information.
>   *
> - * When builtin,  KUnit tests are all run as late_initcalls; this means
> + * When builtin, KUnit tests are all run as late_initcalls; this means
>   * that they cannot test anything where tests must run at a different init
>   * phase. One significant restriction resulting from this is that KUnit
>   * cannot reliably test anything that is initialize in the late_init phase;
> -- 
> 2.20.1

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 9b0c46a6ca1f..dce68c59ac76 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -232,9 +232,9 @@ void __kunit_test_suites_exit(struct kunit_suite **suites);
  * kunit_test_suites() - used to register one or more &struct kunit_suite
  *			 with KUnit.
  *
- * @suites: a statically allocated list of &struct kunit_suite.
+ * @suites_list: a statically allocated list of &struct kunit_suite.
  *
- * Registers @suites with the test framework. See &struct kunit_suite for
+ * Registers @suites_list with the test framework. See &struct kunit_suite for
  * more information.
  *
  * When builtin,  KUnit tests are all run as late_initcalls; this means
@@ -253,8 +253,8 @@ void __kunit_test_suites_exit(struct kunit_suite **suites);
  * tests from the same place, and at the very least to do so after
  * everything else is definitely initialized.
  */
-#define kunit_test_suites(...)						\
-	static struct kunit_suite *suites[] = { __VA_ARGS__, NULL};	\
+#define kunit_test_suites(suites_list...)				\
+	static struct kunit_suite *suites[] = {suites_list, NULL};	\
 	static int kunit_test_suites_init(void)				\
 	{								\
 		return __kunit_test_suites_init(suites);		\
