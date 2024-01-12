Return-Path: <linux-kselftest+bounces-2883-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 592FE82B8D1
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 02:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E67671F243B1
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 01:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD477ED3;
	Fri, 12 Jan 2024 01:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZD7nJh3A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D304A3F;
	Fri, 12 Jan 2024 01:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27279C433B1;
	Fri, 12 Jan 2024 01:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705021228;
	bh=QXQRz/JntJstTO+QAHrv2SpB3FI0qeWQbQKgojY5CPE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZD7nJh3AqHkVx8/0gqOJK7hsYAVbHovYQZWsgSLjnwYgOjg+bCJI8MONekh/k00dn
	 eQ9UsfYDpQNPOL5Sk9mKoyiRodaNon+e9oxRQN+eGTvRHlMEWV2AFDgZWE4tZDd44R
	 SPTfpyYTKGLkzyLaq+W1uH4ROhOB0OR0sp7ta3nP8CLcaYOdEaTU4YFwBNYgQeHfZv
	 624I2mDR1W6hShwdt0F7brha79YdrKRGMUkblgVzwHLPjMh/vhqSGPKjqPl3ZUW7wq
	 dbUeEd5+40mtSthSmGveOzda1lbFbEZp0PTGW8hrEpl3+6cux/p8MjFHyHSbYwr40k
	 0jyt8F3Bd8cfw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0F85CD8C975;
	Fri, 12 Jan 2024 01:00:28 +0000 (UTC)
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
 <170502122805.27071.156663258880842784.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jan 2024 01:00:28 +0000
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
by Jakub Kicinski <kuba@kernel.org>:

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
    (no matching commit)
  - [net,2/2] selftests: forwarding: Remove executable bits from lib.sh
    https://git.kernel.org/netdev/net/c/66cee759ffa3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



