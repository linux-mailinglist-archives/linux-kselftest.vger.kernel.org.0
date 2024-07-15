Return-Path: <linux-kselftest+bounces-13746-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C46931AD5
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 21:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78F491C218EF
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 19:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE0D1304A2;
	Mon, 15 Jul 2024 19:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBUuYYZG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2620F82D98;
	Mon, 15 Jul 2024 19:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721071491; cv=none; b=aYv+78fACRKkmbwU+7Mp8gHLaPauqpa89DBL3FAEKS+39bF8q/fL03AlQ8cG3hQU8OQnsgxWo9Rb14LVF+jKS0lSGnRYvi734VFlMzrYwrsHyOpWPsKuLRS6AnBftNi76nwzHQr9bXh6zuaKbE17eeHRvxI2ki8UBykUJzj8wMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721071491; c=relaxed/simple;
	bh=eYlGUkv26oWxsnDqavGc6bKwsTtN64atmnslN7iU/Vw=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=JEJfhNQbg+LDAm18AyTJHejzKAkh3ShByqe8AZ5u+YIDwz2UKDhZWw/vCswt3sGlc1dN5l+7U5jgYH6sbpR92el7FETdPfc7ErOqj3qHQHHVwsvfknGCrm47W2wlq2TWS0oBFYdCQhxWmmOcnZa9CZoKPktZFbsvZFeG7WB90nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBUuYYZG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AECBC4AF0E;
	Mon, 15 Jul 2024 19:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721071490;
	bh=eYlGUkv26oWxsnDqavGc6bKwsTtN64atmnslN7iU/Vw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=MBUuYYZGuwsoQi1AT29SaenIoKTPdkJdaaBjNFVpbQmqTMnvIJPSwtcdMgaw8lXi2
	 wPvSyg9yYBwgO00IDvPssmZuCQTeACCwLeNxLAgpL1ukogQfpiGXQrb43muvUXHfQ8
	 dlXqsJ3ZOyU0ZlfeimV7H6n3OnJtCHifzmFMfZ+Zj2hghdaq6RmhzjkHXjyuoDU9Vo
	 iteumEot7Uln9YfCxhT6uGm2ogOyn8Hw+N5Vs3kktbUSpZTuJuKLuF+wwiKGUTgGNK
	 46JRRubumgBvb0S/SaZ2lHxlcdKL4AuPV7kcGGVn7VdqVDa0zcPQlhIaTLchR9Mec5
	 L/eJ0nYikyLZA==
Message-ID: <aaa1af9d990ebcd53ea7743df5f19468.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240710201246.1802189-3-sboyd@kernel.org>
References: <20240710201246.1802189-1-sboyd@kernel.org> <20240710201246.1802189-3-sboyd@kernel.org>
Subject: Re: [PATCH v7 2/8] of: Add test managed wrappers for of_overlay_apply()/of_node_put()
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Date: Mon, 15 Jul 2024 12:24:48 -0700
User-Agent: alot/0.10

Quoting Stephen Boyd (2024-07-10 13:12:38)
> Add test managed wrappers for of_overlay_apply() that automatically
> removes the overlay when the test is finished. This API is intended for
> use by KUnit tests that test code which relies on 'struct device_node's
> and of_*() APIs.
>=20
> KUnit tests will call of_overlay_apply_kunit() to load an overlay that's
> been built into the kernel image. When the test is complete, the overlay
> will be removed.
>=20
> This has a few benefits:
>=20
>  1) It keeps the tests hermetic because the overlay is removed when the
>     test is complete. Tests won't even be aware that an overlay was
>     loaded in another test.
>=20
>  2) The overlay code can live right next to the unit test that loads it.
>     The overlay and the unit test can be compiled into one kernel module
>     if desired.
>=20
>  3) We can test different device tree configurations by loading
>     different overlays. The overlays can be written for a specific test,
>     and there can be many of them loaded per-test without needing to jam
>     all possible combinations into one DTB.
>=20
>  4) It also allows KUnit to test device tree dependent code on any
>     architecture, not just UML. This allows KUnit tests to test
>     architecture specific device tree code.
>=20
> There are some potential pitfalls though. Test authors need to be
> careful to not overwrite properties in the live tree. The easiest way to
> do this is to add and remove nodes with a 'kunit-' prefix, almost
> guaranteeing that the same node won't be present in the tree loaded at
> boot.
>=20
> Suggested-by: Rob Herring <robh@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: David Gow <davidgow@google.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

