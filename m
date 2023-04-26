Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C986EEEB3
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Apr 2023 09:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239449AbjDZHAX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Apr 2023 03:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238588AbjDZHAV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Apr 2023 03:00:21 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F1130E1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Apr 2023 23:59:54 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-3ef34c49cb9so322191cf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Apr 2023 23:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682492386; x=1685084386;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KNJPmX6pG5kruo6GSe+ZwqGkKhlM5lIvYAr5h2XhEYw=;
        b=Lh6WkTW137Rh4NAAxoqeFjGXRvkykRdDnyaq5WZMiuTdfSTDt8+ZMlnOBToxfW8Jmr
         aSJuGkePWGgi1EntriX3TaoN6yxX2szyK1Dj+1e2vDtf4ZH8gbrwk7ILx5bB8hGy7Wkg
         BgsW8ZwAcnhOMv2bZsh06HBrDbqbvQ1jyeG7W6JNMFy6IovWShcRLsdsZ083VXB85pNO
         dttWIH5LjGMFNtIaqkNTMLsEJuLmS1Wvh7k3XbrlVftLvHl5A2Hh8ZNvJV0pUm3bMS+k
         OjXmBLXY1cxj8ptoy8ASYhBURHMD7yCU7xfIHRSxOAwx0gVdIs7lz3GHvpz4zM70PvZa
         JHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682492386; x=1685084386;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KNJPmX6pG5kruo6GSe+ZwqGkKhlM5lIvYAr5h2XhEYw=;
        b=XGQHU17kkmnWKCNx6+X8qvCDIaKOAOhZ8vcACW8rtRiqNxHvFDE4PNk/VDjFEHkggp
         V3RBVqoMlyImMZO+lry7/WEhACC3efluv09jSdZdrsyKFqKjdqH7ovsiODaaIafkQA7a
         GG8px1Si7JS0uYDCK+ImheCa/VCbDQ9DTV7Pky68yPvZ+zGs8HMPdUh6v4/iXkYKsGpe
         31J+gk/T6dUjzMQgWf07CZQL/00wWAKJMw3qYN4jZSAIIf2G9BgbVVR0WLov+NTCPrBE
         H/BcK7v4DY7h+Gu7DFNQPlIZtH4Kef5RU+qjoXzqOeU4CGkpsJOfmDwV6cKyJjcRO3ad
         74Cg==
X-Gm-Message-State: AC+VfDyC8fEN8q1p74Al+G+wV1n/RJjwRusKgtHkFYQFL0MxCQVf1baz
        FuFlCndGc6qWuXX4lO2i6yrKtK0qPyGFYwaWR0PCYw==
X-Google-Smtp-Source: ACHHUZ7sKCXKKQ5wsKGzwE3wwMMEaGOH5X9vxpZUwPyE5G5/6COsZjgbsAYbToDVkoi8cphmVTXkX19ZuZ/SOELDI10=
X-Received: by 2002:ac8:5f90:0:b0:3f0:af20:1a37 with SMTP id
 j16-20020ac85f90000000b003f0af201a37mr156621qta.15.1682492386401; Tue, 25 Apr
 2023 23:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230421084226.2278282-1-davidgow@google.com> <20230421084226.2278282-2-davidgow@google.com>
 <CAGS_qxp72dSbE9ZD7EyQ-JvXWucMs=LcX7uM1MAYL5oF_mtzgA@mail.gmail.com>
In-Reply-To: <CAGS_qxp72dSbE9ZD7EyQ-JvXWucMs=LcX7uM1MAYL5oF_mtzgA@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 26 Apr 2023 14:59:35 +0800
Message-ID: <CABVgOSkH+Nfjg3JeRc0My=8tVF4rXe7YL+_K6ExC_u4eDcvJLA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] kunit: Add kunit_add_action() to defer a call
 until test exit
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Rae Moar <rmoar@google.com>,
        Benjamin Berg <benjamin@sipsolutions.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000000d6c5005fa37c93d"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--0000000000000d6c5005fa37c93d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Apr 2023 at 10:12, Daniel Latypov <dlatypov@google.com> wrote:
>
> On Fri, Apr 21, 2023 at 1:42=E2=80=AFAM David Gow <davidgow@google.com> w=
rote:
> >
> > Many uses of the KUnit resource system are intended to simply defer
> > calling a function until the test exits (be it due to success or
> > failure). The existing kunit_alloc_resource() function is often used fo=
r
> > this, but was awkward to use (requiring passing NULL init functions, et=
c),
> > and returned a resource without incrementing its reference count, which
> > -- while okay for this use-case -- could cause problems in others.
> >
> > Instead, introduce a simple kunit_add_action() API: a simple function
> > (returning nothing, accepting a single void* argument) can be scheduled
> > to be called when the test exits. Deferred actions are called in the
> > opposite order to that which they were registered.
> >
> > This mimics the devres API, devm_add_action(), and also provides
> > kunit_remove_action(), to cancel a deferred action, and
> > kunit_release_action() to trigger one early.
>
> Apologies for the delayed bikeshedding.
>
> I think mimicking the devres API is a better idea than kunit_defer()
> and friends.
> But I can't help but think this still isn't the best name.
> I personally would have no idea what `kunit_release_action()` does
> without looking it up.
>
> I feel like `kunit_add_cleanup()` probably works better for a unit
> test framework.
> I think `kunit_remove_cleanup()` is fine and `kunit_release_cleanup()`
> is questionably ok.
> Instead of `release`, maybe it should be `kunit_trigger_cleanup()` or
> more verbosely, something like `kunit_early_trigger_cleanup()`.

Hmm... While personally I prefer 'defer' or 'cleanup' to 'action' in
isolation, I think the benefits of matching the devm_ API probably
exceed the benefits of a slightly better name here.

I'm less convinced by the _release_action() and _remove_action()
names: I definitely think 'trigger' is more obvious here. I hope that,
with some extra documentation, we can nevertheless make this
consistent with devm_*, but it's definitely suboptimal.

>
> I tried to look for equivalents in other languages/frameworks:
> * Rust and C++ rely on RAII, don't think they have equivalents in testing=
 libs
> * Python has `self.addCleanup()`,
> https://docs.python.org/3/library/unittest.html#unittest.TestCase.addClea=
nup
> * Go has `t.Cleanup()`, https://pkg.go.dev/testing#T.Cleanup
> * Looking at Zig since it also has a `defer`, I guess they just use
> that, I don't see anything in
> https://ziglang.org/documentation/master/std/#A;std:testing
> * I know nothing about JUnit, but a quick search seems like they rely
> on @After and @AfterClass annotations,
> https://junit.org/junit4/javadoc/4.12/org/junit/After.html
> * I know even less about HUnit, but it looks like it relies on
> wrapping things via the IO monad,
> https://hackage.haskell.org/package/HUnit-1.6.2.0/docs/Test-HUnit-Base.ht=
ml#t:AssertionPredicate
> * Since we were inspired by TAP, I tried to look at Perl, but didn't
> immediately see anything that looked equivalent,
> https://metacpan.org/pod/Test::Most
>

Thanks for putting that together. It looks like cleanup is the winner
here, followed maybe by defer. I'd been using 'cleanup' to refer to
the sum total of all deferred functions, resource free functions, and
the test 'exit()' function (i.e., everything which runs after a failed
assertion), so I don't want to totally confuse the issue.

Regardless, it's probably worth at least having a mention in the
documentation that these are referred to as a cleanup in
Python/Go/etc, and are vaguely equivalent to 'defer' in Go and Zig.

> >
> > This is implemented as a resource under the hood, so the ordering
> > between resource cleanup and deferred functions is maintained.
> >
> > Signed-off-by: David Gow <davidgow@google.com>
> > ---
>
> <snip>
>
> > diff --git a/include/kunit/resource.h b/include/kunit/resource.h
> > index c0d88b318e90..6db28cd43e9b 100644
> > --- a/include/kunit/resource.h
> > +++ b/include/kunit/resource.h
> > @@ -387,4 +387,80 @@ static inline int kunit_destroy_named_resource(str=
uct kunit *test,
> >   */
> >  void kunit_remove_resource(struct kunit *test, struct kunit_resource *=
res);
> >
> > +
> > +/**
> > + * kunit_add_action() - Defer an 'action' (function call) until the te=
st ends.
> > + * @test: Test case to associate the action with.
> > + * @func: The function to run on test exit
> > + * @ctx: Data passed into @func
> > + *
> > + * Defer the execution of a function until the test exits, either norm=
ally or
> > + * due to a failure.  @ctx is passed as additional context. All functi=
ons
> > + * registered with kunit_add_action() will execute in the opposite ord=
er to that
> > + * they were registered in.
> > + *
> > + * This is useful for cleaning up allocated memory and resources.
>
> Re renaming to kunit_add_cleanup(), I think this makes writing the
> comment easier.
>
> E.g.
> - kunit_add_action() - Defer an 'action' (function call) until the test e=
nds.
> + kunit_add_cleanup() - Call a function when the test ends.
> + ...
> + This is useful for cleaning up allocated memory and resources.
>

Good point. I think we can probably use the better description here
even if we don't rename the function.

Cheers,
-- David

> Daniel

--0000000000000d6c5005fa37c93d
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
64VRg2IjDI2fJVE9RD6aMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQA2lZLYRLu7foeR
cHo1VeNA974FZBiCm08Kd44/aCMEzdTJvxAE9xbUJf7hS1i6eW49qxuSp3/YLn6U7uatwAcmZcwp
Zma19ftf3LH+9Hvffk+X8fbPKe6uHkJhR2LktrhRzF159jj67NvXyGQv8J4n7UNeEVP0d5ByvRwv
tF2bJwlOwRGLoxasKSyDHIyUpwTfWYPq7XvjoGqQ/tDS7Khcc5WncJl0/ZEj7EKjtoGbsDbLdXEF
m/6vdcYKJzF9ghHewtV3YIU4RE3pEM4aCWWRtJwbExzeue6fI7RqURbNCAyQuSpWv0YQvzsX3ZX3
c1otrs50n1N0Sf8/rfJxq7sWMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAR
Gc3rzK+mXUNoQqqxinWU2dcLuMetuAERGTASyxiJtDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA0MjYwNjU5NDZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAkh0oiwSSXxpFu2uTDjOE
RTmUVoQt67w0Ccpma1lY9qG3q+U8Bf9wnv+OevdrzIpEZlzFdDhBemUOjRUBexjXvTEX0Wb33c7N
rBODcPjDlrTSWAs6VgA+ICOqJy57ny9HmvHmuqZYshKSGufKZjXo9yE0GSHZLQDqYp5pWp6YWdVI
I8ic2gwyriwn8YqMbnUwWjtanh8sph2jlTeEdfuPsYp8s61GPnHK8SK1yoQDRf3100DA/QC4A3nt
LS/cq5+bN6NQ3Fx+A4Y8GY41OJvhkxK8Z353YSK/uhApAFeb9PuCPwONF+7Vn9pNV88Og2fUlFAV
RMHl1tp8DJdTXKOTNA==
--0000000000000d6c5005fa37c93d--
