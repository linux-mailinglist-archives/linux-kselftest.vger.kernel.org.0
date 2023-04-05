Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C726B6D766D
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Apr 2023 10:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237373AbjDEIKN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Apr 2023 04:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237350AbjDEIKM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Apr 2023 04:10:12 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFE7198E
        for <linux-kselftest@vger.kernel.org>; Wed,  5 Apr 2023 01:09:37 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id dg15so19085759vsb.13
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Apr 2023 01:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680682158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jlnLyZGevKrYjHhtZFT69GlcypR+os4O+gg5OGb8db0=;
        b=ffYkraaJHdOGMlFJsByjRGiR4NR9xEFC04wh8gTEVF5IwQoGmN3O+i3UAmIKrStCiy
         3YrtimXk1lPS+5dVrtA/MqLhCCJQLKsL3qWm5uSMmuUwlZCqAa0wP1fYo6ZULJcTh5pL
         y1/0H0svH082FhCKjkOeqSMxQPd+0hgquw2opGrccVySF9A941Jd5FQB0tPS3xkaYJKg
         SOoZC+GOGw042LTSmuQAjfq8GsjpO14duyChDbo0zC4VZ7nTYCr1jSfOeI3TEkUgyVmj
         J6dncusUW9/OyAIbpJjJkMtXSXN0K3GxqeDkGgC8gVNZUZ/N5Kcs5r+BxymyZW/qE/KR
         n1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680682158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jlnLyZGevKrYjHhtZFT69GlcypR+os4O+gg5OGb8db0=;
        b=kVn7YXaHoc9Floor3YeC4Xj82kAiIaJr7BOeYm1gd7maMe7pgx2+5m201DVeUPAKVR
         YbQy930nSRkHjV5XkuIoeN7jpMtqUfpSxLhg9LI1xPS8TXUdvHmHzKXxQudyg1qvGBop
         UtmcDz08UzqTH+w1RJ54bnApQFa8Xoe5mlwF75KnMxbw+FTKwgcs7Cjj+wOS3IXkQDV+
         hIsNfW2groUutGdYWBkgatcE4rEWPx/kpnIDifEsE6yFFmlTzjyP4oQgk4p4wFQ4q2/P
         1oEzKRR1SmGuNJzO156B43111OeRjp0PKC5n398w9fQR5RgKQsqps7m6HJUkBUUSITpS
         NTcQ==
X-Gm-Message-State: AAQBX9dWYzcTEjVTzqk8aOds5WvzRzVOdbMjPfZlLlBe2gTsjsk+MATK
        ACQXBGKpBP1h+FihrrIcFZodPf2lrOBgYgo+DCKDnA==
X-Google-Smtp-Source: AKy350actSNnT6e93iHgTrx0Vja6yD+v0IpO6wl0Ni78WTU1W219O6AN8+gIvl1SxBUbyF7I8B0MV16oNMLAmDSuSxU=
X-Received: by 2002:a67:cc15:0:b0:426:3a3d:180b with SMTP id
 q21-20020a67cc15000000b004263a3d180bmr4239462vsl.5.1680682157955; Wed, 05 Apr
 2023 01:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230331080411.981038-1-davidgow@google.com> <20230331080411.981038-2-davidgow@google.com>
 <20230404133231.ingzo7xy7lejpqqb@houat> <4d9b16aa28d4eb6c9d5a158e112abfedbfa2cd4b.camel@sipsolutions.net>
In-Reply-To: <4d9b16aa28d4eb6c9d5a158e112abfedbfa2cd4b.camel@sipsolutions.net>
From:   David Gow <davidgow@google.com>
Date:   Wed, 5 Apr 2023 16:09:05 +0800
Message-ID: <CABVgOSmPpN+OsbamVRx4Nfpqy=6D2kVgF_66A7B37_q=qLLB5A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] kunit: Add kunit_add_action() to defer a call
 until test exit
To:     Benjamin Berg <benjamin@sipsolutions.net>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
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
        boundary="000000000000081a8505f8924fc6"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--000000000000081a8505f8924fc6
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Apr 2023 at 01:55, Benjamin Berg <benjamin@sipsolutions.net> wrote:
>
> Hi,
>
> On Tue, 2023-04-04 at 15:32 +0200, Maxime Ripard wrote:
> > [SNIP]
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
> > Do we expect any other context than GFP_KERNEL?
> >
> > If so, then maybe we can have kunit_add_action() assume GFP_KERNEL and
> > add a variant for the odd case where we would actually need a different
> > GFP flag.
>
> Does anything other than GFP_KERNEL make sense? I would assume these
> functions should only ever be called from a kunit context, i.e. the
> passed test is guaranteed to be identical to the value returned by
> kunit_get_current_test().

That's not strictly-speaking guaranteed. (Indeed, we have some, albeit
contrived, counterexamples in the test.)

The theoretical use-case here is if the kunit context pointer is
passed to another thread or workqueue or something.

There aren't any such users, yet (apart from, possibly,
kunit_kmalloc_array()), though. So we could use GFP_KERNEL by default
for now, and add a variant if such a use-case appears.

>
> That said, I am happy with merging this in this form. I feel the right
> thing here is a patch (with corresponding spatch) that changes all of
> the related APIs to remove the gfp argument.
>
> > > +/**
> > > + * kunit_remove_action_token() - Cancel a deferred action.
> > > + * @test: Test case the action is associated with.
> > > + * @cancel_token: The cancellation token returned by kunit_add_action()
> > > + *
> > > + * Prevent an action deferred using kunit_add_action() from executing when the
> > > + * test ends.
> > > + *
> > > + * You can also use the (test, function, context) triplet to remove an action
> > > + * with kunit_remove_action().
> > > + */
> > > +void kunit_remove_action_token(struct kunit *test, struct kunit_action_ctx *cancel_token);
> >
> > It's not clear to me why we still need the token. If
> > kunit_remove_action() works fine, why would we need to store the token?
> >
> > Can't we just make kunit_add_action() return an int to indicate whether
> > it failed or not, and that's it?
> >
> > > [SNIP]
> >
> > One thing worth pointing is that if kunit_add_action() fails, the
> > cleanup function passed as an argument won't run.
> >
> > So, if the kzalloc call ever fails, patch 2 will leak its res->data()
> > resource for example.
> >
> > devm (and drmm) handles this using a variant called
> > devm_add_action_or_reset, we should either provide the same variant or
> > just go for that behavior by default.
>
> Both version of the function would need a return value. An alternative
> might be to make assertions part of the API. But as with dropping the
> gfp argument, that seems like a more intrusive change that needs to
> happen independently.
>
> Anyway, I am fine with action_or_reset as the default and possibly the
> only behaviour. I expect that every API user will want an assertion
> that checks for failure here anyway.
>

I'm tempted to just have both kunit_add_action() and
kunit_add_action_or_reset(), just to keep things matching the devm_
API to minimise any confusion.

And if we're not too worried about proliferating variants of these
(and, personally, I quite like them), we could have a
kunit_add_action_or_asserrt() version as well.

> Benjamin
>
>
> If kunit_* functions can assert in error conditions, then the example
>
> void test_func(struct kunit *test)
> {
>   char u8 *buf = kunit_kzalloc(test, 1024, GFP_KERNEL);
>   struct sk_buff *skb_a;
>   struct sk_buff *skb_b;
>   /* Further variables */
>
>   KUNIT_ASSERT_NOT_NULL(test, buf);
>
>   skb_a = skb_alloc(1024, GFP_KERNEL);
>   KUNIT_ASSERT_NOT_NULL(test, skb_a);
>   if (kunit_add_cleanup(test, (kunit_defer_function_t) kfree_skb, skb_a))
>     KUNIT_ASSERT_FAILURE("Failed to add cleanup");
>
>   /* Or, maybe: */
>   skb_b = skb_alloc(1024, GFP_KERNEL);
>   KUNIT_ASSERT_NOT_NULL(test, skb_b);
>   KUNIT_ASSERT_EQ(test, 0,
>                   kunit_add_cleanup(test,
>                                     (kunit_defer_function_t) kfree_skb,
>                                     skb_b));
>
>   /* run code that may assert */
> }
>
>
> could be shortened to (with a trivial kunit_skb_alloc helper)
>
> void test_func(struct kunit *test)
> {
>   char u8 *buf = kunit_kzalloc(test, 1024, GFP_KERNEL);
>   struct sk_buff *skb_a = kunit_skb_alloc(1024, GFP_KERNEL);
>   struct sk_buff *skb_b = kunit_skb_alloc(1024, GFP_KERNEL);
>   /* Further variables */
>
>   /* run code that may assert */
> }
>
> I should just post a patch for the existing API and see what people say
> then ...

We definitely already have some functions (e.g.
__kunit_activate_static_stub()) which just assert on failure. In
general, we've avoided doing so where we think there might be a good
reason to handle failures separately (or it makes the API diverge a
lot from a function we're imitating), but I'm open to using them more.
Specialised handling of allocation failures in a test is likely to be
rare enough that making those who need it write their own helpers
wouldn't be a disaster. Or we could have an _or_assert() variant.

In any case, I think your example pretty comfortably speaks for itself.

Cheers,
-- David

--000000000000081a8505f8924fc6
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
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCC4
cUpA9W4j7iP/RefVomm4baE6s0SPnLxrmcv6JOZ+tzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA0MDUwODA5MThaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAFdn5fMs0gGYQ8ePnSWua
SNDJlaF5wIQUBLz7wfrJJKt9HDSWD56SmgN4NqpHakdY/mFsoWbUyioZA6lSsEOv62ocf+yToSlu
9aVhmPqpX6Ekq3W0anKqT6rmtECNseRrRHL5Qvsmt/8SNRnCIuuIeVK2FStBghIs/wN4QG/fEt7t
6s6+af4Rd4tMfXMBILwh3bMl6vuXDWeqN6N2InD91hM73qQLFBFdMrq+/DzqUV57XnHvQnf7vkmg
0uZs4uSTF4N3mxRfr5Jk4KVhxes51kFezHaJ9ULpsO8hHUF7CyWWuTs85VK2KYYmxRIqni2M6a3j
u35RCBCGg1kaKGPESQ==
--000000000000081a8505f8924fc6--
