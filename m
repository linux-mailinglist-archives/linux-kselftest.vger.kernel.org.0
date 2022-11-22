Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FF26333CB
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Nov 2022 04:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbiKVDQh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Nov 2022 22:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiKVDQg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Nov 2022 22:16:36 -0500
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7451FCF0
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Nov 2022 19:16:34 -0800 (PST)
Received: by mail-vk1-xa2b.google.com with SMTP id v81so6609278vkv.5
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Nov 2022 19:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mdm3PzzRKAM9Eqz/8nQE3adLHrBr0qQUHpfAMLeUVrQ=;
        b=gXNjLqYyRsOA9aZkvAzXK5hOEBQv7cslnL3WRHMYpDG/GjqZk+V/O+zwzQdWXrH8vP
         5EhsI5HbfJ2TP5GuecykzptKPUTaIKatCoUIcDUSuPNXgN5+ftZBfswfDfBiUXd1eDmn
         z5BafhmZ///nm+VVVc78eBneHG5zGHgEbpyUD/Q231H59QczlY45+qOE7qeOglYhh0jP
         4D3aOzLG9Y8X2PpisAc4sdb8QBzXSmRBvef8pqKkT3CBMTxNmkQbekiO3sHkUDAyA3BK
         lW2pTWurjtqerzW59z3nNXZiuOk8JCE7NnVcj9yK1T5GMC81F0SCAltBsuOSKpb1qTG6
         uvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mdm3PzzRKAM9Eqz/8nQE3adLHrBr0qQUHpfAMLeUVrQ=;
        b=mHyKb/5RZ2uH/I5jUHuhnxp5tSWBeiFUw1rODhYgmiAtu0hD4NsMdhy9m6fNcNNNdG
         Egzu1057HkmD/sAyqhF53Sw3bm2+GcCFN1iYDjN/sZwIKl6uYoqZEWu9bK/QP0hjzZjG
         PqdcVY5/ErQ3VZbrPGtQl/DkQJXz+IkC+Pr8d1kmNtt45521syJ82D1TXetZy8Yz/Uc0
         CfazXT5PVzv6v8J1Gyi4FLEohbzzPJ1iIIu+lr1csHr1BUFmgRp3Yn4t7yo2LpQEKl8f
         fty+DhDFQEQXmkJ3r9QR1ZFPmxOu34h47dDUmXRsisdjVKiBhlTsgl3ThIg8Ukze826H
         Pnhw==
X-Gm-Message-State: ANoB5pmwuJ4lvA7hRyaIAoYSaGYSb+MGHmpwj7YVWB3jk0+seiL9O1y8
        GmLYfDBJrsQlNQ9PZ2YXgUwHYKJoijqS+peBicWRew==
X-Google-Smtp-Source: AA0mqf7i7fdO0g1QCXYVKToJMP19slSxEyxcYGKJ5EuaIYU6dAixRgzNV8uIVMuqe4Oh78YBJNI/VswBMtrr/H75z94=
X-Received: by 2002:a1f:b247:0:b0:3bb:ea0f:9330 with SMTP id
 b68-20020a1fb247000000b003bbea0f9330mr1714493vkf.4.1669086993448; Mon, 21 Nov
 2022 19:16:33 -0800 (PST)
MIME-Version: 1.0
References: <20221119081252.3864249-1-davidgow@google.com> <20221119081252.3864249-2-davidgow@google.com>
 <CAGS_qxqAUiMfKe2ksnqQtyWv0BWYLA4_uGqpu76d=Oh42mAUgQ@mail.gmail.com>
In-Reply-To: <CAGS_qxqAUiMfKe2ksnqQtyWv0BWYLA4_uGqpu76d=Oh42mAUgQ@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 22 Nov 2022 11:16:21 +0800
Message-ID: <CABVgOSmfcJLs76efLe1zXgZwrSXrxKCLPAhSyx3P+WEkzZNR3A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] kunit: Use the static key when retrieving the
 current test
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        Jonathan Corbet <corbet@lwn.net>,
        Sadiya Kazi <sadiyakazi@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000005e383a05ee06993c"
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

--0000000000005e383a05ee06993c
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 22, 2022 at 10:21 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Sat, Nov 19, 2022 at 12:13 AM 'David Gow' via KUnit Development
> <kunit-dev@googlegroups.com> wrote:
> >
> > In order to detect if a KUnit test is running, and to access its
> > context, the 'kunit_test' member of the current task_struct is used.
> > Usually, this is accessed directly or via the kunit_fail_current_task()
> > function.
> >
> > In order to speed up the case where no test is running, add a wrapper,
> > kunit_get_current_test(), which uses the static key to fail early.
> > Equally, Speed up kunit_fail_current_test() by using the static key.
> >
> > This should make it convenient for code to call this
> > unconditionally in fakes or error paths, without worrying that this will
> > slow the code down significantly.
> >
> > If CONFIG_KUNIT=n (or m), this compiles away to nothing. If
> > CONFIG_KUNIT=y, it will compile down to a NOP (on most architectures) if
> > no KUnit test is currently running.
> >
> > Note that kunit_get_current_test() does not work if KUnit is built as a
> > module. This mirrors the existing restriction on kunit_fail_current_test().
> >
> > Note that the definition of kunit_fail_current_test() still wraps an
> > empty, inline function if KUnit is not built-in. This is to ensure that
> > the printf format string __attribute__ will still work.
> >
> > Also update the documentation to suggest users use the new
> > kunit_get_current_test() function, update the example, and to describe
> > the behaviour when KUnit is disabled better.
> >
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Sadiya Kazi <sadiyakazi@google.com>
> > Signed-off-by: David Gow <davidgow@google.com>
>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>
>
> Looks good to me, but some small optional nits about the Documentation.
>
> I'm a bit sad that the kunit_fail_current_test() macro is now a bit
> more complicated (has two definitions).

I'm not too happy with it either, but I think it's worth having the
printf() format string checking, as well as making it possible to
optimise the call out (without needing LTO), and I can't think of a
better way of doing that at the moment.

The only other option I can think of would be to have lots of #ifdefs
for the _contents_ of the functions, and that seemed more ugly to me.

> Optional: perhaps it's long enough now that we should have a comment
> after the #endif, i.e.
> #endif   /* IS_BUILTIN(CONFIG_KUNIT) */
>

Makes sense to me. Will add in v3.

> <snip>
>
> >
> > diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> > index 2737863ef365..e70014b82350 100644
> > --- a/Documentation/dev-tools/kunit/usage.rst
> > +++ b/Documentation/dev-tools/kunit/usage.rst
> > @@ -625,17 +625,21 @@ as shown in next section: *Accessing The Current Test*.
> >  Accessing The Current Test
> >  --------------------------
> >
> > -In some cases, we need to call test-only code from outside the test file.
> > -For example, see example in section *Injecting Test-Only Code* or if
> > -we are providing a fake implementation of an ops struct. Using
> > -``kunit_test`` field in ``task_struct``, we can access it via
> > -``current->kunit_test``.
> > +In some cases, we need to call test-only code from outside the test file,
> > +for example,  when providing a fake implementation of a function, or to fail
>
> nit: there are two spaces after "for example, "
>
> Personal preference: I'd rather keep "For example," as the start of a
> new sentence.
>
> > +any current test from within an error handler.


Hmm... I found it a bit ugly to keep "For example" at the start of the
sentence, as we then have to stick a (possibly duplicated) verb in to
make it actually a sentence.

How about:
In some cases, we need to call test-only code from outside the test
file. For example, this is useful when providing a fake implementation
of a function, or if we wish to fail the current test from within an
error handler.


> > +We can do this via the ``kunit_test`` field in ``task_struct``, which we can
> > +access using the ``kunit_get_current_test`` function in ``kunit/test-bug.h``.
>
> Personal preference: kunit_get_current_test()
> IMO that would make it easier to pick up when the reader is quickly
> scanning over.
>

Agreed, will fix in v3.

> >
> > -The example below includes how to implement "mocking":
> > +``kunit_get_current_test`` requires KUnit be built-in to the kernel, i.e.
> > +``CONFIG_KUNIT=y``. It is safe to call even if KUnit is not enabled, is built as a module,
> > +or no test is currently running, in which case it will quickly return ``NULL``.
>
> I find this sentence a bit confusing.
>
> I think it's trying to convey that
> * it can be called no matter how the kernel is built or what cmdline
> args are given
> * but it doesn't work properly for CONFIG_KUNIT=m
> * for CONFIG_KUNIT=n, it's a static inline func that just returns NULL
> * when booting with `kunit.enabled=0`, it's fast (thanks to static keys)
>

Yeah: that's the goal.

> But the current wording basically says "the func requires
> CONFIG_KUNIT=y" then says it's safe to call it even if CONFIG_KUNIT=n.
> It feels a bit whiplashy.
>
> Should this be reworded to say the function can be used regardless of
> whether KUnit is enabled but add a `note` block about how it doesn't
> properly for CONFIG_KUNIT=m?
>

How about:
``kunit_get_current_test()`` is safe to call even if KUnit is not
enabled. If KUnit is not enabled (or was built as a module), or no
test is running, it will return NULL.

Or:
``kunit_get_current_test()`` is always available, but will only return
a test if KUnit is built-in to the kernel (i.e, CONFIG_KUNIT=y). In
all other cases, it will return NULL.

We could add a:
This will compile to either a no-op or a static key, so will have
negligible performance impact when no test is running.

Thoughts?

Regardless, the plan is to eventually get rid of the restriction with
modules, so hopefully that part of the awkwardness won't last too
long.

> > +
> > +The example below uses this to implement a "mock" implementation of a function, ``foo``:
> >
> >  .. code-block:: c
> >
> > -       #include <linux/sched.h> /* for current */
> > +       #include <kunit/test-bug.h> /* for kunit_get_current_test */
> >
> >         struct test_data {
> >                 int foo_result;
> > @@ -644,7 +648,7 @@ The example below includes how to implement "mocking":
> >
> >         static int fake_foo(int arg)
> >         {
> > -               struct kunit *test = current->kunit_test;
> > +               struct kunit *test = kunit_get_current_test();
> >                 struct test_data *test_data = test->priv;
> >
> >                 KUNIT_EXPECT_EQ(test, test_data->want_foo_called_with, arg);
> > @@ -675,7 +679,7 @@ Each test can have multiple resources which have string names providing the same
> >  flexibility as a ``priv`` member, but also, for example, allowing helper
> >  functions to create resources without conflicting with each other. It is also
> >  possible to define a clean up function for each resource, making it easy to
> > -avoid resource leaks. For more information, see Documentation/dev-tools/kunit/api/test.rst.
> > +avoid resource leaks. For more information, see Documentation/dev-tools/kunit/api/resource.rst.
>
> Oops, thanks for cleaning this up.
> I guess I forgot to update this when splitting out resource.rst or my
> change raced with the rewrite of this file.
>
> >
> >  Failing The Current Test
> >  ------------------------
> > @@ -703,3 +707,6 @@ structures as shown below:
> >         static void my_debug_function(void) { }
> >         #endif
> >
> > +Note that ``kunit_fail_current_test`` requires KUnit be built-in to the kernel, i.e.
> > +``CONFIG_KUNIT=y``. It is safe to call even if KUnit is not enabled, is built as a module,
> > +or no test is currently running, but will do nothing.
>
> This is the same wording as above.
> I think it's clearer since what it's trying to convey is simpler, so
> it's probably fine.
>
> But if we do end up thinking of a good way to reword the previous bit,
> we might want to reword it here too.

Yeah: I wrote this one first, then copied it above, so that's why this
one is a bit simpler. If we come up with something better for the
first one, we can keep it.

_Maybe_ if we moved things to a .. note block, then we could share
that between both of these sections, though that has its own issues.

--0000000000005e383a05ee06993c
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
MDIwAhABj4peqtakTCOMXLZ2mEqRMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCg
zPKGUHTJ1x11tMloR3IPm/F719CrRK2Z/NfWWSNe4jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjExMjIwMzE2MzNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAT5da0pA7DGCYtXMzh7s/
bmJMgfT0UT24Me405XeXMu1qaznpsOgN+ut8NC3K7AIlMWLaqMSktXjdtRBfSSGsFdxp9k+xx1Ke
8XqjBiED9hLQCVIzuSprw57hSVy5iTnlTlqnuQRFPQvmal2RJ8+mn2R/kD4egBt77qNPvMFSCo28
/U22wJujzmERc92HjB8c84OVddxtPptfZsIOGsP0vTaZv7vZvkdQxFCu0FIoa61wY5Hm32hi6eSW
X6aofx5IqmmYk8X7oTSN2S8OlJqv98ZQxBn5uO9637yeZoJM2+3hi1v17lAfvNXTKkYJm4DJ+DoR
eOghOTzzMXIW2o2v/A==
--0000000000005e383a05ee06993c--
