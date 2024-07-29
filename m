Return-Path: <linux-kselftest+bounces-14405-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 705FB940131
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 00:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C6452832BE
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 22:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277A218F2C0;
	Mon, 29 Jul 2024 22:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3oy0oOh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68C118FDC1;
	Mon, 29 Jul 2024 22:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722292637; cv=none; b=B5cAsM4EScNrXgj9zga2mKY7cZKs5Z4HphR/xTYMW8f5yQOKVopyME6MQi2XJrDJcaThp0tuk3yjxvAXq7k3EmjEZX5MdVsVcOOSy0sjCSBsxQJhwirOlkxlK9cAHlPZwLVQhLypmiPe3xr1eaP9IwMJao9H+438QBcStdEwQRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722292637; c=relaxed/simple;
	bh=EIMu8CtPOmdI8qyNqhGt2ucNGupqh2zkPb5ed5YMMME=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=HfQI7vHLbjLHwzvIOFlVNfq/iBanE5hSguQ9svg6EDa2Fv8rKRECAzsdnSoxDtqPeW9cj+q+ia8Kc4YPRW6yemHHj6WRn319dpMTrVaUuNWgUxonGT9T/SgPCqZrqua5vxc0KqS1THtzbYvik6mM8CmjAXtc4+A4Qjgwj0Vf2Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3oy0oOh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE654C32786;
	Mon, 29 Jul 2024 22:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722292636;
	bh=EIMu8CtPOmdI8qyNqhGt2ucNGupqh2zkPb5ed5YMMME=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=P3oy0oOh+EeM6O6+JT4Nt+p6JlM8BgMUWUrBeyR2Xo9Ewb4lIj5XclRKiVcvLDHp9
	 PQuUPBV/Y4vwq4uzwWw132odDOQRi4tb/8jlqkYymnRiTHkJ2Gq89+XROidrtE9nOg
	 LfM58I4eKcywK4+T/kBItNgyvMX4tNiK8LaIzdM5mcoRFJ6+cGeWmJJ/noCrnAMzf/
	 xUBKFqoZGA8df28rTZ8oxr8NNC+ID7X25qw/mkTN7Y6/Gsno7Mh+SoufXKfBm2U8Bm
	 N5EZyNNSgNFkup4kn8mEcQZqSPGrwVyqK8xQMvDbOW3KgdIyMut91vGJtbY9gK6D6j
	 A4fNOSGqL2hVg==
Message-ID: <488b3f944bb892bee74e3d8aae8400e1.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240718210513.3801024-3-sboyd@kernel.org>
References: <20240718210513.3801024-1-sboyd@kernel.org> <20240718210513.3801024-3-sboyd@kernel.org>
Subject: Re: [PATCH v8 2/8] of: Add test managed wrappers for of_overlay_apply()/of_node_put()
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>, Geert Uytterhoeven <geert+renesas@glider.be>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Date: Mon, 29 Jul 2024 15:37:14 -0700
User-Agent: alot/0.10

Quoting Stephen Boyd (2024-07-18 14:05:01)
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

