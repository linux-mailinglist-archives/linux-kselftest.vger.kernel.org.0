Return-Path: <linux-kselftest+bounces-32141-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FA1AA682F
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 03:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BC1D1BA5B31
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 01:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBC418DB19;
	Fri,  2 May 2025 01:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgyH82lt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BE518B47C;
	Fri,  2 May 2025 01:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746148200; cv=none; b=mRoOSstTTDjmd4HkxoqXfrdMD2UG5hEunm5lRRee7N/nFOVX/c0uoBTlL2ewWB/p1cB/CdAfjrdS5BtUqoFT1htY/HYHwl77IXNuxboR06vMdEdZe/tRBpX4GcIErHpodv7R7EuiPKaqCr6OTGlQLUuzkqZ+Bvmxe5rF/U6ggE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746148200; c=relaxed/simple;
	bh=i9k+cCnZXIGAo9OsKx/x46ZTrn2NhHL72VnS/sGe5ys=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dG5be23XFjZ7wfuhf3fYMw4LCPY6iHtaMX0mzNR5xjKsOKwiCWf+b28+NpAewakWLQfCzrSbxXAxZYN9DOOWw7GGjdJDAogK8R4c5s7WxRk3HV3rgj9DLUp6Z0J3j7WIzpkhRFMDAGsDGjxnmG3G1U2wsyf5bYDHSq8dXeBbKWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgyH82lt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98CBAC4CEE3;
	Fri,  2 May 2025 01:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746148200;
	bh=i9k+cCnZXIGAo9OsKx/x46ZTrn2NhHL72VnS/sGe5ys=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dgyH82ltRAW5HbMwDnHDHz7bj9Vr/MIUjc5RtmG3sjys3eVXrZPYWwRwI3C/j+9Nh
	 GeisRF4lWKe4tCz1425M6H0jYP8gO6XxPa2DLyjX7z+7dko8UK8YcQq9WT3islUFv5
	 Twg813sDithcOFOlXeUQ7Qiin2xtHLp91VAzEhO6Tvweb7qkW9qyo5eRj322KRCW9l
	 wDW5X5xVHGY3b0yI9zfT8MVNTPyc5WUFooVcxuiyW4KUxGGaNeEGezPwLoe3t5VKI3
	 CFKnccUDYbuyE3tDUUpcOA8YCLbUDryLcqHEBfbaDw2REX8Yx+XdMlJX0fuYBMGm7v
	 4QoNSHBvusyOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD5F3822D59;
	Fri,  2 May 2025 01:10:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] selftests: drv-net: rss_input_xfrm: Check test
 prerequisites before running
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174614823950.3123530.15874122878454806894.git-patchwork-notify@kernel.org>
Date: Fri, 02 May 2025 01:10:39 +0000
References: <20250430054801.750646-1-gal@nvidia.com>
In-Reply-To: <20250430054801.750646-1-gal@nvidia.com>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, noren@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Apr 2025 08:48:01 +0300 you wrote:
> Ensure the following prerequisites before executing the test:
> 1. 'socat' is installed on the remote host.
> 2. Python version supports socket.SO_INCOMING_CPU (available since v3.11).
> 
> Skip the test if either prerequisite is not met.
> 
> Reviewed-by: Nimrod Oren <noren@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] selftests: drv-net: rss_input_xfrm: Check test prerequisites before running
    https://git.kernel.org/netdev/net-next/c/c76bab22e920

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



