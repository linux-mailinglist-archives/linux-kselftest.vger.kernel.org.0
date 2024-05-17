Return-Path: <linux-kselftest+bounces-10321-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5395F8C7F3B
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 02:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7CA1F22BCB
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 00:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C61F633;
	Fri, 17 May 2024 00:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HD7Szvyn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12283389;
	Fri, 17 May 2024 00:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715906014; cv=none; b=oWdY8+o8vM+DIBMjeNWAzFz7YZIFcemQJVKQTzZPYp6EG7XFAz7NzFDOd/yQVj7pRCe8sYTjpB9TlESckmzG/2dmuI9V8QduACyY3zrkCW6IhJE+CmERJvwpvRYsrLErOztjY/kM1tzxaJfwv9RgcMcMJmfX7h59Q4TS7M6RaAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715906014; c=relaxed/simple;
	bh=NtdMFwjCCg6DRe8jJko5fsFCy+aStnuV7IT8PB1A13Y=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=QH93JmupedKdsukGr94Z+8CWlw//qBNegTkGO0UCvdSU8NZC2M5nnlnM4e1Yka5bfrFs1wUDeQEeEuqYAEFRSrtygLELhq1GuONS9YKjFAxucLHTCf/IHxQcPLJ+tuNw2ZSbaJyThPRZs2I6fOhJ9HLNFnqSY4VEA7yaEoFFx9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HD7Szvyn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7095DC113CC;
	Fri, 17 May 2024 00:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715906013;
	bh=NtdMFwjCCg6DRe8jJko5fsFCy+aStnuV7IT8PB1A13Y=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=HD7SzvynKcjYOsvcvN/G2QU4qpCjqTri3qEAUXZJKLDZd8DaMG3OHyjJWQvd/PNSN
	 Hp3G5XPAdtvJsu/IhGFHIdDEP2qwIMy4G3HWe3wmKLvS+77nMDzpRF/H7juYwzhCcq
	 LGYLU2dy6v05RtemPVjwjMaeiojcS/Ic8eojFv8JE+gKUbdF69Pbpkr13ptXIlpgBb
	 1vc6a+nFcvDpsnmOhOSw7xMZ/50XnFVYsNWeU9GCgkfaUDR53tPeRIlPGD9gpFI+ZI
	 6R4pkCX9kR4SJYk04QKvI8BF6y67hgnec7XugZyYDBNO47GSXeReF5OSF4XIhCiqNk
	 fHuH7AyWjgkQQ==
Message-ID: <a5a821acebb8f447e3f17a0b5ba7f4e2.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAL_Jsq+M953w4FdOHmDWByqUbJmB+g_G=KxAuZ04zFqV6zBmzg@mail.gmail.com>
References: <20240422232404.213174-1-sboyd@kernel.org> <CABVgOSmgUJp3FijpYGCphi1OzRUNvmYQmPDdL6mN59YnbkR2iQ@mail.gmail.com> <b822c6a5488c4098059b6d3c35eecbbd.sboyd@kernel.org> <5c919f0d3d72fe1592a11c45545e8a60.sboyd@kernel.org> <CAL_JsqK4EZ0RhYCw6ZaeYSJu5Ps1J+J25vjwQy2XvNa5F5d7Pw@mail.gmail.com> <f6d7574582592f3bfa50fc45fefc53be.sboyd@kernel.org> <CAL_Jsq+M953w4FdOHmDWByqUbJmB+g_G=KxAuZ04zFqV6zBmzg@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] clk: Add kunit tests for fixed rate and parent data
From: Stephen Boyd <sboyd@kernel.org>
Cc: David Gow <davidgow@google.com>, Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>
To: Rob Herring <robh@kernel.org>
Date: Thu, 16 May 2024 17:33:31 -0700
User-Agent: alot/0.10

Quoting Rob Herring (2024-05-15 15:08:47)
> On Wed, May 15, 2024 at 4:15=E2=80=AFPM Stephen Boyd <sboyd@kernel.org> w=
rote:
> > diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > index 389d4ea6bfc1..acecefcfdba7 100644
> > --- a/drivers/of/platform.c
> > +++ b/drivers/of/platform.c
> > @@ -421,6 +421,7 @@ int of_platform_bus_probe(struct device_node *root,
> >         if (of_match_node(matches, root)) {
> >                 rc =3D of_platform_bus_create(root, matches, NULL, pare=
nt, false);
> >         } else for_each_child_of_node(root, child) {
> > +               of_node_set_flag(root, OF_POPULATED_BUS);
>=20
> No, the same spot as of_platform_populate has it. I guess this would
> be the same, but no reason to do this in the for_each_child_of_node
> loop...

Ok. I'm not intending to send this patch.

>=20
> >                 if (!of_match_node(matches, child))
> >                         continue;
> >                 rc =3D of_platform_bus_create(child, matches, NULL, par=
ent, false);
> >
> >
> > This doesn't work though. I see that prom_init() is called, which
> > constructs a DTB and flattens it to be unflattened by
> > unflatten_device_tree(). The powerpc machine type used by qemu is
> > PLATFORM_PSERIES_LPAR. It looks like it never calls
> > of_platform_bus_probe() from the pseries platform code.
>=20
> Huh. Maybe pseries doesn't have any platform devices?

Looks like it.

>=20
> Ideally, we'd still do it in of_platform_default_populate_init(), but
> if you look at the history, you'll see that broke some PPC boards
> (damn initcall ordering).
>=20
> > What about skipping the OF_POPULATED_BUS check, or skipping the check
> > when the parent is the root node? This is the if condition that's
> > giving the headache.
>=20
> I don't think we should just remove it, but a root node check seems fine.
>=20

Alright. I've added a check to see if the root node is the parent to
allow it. That works well enough, so I'll send that in v5.

