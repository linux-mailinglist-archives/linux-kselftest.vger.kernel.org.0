Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1FA6C344B
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Mar 2023 15:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjCUOdI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Mar 2023 10:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjCUOdG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Mar 2023 10:33:06 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B13A4C0A;
        Tue, 21 Mar 2023 07:33:03 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2F777582194;
        Tue, 21 Mar 2023 10:33:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 21 Mar 2023 10:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1679409180; x=1679416380; bh=T/
        lq0wdl5waDK7GJCv2ptAX5Xsg9I9oRktyonRsh2Ok=; b=nSQeM/hAbtbjunm3+l
        9m0ACRX5pcJaI4mDgqc3K84iYdrOkpWyhiivRFGddhBnNafT5tIoYwX0pOKg2/r2
        d0AREqYUPBAnPjyugOIN8SdCGJ5DLL7KISvulndfWgfqsEsKKKArdTJ72QG0ezyJ
        4oMmHbQYFFK3UhUvVy9evNiYJrAY+iPwA1HL6OOwMtIYq4msJtNrcR3o4PKPsIHj
        Kty9Csv3mzjyUMehWpPB5RriaZ77gwU5fVLJXT3wRu4YMMkNNeDWM/IXnWO9RCMn
        rZERZ4TDdS8g5Ux/IOJR3oXbPFCyXkWOJEQ1+b3x+gvYXHz+KzM/vFSAqzBpPlfe
        AKCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679409180; x=1679416380; bh=T/lq0wdl5waDK
        7GJCv2ptAX5Xsg9I9oRktyonRsh2Ok=; b=WkTdIj36fxYe9ZB98EK6mienufLrF
        qeZoTxB5+dougAHWFmQH32QWx12UioQ12q5M2JLS2WS1Kr7xwhBRKkQR2QpqVrw2
        hiMqLBUR1Plzw97VXOJOPMeUjY03KWodhVVRlHatQmFQ2WezHqtoZI4h6YPwMKZH
        ZPbf5C2KfjpCXB1Fyu2SsJ0TaD9YSTVdYsgGB+5Ebz03LHezG1LKtF5yQb6CjTmN
        4jUvzz0B/Lj2B0i7vPJujZbH8yGXsEawU7ZPc1Rpc4yWK+WcfEHSHweiP0S6CbI8
        /gKKIQe7ZeUgg18lTzYQQxnZ11jXsJT9aPRjoSpd2uzOxkUXgoK6elABg==
X-ME-Sender: <xms:G8AZZLgSQPHKhlV50q8TO3b-YscRkC9yQ7lc6TnjJh3KXHLYTAIoBw>
    <xme:G8AZZIBkr2JChgYJTsTYbi8KEuTIK3nbfoAys_uyDwo6kwBEqioF6pJqiS6PK0GA7
    LGno9h1qEJDq5duAws>
X-ME-Received: <xmr:G8AZZLEiWTYxlKntBJX_Dbfee0v_Ar8edQcJPjs3c9Cl_2MWZ1WJrd3s9dB2l-8aAeOCNJ10YVlIV2qs9a2EOTRy_d9uno0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegtddgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeetfefffefgkedtfefgledugfdtjeefjedvtddtkeetieffjedvgfehheff
    hfevudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:G8AZZIQ3LvdGLv99ngFCGTO6-hTz02yJFTBVzDt_NQDAqd12r6Cx-A>
    <xmx:G8AZZIz_gaZiOALKNSZFvA5p-bS7GlshX4IHWG3o1ksbDtqfeafejg>
    <xmx:G8AZZO4y6C4PkPoN8Zjyt2N7JuF9PlRNG7idrZua3C8HEm9UgYCm4w>
    <xmx:HMAZZIEv6AY65hhQlNCWwIlZEXqiIg197-nyQfcGi_cisbYAWFZd0A>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Mar 2023 10:32:58 -0400 (EDT)
Date:   Tue, 21 Mar 2023 15:32:56 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     David Gow <davidgow@google.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-um@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH 4/8] clk: Add test managed clk provider/consumer APIs
Message-ID: <20230321143256.ybr6c6kstcv5lnbk@houat>
References: <20230302013822.1808711-1-sboyd@kernel.org>
 <20230302013822.1808711-5-sboyd@kernel.org>
 <CABVgOSkahumU6T+rCVx+k7Y9=iMszveseVYE0wfKjXwkNJpFxQ@mail.gmail.com>
 <77b315f6b89eb256c516ee08b1c17312.sboyd@kernel.org>
 <CABVgOSk4gEob3rokKF_p2Bcd_Sj3ikUN4R-HPHyTR0Eoo==85g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kn4g64rogn4yrwmy"
Content-Disposition: inline
In-Reply-To: <CABVgOSk4gEob3rokKF_p2Bcd_Sj3ikUN4R-HPHyTR0Eoo==85g@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--kn4g64rogn4yrwmy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 11, 2023 at 02:32:04PM +0800, David Gow wrote:
> > > > diff --git a/drivers/clk/clk-kunit.c b/drivers/clk/clk-kunit.c
> > > > new file mode 100644
> > > > index 000000000000..78d85b3a7a4a
> > > > --- /dev/null
> > > > +++ b/drivers/clk/clk-kunit.c
> > > > @@ -0,0 +1,204 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * KUnit helpers for clk tests
> > > > + */
> > > > +#include <linux/clk.h>
> > > > +#include <linux/clk-provider.h>
> > > > +#include <linux/err.h>
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/slab.h>
> > > > +
> > > > +#include <kunit/resource.h>
> > > > +
> > > > +#include "clk-kunit.h"
> > > > +
> > > > +static void kunit_clk_disable_unprepare(struct kunit_resource *res)
> > >
> > > We need to decide on the naming scheme of these, and in particular if
> > > they should be kunit_clk or clk_kunit (or something else).
> > >
> > > I'd lean to clk_kunit, if only to match DRM's KUnit helpers being
> > > drm_kunit_helper better, and so that these are more tightly bound to
> > > the subsystem being tested.
> > > (i.e., so I don't have to scroll through every subsystem's helpers
> > > when autocompleting kunit_).
> >
> > Ok, got it. I was trying to match kunit_kzalloc() style. It makes it
> > easy to slap the 'kunit_' prefix on existing auto-completed function
> > names like kzalloc() or clk_prepare_enable().
>=20
> Yeah: my rule of thumb at the moment is to keep the kunit_ prefix for
> things which are generic across the whole kernel (and tend to be
> implemented in lib/kunit), and to use suffixes or infixes (whichever
> works best) for things which are subsystem-specific.

A suffix is kind of weird though when any other managed call is using a
prefix: devm is always using a prefix including for clocks, kunit for
some calls too (like kzalloc).

Having clk_get vs devm_clk_get vs clk_get_kunit would be very
inconsistent and throws me off completely :)

Maxime

--kn4g64rogn4yrwmy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZBnAGAAKCRDj7w1vZxhR
xcCXAPwJeWrqE0jAwByKsB4bICizCU+z39K0DcfRrOCvNgqcfwD8DHaZSDnzz/ky
XhKIRMR9Jm58Oeu5HdXIKxO3zDFyWQU=
=1Uxg
-----END PGP SIGNATURE-----

--kn4g64rogn4yrwmy--
