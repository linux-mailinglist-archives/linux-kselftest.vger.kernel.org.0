Return-Path: <linux-kselftest+bounces-14407-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5022294013D
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 00:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 050241F22B05
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 22:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA90518F2F6;
	Mon, 29 Jul 2024 22:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ub3RJpr6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7968618F2EB;
	Mon, 29 Jul 2024 22:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722292653; cv=none; b=ADFHvcGg9narh0MG3+oUQF2O1RuwHAjuHlr7eQ7Uvz/AGrBR1gXlgFtdfTtgg1H42C7JNNCum5I5Je9X9gIByUH+exuKmq0qpqbuPLr0MKNvLKHbRU//w3+9HzmWu8c4QbRb0gNK0cKSsmkSuW7n+2GTm7mAhMGCutUd61+jF90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722292653; c=relaxed/simple;
	bh=vrwLUBu5A8/eYxSGpMfELEQ3sckpVi5r/TFZT+9Vn8Q=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=QZ8W2QHycLmG+/TG4ixcQV4/KLDAdR0Fg7WAVdb4SmWf5hBYHKinKdRcW/plTu0/95qmKTNXOWvCrvb27ffencLtTNUp0pN6277+YIb5QdpgaCGIanMDrMxM+cBVPaeQjJiXt4GAetJJtozk7drYiEic6b6DGpEoP5ZLgaODYhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ub3RJpr6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B74C32786;
	Mon, 29 Jul 2024 22:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722292653;
	bh=vrwLUBu5A8/eYxSGpMfELEQ3sckpVi5r/TFZT+9Vn8Q=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Ub3RJpr6jo3JoYebqNqB1tCPFBjCSPZ38PI6Qa1nYQJnTf+/rpvZ8MdR4+k4QuCz8
	 7jZ9iP7swl87vK8iw9tSq480uuqNS6BsV4BMIgL0iarIlJ/joYm6/+1Lmg33UqMYRO
	 bc+qr8OCgFAauameOAcOYYuUKGhtUcB2dqP2f/V5vf0BwUV2DZqM1GfNkXMUzufbgx
	 s6aX0aA1gYgegYLhrbldieQq2hRNYPssyJfOSQ64FoRs4Dnxg9ti0SV0ufwOOzD+wE
	 BsVW4XSeWPoErmVdBqTB6lc9cIju9FHlUN/RN+uCadPRQBAwvoVFu9+pS1XSotprea
	 wdMvYYpM8dSKQ==
Message-ID: <d44ead4a178fb029d4239d30c99c44bc.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240718210513.3801024-5-sboyd@kernel.org>
References: <20240718210513.3801024-1-sboyd@kernel.org> <20240718210513.3801024-5-sboyd@kernel.org>
Subject: Re: [PATCH v8 4/8] of: Add a KUnit test for overlays and test managed APIs
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>, Geert Uytterhoeven <geert+renesas@glider.be>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Date: Mon, 29 Jul 2024 15:37:30 -0700
User-Agent: alot/0.10

Quoting Stephen Boyd (2024-07-18 14:05:03)
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

