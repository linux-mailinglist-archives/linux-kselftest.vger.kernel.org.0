Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DA56E2021
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 12:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjDNKCM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 06:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjDNKCG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 06:02:06 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEECB76B4;
        Fri, 14 Apr 2023 03:02:04 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 717652B06EFE;
        Fri, 14 Apr 2023 06:02:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 14 Apr 2023 06:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1681466522; x=1681473722; bh=AX
        mBOrau9y62Ep9jBep7xcrWEaTvywvjZLIPJDZWzw8=; b=CE5N4hsCc7Ea/viRSL
        F+lnjOkQlk0k83MsdAcZxkswiLmj+ON4CTfy8rNKto8zkw6FOyCVNt7YaP4qohYO
        t1GD6QXChlJ5TlWE7S8kBm1x8TDX6DWmQnADAYhF9WXNzlt5N0WtjXXsbKE65maH
        tiRY8Qvy5NbOgLUbPjA9lmRumA0VlEhlySMC7HD5N9Nx8ZcEnjCbVpbS+bwkr/e2
        tbhcPcHcL3pF0/UDYA73HoQot8sd4w9tiRspivnSl961Ic8CU46fpYWuAwSanPKL
        x2OR9Y/Ud+XHPZcsM2/y16iu6MC0RsGkUDlX9BS7X2eeUPfenpgD3ikx1t9O62JK
        GNUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681466522; x=1681473722; bh=AXmBOrau9y62E
        p9jBep7xcrWEaTvywvjZLIPJDZWzw8=; b=Ul5rPHERFuTt+CzCsMPKn39Z8amcc
        1H5mS8DL09X92kH7U+j2yFTEl8gSzgi6dp528zsuZkyXY7OLYbnbfVyiTttg7Vym
        t9oRDetMlPIdSPZD+dhJzJiHY6sN7T51UMZ+T39xkB5lZaIaUoQQraiyC9UdXLC8
        BzNm7lmcklwI7nDa/ZsTjh3Lq6XYntum+UqXySB5V9612zV+jntCB/1lnRXSH73b
        YIawuuUmh960/JXAsaqUDjwWmc4nxp6YjuLOG0kIfm0x64n68p2BoDte9egwN/Im
        L5D2Diz5PkQ0F0avFjFfxc+iPuDY8U2DArYcMFR2c0KQ9VFV1Fw+J0kmw==
X-ME-Sender: <xms:mSQ5ZJ9sGfbDvuVzBblC2zzsPHP5MjKOrhr6mqjdXZVurL7Qt_y6Dg>
    <xme:mSQ5ZNs19OxX2hlzXhDsAUmUfakZawtbcCmWUsIHNifDKaeW2lmVlGYZwQab6A38Z
    Q0TrR7AxDsejqwPm7k>
X-ME-Received: <xmr:mSQ5ZHAIotOx71Aw9jYCyv1359f8opuD8Jn8ZL7PKITU3TOY_vChRRRxBaz8zgf_duwgXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeltddgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffvfevuffkfhggtggujgesghdtsfertddtvdenucfhrhhomhepmhgrgihi
    mhgvsegtvghrnhhordhtvggthhenucggtffrrghtthgvrhhnpeegfeeuffdtuefffeegvd
    evhedvtdekkeeftdefjedufffguefgudffhfduffehteenucffohhmrghinhepkhgvrhhn
    vghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:mSQ5ZNejtdtl0F7Sxmo-hFqWXhultPBqvVc9tc6IM5WyXIxEgfb6BQ>
    <xmx:mSQ5ZOOwAXZ7YZKeEuj3IYaQBM-iqWl9Kv3PQEWtMQoZLbXjxd68fg>
    <xmx:mSQ5ZPnezi-Ry3315dLzcCygIWUrpMbhbDB21E2PDJRwSHgtKBqc3Q>
    <xmx:miQ5ZDZCwRFz0rRZCRNxGj318CIgoVJcUJ5QxtdisCSu9bGYhxHjm3IAeqw>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Apr 2023 06:02:00 -0400 (EDT)
From:   maxime@cerno.tech
Date:   Fri, 14 Apr 2023 12:01:59 +0200
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
Message-ID: <56w47e5mff74b4jrpgl4odhjxzayoptb6u2e2u6haaf7tuvl4f@xwlmne7p6kli>
11;rgb: fafa/f4f4/ededFrom: Maxime Ripard <maxime@cerno.tech>
References: <20230331080411.981038-1-davidgow@google.com>
 <20230331080411.981038-2-davidgow@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fceqsyq7p6l42qjy"
Content-Disposition: inline
In-Reply-To: <20230331080411.981038-2-davidgow@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--fceqsyq7p6l42qjy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi David,

On Fri, Mar 31, 2023 at 04:04:09PM +0800, David Gow wrote:
> Many uses of the KUnit resource system are intended to simply defer
> calling a function until the test exits (be it due to success or
> failure). The existing kunit_alloc_resource() function is often used for
> this, but was awkward to use (requiring passing NULL init functions, etc),
> and returned a resource without incrementing its reference count, which
> -- while okay for this use-case -- could cause problems in others.
>=20
> Instead, introduce a simple kunit_add_action() API: a simple function
> (returning nothing, accepting a single void* argument) can be scheduled
> to be called when the test exits. Deferred actions are called in the
> opposite order to that which they were registered.
>=20
> This mimics the devres API, devm_add_action(), and also provides
> kunit_remove_action(), to cancel a deferred action, and
> kunit_release_action() to trigger one early.
>=20
> This is implemented as a resource under the hood, so the ordering
> between resource cleanup and deferred functions is maintained.
>=20
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>=20
> Changes since RFC v1:
> https://lore.kernel.org/linux-kselftest/20230325043104.3761770-2-davidgow=
@google.com/
> - Rename functions to better match the devm_* APIs. (Thanks Maxime)
> - Embed the kunit_resource in struct kunit_action_ctx to avoid an extra
>   allocation (Thanks Benjamin)
> - Use 'struct kunit_action_ctx' as the type for cancellation tokens
>   (Thanks Benjamin)
> - Add tests.
>=20
> ---
>  include/kunit/resource.h |  89 ++++++++++++++++++++++++++++
>  lib/kunit/kunit-test.c   | 123 ++++++++++++++++++++++++++++++++++++++-
>  lib/kunit/resource.c     |  99 +++++++++++++++++++++++++++++++
>  3 files changed, 310 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/kunit/resource.h b/include/kunit/resource.h
> index c0d88b318e90..15efd8924666 100644
> --- a/include/kunit/resource.h
> +++ b/include/kunit/resource.h
> @@ -387,4 +387,93 @@ static inline int kunit_destroy_named_resource(struc=
t kunit *test,
>   */
>  void kunit_remove_resource(struct kunit *test, struct kunit_resource *re=
s);
> =20
> +typedef void (*kunit_defer_function_t)(void *ctx);
> +
> +/* An opaque token to a deferred action. */
> +struct kunit_action_ctx;
> +
> +/**
> + * kunit_add_action() - Defer an 'action' (function call) until the test=
 ends.
> + * @test: Test case to associate the action with.
> + * @func: The function to run on test exit
> + * @ctx: Data passed into @func
> + * @internal_gfp: gfp to use for internal allocations, if unsure, use GF=
P_KERNEL
> + *
> + * Defer the execution of a function until the test exits, either normal=
ly or
> + * due to a failure.  @ctx is passed as additional context. All functions
> + * registered with kunit_add_action() will execute in the opposite order=
 to that
> + * they were registered in.
> + *
> + * This is useful for cleaning up allocated memory and resources.
> + *
> + * Returns:
> + *   An opaque "cancellation token", or NULL on error. Pass this token to
> + *   kunit_remove_action_token() in order to cancel the deferred executi=
on of
> + *   func().
> + */
> +struct kunit_action_ctx *kunit_add_action(struct kunit *test, kunit_defe=
r_function_t func,
> +		      void *ctx, gfp_t internal_gfp);

I've tried to leverage kunit_add_action() today, and I'm wondering if
passing the struct kunit pointer to the deferred function would help.

The code I'm struggling with is something like:

> static int test_init(struct kunit *test)
> {
> 	priv =3D kunit_kzalloc(sizeof(*priv), GFP_KERNEL);
>	KUNIT_ASSERT_NOT_NULL(test, priv);
>	test->priv =3D priv;
>
> 	priv->dev =3D alloc_device();
>
>	return 0;
> }

and then in the test itself:

> static void actual_test(struct kunit *test)
> {
> 	struct test_priv *priv =3D test->priv;
>
>	id =3D allocate_buffer(priv->dev);
>
> 	KUNIT_EXPECT_EQ(test, id, 42);
>
> 	free_buffer(priv->dev, id);
> }

I'd like to turn free_buffer an action registered right after allocate
buffer. However, since it takes several arguments and kunit_add_action
expects a single pointer, we would need to create a structure for it,
allocate it, fill it, and then free it when the action has ran.

It creates a lot of boilerplate, while if we were passing the pointer to
struct kunit we could access the context of the test as well, and things
would be much simpler.

Does that make sense?

Maxime

--fceqsyq7p6l42qjy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZDkklwAKCRDj7w1vZxhR
xeNoAP9VMmSPcl8ZzIFWaozvx8UFXU/3lzCtRY36TKzGyxPxxAD+NLmzkbxArqsc
XrsZQswdB53bCVwGmp6eiVyTgG8Dnw4=
=ONZA
-----END PGP SIGNATURE-----

--fceqsyq7p6l42qjy--
