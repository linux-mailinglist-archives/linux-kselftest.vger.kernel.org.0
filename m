Return-Path: <linux-kselftest+bounces-10264-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1571B8C6DA5
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 23:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD27F282753
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 21:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFB115B13E;
	Wed, 15 May 2024 21:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiDOQQmN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCEC2F877;
	Wed, 15 May 2024 21:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715807738; cv=none; b=GgNaSJYkGzjSu2HFG1loMxO0Qyobt1+SrysBrBaZay69ifGLH6gKB44e5OFwYwvZjgj+m+j3Br0PDuI4v3WuGx5/A5bObLb9mU+G1kKISQailg4jqZ+VHnF9Osz4CSQmH+uFkm9RpEFzlaUAZ5m+PjtMJwxvruVS2FeYyPqrkuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715807738; c=relaxed/simple;
	bh=8zRgYixeWbU5a3kUd0M4xV5TV+AjxJpEmwU45ge4kaY=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=BmsCn2nCgRDW0wQkhSgrZ3VM4nF0BbusABfrVK25kzZEPP9th1rJ3mdbkBqWUhlPh5lMZm40tiwfSqLufAOcW2V5BkLp8VE+00gR7HoCdWvSnEmLWMlvQPkmhFuf/FHhOyapJbP8tZDLGMnDCU8qibbLgJcIR+BcxTAuIuRsbAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiDOQQmN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B304C116B1;
	Wed, 15 May 2024 21:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715807738;
	bh=8zRgYixeWbU5a3kUd0M4xV5TV+AjxJpEmwU45ge4kaY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=PiDOQQmN+bIHiSfpue2YctCCuTwEZkmpnSQGS3TqeNw0bE58cNELXRSd85nazMCPD
	 yuyXdclaoXVl/gIeV3NxguyB4jU8hRBbwCLWM8Ce6hG3Aftjx0m6mkx3JnkRu8L61F
	 qCJ/012Qc4p9xwHF+8KEZzJM+driOYnuam1IQoI9owU8e5ESdC4IjvM5Mu2OlTHOjB
	 g9qjwOJYBTWtHgJDeBBv2x/DFhL6M6/FB+rJSajg2VRDV/830G/RhBhCT1FjyRohhx
	 FXGpleblOhL/tGUOmGx1hG+eiRwQldeZlT5/MfIcU1Ig4+uSXrn/MJ28b8ibODTfCo
	 7kY1NLoRgCVzw==
Message-ID: <f6d7574582592f3bfa50fc45fefc53be.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAL_JsqK4EZ0RhYCw6ZaeYSJu5Ps1J+J25vjwQy2XvNa5F5d7Pw@mail.gmail.com>
References: <20240422232404.213174-1-sboyd@kernel.org> <CABVgOSmgUJp3FijpYGCphi1OzRUNvmYQmPDdL6mN59YnbkR2iQ@mail.gmail.com> <b822c6a5488c4098059b6d3c35eecbbd.sboyd@kernel.org> <5c919f0d3d72fe1592a11c45545e8a60.sboyd@kernel.org> <CAL_JsqK4EZ0RhYCw6ZaeYSJu5Ps1J+J25vjwQy2XvNa5F5d7Pw@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] clk: Add kunit tests for fixed rate and parent data
From: Stephen Boyd <sboyd@kernel.org>
Cc: David Gow <davidgow@google.com>, Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>
To: Rob Herring <robh@kernel.org>
Date: Wed, 15 May 2024 14:15:36 -0700
User-Agent: alot/0.10

Quoting Rob Herring (2024-05-15 06:06:09)
> On Tue, May 14, 2024 at 4:29=E2=80=AFPM Stephen Boyd <sboyd@kernel.org> w=
rote:
> >
> > powerpc doesn't mark the root node with OF_POPULATED_BUS. If I set that
> > in of_platform_default_populate_init() then the overlays can be applied.
> >
> > ---8<----
> > diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > index 389d4ea6bfc1..fa7b439e9402 100644
> > --- a/drivers/of/platform.c
> > +++ b/drivers/of/platform.c
> > @@ -565,6 +565,10 @@ static int __init of_platform_default_populate_ini=
t(void)
> >                                 of_platform_device_create(node, buf, NU=
LL);
> >                 }
> >
> > +               node =3D of_find_node_by_path("/");
> > +               if (node)
> > +                       of_node_set_flag(node, OF_POPULATED_BUS);
>=20
> I think you want to do this in of_platform_bus_probe() instead to
> mirror of_platform_populate(). These are supposed to be the same
> except that 'populate' only creates devices for nodes with compatible
> while 'probe' will create devices for all child nodes. Looks like we
> are missing some devlink stuff too. There may have been some issue for
> PPC with it.

Got it. So this patch?

---8<---
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 389d4ea6bfc1..acecefcfdba7 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -421,6 +421,7 @@ int of_platform_bus_probe(struct device_node *root,
 	if (of_match_node(matches, root)) {
 		rc =3D of_platform_bus_create(root, matches, NULL, parent, false);
 	} else for_each_child_of_node(root, child) {
+		of_node_set_flag(root, OF_POPULATED_BUS);
 		if (!of_match_node(matches, child))
 			continue;
 		rc =3D of_platform_bus_create(child, matches, NULL, parent, false);


This doesn't work though. I see that prom_init() is called, which
constructs a DTB and flattens it to be unflattened by
unflatten_device_tree(). The powerpc machine type used by qemu is
PLATFORM_PSERIES_LPAR. It looks like it never calls
of_platform_bus_probe() from the pseries platform code.

What about skipping the OF_POPULATED_BUS check, or skipping the check
when the parent is the root node? This is the if condition that's
giving the headache.

---8<---
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 389d4ea6bfc1..38dfafc25d86 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -735,10 +735,6 @@ static int of_platform_notify(struct notifier_block *n=
b,
=20
 	switch (of_reconfig_get_state_change(action, rd)) {
 	case OF_RECONFIG_CHANGE_ADD:
-		/* verify that the parent is a bus */
-		if (!of_node_check_flag(rd->dn->parent, OF_POPULATED_BUS))
-			return NOTIFY_OK;	/* not for us */
-
 		/* already populated? (driver using of_populate manually) */
 		if (of_node_check_flag(rd->dn, OF_POPULATED))
 			return NOTIFY_OK;


>=20
> > +               of_node_put(node);
> >         } else {
> >                 /*
> >                  * Handle certain compatibles explicitly, since we don'=
t want to create
> >
> > I'm guessing this is wrong though, because I see bunch of powerpc speci=
fic code
> > calling of_platform_bus_probe() which will set the flag on the actual p=
latform
> > bus nodes. Maybe we should just allow overlays to create devices at the=
 root
> > node regardless? Of course, the flag doc says "platform bus created for
> > children" and if we never populated the root then that isn't entirely a=
ccurate.
> >
> > Rob, can you point me in the right direction? Do we need to use simple-=
bus in
> > the test overlays and teach overlay code to populate that bus?
>=20
> Overlays adding things to the root node might be suspect, but probably
> there are some valid reasons to do so.

In this case we're using it to add nodes without a reg property to the
root node.

> If simple-bus makes sense here,
> then yes, you should use it. But if what's on it is not MMIO devices,
> don't. That's a warning in the schema now.
>=20

Ok. Sounds like adding these nodes to the root node is the right way
then.

I wonder if we can make MMIO devices appear on the kunit bus by adding
DT support to the bus and then letting those nodes have reg properties
that we "sinkhole" by making those iomem resources point to something
else in the ioremap code. Then we can work in MMIO kunit emulation that
way to let tests check code that works with readl/writel, e.g. the clk
gate tests.

