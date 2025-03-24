Return-Path: <linux-kselftest+bounces-29698-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57457A6E352
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 20:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CF991895EAF
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 19:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3224A19D88F;
	Mon, 24 Mar 2025 19:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezBXWM2G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0651619CCEA;
	Mon, 24 Mar 2025 19:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742844002; cv=none; b=OeDzRjeq85h61TBGxi2NQggBsC6X7hoHf7n5sDbzjg9nPsu7IG7dSxPhp501TThGSVm/g+/H1GYcI/qhvy8szVwzDK0qROi9O5mB/J1PHtbIpgjWI/hq/Zhk9jgEERq2jQJgzvicYmlnU/UppzM2ui/Gl1Tt3Hqj5vDcZ9r95Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742844002; c=relaxed/simple;
	bh=cGarqQM7eN/YzTgeHfhkcgOUGMSBEhE4Iw6fsmgMAOE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GY3eILdsRnpRrERKvOszCuQzurJZtYdCrunqooG+KqB3BJN9BXYos549fJJs9X6qKkirIMZNB2rn6G1pjwOy1t4LfAAmjw5dil3ZbOV1x+4jVQXEyIylAkVQI6XW7RM35+Wm78Xjof9qjiBwcoAVEW3orqgusxpOA+L8ZyHSb/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezBXWM2G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40220C4CEED;
	Mon, 24 Mar 2025 19:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742844001;
	bh=cGarqQM7eN/YzTgeHfhkcgOUGMSBEhE4Iw6fsmgMAOE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ezBXWM2GuM2Ver1fZfrxZh/EgtY57ROZcahDj4MYr9fXMKLIqXLxDma4CCE9LAkiR
	 mvJWlfP8bNdl8MafiVOTkRCpG36K0kg52scPowN7W7AUjUq9O5uDeFIgd19Hf+cxte
	 tzACTJzQMrZFXO3B2qYJvnZ+b7hb55ToaHqg69gvLahxVwpRoVPiWTZJ21Ljk3J0TZ
	 j14+zDliruG145yuPZlYY4HvfDNstuuzDXxEimhTMtCuJYu2r+9yIa/l7+ybVfdKlL
	 lKtbBKFW1e5UgrWICMI7H3NOHp0R3KNd3rav4aadQ1898LVdWePe7XcuD+QtHl40Zl
	 CZL5MGQrNRktA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B7D380664D;
	Mon, 24 Mar 2025 19:20:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 1/2] net: pktgen: add strict buffer parsing index
 check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174284403701.4140851.5482210239740401759.git-patchwork-notify@kernel.org>
Date: Mon, 24 Mar 2025 19:20:37 +0000
References: <20250317090401.1240704-1-ps.report@gmx.net>
In-Reply-To: <20250317090401.1240704-1-ps.report@gmx.net>
To: Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, dan.carpenter@linaro.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Mar 2025 10:04:00 +0100 you wrote:
> Add strict buffer parsing index check to avoid the following Smatch
> warning:
> 
>   net/core/pktgen.c:877 get_imix_entries()
>   warn: check that incremented offset 'i' is capped
> 
> Checking the buffer index i after every get_user/i++ step and returning
> with error code immediately avoids the current indirect (but correct)
> error handling.
> 
> [...]

Here is the summary with links:
  - [net-next,v1,1/2] net: pktgen: add strict buffer parsing index check
    https://git.kernel.org/netdev/net-next/c/7151062c297c
  - [net-next,v1,2/2] selftest: net: update proc_net_pktgen (add more imix_weights test cases)
    https://git.kernel.org/netdev/net-next/c/3099f9e156b3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



