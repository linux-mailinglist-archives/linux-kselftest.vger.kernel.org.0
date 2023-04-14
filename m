Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9476E2245
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 13:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjDNLeL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 07:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjDNLeK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 07:34:10 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121896E9D;
        Fri, 14 Apr 2023 04:34:08 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 093242B067BD;
        Fri, 14 Apr 2023 07:34:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 14 Apr 2023 07:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1681472042; x=1681479242; bh=rM
        JCikyOsY0FXxfCv3qUMYonrkpFuOtJ0ExOmE6K1kk=; b=VSEOGWs0H7Om9QbqNT
        3HKrrPhe+Sk5I+3bQ25chXd/OWYRNO20DZeS9qim0enTBg5/7PJiTzt6TCz9Harh
        /GpfAt+sggF7l8ZoS92cKuE2k/i/uTE0pAetwSrEukeIIn+Z/BoWipf7iANDwyYl
        HhFQhi1oJEGqDJGbkWNwLOV8AqZDRSua+I1SMdlnlH0CWimZI8VNBmzyDotA//Ln
        tWMM3i5vpZqwBRhdrRBFoWyRjtqn0UyxrcUMAs82fcFYpwafvy7CA0Ppkq/7Afy0
        nGL3zStwvOk/0CnH+pQxyHSELNx8jTcZy1LrbFZLO8iJfWSOYj2kMRn7GRCcz7Dc
        GuJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681472042; x=1681479242; bh=rMJCikyOsY0FX
        xfCv3qUMYonrkpFuOtJ0ExOmE6K1kk=; b=Gea4DkxO8m4i8Gd/Te2tgTrfbYu9+
        d+bCRmHGh5JfNXaUbMAEp8bswScX55ciibxDxYZgJ3k4BnWud0ICjU3HOuB2MME/
        TLllSoHX6Uar6IupyTOgdU/veAU3VoUiRnfc3yle2SlK/dn9C32OeDEl1g0X1Y+B
        Zo9YgbBha4o4OoEGVbf2onN4KLrNe3Z/BjyjnSTEhPOcJE6jqZaMKC+IwSMKeI9g
        sPjnYU8eslJw8izWJePUFTM+TlclZ9xcr5BQwz1vTc0w8359zyj/SuRiT+e7raAj
        F0yHm8FRWpgmjaLnb5W5FoQNLqd1tadbCHFWNAJoSk4nFcQ/Tq9/Y8ssQ==
X-ME-Sender: <xms:KTo5ZPzFGL-SzZ-R9t7Uc7PDsRN9z0o3ppAbAHBGL6eRO8HxCOax0A>
    <xme:KTo5ZHTQsvM8sZH3ujmIusyvRykE2GJjrOU7Kz1IydwKzjGVxDA2B0weNRzvvRPde
    Vj-q5UYZTpHQSTC5mk>
X-ME-Received: <xmr:KTo5ZJVRuyRO0BPCo2BznYZSrHlT8ojtCVirc-MAG1iCwgn0-fiPq1otb13jAH6tqEBiCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeltddggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtsfertddtudenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeefkedvjefgffdtjeetueekieekieetleehieetgfdvkedujeeufefhteeg
    heeileenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggt
    hh
X-ME-Proxy: <xmx:KTo5ZJgGTZ9fvwhIrrBH8Vc1VOsyp6OqZAZfVbFFFFS0vYec_lA6Ww>
    <xmx:KTo5ZBAjHCj1-O8mdzli1RI1yKH9ssKSBf-dbgAabxbxo5en0MCwQA>
    <xmx:KTo5ZCLqIQ_7NBNJUAdMAfWf7knC07HmQnAuaGT0iX8Z7zySWxepeg>
    <xmx:Kjo5ZCs3TfMd8HAAdUU4DATNcdF7Stf9sSHMM8cxoqX4YFmLxL0TUZIWy9c>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Apr 2023 07:34:00 -0400 (EDT)
Date:   Fri, 14 Apr 2023 13:33:56 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Benjamin Berg <benjamin@sipsolutions.net>
Cc:     David Gow <davidgow@google.com>,
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
Subject: Re: [RFC PATCH v2 1/3] kunit: Add kunit_add_action() to defer a call
 until test exit
Message-ID: <6tg5tyvl5x6bywwvjcudlexmzn5ubjqbc4hv4iz2tuw2hrjxas@4sb2l2yywr72>
References: <20230331080411.981038-1-davidgow@google.com>
 <20230331080411.981038-2-davidgow@google.com>
 <56w47e5mff74b4jrpgl4odhjxzayoptb6u2e2u6haaf7tuvl4f@xwlmne7p6kli>
 <f51a15fbc49b9119a9e5db8240facd6ab51a0d46.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dc6jf7mpwhdpexwi"
Content-Disposition: inline
In-Reply-To: <f51a15fbc49b9119a9e5db8240facd6ab51a0d46.camel@sipsolutions.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--dc6jf7mpwhdpexwi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 14, 2023 at 01:00:26PM +0200, Benjamin Berg wrote:
> Hi,
>=20
> On Fri, 2023-04-14 at 12:01 +0200, maxime@cerno.tech wrote:
> > Hi David,
> >=20
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
> > >=20
> > > Instead, introduce a simple kunit_add_action() API: a simple function
> > > (returning nothing, accepting a single void* argument) can be schedul=
ed
> > > to be called when the test exits. Deferred actions are called in the
> > > opposite order to that which they were registered.
> > >=20
> > > This mimics the devres API, devm_add_action(), and also provides
> > > kunit_remove_action(), to cancel a deferred action, and
> > > kunit_release_action() to trigger one early.
> > >=20
> > > This is implemented as a resource under the hood, so the ordering
> > > between resource cleanup and deferred functions is maintained.
> > >=20
> > > Signed-off-by: David Gow <davidgow@google.com>
> > > ---
> > >=20
> > > Changes since RFC v1:
> > > https://lore.kernel.org/linux-kselftest/20230325043104.3761770-2-davi=
dgow@google.com/
> > > - Rename functions to better match the devm_* APIs. (Thanks Maxime)
> > > - Embed the kunit_resource in struct kunit_action_ctx to avoid an ext=
ra
> > > =A0 allocation (Thanks Benjamin)
> > > - Use 'struct kunit_action_ctx' as the type for cancellation tokens
> > > =A0 (Thanks Benjamin)
> > > - Add tests.
> > >=20
> > > ---
> > > =A0include/kunit/resource.h |=A0 89 ++++++++++++++++++++++++++++
> > > =A0lib/kunit/kunit-test.c=A0=A0 | 123 +++++++++++++++++++++++++++++++=
+++++++-
> > > =A0lib/kunit/resource.c=A0=A0=A0=A0 |=A0 99 +++++++++++++++++++++++++=
++++++
> > > =A03 files changed, 310 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/include/kunit/resource.h b/include/kunit/resource.h
> > > index c0d88b318e90..15efd8924666 100644
> > > --- a/include/kunit/resource.h
> > > +++ b/include/kunit/resource.h
> > > @@ -387,4 +387,93 @@ static inline int kunit_destroy_named_resource(s=
truct kunit *test,
> > > =A0 */
> > > =A0void kunit_remove_resource(struct kunit *test, struct kunit_resour=
ce *res);
> > > =A0
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
> > > + * due to a failure.=A0 @ctx is passed as additional context. All fu=
nctions
> > > + * registered with kunit_add_action() will execute in the opposite o=
rder to that
> > > + * they were registered in.
> > > + *
> > > + * This is useful for cleaning up allocated memory and resources.
> > > + *
> > > + * Returns:
> > > + *=A0=A0 An opaque "cancellation token", or NULL on error. Pass this=
 token to
> > > + *=A0=A0 kunit_remove_action_token() in order to cancel the deferred=
 execution of
> > > + *=A0=A0 func().
> > > + */
> > > +struct kunit_action_ctx *kunit_add_action(struct kunit *test, kunit_=
defer_function_t func,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 void *c=
tx, gfp_t internal_gfp);
> >=20
> > I've tried to leverage kunit_add_action() today, and I'm wondering if
> > passing the struct kunit pointer to the deferred function would help.
> >=20
> > The code I'm struggling with is something like:
> >=20
> > > static int test_init(struct kunit *test)
> > > {
> > > =A0=A0=A0=A0=A0=A0=A0=A0priv =3D kunit_kzalloc(sizeof(*priv), GFP_KER=
NEL);
> > > =A0=A0=A0=A0=A0=A0=A0=A0KUNIT_ASSERT_NOT_NULL(test, priv);
> > > =A0=A0=A0=A0=A0=A0=A0=A0test->priv =3D priv;
> > >=20
> > > =A0=A0=A0=A0=A0=A0=A0=A0priv->dev =3D alloc_device();
> > >=20
> > > =A0=A0=A0=A0=A0=A0=A0=A0return 0;
> > > }
> >=20
> > and then in the test itself:
> >=20
> > > static void actual_test(struct kunit *test)
> > > {
> > > =A0=A0=A0=A0=A0=A0=A0=A0struct test_priv *priv =3D test->priv;
> > >=20
> > > =A0=A0=A0=A0=A0=A0=A0=A0id =3D allocate_buffer(priv->dev);
> > >=20
> > > =A0=A0=A0=A0=A0=A0=A0=A0KUNIT_EXPECT_EQ(test, id, 42);
> > >=20
> > > =A0=A0=A0=A0=A0=A0=A0=A0free_buffer(priv->dev, id);
> > > }
> >=20
> > I'd like to turn free_buffer an action registered right after allocate
> > buffer. However, since it takes several arguments and kunit_add_action
> > expects a single pointer, we would need to create a structure for it,
> > allocate it, fill it, and then free it when the action has ran.
> >=20
> > It creates a lot of boilerplate, while if we were passing the pointer to
> > struct kunit we could access the context of the test as well, and things
> > would be much simpler.
>=20
> The question seems to be what about the typical use-case. I was always
> imagining calling functions like kfree/kfree_skb which often only
> require a single argument.

I guess we can have a look at the devm stuff. I'd expect the scope of
things that will eventually tie their resource to kunit would be
similar. "Straight" allocation/deallocation functions are the obvious
first candidates, but there's a lot of other use cases as well.

I guess my main point is that it assumes that most function to clean
things up will take the resource as its only argument, which isn't
always the case. I guess it's reasonable to optimize for the most
trivial case, but we should strive to keep the boilerplate down as much
as we can in the other case too.

> For arbitrary arguments, a struct and custom free function will be
> needed. At that point, maybe it is fair to assume that API users will
> use the resource API directly, doing the same trick as kunit_add_action
> and storing the arguments together with struct kunit_resource.

kunit_add_resource adds tons of boilerplate as well:

struct test_buffer_priv {
	struct device *dev;
}

struct test_alloc_params {
	struct device *dev;
	void *buffer;
}

static int __alloc_buffer(struct kunit_resource *res, void *ptr)
{
	struct test_alloc_params *params =3D ptr;
	void *buffer;

	params->buffer =3D allocate_buffer(params->dev, params->size);
	res->data =3D params;

	return 0;
}

static void __free_buffer(struct kunit_resource *res)
{
	struct test_alloc_params *params =3D res->data;

	free_buffer(params->dev, params->buffer);
}

void actual_test(struct kunit_test *test)
{
	struct test_alloc_params *params =3D test->priv;

	kunit_alloc_resource(test, __alloc_buffer, __free_buffer, GFP_KERNEL, para=
ms);
	KUNIT_EXPECT_NOT_NULL(params->buffer);
}

int test_init(struct kunit_test *test)
{
	struct test_alloc_params *params =3D
		kunit_kmalloc(test, sizeof(*params), GFP_KERNEL);

	test->priv =3D params;

	params->dev =3D kunit_allocate_device(...);

	return 0;
}


while we could have something like:


struct test_buffer_priv {
	struct device *dev;
}

static void free_buffer_action(struct kunit *test, void *ptr)
{
	struct test_buffer_priv *priv =3D test->priv;

	free_buffer(params->dev, ptr);
}

void actual_test(struct kunit_test *test)
{
	struct test_buffer_priv *priv =3D test->priv;
	void *buffer;

	buffer =3D allocate_buffer(priv->dev, 42);
	kunit_add_action(test, free_buffer_action, buffer);

	KUNIT_EXPECT_NOT_NULL(buffer);
}

int test_init(struct kunit_test *test)
{
	struct test_buffer_priv *priv =3D
		kunit_kmalloc(test, sizeof(*priv), GFP_KERNEL);

	test->priv =3D priv;

	priv->dev =3D kunit_allocate_device(...);

	return 0;
}

Which is much more compact, more readable, and less error prone.

And sure, kfree and free_skb would need some intermediate function, but
it's like 3 more lines, which can even be shared at the framework or
kunit level, so shouldn't really impact the tests themselves.

> That said, maybe one could add it as a second argument? It is a little
> bit weird API wise, but it would allow simply casting single-argument
> functions in order to ignore "struct kunit *" argument.=20

I guess. I'd find it a bit weird to have that one function with the
argument order reversed compared to everything else though.

Maxime

--dc6jf7mpwhdpexwi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZDk6JAAKCRDj7w1vZxhR
xUG+AP9xZCRzAEfO1RtUL5owpPanTeLyceW7d6mxWZmLFwNS1wD+PTDbyR0SBZSE
ievqgeNiU7VTh/mG/C4rsIP/XqYlAg0=
=dinx
-----END PGP SIGNATURE-----

--dc6jf7mpwhdpexwi--
