Return-Path: <linux-kselftest+bounces-13748-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF67931AE1
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 21:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AE3B1C21738
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 19:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32005139D0A;
	Mon, 15 Jul 2024 19:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYlWSShd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0031304A2;
	Mon, 15 Jul 2024 19:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721071507; cv=none; b=J1uE0eLBhQBXMlOP9XIg/byfFtvpGkSlU4wN5dHpjl/H+yQc4UhV58X2+/yllvwLrfkVkiw2IRL1L3bzZQMUtld2fBVnKsA965rbpcswdBY39fbCMaUtzgZ6bntlsovgCW3unDOHTZoou+AlEIPQKGq5DjjPzIaVptE0jFsTZeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721071507; c=relaxed/simple;
	bh=JoRBxOZUpybsOqmr5tWJ5r7BWVAY3m9iux8Dn5RCTJ0=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=XIje2+kAh+TGX8Dc1Gk9bpV6GBQ7hnkBU+478zZLVbOEgc9QnEWOX/j4UtFuqmw1f6o706/e+W6Lf6CsbfuDoYuFl59EyvIuSHwGr1nKSDYmOwsXHXYPTOH+VTAPy7L6oMr8+0aq6iG1mcbir8Le+9jRsre3i8VPdUW3B1uDqsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYlWSShd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C35C4AF0A;
	Mon, 15 Jul 2024 19:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721071506;
	bh=JoRBxOZUpybsOqmr5tWJ5r7BWVAY3m9iux8Dn5RCTJ0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=IYlWSShd+nVFF8PkiMYUJ/mQXITJ/OwlEd1tALn2iu7EUzTPtk+E8cq7VFE9qHMbY
	 68Hwiyuq5E+YxxbIp1KA5CNlVpwXQVbuo0CmURcL2v83IYPEWDjq0eZgXByUHn1hZV
	 +Re/cuHbRH2jfmGS1g1i3VYebjl6xndTXmO5s9YjTj8jhXxArbLm0GSP1RhCaMbinf
	 g6rCNszT61syVoFE9Xu23oysy7tLaY2Yzfsn2mwYE+aivCEv0Hw/GoK5X5xOy6ctw6
	 SqxlPikgIYvbiV5kF7TzkNa60wYjkvzbhL7WwwJX9cUqyRhaFaDAfwmpI5EN8zyuuK
	 80yDZYuwSQ6Kg==
Message-ID: <3c967737d15eee9fcfbed675b541dacb.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240710201246.1802189-5-sboyd@kernel.org>
References: <20240710201246.1802189-1-sboyd@kernel.org> <20240710201246.1802189-5-sboyd@kernel.org>
Subject: Re: [PATCH v7 4/8] of: Add a KUnit test for overlays and test managed APIs
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Date: Mon, 15 Jul 2024 12:25:04 -0700
User-Agent: alot/0.10

Quoting Stephen Boyd (2024-07-10 13:12:40)
> Test the KUnit test managed overlay APIs. Confirm that platform devices
> are created and destroyed properly. This provides us confidence that the
> test managed APIs work correctly and can be relied upon to provide tests
> with fake platform devices and device nodes via overlays compiled into
> the kernel image.
>=20
> Cc: Rob Herring <robh@kernel.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Daniel Latypov <dlatypov@google.com>
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Reviewed-by: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

