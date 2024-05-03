Return-Path: <linux-kselftest+bounces-9301-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 401CB8BA4E3
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 03:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8D621F230CB
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 01:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699BBD2FA;
	Fri,  3 May 2024 01:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqHjGmHa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E49ABE58;
	Fri,  3 May 2024 01:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714699665; cv=none; b=foVcCsvTd/+kNL/3DcYXnr+CV21WKnXdpU+XiN/AqNc/cbfNnQA+VXoH/hIqeYJKCHe52ITKbOorVp/xiPxaLi6repF4Th8c9kHA2FNey4PctHiiYBS2m+459y4AVmP6SFrZC4mlOWG3icciMLN7YIy/a8riO/39zOPVtLuPGh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714699665; c=relaxed/simple;
	bh=7+OCs1frOmX7fsw9+l60/r+QLonvowdRmW1VMJOzAxM=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=b4zaahVHhtnAlk7WPDgsd1uTmFLL50MNikSXbvJfiuh9rD45Nvwt6fptrnASazFdXODrM9rFwph8AlvYBjNhRZuHEob4s/RFZmySUREwa4V7c05mEajRo4Sb+KdpbnSEHCYDPUmS7y6Lu48q20+BDyiJCjKSIpeo16cPilboAaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqHjGmHa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732E4C113CC;
	Fri,  3 May 2024 01:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714699664;
	bh=7+OCs1frOmX7fsw9+l60/r+QLonvowdRmW1VMJOzAxM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=FqHjGmHatbLDqkXvPJmO2CWsjca1qAHGrHoekNT0AToQpwZKIGZldXBtXSSCK4ACa
	 6ga+UZssczhA5iau0MzVvkwqvVli26agjx1ej4nz7G0dN23snKsLxe2Hlg9x1u2sM8
	 IAD32WifcPNlG0lHA2JPWvgbsj4kRkrp9PbHt1y0HwFbM83+HSJZrW5/ow2Alx+JSz
	 cLtNLL3upK2nW1AU9hUHOQqk1HdPvNzT2AVbK+ksS1pHlFFgF1IfbQn9A6i/wDY9rr
	 rU+L/REE1z9Wr360oJkxXOMtPUW1U0zdCY8HKJM7ZX0iSpQkYiKI+JGWsLlJ60l7M7
	 ohmHw4l1fyIFw==
Message-ID: <b822c6a5488c4098059b6d3c35eecbbd.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABVgOSmgUJp3FijpYGCphi1OzRUNvmYQmPDdL6mN59YnbkR2iQ@mail.gmail.com>
References: <20240422232404.213174-1-sboyd@kernel.org> <CABVgOSmgUJp3FijpYGCphi1OzRUNvmYQmPDdL6mN59YnbkR2iQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] clk: Add kunit tests for fixed rate and parent data
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>
To: David Gow <davidgow@google.com>
Date: Thu, 02 May 2024 18:27:42 -0700
User-Agent: alot/0.10

Quoting David Gow (2024-05-01 01:08:11)
>=20
> Thanks very much. I'm about halfway through reviewing these, and I
> like them a lot so far.
>=20
> Most of my thoughts are just naming ideas. I fear some of them may be
> the reverse of previous suggestions, as we've since landed the KUnit
> device wrappers in include/kunit/device.h, which we decided would live
> as part of KUnit, not as part of the device infrastructure. I don't
> enormously mind if we make the opposite decision for these, though it
> does seem a bit inconsistent if we do 'devices' differently from
> 'platform_devices'. Thoughts?

Let's discuss on one of the patches.

>=20
> The other thing I've noted so far is that the
> of_apply_kunit_platform_device and of_overlay_apply_kunit_cleanup
> tests fail (and BUG() with a NULL pointer) on powerpc:
> > [15:18:51]     # of_overlay_apply_kunit_platform_device: EXPECTATION FA=
ILED at drivers/of/overlay_test.c:47
> > [15:18:51]     Expected pdev is not null, but is
> > [15:18:51] BUG: Kernel NULL pointer dereference at 0x0000004c

This seems to be because pdev is NULL and we call put_device(&pdev->dev)
on it. We could be nicer and have an 'if (pdev)' check there. I wonder
if that fixes the other two below?

---8<---
diff --git a/drivers/of/overlay_test.c b/drivers/of/overlay_test.c
index 223e5a5c23c5..85cfbe6bb132 100644
--- a/drivers/of/overlay_test.c
+++ b/drivers/of/overlay_test.c
@@ -45,7 +45,8 @@ static void of_overlay_apply_kunit_platform_device(struct=
 kunit *test)
=20
 	pdev =3D of_find_device_by_node(np);
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, pdev);
-	put_device(&pdev->dev);
+	if (pdev)
+		put_device(&pdev->dev);
 }
=20
 static int of_overlay_bus_match_compatible(struct device *dev, const void =
*data)
@@ -77,8 +78,8 @@ static void of_overlay_apply_kunit_cleanup(struct kunit *=
test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, np);
=20
 	pdev =3D of_find_device_by_node(np);
-	put_device(&pdev->dev); /* Not derefing 'pdev' after this */
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+	put_device(&pdev->dev); /* Not derefing 'pdev' after this */
=20
 	/* Remove overlay */
 	kunit_cleanup(&fake);
@@ -91,7 +92,8 @@ static void of_overlay_apply_kunit_cleanup(struct kunit *=
test)
 	dev =3D bus_find_device(&platform_bus_type, NULL, kunit_compatible,
 			      of_overlay_bus_match_compatible);
 	KUNIT_EXPECT_PTR_EQ(test, NULL, dev);
-	put_device(dev);
+	if (dev)
+		put_device(dev);
 }
=20
 static struct kunit_case of_overlay_apply_kunit_test_cases[] =3D {

> > [15:18:51]     # of_overlay_apply_kunit_platform_device: try faulted: l=
ast line seen lib/kunit/resource.c:99
> > [15:18:51]     # of_overlay_apply_kunit_platform_device: internal error=
 occurred preventing test case from running: -4
> > [15:18:51] [FAILED] of_overlay_apply_kunit_platform_device
>=20
> > [15:18:51] BUG: Kernel NULL pointer dereference at 0x0000004c
> > [15:18:51] note: kunit_try_catch[698] exited with irqs disabled
> > [15:18:51]     # of_overlay_apply_kunit_cleanup: try faulted: last line=
 seen drivers/of/overlay_test.c:77
> > [15:18:51]     # of_overlay_apply_kunit_cleanup: internal error occurre=
d preventing test case from running: -4
> > [15:18:51] [FAILED] of_overlay_apply_kunit_cleanup
>=20
> I've not had a chance to dig into it any further, yet, but it appears
> to work on all of the other architectures I tried.

Cool. I don't know why powerpc doesn't make devices. Maybe it has a
similar design to sparc to create resources. I'll check it out.

