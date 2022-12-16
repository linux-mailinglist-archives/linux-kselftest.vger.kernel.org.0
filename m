Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F3664E7A6
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Dec 2022 08:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiLPHRu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Dec 2022 02:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiLPHRt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Dec 2022 02:17:49 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFAA13E34
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Dec 2022 23:17:47 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id d185so1560732vsd.0
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Dec 2022 23:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eVKIG5UBizWKBtyvWledYHpd24ATpHjeEXZ43I4enuw=;
        b=WtapbrBCroAdv1i3g6k0p44tGyGkde5hfterw3/neA89osupsjYNAD43bsAmeu7S9h
         vZ/mtyMac20wxtOdbcXx7mCGQK/bUVCrIBb8QH6gpCTWRHCVS9E+D76BzY4Xa1bsom5o
         hXwig+q190ajg6aTrQjj8usU3APP9psYFJpXAa4JpZU5O6ojwAEVYZCm92JHtVv+TfBw
         liIltF89E9FiH1qbwM5coNwSGbwfDvHl9wSeF4BKDSYmWhxZzegTrKjnA+hDxVaIUQto
         /u+BDzOzUuxRIsmEjomKcG3Q/QYDrToYBkAg2SvK2RPfk5Ya8jS3C+HStq38RNn2yRMn
         opUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eVKIG5UBizWKBtyvWledYHpd24ATpHjeEXZ43I4enuw=;
        b=NWXyiIArCDKpc1RWlANUFMPWTLbRwuB7Om4VAzY2dIffn3Ghbw11roYbxgmJZnyQWQ
         GA0GtBMrBPY91UHHv4fS5dT3SWF65ZQkU+KxhRCfNzzkRKZdgHKTk8mmjIMMxvMLFlTh
         lx1y9WzPWUEQFozdEnCl1CaesbhrunK3akyNiZv5d9yntl0J5p+cuKsi2TaeFhFyjsaO
         hSA3eJwq88VXXmJhJxdhFfZK4hXvQmJPqQQKW6pOFV/Z+DR0SF76vfBRg7Z5dgkcHle8
         wt6afzbl9tZjPUcJM1sAbxLQuzeBvf6wKJRx3eLuFCZGbeR3Aag5SOt8JJrF2oDJgocv
         uMzQ==
X-Gm-Message-State: ANoB5pkeV2+kh0ho6xbWicJZ2tOl6+K2B6ZChtk7lv/yB3NQDWvHLLui
        mDPNeXgDYCcizhkfZEfqUN2orUa0/feAzowWNAJcWQ==
X-Google-Smtp-Source: AA0mqf40vUhkxz9DjVcOn/rlDEPQREYWPww3U81Tfud40lkmrRnj6MiWA6kycUdu91B43riarqIixR4q1a9rOGfypbs=
X-Received: by 2002:a05:6102:5785:b0:3b0:7178:7fe8 with SMTP id
 dh5-20020a056102578500b003b071787fe8mr41775934vsb.38.1671175066606; Thu, 15
 Dec 2022 23:17:46 -0800 (PST)
MIME-Version: 1.0
References: <20221208061841.2186447-1-davidgow@google.com> <20221208061841.2186447-3-davidgow@google.com>
 <CAGS_qxqUuaGeeUSpERLduvm7f6A7c+psBwUr=RiBFzPFRipHkg@mail.gmail.com>
In-Reply-To: <CAGS_qxqUuaGeeUSpERLduvm7f6A7c+psBwUr=RiBFzPFRipHkg@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 16 Dec 2022 15:17:35 +0800
Message-ID: <CABVgOSm8fscdE_uX9=gYBRUBQ1dMYuijxK7odJEbRgVG-VrZOA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Documentation: Add Function Redirection API docs
To:     Daniel Latypov <dlatypov@google.com>
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
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000003a5b3605efecc4f5"
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

--0000000000003a5b3605efecc4f5
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Dec 2022 at 02:55, 'Daniel Latypov' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> On Wed, Dec 7, 2022 at 10:18 PM 'David Gow' via KUnit Development
> <kunit-dev@googlegroups.com> wrote:
> >
> > From: Sadiya Kazi <sadiyakazi@google.com>
> >
> > Added a new page (functionredirection.rst) that describes the Function
> > Redirection (static stubbing) API. This page will be expanded if we add,
> > for example, ftrace-based stubbing.
> >
> > In addition,
> > 1. Updated the api/index.rst page to create an entry for function
> >    redirection api
> > 2. Updated the toctree to be hidden, reducing redundancy on the
> >    generated page.
> >
> > Signed-off-by: Sadiya Kazi <sadiyakazi@google.com>
> > Co-developed-by: David Gow <davidgow@google.com>
> > Signed-off-by: David Gow <davidgow@google.com>
>
> Since I wrote the example code snippets (over at
> https://kunit.dev/mocking.html#compile-time), I wasn't sure if I
> should give an Rb tag.
> But the majority of this doc is text I had no part in writing, so with
> that caveat:
>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>
>

Thanks: I'd forgotten we'd adapted that code from the kunit.dev
website. We'll add you as a Co-developed-by in the next version.

> I noticed a few typos we could fix.
> The rest of my comments are optional suggestions about rewording some
> bits and adding `` to identifiers.
>

Most of the lack of `` in identifiers is deliberate: because the
kerneldoc comments are included, having the identifiers (particularly
functions and function-like macros, with the () after them)
automatically get turned into links to the reference documentation
below by sphinx.

> > ---
> >
> > Note that this patch is new to v1 of the series, and wasn't included in
> > the previous RFCs.
> >
> > ---
> >  .../kunit/api/functionredirection.rst         | 162 ++++++++++++++++++
> >  Documentation/dev-tools/kunit/api/index.rst   |  13 +-
> >  2 files changed, 172 insertions(+), 3 deletions(-)
> >  create mode 100644 Documentation/dev-tools/kunit/api/functionredirection.rst
> >
> > diff --git a/Documentation/dev-tools/kunit/api/functionredirection.rst b/Documentation/dev-tools/kunit/api/functionredirection.rst
> > new file mode 100644
> > index 000000000000..fc7644dfea65
> > --- /dev/null
> > +++ b/Documentation/dev-tools/kunit/api/functionredirection.rst
> > @@ -0,0 +1,162 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +========================
> > +Function Redirection API
> > +========================
> > +
> > +Overview
> > +========
> > +
> > +When writing unit tests, it's important to be able to isolate the code being
> > +tested from other parts of the kernel. This ensures the reliability of the test
> > +(it won't be affected by external factors), reduces dependencies on specific
> > +hardware or config options (making the test easier to run), and protects the
> > +stability of the rest of the system (making it less likely for test-specific
> > +state to interfere with the rest of the system).
> > +
> > +While for some code (typically generic data structures, helpers, and toher
>
> s/toher/other
>

Nice catch, thanks.

> > +"pure function") this is trivial, for others (like device drivers, filesystems,
>
> s/function/functions, perhaps?
>

Will fix, thanks.

> > +core subsystems) the code is heavily coupled with other parts of the kernel.
> > +
> > +This often involves global state in some way: be it global lists of devices,
>
> s/be it/be it a
>

Will change to "be it a global list" (singular).

> > +the filesystem, or hardware state, this needs to be either carefully managed,
> > +isolated, and restored, or avoided altogether by replacing access to and
> > +mutation of this state with a "fake" or "mock" variant.
>
> optional nit: this sentence feels a bit long.
> If we can find a way to split it up, that would be nice.
>
> Perhaps something like:
> This coupling is often due to global state: be it a global list of devices...
> Tests need to either carefully manage, isolate, and restore state or
> they can avoid it altogether by...
>

Sounds good to me! Will go with this.

> > +
> > +This can be done by refactoring the code to abstract out access to such state,
> > +by introducing a layer of indirection which can use or emulate a separate set of
>
> optional nit: "abstract our access... by introducing a layer of
> indirection" feels a bit redundant.
> These are the same thing.
>
> Perhaps instead: "abstract out access to such state so tests can..."
>

Hmm... I see what you mean, but do feel that explicitly calling out "a
layer of indirection" is more clear than just making it more
"abstract".
I'll play around with the wording of this.

> > +test state. However, such refactoring comes with its own costs (and undertaking
> > +significant refactoring before being able to write tests is suboptimal).
> > +
> > +A simpler way to intercept some of the function calls is to use function
> > +redirection via static stubs.
>
> Maybs s/intercept/replace?
> Intercept makes it sounds like we're supporting "test spies", but if
> you use the macro below, you have no way of implementing such a thing.
>
> E.g. it makes it sound like we can have
>   int func() {
>     if (intercepted) { ++func_called; }
>     // still run the rest of func
>   }
>

Yeah, test spies may be a feature we want to add later, but I agree
this could be confusing.

> > +
> > +
> > +Static Stubs
> > +============
> > +
> > +Static stubs are a way of redirecting calls to one function (the "real"
> > +function) to another function (the "replacement" function).
> > +
> > +It works by adding a macro to the "real" function which checks to see if a test
> > +is running, and if a replacement function is available. If so, that function is
> > +called in place of the original.
> > +
> > +Using static stubs is pretty straightforward:
> > +
> > +1. Add the KUNIT_STATIC_STUB_REDIRECT() macro to the start of the "real"
>
> nit: should we use ``KUNIT_STATIC_STUB_REDIRECT()`` to format it as code?
>

As noted above, sphinx will link to the reference for the macro if we
don't use quotes.

> > +   function.
> > +
> > +   This should be the first statement in the function, after any variable
> > +   declarations. KUNIT_STATIC_STUB_REDIRECT() takes the name of the
>
> ditto ``
>

Again, sphinx links without ``.

> > +   function, followed by all of the arguments passed to the real function.
> > +
> > +   For example:
> > +
> > +   .. code-block:: c
> > +
> > +       void send_data_to_hardware(const char *str)
> > +       {
> > +               KUNIT_STATIC_STUB_REDIRECT(send_data_to_hardware, str);
> > +               /* real implementation */
> > +       }
> > +
> > +2. Write one or more replacement functions.
> > +
> > +   These functions should have the same function signature as the real function.
> > +   In the event they need to access or modify test-specific state, they can use
> > +   kunit_get_current_test() to get a struct kunit pointer. This can then
>
> ditto for ``kunit_get_current_test`` and ``struct kunit``
>

Sphinx will also recognise the 'struct' keyword here, and should link
to the documentation for struct kunit.

> > +   be passed to the expectation/assertion macros, or used to look up KUnit
> > +   resources.
> > +
> > +   For example:
> > +
> > +   .. code-block:: c
> > +
> > +       void fake_send_data_to_hardware(const char *str)
> > +       {
> > +               struct kunit *test = kunit_get_current_test();
> > +               KUNIT_EXPECT_STREQ(test, str, "Hello World!");
> > +       }
> > +
> > +3. Activate the static stub from your test.
> > +
> > +   From within a test, the redirection can be enabled with
> > +   kunit_activate_static_stub(), which accepts a struct kunit pointer,
>
> ditto here
>
> > +   the real function, and the replacement function. You can call this several
> > +   times with different replacement functions to swap out implementations of the
> > +   function.
> > +
> > +   In our example, this would be
> > +
> > +   .. code-block:: c
> > +
> > +        kunit_activate_static_stub(test,
> > +                                   send_data_to_hardware,
> > +                                   fake_send_data_to_hardware);
> > +
> > +4. Call (perhaps indirectly) the real function.
> > +
> > +   Once the redirection is activated, any call to the real function will call
> > +   the replacement function instead. Such calls may be buried deep in the
> > +   implementation of another function, but must occur from the test's kthread.
> > +
> > +   For example:
> > +
> > +   .. code-block:: c
> > +
> > +        send_data_to_hardware("Hello World!"); /* Succeeds */
> > +        send_data_to_hardware("Something else"); /* Fails the test. */
> > +
> > +5. (Optionally) disable the stub.
> > +
> > +   When you no longer need it, the redirection can be disabled (and hence the
> > +   original behaviour of the 'real' function resumed) using
> > +   kunit_deactivate_static_stub(). If the stub is not manually deactivated, it
> > +   will nevertheless be disabled when the test finishes.
>
> optional nit: this block of text feels overly long to me, personally.
>
> Perhaps something shorter like:
> When you no longer need it, you can disable the stub manually by
> calling ``kunit_deactive_static_stub()``.
> Otherwise, it will be disabled automatically at the end of the test.
>

Hmm... I'm not sure if the explicit mention that this resumes the
normal "real" function behaviour is helpful. Will consider for v2.

> > +
> > +   For example:
> > +
> > +   .. code-block:: c
> > +
> > +        kunit_deactivate_static_stub(test, send_data_to_hardware);
> > +
> > +
> > +It's also possible to use these replacement functions to test to see if a
> > +function is called at all, for example:
> > +
> > +.. code-block:: c
> > +
> > +       void send_data_to_hardware(const char *str)
> > +       {
> > +               KUNIT_STATIC_STUB_REDIRECT(send_data_to_hardware, str);
> > +               /* real implementation */
> > +       }
> > +
> > +       /* In test file */
> > +       int times_called = 0;
> > +       void fake_send_data_to_hardware(const char *str)
> > +       {
> > +               /* fake implementation */
>
> minor nit: in the original example, this body was basically a placeholder.
> Given we're starting this section with saying "here's how you can
> count the function calls", this is the only thing you'd ever put in
> the body.
>
> So I'd prefer we just drop the comment.
>

Makes sense, will do.

> > +               times_called++;
> > +       }
> > +       ...
> > +       /* In the test case, redirect calls for the duration of the test */
> > +       kunit_activate_static_stub(test, send_data_to_hardware, fake_send_data_to_hardware);
> > +
> > +       send_data_to_hardware("hello");
> > +       KUNIT_EXPECT_EQ(test, times_called, 1);
> > +
> > +       /* Can also deactivate the stub early, if wanted */
> > +       kunit_deactivate_static_stub(test, send_data_to_hardware);
> > +
> > +       send_data_to_hardware("hello again");
> > +       KUNIT_EXPECT_EQ(test, times_called, 1);
> > +
> > +
> > +
> > +API Reference
> > +=============
> > +
> > +.. kernel-doc:: include/kunit/static_stub.h
> > +   :internal:
> > diff --git a/Documentation/dev-tools/kunit/api/index.rst b/Documentation/dev-tools/kunit/api/index.rst
> > index 45ce04823f9f..2d8f756aab56 100644
> > --- a/Documentation/dev-tools/kunit/api/index.rst
> > +++ b/Documentation/dev-tools/kunit/api/index.rst
> > @@ -4,17 +4,24 @@
> >  API Reference
> >  =============
> >  .. toctree::
> > +       :hidden:
> >
> >         test
> >         resource
> > +       functionredirection
> >
> > -This section documents the KUnit kernel testing API. It is divided into the
> > +
> > +This page documents the KUnit kernel testing API. It is divided into the
> >  following sections:
> >
> >  Documentation/dev-tools/kunit/api/test.rst
> >
> > - - documents all of the standard testing API
> > + - Documents all of the standard testing API
> >
> >  Documentation/dev-tools/kunit/api/resource.rst
> >
> > - - documents the KUnit resource API
> > + - Documents the KUnit resource API
> > +
> > +Documentation/dev-tools/kunit/api/functionredirection.rst
> > +
> > + - Documents the KUnit Function Redirection API
> > --
> > 2.39.0.rc0.267.gcb52ba06e7-goog
>
>

Cheers,
-- David

--0000000000003a5b3605efecc4f5
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
N0A3bgltvER3q1cGraQJMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAxS21FdvRtCQVc
jgEj+xxSnUr0N9reJlI5J9zRiBCWGxm5yhz965IDka3XVFEbj+beJj/gyHoxbaTGf2AjOufpcMqy
p4mtqc2l4Csudl8QeiBaOUDx4VKADbgxqpjvwD5zRpSKVj4S9y3BJi9xrRdPOm1Z2ZZYxRUxUz7d
2MXoxQsFucGJO5a4CwDBaGgJAqvwCXU5Q64rKVIUBk6mtcd3cDwX+PXqx4QrhHFGq6b6oi37YQ8B
+bhlXqlkLrbPlPFk+4Rh4EaW92iD5g8kvtXCOwvIIvs+15Io0dbpIe2W5UKo2OcyDDFvrOACmUOE
/GuEkhENcyDVyEs/4/N2u9WYMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABj4peqtakTCOMXLZ2mEqRMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAq
brvYSTnZ/5bXHmsTyBvUD/xTHXpgKn/y+y5YHzMAhDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjEyMTYwNzE3NDdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEATkC/dNnb4pwrnP7N4Qk7
3kjaN9rXUwS0LWxorWPb1Gv8JM5SSAaeqpks67SmeoEOaQZaGGZi8Qc4ygQDsv/jJfmXp1JshPvM
h024ZxeP7a03hFSAsGzL689I6gAhYxlV66gw89u+MaakMV/r5QWbzF51sEeo9EFvAUR/njcuGRKs
KKzzelX0mVi+B31Nh3vJ4dQPLj2ProPW+iEWn8w7gxC12quNgDidRwcIb8yP7eUM4GVfZXFOK3O6
xSrIzeH3pc3dI6FFNrQ2b8a1pZmQbtLHMxYCgNQzLy1VZf/OqWzzcoixm2HZif7Mq6kg2sNOLuWq
6Lc8iq0uVM/2vNJZHQ==
--0000000000003a5b3605efecc4f5--
