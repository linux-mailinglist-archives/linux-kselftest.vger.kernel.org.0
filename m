Return-Path: <linux-kselftest+bounces-13089-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B94924B96
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 00:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C725AB20D59
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 22:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E201DA30C;
	Tue,  2 Jul 2024 22:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLPZewcd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9659D1DA302;
	Tue,  2 Jul 2024 22:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719959150; cv=none; b=Qr3Vz+BU3Gpd3Pr/2Ij6rd0zhL6LoIHYRu6VoEwR1DU/lcTw7tnbtuUKRNTZ2lQs0gnDMQBLJDg1stMC67skgaXl+c0tHatjOPiG86m0xt957jK6wsgsPoJdVqH390BgH6q4hlfT31WEEI9qP4GCh6kMpxyqCQh98wF+rk0FHBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719959150; c=relaxed/simple;
	bh=xPUDoFRaSIIRZKlVHUF3wDN0LVVADMlRmKTOrYQ/+WQ=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=lhlC9INB25LEj3me44bTf+/5nhxyTuPfnlAX02zYT14cAeud/IUHIMMJY79rHWRrRU/uH8//CIBCKU6E+xPgNsjpXS3Eh1BbvJkkhhZprXWXlbv9NmP3lpxaPXq8k4jVUbGmjQaCIByTgsC4vI9zsJxerVAvRDoCKeuvxFZ2vWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLPZewcd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE852C116B1;
	Tue,  2 Jul 2024 22:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719959150;
	bh=xPUDoFRaSIIRZKlVHUF3wDN0LVVADMlRmKTOrYQ/+WQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=NLPZewcddc/jeneoRtTxm3HZYkNS05iJd83e+K5Yn+iMQ/xm1D4HupLCMLI8KTDeL
	 dXKL+ZYzLOkJ4gS7b5UdXjzYJMV3VcjaRrFc87cisdMGPqePm7Jbl855imMgfn8ORN
	 v9kWaZy3oUESimmQfiwFQIoPrExNGpT7hdg3e2cFwLoDDaNeD4/4RtLrAtkc+vub46
	 6/b1sCFW0fOIY9i6Da8J9UXAw3D+s0iOTMhmkbczwfDyj/zpfPOKss/wVnmYh/kfYV
	 QlA14ALAvcJRoxdL/PDwJUsuv34EdOQ5hOpb/sHDkBIcdLOh62NepK/j46YFP473Ea
	 yg/laUu19IetA==
Message-ID: <c88fbeb65cfda6c568b4d8d69215139f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABVgOS=4Qnb7pvc_mmkPGdyVFGNWU9wdyn9p-QBKKG+rbJGtfA@mail.gmail.com>
References: <20240603223811.3815762-1-sboyd@kernel.org> <20240603223811.3815762-12-sboyd@kernel.org> <CABVgOS=4Qnb7pvc_mmkPGdyVFGNWU9wdyn9p-QBKKG+rbJGtfA@mail.gmail.com>
Subject: Re: [PATCH v5 11/11] clk: Add KUnit tests for clks registered with struct clk_parent_data
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>
To: David Gow <davidgow@google.com>
Date: Tue, 02 Jul 2024 15:25:47 -0700
User-Agent: alot/0.10

Quoting David Gow (2024-06-13 00:56:08)
> On Tue, 4 Jun 2024 at 06:38, Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Test that clks registered with 'struct clk_parent_data' work as
> > intended and can find their parents.
> >
> > Cc: Christian Marangi <ansuelsmth@gmail.com>
> > Cc: Brendan Higgins <brendan.higgins@linux.dev>
> > Cc: David Gow <davidgow@google.com>
> > Cc: Rae Moar <rmoar@google.com>
> > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > ---
>=20
> This seems good to me overall, but will break if we can't compile the
> dtbo.o file. Maybe these need to live behind a  #if
> IS_ENABLED(CONFIG_OF) or equivalent.
>=20
> Also, there's a cast to kunit_action_t* which needs to use a wrapper.
>=20
> Otherwise,
> Reviewed-by: David Gow <davidgow@google.com>
>=20
> Cheers,
> -- David
>=20
> >  drivers/clk/Kconfig                         |   1 +
> >  drivers/clk/Makefile                        |   3 +-
> >  drivers/clk/clk_parent_data_test.h          |  10 +
> >  drivers/clk/clk_test.c                      | 451 +++++++++++++++++++-
> >  drivers/clk/kunit_clk_parent_data_test.dtso |  28 ++
> >  5 files changed, 491 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/clk/clk_parent_data_test.h
> >  create mode 100644 drivers/clk/kunit_clk_parent_data_test.dtso
> >
> > diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> > index f649f2a0279c..c33fdf9fdcd6 100644
> > --- a/drivers/clk/Kconfig
> > +++ b/drivers/clk/Kconfig
> > @@ -508,6 +508,7 @@ config CLK_KUNIT_TEST
> >         tristate "Basic Clock Framework Kunit Tests" if !KUNIT_ALL_TESTS
> >         depends on KUNIT
> >         default KUNIT_ALL_TESTS
> > +       select OF_OVERLAY if OF
> >         help
> >           Kunit tests for the common clock framework.
> >
> > diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> > index 7b57e3d22cee..ed4e1a0e6943 100644
> > --- a/drivers/clk/Makefile
> > +++ b/drivers/clk/Makefile
> > @@ -2,7 +2,8 @@
> >  # common clock types
> >  obj-$(CONFIG_HAVE_CLK)         +=3D clk-devres.o clk-bulk.o clkdev.o
> >  obj-$(CONFIG_COMMON_CLK)       +=3D clk.o
> > -obj-$(CONFIG_CLK_KUNIT_TEST)   +=3D clk_test.o
> > +obj-$(CONFIG_CLK_KUNIT_TEST)   +=3D clk_test.o \
> > +                                  kunit_clk_parent_data_test.dtbo.o
>=20
> This breaks if CONFIG_OF isn't enabled, as there's no rule to compile it:
> make[5]: *** No rule to make target
> 'drivers/clk/kunit_clk_parent_data_test.dtbo.o', needed by
> 'drivers/clk/modules.order'.  Stop.
>=20

Ah, I see that I need to set CONFIG_DTC or the DT compiler (dtc) won't
be built. Maybe I should just select OF_OVERLAY instead of being nice
and letting OF be disabled? The problem is that I can't test the
CONFIG_OF=3Dn case easily then.

For now I'll go with 'select DTC', but it really feels like we should
just get rid of that Kconfig and build 'dtc' if it is needed.

> > diff --git a/drivers/clk/clk_test.c b/drivers/clk/clk_test.c
> > index 39e2b5ff4f51..bdf3c4bb2243 100644
> > --- a/drivers/clk/clk_test.c
> > +++ b/drivers/clk/clk_test.c
> > @@ -4,12 +4,19 @@
> >   */
> >  #include <linux/clk.h>
> >  #include <linux/clk-provider.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> >
> >  /* Needed for clk_hw_get_clk() */
> >  #include "clk.h"
[...]
> > +
> > +/**
> > + * struct clk_register_clk_parent_data_of_ctx - Context for clk_parent=
_data OF tests
> > + * @np: device node of clk under test
> > + * @hw: clk_hw for clk under test
> > + */
> > +struct clk_register_clk_parent_data_of_ctx {
> > +       struct device_node *np;
> > +       struct clk_hw hw;
> > +};
> > +
> > +static int clk_register_clk_parent_data_of_test_init(struct kunit *tes=
t)
> > +{
> > +       struct clk_register_clk_parent_data_of_ctx *ctx;
> > +
> > +       KUNIT_ASSERT_EQ(test, 0,
> > +                       of_overlay_apply_kunit(test, kunit_clk_parent_d=
ata_test));
> > +
> > +       ctx =3D kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
> > +       if (!ctx)
> > +               return -ENOMEM;
> > +       test->priv =3D ctx;
> > +
> > +       ctx->np =3D of_find_compatible_node(NULL, NULL, "test,clk-paren=
t-data");
> > +       if (!ctx->np)
> > +               return -ENODEV;
> > +
> > +       return kunit_add_action_or_reset(test, (kunit_action_t *)&of_no=
de_put, ctx->np);
>=20
> We should use an action wrapper here (KUNIT_DEFINE_ACTION_WRAPPER()),
> as casting function pointers to kunit_action_t* breaks control-flow
> integrity.

Got it, thanks. Maybe there should be an of_node_put_kunit_exit() helper th=
at
does that and can be used anywhere.

