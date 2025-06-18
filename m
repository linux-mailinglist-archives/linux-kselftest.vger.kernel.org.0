Return-Path: <linux-kselftest+bounces-35244-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3F7ADE043
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 03:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 367DE189BCCD
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 01:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D9316132F;
	Wed, 18 Jun 2025 01:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hticJJ4d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB34D155382;
	Wed, 18 Jun 2025 01:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750208423; cv=none; b=Q85TpOJUkTGGy5f2FyVV0dchioO1pkRRQyl+f5S4MCNNU6bsgGcyFjx9ntuusRhn0WnOps+OAJiB0q8Jy/+HRAM+f2i7cmHHEUoNMRpLjd8+eWQpk/lEVddYogKlYIZTFY7KVcr3ujitF2Nx+4ph0c/udrscC4YfgXwYlYG894k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750208423; c=relaxed/simple;
	bh=R30wj6lVsUukB/5V0YaHiWsAyeqatmoZoojwTEb5r18=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=comA7juSQcFDUycBB/+cMmdXJtrMuXk6+izXmBpUZyXvzZ11/qcxK2PEmYsAJPCi+ft9RTo+obff6o5TLgkevLpkkNuPE6bDdUqM4AExrxLNhHkH6s26mMRcd3csmu6bWoK+u3Jk1zbyFrFg3OwyQnrptmGUX4VuvXcMxl9pA30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hticJJ4d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7C9C4CEF1;
	Wed, 18 Jun 2025 01:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750208422;
	bh=R30wj6lVsUukB/5V0YaHiWsAyeqatmoZoojwTEb5r18=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hticJJ4dc1EMiMi2mnnT8USwJJkaSfZKjzB1pJwbGv2MjSTZIZkPGQ+nIsSNj+9gC
	 SJDGLjGTk+UVZJsJNKrldT5CIYv7JAPukyhLprey0odT3Xy6HGPGJLKttAQXxHf+Fg
	 fuP4k9LtkYCQ3CNIGUb9s5pVs+d1/c+QVrPrH31YKWQ0rC/Ih/knyk1EMDmLBoOdh3
	 EyANFeruVq4dZSaJPtN7drOpza6XSnenM0/FGLQzSpIRoF3B/hT9W3OnbkLWVCGZKS
	 F8M23+i1QW9qVJGBRzu7LcgamDgcQiPBHj8iY9Nn9R81VSIY8NXc7qAIwDHbCamtXE
	 x/LG1Ut9pCLWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B2E38111DD;
	Wed, 18 Jun 2025 01:00:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next,
 v4] selftest: Add selftest for multicast address notifications
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175020845099.3753357.3589246479890125144.git-patchwork-notify@kernel.org>
Date: Wed, 18 Jun 2025 01:00:50 +0000
References: <20250614053522.623820-1-yuyanghuang@google.com>
In-Reply-To: <20250614053522.623820-1-yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, maze@google.com, lorenzo@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 14 Jun 2025 14:35:22 +0900 you wrote:
> This commit adds a new kernel selftest to verify RTNLGRP_IPV4_MCADDR
> and RTNLGRP_IPV6_MCADDR notifications. The test works by adding and
> removing a dummy interface and then confirming that the system
> correctly receives join and removal notifications for the 224.0.0.1
> and ff02::1 multicast addresses.
> 
> The test relies on the iproute2 version to be 6.13+.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] selftest: Add selftest for multicast address notifications
    https://git.kernel.org/netdev/net-next/c/e74058f5619f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



