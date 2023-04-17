Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7C36E4612
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Apr 2023 13:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjDQLKW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Apr 2023 07:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjDQLKU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Apr 2023 07:10:20 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6FB268F;
        Mon, 17 Apr 2023 04:09:17 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 46059582221;
        Mon, 17 Apr 2023 07:07:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 17 Apr 2023 07:07:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1681729660; x=1681736860; bh=bT
        tthA6VPXAxkFfxNa3/wjFZM4+tTAxqmF+b3PB+Glg=; b=hTIIrpcTTKkYsjZtiA
        fy/r45LsFjqK/L9BmkNWnqHS4+DxuAAHNkBtr8BvgoNvK23Gq9Ie0j/OM6Q/834h
        gf/Y5SqjLrWnHy+tgu9OWVdgWQLhgAefsDrGyto8fWA3afdcFa0eUvFXNU14ySqq
        VmZTgZif/+MqRDXjmTnMmieRLwe8tbugXSi7zVrwTdSEIH4xDGLY6JnQfMPUtKvv
        HNDvg8LBiryLPFAkD94CeSvX46dYN3OzdFIyfeFb4MaPOanwLOHUD7mrAl+yztHm
        ft8JRNq/dFbhm3HnAGjoi/i+A9OgFIhWfB9J1sZipqG5PTh6q6pNbZjza73bq3HK
        lr+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681729660; x=1681736860; bh=bTtthA6VPXAxk
        FfxNa3/wjFZM4+tTAxqmF+b3PB+Glg=; b=Ev3LPsCN9ACOrvriKQJqNDyYXMGeY
        yjwABcqyEcSqdXHV4QtT0wAATotgfFmBKqx2+J6PXbsw//J6IpXcLzsVlBUcf1fu
        VAhM0mpE9WeJJ6rlCBqZAn0U1HzE1eEeyaZzyVAhpX2n4Q4+bLmFfx1dm0rLCL7g
        PaWdggW40AOH7hJ3tx/wZhIGUQqeNM//UcBw6BKfT/VP7Ic82MJAcxs18DcPtVce
        t83ZDpbrVocffRAkBuaAVWbmPg3wAhaJ4vcm2k2PEfFJrbj8MlUoMWXQOPgUfFDC
        X0Fdn0wdJKWrhkqkg5VaNWbOkuce/TCs9H0ZddtmrhBHC3hXQmlTTf6JQ==
X-ME-Sender: <xms:eyg9ZEUfC7UVhyEYgIiG7aFMMQeMgiTjyU034P1mrKEH2SIy-VeEHQ>
    <xme:eyg9ZIlqZgXLqth13k-bd7saG3UGdyTldNsU9D6kV-WVbse7p4zVka6hv46wkvVaa
    POmPT3IRAISpLavRXY>
X-ME-Received: <xmr:eyg9ZIbK_kvjAVDewXjyFhlCGF4YviudNKPCjEA7eCtFZZCp5sMQLwHBuwHgecAkVxZU4e1aDqjAvq-4c8scPo2iG__ciuo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeliedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtsfertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedtgfdukeeigeeuhfelheeftdfhgfegfefgudeuiefhueeuleekveetvdei
    tddvieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggt
    hh
X-ME-Proxy: <xmx:eyg9ZDUL3HFcDHjyrKYRinf1AOzwtE_XHxmznZuZN8LNUuJlfVCKgg>
    <xmx:eyg9ZOkn4rPRnN6x7E8-IFkI_HToNwNOA7Kz7hAGEkm1n7WxTkwdFQ>
    <xmx:eyg9ZIfw2CA3vuQtn38C2PMca11goBf_zEbDqtWFr2n5XH9zbYpwKA>
    <xmx:fCg9ZKxCiuyeDWrx6yuRYrdGpe19i8f2ZSDCEtqT7RlubNqzVcskxw>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Apr 2023 07:07:38 -0400 (EDT)
Date:   Mon, 17 Apr 2023 13:07:36 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     David Gow <davidgow@google.com>
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
Subject: Re: [RFC PATCH v2 1/3] kunit: Add kunit_add_action() to defer a call
 until test exit
Message-ID: <rsmo6fiwagtrbev2o556rpp747s67ymz3s564chm2q3h73qf3f@e5s3x3wtzfqf>
References: <20230331080411.981038-1-davidgow@google.com>
 <20230331080411.981038-2-davidgow@google.com>
 <56w47e5mff74b4jrpgl4odhjxzayoptb6u2e2u6haaf7tuvl4f@xwlmne7p6kli>
 <CABVgOSmjs0wLUa4=ErkB9tH8p6A1P6N33befv63whF+hECRExQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="36nq5iptcuyvnvqr"
Content-Disposition: inline
In-Reply-To: <CABVgOSmjs0wLUa4=ErkB9tH8p6A1P6N33befv63whF+hECRExQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--36nq5iptcuyvnvqr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi David,

On Sat, Apr 15, 2023 at 04:42:27PM +0800, David Gow wrote:
> On Fri, 14 Apr 2023 at 18:02, <maxime@cerno.tech> wrote:
> >
> > Hi David,
> >
> > On Fri, Mar 31, 2023 at 04:04:09PM +0800, David Gow wrote:
> > > Many uses of the KUnit resource system are intended to simply defer
> > > calling a function until the test exits (be it due to success or
> > > failure). The existing kunit_alloc_resource() function is often used =
for
> > > this, but was awkward to use (requiring passing NULL init functions, =
etc),
> > > and returned a resource without incrementing its reference count, whi=
ch
> > > -- while okay for this use-case -- could cause problems in others.
> > >
> > > Instead, introduce a simple kunit_add_action() API: a simple function
> > > (returning nothing, accepting a single void* argument) can be schedul=
ed
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
> > > https://lore.kernel.org/linux-kselftest/20230325043104.3761770-2-davi=
dgow@google.com/
> > > - Rename functions to better match the devm_* APIs. (Thanks Maxime)
> > > - Embed the kunit_resource in struct kunit_action_ctx to avoid an ext=
ra
> > >   allocation (Thanks Benjamin)
> > > - Use 'struct kunit_action_ctx' as the type for cancellation tokens
> > >   (Thanks Benjamin)
> > > - Add tests.
> > >
> > > ---
> > >  include/kunit/resource.h |  89 ++++++++++++++++++++++++++++
> > >  lib/kunit/kunit-test.c   | 123 +++++++++++++++++++++++++++++++++++++=
+-
> > >  lib/kunit/resource.c     |  99 +++++++++++++++++++++++++++++++
> > >  3 files changed, 310 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/kunit/resource.h b/include/kunit/resource.h
> > > index c0d88b318e90..15efd8924666 100644
> > > --- a/include/kunit/resource.h
> > > +++ b/include/kunit/resource.h
> > > @@ -387,4 +387,93 @@ static inline int kunit_destroy_named_resource(s=
truct kunit *test,
> > >   */
> > >  void kunit_remove_resource(struct kunit *test, struct kunit_resource=
 *res);
> > >
> > > +typedef void (*kunit_defer_function_t)(void *ctx);
> > > +
> > > +/* An opaque token to a deferred action. */
> > > +struct kunit_action_ctx;
> > > +
> > > +/**
> > > + * kunit_add_action() - Defer an 'action' (function call) until the =
test ends.
> > > + * @test: Test case to associate the action with.
> > > + * @func: The function to run on test exit
> > > + * @ctx: Data passed into @func
> > > + * @internal_gfp: gfp to use for internal allocations, if unsure, us=
e GFP_KERNEL
> > > + *
> > > + * Defer the execution of a function until the test exits, either no=
rmally or
> > > + * due to a failure.  @ctx is passed as additional context. All func=
tions
> > > + * registered with kunit_add_action() will execute in the opposite o=
rder to that
> > > + * they were registered in.
> > > + *
> > > + * This is useful for cleaning up allocated memory and resources.
> > > + *
> > > + * Returns:
> > > + *   An opaque "cancellation token", or NULL on error. Pass this tok=
en to
> > > + *   kunit_remove_action_token() in order to cancel the deferred exe=
cution of
> > > + *   func().
> > > + */
> > > +struct kunit_action_ctx *kunit_add_action(struct kunit *test, kunit_=
defer_function_t func,
> > > +                   void *ctx, gfp_t internal_gfp);
> >
> > I've tried to leverage kunit_add_action() today, and I'm wondering if
> > passing the struct kunit pointer to the deferred function would help.
> >
>=20
> I'm tempted, but it does make the case where we just want to cast,
> e.g., kfree() directly to an action pointer more difficult. Not that
> that's a deal-blocker, but it was convenient...
>=20
> > The code I'm struggling with is something like:
> >
> > > static int test_init(struct kunit *test)
> > > {
> > >       priv =3D kunit_kzalloc(sizeof(*priv), GFP_KERNEL);
> > >       KUNIT_ASSERT_NOT_NULL(test, priv);
> > >       test->priv =3D priv;
> > >
> > >       priv->dev =3D alloc_device();
> > >
> > >       return 0;
> > > }
> >
> > and then in the test itself:
> >
> > > static void actual_test(struct kunit *test)
> > > {
> > >       struct test_priv *priv =3D test->priv;
> > >
> > >       id =3D allocate_buffer(priv->dev);
> > >
> > >       KUNIT_EXPECT_EQ(test, id, 42);
> > >
> > >       free_buffer(priv->dev, id);
> > > }
> >
> > I'd like to turn free_buffer an action registered right after allocate
> > buffer. However, since it takes several arguments and kunit_add_action
> > expects a single pointer, we would need to create a structure for it,
> > allocate it, fill it, and then free it when the action has ran.
>=20
> The general case of wanting multiple arguments to an action is a bit
> complicated. My plan was to initially support just the one argument,
> and deal with more complicated cases later. Ideas included:
> - using a struct like you suggest, possibly with some macro magic to
> make it easier,
> - having a bunch of very similar implementations of
> kunit_add_action{2,3,4,..}(), which accept 2,3,4,... arguments,
> - something horrible and architecture-specific with manually writing
> out arguments to the stack (or registers)
>=20
> None of those sounded particularly pleasant, though. My suspicion is
> that the "right" way of doing this is to maybe have one or two helpers
> for common cases (e.g., 2 arguments), and just suggest people create a
> structure for anything more complicated, but I'd love a nicer
> solution.
>=20
> >
> > It creates a lot of boilerplate, while if we were passing the pointer to
> > struct kunit we could access the context of the test as well, and things
> > would be much simpler.
>=20
> For the test context specifically, can you just use kunit_get_current_tes=
t()?

I wasn't aware that it was a solution, but it looks like a good compromise =
:)

Maxime

--36nq5iptcuyvnvqr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZD0oeAAKCRDj7w1vZxhR
xetdAQD6BdDGcA8CaNrjEeewx2GnU7b8aAKRN2mT+UmW5XxKVAD/VAz2yzSt8dtO
A2kxfYeUuivVfGIiT/qbriZ/YJDyewo=
=VPwF
-----END PGP SIGNATURE-----

--36nq5iptcuyvnvqr--
