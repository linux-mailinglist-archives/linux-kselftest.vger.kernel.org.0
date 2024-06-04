Return-Path: <linux-kselftest+bounces-11219-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BC88FBD89
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 22:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C87151C2098F
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 20:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A901F14BF9B;
	Tue,  4 Jun 2024 20:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s31lnDnQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0FD14B97D;
	Tue,  4 Jun 2024 20:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717534335; cv=none; b=JEHUmMdMkdxheaqBb4ZfwrJzl33JJop4HLS7qIdylWFo2C0POxdT3qofc0WdXewz7xVIXLMmv/iPVJM18eSPUIcvTWCOcoBZ5PuTg3UVqgbDK+QHZsILtIabMz67aa5Dw8OVUGYjkuGmiIaZA98hjftfPmoSzK8DWUEfi24e6X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717534335; c=relaxed/simple;
	bh=HQBS865jNCFeERnwf3D7e8dcgoXZ27Ob/udNNGmZ8Wc=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=dOwz13WNXF6B6TfeB6SgYPxOWEbw1AfDi4QWDrBtfkRbDf5OQIPWG9CNunGC6m0SRf+QK50obguebnP6YTvCeXGOlcs2zAHpBnimvkQdq4SsudIhwmIzaPNfAZ54mCxRJAZU6Yu/LPT3lmScN0i5pYZiGmz9L33BwPdif/uj9dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s31lnDnQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA22BC2BBFC;
	Tue,  4 Jun 2024 20:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717534335;
	bh=HQBS865jNCFeERnwf3D7e8dcgoXZ27Ob/udNNGmZ8Wc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=s31lnDnQ5n9lX1U/f/J+fwRHpU2VAxpbPVARiVpMPbXvdRFLxMTBoZqcHniixUnLN
	 8kQxtRTVo8GSV1D8/AL93eTkpdVKwJGBwR7nQjng6AleCLTHF2OrYwPqPYXx8LHA+G
	 AmGBnJJDXkyKx6LwNkc14b4A5gC0RU5PSZxGv/ceBjM3OD/rX8y/ntYW/YMRvtGIbH
	 EW74/UZXMb0E3q7PPJlKpOgE6YzJY6Gfg6NAih27K6sBK9ErFbet0BlHjEDnd/tjnI
	 E9Iqx269vlTdLhwyKchsaQTOZDSn8TfqBt6LL85te2B1HxwhQX04tFMcvPDIU6b01Q
	 eki5Kz1ZixbYQ==
Message-ID: <8ae81e535968e6a2b3f4e09ea1b7a54f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAL_Jsq+mGbW=4RbF+E1knvQco+5b1s7Tk8=2wyo9rT48Q=zkFQ@mail.gmail.com>
References: <20240603223811.3815762-1-sboyd@kernel.org> <20240603223811.3815762-8-sboyd@kernel.org> <20240604130526.GA12945-robh@kernel.org> <cce5a85e48f35f5ad5464a2443ca972e.sboyd@kernel.org> <CAL_Jsq+mGbW=4RbF+E1knvQco+5b1s7Tk8=2wyo9rT48Q=zkFQ@mail.gmail.com>
Subject: Re: [PATCH v5 07/11] dt-bindings: test: Add single clk consumer
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>
To: Rob Herring <robh@kernel.org>
Date: Tue, 04 Jun 2024 13:52:12 -0700
User-Agent: alot/0.10

Quoting Rob Herring (2024-06-04 13:19:18)
> On Tue, Jun 4, 2024 at 1:28=E2=80=AFPM Stephen Boyd <sboyd@kernel.org> wr=
ote:
>=20
> > And replace it with something that makes
> > the test vendor prefix opt out of all checking? How is that done?  Some
> > patch to dtschema directly?
>=20
> Yes, but I just added it for you.
>=20

Thanks! I'll wait another day or two before resending then.

