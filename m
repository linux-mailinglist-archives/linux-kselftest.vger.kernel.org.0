Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9300B6E2FC1
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Apr 2023 10:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjDOImq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Apr 2023 04:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDOImp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Apr 2023 04:42:45 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE363ABC
        for <linux-kselftest@vger.kernel.org>; Sat, 15 Apr 2023 01:42:43 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-2f87c5b4635so179924f8f.1
        for <linux-kselftest@vger.kernel.org>; Sat, 15 Apr 2023 01:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681548161; x=1684140161;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+Z3orGvWdAKTA5wVlyp7VEpZy/w/ykSNEurOkbyRcMA=;
        b=g8wVRv/t0kklv76Q4U6r9/qicaLQ2ISKQRCBeaLQAd9Fc6dOWBNYWYSORzc/wslbXq
         PIgrZ3boNXH00AvtCQArs6ujgmsWwYci23m4s223Pmz6BCKA68CNDqd2ffO6HaehA0Dr
         ZZDL830iVnU7TPHK8Jm3cLzn8w1xEiEjq3J1TcqHWIzM/PN4J7B58UZlSceMAeL5B0Ew
         XjtjjQsNhaC0F4gDyu2ZCk08PhK5y15gtDBJse7zb7CSTvl6+UEkQnhu2bODLJwGf8sQ
         uDkYKtK08mJ+aSdulz0jZ5uWOhVhG/2TI1g/rTmiVJOKjdqWM4FWV08DbqQ0omqQqpjT
         xTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681548161; x=1684140161;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Z3orGvWdAKTA5wVlyp7VEpZy/w/ykSNEurOkbyRcMA=;
        b=Srlbl+PPpnUAHB8xOuOl23Iq4D2MfMNb77A0uVru7Jn0l+TLm7+vLPfRdPPzHLV5aU
         XlrqGEyh1Yfk60bO1A6D0nPG5qU7J5tg7CNQOPgQgRCrH6yHv84JykUxsfnUTKOqtJtl
         fLTu6lBT2sipk0G+vOuaO4YSZLkn0XQv2Sn+HOAW5OemQ0aig31Tt+A+UZh4EcPresFl
         UGiq6HZCeMDaPdBjf+Qm2Z4drw/rglhgIiiY4zqRTo5Wu/hqfJuzFoBCiUQ0M3UQkDNq
         J1YiWiiLkFKbF7Rmvy/E128smskoZoOEpnUCmwd5N/hq2szpww6moxDxf5NdygVBvqxs
         c1xA==
X-Gm-Message-State: AAQBX9dZk1rnck0i1j1SFRCupuU6iRW3lLZXoTZ/6dZBCmNhdKyBDzeb
        vsQ8/XXuBSOeN3MMDhioCX1FWhRoFnyU7B6e6ttVzQ==
X-Google-Smtp-Source: AKy350beHIEW7z8Hj9YyTcgh27L0mCnt7AxJpOn/DnBDPwsaQfyJi6SHy1Vo2up1MS0Jf++6kQ35QYa0OcHek+Spw9U=
X-Received: by 2002:a5d:6a8d:0:b0:2f4:2188:7dad with SMTP id
 s13-20020a5d6a8d000000b002f421887dadmr280175wru.2.1681548161430; Sat, 15 Apr
 2023 01:42:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230331080411.981038-1-davidgow@google.com> <20230331080411.981038-2-davidgow@google.com>
 <56w47e5mff74b4jrpgl4odhjxzayoptb6u2e2u6haaf7tuvl4f@xwlmne7p6kli>
In-Reply-To: <56w47e5mff74b4jrpgl4odhjxzayoptb6u2e2u6haaf7tuvl4f@xwlmne7p6kli>
From:   David Gow <davidgow@google.com>
Date:   Sat, 15 Apr 2023 16:42:27 +0800
Message-ID: <CABVgOSmjs0wLUa4=ErkB9tH8p6A1P6N33befv63whF+hECRExQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] kunit: Add kunit_add_action() to defer a call
 until test exit
To:     maxime@cerno.tech
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        Rae Moar <rmoar@google.com>,
        Benjamin Berg <benjamin@sipsolutions.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000dc2b8705f95bf0a9"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--000000000000dc2b8705f95bf0a9
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Apr 2023 at 18:02, <maxime@cerno.tech> wrote:
>
> Hi David,
>
> On Fri, Mar 31, 2023 at 04:04:09PM +0800, David Gow wrote:
> > Many uses of the KUnit resource system are intended to simply defer
> > calling a function until the test exits (be it due to success or
> > failure). The existing kunit_alloc_resource() function is often used for
> > this, but was awkward to use (requiring passing NULL init functions, etc),
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
> >
> > This is implemented as a resource under the hood, so the ordering
> > between resource cleanup and deferred functions is maintained.
> >
> > Signed-off-by: David Gow <davidgow@google.com>
> > ---
> >
> > Changes since RFC v1:
> > https://lore.kernel.org/linux-kselftest/20230325043104.3761770-2-davidgow@google.com/
> > - Rename functions to better match the devm_* APIs. (Thanks Maxime)
> > - Embed the kunit_resource in struct kunit_action_ctx to avoid an extra
> >   allocation (Thanks Benjamin)
> > - Use 'struct kunit_action_ctx' as the type for cancellation tokens
> >   (Thanks Benjamin)
> > - Add tests.
> >
> > ---
> >  include/kunit/resource.h |  89 ++++++++++++++++++++++++++++
> >  lib/kunit/kunit-test.c   | 123 ++++++++++++++++++++++++++++++++++++++-
> >  lib/kunit/resource.c     |  99 +++++++++++++++++++++++++++++++
> >  3 files changed, 310 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/kunit/resource.h b/include/kunit/resource.h
> > index c0d88b318e90..15efd8924666 100644
> > --- a/include/kunit/resource.h
> > +++ b/include/kunit/resource.h
> > @@ -387,4 +387,93 @@ static inline int kunit_destroy_named_resource(struct kunit *test,
> >   */
> >  void kunit_remove_resource(struct kunit *test, struct kunit_resource *res);
> >
> > +typedef void (*kunit_defer_function_t)(void *ctx);
> > +
> > +/* An opaque token to a deferred action. */
> > +struct kunit_action_ctx;
> > +
> > +/**
> > + * kunit_add_action() - Defer an 'action' (function call) until the test ends.
> > + * @test: Test case to associate the action with.
> > + * @func: The function to run on test exit
> > + * @ctx: Data passed into @func
> > + * @internal_gfp: gfp to use for internal allocations, if unsure, use GFP_KERNEL
> > + *
> > + * Defer the execution of a function until the test exits, either normally or
> > + * due to a failure.  @ctx is passed as additional context. All functions
> > + * registered with kunit_add_action() will execute in the opposite order to that
> > + * they were registered in.
> > + *
> > + * This is useful for cleaning up allocated memory and resources.
> > + *
> > + * Returns:
> > + *   An opaque "cancellation token", or NULL on error. Pass this token to
> > + *   kunit_remove_action_token() in order to cancel the deferred execution of
> > + *   func().
> > + */
> > +struct kunit_action_ctx *kunit_add_action(struct kunit *test, kunit_defer_function_t func,
> > +                   void *ctx, gfp_t internal_gfp);
>
> I've tried to leverage kunit_add_action() today, and I'm wondering if
> passing the struct kunit pointer to the deferred function would help.
>

I'm tempted, but it does make the case where we just want to cast,
e.g., kfree() directly to an action pointer more difficult. Not that
that's a deal-blocker, but it was convenient...

> The code I'm struggling with is something like:
>
> > static int test_init(struct kunit *test)
> > {
> >       priv = kunit_kzalloc(sizeof(*priv), GFP_KERNEL);
> >       KUNIT_ASSERT_NOT_NULL(test, priv);
> >       test->priv = priv;
> >
> >       priv->dev = alloc_device();
> >
> >       return 0;
> > }
>
> and then in the test itself:
>
> > static void actual_test(struct kunit *test)
> > {
> >       struct test_priv *priv = test->priv;
> >
> >       id = allocate_buffer(priv->dev);
> >
> >       KUNIT_EXPECT_EQ(test, id, 42);
> >
> >       free_buffer(priv->dev, id);
> > }
>
> I'd like to turn free_buffer an action registered right after allocate
> buffer. However, since it takes several arguments and kunit_add_action
> expects a single pointer, we would need to create a structure for it,
> allocate it, fill it, and then free it when the action has ran.

The general case of wanting multiple arguments to an action is a bit
complicated. My plan was to initially support just the one argument,
and deal with more complicated cases later. Ideas included:
- using a struct like you suggest, possibly with some macro magic to
make it easier,
- having a bunch of very similar implementations of
kunit_add_action{2,3,4,..}(), which accept 2,3,4,... arguments,
- something horrible and architecture-specific with manually writing
out arguments to the stack (or registers)

None of those sounded particularly pleasant, though. My suspicion is
that the "right" way of doing this is to maybe have one or two helpers
for common cases (e.g., 2 arguments), and just suggest people create a
structure for anything more complicated, but I'd love a nicer
solution.

>
> It creates a lot of boilerplate, while if we were passing the pointer to
> struct kunit we could access the context of the test as well, and things
> would be much simpler.

For the test context specifically, can you just use kunit_get_current_test()?

There might be an issue with using it during the cleanup process after
a failed assertion (as if the test is aborted early, the cleanup runs
in a different thread), but if so, this should fix it:
---
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index e2910b261112..2d7cad249863 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -392,10 +392,21 @@ static void kunit_case_internal_cleanup(struct
kunit *test)
static void kunit_run_case_cleanup(struct kunit *test,
                                  struct kunit_suite *suite)
{
+       /*
+        * If we're no-longer running from within the test kthread()
because it failed
+        * or timed out, we still need the context to be okay when
running exit and
+        * cleanup functions.
+        */
+       struct kunit *old_current = current->kunit_test;
+
+       current->kunit_test = test;
       if (suite->exit)
               suite->exit(test);

       kunit_case_internal_cleanup(test);
+
+       /* Restore the thread's previous test context (probably NULL
or test). */
+       current->kunit_test = old_current;
}

struct kunit_try_catch_context {
---

I'll look into tidying that up and sending it through next week, anyway.

Cheers,
-- David

--000000000000dc2b8705f95bf0a9
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
LmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5n
bG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG9w0BAQsFAAOCAQEANyYcO+9JZYyqQt41
TMwvFWAw3vLoLOQIfIn48/yea/ekOcParTb0mbhsvVSZ6sGn+txYAZb33wIb1f4wK4xQ7+RUYBfI
TuTPL7olF9hDpojC2F6Eu8nuEf1XD9qNI8zFd4kfjg4rb+AME0L81WaCL/WhP2kDCnRU4jm6TryB
CHhZqtxkIvXGPGHjwJJazJBnX5NayIce4fGuUEJ7HkuCthVZ3Rws0UyHSAXesT/0tXATND4mNr1X
El6adiSQy619ybVERnRi5aDe1PTwE+qNiotEEaeujz1a/+yYaaTY+k+qJcVxi7tbyQ0hi0UB3myM
A/z2HmGEwO8hx7hDjKmKbDCCA18wggJHoAMCAQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUA
MEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWdu
MRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEg
MB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzAR
BgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4
Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0EXyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuu
l9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+JJ5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJ
pij2aTv2y8gokeWdimFXN6x0FNx04Druci8unPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh
6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTvriBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti
+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGjQjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8E
BTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5NUPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEA
S0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigHM8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9u
bG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmUY/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaM
ld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88
q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcya5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/f
hO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/XzCCBNgwggPAoAMCAQICEAHHLXCbS0CYcocWQtL1
FY8wDQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExKjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjMgU01JTUUgQ0EgMjAyMDAeFw0yMzAxMjkw
NjQ2MThaFw0yMzA3MjgwNjQ2MThaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5j
b20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC+31G8qfgjYj6KzASqulKfP5LGLw1o
hZ6j8Uv9o+fA+zL+2wOPYHLNIb6jyAS16+FwevgTr7d9QynTPBiCGE9Wb/i2ob9aBcupQVtBjlJZ
I6qUXdVBlo5zsORdNV7/XEqlpu+X5MK5gNHlWhe8gNpAhADSib2H4rjBvFF2yi9BHBAYZU95f0IN
cSS0WDNSSCktPaXtAGsI3tslroyjFYUluwGklmQms/tV8f/52zc7A5lzX+hxnnJdsRgirJRI9Sb6
Uypzk06KLxOO2Pg9SFn6MwbAO6LuInpokhxcULUz3g/CMQBmEMSEzPPnfDIAqwDI0Kqh0NAin+V4
fQxJfDCZAgMBAAGjggHUMIIB0DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1Ud
DwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFJyglaiY
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
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDh
Ot0VpVqRvDkwUoHhmxl4J4oKLjZ/A5na6uO0omZQ8jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA0MTUwODQyNDFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEABK0JuuYVUzwCrZFIK3Qh
VMLcEkn05rwO9N1tlx8/pWShA9btOdfoT6M8Fr0Z86pLOQ9dxyjJ1ZmyKG6Jd/ByldDHCaZUCPoz
Nvp+ys792jaKeYExX9QsQ4FEq7szev+SbupM+TxrfU0xayBtlYJTE49qwilq2sBCEDQX4cRxvukp
UsMAkJ4y+0aVRp7ISg7nHnnC2ZB8twr2DGZxj2/P5ogI3YVOx7MWK0iilofTT1tmO16QGyI2HXB1
sgQZ1W8gIo3mMfWSuVrcRwxfVBWpL98yIrUrpD+kdApakgSItOxAURc6LMmv1I4p/v+PQPdFngYg
YELeXN3aXf5CZGbnqw==
--000000000000dc2b8705f95bf0a9--
