Return-Path: <linux-kselftest+bounces-13749-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C27931AE3
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 21:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1366F1F22A1C
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 19:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D58132464;
	Mon, 15 Jul 2024 19:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="naJQ5j91"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E17082D98;
	Mon, 15 Jul 2024 19:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721071521; cv=none; b=g4rKBN8tMkrG5Asey3nWhTusKQInzyHqqkkD5NcQp+jj76JtMczAkfhA+kYVeQybW8k7cI9HdZskoyynQ6cHx9pKExsG2DndjuIat17RU90LBx5y1pHjvbHAtiSWNf5evQdPea85MAwW55ltyTOJQ1kPP1zX79QFZxnecDTECyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721071521; c=relaxed/simple;
	bh=gcrMwZFMXG3+JgpSvg87yIyW8CM553uiZ+BggJ2J7yE=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=dEZohxVjrWXq7qlN/diUmYzQUdBZFcjLaBFrBu6NBcfPbua2dBFZ4cAK+IqaYfVY0tG0VfGF/0itD8mhbuvKU2bA3YU2+fwCFy27njFrIm5bWK64SmbbB0DpOzr4K+bikaJOczE3qA5iOkynFctV34eAOPfl7zTvM2lypeMebz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=naJQ5j91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7C7C4AF0B;
	Mon, 15 Jul 2024 19:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721071520;
	bh=gcrMwZFMXG3+JgpSvg87yIyW8CM553uiZ+BggJ2J7yE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=naJQ5j91MxyNXtSOc/66ck0W0wb8kgjxjmm2Jgx2UsjkvxJ6AQPrqx0cb9RceyeYY
	 O22aSIGKlu4kxHhASBUbD8kGHGAPlNLiZqWe6iodCp01XA3O8ZPAuhbQLhK9Y2y2oU
	 o9In9k4ntbdaLk0q1ZJGmD6bfe0GxMtbzk9kPX4E02SHFcdaRzVCs2EHMINFGHr4wo
	 J/Qt8GjccvMxGjuQ/gwQTJwOMtuGrJQ357oX/Ze1hTffo+s5gT9djMbQ1DScEsiNBy
	 uHJzNbFP/uXmbf8luZ8hPBg59s27KpjVXDD2HAvdF7O4NVxQDbQgD9ZtTtINxyOJWA
	 fh9onBSKV98kw==
Message-ID: <795c356079c0224234e5b9d97ec964d1.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240710201246.1802189-6-sboyd@kernel.org>
References: <20240710201246.1802189-1-sboyd@kernel.org> <20240710201246.1802189-6-sboyd@kernel.org>
Subject: Re: [PATCH v7 5/8] platform: Add test managed platform_device/driver APIs
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Date: Mon, 15 Jul 2024 12:25:18 -0700
User-Agent: alot/0.10

Quoting Stephen Boyd (2024-07-10 13:12:41)
> Introduce KUnit resource wrappers around platform_driver_register(),
> platform_device_alloc(), and platform_device_add() so that test authors
> can register platform drivers/devices from their tests and have the
> drivers/devices automatically be unregistered when the test is done.
>=20
> This makes test setup code simpler when a platform driver or platform
> device is needed. Add a few test cases at the same time to make sure the
> APIs work as intended.
>=20
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Reviewed-by: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

