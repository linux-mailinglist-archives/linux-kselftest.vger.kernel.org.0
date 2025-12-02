Return-Path: <linux-kselftest+bounces-46864-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C89C99BB5
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 02:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8EE6C4E1718
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 01:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EB71B3925;
	Tue,  2 Dec 2025 01:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXvq9lmT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6662A79CF;
	Tue,  2 Dec 2025 01:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764638611; cv=none; b=H6KcLQCEZ6U1tikG5caW+Xbm/fq/aXsEq99e4NiCbDmPLZx3QEqXarzRgKdiczJHnAnpVRVom+KCF67fwTJpz8QE9cFaUcf4jBgzNbAbhhXhUbM2N2PwesG39qnsGVvjp4gMmPrkY/Lb0bJKneJEJh0OSlf6aPRw822+ozujLeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764638611; c=relaxed/simple;
	bh=pGoNpgk9fm7AxtW35iuqu42uTT0Yzq7QSXE4gCS724M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C/P1+387w6fCjKU7CiGMBbC2OPP6qYKsLQsqPimZHl4gFePi/zDtzZp9zzAbb4qUqQfjuVLaf6eWQtjXsEmQWeQaN+LG0XZjliurdd6WbAsR6q3APZhpP0Np47fUlmztMXzPlzWOnhWEup21zrU5f5VJOWcJQ2zM6WnBotUhbbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXvq9lmT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD7EC4CEF1;
	Tue,  2 Dec 2025 01:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764638610;
	bh=pGoNpgk9fm7AxtW35iuqu42uTT0Yzq7QSXE4gCS724M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LXvq9lmTewPn+LzVc28vb6MhK6kvb/FkWTtSh6f6T9TvvAIg0R9C5ChuC89Zqg9PP
	 iH0KHqZrAWSJyvW/1wdTZThT537Vna7nble8PX9UYn2860P4st23ka8/tnv/IYs7Uf
	 +zKT4/50RVvKr9Pj7j2OVu/NDxcfw4K9LAwU0cOebnaJCVFEeT6Edc7gBF0jjZ9w0z
	 J4E8j+1kABQdMRTK147xsZfxAMgG8MQdknoqLnbo8jbUq/dzx52ep1PKt4AdTvNp3L
	 WhTkACCMS+zBBygA6gS0MW+JU3gWhGAdr7vvWrKdKg94aMNfPAbUxoSIiK90seyNvi
	 HL0PPA0dEhcRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F29B9381196B;
	Tue,  2 Dec 2025 01:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V3 0/6] selftests: drv-net: Fix issues in
 devlink_rate_tc_bw.py
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176463843079.2624727.13926178837360430248.git-patchwork-notify@kernel.org>
Date: Tue, 02 Dec 2025 01:20:30 +0000
References: <20251130091938.4109055-1-cjubran@nvidia.com>
In-Reply-To: <20251130091938.4109055-1-cjubran@nvidia.com>
To: Carolina Jubran <cjubran@nvidia.com>
Cc: shuah@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, gal@nvidia.com,
 tariqt@nvidia.com, cratiu@nvidia.com, noren@nvidia.com, mbloch@nvidia.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 30 Nov 2025 11:19:32 +0200 you wrote:
> Hi,
> 
> This series fixes issues in the devlink_rate_tc_bw.py selftest and
> introduces a new Iperf3Runner that helps with measurement handling.
> 
> Thanks,
> Carolina
> 
> [...]

Here is the summary with links:
  - [net-next,V3,1/6] selftests: drv-net: Add devlink_rate_tc_bw.py to TEST_PROGS
    https://git.kernel.org/netdev/net-next/c/a8658f7bb650
  - [net-next,V3,2/6] selftests: drv-net: introduce Iperf3Runner for measurement use cases
    https://git.kernel.org/netdev/net-next/c/2a60ce94c6e8
  - [net-next,V3,3/6] selftests: drv-net: Use Iperf3Runner in devlink_rate_tc_bw.py
    https://git.kernel.org/netdev/net-next/c/cb1acbd30a42
  - [net-next,V3,4/6] selftests: drv-net: Set shell=True for sysfs writes in devlink_rate_tc_bw.py
    https://git.kernel.org/netdev/net-next/c/3796e549e305
  - [net-next,V3,5/6] selftests: drv-net: Fix and clarify TC bandwidth split in devlink_rate_tc_bw.py
    https://git.kernel.org/netdev/net-next/c/9ecd05a2c872
  - [net-next,V3,6/6] selftests: drv-net: Fix tolerance calculation in devlink_rate_tc_bw.py
    https://git.kernel.org/netdev/net-next/c/5cc1bddcfeb2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



