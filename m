Return-Path: <linux-kselftest+bounces-48903-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3269CD1C27B
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 03:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E8FD303AAE1
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 02:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E587A3148C6;
	Wed, 14 Jan 2026 02:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubocRfUU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3023230D14;
	Wed, 14 Jan 2026 02:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768358623; cv=none; b=lNBCxt4HdeAtOYQwHdb1j1vTNhit+H9fnSjTb57w3u8C5/2CzNuaQhX66JSq+M7wmbVB0BWInf5yPEK28CZHzU7omyGWwIfCfLTJOPhEbny9XW+/tNeaK4sk+bhkvCInWMushu8qMFX42t80WECVJnmFElwnKWvRNVL8TFrfF3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768358623; c=relaxed/simple;
	bh=B82yhT/Xs8cX6q/6DEszXt6PG6EP4RUHWy6XtrKoXU4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fu3d0t/UsAmbX3kzzqX8nbmbEMcGYc0jCHyFczzqj0OvhVuClhU6WlUIYzy8ofxXx4o7+L5+ijuvGFDyEeap46E/4KFvAuFUVd2fLiaHFaefiBF/vzlf78ob7Dvn8a4nlTVy2yAU685eMQgb7Ei6r1bH9TwN4yRHn5dr6tZd0Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubocRfUU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D0EC116C6;
	Wed, 14 Jan 2026 02:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768358623;
	bh=B82yhT/Xs8cX6q/6DEszXt6PG6EP4RUHWy6XtrKoXU4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ubocRfUUtPXACTPLANWw8GpW7Wqeal60nf4Q5GP7PPhy3mbFrGw7jaFv1VZL7Yx7l
	 9L/TQzGaPtU5O2H0XLpRCCE90k3HLofy1AI/CXJKYPjWD+O1r67XZQ/ESvkfssx4ug
	 5L/CFAgePxY0cb9OqiPydFkNXKlZ2Jj8k5MQSIOBnSsub1eSum8AuxeXmjAkTPpy2Y
	 EaEsNH6RDYwJtC6HOKBdNfWmfEpezhKktHktpdQv/45KUFz8uCN05MoRuI78fZ/hK3
	 01M8w1jd0K9UAYY2nGrzFHP7OJ+zbYRclYHRVd8q99ObXDMdmmHdwyTTKf51pjHU18
	 DFnAfBDkryGQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2FC03808200;
	Wed, 14 Jan 2026 02:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/6] selftests: drv-net: gro: enable HW GRO
 and
 LRO testing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176835841678.2561636.12391509152675295422.git-patchwork-notify@kernel.org>
Date: Wed, 14 Jan 2026 02:40:16 +0000
References: <20260113000740.255360-1-kuba@kernel.org>
In-Reply-To: <20260113000740.255360-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, sdf@fomichev.me, willemb@google.com,
 petrm@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Jan 2026 16:07:34 -0800 you wrote:
> Add support for running our existing GRO test against HW GRO
> and LRO implementation. The first 3 patches are just ksft lib
> nice-to-haves, and patch 4 cleans up the existing gro Python.
> 
> Patches 5 and 6 are of most practical interest. The support
> reconfiguring the NIC to disable SW GRO and enable HW GRO and LRO.
> Additionally last patch breaks up the existing GRO cases to
> track HW compliance at finer granularity.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/6] selftests: net: py: teach ksft_pr() multi-line safety
    https://git.kernel.org/netdev/net-next/c/b324192e36ec
  - [net-next,v3,2/6] selftests: net: py: teach cmd() how to print itself
    https://git.kernel.org/netdev/net-next/c/ce0f92dc737c
  - [net-next,v3,3/6] selftests: drv-net: gro: use cmd print
    https://git.kernel.org/netdev/net-next/c/d131da6d7282
  - [net-next,v3,4/6] selftests: drv-net: gro: improve feature config
    https://git.kernel.org/netdev/net-next/c/8171f6a76b22
  - [net-next,v3,5/6] selftests: drv-net: gro: run the test against HW GRO and LRO
    https://git.kernel.org/netdev/net-next/c/d3b35898de02
  - [net-next,v3,6/6] selftests: drv-net: gro: break out all individual test cases
    https://git.kernel.org/netdev/net-next/c/fe074aaa5329

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



