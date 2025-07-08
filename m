Return-Path: <linux-kselftest+bounces-36739-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 612D0AFC08E
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 04:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50781420135
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 02:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDAB22B5AD;
	Tue,  8 Jul 2025 02:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPnh51Sg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E1D21883F;
	Tue,  8 Jul 2025 02:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751940625; cv=none; b=F1EWTVjhy8jzvoPFf01303hOipir9QZvH79pKiQFneom3oZPw+iVpn06zr+Y63W/EJqaEk/AK0CH7YZw51mK5x8BRhUW0rCfqxwXYMRqGfi9r1UNMM9Bfw8H1tEV/nssMnFD/Ns8dNARzVdmiS4JXrqN/Z9YRV6TdKIyKilVP58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751940625; c=relaxed/simple;
	bh=MruwqvZc5LP3jAJGI/pDLVRJ8Xn8JFxY+XCfzAUT7eQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JoQBPowH0RI55qOkkkxS5f/xa1uKXlqL3TYGUITq6M+xdI+jQlpY1ih2tAo68+IDD8zICv5LVP6/7Cn52XHE6YaWjCDOWhXV84re4lGPngYbs4X8vQVaScMLi1CNNrGSgZQgeuYG9OKrmAyLL6YuS6xURJXW/fTAl0Si0hFNKZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPnh51Sg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA8CC4CEE3;
	Tue,  8 Jul 2025 02:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751940625;
	bh=MruwqvZc5LP3jAJGI/pDLVRJ8Xn8JFxY+XCfzAUT7eQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fPnh51SgGgorkAiOWQC+Ez/dG7yG5Z9hX/BuTC9sJInmjiW4BYoAeG4ki7+vk2RMi
	 AiySCwBMg0r3nITCBDOfxcMt+1G5x1qfOIUv7QVkSvrZMGwPh76XBJOYtFWE7z5uOI
	 X9o1LM2P1rK1IuxQW4TYFXQ4Gj8kUlk/o4s3/Q2PI/ghO18gVIcuCp3FvB2PN0cxSw
	 Pcjq17ppoJNrFTG6rh2SxZ0HmCOpTWuiHFI2jJ7NYBVJOAlSoitb32ebpfpRd8Hg89
	 +ds9kkI48/pja3SvFmippX37+3uHNSopqw+w6rVA2No4Ti/IsWmsUszmLJos8nnJ6J
	 zwOPbI9LkwgFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D6F38111DD;
	Tue,  8 Jul 2025 02:10:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/7] netpoll: Factor out functions from
 netpoll_send_udp() and add ipv6 selftest
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175194064702.3543842.10191674038121919735.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jul 2025 02:10:47 +0000
References: <20250702-netpoll_untagle_ip-v2-0-13cf3db24e2b@debian.org>
In-Reply-To: <20250702-netpoll_untagle_ip-v2-0-13cf3db24e2b@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-team@meta.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 02 Jul 2025 03:06:32 -0700 you wrote:
> Refactors the netpoll UDP transmit path to improve code clarity,
> maintainability, and protocol-layer encapsulation.
> 
> Function netpoll_send_udp() has more than 100 LoC, which is hard to
> understand and review. After this patchset, it has only 32 LoC, which is
> more manageable.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/7] netpoll: Improve code clarity with explicit struct size calculations
    https://git.kernel.org/netdev/net-next/c/4b52cdfcce21
  - [net-next,v2,2/7] netpoll: factor out UDP checksum calculation into helper
    https://git.kernel.org/netdev/net-next/c/01dae7a61c1a
  - [net-next,v2,3/7] netpoll: factor out IPv6 header setup into push_ipv6() helper
    https://git.kernel.org/netdev/net-next/c/839388f39aee
  - [net-next,v2,4/7] netpoll: factor out IPv4 header setup into push_ipv4() helper
    https://git.kernel.org/netdev/net-next/c/8c27639dbe54
  - [net-next,v2,5/7] netpoll: factor out UDP header setup into push_udp() helper
    https://git.kernel.org/netdev/net-next/c/cacfb1f4e9f6
  - [net-next,v2,6/7] netpoll: move Ethernet setup to push_eth() helper
    https://git.kernel.org/netdev/net-next/c/eb4e773f13fb
  - [net-next,v2,7/7] selftests: net: Add IPv6 support to netconsole basic tests
    https://git.kernel.org/netdev/net-next/c/3dc6c76391cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



