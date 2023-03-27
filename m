Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32D46CA690
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 15:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbjC0N4R (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 09:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbjC0N4Q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 09:56:16 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F1E3C25;
        Mon, 27 Mar 2023 06:56:10 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 4E58D320034E;
        Mon, 27 Mar 2023 09:56:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 27 Mar 2023 09:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1679925366; x=1680011766; bh=HQT73unAvjM/fisNmxvsr2xKlXq84rjVLT6
        NDbZHsog=; b=OIroo5S7CwonPlMw2XW5OLfdr/Xv3LJtwlzS+QhdDZqjC0TT1S1
        dohG4xJhHByP4VgFIIHwlFfgnhdmtlKbvDUg2Hq7S4DiF7s+DHx+e2M1WX8dDnjV
        ZiwJAKHcqv5FpvOxLWKC21i6PZHmL//+FLuFEvFvHUKLicFKRlp4aOnPXW0eti7q
        LFVOHkwCnpZBFzOp6fFNfxTZ4NTAE23jq+/ExdLE5Q4yj9aDbKZAeVtbsu8iJlD7
        fGsXi5k4NCt84Kbj4wRc3Nnl2FzByVxVxTrpONLHOHty5ITL3HV4ghvGAmdVzQu6
        l9ZBmOOwuT/R/2+pVje41Hv5DrkEEV/qzTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1679925366; x=1680011766; bh=HQT73unAvjM/fisNmxvsr2xKlXq84rjVLT6
        NDbZHsog=; b=mr7mpDhP9QGafW+njvAQGQuglvXNusInBlcZTQj1HueI0gU8+3d
        iT4us/ykq0dZPlzw/dvSGfTmuPl0k9MCyK0aYj/IkDzug+4B3PPiCTzpc76NLBTK
        ALvmCAZOSU1zt/AHTrCy3IAD7O90kzUg++PrF4UzKnUNsFP5fJdmsq5mIKwJP8Sk
        19jozbm4tnljLw9CxXbirSt6IKDFgqmvyPhwIN3lt2sWbn3RtbsFxSk8Xpv/apvX
        OkPFtaKRL3zA7KN8BMAu3J6ocIB2+3FIUGPAyNo0e+/JasoEtDrOKC/e8lV93Tog
        47GIBNZ/STP1jyAjkkvApHhsY75oygc9wHw==
X-ME-Sender: <xms:dqAhZPMJQ9zb-hggCYEAcoIUsTX9YCErD5gF_IJRJqztDneVn_0Qkw>
    <xme:dqAhZJ-qdTFdvqXWHSguC-RVjphf-Ok9NS_Ab6JgAg2uDFJAgUOY8U27vViddB6L_
    U7SVsZ9ue4zAkN0poE>
X-ME-Received: <xmr:dqAhZOTXWOqlgK85bsEOxdAVUt1-cxuQbW8yaILst0kobqjR2VlNw7v0_CQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehvddgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtqhertddttddvnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnheptefgleeggfegkeekgffgleduieduffejffegveevkeejudektdduueet
    feetfefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:dqAhZDsw3pwh1Cf2t9_CjJj8UQIA4i2JULDcXEGqjo4-yP5LKe5PSw>
    <xmx:dqAhZHdPl0YArw1A7PqHnYIEh6-gUJn-CKufKCDHBY1yZCvX6ERI5A>
    <xmx:dqAhZP1bbPSF30FvcHd5ilSi-Y8VaNH64z-Fm81ptruVjFFleBR5Hw>
    <xmx:dqAhZP1ndbW_KSyh4uUPR3UuCs09gu0w5IpDg9YMubNP0WXNAcTe4Q>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Mar 2023 09:56:05 -0400 (EDT)
Date:   Mon, 27 Mar 2023 15:56:04 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     David Gow <davidgow@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Subject: Re: [RFC PATCH 1/2] kunit: resource: Add kunit_defer() functionality
Message-ID: <20230327135604.rxqlt2kjvfkf2vhb@penduick>
References: <20230325043104.3761770-1-davidgow@google.com>
 <20230325043104.3761770-2-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230325043104.3761770-2-davidgow@google.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi David,

Thanks a lot for doing this

On Sat, Mar 25, 2023 at 12:31:03PM +0800, David Gow wrote:
> Many uses of the KUnit resource system are intended to simply defer
> calling a function until the test exits (be it due to success or
> failure). The existing kunit_alloc_resource() function is often used for
> this, but was awkward to use (requiring passing NULL init functions, etc),
> and returned a resource without incrementing its reference count, which
> -- while okay for this use-case -- could cause problems in others.
>=20
> Instead, introduce a simple kunit_defer() API: a simple function
> (returning nothing, accepting a single void* argument) can be scheduled
> to be called when the test exits. Deferred functions are called in the
> opposite order to that which they were registered.
>=20
> This is implemented as a resource under the hood, so the ordering
> between resource cleanup and deferred functions is maintained.
>=20
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>  include/kunit/resource.h |  87 +++++++++++++++++++++++++++++++
>  lib/kunit/resource.c     | 110 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 197 insertions(+)
>=20
> diff --git a/include/kunit/resource.h b/include/kunit/resource.h
> index cf6fb8f2ac1b..6c4728ca9237 100644
> --- a/include/kunit/resource.h
> +++ b/include/kunit/resource.h
> @@ -387,4 +387,91 @@ static inline int kunit_destroy_named_resource(struc=
t kunit *test,
>   */
>  void kunit_remove_resource(struct kunit *test, struct kunit_resource *re=
s);
> =20
> +typedef void (*kunit_defer_function_t)(void *ctx);
> +
> +/**
> + * kunit_defer() - Defer a function call until the test ends.

devm (and drm resource management) uses devm_add_action for this, and
providing consistency across resource management API would be neat.

> + * @test: Test case to associate the deferred function with.
> + * @func: The function to run on test exit
> + * @ctx: Data passed into @func
> + * @internal_gfp: gfp to use for internal allocations, if unsure, use GF=
P_KERNEL

Do you really expect any GFP flag other than GFP_KERNEL?

> + * Defer the execution of a function until the test exits, either normal=
ly or
> + * due to a failure.  @ctx is passed as additional context. All functions
> + * registered with kunit_defer() will execute in the opposite order to t=
hat
> + * they were registered in.
> + *
> + * This is useful for cleaning up allocated memory and resources.
> + *
> + * RETURNS:
> + *   An opaque "cancellation token", or NULL on error. Pass this token to
> + *   kunit_defer_cancel() in order to cancel the deferred execution of f=
unc().
> + */

devm also gets away with this by (iirc) associating the function
pointer and context to the device. That triplet is pretty much
guaranteed to be unique across calls and thus you don't have to keep
(and pass!) a token around.

> +void *kunit_defer(struct kunit *test, kunit_defer_function_t func,
> +		  void *ctx, gfp_t internal_gfp);
> +
> +/**
> + * kunit_defer_cancel_token() - Cancel a deferred function call.
> + * @test: Test case the deferred function is associated with.
> + * @cancel_token: The cancellation token returned by kunit_defer()
> + *
> + * Prevent a function deferred using kunit_defer() from executing when t=
he
> + * test ends.
> + *
> + * Prefer using this to kunit_defer_cancel() where possible.
> + */
> +void kunit_defer_cancel_token(struct kunit *test, void *cancel_token);
> +
> +/**
> + * kunit_defer_trigger_token() - Run a deferred function call immediatel=
y.
> + * @test: Test case the deferred function is associated with.
> + * @cancel_token: The cancellation token returned by kunit_defer()
> + *
> + * Execute a deferred function call immediately, instead of waiting for =
the
> + * test to end.
> + *
> + * Prefer using this to kunit_defer_trigger() where possible.
> + */
> +void kunit_defer_trigger_token(struct kunit *test, void *cancel_token);
> +
> +/**
> + * kunit_defer_cancel() - Cancel a matching deferred function call.
> + * @test: Test case the deferred function is associated with.
> + * @func: The deferred function to cancel.
> + * @ctx: The context passed to the deferred function to trigger.
> + *
> + * Prevent a function deferred via kunit_defer() from executing at shutd=
own.
> + * Unlike kunit_defer_cancel_token(), this takes the (func, ctx) pair in=
stead of
> + * the cancellation token. If that function/context pair was deferred mu=
ltiple
> + * times, only the most recent one will be cancelled.
> + *
> + * Prefer using kunit_defer_cancel_token() to this where possible.
> + */
> +void kunit_defer_cancel(struct kunit *test,
> +			kunit_defer_function_t func,
> +			void *ctx);
> +
> +/**
> + * kunit_defer_trigger() - Run a matching deferred function call immedia=
tely.
> + * @test: Test case the deferred function is associated with.
> + * @func: The deferred function to trigger.
> + * @ctx: The context passed to the deferred function to trigger.
> + *
> + * Execute a function deferred via kunit_defer() immediately, rather tha=
n when
> + * the test ends.
> + * Unlike kunit_defer_trigger_token(), this takes the (func, ctx) pair i=
nstead of
> + * the cancellation token. If that function/context pair was deferred mu=
ltiple
> + * times, it will only be executed once here. The most recent deferral w=
ill
> + * no longer execute when the test ends.
> + *
> + * kunit_defer_trigger(test, func, ctx);
> + * is equivalent to
> + * func(ctx);
> + * kunit_defer_cancel(test, func, ctx);
> + *
> + * Prefer using kunit_defer_trigger_token() to this where possible.
> + */
> +void kunit_defer_trigger(struct kunit *test,
> +			 kunit_defer_function_t func,
> +			 void *ctx);
>  #endif /* _KUNIT_RESOURCE_H */

I think I agree with Matti here, you might want some function to
cancel an action/deferral but it's not clear to me why you would need
all the other functions there (for now at least)

Maxime
