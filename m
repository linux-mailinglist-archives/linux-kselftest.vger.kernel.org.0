Return-Path: <linux-kselftest+bounces-48794-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E503D155EC
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 22:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 474B53025DAF
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 21:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD123612F6;
	Mon, 12 Jan 2026 21:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JsLCPUDu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3C6340A6C;
	Mon, 12 Jan 2026 21:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768251671; cv=none; b=d1VT0DXFB7n5fvcpzldhNNNviP9eVaJUJJMWy2VIcz0N7j69BRSHI5sjFql1AkSRW7qsDrbFeMiegVtXhkekeznb6+0lJgbf+3RGQz+U413iUYh5XbAJLmEMiSOMAFt/nqU/EJXtu8xtF7GPvrPvBzL1BvRwiOWj96Xoxh9UYTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768251671; c=relaxed/simple;
	bh=zJmzqUAKVRmQQrSuIJa+yM//vnVtzmCQhnM2U7EzW+k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bbVOYeS3TihrDGp0Y80yqJu72sjpHjVnJGV32dg9F5d0e0wvn7h+kJhTBFQYUbNuyHVybkoXyb8N3fQ2c7zWJ5cQRjC5bxTZNNI29Snik69lFOk+pJTZycnNdK4zn4nTr7f34HCHxhYp+fyqO5jLwlAu8SrlyPhpmBYOjmL69R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JsLCPUDu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99461C116D0;
	Mon, 12 Jan 2026 21:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768251670;
	bh=zJmzqUAKVRmQQrSuIJa+yM//vnVtzmCQhnM2U7EzW+k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JsLCPUDuZxTcKcaC6V8IAqTMUDZJetzhRWqgmzrQUY21ujr2HgbZp8KZPm5Oi325+
	 AwlytYHeFMK47v8ocBQoMjYbuWdlPQ4yl8WTbW/l2pU6ikmScXIGU889VMuBAspsz1
	 ZeAYdYZhD5bwSyDt1HcQd/7EL80vud5rvdUc++673Re3Ir0ncW/vQwDJeD11aXFWG0
	 c/eECmB7bV9DZjLqC4fyveucrZS2IYU+7wK69Jov85qM+WNno6KGjEgy28RqRDzI1x
	 eB1xpFPdxdz0JsEyfu7zl6xrxFG1emJ7MUQjEAhOHGtkewVtXd3kFdZ8m1HSoNLtTV
	 dk3rKSqNjZqYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B618D380CFD5;
	Mon, 12 Jan 2026 20:57:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/1] PSP self test improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176825146428.1092878.13183078035784367751.git-patchwork-notify@kernel.org>
Date: Mon, 12 Jan 2026 20:57:44 +0000
References: <20260109110851.2952906-1-cratiu@nvidia.com>
In-Reply-To: <20260109110851.2952906-1-cratiu@nvidia.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 cjubran@nvidia.com, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 9 Jan 2026 13:08:50 +0200 you wrote:
> Changes since v1:
> - Used ifindex in psp_responder to select the PSP device
> - Merged the two patches since they started overlapping too much.
> 
> Cosmin Ratiu (1):
>   selftests: drv-net: psp: Better control the used PSP dev
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/1] selftests: drv-net: psp: Better control the used PSP dev
    https://git.kernel.org/netdev/net-next/c/9086984ff52e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



