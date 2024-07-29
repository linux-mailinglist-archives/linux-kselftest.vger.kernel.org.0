Return-Path: <linux-kselftest+bounces-14404-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F61C94012A
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 00:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61B3A1C21369
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 22:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A6918F2D7;
	Mon, 29 Jul 2024 22:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osqzTVr6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A46318EFE2;
	Mon, 29 Jul 2024 22:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722292629; cv=none; b=h7Tqa69lQyqc4QtoNP4FvvNhXawhU61Jn62BgSqm/6vGe684ksCF+7MHY/k9Pmtf5xwGNXBIVzfvOe1fe85LzJklOrlEpU/lc6Ei0vyXqG0uAv6jAOxk/ms82nJfMLJawFujlf+Tgp3hEdY0NfQQPuDdE40fNwzPXufAkxgizDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722292629; c=relaxed/simple;
	bh=8IYqgOjBiK5evvB8DTQRkGBtrOUfdrQWjrJtQZudLxU=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=bFuA3lPHN10f9qbW8c/46nZVzzhqHR/Q9REr0An5KW8eU0JTef+dBX9IfYPwy4gtFAz30+GtgL8Lc7c0yj1M+n4jY6D/EjXWH/wCbZgfKz4bAR/TJbdvu3xxzKl9WnKpCiPg5teupYNt0IHEJOsoLwST/NcbAR3/tfRH7WMsiRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osqzTVr6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D4FC4AF07;
	Mon, 29 Jul 2024 22:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722292628;
	bh=8IYqgOjBiK5evvB8DTQRkGBtrOUfdrQWjrJtQZudLxU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=osqzTVr6Q5iEdxrZpr/33qDw1B/oKca/Y7T+lDFGxZgpYo7zZSfnIV2zlY02/VGmV
	 imZZxIVHkOmDb7nU+v3FmGkctH6t7Tt8vQpCke6iNp5dOjSkpASgXsJvwxno/8tsg9
	 OZeWLNwnMpq+lx0V+T6XKjyTjuSQSfpmrQj+SBnaHJnTQR77lPDyrLE/eM0oEZl4yy
	 q65LM8M+FdE4PWMp2D/82ep9kIUhqXk0ynAhxVpcuz2iN+lWcVbVRzpmAWGWQKFDda
	 aNbDMN5lJJvfraFPP0OccQn1ozkiZ+s5HhQdhJr+9w1Vx62OOYP8DZi0CmjxwyqNW4
	 d2MRi5nmuMyWw==
Message-ID: <d0064808c62ff78efb5c5899cbfd4584.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240718210513.3801024-2-sboyd@kernel.org>
References: <20240718210513.3801024-1-sboyd@kernel.org> <20240718210513.3801024-2-sboyd@kernel.org>
Subject: Re: [PATCH v8 1/8] of/platform: Allow overlays to create platform devices from the root node
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>, Geert Uytterhoeven <geert+renesas@glider.be>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Date: Mon, 29 Jul 2024 15:37:06 -0700
User-Agent: alot/0.10

Quoting Stephen Boyd (2024-07-18 14:05:00)
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
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> [sboyd@kernel.org: Folded in condition fix]
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

