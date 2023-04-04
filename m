Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C756D6AFC
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Apr 2023 19:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbjDDR4C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Apr 2023 13:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235899AbjDDRz7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Apr 2023 13:55:59 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C995E49E2;
        Tue,  4 Apr 2023 10:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ONN1widH5Qtf7uAuoBh252hI4mEZ9k+7s+ZgWeKSXzM=;
        t=1680630953; x=1681840553; b=tPIWdRQr4eY1sv2hMQTIF7vRfMNImyWcyCrBXSf1bKv1xdj
        S1h9gfQinaT7X1aIBDZZHdvxTwviuKmwrkk81ErUafgsSXmmnIOT2M/kDphyKSXfPFtEpbjzWJUJb
        FownlQURVp5uEcmAF9BC8EkqGZWXVnQP7LlI56wv6hiBYar416qc0Eek5l/RegcbzFRHi3PKkPvqg
        dXgR9tsEITS186LlQDjGVfAa6/NSuNNIJEdAL+bctOLOtDdIGyqoEuR+rkoTkyH3SAV6x2QhT++K3
        HyIMutoVN9f5/zAJDeYMuOix775pYZm+4X1BH2fR8+AMJ5gcrjETB5WN/R08U6FQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1pjksW-006Bx4-12;
        Tue, 04 Apr 2023 19:55:32 +0200
Message-ID: <4d9b16aa28d4eb6c9d5a158e112abfedbfa2cd4b.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v2 1/3] kunit: Add kunit_add_action() to defer a
 call until test exit
From:   Benjamin Berg <benjamin@sipsolutions.net>
To:     Maxime Ripard <maxime@cerno.tech>, David Gow <davidgow@google.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
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
Date:   Tue, 04 Apr 2023 19:55:30 +0200
In-Reply-To: <20230404133231.ingzo7xy7lejpqqb@houat>
References: <20230331080411.981038-1-davidgow@google.com>
         <20230331080411.981038-2-davidgow@google.com>
         <20230404133231.ingzo7xy7lejpqqb@houat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On Tue, 2023-04-04 at 15:32 +0200, Maxime Ripard wrote:
> [SNIP]
> > +/**
> > + * kunit_add_action() - Defer an 'action' (function call) until the te=
st ends.
> > + * @test: Test case to associate the action with.
> > + * @func: The function to run on test exit
> > + * @ctx: Data passed into @func
> > + * @internal_gfp: gfp to use for internal allocations, if unsure, use =
GFP_KERNEL
> > + *
> > + * Defer the execution of a function until the test exits, either norm=
ally or
> > + * due to a failure.=C2=A0 @ctx is passed as additional context. All f=
unctions
> > + * registered with kunit_add_action() will execute in the opposite ord=
er to that
> > + * they were registered in.
> > + *
> > + * This is useful for cleaning up allocated memory and resources.
> > + *
> > + * Returns:
> > + *=C2=A0=C2=A0 An opaque "cancellation token", or NULL on error. Pass =
this token to
> > + *=C2=A0=C2=A0 kunit_remove_action_token() in order to cancel the defe=
rred execution of
> > + *=C2=A0=C2=A0 func().
> > + */
> > +struct kunit_action_ctx *kunit_add_action(struct kunit *test, kunit_de=
fer_function_t func,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *ctx, gfp_t intern=
al_gfp);
>=20
> Do we expect any other context than GFP_KERNEL?
>=20
> If so, then maybe we can have kunit_add_action() assume GFP_KERNEL and
> add a variant for the odd case where we would actually need a different
> GFP flag.

Does anything other than GFP_KERNEL make sense? I would assume these
functions should only ever be called from a kunit context, i.e. the
passed test is guaranteed to be identical to the value returned by
kunit_get_current_test().

That said, I am happy with merging this in this form. I feel the right
thing here is a patch (with corresponding spatch) that changes all of
the related APIs to remove the gfp argument.

> > +/**
> > + * kunit_remove_action_token() - Cancel a deferred action.
> > + * @test: Test case the action is associated with.
> > + * @cancel_token: The cancellation token returned by kunit_add_action(=
)
> > + *
> > + * Prevent an action deferred using kunit_add_action() from executing =
when the
> > + * test ends.
> > + *
> > + * You can also use the (test, function, context) triplet to remove an=
 action
> > + * with kunit_remove_action().
> > + */
> > +void kunit_remove_action_token(struct kunit *test, struct kunit_action=
_ctx *cancel_token);
>=20
> It's not clear to me why we still need the token. If
> kunit_remove_action() works fine, why would we need to store the token?
>=20
> Can't we just make kunit_add_action() return an int to indicate whether
> it failed or not, and that's it?
>=20
> > [SNIP]
>=20
> One thing worth pointing is that if kunit_add_action() fails, the
> cleanup function passed as an argument won't run.
>=20
> So, if the kzalloc call ever fails, patch 2 will leak its res->data()
> resource for example.
>=20
> devm (and drmm) handles this using a variant called
> devm_add_action_or_reset, we should either provide the same variant or
> just go for that behavior by default.

Both version of the function would need a return value. An alternative
might be to make assertions part of the API. But as with dropping the
gfp argument, that seems like a more intrusive change that needs to
happen independently.

Anyway, I am fine with action_or_reset as the default and possibly the
only behaviour. I expect that every API user will want an assertion
that checks for failure here anyway.

Benjamin


If kunit_* functions can assert in error conditions, then the example

void test_func(struct kunit *test)
{
  char u8 *buf =3D kunit_kzalloc(test, 1024, GFP_KERNEL);
  struct sk_buff *skb_a;
  struct sk_buff *skb_b;
  /* Further variables */

  KUNIT_ASSERT_NOT_NULL(test, buf);

  skb_a =3D skb_alloc(1024, GFP_KERNEL);
  KUNIT_ASSERT_NOT_NULL(test, skb_a);
  if (kunit_add_cleanup(test, (kunit_defer_function_t) kfree_skb, skb_a))
    KUNIT_ASSERT_FAILURE("Failed to add cleanup");

  /* Or, maybe: */
  skb_b =3D skb_alloc(1024, GFP_KERNEL);
  KUNIT_ASSERT_NOT_NULL(test, skb_b);
  KUNIT_ASSERT_EQ(test, 0,
                  kunit_add_cleanup(test,
                                    (kunit_defer_function_t) kfree_skb,
                                    skb_b));

  /* run code that may assert */
}


could be shortened to (with a trivial kunit_skb_alloc helper)

void test_func(struct kunit *test)
{
  char u8 *buf =3D kunit_kzalloc(test, 1024, GFP_KERNEL);
  struct sk_buff *skb_a =3D kunit_skb_alloc(1024, GFP_KERNEL);
  struct sk_buff *skb_b =3D kunit_skb_alloc(1024, GFP_KERNEL);
  /* Further variables */

  /* run code that may assert */
}

I should just post a patch for the existing API and see what people say
then ...
