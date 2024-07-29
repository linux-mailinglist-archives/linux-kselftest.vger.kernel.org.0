Return-Path: <linux-kselftest+bounces-14412-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD6E940150
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 00:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07FF12831E7
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 22:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF5D18FDB4;
	Mon, 29 Jul 2024 22:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TeMSztOa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBB518FDA7;
	Mon, 29 Jul 2024 22:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722292687; cv=none; b=ZunyCXdAKRQ5EHCiUpTLYdQhnrx7tC/ITbCiaWdPFThqASFmbq16/BCZLh16YCJUoJi4XoPrFng5k/1ZrmUwx8fC+gsyL36ViprMVS3OR1AknNwLvuV+w9fs07ApzuNlCuwEUzy0HuU7vXuTdr4Fs7aroTT2RTyItXxu9NNFWyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722292687; c=relaxed/simple;
	bh=64QUheo9mG28hqcNZIz4J+iNinG8AjvsgG09dnMrB08=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=fugwJw9iW4z/CwXQJEQdeXMPUVCkpN8sq2j93cwtd+Lk6LtbbBdj26Dd4C1F2LuSmlUzADOoPMLYPMYXcAQykX8WObMkjglVYFJ7DiKh55rguRRXVNk9vf5TY8R01TImn8wMwdqJtffSsJsFZ3pRXduiq2W01wc10/BHHgjwEPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TeMSztOa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CA5C32786;
	Mon, 29 Jul 2024 22:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722292687;
	bh=64QUheo9mG28hqcNZIz4J+iNinG8AjvsgG09dnMrB08=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=TeMSztOaAoVpTzdfkNqcmylxw7SB1AimAeQTz3ohH8wcCDTKZVvoi+sUvQH/lGv/+
	 /Grpdjo+nHJq5ciOCHB67R6wh6os5cbbPunGBPcHoHjWT8I1pFEHwmelcudDU3iNna
	 RBIPeH8W7XDvHNDP1l2R6mwGvMIXM80wcaheQuyTKOorkm2MXfbYbBlxgarKyLGbwz
	 a/lfoG/x2c/vFOGBFkH46obTbe9liudXNNDgkiFFlJyFTIbT37ggIcHpEkgpUW+/Kv
	 /4WPpvHpVGlDA6Cks3QiGkyb8oFcA/anCikviM5mNA286o+62kdMtJuS4H5KOmyG6Q
	 jLgty3l/GOyZw==
Message-ID: <4340edec8e6858a7d4add4be17de7790.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240718210513.3801024-9-sboyd@kernel.org>
References: <20240718210513.3801024-1-sboyd@kernel.org> <20240718210513.3801024-9-sboyd@kernel.org>
Subject: Re: [PATCH v8 8/8] clk: Add KUnit tests for clks registered with struct clk_parent_data
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>, Geert Uytterhoeven <geert+renesas@glider.be>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Date: Mon, 29 Jul 2024 15:38:05 -0700
User-Agent: alot/0.10

Quoting Stephen Boyd (2024-07-18 14:05:07)
> Test that clks registered with 'struct clk_parent_data' work as
> intended and can find their parents.
>=20
> Cc: Christian Marangi <ansuelsmth@gmail.com>
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Reviewed-by: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

