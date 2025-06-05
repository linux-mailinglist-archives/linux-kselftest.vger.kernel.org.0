Return-Path: <linux-kselftest+bounces-34374-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C60BACF2A8
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 17:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F7E7175186
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 15:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35A62749F0;
	Thu,  5 Jun 2025 15:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrptzWW8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C225275112;
	Thu,  5 Jun 2025 15:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749136211; cv=none; b=k8NmYYDILTz+km8KScXjNGkZiVYAZRJoazaH07PLQdz+rI91bL1BvMe7oaPuMRFPG03tsT3+g4s/pt1XGGCU7Vj+AT2RRwfdT18G7x83nwdbo77ExiT7h7qbKQdOSjXAMLoJdNbSR2MFqLOr8AdUQ/mK1Q5X6PP10B6NMQMJ4/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749136211; c=relaxed/simple;
	bh=5o/Lbq/P6WLh6TRykuh/x7rxSuqLcMyC5Jh0y9sW7ws=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p0F+gfhhOBuOz++C8XKOZrqv+G3rBz94irvgbMfarZbcGYhOXdaS/yJQnQYdXEASPKsabKr5+29ChxbA2YoIbDQlnm4tu9+70Uqq4sN+Yy/nI56Wr4Ul93BKCgOSIG4hAIQLZEV77V0+7VUFGmN8vLmOV2e4tU6Jmu6XxYSeGsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrptzWW8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC8AC4CEE7;
	Thu,  5 Jun 2025 15:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749136211;
	bh=5o/Lbq/P6WLh6TRykuh/x7rxSuqLcMyC5Jh0y9sW7ws=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qrptzWW8an+ZJ3rW67neiIGePnQGDe2JrqJaN5l9wNJ5vIgYlngQsBXr4uFnK93R5
	 K4gMKstq8ui5K3ff2X2xlgw3lCSXrSPWPHzLUZnr2j8EPp9rvNWiMlPKOI79d5t+Xw
	 CyA9HuUBnnHYBqwgLb7NjDcbIyePvRGh7M/H+ftHupZy5U72/0vK9l2XKVVyQlPsY1
	 YfWYCdYhnqWLEr/m8aCQ2eeruoN4IYC+Z5V7GghW+aZ/X7borw8eKkKzv4eDHb39mX
	 A8c3Cog+li3fM27c26UXunxmG6du+2KDlVPLTD63EAq8G6hwfA6IY2xMJC92r6uMn1
	 IWt6HnPVDXdBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C2438111D8;
	Thu,  5 Jun 2025 15:10:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] selftests: drv-net: add configs for the TSO test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174913624274.3108661.4865253656443110447.git-patchwork-notify@kernel.org>
Date: Thu, 05 Jun 2025 15:10:42 +0000
References: <20250604001653.853008-1-kuba@kernel.org>
In-Reply-To: <20250604001653.853008-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 willemb@google.com, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Jun 2025 17:16:52 -0700 you wrote:
> Add missing config options for the tso.py test, specifically
> to make sure the kernel is built with vxlan and gre tunnels.
> 
> I noticed this while adding a TSO-capable device QEMU to the CI.
> Previously we only run virtio tests and it doesn't report LSO
> stats on the QEMU we have.
> 
> [...]

Here is the summary with links:
  - [net,v2] selftests: drv-net: add configs for the TSO test
    https://git.kernel.org/netdev/net/c/7eb6b63aa3c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



