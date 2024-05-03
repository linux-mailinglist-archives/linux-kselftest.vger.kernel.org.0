Return-Path: <linux-kselftest+bounces-9299-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CFE8BA497
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 02:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0298B212FE
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 00:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7A98C05;
	Fri,  3 May 2024 00:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoKHnsKm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2415F36B;
	Fri,  3 May 2024 00:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714696575; cv=none; b=LcSo3Dj7gSGG+mfdXOO+jHOaaU3lPUk3aCKPmjkV96EqzulEI+hUhRen6AxOfCwTNVwdkdJqkSiBuqyog2NrQ48czGhmUYZCklddcNR08QNa1g77qJQ8RROPADtwp2l2tSlyT6JarzQ9agiU3RCAQNidczcPazX0NGSJLVQmlnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714696575; c=relaxed/simple;
	bh=bKhaQEnzeCgUZSUgaPavvVhtFMZ1NYjHum4LxmtOFXU=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=DQfRZqhrB1h24cTkH2YKDL2tb5rE1rQVof6QMQ3VHVrc+GvJXtuuNJKJ3n0xBzVWlgLcBS3fDvim/U1H/lCmggrHSn1BDCHLovKMn5LwrffTGGEtyJRhYXrCwsBkI1DKMYGiB3xo0I1tUqmPV/05Q/rmEkXpoQvWHGs6fofeHF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoKHnsKm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9808FC113CC;
	Fri,  3 May 2024 00:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714696574;
	bh=bKhaQEnzeCgUZSUgaPavvVhtFMZ1NYjHum4LxmtOFXU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=YoKHnsKmaE8a1q4sq+Ino4j5K8nMsHjk/WrDO62RcRZiYdWXlosAgtujF2c9QlAIP
	 cQ7chKKKUSPiQAqMBFPlHwBMRqT4Cvzm6Kj83mYTyj5XJD1PQors+OSuSOIyZBjWJt
	 nQsHRtL0UUIC3V1zIrK+hkkXk842bkgtfZk40+5Q6KILqYJV6mv7Cund5ixvAVolSz
	 2WlCqScuTEX4ORnGm4GJA17f4c7nN6s7zQuFDHzsku1zOuiNDKNWDuHFtiSyivulAo
	 PtP5qxuDzKrzEf9Mx0DltaI0Y19tHOm4TGEcEbXWppHRLYkUiPjclovypRnWtvVwZm
	 8ajDlOzXhSABw==
Message-ID: <15345b349077f57935e8f1d3d69f66f9.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABVgOSm_Qce1AZQjH8wE4t238hxLYTNswNf1AkEDbWtqDTK7Ow@mail.gmail.com>
References: <20240422232404.213174-1-sboyd@kernel.org> <20240422232404.213174-2-sboyd@kernel.org> <CABVgOSm_Qce1AZQjH8wE4t238hxLYTNswNf1AkEDbWtqDTK7Ow@mail.gmail.com>
Subject: Re: [PATCH v4 01/10] of: Add test managed wrappers for of_overlay_apply()/of_node_put()
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>
To: David Gow <davidgow@google.com>
Date: Thu, 02 May 2024 17:36:12 -0700
User-Agent: alot/0.10

Quoting David Gow (2024-05-01 00:55:10)
> On Tue, 23 Apr 2024 at 07:24, Stephen Boyd <sboyd@kernel.org> wrote:
> > diff --git a/Documentation/dev-tools/kunit/api/index.rst b/Documentatio=
n/dev-tools/kunit/api/index.rst
> > index 2d8f756aab56..282befa17edf 100644
> > --- a/Documentation/dev-tools/kunit/api/index.rst
> > +++ b/Documentation/dev-tools/kunit/api/index.rst
> > @@ -9,11 +9,15 @@ API Reference
> >         test
> >         resource
> >         functionredirection
> > +       of
> >
> >
> >  This page documents the KUnit kernel testing API. It is divided into t=
he
> >  following sections:
> >
> > +Core KUnit API
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> >  Documentation/dev-tools/kunit/api/test.rst
> >
> >   - Documents all of the standard testing API
> > @@ -25,3 +29,10 @@ Documentation/dev-tools/kunit/api/resource.rst
> >  Documentation/dev-tools/kunit/api/functionredirection.rst
> >
> >   - Documents the KUnit Function Redirection API
> > +
> > +Driver KUnit API
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> If we're adding a separate 'Driver' section here, it's probably
> sensible to move the existing device/driver helper documentation here,
> rather than leaving it in resource.rst as-is. I'm happy to do that in
> a follow-up patch, though.

To clarify, you're talking about "Managed Devices"? Looks like that can
be a follow-up to split it into a new file and then put it here. If
you're happy to do that then I'll leave it to you.

>=20
> > +
> > +Documentation/dev-tools/kunit/api/of.rst
> > +
> > + - Documents the KUnit device tree (OF) API
> > diff --git a/Documentation/dev-tools/kunit/api/of.rst b/Documentation/d=
ev-tools/kunit/api/of.rst
> > new file mode 100644
> > index 000000000000..8587591c3e78
> > --- /dev/null
> > +++ b/Documentation/dev-tools/kunit/api/of.rst
> > @@ -0,0 +1,13 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Device Tree (OF) API
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The KUnit device tree API is used to test device tree (of_*) dependent=
 code.
> > +
> > +.. kernel-doc:: include/kunit/of.h
> > +   :internal:
> > +
> > +.. kernel-doc:: drivers/of/of_kunit.c
> > +   :export:
> > diff --git a/drivers/of/Makefile b/drivers/of/Makefile
> > index 251d33532148..0dfd05079313 100644
> > --- a/drivers/of/Makefile
> > +++ b/drivers/of/Makefile
> > @@ -19,6 +19,7 @@ obj-y +=3D kexec.o
> >  endif
> >  endif
> >
> > +obj-$(CONFIG_KUNIT) +=3D of_kunit.o
>=20
> I'm tempted to have this either live in lib/kunit, or be behind a
> separate Kconfig option, particularly since this will end up as a
> separate module, as-is.

Is the idea to have a single module that has all the kunit "stuff" in it
so we can just load one module and be done? Is there any discussion on
the list I can read to see the argument for this?

>=20
> >  obj-$(CONFIG_OF_KUNIT_TEST) +=3D of_test.o
> >
> >  obj-$(CONFIG_OF_UNITTEST) +=3D unittest-data/
> > diff --git a/drivers/of/of_kunit.c b/drivers/of/of_kunit.c
> > new file mode 100644
> > index 000000000000..f63527268a51
> > --- /dev/null
> > +++ b/drivers/of/of_kunit.c
> > @@ -0,0 +1,99 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Test managed device tree APIs
> > + */
> > +
> > +#include <linux/of.h>
> > +#include <linux/of_fdt.h>
> > +
> > +#include <kunit/of.h>
> > +#include <kunit/test.h>
> > +#include <kunit/resource.h>
> > +
> > +static void of_overlay_fdt_apply_kunit_exit(void *ovcs_id)
> > +{
> > +       of_overlay_remove(ovcs_id);
> > +}
> > +
> > +/**
> > + * of_overlay_fdt_apply_kunit() - Test managed of_overlay_fdt_apply()
> > + * @test: test context
> > + * @overlay_fdt: device tree overlay to apply
> > + * @overlay_fdt_size: size in bytes of @overlay_fdt
> > + * @ovcs_id: identifier of overlay, used to remove the overlay
> > + *
> > + * Just like of_overlay_fdt_apply(), except the overlay is managed by =
the test
> > + * case and is automatically removed with of_overlay_remove() after th=
e test
> > + * case concludes.
> > + *
> > + * Return: 0 on success, negative errno on failure
> > + */
> > +int of_overlay_fdt_apply_kunit(struct kunit *test, void *overlay_fdt,
> > +                              u32 overlay_fdt_size, int *ovcs_id)
>=20
> We're using kunit_ as a prefix for the device helpers (e.g.
> kunit_device_register()), so it may make sense to do that here, too.
> It's not as important as with the platform_device helpers, which are
> very similar to the existing device ones, but if we want to treat
> these as "part of KUnit which deals with of_overlays", rather than
> "part of "of_overlay which deals with KUnit", this may fit better.
>=20
> Thoughts?

I'm fine either way with the name. I recall that last time we put a
kunit postfix to make it easier to tab complete or something like that.

I find it hard to understand the distinction you're trying to make
though. I guess you're saying the difference is what subsystem maintains
the code, kunit or of. When they're simple wrappers it is easier to
extract them out to lib/kunit and thus they can (should?) have the kunit
prefix. Maybe that always holds true, because kunit wrappers are
typically another API consumer, and if the API is exported either in a
linux/ header or as an exported symbol it can be wrapped in lib/kunit
easily. Did I follow correctly? When would of_overlay ever deal with
KUnit?

> > diff --git a/include/kunit/of.h b/include/kunit/of.h
> > new file mode 100644
> > index 000000000000..9981442ba578
> > --- /dev/null
> > +++ b/include/kunit/of.h
> > @@ -0,0 +1,94 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _KUNIT_OF_H
> > +#define _KUNIT_OF_H
> > +
> > +#include <kunit/test.h>
> > +
> > +struct device_node;
> > +
> > +#ifdef CONFIG_OF
>=20
> Do we also need to check for CONFIG_OF_OVERLAY here?
>=20
> Also, how useful is it to compile but skip tests without
> CONFIG_OF{,_OVERLAY} enabled? The other option is a compile error,
> which may make it more obvious that these are disabled if it's
> unexpected.
>=20
> Thoughts?

I've tried to make it so that tests skip if an option isn't enabled. I
suppose the CONFIG_OF_OVERLAY check can be hoisted up here as well so
that the skip isn't buried in lower levels.

