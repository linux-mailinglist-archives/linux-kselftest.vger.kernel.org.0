Return-Path: <linux-kselftest+bounces-29447-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C9AA69675
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 18:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92ECF16F5E0
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 17:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5A9205E16;
	Wed, 19 Mar 2025 17:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sh533+lW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D641E8322;
	Wed, 19 Mar 2025 17:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742405399; cv=none; b=BQjmoiPW78CW+KPMkDiRKL0VN4T43XK3sjiCmFnq+qk/xJPhkEGSdaLuYaXwQl6Zk3x2kk55VJeUv2nXjkfR/vRWo9HGdi5U9385YudfRwnxa+J0m5ewoN7gdDni4rHKNFmBxtWJwdq2OrNJj2XjRx5TDRrtgF2bMzJTju1LEHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742405399; c=relaxed/simple;
	bh=c9786C236wd96FDG6PlRHsJbJsyVfXc5lTtHTImEIxY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jWYjKlg5WlCthgKtO7vLNKh+zCBja233/pW2v4kTsuL1wFk+G4tEtz5hlPSYFH3DE0ty4LocVrDi8H4Uy5VlHGm5k1ESmqMihub8lRAOukifd4BwceTGyg9MAx+hq3iCfRm4KfnGuBlfvrUKRIo5myQdVnC0q9YeInpdmNt8uAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sh533+lW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E1AC4CEE4;
	Wed, 19 Mar 2025 17:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742405398;
	bh=c9786C236wd96FDG6PlRHsJbJsyVfXc5lTtHTImEIxY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sh533+lWPpVsVWTfvXE0wMapJclMXNOnlB0Rh3XG+gD9zKPCzVQaXk9ulXxqB+gSo
	 HoVlXR4q67DncnnxolvYZgZ+E5hlnlPku+kVBG0uXLpY1AREzdt8sBUAnUzDPLDMbo
	 +fik1n+Gmnf554zOx2LWabE6nkHoJIi1YYvc76cIOOzezOaP8ACas5b08KM9ussqz/
	 7nSxX8r+/WOmGPbspt7JsDPe2sE9IiwldzpJ4GjaUrVFiXq2E/AhQHpNSVKWCOgI2Z
	 sWW+krZaMwdP8SjPxAEosR6IBWOff5KUEpVLCKActJwnqwzXLBkWFmKzeBlyOdEvL5
	 ijntBwNX1UYBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F37380CFFE;
	Wed, 19 Mar 2025 17:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: drv-net: use defer in the ping test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174240543425.1125754.2555688406612172851.git-patchwork-notify@kernel.org>
Date: Wed, 19 Mar 2025 17:30:34 +0000
References: <20250312131040.660386-1-kuba@kernel.org>
In-Reply-To: <20250312131040.660386-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 ap420073@gmail.com, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 12 Mar 2025 14:10:40 +0100 you wrote:
> Make sure the test cleans up after itself. The XDP off statements
> at the end of the test may not be reached.
> 
> Fixes: 75cc19c8ff89 ("selftests: drv-net: add xdp cases for ping.py")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: ap420073@gmail.com
> CC: linux-kselftest@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - [net] selftests: drv-net: use defer in the ping test
    https://git.kernel.org/netdev/net/c/acf10a8c0b3a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



