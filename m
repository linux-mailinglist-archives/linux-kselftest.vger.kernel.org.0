Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3E26CFCF9
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Mar 2023 09:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjC3Hi0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Mar 2023 03:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjC3HiZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Mar 2023 03:38:25 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61AD4202;
        Thu, 30 Mar 2023 00:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=rTvHH6jePPL/V4i5M5sos/9YKzC22HNqmj31MuZkn9U=;
        t=1680161903; x=1681371503; b=pnX3eYltb0R82w05qstWFSdiUxr9FtOWO3MrGUKsMAsHFfu
        PB1lML278WI3c9DYlggOwIB1HpP8mhrLSu8zssn7yL/a/m6iH6BH//gNXW7DtCBaVjENgErxC8jL7
        bOgPdcejZrl9H/Zw4fjisKSJ6fqsS2gcf2k1mVmIT4aUqAyoBYexjItPk0cwj3A3XazhEFAk330BE
        gIYWXXpsulJ3PARzXFcGfwpCLuOpvC7Akc4LnH4sYoAD09UHHk7I/tQQipESVKFKVa355n7FMRNZl
        ZM1Ap7YDHiHjvE96ZuXVgnyecReWVsxnZSihTWY94LIIord5wZLpYkbAbGUSdR+A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1phmrO-000vTJ-1p;
        Thu, 30 Mar 2023 09:38:14 +0200
Message-ID: <bdad2aad9bb80f4534a0c812efb974060ceafc0c.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 1/2] kunit: resource: Add kunit_defer() functionality
From:   Benjamin Berg <benjamin@sipsolutions.net>
To:     David Gow <davidgow@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Date:   Thu, 30 Mar 2023 09:38:11 +0200
In-Reply-To: <20230325043104.3761770-2-davidgow@google.com>
References: <20230325043104.3761770-1-davidgow@google.com>
         <20230325043104.3761770-2-davidgow@google.com>
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

I do like having such an API for automatic cleanup.

On Sat, 2023-03-25 at 12:31 +0800, David Gow wrote:
> Many uses of the KUnit resource system are intended to simply defer
> calling a function until the test exits (be it due to success or
> failure). The existing kunit_alloc_resource() function is often used for
> this, but was awkward to use (requiring passing NULL init functions, etc)=
,
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
> =C2=A0include/kunit/resource.h |=C2=A0 87 +++++++++++++++++++++++++++++++
> =C2=A0lib/kunit/resource.c=C2=A0=C2=A0=C2=A0=C2=A0 | 110 ++++++++++++++++=
+++++++++++++++++++++++
> =C2=A02 files changed, 197 insertions(+)
>=20
> diff --git a/include/kunit/resource.h b/include/kunit/resource.h
> index cf6fb8f2ac1b..6c4728ca9237 100644
> --- a/include/kunit/resource.h
> +++ b/include/kunit/resource.h
> @@ -387,4 +387,91 @@ static inline int kunit_destroy_named_resource(struc=
t kunit *test,
> =C2=A0 */
> =C2=A0void kunit_remove_resource(struct kunit *test, struct kunit_resourc=
e *res);
> =C2=A0
> +typedef void (*kunit_defer_function_t)(void *ctx);
> +
> +/**
> + * kunit_defer() - Defer a function call until the test ends.

I separately proposed kunit_add_cleanup. Which I find quite descriptive
and it matches the name that the python unittest package uses.

> + * @test: Test case to associate the deferred function with.
> + * @func: The function to run on test exit
> + * @ctx: Data passed into @func
> + * @internal_gfp: gfp to use for internal allocations, if unsure, use GF=
P_KERNEL
> + *
> + * Defer the execution of a function until the test exits, either normal=
ly or
> + * due to a failure.=C2=A0 @ctx is passed as additional context. All fun=
ctions
> + * registered with kunit_defer() will execute in the opposite order to t=
hat
> + * they were registered in.
> + *
> + * This is useful for cleaning up allocated memory and resources.
> + *
> + * RETURNS:
> + *=C2=A0=C2=A0 An opaque "cancellation token", or NULL on error. Pass th=
is token to
> + *=C2=A0=C2=A0 kunit_defer_cancel() in order to cancel the deferred exec=
ution of func().
> + */
> +void *kunit_defer(struct kunit *test, kunit_defer_function_t func,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 void *ctx, gfp_t internal_gfp);

Maybe return struct kunit_defer_ctx* instead of void? No need to have
the structure itself be visible.

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
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kunit_def=
er_function_t func,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0void *ctx=
);
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
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kunit_de=
fer_function_t func,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *ct=
x);
> =C2=A0#endif /* _KUNIT_RESOURCE_H */
> diff --git a/lib/kunit/resource.c b/lib/kunit/resource.c
> index c414df922f34..0d0c48054d45 100644
> --- a/lib/kunit/resource.c
> +++ b/lib/kunit/resource.c
> @@ -77,3 +77,113 @@ int kunit_destroy_resource(struct kunit *test, kunit_=
resource_match_t match,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(kunit_destroy_resource);
> +
> +struct kunit_defer_ctx {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kunit_defer_function_t func;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0void *ctx;
> +};

You could avoid an allocation by embedding struct kunit_resource.

> +
> +static void __kunit_defer_free(struct kunit_resource *res)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct kunit_defer_ctx *defer_=
ctx =3D (struct kunit_defer_ctx *)res->data;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0defer_ctx->func(defer_ctx->ctx=
);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kfree(res->data);
> +}
> +
> +void *kunit_defer(struct kunit *test, kunit_defer_function_t func,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0void *ctx, gfp_t internal_gfp)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct kunit_resource *res;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct kunit_defer_ctx *defer_=
ctx;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0KUNIT_ASSERT_NOT_NULL_MSG(test=
, func, "Tried to defer a NULL function!");
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0res =3D kzalloc(sizeof(*res), =
internal_gfp);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!res)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return NULL;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0defer_ctx =3D kzalloc(sizeof(*=
defer_ctx), internal_gfp);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!defer_ctx)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0goto free_res;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0defer_ctx->func =3D func;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0defer_ctx->ctx =3D ctx;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0res->should_kfree =3D true;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__kunit_add_resource(test, NUL=
L, __kunit_defer_free, res, defer_ctx);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return (void *)res;
> +
> +free_res:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kfree(res);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return NULL;
> +}
> +
> +void kunit_defer_cancel_token(struct kunit *test, void *cancel_token)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct kunit_resource *res =3D=
 (struct kunit_resource *)cancel_token;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Remove the free function so=
 we don't run the deferred function. */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0res->free =3D NULL;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kunit_remove_resource(test, re=
s);
> +}
> +
> +void kunit_defer_trigger_token(struct kunit *test, void *cancel_token)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct kunit_resource *res =3D=
 (struct kunit_resource *)cancel_token;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Removing the resource shoul=
d trigger the res->free function. */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kunit_remove_resource(test, re=
s);
> +}
> +
> +static bool __kunit_defer_match(struct kunit *test,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct kunit_resource *res, void *ma=
tch_data)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct kunit_defer_ctx *match_=
ctx =3D (struct kunit_defer_ctx *)match_data;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct kunit_defer_ctx *res_ct=
x =3D (struct kunit_defer_ctx *)res->data;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Make sure this is a free fu=
nction. */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (res->free !=3D __kunit_def=
er_free)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return false;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Both the function and conte=
xt data should match. */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return (match_ctx->func =3D=3D=
 res_ctx->func) && (match_ctx->ctx =3D=3D res_ctx->ctx);
> +}
> +
> +void kunit_defer_cancel(struct kunit *test,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kunit_def=
er_function_t func,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0void *ctx=
)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct kunit_defer_ctx defer_c=
tx;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct kunit_resource *res;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0defer_ctx.func =3D func;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0defer_ctx.ctx =3D ctx;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0res =3D kunit_find_resource(te=
st, __kunit_defer_match, &defer_ctx);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (res) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0kunit_defer_cancel_token(test, res);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0kunit_put_resource(res);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> +}
> +
> +void kunit_defer_trigger(struct kunit *test,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kunit_de=
fer_function_t func,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *ct=
x)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct kunit_defer_ctx defer_c=
tx;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct kunit_resource *res;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0defer_ctx.func =3D func;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0defer_ctx.ctx =3D ctx;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0res =3D kunit_find_resource(te=
st, __kunit_defer_match, &defer_ctx);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (res) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0kunit_defer_trigger_token(test, res);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0/* We have to put() this here, else free won't be called.=
 */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0kunit_put_resource(res);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> +}

