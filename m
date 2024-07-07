Return-Path: <linux-kselftest+bounces-13291-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7BC929942
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jul 2024 20:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9727E281531
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jul 2024 18:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3C758AD0;
	Sun,  7 Jul 2024 18:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4aitq+I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C24A5381A;
	Sun,  7 Jul 2024 18:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720375735; cv=none; b=ov+uCb2YsQ7ot4x74uSgkr8VS8IOa/Eo2LlrCqhEz796DqOgCBULXHN+YYn9149IgmDmv+pk+ACp+uFDk0HYQwD2Xcm1KtvYteEJU8K9F52+OJwUVKuCIh2Vplrrclc340y6lnHQ8cgE5dQ/LQDgLJF8uVYf1CJ0BhFm4hdbfY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720375735; c=relaxed/simple;
	bh=qgvupkcqbZwzRUgn2B7hFKQb99frslsPEmmO/j0sSpI=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=q8G2gHlTQb2dlQwyFwWLO242Cw3/bl7KUMFJ6RJTLVDhZRvL3YXFuHUUIdRr2J60GE+5VqF38+3yo+LgbRQJUcKb9iHFSJYrtSkeOuL9+FGJCYj6sO3s4EgMjNk12F34Kx6BMloiOKWoZi2veuHwvkp5Hcgi5zhADxemQAxN2Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4aitq+I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EECDFC3277B;
	Sun,  7 Jul 2024 18:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720375735;
	bh=qgvupkcqbZwzRUgn2B7hFKQb99frslsPEmmO/j0sSpI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=B4aitq+I/8M2dGkZf5DHTcYN0VFmyWC8MBFCxkz8CudlG3Nf89uxUv+DNDnwWq51E
	 QG7s2OjUKcom2dY9k1HP/BLcHVvVY8CMTw/9NVsZ+fEAxgBUw9stJ90I65DoNKbwe0
	 KEmJiyXfYEr/+28AqhDy6Z2g2yK8EtBHhexhUmGLRfPNe0c7QOov1ukIw/WyceVLro
	 iwZVS+Fn+mEzBNsZ5BoICy9EPoixqwOkMtZ/lWViG4zeGQGWdobYUMms9u1TS7rOqd
	 JUjwmpzJmBzyyZ0GuAFjc06q4eHjv1BdKiUv+DtL/LbLOtmTR87EXGr+pgerYs7T1Y
	 Q7D2yJQ15AGNA==
Message-ID: <b07579a09b59a75cbf74aa972165f90d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <34d38e79a2008ed6e4303e6911b1cf08.sboyd@kernel.org>
References: <20240706045454.215701-1-sboyd@kernel.org> <20240706045454.215701-6-sboyd@kernel.org> <CABVgOSk93mNY4diXppGWJZgWJhrHpGqECBXNROWkRCaZjFi2tw@mail.gmail.com> <34d38e79a2008ed6e4303e6911b1cf08.sboyd@kernel.org>
Subject: Re: [PATCH v6 5/8] platform: Add test managed platform_device/driver APIs
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>
To: David Gow <davidgow@google.com>
Date: Sun, 07 Jul 2024 11:08:52 -0700
User-Agent: alot/0.10

Quoting Stephen Boyd (2024-07-07 11:02:06)
> Quoting David Gow (2024-07-06 01:04:25)
> > On Sat, 6 Jul 2024 at 12:55, Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > Introduce KUnit resource wrappers around platform_driver_register(),
> > > platform_device_alloc(), and platform_device_add() so that test autho=
rs
> > > can register platform drivers/devices from their tests and have the
> > > drivers/devices automatically be unregistered when the test is done.
> > >
> > > This makes test setup code simpler when a platform driver or platform
> > > device is needed. Add a few test cases at the same time to make sure =
the
> > > APIs work as intended.
> > >
> > > Cc: Brendan Higgins <brendan.higgins@linux.dev>
> > > Reviewed-by: David Gow <davidgow@google.com>
> > > Cc: Rae Moar <rmoar@google.com>
> > > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > > ---
> >=20
> > Hmm... this is failing under KASAN for me. I'll take a closer look
> > next week, but in case there's anything super-obvious, here's the
> > report:
>=20
> Thanks. I reproduced with your commandline and I'll take a look.
>=20

Seems that I forgot to fold this in when I was testing.

----8<---
diff --git a/lib/kunit/platform.c b/lib/kunit/platform.c
index ba1b0006dc45..0b518de26065 100644
--- a/lib/kunit/platform.c
+++ b/lib/kunit/platform.c
@@ -75,7 +75,7 @@ kunit_platform_device_alloc_match(struct kunit *test,
 {
 	struct platform_device *pdev =3D match_data;
=20
-	return res->data =3D=3D pdev && res->free !=3D kunit_platform_device_allo=
c_exit;
+	return res->data =3D=3D pdev && res->free =3D=3D kunit_platform_device_al=
loc_exit;
 }
=20
 KUNIT_DEFINE_ACTION_WRAPPER(platform_device_unregister_wrapper,

