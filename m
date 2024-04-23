Return-Path: <linux-kselftest+bounces-8712-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB388AEA22
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 17:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D93992856D0
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 15:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAEC13B7A3;
	Tue, 23 Apr 2024 15:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iouqw4mQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4735F12EBE7;
	Tue, 23 Apr 2024 15:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713884733; cv=none; b=b3AyBeOlp3+g58tgDa/UooU2NboKC6DW47Aukq2sl68LOwCc5vHYQ02Shapnt+IpX5ewMyVm8NrKZbQvAlcyz5QoTaToiwMZvbGNFuGtN4CxR/lcwh07eRRqOyy6Jt/Xf1hVwj8AW9kpVV+iSlWXVuDLt0qMuATPI5RIdTnwlRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713884733; c=relaxed/simple;
	bh=rhecxeD2cGyz50/rzIf8qdv6WpuU26577Z2AHZCuTww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVZmo0FfgCdKkzQNBCH+I82WAZJYWnZ3qCUVbF04P1c313ZgHZaxT+6Hj+1E6lw8RVVo23VCFwotT7VQ5UsQ+3yRKBVAFbzgongK2kkLSktSBITf/U1UFb4Ji1OMiFHQX6bSvWUQ9Epo2bPBQBAdW9sHXCf2WwISDQiE7hKWEnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iouqw4mQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D6AC2BD10;
	Tue, 23 Apr 2024 15:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713884732;
	bh=rhecxeD2cGyz50/rzIf8qdv6WpuU26577Z2AHZCuTww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iouqw4mQZBJgFmb3LgZ98QJhyGYQvc+EInq511gxjyPNMtiaum2vNq2Bl+Mg4qHXk
	 Ens6L+4d3LJ7hd+zWQCJaLT5DrWIFqiasL0rRDPLSEGmWCxVidMINn/MTcMgW5Q2Cu
	 RGf/Kj7hBmo/dOIJI842Lz+RqBecO4Fa0SOseDLKHnYJY1Mn1/wiXg6lEOMPfVPv03
	 WFA65VhAAb12rWp+V2bSkIzQQF6bLEP6T7d3S743Jo0auOzhv5OawT9x5btL8kC5Yw
	 prpPY5s0WmWhGzwv2S5B6ZRNvPXnaWhn7II8vvJR1gvk6bWGd2Xzaj2sclfCpVFcZa
	 rh5X9WIN6nOwQ==
Date: Tue, 23 Apr 2024 10:05:30 -0500
From: Rob Herring <robh@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Maxime Ripard <maxime@cerno.tech>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org,
	David Gow <davidgow@google.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	kunit-dev@googlegroups.com, patches@lists.linux.dev,
	linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Saravana Kannan <saravanak@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Latypov <dlatypov@google.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 01/10] of: Add test managed wrappers for
 of_overlay_apply()/of_node_put()
Message-ID: <171388470076.215446.15104256542666415343.robh@kernel.org>
References: <20240422232404.213174-1-sboyd@kernel.org>
 <20240422232404.213174-2-sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422232404.213174-2-sboyd@kernel.org>


On Mon, 22 Apr 2024 16:23:54 -0700, Stephen Boyd wrote:
> Add test managed wrappers for of_overlay_apply() that automatically
> removes the overlay when the test is finished. This API is intended for
> use by KUnit tests that test code which relies on 'struct device_node's
> and of_*() APIs.
> 
> KUnit tests will call of_overlay_apply_kunit() to load an overlay that's
> been built into the kernel image. When the test is complete, the overlay
> will be removed.
> 
> This has a few benefits:
> 
>  1) It keeps the tests hermetic because the overlay is removed when the
>     test is complete. Tests won't even be aware that an overlay was
>     loaded in another test.
> 
>  2) The overlay code can live right next to the unit test that loads it.
>     The overlay and the unit test can be compiled into one kernel module
>     if desired.
> 
>  3) We can test different device tree configurations by loading
>     different overlays. The overlays can be written for a specific test,
>     and there can be many of them loaded per-test without needing to jam
>     all possible combinations into one DTB.
> 
>  4) It also allows KUnit to test device tree dependent code on any
>     architecture, not just UML. This allows KUnit tests to test
>     architecture specific device tree code.
> 
> There are some potential pitfalls though. Test authors need to be
> careful to not overwrite properties in the live tree. The easiest way to
> do this is to add and remove nodes with a 'kunit-' prefix, almost
> guaranteeing that the same node won't be present in the tree loaded at
> boot.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  Documentation/dev-tools/kunit/api/index.rst | 11 +++
>  Documentation/dev-tools/kunit/api/of.rst    | 13 +++
>  drivers/of/Makefile                         |  1 +
>  drivers/of/of_kunit.c                       | 99 +++++++++++++++++++++
>  include/kunit/of.h                          | 94 +++++++++++++++++++
>  5 files changed, 218 insertions(+)
>  create mode 100644 Documentation/dev-tools/kunit/api/of.rst
>  create mode 100644 drivers/of/of_kunit.c
>  create mode 100644 include/kunit/of.h
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

