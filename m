Return-Path: <linux-kselftest+bounces-13750-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E69A931AE9
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 21:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60BA61C2196F
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 19:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB30713A86C;
	Mon, 15 Jul 2024 19:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGFc8jdp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48A1137932;
	Mon, 15 Jul 2024 19:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721071530; cv=none; b=CRgZQ0TcmaFwqH704iwBvBPzPIcL76TTIIvl1PL3iYZptctyCLMiKkZdmm6CHp4ylnvCP3996N1ufMevtz/1Ue/wYRYxZrdT2iWhJeJX0BCX2cJ/fCmq3pBmwHDn9EEE9OKhmTOm9a8oLMCcvs/Tk8OlIXdbZ0ww97X93vtBy6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721071530; c=relaxed/simple;
	bh=HCQwXA0zL4VlzEp1LLWrMug/gNBh+smW3peehKVM3dQ=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=cqU4goHteU2VI8BwcHChELwYkhrEj20C7u4zKfFBc8DA7JQ0qMtMUzjLaiHe/mOJj7tVG9pIa0Ol/75v8H8lxQf3u1Ttlo1idVEBvUzdRxxRPHImsHokVdCEINiJ4+bNorwEHFvaThFdML/1RcokpHURKRUwFIp7AuWZGR7iVl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGFc8jdp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B254C4AF0A;
	Mon, 15 Jul 2024 19:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721071530;
	bh=HCQwXA0zL4VlzEp1LLWrMug/gNBh+smW3peehKVM3dQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=cGFc8jdpGlzakskBmtnH2RFIAG691BICns+ZyaLpfMjVd0YsAdEkDS+4XpKtHBJhO
	 /GTFqfe/eZzvaxYSQyb5J/gTD0gDWKnWLFNLVE5o5yXQGcZ+kFYfnA1JJuC+n5kx3a
	 qMMwbkBzacATOjMc+pzKs6Ab11siLU1esB66TfCX4/qUk2RonbmmHFpNjq7El5Nfv7
	 vTCUM0u5M6VuYD9SNFBXdfskwencFbB1JNgDla6taY6gbgZ1CefgNQHEGtlHGF59Ll
	 bzqFatAphataWYuT2DWiwcx32jit4RpAAVmvXWJlNwNiuS8Gty2zW5nqjVYE7YfWig
	 SKtSYM7cYYGgg==
Message-ID: <083427fef0169b312530bbee22d2ba9b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240710201246.1802189-7-sboyd@kernel.org>
References: <20240710201246.1802189-1-sboyd@kernel.org> <20240710201246.1802189-7-sboyd@kernel.org>
Subject: Re: [PATCH v7 6/8] clk: Add test managed clk provider/consumer APIs
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Date: Mon, 15 Jul 2024 12:25:28 -0700
User-Agent: alot/0.10

Quoting Stephen Boyd (2024-07-10 13:12:42)
> Unit tests are more ergonomic and simpler to understand if they don't
> have to hoist a bunch of code into the test harness init and exit
> functions. Add some test managed wrappers for the clk APIs so that clk
> unit tests can write more code in the actual test and less code in the
> harness.
>=20
> Only add APIs that are used for now. More wrappers can be added in the
> future as necessary.
>=20
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

