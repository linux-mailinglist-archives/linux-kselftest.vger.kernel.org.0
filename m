Return-Path: <linux-kselftest+bounces-39685-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3C1B31CDB
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 16:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88D061D23541
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 14:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C78130F533;
	Fri, 22 Aug 2025 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8SafVce"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36788305E0D;
	Fri, 22 Aug 2025 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874206; cv=none; b=fLZUxn0msONsOpoqzjQ1SlmF7qLvaEKGiAgPyAEF6WbeWoncG/2wVjqU8PpibNTnmcn64X+FQBeNas2cyuxOAEz2AihugvLI8QT7T583h8+8JiJhk7dzG8zyjiId8shCpJiVA/ZuZLxLWHz6jzPTE6jY8cAmKI1CXsg+m4Jq9qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874206; c=relaxed/simple;
	bh=MjyHO/4BL7cHnKC4UYxDMhLYbriTAQDeFzfJCYKJ+TY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n3mI8j8jtxq2/e4g5r24oMSc/Q8LtRhEWzwFDnMD+MMNqh7vGe4DSLNeSrS1CQ15U5s14nG2oZx2rw53st7knFyRB2j47m3fAEUXCm+m/vJlZbOnD0jY8OMyp6Hrhnf/kFrWD23wGEJWtd0tEVoeew0e20AUUqdZtiee78/+AmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8SafVce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF88C4CEED;
	Fri, 22 Aug 2025 14:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755874205;
	bh=MjyHO/4BL7cHnKC4UYxDMhLYbriTAQDeFzfJCYKJ+TY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a8SafVce8IFQL42N+4GleRApfbE9SomRYOYHAeohYAe/2SIspSrdX3DVkntEtMBGJ
	 fHdbsV+uqBDWuggHdYotFIY7PMQrpW8ap2NIl2uW2UAFsnw2candJsAMzP6Z2k+WlI
	 mfJRGegIQ2WtEYtmNrs+Eh4QucCU6NBzVQ5P4R1oSrhoLzza5/4/OU+YpdNTQ0r0gP
	 +f5w9rKhqB3z0f4PSakWPTxDkl40O+OUKPDgT4MBjjpPPCh/FWUi+bgsadW7b0+n0m
	 Gf06r04E5a0FQgd3X80ltyjttjh7Fe2dgslL8Dqiw1sLwlYOMeCKt0Dj7Rfl3uMHTV
	 pK/yGPBa2q2kg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEE7383BF6A;
	Fri, 22 Aug 2025 14:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] selftests: Test XDP_TX for single-buffer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175587421475.1861845.5730687564277549751.git-patchwork-notify@kernel.org>
Date: Fri, 22 Aug 2025 14:50:14 +0000
References: <20250821014023.1481662-1-dimitri.daskalakis1@gmail.com>
In-Reply-To: <20250821014023.1481662-1-dimitri.daskalakis1@gmail.com>
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Cc: davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, sdf@fomichev.me, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 20 Aug 2025 18:40:20 -0700 you wrote:
> Ensure single buffer XDP functions correctly by covering the following cases:
> 1) Zero size payload
> 2) Full MTU
> 3) Single buffer packets through a multi-buffer XDP program
> 
> These changes were tested with netdevsim and fbnic.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] selftests: drv-net: xdp: Extract common XDP_TX setup/validation.
    https://git.kernel.org/netdev/net-next/c/91aacd8ceffe
  - [net-next,2/3] selftests: drv-net: xdp: Add a single-buffer XDP_TX test.
    https://git.kernel.org/netdev/net-next/c/d06d70eb6af4
  - [net-next,3/3] selftests: drv-net: xdp: Validate single-buff XDP_TX in multi-buff mode
    https://git.kernel.org/netdev/net-next/c/bbd885b193cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



