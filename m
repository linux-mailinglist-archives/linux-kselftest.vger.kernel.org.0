Return-Path: <linux-kselftest+bounces-355-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5174D7F2364
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 03:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82AD11C21570
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 02:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C970111BF;
	Tue, 21 Nov 2023 02:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJkBOUEj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDA9CA51;
	Tue, 21 Nov 2023 02:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67FC4C433CB;
	Tue, 21 Nov 2023 02:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700532025;
	bh=8RHzjbHL2fNjN9Iqh/fE8jWjCFZIKPGlbbiWdG4vFYw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VJkBOUEjQ7fKHA9lV7Pe1b/9YQHxORY8TXDJALMm9+RxfvRcHdyEKwm9MNRwYrst3
	 Hr0uTRpP8WR5MJZcogu19fYFMftU7o9Eepr673QnAc5KyBzaFG6FJ6avU9QvHf9aZK
	 5UeSeTGlxt4gg524Pbhodu8ggPfg9MLtjOc4f0jZxTCpZmFO6cIeQEw8ZLp9drRMUz
	 Y436KDJINV6ptnKsWYft2anWEIxA7Cicrhn6AoIY2kKkb3uaiJ2BahGKkHl9YHFMTU
	 ZU1ekFI0MWH5JKW+Av0kl0JJtpxOE565iTw/SyN9n4apqeJjt6u8pu+GteZOXUAHg0
	 MELxwt1IjVJ6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4AE8AEAA95F;
	Tue, 21 Nov 2023 02:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: net: verify fq per-band packet limit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170053202530.14605.2419341175406490065.git-patchwork-notify@kernel.org>
Date: Tue, 21 Nov 2023 02:00:25 +0000
References: <20231116203449.2627525-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20231116203449.2627525-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, linux-kselftest@vger.kernel.org,
 willemb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Nov 2023 15:34:43 -0500 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Commit 29f834aa326e ("net_sched: sch_fq: add 3 bands and WRR
> scheduling") introduces multiple traffic bands, and per-band maximum
> packet count.
> 
> Per-band limits ensures that packets in one class cannot fill the
> entire qdisc and so cause DoS to the traffic in the other classes.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: net: verify fq per-band packet limit
    https://git.kernel.org/netdev/net-next/c/a0bc96c0cd6e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



