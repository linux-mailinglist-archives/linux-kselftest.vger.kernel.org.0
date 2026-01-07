Return-Path: <linux-kselftest+bounces-48373-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D61F9CFBC04
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 03:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5CD6301897A
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 02:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1591221F39;
	Wed,  7 Jan 2026 02:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kkr0cuF3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42E83B2AA;
	Wed,  7 Jan 2026 02:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767753213; cv=none; b=Sdah9G8kT2doNpiwQk1lmEErbBrjucAYc2Vwja93u3Yj6H7a2d7Ypcqcxy8MvzfPe6z180n46HxqKSX+OW2m90dBE7ybw1h/8QcZJmV3gUQ0b8VbZtEOdGbNy9Qu+Qp4UYS1/yPhfVWRttj2Xw4U4/VF8PtbA/OzyBwvu0xg9M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767753213; c=relaxed/simple;
	bh=MCUUIdXCDhCt4LmsTYV2Uss60dFo7CxTbWBVPSNDhdo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KxpGqu3eVcAfzzk7/I6/GjorQfSjSBaPDPN1jyU5Cdfb7gq++0OHMw9CtidGfwu/iaiy/lCGzSKlz+ErX1G1QiXDHDXnfYva4clUxVl2cpPCzBj9WKQ5vLH5HMId9g+QmCc0ZAwswrpMPlOCX9yRl7xQzpYsgPQbdY1oTpF2Qb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kkr0cuF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F957C116C6;
	Wed,  7 Jan 2026 02:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767753212;
	bh=MCUUIdXCDhCt4LmsTYV2Uss60dFo7CxTbWBVPSNDhdo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Kkr0cuF31PJ4cqyvx1vPoHO0yf0hlMsG8CInERPQeSx37v1uQoTLLlBG3kL6/d7wp
	 8J0PTsQpekCQ5iUMBvnX3Zz/CIFsc2qXz/LfWCgiYCmkTxuYSLdpvIIvL7pFgpQAH3
	 V/xxhlOT2wBRYwkRuOUXCt+q5MbBui0q9vonaBW7Mk1LM8ztSAx4muIxEvF/6zEWmf
	 IY5d49UnlzYvvkrsN76Olr5RfLYhWV4Gyerh7Ly6qDl5Cl5rU/eUZOc4t0MoV8CisW
	 Nc3PSaDC2lkzXqfxTpScE/ZuwjEAhe4P2t6PiLQWPv8MAFs3EKT1IVzoX4xWdVQqkx
	 NwSYQbZBzdlVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5AB3380CEF5;
	Wed,  7 Jan 2026 02:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2] net: netdevsim: fix inconsistent carrier state
 after link/unlink
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176775300954.2206594.1826844025995318778.git-patchwork-notify@kernel.org>
Date: Wed, 07 Jan 2026 02:30:09 +0000
References: <cover.1767624906.git.yk@y-koj.net>
In-Reply-To: <cover.1767624906.git.yk@y-koj.net>
To: Yohei Kojima <yk@y-koj.net>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, leitao@debian.org,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  6 Jan 2026 00:17:31 +0900 you wrote:
> This series fixes netdevsim's inconsistent behavior between carrier
> and link/unlink state.
> 
> More specifically, this fixes a bug that the carrier goes DOWN although
> two netdevsim were peered, depending on the order of peering and ifup.
> Especially in a NetworkManager-enabled environment, netdevsim test fails
> because of this.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] net: netdevsim: fix inconsistent carrier state after link/unlink
    https://git.kernel.org/netdev/net/c/d83dddffe190
  - [net,v3,2/2] selftests: netdevsim: add carrier state consistency test
    https://git.kernel.org/netdev/net/c/75df712cddfd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



