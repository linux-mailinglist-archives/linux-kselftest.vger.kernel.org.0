Return-Path: <linux-kselftest+bounces-13404-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE6492C414
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 21:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEF31B21A7A
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 19:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E7F182A5C;
	Tue,  9 Jul 2024 19:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUz0X8U6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7927F7C7;
	Tue,  9 Jul 2024 19:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720554569; cv=none; b=FjnCavckySiah+sGq2JlaUzaOXsHdPZAikLzEyhicq+adzn3eLW0gZXPWcWTPADJlZ8Kntn9yBLfprB+ETJIlIRPT56GvsDLwgQ5wErF1BuIMx030lW/4r+cIaLYy/9FgU00hhZf3u84nBgvTIwNvPq0ah012AY4QjnvyoF+eMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720554569; c=relaxed/simple;
	bh=nemlQbh6hUiC0LFAb9INgTT743Po9pIJ7bue1vsUjmc=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=aqAD3lpyjuADg2mso/EvLtP+uDcz2nl4h2iTR5E5vYT76sU4u1Gf2zeLlUxjJZBN5cvLV94R5zSZlf077WyckXQrVA36eiBozlVi0J/1elqYAwHzeQ2YMcuxo6T7S/MCHNzKiJpCK2K+9l4jSwwJvK86o1dyewgqJTlBtnJN1PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUz0X8U6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27ABCC3277B;
	Tue,  9 Jul 2024 19:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720554569;
	bh=nemlQbh6hUiC0LFAb9INgTT743Po9pIJ7bue1vsUjmc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=QUz0X8U6FFM9PwumGE7yIm09NlCgxPuS2oycCmpclHr3W0hcPHM/AHgvP5mzfAXVS
	 sXRzADzUsr3euni6FfQ9wJa+u3Cx8YsSjTzoybBN9ilo7YlUPQc+q9JA0VgvIdbmLD
	 2LJYf2o5KGlBmhJuqjUVFKr8TF575pfYW3mjhTIliS5GcwsHahZIWF8BQb8Rizg5P1
	 nK58UK5k4ex4uj3XAQIU1g0XzL64IinVl7hoT/VgPhosIXjUSGhvEKh1x+qlmvTeCd
	 M9bh1qTAWW1GWN5qqT/dXpBE22t+MDmF9CFbk5AbHQNqrJ20bRNhZ9xcky5gDa5vJP
	 L24nVwb8rmAKQ==
Message-ID: <256827bfb6f7084d337677bf1c03bc61.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <dd7278f5-8da9-46c5-8db2-6d3882f7d674@quicinc.com>
References: <20240706045454.215701-1-sboyd@kernel.org> <20240706045454.215701-5-sboyd@kernel.org> <dd7278f5-8da9-46c5-8db2-6d3882f7d674@quicinc.com>
Subject: Re: [PATCH v6 4/8] of: Add a KUnit test for overlays and test managed APIs
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Michael Turquette <mturquette@baylibre.com>
Date: Tue, 09 Jul 2024 12:49:26 -0700
User-Agent: alot/0.10

Quoting Jeff Johnson (2024-07-09 07:49:40)
> On 7/5/24 21:54, Stephen Boyd wrote:
> > Test the KUnit test managed overlay APIs. Confirm that platform devices
> > are created and destroyed properly. This provides us confidence that the
> > test managed APIs work correctly and can be relied upon to provide tests
> > with fake platform devices and device nodes via overlays compiled into
> > the kernel image.
>=20
> ...
>=20
> > +kunit_test_suites(
> > +     &of_overlay_apply_kunit_suite,
> > +);
> > +MODULE_LICENSE("GPL");
>=20
> Multiple patches in this series introduce new instances of=20
> MODULE_LICENSE() without an accompanying MODULE_DESCRIPTION().
>=20
> Building a module without a MODULE_DESCRIPTION() will result in a=20
> warning when building with make W=3D1.

Thanks! I'll add it.

