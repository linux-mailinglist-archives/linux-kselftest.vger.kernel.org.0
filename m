Return-Path: <linux-kselftest+bounces-29022-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7242A60D4E
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 10:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17300163804
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 09:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2A01EDA0F;
	Fri, 14 Mar 2025 09:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNztvbmu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F6F763F8;
	Fri, 14 Mar 2025 09:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741944596; cv=none; b=D4uUxmKb4Tx2SiPnUoS8RNCobV0QmIRBiIF+dqHh0oQygFsB0jracGZtXWVRXqJgObETLUs/x4Yw1PFjtlE8L9PukoyMOxZWg1PiWXy2NbRTg4pS0wqeoYybL3AnvKwRg0pdMUjsjlOhWiLwSBQ7kr466Y2+U1EfLH6eOYYTo8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741944596; c=relaxed/simple;
	bh=1MV0CmWQUAVkxakZMhwjIv5JUYRsoJpgm0sSZIVSysc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VgsMFiSy+aPPKVY3lB/s+ShsHY1LAtlVFnuizMb4Flece6HmMjPwkIAMGOzFRUhyEHbYoUIj8S6tSKf0El3vmw8RGuXlzv0q2VK5W50+sHSWLOoobX8nCLoBErivIBNowxh9zWeqjyaHYO8crSOiNC6wWjAkq0r9Jm4eWOcx/e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNztvbmu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2C8C4CEE3;
	Fri, 14 Mar 2025 09:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741944596;
	bh=1MV0CmWQUAVkxakZMhwjIv5JUYRsoJpgm0sSZIVSysc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LNztvbmuGDvwcbfmRW9Yxn86cXdzmvlOc0sZSYVaaqic2JoN3WSuKmY3dPcXq8BHx
	 nVwZw4VpAygBG+CD9jvvZMny6VAEAxypH6V89HUuJmc7Lrb+ZEXiGbziufJGQNtg0C
	 nJ9KjnKhc7+LH0g5Aot4Fkp5FbMppLTQouY/jKZTpcydtN5izKKgcXkRQPA0avcy7D
	 7mLExY0xLsNoiqPmKoyycGrxqaIAqBuT18mbXrKSuPiHspBw59ea3dVJZt0cyHQKAg
	 JjPmvkjWhQ1JAEE/8qBoI9svFiX9s6fqudgwgS2zqNasVOyo8lniFTG2YrGmE4iUzO
	 kopwX8TBwn5yg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1203806655;
	Fri, 14 Mar 2025 09:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: drv-net: fix merge conflicts
 resolution
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174194463076.2177919.13940583738583650186.git-patchwork-notify@kernel.org>
Date: Fri, 14 Mar 2025 09:30:30 +0000
References: <20250314-net-next-drv-net-ping-fix-merge-v1-1-0d5c19daf707@kernel.org>
In-Reply-To: <20250314-net-next-drv-net-ping-fix-merge-v1-1-0d5c19daf707@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, sfr@canb.auug.org.au

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 14 Mar 2025 09:35:51 +0100 you wrote:
> After the recent merge between net-next and net, I got some conflicts on
> my side because the merge resolution was different from Stephen's one
> [1] I applied on my side in the MPTCP tree.
> 
> It looks like the code that is now in net-next is using the old way to
> retrieve the local and remote addresses. This patch is now using the new
> way, like what was in Stephen's email [1].
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: drv-net: fix merge conflicts resolution
    https://git.kernel.org/netdev/net-next/c/a1e36ec36356

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



