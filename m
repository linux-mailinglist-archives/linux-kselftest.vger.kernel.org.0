Return-Path: <linux-kselftest+bounces-16312-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CBC95F61F
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 18:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D303282A01
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 16:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF51B1946B1;
	Mon, 26 Aug 2024 16:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nasRoOMJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CDD18858E;
	Mon, 26 Aug 2024 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724688632; cv=none; b=Ilj+fUMiYlqFSrTCwngyz0/JpAEOhMuUuS/sXtq+Ybez6/tnjw7KdTBI3WZCeMxFC8AOeZ7qLL6JfMare3x50GiIPv0P6SZpjvFhYsyLkFoHaLqebkAOuwjRvcDkB9h8rPDfDJm3e4+54Y7C9T3ZEB+fSkncscfRRBj23r/kG7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724688632; c=relaxed/simple;
	bh=Gtmt/VyuBoYN4UaJVCGTPSHAav6dtM1HQ0ut3XXbVJ8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cINRwsyyFcfuzlJtDPLh2Dl1+oZE37nF/UIlUM+irJs7PM1NqEnD3UFAdsUOwrIjz7007zEzB5kd/xsHnSN1Vj5zTW7goX5ZxRc94CWPx5CyfjQvhTJLkRG7MjyA1o0D8fQeSUg6PDaqVqb4em8Nq9GiDVk+uZjnlsCGfrndKRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nasRoOMJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36313C52FC2;
	Mon, 26 Aug 2024 16:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724688630;
	bh=Gtmt/VyuBoYN4UaJVCGTPSHAav6dtM1HQ0ut3XXbVJ8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nasRoOMJCNbQxE/OB45ox9bSNZJvI08gCmfS6Qe1gtyapxgYp/+QukwkspVFS7v/u
	 DCYnFAl0n0MB+M0a/EHIXMgZNIuIFkMMciX0+3Nir9fI6cgpVRsJ++zHVIyylhpGag
	 saKtogYjwpBX5tmaYExo70aCqtSIQvgp+oJIvkIxtiVU9nZgP2eSqV6inwKfvsMjM6
	 C/puQ0FIshlIDQz3nQ0eb6OXeungwhP+duUIO4mJYKi/rKsP6i98T1YJ+wt2Wl9DrO
	 WqetV3WDfmXpiecaKXtPxbkVD5vXGbATLqB/JkvxReXdqYB9awuVqeUu2dhU8OnrgO
	 v+JCZMmSeuoAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CB93822D6D;
	Mon, 26 Aug 2024 16:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1 V2] Selftests: net: Set executable bit for shell script
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172468862999.56156.11380462339088608226.git-patchwork-notify@kernel.org>
Date: Mon, 26 Aug 2024 16:10:29 +0000
References: <20240824143837.228874-1-david.hunter.linux@gmail.com>
In-Reply-To: <20240824143837.228874-1-david.hunter.linux@gmail.com>
To: David Hunter <david.hunter.linux@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, javier.carrasco.cruz@gmail.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 shuah@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Sat, 24 Aug 2024 10:38:37 -0400 you wrote:
> Turn on the execution bit for the shell script file. The test is skipped
> when downloaded from the linux_mainline source files.
> 
> Signed-off-by: David Hunter <david.hunter.linux@gmail.com>
> ---
> V1 --> V2
> 	- Split the patch into two separate patches (one for each issue)
> 	- Included subject prefixes
> 
> [...]

Here is the summary with links:
  - [1/1,V2] Selftests: net: Set executable bit for shell script
    https://git.kernel.org/netdev/net-next/c/39e8111ce5ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



