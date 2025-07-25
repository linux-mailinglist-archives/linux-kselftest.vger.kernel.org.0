Return-Path: <linux-kselftest+bounces-38007-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19906B12432
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 20:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A8405846B6
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 18:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CAE255240;
	Fri, 25 Jul 2025 18:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXdkdIKm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266BD2550D2;
	Fri, 25 Jul 2025 18:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468798; cv=none; b=MI+zcWsvsVvHoIsJVf7cZ4tkfElmr3gg8XBaVErH+ohCWZUjUsxejy0tJ2TT5m6sB+9i2bjU6iKdgdJj6fu4RDcWRaPMxRAPFmgWVLmBJa5diACBiD504l3a3KKpkq51n/W8cqK9OjpD2A0fyjIhKFXPvOrxNFdJn70WKfy/l/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468798; c=relaxed/simple;
	bh=zrmTJvK9djwEgOGhMRS+0+NritPDOSCZSiiUHcQBa1U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JHhHIRgadkdAzdgaxZWvCqes5ASakN/qvmqgxIMAsw3YZnsyNIrzYeZAlD39UienR3MolFk4bRa8G7XIOdhaYqCRS+s7cVHllNGsdKc6GPrZ/wghDAGljtJ9USDeOmt8dz7zbzb0AkSWndtOrM52Y6NLBe63/1LPdGsvH/piHpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXdkdIKm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2BEC4CEEB;
	Fri, 25 Jul 2025 18:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753468797;
	bh=zrmTJvK9djwEgOGhMRS+0+NritPDOSCZSiiUHcQBa1U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GXdkdIKm9NZNL91lY66LMGIa4Unt+Tl2/ZSY8pUPz5++ceisFlh8zzFkU4hsV37Cl
	 I4pv3ISLoDqYe0rT1/yzSEkMt7QQ5XBQMMf7ufuIHGaGHb9PIkE8/rrUiWCn68LF64
	 4ENxtqly7692q8rqch+43a3+Tx4VL4rMuyVmBZuS4yQIApmoT2T9EN3o9qORp3ACGD
	 b8LfvFrd5YeJH2xm6bSpEsQkBFSjZeq2wSyght/wbcz6ym7U2HiUx0uMocnzQqJngc
	 tyNHumqIS4slt+0dEFjJfpqRbr57wVqz7rAmcpKp10rDenaDSPp4wmNQ5dEAnzko+g
	 9vbj5lu6bXSVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C22383BF5B;
	Fri, 25 Jul 2025 18:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: net: Skip test if IPv6 is not
 configured
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175346881499.3231025.2977855605855058343.git-patchwork-notify@kernel.org>
Date: Fri, 25 Jul 2025 18:40:14 +0000
References: <20250723-netcons_test_ipv6-v1-1-41c9092f93f9@debian.org>
In-Reply-To: <20250723-netcons_test_ipv6-v1-1-41c9092f93f9@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Jul 2025 10:35:06 -0700 you wrote:
> Extend the `check_for_dependencies()` function in `lib_netcons.sh` to check
> whether IPv6 is enabled by verifying the existence of
> `/proc/net/if_inet6`. Having IPv6 is a now a dependency of netconsole
> tests. If the file does not exist, the script will skip the test with an
> appropriate message suggesting to verify if `CONFIG_IPV6` is enabled.
> 
> This prevents the test to misbehave if IPv6 is not configured.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: net: Skip test if IPv6 is not configured
    https://git.kernel.org/netdev/net-next/c/5ec9b15d8dfa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



