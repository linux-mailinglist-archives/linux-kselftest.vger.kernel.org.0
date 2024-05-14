Return-Path: <linux-kselftest+bounces-10165-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D418C4B86
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 05:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A69A11F229CD
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 03:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73A6BA45;
	Tue, 14 May 2024 03:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWhj5WyH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DC3AD53;
	Tue, 14 May 2024 03:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715657751; cv=none; b=HPO42QaS7A0t7+1/FRasS7zqC+9U+HcoudA72MBtrEF/JFMjNaJiO+mENpnsvPoI/aZAb+47RQ9GmiHuYhE1XNxdSE52yWtCSbRvQn9MY93RFsp4g5zye5DKLm/L12ZxKJOLC+Z4rhfTir/l6/Krtuw5jK05WPH1pQpWfqqdD6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715657751; c=relaxed/simple;
	bh=2g51WnteVbDW6Xw9cHo8bze8u9qoK08M7PEKoTNl//U=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=i5QPuNqmTH+TZ7Nbmu5T9mEyb4i31vq4UFthc7biMNPjC/DT2LM5aGD32NFHiGEy9N9PfcySKapVH270nriVUn3qlWNlbzM8gKuPidfKwkufhHeoMkWX6TmMQkZ8cbAugOTm70nyZ+kwEXGDTikA79S+cKUajXUJ24paxRQ3M1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWhj5WyH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4913AC2BD10;
	Tue, 14 May 2024 03:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715657751;
	bh=2g51WnteVbDW6Xw9cHo8bze8u9qoK08M7PEKoTNl//U=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=RWhj5WyH38Woqr+5eMMlmko6m4W28FqTOEvMn2vnCfh/yJHDfSelrHDdq8V296J2s
	 ZaDecWJebiToXuNeDOHk8hkAqC0FezOcUWj3+1oEtpAevdnjdHYub5zHelCHV+44sP
	 sY8B02t11x5Gt58+t0omv/OQ/jp/9HsU7dCOHyrLxej3fMwMunVBzZpc6m1le3F26m
	 g027xhP7NXsTyu3Uy5iaRfbIQWnwjxHS1vTrUPnzOCbjhqtmU4cmP4ffBK3evUqzSZ
	 p3b4TXgHAQssXm6Nx/ikd6fGoui/EKPwhF4lWm0v5bRa8FnTkj+tje5PB04f8XHZ47
	 9b53bYw7AT5Qw==
Message-ID: <31d4dfdf8bc4b866a2b6d45fc4de0c2d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240422232404.213174-6-sboyd@kernel.org>
References: <20240422232404.213174-1-sboyd@kernel.org> <20240422232404.213174-6-sboyd@kernel.org>
Subject: Re: [PATCH v4 05/10] platform: Add test managed platform_device/driver APIs
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Date: Mon, 13 May 2024 20:35:49 -0700
User-Agent: alot/0.10

Quoting Stephen Boyd (2024-04-22 16:23:58)
> diff --git a/drivers/base/test/platform_kunit.c b/drivers/base/test/platf=
orm_kunit.c
> new file mode 100644
> index 000000000000..54af6db2a6d8
> --- /dev/null
> +++ b/drivers/base/test/platform_kunit.c
> @@ -0,0 +1,174 @@
[...]
> +struct platform_device *
> +platform_device_alloc_kunit(struct kunit *test, const char *name, int id)
> +{
> +       struct platform_device *pdev;
> +
> +       pdev =3D platform_device_alloc(name, id);
> +       if (!pdev)
> +               return NULL;
> +
> +       if (kunit_add_action_or_reset(test, (kunit_action_t *)&platform_d=
evice_put, pdev))
> +               return NULL;
> +
> +       return pdev;
> +}
> +EXPORT_SYMBOL_GPL(platform_device_alloc_kunit);
> +
> +static void platform_device_add_kunit_exit(struct kunit_resource *res)
> +{
> +       struct platform_device *pdev =3D res->data;
> +
> +       platform_device_unregister(pdev);
> +}
> +
> +static bool
> +platform_device_alloc_kunit_match(struct kunit *test,
> +                                 struct kunit_resource *res, void *match=
_data)
> +{
> +       struct platform_device *pdev =3D match_data;
> +
> +       return res->data =3D=3D pdev;
> +}
> +
> +/**
> + * platform_device_add_kunit() - Register a KUnit test managed platform =
device
> + * @test: test context
> + * @pdev: platform device to add
> + *
> + * Register a test managed platform device. The device is unregistered w=
hen the
> + * test completes.
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +int platform_device_add_kunit(struct kunit *test, struct platform_device=
 *pdev)
> +{
> +       struct kunit_resource *res;
> +       int ret;
> +
> +       ret =3D platform_device_add(pdev);
> +       if (ret)
> +               return ret;
> +
> +       res =3D kunit_find_resource(test, platform_device_alloc_kunit_mat=
ch, pdev);

This doesn't work because platform_device_alloc_kunit() used
kunit_add_action_or_reset() which has a chained free routine and data
pointer. I've added a test to make sure the platform device is removed
from the bus. It's not super great though because when this code fails
to find a match it will still remove the device by calling
platform_device_unregister() when the test ends. It will follow that up
with a call to platform_device_put(), which is the problem as that
causes an underflow and operates on an already freed device.

I couldn't come up with anything better than searching the platform bus.
Maybe if there was a way to allocate the memory or redirect where
platform_device_alloc_kunit() got memory from we could hold the device
memory around after it should have been freed and make sure the kref for
the device kobject is 0. That seems pretty invasive to do though so I'm
just going to leave it for now and add this test to make sure it cleans
up.

