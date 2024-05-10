Return-Path: <linux-kselftest+bounces-10047-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1308C2AEF
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 22:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77E902850B8
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 20:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8426A4D595;
	Fri, 10 May 2024 20:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHhKc+PF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F23417C98;
	Fri, 10 May 2024 20:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715371967; cv=none; b=LRnrDKfmXyM4D+IrjLNsQmWm8ZlIczH55OrW63H1No4Dod24viKEOa/KIV7gG8bp0MK+FZKNRfNYZTYLrp+ZYV4pyoi54f6NYx1hcTY0M3pHGswCFqc3jscX1L91OhBwuQ9lHFz21ACej+LkD9acd7s6RQzY/i+EITlsxaR48go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715371967; c=relaxed/simple;
	bh=ZKkZcljk702AJTFuuPtYmlTSrAuvKM1awKsEM9YYpzo=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=DxLDnGaqn8oWfYIT0zVIY5aXfFsdM5Vn3YTGliHEsOcBtMiIINEsB7WmPYML7jt0ZaoDYG8GiWT5dR05ARLInlYUaNp/ovafH0ukgANuVC4dlcqZOuWg+bGudzdH93YqvZgAemaixfHfY4fGB/fBfAbNHg33E3YyEciC0xEa9MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHhKc+PF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9BF5C2BD11;
	Fri, 10 May 2024 20:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715371966;
	bh=ZKkZcljk702AJTFuuPtYmlTSrAuvKM1awKsEM9YYpzo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=jHhKc+PF6mzL0eDQlg59ykEtL7LsttfPnDOrHXJEx26ldPk7Lu1EZu/jucg10O8Aa
	 uZf0ITXjbUD7061Y/uduLsBiyxayoMqXomL6WzmIePeEixiQI8/hHjMZqiYxqsQ4V+
	 YjhrHEeWeNVeF9GmkFA7yglUdG7ZJqY6lNdRj9+BXovO0e16QnR24uRZWowFelilcL
	 uCvQ+NL/Rs8zh2sNPisquSEKqRbE5qhue4TuSOSe79mzOnuAhgk4WN5A7EhXC5be2w
	 mCvAcZmTVTRNYpy2G0TRWWuih22mhPzWvy8GIV+VuFXG9G6C8bjBibwh3CcppxZxGu
	 /ifsv0jE22iug==
Message-ID: <8ca61099580bdbf3550f0029b6381bcc.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABVgOS=+SnMN6qG4DWRXjbHZB_87nsZdfOmPVv8yHTpCqozkWA@mail.gmail.com>
References: <20240422232404.213174-1-sboyd@kernel.org> <20240422232404.213174-6-sboyd@kernel.org> <CABVgOSk=jGzj55v+YWzOBCsG7Wdk68pyZr0VdAYftybv+5X67A@mail.gmail.com> <431171223433496db0a85072be5c83ba.sboyd@kernel.org> <CABVgOS=+SnMN6qG4DWRXjbHZB_87nsZdfOmPVv8yHTpCqozkWA@mail.gmail.com>
Subject: Re: [PATCH v4 05/10] platform: Add test managed platform_device/driver APIs
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>
To: David Gow <davidgow@google.com>
Date: Fri, 10 May 2024 13:12:44 -0700
User-Agent: alot/0.10

Quoting David Gow (2024-05-04 01:30:34)
> On Fri, 3 May 2024 at 09:04, Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting David Gow (2024-05-01 00:55:46)
> > > On Tue, 23 Apr 2024 at 07:24, Stephen Boyd <sboyd@kernel.org> wrote:
> > > > diff --git a/Documentation/dev-tools/kunit/api/platformdevice.rst b=
/Documentation/dev-tools/kunit/api/platformdevice.rst
> > > > new file mode 100644
> > > > index 000000000000..b228fb6558c2
> > > > --- /dev/null
> > > > +++ b/Documentation/dev-tools/kunit/api/platformdevice.rst
> > > > @@ -0,0 +1,10 @@
> > > > +.. SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +Platform Device API
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +
> > > > +The KUnit platform device API is used to test platform devices.
> > > > +
> > > > +.. kernel-doc:: drivers/base/test/platform_kunit.c
> > > > +   :export:
> > > > diff --git a/drivers/base/test/Makefile b/drivers/base/test/Makefile
> > > > index e321dfc7e922..740aef267fbe 100644
> > > > --- a/drivers/base/test/Makefile
> > > > +++ b/drivers/base/test/Makefile
> > > > @@ -1,8 +1,11 @@
> > > >  # SPDX-License-Identifier: GPL-2.0
> > > >  obj-$(CONFIG_TEST_ASYNC_DRIVER_PROBE)  +=3D test_async_driver_prob=
e.o
> > > >
> > > > +obj-$(CONFIG_KUNIT) +=3D platform_kunit.o
> > > > +
> > >
> > > Do we want this to be part of the kunit.ko module (and hence,
> > > probably, under lib/kunit), or to keep this as a separate module.
> > > I'm tempted, personally, to treat this as a part of KUnit, and have it
> > > be part of the same module. There are a couple of reasons for this:
> > > - It's nice to have CONFIG_KUNIT produce only one module. If we want
> > > this to be separate, I'd be tempted to put it behind its own kconfig
> > > entry.
> > > - The name platform_kunit.ko suggests (to me, at least) that this is
> > > the test for platform devices, not the implementation of the helper.
> >
> > I was following *_kunit as "helpers" and *_test as the test. Only
> > loosely based on the documentation that mentions to use _test or _kunit
> > for test files. Maybe it should have _kunit_helpers postfix?
>=20
> Yeah, the style guide currently suggests that *_test is the default
> for tests, but that _kunit may also be used for tests if _test is
> already used for non-KUnit tests:
> https://docs.kernel.org/dev-tools/kunit/style.html#test-file-and-module-n=
ames
>=20
> DRM has drm_kunit_helpers, so _kunit_helpers seems like a good suffix
> to settle on.

Alright, I'll rename the files.

>=20
> > Following the single module design should I merge the tests for this
> > code into kunit-test.c? And do the same sort of thing for clk helpers?
> > That sounds like it won't scale very well if everything is in one modul=
e.
>=20
> I don't think it's as important that the tests live in the same
> module. It's nice from an ergonomic point-of-view to only have to
> modprobe the one thing, but we've already let that ship sail somewhat
> with string-stream-test.
>=20
> Either way, splitting up kunit-test.c is something we'll almost
> certainly want to do at some point, and we can always put them into
> the same module even if they're different source files if we have to.

Alright.

>=20
> >
> > Shouldn't the wrapper code for subsystems live in those subsystems like
> > drm_kunit_helpers.c does? Maybe the struct device kunit wrappers should
> > be moved out to drivers/base/? lib/kunit can stay focused on providing
> > pure kunit code then.
>=20
> I tend to agree that wrapper code for subsystems should live in those
> subsystems, especially if the subsystems are relatively self-contained
> (i.e., the helpers are used to test that subsystem itself, rather than
> exported for other parts of the kernel to use to test interactions
> with said subsystem). For 'core' parts of the kernel, I think it makes
> it easier to make these obviously part of KUnit (e.g. kunit_kzalloc()
> is easier to have within KUnit, rather than as a part of the
> allocators).
>=20
> The struct device wrappers have the problem that they rely on the
> kunit_bus being registered, which is currently done when the kunit
> module is loaded. So it hooks more deeply into KUnit than is
> comfortable to do from drivers/base. So we've treated it as a 'core'
> part of the kernel.

Ok, thanks. The kzalloc wrappers look like the best example here. They
are so essential that they are in lib/kunit. The platform bus is built
into the kernel all the time, similar to mm, so I can see it being
essential and desired to have the wrappers in lib/kunit.

>=20
> Ultimately, it's a grey area, so I can live with this going either
> way, depending on the actual helpers, so long as we don't end up with
> lots of half-in/half-out helpers, which behave a bit like both. (For
> example, at the moment, helpers which live outside lib/kunit are
> documented and have headers in the respective subsystems'
> directories.)
>=20
> FWIW, my gut feeling for what's "most consistent" with what we've done
> so far is:
> 1. platform_device helpers should live alongside the current managed
> device stuff, which is currently in lib/kunit
> 2. clk helpers should probably live in clk
> 3. of/of_overlay sits a bit in the middle, but having thought more
> about it, it'd probably lean towards having it be part of 'of', not
> 'kunit.

Sounds good. I'll follow this route.

>=20
> But all of this is, to some extent, just bikeshedding, so as long as
> we pick somewhere to put them, and don't mix things up too much, I
> don't think it matters exactly what side of this fuzzy line they end
> up on.
>=20

Yeah. My final hesitation is that it will be "too easy" to make devices
that live on the platform_bus when they should really be on the
kunit_bus. I guess we'll have to watch out for folks making platform
devices that don't use any other platform device APIs like IO resources,
etc.

