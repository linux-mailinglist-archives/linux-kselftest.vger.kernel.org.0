Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E464E6E2FC5
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Apr 2023 10:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjDOItI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Apr 2023 04:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDOItH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Apr 2023 04:49:07 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CC240E1
        for <linux-kselftest@vger.kernel.org>; Sat, 15 Apr 2023 01:49:05 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id he13so16446135wmb.2
        for <linux-kselftest@vger.kernel.org>; Sat, 15 Apr 2023 01:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681548544; x=1684140544;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ieNokU2/c55I4Cta/WQIN3RG/XNcqeYcDJaj36JOeNA=;
        b=zgP+Gcx+sRLz5FPeS8GKbi2tSs/7VyPY/RF8XmtrRdh4ZMmj/gAV+z7s4lvgImx7qa
         k5xNOoOt2UFDT3q3Dp2jVALEFKSwbqhFpLAFdDOkPhmlDsA1+jKBbzvDLEG3vE6GIvQn
         MMT6GC0W80/J8G4h7insTV82jIimNQP9jSkdgQYAbqQwG9KvN6Rmf73UNdcJD/DZLZFv
         0UKgO1E0SvhfW9Ea40OmGv8q0piH/H168GiwMf/WeZ4j9ZpyWyT6xgEDvUpwmEuthCuD
         aeccawZ/gKmn9weNM4KQvAxscOtL3J0Dx9IHcSXnq8Ew2eoKiNizSXgy+z5S8fiLgiwk
         QxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681548544; x=1684140544;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ieNokU2/c55I4Cta/WQIN3RG/XNcqeYcDJaj36JOeNA=;
        b=jpdaGjjJVgS55LMrMOEGM7nVaMsmGjp3qhNpRDK/2nqBT8C0xKnAMifIeJ1SayuWsV
         awEa/F6ZVBW4WFQm79UGTk98le04Vqz8Nt/jIgAGjZhT+1OlK1OrV07j2KgLtngMKRo9
         RC+d8hlV4Mhj4BYdrK5S/seoWJ7szOTe/xQf0WA9CWrZj40hkevFSFRFaFyM+syXuO3H
         IYswAWoKLgORalin9Xndu4x8SJy36+CI1FYnPcLw47GYWPLW7cNdb9oHKVP9gDvvNDC8
         QE6IRXKBTHxn0woZwAdLrF/yuGGrMsjdB96p1NnIP9az0J+Q/ymdx8A1EeHJVMtGLDNG
         ZfWw==
X-Gm-Message-State: AAQBX9fzhINhUPI9EYJBbzrKzUctxR/jyC8fhyqtEiUotFQo7U4PU4NR
        yJ/e9EU7F8g+W3EAH3Z5rQzvcZMuy2yFy4wIsa6JWw==
X-Google-Smtp-Source: AKy350Ys6zojeKI4qMGhiGjZsUmwHEYhqt3cMiJ6DKvWX2ZR2M/0OBwWt+Y2H+Ozrg87pDLocQmdyZ7vHbKbk4dBuRk=
X-Received: by 2002:a1c:7910:0:b0:3df:97cf:4590 with SMTP id
 l16-20020a1c7910000000b003df97cf4590mr1945091wme.3.1681548544162; Sat, 15 Apr
 2023 01:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230331080411.981038-1-davidgow@google.com> <20230331080411.981038-2-davidgow@google.com>
 <56w47e5mff74b4jrpgl4odhjxzayoptb6u2e2u6haaf7tuvl4f@xwlmne7p6kli> <f51a15fbc49b9119a9e5db8240facd6ab51a0d46.camel@sipsolutions.net>
In-Reply-To: <f51a15fbc49b9119a9e5db8240facd6ab51a0d46.camel@sipsolutions.net>
From:   David Gow <davidgow@google.com>
Date:   Sat, 15 Apr 2023 16:48:51 +0800
Message-ID: <CABVgOSkOh_Hyme9nuAPVf87XR8JcwRtB_Y6qc9GWwgooubAaZQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] kunit: Add kunit_add_action() to defer a call
 until test exit
To:     Benjamin Berg <benjamin@sipsolutions.net>
Cc:     maxime@cerno.tech, Matti Vaittinen <mazziesaccount@gmail.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        Rae Moar <rmoar@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000abc4e805f95c0750"
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

--000000000000abc4e805f95c0750
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Apr 2023 at 19:00, Benjamin Berg <benjamin@sipsolutions.net> wrote:
>
> Hi,
>
> On Fri, 2023-04-14 at 12:01 +0200, maxime@cerno.tech wrote:
> > Hi David,
> >
> > On Fri, Mar 31, 2023 at 04:04:09PM +0800, David Gow wrote:
> > > Many uses of the KUnit resource system are intended to simply defer
> > > calling a function until the test exits (be it due to success or
> > > failure). The existing kunit_alloc_resource() function is often used for
> > > this, but was awkward to use (requiring passing NULL init functions, etc),
> > > and returned a resource without incrementing its reference count, which
> > > -- while okay for this use-case -- could cause problems in others.
> > >
> > > Instead, introduce a simple kunit_add_action() API: a simple function
> > > (returning nothing, accepting a single void* argument) can be scheduled
> > > to be called when the test exits. Deferred actions are called in the
> > > opposite order to that which they were registered.
> > >
> > > This mimics the devres API, devm_add_action(), and also provides
> > > kunit_remove_action(), to cancel a deferred action, and
> > > kunit_release_action() to trigger one early.
> > >
> > > This is implemented as a resource under the hood, so the ordering
> > > between resource cleanup and deferred functions is maintained.
> > >
> > > Signed-off-by: David Gow <davidgow@google.com>
> > > ---
> > >
> > > Changes since RFC v1:
> > > https://lore.kernel.org/linux-kselftest/20230325043104.3761770-2-davidgow@google.com/
> > > - Rename functions to better match the devm_* APIs. (Thanks Maxime)
> > > - Embed the kunit_resource in struct kunit_action_ctx to avoid an extra
> > >   allocation (Thanks Benjamin)
> > > - Use 'struct kunit_action_ctx' as the type for cancellation tokens
> > >   (Thanks Benjamin)
> > > - Add tests.
> > >
> > > ---
> > >  include/kunit/resource.h |  89 ++++++++++++++++++++++++++++
> > >  lib/kunit/kunit-test.c   | 123 ++++++++++++++++++++++++++++++++++++++-
> > >  lib/kunit/resource.c     |  99 +++++++++++++++++++++++++++++++
> > >  3 files changed, 310 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/kunit/resource.h b/include/kunit/resource.h
> > > index c0d88b318e90..15efd8924666 100644
> > > --- a/include/kunit/resource.h
> > > +++ b/include/kunit/resource.h
> > > @@ -387,4 +387,93 @@ static inline int kunit_destroy_named_resource(struct kunit *test,
> > >   */
> > >  void kunit_remove_resource(struct kunit *test, struct kunit_resource *res);
> > >
> > > +typedef void (*kunit_defer_function_t)(void *ctx);
> > > +
> > > +/* An opaque token to a deferred action. */
> > > +struct kunit_action_ctx;
> > > +
> > > +/**
> > > + * kunit_add_action() - Defer an 'action' (function call) until the test ends.
> > > + * @test: Test case to associate the action with.
> > > + * @func: The function to run on test exit
> > > + * @ctx: Data passed into @func
> > > + * @internal_gfp: gfp to use for internal allocations, if unsure, use GFP_KERNEL
> > > + *
> > > + * Defer the execution of a function until the test exits, either normally or
> > > + * due to a failure.  @ctx is passed as additional context. All functions
> > > + * registered with kunit_add_action() will execute in the opposite order to that
> > > + * they were registered in.
> > > + *
> > > + * This is useful for cleaning up allocated memory and resources.
> > > + *
> > > + * Returns:
> > > + *   An opaque "cancellation token", or NULL on error. Pass this token to
> > > + *   kunit_remove_action_token() in order to cancel the deferred execution of
> > > + *   func().
> > > + */
> > > +struct kunit_action_ctx *kunit_add_action(struct kunit *test, kunit_defer_function_t func,
> > > +                     void *ctx, gfp_t internal_gfp);
> >
> > I've tried to leverage kunit_add_action() today, and I'm wondering if
> > passing the struct kunit pointer to the deferred function would help.
> >
> > The code I'm struggling with is something like:
> >
> > > static int test_init(struct kunit *test)
> > > {
> > >         priv = kunit_kzalloc(sizeof(*priv), GFP_KERNEL);
> > >         KUNIT_ASSERT_NOT_NULL(test, priv);
> > >         test->priv = priv;
> > >
> > >         priv->dev = alloc_device();
> > >
> > >         return 0;
> > > }
> >
> > and then in the test itself:
> >
> > > static void actual_test(struct kunit *test)
> > > {
> > >         struct test_priv *priv = test->priv;
> > >
> > >         id = allocate_buffer(priv->dev);
> > >
> > >         KUNIT_EXPECT_EQ(test, id, 42);
> > >
> > >         free_buffer(priv->dev, id);
> > > }
> >
> > I'd like to turn free_buffer an action registered right after allocate
> > buffer. However, since it takes several arguments and kunit_add_action
> > expects a single pointer, we would need to create a structure for it,
> > allocate it, fill it, and then free it when the action has ran.
> >
> > It creates a lot of boilerplate, while if we were passing the pointer to
> > struct kunit we could access the context of the test as well, and things
> > would be much simpler.
>
> The question seems to be what about the typical use-case. I was always
> imagining calling functions like kfree/kfree_skb which often only
> require a single argument.

Yeah, my thought was that having just the one argument would be
easiest for re-using existing functions. That being said, implementing
a simple wrapper which just discards the 'test' argument is probably
more ergonomic than having to write all the struct manipulation stuff,
so it depends a bit on what proves the more common case.

> For arbitrary arguments, a struct and custom free function will be
> needed. At that point, maybe it is fair to assume that API users will
> use the resource API directly, doing the same trick as kunit_add_action
> and storing the arguments together with struct kunit_resource.
>
At this point, I'd still probably use the kunit_add_action() API, just
because the resource one adds yet more complication with the 'init'
function and the reference counting. I have some vague plans to
simplify it a bit, but still definitely wouldn't rule out using the
action API here, even if it involves managing structs.


> That said, maybe one could add it as a second argument? It is a little
> bit weird API wise, but it would allow simply casting single-argument
> functions in order to ignore "struct kunit *" argument.
>

Ooh... that's evil in a particularly fun way. :-) It'd definitely be
convenient in both cases (we usually need to cast kfree() anyway for
const reasons), so I'm a bit tempted. Do we know that this would work
with the calling convention on all architectures? I'm not aware of the
kernel using anything like stdcall where the callee pops the stack on
return, but there definitely could be some architecture which does...

Cheers,

-- David

--000000000000abc4e805f95c0750
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
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCv
8uFoxmPlcFKZ4Bn2e5JtfnmU3fVPD2tT+qvN2+mzWzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA0MTUwODQ5MDRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAg4Yr8/cJzvU0roTUe+nH
wezGj1X43K2phrWCm9zAei4kQlH6UcZF4txKaEKonJDcUJr20djEeO1KJ2cuHXuSD12wzD07TPS8
IzMKjgN3BPGZUav8dNuZicg0Liycysa5MyqhHKz6lkKeb8xMduqSTz8B0XGJt4WgvsI5psq5n6n9
sR34BzBCPZcdchA+Dbwa3uM6/YHMN7eGAo01CZiYQroIlgj10QUc9XNurAgptTFnWgclXWIHRizy
U1benCtft+PTM7/V7cHmPvIpE8oZADkRIutli3t5zBOc2lczyMVEAK+5GN875/aopR1gOuyLBN/q
qE3QbDBgpGUSUYjnag==
--000000000000abc4e805f95c0750--
