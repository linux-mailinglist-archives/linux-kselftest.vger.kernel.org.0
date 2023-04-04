Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F896D62D7
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Apr 2023 15:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbjDDNcm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Apr 2023 09:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjDDNcl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Apr 2023 09:32:41 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2280A35B3;
        Tue,  4 Apr 2023 06:32:39 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id B36982B066D4;
        Tue,  4 Apr 2023 09:32:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 04 Apr 2023 09:32:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1680615154; x=1680622354; bh=9H
        9NZ3OPXzLqOcbWAakrD7TSSUiFi1BK/ui51msM55I=; b=t8A7ZCT9MnTZTF9EyM
        8IJC1QbKLrf3GgWZclAPy11KIi6dSc1jz6owN1QSwQivm7Njt0J8cFr264/5KMOm
        fRXRxQq/3TPRjjLkmUoWrv2aB3mTTf9inNZhtEFm8jT0toduw3SgkUabDq1XqzmO
        HTeScomjxFdjSlalP3LaVaWuwXuihadwh+IFdFhtF56BmX/glr4TX6oMw6xLVFfS
        50ee1MXRXr9gZgi0aEAjNhshxDmKzkGi+dg9dsbumovWwyFBCKdG3Mx9PL6nHJrL
        aYsZ2EW0lP7uyNGcC5hzvGl3hjuqFx8NN5vb0X1jxg6neV9QiBID4VJ/EHa77WnZ
        qyBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680615154; x=1680622354; bh=9H9NZ3OPXzLqO
        cbWAakrD7TSSUiFi1BK/ui51msM55I=; b=Kw+2pi0NaYFQw58RHaE2QjpOX98ln
        tEtaPQhTLGDwJP382A1VBiNFcXw2Lc20kxzhdnGDxVxr4f7OnS8s/DEt8NL9Sr8m
        3FWNAoQ41+vxFzfZhYnpBt4X0OGVABPx8rquO/7Tw9+yAxsCR3Xr0NPGDFWv72TZ
        dDu8p7bjojNTfMui489LF1HXACv9mRSdGPQHp6xjFTRE0IenwAj0vzUVNKmHvQv8
        M95erHczyF8M8GcXd2k4hunPvfpUYMX/44pvtlTi05tquE9l/7UxRvn7m0QufoCU
        mcMxMaXSpowUiKsW3IAf3L+X6h0Tv035m3LdedYRPu8bhhsYDPnrI3/bw==
X-ME-Sender: <xms:8SYsZAaZ2ONeP1p1oyWjtmJvPJFwDjLU5BqEALZf-TnKkS96YKPi6Q>
    <xme:8SYsZLanMiq86Gxwm3A7Fy3tYQk2byfe4zt_bbIn8kaSwscTu4DQdxNRB-zkvNjA-
    t75eDSVJwQ6PzzrQus>
X-ME-Received: <xmr:8SYsZK9EZ-EZIFso5yK6E7pCuZDlGP1jzl7t1KMfu1Q1ESWGeHBuJQoJksEYMlYP9urPh-qA31-7tn3bBSJzyqZoOGWVgG4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiledgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedtleekjeeiudefvdfhieffteelhfeivdeliefgieeugffhvdelieffjeei
    geetjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggt
    hh
X-ME-Proxy: <xmx:8SYsZKrk5BipJdur3G3nZXs890wEraftx1a9vr3R4cWruK7IV-zo1w>
    <xmx:8SYsZLrc4bNaMyA2N1WQ7aP9Q0FvLoDIXTWuOPPZf8BqviyxjJAxGw>
    <xmx:8SYsZISz2MtOTDaeRdRNbzL_32iFSbU1a8CBc-gcPhOup4LHwhu6jA>
    <xmx:8iYsZOXmVCtRf39qKVcVYkoZXitdNnJ4X9G-xeH4IALnt-5vKmg1szUKU0w>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Apr 2023 09:32:33 -0400 (EDT)
Date:   Tue, 4 Apr 2023 15:32:31 +0200
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
Message-ID: <20230404133231.ingzo7xy7lejpqqb@houat>
References: <20230331080411.981038-1-davidgow@google.com>
 <20230331080411.981038-2-davidgow@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7dihak5kgoqjm4ua"
Content-Disposition: inline
In-Reply-To: <20230331080411.981038-2-davidgow@google.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--7dihak5kgoqjm4ua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi David,

Looks great, thanks for sending a second version

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

Do we expect any other context than GFP_KERNEL?

If so, then maybe we can have kunit_add_action() assume GFP_KERNEL and
add a variant for the odd case where we would actually need a different
GFP flag.

> +/**
> + * kunit_remove_action_token() - Cancel a deferred action.
> + * @test: Test case the action is associated with.
> + * @cancel_token: The cancellation token returned by kunit_add_action()
> + *
> + * Prevent an action deferred using kunit_add_action() from executing wh=
en the
> + * test ends.
> + *
> + * You can also use the (test, function, context) triplet to remove an a=
ction
> + * with kunit_remove_action().
> + */
> +void kunit_remove_action_token(struct kunit *test, struct kunit_action_c=
tx *cancel_token);

It's not clear to me why we still need the token. If
kunit_remove_action() works fine, why would we need to store the token?

Can't we just make kunit_add_action() return an int to indicate whether
it failed or not, and that's it?

> +/**
> + * kunit_release_action_token() - Trigger a deferred action immediately.
> + * @test: Test case the action is associated with.
> + * @cancel_token: The cancellation token returned by kunit_add_action()
> + *
> + * Execute an action immediately, instead of waiting for the test to end.
> + *
> + * You can also use the (test, function, context) triplet to trigger an =
action
> + * with kunit_release_action().
> + */
> +void kunit_release_action_token(struct kunit *test, struct kunit_action_=
ctx *cancel_token);
> +
> +/**
> + * kunit_remove_action() - Cancel a matching deferred action.
> + * @test: Test case the action is associated with.
> + * @func: The deferred function to cancel.
> + * @ctx: The context passed to the deferred function to trigger.
> + *
> + * Prevent an action deferred via kunit_add_action() from executing when=
 the
> + * test terminates..
> + * Unlike kunit_remove_action_token(), this takes the (func, ctx) pair i=
nstead of
> + * the cancellation token. If that function/context pair was deferred mu=
ltiple
> + * times, only the most recent one will be cancelled.
> + */
> +void kunit_remove_action(struct kunit *test,
> +			 kunit_defer_function_t func,
> +			 void *ctx);
> +
> +/**
> + * kunit_release_action() - Run a matching action call immediately.
> + * @test: Test case the action is associated with.
> + * @func: The deferred function to trigger.
> + * @ctx: The context passed to the deferred function to trigger.
> + *
> + * Execute a function deferred via kunit_add_action()) immediately, rath=
er than
> + * when the test ends.
> + * Unlike kunit_release_action_token(), this takes the (func, ctx) pair =
instead of
> + * the cancellation token. If that function/context pair was deferred mu=
ltiple
> + * times, it will only be executed once here. The most recent deferral w=
ill
> + * no longer execute when the test ends.
> + *
> + * kunit_release_action(test, func, ctx);
> + * is equivalent to
> + * func(ctx);
> + * kunit_remove_action(test, func, ctx);
> + */
> +void kunit_release_action(struct kunit *test,
> +			  kunit_defer_function_t func,
> +			  void *ctx);
>  #endif /* _KUNIT_RESOURCE_H */
> diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
> index b63595d3e241..eaca1b133922 100644
> --- a/lib/kunit/kunit-test.c
> +++ b/lib/kunit/kunit-test.c
> @@ -111,7 +111,7 @@ struct kunit_test_resource_context {
>  	struct kunit test;
>  	bool is_resource_initialized;
>  	int allocate_order[2];
> -	int free_order[2];
> +	int free_order[4];
>  };
> =20
>  static int fake_resource_init(struct kunit_resource *res, void *context)
> @@ -402,6 +402,123 @@ static void kunit_resource_test_named(struct kunit =
*test)
>  	KUNIT_EXPECT_TRUE(test, list_empty(&test->resources));
>  }
> =20
> +static void increment_int(void *ctx)
> +{
> +	int *i =3D (int *)ctx;
> +	(*i)++;
> +}
> +
> +static void kunit_resource_test_action(struct kunit *test)
> +{
> +	int num_actions =3D 0;
> +
> +	kunit_add_action(test, increment_int, &num_actions, GFP_KERNEL);
> +	KUNIT_EXPECT_EQ(test, num_actions, 0);
> +	kunit_cleanup(test);
> +	KUNIT_EXPECT_EQ(test, num_actions, 1);
> +
> +	/* Once we've cleaned up, the action queue is empty. */
> +	kunit_cleanup(test);
> +	KUNIT_EXPECT_EQ(test, num_actions, 1);
> +
> +	/* Check the same function can be deferred multiple times. */
> +	kunit_add_action(test, increment_int, &num_actions, GFP_KERNEL);
> +	kunit_add_action(test, increment_int, &num_actions, GFP_KERNEL);
> +	kunit_cleanup(test);
> +	KUNIT_EXPECT_EQ(test, num_actions, 3);
> +}
> +static void kunit_resource_test_remove_action(struct kunit *test)
> +{
> +	int num_actions =3D 0;
> +	struct kunit_action_ctx *cancel_token;
> +	struct kunit_action_ctx *cancel_token2;
> +
> +	cancel_token =3D kunit_add_action(test, increment_int, &num_actions, GF=
P_KERNEL);
> +	KUNIT_EXPECT_EQ(test, num_actions, 0);
> +
> +	kunit_remove_action_token(test, cancel_token);
> +	kunit_cleanup(test);
> +	KUNIT_EXPECT_EQ(test, num_actions, 0);
> +
> +	/* Check calls from the same function/context pair can be cancelled ind=
ependently*/
> +	cancel_token =3D kunit_add_action(test, increment_int, &num_actions, GF=
P_KERNEL);
> +	cancel_token2 =3D kunit_add_action(test, increment_int, &num_actions, G=
FP_KERNEL);
> +	kunit_remove_action_token(test, cancel_token);
> +	kunit_cleanup(test);
> +	KUNIT_EXPECT_EQ(test, num_actions, 1);
> +
> +	/* Also check that we can cancel just one of the identical function/con=
text pairs. */
> +	cancel_token =3D kunit_add_action(test, increment_int, &num_actions, GF=
P_KERNEL);
> +	cancel_token2 =3D kunit_add_action(test, increment_int, &num_actions, G=
FP_KERNEL);
> +	kunit_remove_action(test, increment_int, &num_actions);
> +	kunit_cleanup(test);
> +	KUNIT_EXPECT_EQ(test, num_actions, 2);
> +}
> +static void kunit_resource_test_release_action(struct kunit *test)
> +{
> +	int num_actions =3D 0;
> +	struct kunit_action_ctx *cancel_token;
> +	struct kunit_action_ctx *cancel_token2;
> +
> +	cancel_token =3D kunit_add_action(test, increment_int, &num_actions, GF=
P_KERNEL);
> +	KUNIT_EXPECT_EQ(test, num_actions, 0);
> +	/* Runs immediately on trigger. */
> +	kunit_release_action_token(test, cancel_token);
> +	KUNIT_EXPECT_EQ(test, num_actions, 1);
> +
> +	/* Doesn't run again on test exit. */
> +	kunit_cleanup(test);
> +	KUNIT_EXPECT_EQ(test, num_actions, 1);
> +
> +	/* Check calls from the same function/context pair can be triggered ind=
ependently*/
> +	cancel_token =3D kunit_add_action(test, increment_int, &num_actions, GF=
P_KERNEL);
> +	cancel_token2 =3D kunit_add_action(test, increment_int, &num_actions, G=
FP_KERNEL);
> +	kunit_release_action_token(test, cancel_token);
> +	KUNIT_EXPECT_EQ(test, num_actions, 2);
> +	kunit_cleanup(test);
> +	KUNIT_EXPECT_EQ(test, num_actions, 3);
> +
> +	/* Also check that we can trigger just one of the identical function/co=
ntext pairs. */
> +	kunit_add_action(test, increment_int, &num_actions, GFP_KERNEL);
> +	kunit_add_action(test, increment_int, &num_actions, GFP_KERNEL);
> +	kunit_release_action(test, increment_int, &num_actions);
> +	KUNIT_EXPECT_EQ(test, num_actions, 4);
> +	kunit_cleanup(test);
> +	KUNIT_EXPECT_EQ(test, num_actions, 5);
> +}
> +static void action_order_1(void *ctx)
> +{
> +	struct kunit_test_resource_context *res_ctx =3D (struct kunit_test_reso=
urce_context *)ctx;
> +
> +	KUNIT_RESOURCE_TEST_MARK_ORDER(res_ctx, free_order, 1);
> +	kunit_log(KERN_INFO, current->kunit_test, "action_order_1");
> +}
> +static void action_order_2(void *ctx)
> +{
> +	struct kunit_test_resource_context *res_ctx =3D (struct kunit_test_reso=
urce_context *)ctx;
> +
> +	KUNIT_RESOURCE_TEST_MARK_ORDER(res_ctx, free_order, 2);
> +	kunit_log(KERN_INFO, current->kunit_test, "action_order_2");
> +}
> +static void kunit_resource_test_action_ordering(struct kunit *test)
> +{
> +	struct kunit_test_resource_context *ctx =3D test->priv;
> +	struct kunit_action_ctx *cancel_token;
> +
> +	kunit_add_action(test, action_order_1, ctx, GFP_KERNEL);
> +	cancel_token =3D kunit_add_action(test, action_order_2, ctx, GFP_KERNEL=
);
> +	kunit_add_action(test, action_order_1, ctx, GFP_KERNEL);
> +	kunit_add_action(test, action_order_2, ctx, GFP_KERNEL);
> +	kunit_remove_action(test, action_order_1, ctx);
> +	kunit_release_action_token(test, cancel_token);
> +	kunit_cleanup(test);
> +
> +	/* [2 is triggered] [2], [(1 is cancelled)] [1] */
> +	KUNIT_EXPECT_EQ(test, ctx->free_order[0], 2);
> +	KUNIT_EXPECT_EQ(test, ctx->free_order[1], 2);
> +	KUNIT_EXPECT_EQ(test, ctx->free_order[2], 1);
> +}
> +
>  static int kunit_resource_test_init(struct kunit *test)
>  {
>  	struct kunit_test_resource_context *ctx =3D
> @@ -433,6 +550,10 @@ static struct kunit_case kunit_resource_test_cases[]=
 =3D {
>  	KUNIT_CASE(kunit_resource_test_proper_free_ordering),
>  	KUNIT_CASE(kunit_resource_test_static),
>  	KUNIT_CASE(kunit_resource_test_named),
> +	KUNIT_CASE(kunit_resource_test_action),
> +	KUNIT_CASE(kunit_resource_test_remove_action),
> +	KUNIT_CASE(kunit_resource_test_release_action),
> +	KUNIT_CASE(kunit_resource_test_action_ordering),
>  	{}
>  };
> =20
> diff --git a/lib/kunit/resource.c b/lib/kunit/resource.c
> index c414df922f34..824cf91e306d 100644
> --- a/lib/kunit/resource.c
> +++ b/lib/kunit/resource.c
> @@ -77,3 +77,102 @@ int kunit_destroy_resource(struct kunit *test, kunit_=
resource_match_t match,
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(kunit_destroy_resource);
> +
> +struct kunit_action_ctx {
> +	struct kunit_resource res;
> +	kunit_defer_function_t func;
> +	void *ctx;
> +};
> +
> +static void __kunit_action_free(struct kunit_resource *res)
> +{
> +	struct kunit_action_ctx *action_ctx =3D container_of(res, struct kunit_=
action_ctx, res);
> +
> +	action_ctx->func(action_ctx->ctx);
> +}
> +
> +struct kunit_action_ctx *kunit_add_action(struct kunit *test, kunit_defe=
r_function_t func,
> +					 void *ctx, gfp_t internal_gfp)
> +{
> +	struct kunit_action_ctx *action_ctx;
> +
> +	KUNIT_ASSERT_NOT_NULL_MSG(test, func, "Tried to action a NULL function!=
");
> +
> +	action_ctx =3D kzalloc(sizeof(*action_ctx), internal_gfp);
> +	if (!action_ctx)
> +		return NULL;
> +
> +	action_ctx->func =3D func;
> +	action_ctx->ctx =3D ctx;
> +
> +	action_ctx->res.should_kfree =3D true;
> +	/* As init is NULL, this cannot fail. */
> +	__kunit_add_resource(test, NULL, __kunit_action_free, &action_ctx->res,=
 action_ctx);
> +
> +	return action_ctx;
> +}

One thing worth pointing is that if kunit_add_action() fails, the
cleanup function passed as an argument won't run.

So, if the kzalloc call ever fails, patch 2 will leak its res->data()
resource for example.

devm (and drmm) handles this using a variant called
devm_add_action_or_reset, we should either provide the same variant or
just go for that behavior by default.

Maxime

--7dihak5kgoqjm4ua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZCwm5wAKCRDj7w1vZxhR
xYTbAQDzrBswopZExD1/mqPbm7KrjHiH3SFY3aoPRYUlODe50wEAqqjIpM1aeyDq
frSQgWcYZYKAk2uIOH09/+NKiIxi+w4=
=8kFL
-----END PGP SIGNATURE-----

--7dihak5kgoqjm4ua--
