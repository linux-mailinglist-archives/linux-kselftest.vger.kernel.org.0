Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AAA64E168
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Dec 2022 19:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiLOSzK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Dec 2022 13:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiLOSzG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Dec 2022 13:55:06 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB6D379C9
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Dec 2022 10:55:04 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 124so268017pfy.0
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Dec 2022 10:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tql803N7RKHuASaIdu+UkrN+NkU/fpU+hod/+Xu+0bY=;
        b=EYuI77zPNcW0wzWblw74hpUTvu8AQLpoMzPSRWgKRX5K3Vurk9HKM3ALv7PnYwOOOJ
         1nzN7Acw0nmSqxgF1ul41UiPrrzfOKzgdOGKz1TSfoBMkTyCm7JptAA9nmUvV15xKZEA
         UP5sAxUXSxU6V9Waxi3TGHcR6p6Yya+0/Q/PCpmVYwmhrhjlw3rZ95TYanDLDHm03yK7
         i1q6iP6eVAz/oZIcVJrPbiaSi/M+e9sGtoIHv29vp472kY1mlwmPWa+Zki6MRyBqFWuT
         1TdS49C7hYQ/ui7UmrRZA0E3V1D/oWBZGqQXut9wplm+cCH2UlPnjRKMbRaZXqnqcaAr
         I4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tql803N7RKHuASaIdu+UkrN+NkU/fpU+hod/+Xu+0bY=;
        b=g5izYkVBsN9ozAGvs7WdaaYtlldQWrt7TOWHzkhq2sHH9UUZsj2dUaFO71DrOEO+oD
         0mKoVweJkypJcaWSs6E2bY2NTQ3OqFO6rct4sBsoql11PQsImh53qInyN5LmyMQVivel
         CuK78isGiUANvI5MaRZa1nrYzDr3MVUzaXinKqwkLCEapuzMHDZzL28YvNnkYlbI51RJ
         hrXefgZdqUWhABKQHNXzMS+jObsQQCq+FykQQxhu9I6pYzPp++mA8HScD2edc/I/c7SH
         /eWDWdjSImCW2rfck5TsB1O37xSwVkv7JsqFi2Zr6dBIyxEIYlvIP3ZFSigZsWYWF+pu
         Ep0A==
X-Gm-Message-State: ANoB5pnhtsRtDL/+Mhhep2MPe2YOZeZj3ue6ig7MNj2vA9fUjWR9IlvS
        h9QxgL/Cce+VytDtZhUD/W0Gxh41h4xdVgmLjOlzaQ==
X-Google-Smtp-Source: AA0mqf7K7vyKkq01+H38YVBuJRxakQHpgkN7io9XEQ0BlOl7dyKzTDVORCw3/HzdJh1c79jWOtmX6fG7j17fiuTfCR0=
X-Received: by 2002:a62:1812:0:b0:56c:afe:e8bf with SMTP id
 18-20020a621812000000b0056c0afee8bfmr80788681pfy.51.1671130503191; Thu, 15
 Dec 2022 10:55:03 -0800 (PST)
MIME-Version: 1.0
References: <20221208061841.2186447-1-davidgow@google.com> <20221208061841.2186447-3-davidgow@google.com>
In-Reply-To: <20221208061841.2186447-3-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 15 Dec 2022 10:54:51 -0800
Message-ID: <CAGS_qxqUuaGeeUSpERLduvm7f6A7c+psBwUr=RiBFzPFRipHkg@mail.gmail.com>
Subject: Re: [PATCH 2/2] Documentation: Add Function Redirection API docs
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Sadiya Kazi <sadiyakazi@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joe Fradley <joefradley@google.com>,
        Steve Muckle <smuckle@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 7, 2022 at 10:18 PM 'David Gow' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> From: Sadiya Kazi <sadiyakazi@google.com>
>
> Added a new page (functionredirection.rst) that describes the Function
> Redirection (static stubbing) API. This page will be expanded if we add,
> for example, ftrace-based stubbing.
>
> In addition,
> 1. Updated the api/index.rst page to create an entry for function
>    redirection api
> 2. Updated the toctree to be hidden, reducing redundancy on the
>    generated page.
>
> Signed-off-by: Sadiya Kazi <sadiyakazi@google.com>
> Co-developed-by: David Gow <davidgow@google.com>
> Signed-off-by: David Gow <davidgow@google.com>

Since I wrote the example code snippets (over at
https://kunit.dev/mocking.html#compile-time), I wasn't sure if I
should give an Rb tag.
But the majority of this doc is text I had no part in writing, so with
that caveat:

Reviewed-by: Daniel Latypov <dlatypov@google.com>

I noticed a few typos we could fix.
The rest of my comments are optional suggestions about rewording some
bits and adding `` to identifiers.

> ---
>
> Note that this patch is new to v1 of the series, and wasn't included in
> the previous RFCs.
>
> ---
>  .../kunit/api/functionredirection.rst         | 162 ++++++++++++++++++
>  Documentation/dev-tools/kunit/api/index.rst   |  13 +-
>  2 files changed, 172 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/dev-tools/kunit/api/functionredirection.rst
>
> diff --git a/Documentation/dev-tools/kunit/api/functionredirection.rst b/Documentation/dev-tools/kunit/api/functionredirection.rst
> new file mode 100644
> index 000000000000..fc7644dfea65
> --- /dev/null
> +++ b/Documentation/dev-tools/kunit/api/functionredirection.rst
> @@ -0,0 +1,162 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +========================
> +Function Redirection API
> +========================
> +
> +Overview
> +========
> +
> +When writing unit tests, it's important to be able to isolate the code being
> +tested from other parts of the kernel. This ensures the reliability of the test
> +(it won't be affected by external factors), reduces dependencies on specific
> +hardware or config options (making the test easier to run), and protects the
> +stability of the rest of the system (making it less likely for test-specific
> +state to interfere with the rest of the system).
> +
> +While for some code (typically generic data structures, helpers, and toher

s/toher/other

> +"pure function") this is trivial, for others (like device drivers, filesystems,

s/function/functions, perhaps?

> +core subsystems) the code is heavily coupled with other parts of the kernel.
> +
> +This often involves global state in some way: be it global lists of devices,

s/be it/be it a

> +the filesystem, or hardware state, this needs to be either carefully managed,
> +isolated, and restored, or avoided altogether by replacing access to and
> +mutation of this state with a "fake" or "mock" variant.

optional nit: this sentence feels a bit long.
If we can find a way to split it up, that would be nice.

Perhaps something like:
This coupling is often due to global state: be it a global list of devices...
Tests need to either carefully manage, isolate, and restore state or
they can avoid it altogether by...

> +
> +This can be done by refactoring the code to abstract out access to such state,
> +by introducing a layer of indirection which can use or emulate a separate set of

optional nit: "abstract our access... by introducing a layer of
indirection" feels a bit redundant.
These are the same thing.

Perhaps instead: "abstract out access to such state so tests can..."

> +test state. However, such refactoring comes with its own costs (and undertaking
> +significant refactoring before being able to write tests is suboptimal).
> +
> +A simpler way to intercept some of the function calls is to use function
> +redirection via static stubs.

Maybs s/intercept/replace?
Intercept makes it sounds like we're supporting "test spies", but if
you use the macro below, you have no way of implementing such a thing.

E.g. it makes it sound like we can have
  int func() {
    if (intercepted) { ++func_called; }
    // still run the rest of func
  }

> +
> +
> +Static Stubs
> +============
> +
> +Static stubs are a way of redirecting calls to one function (the "real"
> +function) to another function (the "replacement" function).
> +
> +It works by adding a macro to the "real" function which checks to see if a test
> +is running, and if a replacement function is available. If so, that function is
> +called in place of the original.
> +
> +Using static stubs is pretty straightforward:
> +
> +1. Add the KUNIT_STATIC_STUB_REDIRECT() macro to the start of the "real"

nit: should we use ``KUNIT_STATIC_STUB_REDIRECT()`` to format it as code?

> +   function.
> +
> +   This should be the first statement in the function, after any variable
> +   declarations. KUNIT_STATIC_STUB_REDIRECT() takes the name of the

ditto ``

> +   function, followed by all of the arguments passed to the real function.
> +
> +   For example:
> +
> +   .. code-block:: c
> +
> +       void send_data_to_hardware(const char *str)
> +       {
> +               KUNIT_STATIC_STUB_REDIRECT(send_data_to_hardware, str);
> +               /* real implementation */
> +       }
> +
> +2. Write one or more replacement functions.
> +
> +   These functions should have the same function signature as the real function.
> +   In the event they need to access or modify test-specific state, they can use
> +   kunit_get_current_test() to get a struct kunit pointer. This can then

ditto for ``kunit_get_current_test`` and ``struct kunit``

> +   be passed to the expectation/assertion macros, or used to look up KUnit
> +   resources.
> +
> +   For example:
> +
> +   .. code-block:: c
> +
> +       void fake_send_data_to_hardware(const char *str)
> +       {
> +               struct kunit *test = kunit_get_current_test();
> +               KUNIT_EXPECT_STREQ(test, str, "Hello World!");
> +       }
> +
> +3. Activate the static stub from your test.
> +
> +   From within a test, the redirection can be enabled with
> +   kunit_activate_static_stub(), which accepts a struct kunit pointer,

ditto here

> +   the real function, and the replacement function. You can call this several
> +   times with different replacement functions to swap out implementations of the
> +   function.
> +
> +   In our example, this would be
> +
> +   .. code-block:: c
> +
> +        kunit_activate_static_stub(test,
> +                                   send_data_to_hardware,
> +                                   fake_send_data_to_hardware);
> +
> +4. Call (perhaps indirectly) the real function.
> +
> +   Once the redirection is activated, any call to the real function will call
> +   the replacement function instead. Such calls may be buried deep in the
> +   implementation of another function, but must occur from the test's kthread.
> +
> +   For example:
> +
> +   .. code-block:: c
> +
> +        send_data_to_hardware("Hello World!"); /* Succeeds */
> +        send_data_to_hardware("Something else"); /* Fails the test. */
> +
> +5. (Optionally) disable the stub.
> +
> +   When you no longer need it, the redirection can be disabled (and hence the
> +   original behaviour of the 'real' function resumed) using
> +   kunit_deactivate_static_stub(). If the stub is not manually deactivated, it
> +   will nevertheless be disabled when the test finishes.

optional nit: this block of text feels overly long to me, personally.

Perhaps something shorter like:
When you no longer need it, you can disable the stub manually by
calling ``kunit_deactive_static_stub()``.
Otherwise, it will be disabled automatically at the end of the test.

> +
> +   For example:
> +
> +   .. code-block:: c
> +
> +        kunit_deactivate_static_stub(test, send_data_to_hardware);
> +
> +
> +It's also possible to use these replacement functions to test to see if a
> +function is called at all, for example:
> +
> +.. code-block:: c
> +
> +       void send_data_to_hardware(const char *str)
> +       {
> +               KUNIT_STATIC_STUB_REDIRECT(send_data_to_hardware, str);
> +               /* real implementation */
> +       }
> +
> +       /* In test file */
> +       int times_called = 0;
> +       void fake_send_data_to_hardware(const char *str)
> +       {
> +               /* fake implementation */

minor nit: in the original example, this body was basically a placeholder.
Given we're starting this section with saying "here's how you can
count the function calls", this is the only thing you'd ever put in
the body.

So I'd prefer we just drop the comment.

> +               times_called++;
> +       }
> +       ...
> +       /* In the test case, redirect calls for the duration of the test */
> +       kunit_activate_static_stub(test, send_data_to_hardware, fake_send_data_to_hardware);
> +
> +       send_data_to_hardware("hello");
> +       KUNIT_EXPECT_EQ(test, times_called, 1);
> +
> +       /* Can also deactivate the stub early, if wanted */
> +       kunit_deactivate_static_stub(test, send_data_to_hardware);
> +
> +       send_data_to_hardware("hello again");
> +       KUNIT_EXPECT_EQ(test, times_called, 1);
> +
> +
> +
> +API Reference
> +=============
> +
> +.. kernel-doc:: include/kunit/static_stub.h
> +   :internal:
> diff --git a/Documentation/dev-tools/kunit/api/index.rst b/Documentation/dev-tools/kunit/api/index.rst
> index 45ce04823f9f..2d8f756aab56 100644
> --- a/Documentation/dev-tools/kunit/api/index.rst
> +++ b/Documentation/dev-tools/kunit/api/index.rst
> @@ -4,17 +4,24 @@
>  API Reference
>  =============
>  .. toctree::
> +       :hidden:
>
>         test
>         resource
> +       functionredirection
>
> -This section documents the KUnit kernel testing API. It is divided into the
> +
> +This page documents the KUnit kernel testing API. It is divided into the
>  following sections:
>
>  Documentation/dev-tools/kunit/api/test.rst
>
> - - documents all of the standard testing API
> + - Documents all of the standard testing API
>
>  Documentation/dev-tools/kunit/api/resource.rst
>
> - - documents the KUnit resource API
> + - Documents the KUnit resource API
> +
> +Documentation/dev-tools/kunit/api/functionredirection.rst
> +
> + - Documents the KUnit Function Redirection API
> --
> 2.39.0.rc0.267.gcb52ba06e7-goog
