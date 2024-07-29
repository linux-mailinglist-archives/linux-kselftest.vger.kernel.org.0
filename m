Return-Path: <linux-kselftest+bounces-14411-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AFE94014C
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 00:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F2A8283303
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 22:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B3418FC97;
	Mon, 29 Jul 2024 22:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swlXnShH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CDA18EFF8;
	Mon, 29 Jul 2024 22:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722292678; cv=none; b=mTpKXbXMgT+zBsh53HQUkqN97yW5uJRU/2Dhvw4viKyQ3qGjFzPra3bfvqBOV+nbKntLd8huN5HeMJmyGn48dGEzDx9Wt2enGqLVwVnrF42XBhq8/ui479U0ETkWdmUFZK6XuFVQzdiLQrYw/JUEQfweY5bV0t/mw8XpYU9MLjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722292678; c=relaxed/simple;
	bh=eYggHvXxighazpD2Muzb6dVE6lAq/PA4AKTc7cBzs0A=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=q5Ck5sldrWftwZMOz9fPqbUUU29P4dsn5gVzvuOheXkjXL8Q7GvR1ykrYxOmhy3wmNuYlHALC22GzL7rpXeV3HCfLF1NWXPOBp5pO71uEfc37eG+dTuVB7B7EdsfOE5OzQ/f5havXlwbg4eGqIhQs0/8RfYYzMrwhEPCwZa+ekU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swlXnShH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381CFC32786;
	Mon, 29 Jul 2024 22:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722292678;
	bh=eYggHvXxighazpD2Muzb6dVE6lAq/PA4AKTc7cBzs0A=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=swlXnShHC8R4aMMb02p1/b1BD+D4YICk5utmSym9AyBtDz62ruMzMZdfqUYoyV0lm
	 1HKHCZYmzg8P3DiF/v8wplwrpsEAVmlEujt0cIl3afJDxkmv+RHEa7fEAaQ2RwO83N
	 o87UTK1/1cw41ahUGlEAfbmLIuBlK5HTlX5Ci5nPwrOwjj8AH3xOvtVSVALoz75zp0
	 TIC9/fgxUoBRWnQ3onXOSemYL5hEtHChqrQqZeSffgZh6eRQKL9rOLE2gftB0fuX/9
	 VYmGtnh7tIjnU/5GnTRg5xktV36V1o2w+tOSsfv8UUOp6yBO56V2+cXtql0fWL5R94
	 sNDV6cBS4cvKg==
Message-ID: <30a69ca80c659cb6fb454db137c1743b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240718210513.3801024-8-sboyd@kernel.org>
References: <20240718210513.3801024-1-sboyd@kernel.org> <20240718210513.3801024-8-sboyd@kernel.org>
Subject: Re: [PATCH v8 7/8] clk: Add KUnit tests for clk fixed rate basic type
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>, Geert Uytterhoeven <geert+renesas@glider.be>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Date: Mon, 29 Jul 2024 15:37:56 -0700
User-Agent: alot/0.10

Quoting Stephen Boyd (2024-07-18 14:05:06)
> Test that the fixed rate basic type clk works as intended.
>=20
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

