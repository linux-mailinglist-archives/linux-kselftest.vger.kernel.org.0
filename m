Return-Path: <linux-kselftest+bounces-28263-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BA8A4F347
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 02:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8575216F45C
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 01:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B48012CDBE;
	Wed,  5 Mar 2025 01:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIBs/HvY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFC9282EE;
	Wed,  5 Mar 2025 01:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741137010; cv=none; b=JQMy4ONwLpJZ0qerMH4ntQx6+iVxraRhY3NS3qnLLdBug+YMSyNh4QN+Hq5nMxa/44LCDohAJXDiWX7ix1r7H2NtM/+YmX4ziUr8Hx2+dJCwCYWIyOHifJInkYRrDQHaSRoGlydu72Q9iri5WtkhN0RZ8cmSx5aBgHcHtGbWyVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741137010; c=relaxed/simple;
	bh=o2GS4bqqE977OqAGP8Gc1WH1R92Ml4Sy3dtY91sTP1c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I3U0KqkYKo5mXayJCv37rJ+ftafZnRxTNxRkTfC0HrMiI4RORncGCEN7btgHdWMRiPnlFYvxzT+s84GuNWAPfVdWPY+3U4DlZkl+kCLwrpjb3w5mmcH8xVh0XGR3OdZP/o1Ugdyi3BCVuMhu3FvLujTOu18r9/jl1kC2BFvY1Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIBs/HvY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9050AC4CEE5;
	Wed,  5 Mar 2025 01:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741137009;
	bh=o2GS4bqqE977OqAGP8Gc1WH1R92Ml4Sy3dtY91sTP1c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MIBs/HvYoceKM6s3CP46Kv7DLdc7J5vFMIqW7wXABFnd3wmYrxt8DEc3NycgW+Yn3
	 BxLIYp9wKh/07ldbNG0h09RTuY9VYsOf4cnqUiZc1KqItIC5ERhAMOxHkCjUslS9xD
	 VQ6wW8BQRqLp0g0YAC9k9ofAWwkiEWWwqX9xzFuVdbEcsB1hb6l/cb9g78Vgq9Qy9Y
	 PojeabFho7z7OHPRm9dD5XsCihqxhMlwrroiT1zvnc65KAPe9uuDgEfpWgId3L9sCp
	 qeA8zi8IOg6EwWLK7lWlwQ9i8rpVgKs8UrI3IBiYX8hCvnJjr53Oj+8Eq33Ht84poV
	 068afxA5xpWdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE531380CFEB;
	Wed,  5 Mar 2025 01:10:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] mptcp: improve code coverage and small
 optimisations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174113704249.354590.10497092944102408031.git-patchwork-notify@kernel.org>
Date: Wed, 05 Mar 2025 01:10:42 +0000
References: <20250228-net-next-mptcp-coverage-small-opti-v1-0-f933c4275676@kernel.org>
In-Reply-To: <20250228-net-next-mptcp-coverage-small-opti-v1-0-f933c4275676@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, yangang@kylinos.cn

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Feb 2025 15:38:34 +0100 you wrote:
> This small series have various unrelated patches:
> 
> - Patch 1 and 2: improve code coverage by validating mptcp_diag_dump_one
>   thanks to a new tool displaying MPTCP info for a specific token.
> 
> - Patch 3: a fix for a commit which is only in net-next.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] selftests: mptcp: Add a tool to get specific msk_info
    https://git.kernel.org/netdev/net-next/c/00f5e338cf7e
  - [net-next,2/5] selftests: mptcp: add a test for mptcp_diag_dump_one
    https://git.kernel.org/netdev/net-next/c/ba2400166570
  - [net-next,3/5] mptcp: pm: in-kernel: avoid access entry without lock
    https://git.kernel.org/netdev/net-next/c/e85d33b35508
  - [net-next,4/5] mptcp: pm: in-kernel: reduce parameters of set_flags
    https://git.kernel.org/netdev/net-next/c/70c575d5a94f
  - [net-next,5/5] mptcp: pm: exit early with ADD_ADDR echo if possible
    https://git.kernel.org/netdev/net-next/c/f0de92479a09

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



