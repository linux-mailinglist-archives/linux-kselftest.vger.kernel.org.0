Return-Path: <linux-kselftest+bounces-37957-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 979A6B1120D
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 22:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB7FCB03618
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 20:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0421E242D6D;
	Thu, 24 Jul 2025 20:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4QY9SNF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1C522D4DE;
	Thu, 24 Jul 2025 20:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753388000; cv=none; b=RYmRHoVTKLUwmMC0lHA+XGVqX9SGuaoZvzlEPIbDtVjdcKWEglqJflQo5CTiJT6wKYik43wy1GBaJU+9QXteQQ+P1P4AT5iPd1VPqh3HU2bJyIdXnYCRRLsxxm4mHKUJNrmDbrk13SFTteYpcSZw8RViFcnYS9oW4xBM7Q9EyIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753388000; c=relaxed/simple;
	bh=QZ/SJfkph6XGpIoL2Ts4pIh2C02IDx61t/tw1KT3zDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXILh8xMUiY9cPTaqDchXPTifzKKZm/DINSEkyJH9mXWONpsHsIqeSVine08J0doS6VsC1pnP0+sak7ESgvY+QrSPzEYXgCFBBB2OXgGwV0tJA6pRMqa7LsO1bSaaTm+SO+XJ4spaEyaXPLOTS3l/Q6N9gTrlOj6AnouIiXdCdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4QY9SNF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B496C4CEED;
	Thu, 24 Jul 2025 20:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753387998;
	bh=QZ/SJfkph6XGpIoL2Ts4pIh2C02IDx61t/tw1KT3zDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I4QY9SNFbs+VzBtfr7dLLqlMZbuPWhHXa/IFLqpJWHO/hdxfuatmshXF5ZVpm2G+g
	 ba9AmFjAXb6ouTJjeNnEsogG+6Lvdv5YmqPt1EJF59OX1Si4mTsXvj4eyuzBnfSvAk
	 gD4J0+Wx2eFoysoXaQhUoczxUL5yHuVijirjZZpsYuJ/S1Vlkx+L7Dj3ppQ6UieyKv
	 ZaFrQdwOg4WHX+C1LgRmlQFWn3Ttu5Q5e23OBPOgZGXELFrVJbENhe5EmkXy3dUG9e
	 q2N+mGOZ1O/B46kvfyL7V2EMQtF7KHi+gVKq/K+pcF7rAflknCpwRR8IkxnCxJ8Nlt
	 BAa151YGSJ5cg==
Date: Thu, 24 Jul 2025 21:13:14 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH net-next] selftests: net: Skip test if IPv6 is not
 configured
Message-ID: <20250724201314.GF1266901@horms.kernel.org>
References: <20250723-netcons_test_ipv6-v1-1-41c9092f93f9@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723-netcons_test_ipv6-v1-1-41c9092f93f9@debian.org>

On Wed, Jul 23, 2025 at 10:35:06AM -0700, Breno Leitao wrote:
> Extend the `check_for_dependencies()` function in `lib_netcons.sh` to check
> whether IPv6 is enabled by verifying the existence of
> `/proc/net/if_inet6`. Having IPv6 is a now a dependency of netconsole
> tests. If the file does not exist, the script will skip the test with an
> appropriate message suggesting to verify if `CONFIG_IPV6` is enabled.
> 
> This prevents the test to misbehave if IPv6 is not configured.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>

