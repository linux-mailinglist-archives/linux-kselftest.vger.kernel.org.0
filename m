Return-Path: <linux-kselftest+bounces-8713-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA93A8AEA31
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 17:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C5B1C22563
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 15:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9815E13B7AB;
	Tue, 23 Apr 2024 15:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQBQOBcU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F8419BBA;
	Tue, 23 Apr 2024 15:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713884852; cv=none; b=aPHKOXAyU7YqbeSz8xD0f6Mqi7uGY1DRY9GGYWJ7TvpbsK/F/PitkrZ4eFNqRY4lEUKFPSTFP/BZ4wM/01bTuS90maQD1mc9kw39nIVqGzZhbv06b5v739VOJ5ZjG+jX4T99LnwmgAggs0bhWs6YOhlmu6rEWp/a+PAcfmTmsf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713884852; c=relaxed/simple;
	bh=AKBMobjYQ6x2TD8CDoee3DGcDXyOQQFoITtQ9pcukvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3JPs/I4dVDuIk1SXkIWbB+D+bEd+sBDylWj+taQY1OBcB54jzv0ohAHY7CF5K6i1Xp+K3Lzxd79+cO+qxLf4/J9O9cAqeyrHl12ElTw0cpgskJHYgyUEA6uxGlf6+qQPqjsCFaT/nMWZIwhDoWAyLildsgVNPqyJCBrZafeNYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQBQOBcU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B495EC116B1;
	Tue, 23 Apr 2024 15:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713884850;
	bh=AKBMobjYQ6x2TD8CDoee3DGcDXyOQQFoITtQ9pcukvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kQBQOBcUB6DxFRkYRr4oNjwNyRODpE0Md48n7Zb5oTuNNRbDZF1TEs9RIkhLA6W1l
	 DSgBijpsweTdM2j/Dfr+WbeASNgDWuKI+e02uweWMyuuokfPMtmRWSNCJvydqf2WB7
	 eOIS0r7XygtdDHoNheYn+zXRtQLN+k9acEerv0Zu8DoXhV+BZbMJS7RrOcCblXz+ED
	 N5KIIWqVP65av1QQnC2YMgPNcHG5Un82QZ7hF1amdgrDpC7Djd95mFyTridA8TUi0X
	 2sXEs3ag78ZSlhgUTRma6tbt7t/BuuBmUa3OBQiOisRU1iGBpa8Cvzux/5OwEmX2nR
	 TFnYqAXwI1BfQ==
Date: Tue, 23 Apr 2024 10:07:28 -0500
From: Rob Herring <robh@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, devicetree@vger.kernel.org,
	Rae Moar <rmoar@google.com>, patches@lists.linux.dev,
	kunit-dev@googlegroups.com,
	Brendan Higgins <brendan.higgins@linux.dev>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-clk@vger.kernel.org, Daniel Latypov <dlatypov@google.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kselftest@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Ripard <maxime@cerno.tech>,
	Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v4 04/10] of: Add a KUnit test for overlays and test
 managed APIs
Message-ID: <171388483531.238610.10285255210612947227.robh@kernel.org>
References: <20240422232404.213174-1-sboyd@kernel.org>
 <20240422232404.213174-5-sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422232404.213174-5-sboyd@kernel.org>


On Mon, 22 Apr 2024 16:23:57 -0700, Stephen Boyd wrote:
> Test the KUnit test managed overlay APIs. Confirm that platform devices
> are created and destroyed properly. This provides us confidence that the
> test managed APIs work correctly and can be relied upon to provide tests
> with fake platform devices and device nodes via overlays compiled into
> the kernel image.
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Daniel Latypov <dlatypov@google.com>
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/of/.kunitconfig            |   1 +
>  drivers/of/Kconfig                 |  10 +++
>  drivers/of/Makefile                |   1 +
>  drivers/of/kunit_overlay_test.dtso |   9 +++
>  drivers/of/overlay_test.c          | 115 +++++++++++++++++++++++++++++
>  5 files changed, 136 insertions(+)
>  create mode 100644 drivers/of/kunit_overlay_test.dtso
>  create mode 100644 drivers/of/overlay_test.c
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


