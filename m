Return-Path: <linux-kselftest+bounces-13747-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19AB931ADC
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 21:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F184B21703
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 19:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC5F1369A3;
	Mon, 15 Jul 2024 19:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uN7f9W8Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097968120A;
	Mon, 15 Jul 2024 19:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721071499; cv=none; b=Nqmh2SPnWf9nU90AZk78axYDxokPZFSlL19zD1YQEDpQpmbIsbGoKOb6fbumBg007pr0GmvB7llEMi5KBE6VPDtV4AmfO2bFJ61p394pp2+SLUEs8pgcEDhbmKWql9QRms/QRtxswD4q0SFR/50yqoCs0IBVKzkI45n8UJdto2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721071499; c=relaxed/simple;
	bh=hbNNEq4BmW2n8sUaZV1ATt09M+CcNJZLHoBPIHfi+Vo=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=WcUGIXR5xVcOMLavMzDouV4b8zcXYBrOkJ/2gUEApIN0iFy6UlkFE5QKuFEtjooLRnZtFjXS33hW08WRIpvDC1gIcAYnkXO136YWwim1zduT+tfcRLcOUDGgPqqbZkc+433o/KtvL59rilcpMCyygckKPL2bCLqcOCqkl6D/xdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uN7f9W8Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9862C32782;
	Mon, 15 Jul 2024 19:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721071498;
	bh=hbNNEq4BmW2n8sUaZV1ATt09M+CcNJZLHoBPIHfi+Vo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=uN7f9W8ZUalxXxVQtnP20F0krY5i8b5JLizCAvvc4ef55+LKzCHVgT/74kEmMI3ev
	 gyuq1w/oWhQqn1Mu/nVGnB56JntZ8wlZ7y92VVIPCl5GlagfGvs4SDdiXCdszcRADJ
	 z5mynSoiRksS3gkPqJAXLmF5bbkrYaXiYTiZjaZsej/87002Z9RAR+BwQHphqht8y5
	 Xx4m9KlsPvwk88JhyjCxPHjcYZxx0I3w5f4gqKKAolU9QiGUzWSO6D/V1woqLGH8iD
	 muCbDT1uJUh+rBT6un8J2cw5pcrrP6F1ewl5ldVZxkLKs6v9K6Sp1VTJ/AkRyFC7j/
	 YND/EmrEMWQHg==
Message-ID: <91e0909e25d3b95abeef71c0b6457918.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240710201246.1802189-4-sboyd@kernel.org>
References: <20240710201246.1802189-1-sboyd@kernel.org> <20240710201246.1802189-4-sboyd@kernel.org>
Subject: Re: [PATCH v7 3/8] dt-bindings: vendor-prefixes: Add "test" vendor for KUnit and friends
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Date: Mon, 15 Jul 2024 12:24:56 -0700
User-Agent: alot/0.10

Quoting Stephen Boyd (2024-07-10 13:12:39)
> Add the vendor prefix "test" to reserve a vendor prefix for bindings
> that are purely for testing device tree code. This allows test code to
> write bindings that can be checked by the schema validator.
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: David Gow <davidgow@google.com>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

