Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A266CFC7F
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Mar 2023 09:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjC3HPE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Mar 2023 03:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjC3HPB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Mar 2023 03:15:01 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD2D6A47
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Mar 2023 00:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=6Kq3aU39W9ryn89FrNrhxHRhiiFCYOxu4oueT4/lEBY=;
        t=1680160478; x=1681370078; b=tj91VOkmXfboSYvtoNZ4I+1D8NfOFf4nGAbRmp0Swhklt9q
        I9k1iyGMRWus6EDQxtbJYUFg8gm/YL3NTk+sdQT82Z21WjOOCdh0osnzAxNVPQrWy53F8l+mLOr4A
        graiOs3JFikRhcxaHMq6CLMPDdCmWKXH3gT59eIzYCqsgf9jzr+GH8ra2K+NiIuZPjCmwmd4H0kIN
        huAP+Q3rDnDbPMWnBcZeX4E7LO84MxYNniluCGNZtSYnQEtiVwVn6sCvrMx9L3jACdg/JePlf6pN3
        Z+haXiOLV7YlO9zzF5Vw+GycK+ZeQ7ORDhXw2v1Tt64+v8QsMo235AwMCOTbZq2g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1phmUS-000uRU-1B;
        Thu, 30 Mar 2023 09:14:32 +0200
Message-ID: <1a4aa2f79fd753287e17103f36b2e37670f803dc.camel@sipsolutions.net>
Subject: Re: [PATCH 2/3] kunit: add ability to register a simple cleanup
 function
From:   Benjamin Berg <benjamin@sipsolutions.net>
To:     David Gow <davidgow@google.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Johannes Berg <johannes@sipsolutions.net>
Date:   Thu, 30 Mar 2023 09:14:30 +0200
In-Reply-To: <CABVgOSkcT0f5ex6E_cbepy4R2=qmSdVwgv0XLjaFp=rg=jDzbg@mail.gmail.com>
References: <20230329172311.71861-1-benjamin@sipsolutions.net>
         <20230329172311.71861-2-benjamin@sipsolutions.net>
         <CABVgOSkcT0f5ex6E_cbepy4R2=qmSdVwgv0XLjaFp=rg=jDzbg@mail.gmail.com>
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

On Thu, 2023-03-30 at 14:17 +0800, David Gow wrote:
> On Thu, 30 Mar 2023 at 01:23, <benjamin@sipsolutions.net> wrote:
> >=20
> > From: Benjamin Berg <benjamin.berg@intel.com>
> >=20
> > This is useful to e.g. automatically free resources at the end of the
> > test, without having to deal with kunit resource objects directly.
> >=20
> > The whole point of doing this is that the callback is guaranteed to
> > happen in case the test aborts (due to an assertion). As such, use
> > assertions internally rather than requiring further error checking by
> > the API user.
> >=20
> > Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> > ---
>=20
> Thanks!
>=20
> I've actually been working on something similar here:
> https://lore.kernel.org/linux-kselftest/20230325043104.3761770-2-davidgow=
@google.com/

Oh, neat!

> Maxime suggested that it might be worth naming this kunit_add_action()
> for consistency with devm_add_action(). We also need the cancel/remove
> and trigger/release helpers for some of the other device helpers.

With kunit_add_cleanup I simply chose to copy the python unittest
API[1], which may already be familiar to people and feels quite
descriptive to me.


Something to maybe talk about is whether my approach of simply
asserting instead of returning an error is desirable.=C2=A0In my view, test=
s
should be fine with being aborted in most situations and the test
itself is never going to succeed after an allocation failure. I had a
quick look at kunit_kzalloc, and doing an assertion right afterwards is
a very common pattern. But, even if it is similar to e.g. userspace
GLib's g_malloc, it would be a new behaviour for the kernel.

Benjamin

[1] https://docs.python.org/3/library/unittest.html#unittest.TestCase.addCl=
eanup

> Hopefully between these, we can have something which works for everyone.
>=20
> Cheers,
> -- David
>=20
>=20
>=20
>=20
> > =C2=A0include/kunit/test.h | 20 ++++++++++++++++++++
> > =C2=A0lib/kunit/test.c=C2=A0=C2=A0=C2=A0=C2=A0 | 37 +++++++++++++++++++=
++++++++++++++++++
> > =C2=A02 files changed, 57 insertions(+)
> >=20
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index 519b90261c72..ab1dacf1c9f4 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -373,6 +373,26 @@ static inline void *kunit_kcalloc(struct kunit
> > *test, size_t n, size_t size, gfp
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return kunit_kmalloc_array(t=
est, n, size, gfp |
> > __GFP_ZERO);
> > =C2=A0}
> >=20
> > +typedef void (*kunit_cleanup_t)(const void *);
> > +
> > +/**
> > + * kunit_add_cleanup() - Add post-test cleanup action.
> > + * @test: The test case to which the resource belongs.
> > + * @cleanup_func: function to call at end of test.
> > + * @data: data to pass to @free_func.
> > + * @internal_gfp: gfp to use for internal allocations, if unsure,
> > use GFP_KERNEL
> > + *
> > + * This adds a cleanup action to be executed after the test
> > completes.
> > + * Internally this is handled using a *test managed resource*.
> > + *
> > + * This function will abort the test on failure.
> > + *
> > + * Note: KUnit needs to allocate memory for a kunit_resource
> > object. You must
> > + * specify an @internal_gfp that is compatible with the current
> > context.
> > + */
> > +void kunit_add_cleanup(struct kunit *test, kunit_cleanup_t
> > cleanup_func,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const void *data,=
 gfp_t internal_gfp);
> > +
> > =C2=A0void kunit_cleanup(struct kunit *test);
> >=20
> > =C2=A0void __printf(2, 3) kunit_log_append(char *log, const char *fmt,
> > ...);
> > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > index c9e15bb60058..72d956dfc324 100644
> > --- a/lib/kunit/test.c
> > +++ b/lib/kunit/test.c
> > @@ -719,6 +719,43 @@ void *kunit_kmalloc_array(struct kunit *test,
> > size_t n, size_t size, gfp_t gfp)
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL_GPL(kunit_kmalloc_array);
> >=20
> > +struct kunit_auto_cleanup {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct kunit_resource resource;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kunit_cleanup_t cleanup_func;
> > +};
> > +
> > +static void kunit_auto_cleanup_free(struct kunit_resource *res)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct kunit_auto_cleanup *cleanu=
p;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cleanup =3D container_of(res, str=
uct kunit_auto_cleanup,
> > resource);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cleanup->cleanup_func(cleanup->re=
source.data);
> > +}
> > +
> > +void kunit_add_cleanup(struct kunit *test, kunit_cleanup_t
> > cleanup_func,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const void *data,=
 gfp_t internal_gfp)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct kunit_auto_cleanup *res;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KUNIT_ASSERT_NOT_NULL_MSG(test, c=
leanup_func,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Cleanup function must not=
 be
> > NULL");
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 res =3D kzalloc(sizeof(*res), int=
ernal_gfp);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!res) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 cleanup_func(data);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 KUNIT_ASSERT_FAILURE(test, "Could not allocate
> > resource for cleanup");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 res->cleanup_func =3D cleanup_fun=
c;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 res->resource.should_kfree =3D tr=
ue;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Cannot fail as init is NULL */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __kunit_add_resource(test, NULL, =
kunit_auto_cleanup_free,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 &res->resource, (void *)data);
> > +}
> > +EXPORT_SYMBOL_GPL(kunit_add_cleanup);
> > +
> > =C2=A0static inline bool kunit_kfree_match(struct kunit *test,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st=
ruct kunit_resource *res,
> > void *match_data)
> > =C2=A0{
> > --
> > 2.39.2
> >=20

