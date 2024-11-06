Return-Path: <linux-kselftest+bounces-21508-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4275F9BDB4A
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 02:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723401C22D6B
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 01:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4523418C006;
	Wed,  6 Nov 2024 01:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aITdy0qr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0BD18BBB9;
	Wed,  6 Nov 2024 01:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730857229; cv=none; b=tEDqJNb8yPoz81ZVR90ERSMvFiWez7KkIGoowSQBBQEiT/IGaNUk79KxTTiZZO2du959rsiMGDb8esz57Tzi5BzK8golnpspt8aTk0D5qaypwbA43I3vgU7CohWVdzg9VZUYzhNwl+JPsjO/dJZB8sBrUzikVOy7S0grG6eJkZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730857229; c=relaxed/simple;
	bh=esOnjkeufN8HAPgjP5fkn+3SUM3+jIm1xlaaK6Sx+ns=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HQQnbisAEdI5HabTORVHsHCGktWfU2MPI3+5TVUHgmCtAsxkzdSEl+i6Wbg9ANduZ9+2lGhQt1twUiqZmSdzyhdYriAiAc98zZK77KcCuoTDGh2KvwxiM0n75BFDRA3QLKzi5QVTAMiCIKVcrTWVa6VZ4qExLZtzihcjqTJ/whE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aITdy0qr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA1AC4CECF;
	Wed,  6 Nov 2024 01:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730857228;
	bh=esOnjkeufN8HAPgjP5fkn+3SUM3+jIm1xlaaK6Sx+ns=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aITdy0qr3NafHRwWdPWIzf1OVlqZgNQX8jtQltYDCTl6063O6Mffjrv6TG73w0Hk9
	 u2F1Z/D8WvTv8kjIJqBvapfhdIhry1a6+7OeRTs8Y7ZKtYFPejgCTktnsRrVH0vN+7
	 pagV/8e6F9gBRUytiVNh+On2qtDkTgvYa9eht/xwpqS5leukK/nnnfBY6huh7lOCwX
	 quNd4oBy0BhtHaprF8jyo3MwuD2QnewVkTB1lWNGBQ+S2dOhyQb2/JCLRYb1e3agvU
	 S5Gjfnkk/6y0sp0GzKrJkudVRp0o6kZbjcVNbpZdFKlVNZm34mB8xWAcapI6TRKQ63
	 3ia/jU+8SHswg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0D93809A80;
	Wed,  6 Nov 2024 01:40:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: net: include lib/sh/*.sh with lib.sh
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173085723778.759302.10510309486670038114.git-patchwork-notify@kernel.org>
Date: Wed, 06 Nov 2024 01:40:37 +0000
References: <20241104-net-next-selftests-lib-sh-deps-v1-1-7c9f7d939fc2@kernel.org>
In-Reply-To: <20241104-net-next-selftests-lib-sh-deps-v1-1-7c9f7d939fc2@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 martineau@kernel.org, geliang@kernel.org, pablo@netfilter.org,
 kadlec@netfilter.org, petrm@nvidia.com, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 04 Nov 2024 12:34:26 +0100 you wrote:
> Recently, the net/lib.sh file has been modified to include defer.sh from
> net/lib/sh/ directory. The Makefile from net/lib has been modified
> accordingly, but not the ones from the sub-targets using net/lib.sh.
> 
> Because of that, the new file is not installed as expected when
> installing the Forwarding, MPTCP, and Netfilter targets, e.g.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: net: include lib/sh/*.sh with lib.sh
    https://git.kernel.org/netdev/net-next/c/f72aa1b27628

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



