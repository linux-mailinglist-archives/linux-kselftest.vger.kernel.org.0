Return-Path: <linux-kselftest+bounces-4001-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2BF846DCB
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 11:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC4EB286C6F
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 10:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B781C7A732;
	Fri,  2 Feb 2024 10:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXLn72jk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD3578695;
	Fri,  2 Feb 2024 10:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706869227; cv=none; b=EydqtlK1UPzgVQiAIKY3carolbHMyBe6Ao7phslQY08wDCGSN/JvMWIhRzZgZo83gZ4+W5G9jHXUNQRAH33x0mOm8cDftzdUZlvBwHD1kr1dhSxjrrnOjLl4i1Zb8Be6WvJTooKU/gfvr3GcH5T8d2r7AzyBBS/dIq/amXwoZZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706869227; c=relaxed/simple;
	bh=sxNe/TDVnItSokvWeIOnsfnu4Mu4v0Am2l/TSJ5DMEY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MVPSVPqIGxjyMFCtXvPrmJIUzOLgIqr0STpnI/kO7i4P1mLPvUINRTbg69zC4Pb1gw+wM9EM558CXL7kVSA5lowsrsWN5QfxSf7ovGRDH1IY9k6u9AP5UCzUWCZxMvj3vdylF7BsYpVdfF8jd1nwHkbwAr4wF3RY4lAQ7f4/DsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXLn72jk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1383EC433F1;
	Fri,  2 Feb 2024 10:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706869227;
	bh=sxNe/TDVnItSokvWeIOnsfnu4Mu4v0Am2l/TSJ5DMEY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pXLn72jkaZ18x9sc/f9v9jhRdaue9RQ3BM+ZPGuEWt9R9L2R7kenyXCz6nKjh1fC/
	 oasmWQxq9tp/hquhWO3yoJF58ftLsYbGhmhcCDKAY/7bhpLTAG8gYXRA4E+jk7dadW
	 k5ThxaT9rO3EZK3E+7lMuIX3mNGBWNN8Ee8Xzj30sZc6K6LhCbu/3MI/iuVzIF99eY
	 UcTihdh7GXDY0dj0Fug552fgKmm87INHdQPYaY6k7ltEUsJhbP1O0r/cn/Q6lZIYdg
	 U21zmZBBuiwVslb2ZSTgLOKM0aylQAyXTJSv/AFHPuqR1arf/xtHB3VP06bOqaBMM2
	 I4Oh300JtSSIw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC068C04E27;
	Fri,  2 Feb 2024 10:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: openvswitch: Test ICMP related matches
 work with SNAT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170686922696.24154.1379169151716970298.git-patchwork-notify@kernel.org>
Date: Fri, 02 Feb 2024 10:20:26 +0000
References: <20240131040822.835867-1-brad@faucet.nz>
In-Reply-To: <20240131040822.835867-1-brad@faucet.nz>
To: Brad Cowie <brad@faucet.nz>
Cc: netdev@vger.kernel.org, pshelar@ovn.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 dev@openvswitch.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, aconole@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 31 Jan 2024 17:08:22 +1300 you wrote:
> Add a test case for regression in openvswitch nat that was fixed by
> commit e6345d2824a3 ("netfilter: nf_nat: fix action not being set for
> all ct states").
> 
> Link: https://lore.kernel.org/netdev/20231221224311.130319-1-brad@faucet.nz/
> Link: https://mail.openvswitch.org/pipermail/ovs-dev/2024-January/410476.html
> Suggested-by: Aaron Conole <aconole@redhat.com>
> Signed-off-by: Brad Cowie <brad@faucet.nz>
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: openvswitch: Test ICMP related matches work with SNAT
    https://git.kernel.org/netdev/net-next/c/094bdd48afb8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



