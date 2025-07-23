Return-Path: <linux-kselftest+bounces-37862-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC514B0E81B
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 03:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E02A2174595
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 01:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2F91D95A3;
	Wed, 23 Jul 2025 01:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcqjIfoa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00271D6DB6;
	Wed, 23 Jul 2025 01:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753234221; cv=none; b=iMBRxP7SlLj7W9wkJbp+JIe3QJwhQuirtWFL8pF8uvlQ6mB5w3uv4BKutTdF8JRI3eY7rnIjXTa8RzlyyYqHY7YA0vHvf2A+ifTFoIvex4pjzJhZfi6dayPRqhowDEHHs/etRRUKuiLwExk5R9A3C7InZ0KZen85pwoPQqIAyQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753234221; c=relaxed/simple;
	bh=3E1gRrFaeCrEyCBmb1gLjo97LjP+ccCXOTC9zsWGrFY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qiuJh8xpEms8WG0JJUh/65iKR64wTE06zHDLB7Kl+PE66d+FQblYzC1QKL5wS3l0RfEkVl57N+A+CF/MdxydTlkmlW+i6P091b/zpgJh3YWEScdn+9w/lQmZU/zKOaLnkxaR+JOJUg9KsAyWxkdEPL27KHZUcz/VWCVPVyKUpGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcqjIfoa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA36C4CEEB;
	Wed, 23 Jul 2025 01:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753234220;
	bh=3E1gRrFaeCrEyCBmb1gLjo97LjP+ccCXOTC9zsWGrFY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JcqjIfoa7UagvsAZzk0ZhGUiFcnAufyTjUhy2sciWBBPAgn/aBTwDhSYZsJcT+5Ab
	 dXIXtAamC5gMME/AVw1OVe4LdTMNZkLhlQ8CxYTkSdYr5KhNbp5LQvQ8+wTauGU7vk
	 fXqEkvlzmxwEd6UNjpuHmUuhNNNRMcplsDZ4WAu87w09Vl4RUGTc+2xbniSXzF5rcm
	 6dS6AUDW9yHMjKElP/mnAMxm4yIsVNOXjDVz8d69CYvbs+MAqbOkBcHfddV1GO3gg0
	 PRiYe37omdJN7bwskIl1bbyeFixo5uuPEF6x+bx6NgHS5bglBBudoKmP48r40OI4+T
	 s82HwINcv0cog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD7C383BF5D;
	Wed, 23 Jul 2025 01:30:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V6 0/5] selftests: drv-net: Test XDP native
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175323423849.1016544.9128937268934260157.git-patchwork-notify@kernel.org>
Date: Wed, 23 Jul 2025 01:30:38 +0000
References: <20250719083059.3209169-1-mohsin.bashr@gmail.com>
In-Reply-To: <20250719083059.3209169-1-mohsin.bashr@gmail.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 shuah@kernel.org, horms@kernel.org, cratiu@nvidia.com, noren@nvidia.com,
 cjubran@nvidia.com, mbloch@nvidia.com, jdamato@fastly.com, gal@nvidia.com,
 sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
 morbo@google.com, justinstitt@google.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 19 Jul 2025 01:30:54 -0700 you wrote:
> This patch series add tests to validate XDP native support for PASS,
> DROP, ABORT, and TX actions, as well as headroom and tailroom adjustment.
> For adjustment tests, validate support for both the extension and
> shrinking cases across various packet sizes and offset values.
> 
> The pass criteria for head/tail adjustment tests require that at-least
> one adjustment value works for at-least one packet size. This ensure
> that the variability in maximum supported head/tail adjustment offset
> across different drivers is being incorporated.
> 
> [...]

Here is the summary with links:
  - [net-next,V6,1/5] net: netdevsim: hook in XDP handling
    https://git.kernel.org/netdev/net-next/c/be09f0d1acce
  - [net-next,V6,2/5] selftests: drv-net: Test XDP_PASS/DROP support
    https://git.kernel.org/netdev/net-next/c/1cbcb1b28b26
  - [net-next,V6,3/5] selftests: drv-net: Test XDP_TX support
    https://git.kernel.org/netdev/net-next/c/6713945726ce
  - [net-next,V6,4/5] selftests: drv-net: Test tail-adjustment support
    https://git.kernel.org/netdev/net-next/c/0b65cfcef9c5
  - [net-next,V6,5/5] selftests: drv-net: Test head-adjustment support
    https://git.kernel.org/netdev/net-next/c/d6444ebc97dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



