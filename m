Return-Path: <linux-kselftest+bounces-13745-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC67931AD0
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 21:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9AB11F220FF
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 19:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB68482D98;
	Mon, 15 Jul 2024 19:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpS5RaSh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B3917BA4;
	Mon, 15 Jul 2024 19:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721071483; cv=none; b=Dfb1VJQe1MwO23XJ4M6rSwBft6R9zwXCUnQ+iIrfKMdkTCLJ4GbflU0mb9AkR6O9mQ+gNkFIas3XvNje9/tRSR7+a/7kEk4Gvtap7SBdLKFON9ccCxXq0yApnxC3UX9oDA6UY485Y6iEE5AiEhJzFHzGuTmt7Lg8iyXWvQJsLV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721071483; c=relaxed/simple;
	bh=YfTpG1xRuTzAEfH2c0EwXhhwpdT3fwRyhYT1rdSqm5s=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=N9+YErScBU8SBJzEp8AhWvLXPuGd5kpeJW9rFlRCMpFEzHBP6dboTP+CrJfk43R8v31G32Ah8Cy5oNE03kuZwGxYc68xzMV1x4GIgIzYvtV9XwHPHjZbN/B3A/inBq1l+kdyoQHVoMT/4Pl+vSm7/bbR00+FR5NuybbIM3EjpSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpS5RaSh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DAAC4AF0B;
	Mon, 15 Jul 2024 19:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721071483;
	bh=YfTpG1xRuTzAEfH2c0EwXhhwpdT3fwRyhYT1rdSqm5s=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=jpS5RaShpA4mhlibAWQIatrVgYFEXqM8gqlAjz3bkIU6LQYPV7JXMGR1bw1hIQeOY
	 tCUGYcgjp9t7EfHVjuH0wVvx2aX6eBOxmS/SjLsNDLNDXP0dhO0hzPvLU8xpI/mSP8
	 bq5ejiL3+7k57AIaPMfKm15OlTkiB48K8glblr1X15KBypFFAmLxBPEZxWqcVD1mk0
	 mPA2D4z5er9IyYoyaiSlRi8co9yFWaJ8ohdL/Ln8WM1K0RRoSbOZhRqJok6BgOVU0I
	 otAYzIe/YIsOdWeaiTr80Ndjebnue7ONUhmQ3xyGKj8N3jr7Uwmm0HJ3pX5eyYbpvf
	 3WwoqvXQbka4A==
Message-ID: <7146be33ea70ab1febe1ef0bc81ef74e.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240710201246.1802189-2-sboyd@kernel.org>
References: <20240710201246.1802189-1-sboyd@kernel.org> <20240710201246.1802189-2-sboyd@kernel.org>
Subject: Re: [PATCH v7 1/8] of/platform: Allow overlays to create platform devices from the root node
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Date: Mon, 15 Jul 2024 12:24:40 -0700
User-Agent: alot/0.10

Quoting Stephen Boyd (2024-07-10 13:12:37)
> We'd like to apply overlays to the root node in KUnit so we can test
> platform devices created as children of the root node.
>=20
> On some architectures (powerpc), the root node isn't marked with
> OF_POPULATED_BUS. If an overlay tries to modify the root node on these
> platforms it will fail, while on other platforms, such as ARM, it will
> succeed. This is because the root node is marked with OF_POPULATED_BUS
> by of_platform_default_populate_init() calling
> of_platform_default_populate() with NULL as the first argument.
>=20
> Loosen the requirement here so that platform devices can be created for
> nodes created as children of the root node via DT overlays even if the
> platform bus wasn't populated for the root node.
>=20
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

