Return-Path: <linux-kselftest+bounces-11277-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E54A8FDAD6
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 01:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C8D6287181
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 23:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA45167DA2;
	Wed,  5 Jun 2024 23:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clvohwWg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF3E2AE7F;
	Wed,  5 Jun 2024 23:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717631271; cv=none; b=Qb3yZyS3ZUR6kZLFtr7jrTvGRQCMDQC407/2ominMjWMaKIGBlmFWwQzHDjJblLs+Bp3zC3o8KI3SjgFsPbJoGFRlp2OhfvMg+1iem8hl4rNcfmgMHciHzEodqjiBl3no9sAkZHSZEFoWTWuzdoPpnqDnpI5fzQQRcBRkW552zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717631271; c=relaxed/simple;
	bh=P0Dz9uZCXkyVC4xEsaJA7+X7GQ2s5KNP/lIbs99pgVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHBqBClKEV9fQFDfOfdDK5Hnqeve3DHGnQz+zxMvjGEDC10Vy9ZwTLJcitTyvJbuXt4GrWvihKHcv0azQTbuqfXd1QJ7FlqJsGm8Va3AEWYgQOKfgrsIWD99wvNR8qeuTJBJiQJYaOx+Nukl9JmNlNQG648SpSkIzKqn2dXx30g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clvohwWg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58FBC2BD11;
	Wed,  5 Jun 2024 23:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717631270;
	bh=P0Dz9uZCXkyVC4xEsaJA7+X7GQ2s5KNP/lIbs99pgVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=clvohwWguyxAER2uYj+UnseqBAsI95UvGSOj46jVLwJI6OX1zOKJqN3rrKtrpqrlE
	 Py7I6IBFsW7aJWoCOPieQoWmBGUGq5p7BjTHkxnxNimBXSitURG5GzeRlEpnFRmdsc
	 ka2TtwJSuWgqQnQ9WqvuqrBrJvPWij4CeSCi4ldIk4tuFFvtzKSBu2bA7WfHYABG9L
	 l3NJIwlRrO7Kk95I5PMKK2onfw7nr2bSgEQWp+9X6dpyVjysl57r1kMEqSL9vsEOeM
	 6/buXteFjsiaeUeq07wTEOfU5LWpONuupQV/K5p4/x6zDIb9qJrNtXqJT7sHqdNzi2
	 fv3Lhs0LQAxUw==
Date: Wed, 5 Jun 2024 17:47:47 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Daniel Latypov <dlatypov@google.com>,
	Saravana Kannan <saravanak@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-kernel@vger.kernel.org,
	Christian Marangi <ansuelsmth@gmail.com>,
	devicetree@vger.kernel.org, Rae Moar <rmoar@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Ripard <maxime@cerno.tech>, linux-clk@vger.kernel.org,
	linux-kselftest@vger.kernel.org, David Gow <davidgow@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, patches@lists.linux.dev,
	Michael Turquette <mturquette@baylibre.com>,
	kunit-dev@googlegroups.com,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 01/11] of/platform: Allow overlays to create platform
 devices from the root node
Message-ID: <171763126482.3452193.1706263155906513076.robh@kernel.org>
References: <20240603223811.3815762-1-sboyd@kernel.org>
 <20240603223811.3815762-2-sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603223811.3815762-2-sboyd@kernel.org>


On Mon, 03 Jun 2024 15:37:58 -0700, Stephen Boyd wrote:
> We'd like to apply overlays to the root node in KUnit so we can test
> platform devices created as children of the root node.
> 
> On some architectures (powerpc), the root node isn't marked with
> OF_POPULATED_BUS. If an overlay tries to modify the root node on these
> platforms it will fail, while on other platforms, such as ARM, it will
> succeed. This is because the root node is marked with OF_POPULATED_BUS
> by of_platform_default_populate_init() calling
> of_platform_default_populate() with NULL as the first argument.
> 
> Loosen the requirement here so that platform devices can be created for
> nodes created as children of the root node via DT overlays even if the
> platform bus wasn't populated for the root node.
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/of/platform.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


