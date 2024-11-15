Return-Path: <linux-kselftest+bounces-22081-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A16D79CD63B
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 05:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 288B71F22636
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 04:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365631684AC;
	Fri, 15 Nov 2024 04:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVxE6XOD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E08614F9D9;
	Fri, 15 Nov 2024 04:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731645623; cv=none; b=K8OCjXlcdefaB6t+OI/NltPV5GcNM4OGwkh8WTPsH6dyt3JKrh3PdvgSoLQdtMsf+pw0/sMslzR27HWrPjbdjn57xRizxatvw4l0dGloo35foZOQl4bLwEVr9t5kxZBnrEmXhf3x4tnGEgRlkd45TbeBsaNetD6wrdFlObKYn+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731645623; c=relaxed/simple;
	bh=koauvZYWrVLIz/tiqY+SnR8+k5MqcqF4T9Dx5OILdX0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LAwp5ht4vTNfY/2WXb2ZylGUFPG+QqRphtvLpXSYzFEfhAA4iwCNSZBY/v9QM1ucu+G6dcaFkrOoQ3yzC3qiD08+TaUYQjHZm102UIV48m4D5AzUF19ANhDGn/hbzI6WdKpX+elZxkW10NjOiODCNHCzjOIUv0rEfYBimWEpi1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVxE6XOD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9323DC4CECF;
	Fri, 15 Nov 2024 04:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731645622;
	bh=koauvZYWrVLIz/tiqY+SnR8+k5MqcqF4T9Dx5OILdX0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MVxE6XODLMc8q/NUmtPbb4LwafASgkSFJJvqnQ6eorHUiTQ+PEpmnYTjoDshHmI/x
	 KAd3fwN1dIbs3sYNoFrocXP2x/+wfQQJoBn9Y5X0qVLKi8vuxaaemne2HrSKiy1/7J
	 IK3uwOtkmxkknbc7WCuCOKg+ZVxxbbop4n+uv1tn7nED7IkhWEB85/94i2J9Zy3CZ+
	 u2F0818dH3vJS3n0CBgAG0VDtSWDb89q99svpx11xVWNSku0JQR/wguAamck1tLikJ
	 rOZPwj8rnnj/1RNf4tqi2jMwQ9wsExpUL70Li60v5t6JxwjmahLnrcXZCpREtcXenY
	 U0Ax90Wy6AZcw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B543809A80;
	Fri, 15 Nov 2024 04:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] net: make RSS+RXNFC semantics more explicit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173164563325.2151510.15712104184262372756.git-patchwork-notify@kernel.org>
Date: Fri, 15 Nov 2024 04:40:33 +0000
References: <cover.1731499021.git.ecree.xilinx@gmail.com>
In-Reply-To: <cover.1731499021.git.ecree.xilinx@gmail.com>
To:  <edward.cree@amd.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, ecree.xilinx@gmail.com, netdev@vger.kernel.org,
 horms@kernel.org, andrew+netdev@lunn.ch, shuah@kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 Nov 2024 12:13:08 +0000 you wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> The original semantics of ntuple filters with FLOW_RSS were not
>  fully understood by all drivers, some ignoring the ring_cookie from
>  the flow rule.  Require this support to be explicitly declared by
>  the driver for filters relying on it to be inserted, and add self-
>  test coverage for this functionality.
> Also teach ethtool_check_max_channel() about this.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] net: ethtool: only allow set_rxnfc with rss + ring_cookie if driver opts in
    https://git.kernel.org/netdev/net-next/c/9e43ad7a1ede
  - [net-next,2/5] net: ethtool: account for RSS+RXNFC add semantics when checking channel count
    https://git.kernel.org/netdev/net-next/c/a64499f618b2
  - [net-next,3/5] selftest: include dst-ip in ethtool ntuple rules
    https://git.kernel.org/netdev/net-next/c/b2d5b4c46856
  - [net-next,4/5] selftest: validate RSS+ntuple filters with nonzero ring_cookie
    https://git.kernel.org/netdev/net-next/c/e9e8abfec214
  - [net-next,5/5] selftest: extend test_rss_context_queue_reconfigure for action addition
    https://git.kernel.org/netdev/net-next/c/29a4bc1fe961

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



