Return-Path: <linux-kselftest+bounces-3067-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4024F82EAF9
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 09:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0D44285431
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 08:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC8E11CB1;
	Tue, 16 Jan 2024 08:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxmywGEs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0096B12B66;
	Tue, 16 Jan 2024 08:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 694D4C433F1;
	Tue, 16 Jan 2024 08:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705394425;
	bh=RvkNX6mf/nhb50Drahhhn5Ty0ZIM4lz3+EQYNCIMnKY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KxmywGEs4iWn9gZikcWx/ZKaOj6p7/UaZ+1I+a0T1SHalVqbqZP7bwG4wQ5hIn9KV
	 zh/KCrw/0rYIr6DPgHiFdB57oTQ2WAnPhow2tAS5eZtcC4t9j2rTvFypbPiJ9/erBJ
	 22stpZydRETdNCHkUNjsVN1IsOWLruVZ9Y6FYtsG8lNqm+y334ho/dR+5ViwLytYmy
	 A7w6ICPbttLPDIZE3wKMDx3mIsh9prymi5/fAMOP9gmhKFi6420t+kg00lXYKWnTWT
	 GACSUrJaZJC0r/Jw5/RGePdFnE/KazO5uUkIRB8HZ5rQGiSFKKCsKoKIRwedcuU8DR
	 1+Y142jT6GbsQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4E0CED8C977;
	Tue, 16 Jan 2024 08:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] selftests: net: Small fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170539442531.18757.14910373850868301223.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jan 2024 08:40:25 +0000
References: <20240110141436.157419-1-bpoirier@nvidia.com>
In-Reply-To: <20240110141436.157419-1-bpoirier@nvidia.com>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: netdev@vger.kernel.org, j.vosburgh@gmail.com, andy@greyhouse.net,
 shuah@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, petrm@nvidia.com, razor@blackwall.org,
 liuhangbin@gmail.com, idosch@nvidia.com, vladimir.oltean@nxp.com,
 jon.toppins+linux@gmail.com, troglobit@gmail.com,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 10 Jan 2024 09:14:34 -0500 you wrote:
> From: Benjamin Poirier <benjamin.poirier@gmail.com>
> 
> Two small fixes for net selftests.
> 
> These patches were carved out of the following RFC series:
> https://lore.kernel.org/netdev/20231222135836.992841-1-bpoirier@nvidia.com/
> 
> [...]

Here is the summary with links:
  - [net,1/2] selftests: bonding: Change script interpreter
    https://git.kernel.org/netdev/net/c/c2518da8e6b0
  - [net,2/2] selftests: forwarding: Remove executable bits from lib.sh
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



