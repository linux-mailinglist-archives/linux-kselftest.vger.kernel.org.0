Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4126E216F
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 13:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjDNLAo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 07:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDNLAn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 07:00:43 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606BA35B1;
        Fri, 14 Apr 2023 04:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=8uNPJbFR7IVtn1RsT91H7sboSJ2k268CmZMEJSUz9Qk=;
        t=1681470042; x=1682679642; b=I/sCIezoh19zKXoptGuue/yYv4U+/gJ+k3DLtPO/nETxdfO
        IepO9jQNMAgzkm4wzRTScuaR2ePi4MrshlVk0GfQvOY1O7dZA2jusYVPuiVlaThnjhDDlrXDE549F
        4SH5YfQ7ZRZCondqHw0qZLTHuNrIy6QBsGMSQXoRT3jefbE7uundX8xZjFvDVXFSFaUbgoyQgo3/u
        KCZeBlCMp3kgqoXBP9rQX/H/3zZkX8hAip3NfrfFjfUmNue21SNwL7uWIoS1TRcOaD70DYEMh09vU
        /8WEV5rvEj/QIgyFOUehYr9H4yx20t9L3JJcEHm6S2wpjrhFo4tzUFz0q6lERBrw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1pnHAK-00FZ3m-3C;
        Fri, 14 Apr 2023 13:00:29 +0200
Message-ID: <f51a15fbc49b9119a9e5db8240facd6ab51a0d46.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v2 1/3] kunit: Add kunit_add_action() to defer a
 call until test exit
From:   Benjamin Berg <benjamin@sipsolutions.net>
To:     maxime@cerno.tech, David Gow <davidgow@google.com>
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
Date:   Fri, 14 Apr 2023 13:00:26 +0200
In-Reply-To: <56w47e5mff74b4jrpgl4odhjxzayoptb6u2e2u6haaf7tuvl4f@xwlmne7p6kli>
References: <20230331080411.981038-1-davidgow@google.com>
         <20230331080411.981038-2-davidgow@google.com>
         <56w47e5mff74b4jrpgl4odhjxzayoptb6u2e2u6haaf7tuvl4f@xwlmne7p6kli>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On Fri, 2023-04-14 at 12:01 +0200, maxime@cerno.tech wrote:
> Hi David,
>=20
> On Fri, Mar 31, 2023 at 04:04:09PM +0800, David Gow wrote:
> > Many uses of the KUnit resource system are intended to simply defer
> > calling a function until the test exits (be it due to success or
> > failure). The existing kunit_alloc_resource() function is often used fo=
r
> > this, but was awkward to use (requiring passing NULL init functions, et=
c),
> > and returned a resource without incrementing its reference count, which
> > -- while okay for this use-case -- could cause problems in others.
> >=20
> > Instead, introduce a simple kunit_add_action() API: a simple function
> > (returning nothing, accepting a single void* argument) can be scheduled
> > to be called when the test exits. Deferred actions are called in the
> > opposite order to that which they were registered.
> >=20
> > This mimics the devres API, devm_add_action(), and also provides
> > kunit_remove_action(), to cancel a deferred action, and
> > kunit_release_action() to trigger one early.
> >=20
> > This is implemented as a resource under the hood, so the ordering
> > between resource cleanup and deferred functions is maintained.
> >=20
> > Signed-off-by: David Gow <davidgow@google.com>
> > ---
> >=20
> > Changes since RFC v1:
> > https://lore.kernel.org/linux-kselftest/20230325043104.3761770-2-davidg=
ow@google.com/
> > - Rename functions to better match the devm_* APIs. (Thanks Maxime)
> > - Embed the kunit_resource in struct kunit_action_ctx to avoid an extra
> > =C2=A0 allocation (Thanks Benjamin)
> > - Use 'struct kunit_action_ctx' as the type for cancellation tokens
> > =C2=A0 (Thanks Benjamin)
> > - Add tests.
> >=20
> > ---
> > =C2=A0include/kunit/resource.h |=C2=A0 89 ++++++++++++++++++++++++++++
> > =C2=A0lib/kunit/kunit-test.c=C2=A0=C2=A0 | 123 ++++++++++++++++++++++++=
++++++++++++++-
> > =C2=A0lib/kunit/resource.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 99 +++++++++=
++++++++++++++++++++++
> > =C2=A03 files changed, 310 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/include/kunit/resource.h b/include/kunit/resource.h
> > index c0d88b318e90..15efd8924666 100644
> > --- a/include/kunit/resource.h
> > +++ b/include/kunit/resource.h
> > @@ -387,4 +387,93 @@ static inline int kunit_destroy_named_resource(str=
uct kunit *test,
> > =C2=A0 */
> > =C2=A0void kunit_remove_resource(struct kunit *test, struct kunit_resou=
rce *res);
> > =C2=A0
> > +typedef void (*kunit_defer_function_t)(void *ctx);
> > +
> > +/* An opaque token to a deferred action. */
> > +struct kunit_action_ctx;
> > +
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
> I've tried to leverage kunit_add_action() today, and I'm wondering if
> passing the struct kunit pointer to the deferred function would help.
>=20
> The code I'm struggling with is something like:
>=20
> > static int test_init(struct kunit *test)
> > {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0priv =3D kunit_kzalloc(=
sizeof(*priv), GFP_KERNEL);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0KUNIT_ASSERT_NOT_NULL(t=
est, priv);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0test->priv =3D priv;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0priv->dev =3D alloc_dev=
ice();
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > }
>=20
> and then in the test itself:
>=20
> > static void actual_test(struct kunit *test)
> > {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct test_priv *priv =
=3D test->priv;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0id =3D allocate_buffer(=
priv->dev);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0KUNIT_EXPECT_EQ(test, i=
d, 42);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0free_buffer(priv->dev, =
id);
> > }
>=20
> I'd like to turn free_buffer an action registered right after allocate
> buffer. However, since it takes several arguments and kunit_add_action
> expects a single pointer, we would need to create a structure for it,
> allocate it, fill it, and then free it when the action has ran.
>=20
> It creates a lot of boilerplate, while if we were passing the pointer to
> struct kunit we could access the context of the test as well, and things
> would be much simpler.

The question seems to be what about the typical use-case. I was always
imagining calling functions like kfree/kfree_skb which often only
require a single argument.

For arbitrary arguments, a struct and custom free function will be
needed. At that point, maybe it is fair to assume that API users will
use the resource API directly, doing the same trick as kunit_add_action
and storing the arguments together with struct kunit_resource.

That said, maybe one could add it as a second argument? It is a little
bit weird API wise, but it would allow simply casting single-argument
functions in order to ignore "struct kunit *" argument.=20

Benjamin
