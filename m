Return-Path: <linux-kselftest+bounces-2866-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBC582B562
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 20:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 093301C2123F
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 19:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54FC55E62;
	Thu, 11 Jan 2024 19:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnJ9wOM0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DB055E57;
	Thu, 11 Jan 2024 19:42:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFDC4C43390;
	Thu, 11 Jan 2024 19:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705002145;
	bh=G6YfkMTfrKpVPvbMcmkuGZLdsfUoy300U8rWYOdWe18=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CnJ9wOM0M04q4k6yTtky3njirZDHFD2rwKAwmQHFyZvvzDNMV7i49R6tGp/tvIDZ/
	 ZohzSuGN5efjalzw7QthYyhhfoQIrvnSlzTVWeDAnn0iWXaZ9Dn0LjnY5HnGxK484j
	 elmSl9mLi+FYcTBX3fL4kM7x289lDlTxdn1+70ZPAYOdzOdO0ptui3oT0XwsCtHS0f
	 gp1phOebrBOtm1weU5qFrc9n2T7rImNIJTEmLE4gs3YHjzW4hhSoOsAUlWCCGSw8PQ
	 akhlUzDoTUxXuwQXTO6v+PQgTt/vW6tDM74scSq1S4qLFocvG6gwMPJaXk0iCdvt6l
	 gTtfxsIU0e9mA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D56A4D8C972;
	Thu, 11 Jan 2024 19:42:24 +0000 (UTC)
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
 <170500214487.3715.485449323936860902.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jan 2024 19:42:24 +0000
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
by David S. Miller <davem@davemloft.net>:

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
    https://git.kernel.org/netdev/net/c/1ad04b795cc3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



