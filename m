Return-Path: <linux-kselftest+bounces-4818-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EC2856FA6
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 22:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DC9CB23609
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 21:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D2E1419B5;
	Thu, 15 Feb 2024 21:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKqLNhPX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0EE13DB92;
	Thu, 15 Feb 2024 21:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708034262; cv=none; b=LtGkANG199WfhTgJa1UIHMSrsgLkqRwFOGr5Lgb32SUgIGiVyBc8EMUcoEqUb47j2cSPC7R+oSwcm678nWZkVK09B+dr/D5ZSI9Y4jtuY9mQ1sJWM/QSQEUoQzuXpjJHZIQTvKj59vqUyCbA0ZO/HvscRQ/6XFn9bIbCzLsbPq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708034262; c=relaxed/simple;
	bh=T7MZeg+yLjaU4BtqowdnnpbuIdHLYtXGFMcH9SwnC3o=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=V6WopTJ0krUuKlWeei1EOXn0xfBWd+xIMww7Tp8uhiYJVvg74Y3mNb5Tq4Au4jo7CmvibuVnsFCCzImsKL0Z5gk41WISfzb6w1Tx3XfQEgd1ia+JBQYKQy6poW1hAk/Twd3BhXLdDpUXcY94g4/mCmstIhFu5h7RibjgJeGClRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKqLNhPX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F234FC433C7;
	Thu, 15 Feb 2024 21:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708034262;
	bh=T7MZeg+yLjaU4BtqowdnnpbuIdHLYtXGFMcH9SwnC3o=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=HKqLNhPXnNKvbiW3EkbP1vnJu/P3vG86/ySfYdF3/dkJRvBlKdC16LT5mZItEadLZ
	 598aG+3ah3tkmZLOIrdMCA71Mv1dhqn/X9wN6XZE2PFnEQ6u9ytiCXPexNV6EfMqDL
	 +S/VfoHHM1M1sW6VN+xeXqAf7GACRVuBldgxHQqrhOn1ISIO28LWtV2GGCUmEB3zYg
	 LhUL9oistI6vrDdKAo/sunUbQYDUYBQ9qCuFzIPCyK9fbnmogWsbeD7/IbCkVRVYdg
	 ZDB69vXMxMVXPPwP5isAT3K/QDz1xP57NY8LETK4c19bJ9dWpvu+gdz4RikrKAAj9r
	 WXx8+d2ecNk+g==
Message-ID: <3e67766fa85be7dd865c5ec9dea1b53b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAL_JsqLrRXdPZ+u9XG960V7sXECBi5Ko7BYdreftYz-O=Hwieg@mail.gmail.com>
References: <20240202195909.3458162-1-sboyd@kernel.org> <20240202195909.3458162-8-sboyd@kernel.org> <CABVgOS=A8BQ6HHpBKFqg-N10ckk2XYavaS-MPXvZ0wenrVm=1g@mail.gmail.com> <89892ecd6b1b043db58258705c32b02b.sboyd@kernel.org> <CAMuHMdUuP5Ya2gU3V_ET=Ji_+yx+jr7eCch5uDJSqvQN9jJM3g@mail.gmail.com> <2185a3cc3152a0b9a94b0c64353bc9a1.sboyd@kernel.org> <CAL_JsqLrRXdPZ+u9XG960V7sXECBi5Ko7BYdreftYz-O=Hwieg@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] of: Add KUnit test to confirm DTB is loaded
From: Stephen Boyd <sboyd@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org, patches@lists.linux.dev, linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, Brendan Higgins <brendan.higgins@linux.dev>
To: Rob Herring <robh+dt@kernel.org>
Date: Thu, 15 Feb 2024 13:57:39 -0800
User-Agent: alot/0.10

Quoting Rob Herring (2024-02-13 09:52:00)
> On Fri, Feb 9, 2024 at 8:59=E2=80=AFPM Stephen Boyd <sboyd@kernel.org> wr=
ote:
> >
> > ---8<---
> > diff --git a/init/main.c b/init/main.c
> > index e24b0780fdff..02f5cf8be6c1 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -97,6 +97,8 @@
> >  #include <linux/jump_label.h>
> >  #include <linux/kcsan.h>
> >  #include <linux/init_syscalls.h>
> > +#include <linux/of.h>
> > +#include <linux/of_fdt.h>
> >  #include <linux/stackdepot.h>
> >  #include <linux/randomize_kstack.h>
> >  #include <net/net_namespace.h>
> > @@ -895,6 +897,8 @@ void start_kernel(void)
> >         pr_notice("%s", linux_banner);
> >         early_security_init();
> >         setup_arch(&command_line);
> > +       if (!of_root)
>=20
> of_root is another thing I'd like to remove direct access to. That
> check could be inside unflatten_device_tree().

Ok.

>=20
> > +               unflatten_device_tree();
>=20
> That's back to what Frank had essentially and I wanted to avoid.

Alright, fair enough.

>=20
> I think I'd just disable the tests on the above arches and let them
> opt-in. I could be convinced otherwise though.
>=20

Kunit folks would prefer to skip tests when dependencies aren't
satisfied. The OF_UNITTEST config already depends on !SPARC so perhaps
it's simplest to have tests skip if OF_EARLY_FLATREE=3Dn. Then
OF_EARLY_FLATREE can be def_bool OF && !(SPARC || M68K || other arches).
The OF_UNITTEST config can depend on OF_EARLY_FLATREE instead of select
it then. This way new supporting architectures can remove themselves
from the def_bool line when they start calling unflatten_device_tree().

