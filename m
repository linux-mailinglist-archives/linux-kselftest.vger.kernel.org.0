Return-Path: <linux-kselftest+bounces-24751-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8F5A15B4E
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Jan 2025 04:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D2D73A8C64
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Jan 2025 03:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6537B14A088;
	Sat, 18 Jan 2025 03:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/CJhGQw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3381474A9;
	Sat, 18 Jan 2025 03:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737172229; cv=none; b=EJ0mI4l6Vx3321t2FNHU/S4x9zDh2G8IpsMQwvXWgsBimSwF6rlsaKSOpxdtBvgYTXSOF50QEL1P/M4hBAZRSBFiT/HhuKkXk3W8BjcvOvb+CEYFaSF2dC9xTU+l55b/8nfy2TUBy6pvYBuU2q3tTLW/lsqa0JUZjISva+IIOJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737172229; c=relaxed/simple;
	bh=MnoqE/Q6g5coOLxuf1HvIkumQhXCkhEEYtPnQgKYJ/w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aDXDB6XngnTTJfT9lq761krW1izUJHkgtmTgXxE1OcXIQ8D56I741Au0rN7INv25UuLp+6a3MerBdVDkhMFh1KcIXoin8bkyzBkHYBJ4P0PwSOdHJ/sDeNd5Rj4vZLO6GFRrSqVWxHEBFxPvJ0GWDCI6z2+aGOQ5Euc0wHBiLKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/CJhGQw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C9EC4CED1;
	Sat, 18 Jan 2025 03:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737172228;
	bh=MnoqE/Q6g5coOLxuf1HvIkumQhXCkhEEYtPnQgKYJ/w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n/CJhGQwvOnfH3zN6hzM4BYWL4Y3UluChtUcnfSNJgUpPEPP6PaMlcliK/j6omwkV
	 ze95xMVbNQHsFVlNyJzTEdDY2aAM3LmYUbEhDdx+QLsB91EFE0UQgF9m8Y4cpBK28q
	 JeRM21+PYyF315aQH3C9y5vSFvSnExoYasa7ppWIvI9oJfPkqfwrEF92UE84SW7H21
	 +6gj+1SwTpgnVfgsSxAAM55Ljf3TU05vBHtjJjPDI3mwsyac7Z7XeyyPtCg48JmvZc
	 caYAbT8a57q2SyOWVPSYl5CArOlFCmh++eR3w8w3HHKnjNPtcP5BPB9EU4ZcJiDDFD
	 eoR7EDYit76Fg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B67380AA62;
	Sat, 18 Jan 2025 03:50:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: net: give up on the cmsg_time accuracy on
 slow machines
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173717225214.2330660.14972461592963136332.git-patchwork-notify@kernel.org>
Date: Sat, 18 Jan 2025 03:50:52 +0000
References: <20250116020105.931338-1-kuba@kernel.org>
In-Reply-To: <20250116020105.931338-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, willemdebruijn.kernel@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 Jan 2025 18:01:05 -0800 you wrote:
> Commit b9d5f5711dd8 ("selftests: net: increase the delay for relative
> cmsg_time.sh test") widened the accepted value range 8x but we still
> see flakes (at a rate of around 7%).
> 
> Return XFAIL for the most timing sensitive test on slow machines.
> 
> Before:
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: net: give up on the cmsg_time accuracy on slow machines
    https://git.kernel.org/netdev/net-next/c/54ea680b759c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



