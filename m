Return-Path: <linux-kselftest+bounces-44469-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA83EC22CE8
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 01:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309983A6088
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 00:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83111F1538;
	Fri, 31 Oct 2025 00:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOCsk7U8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC641EEA3C;
	Fri, 31 Oct 2025 00:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761871241; cv=none; b=l3nY3+uysnPKXgEh9MoQv4tcykKU8F6YyIUlKXUDpou4h0gFQlTP6AMIl5UQsXWSxfIthR0MZY0KrAv6EckQZiSYNcoufC538fP/sIPY8QdqfWyGN2XVPEFyp9NIqZVXF6+j0pTdRZGJVWw68BwSdEyYh5fpmj6rY78KiDJ0cIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761871241; c=relaxed/simple;
	bh=73eOEv5LOq9DtRsvcl7Te7yL0QpSrS1yF8Pnc4rCdpg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lj9HrYRw4WEeJitZ1bSHbB5lbn6Jm/4mM8OQonebcQBamk6/Ur+Pbe9LMEta4XyrKG0bFH7/zKnEIjK19HizDC3xWYDHu17LFfb77a2Txe3X2h25xM2mvNH04omoN27zt434X6oaW92+i0R4w3YGdtots7Mnj8RemSRlb5F8IfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOCsk7U8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BECEC4CEFD;
	Fri, 31 Oct 2025 00:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761871241;
	bh=73eOEv5LOq9DtRsvcl7Te7yL0QpSrS1yF8Pnc4rCdpg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aOCsk7U8MHGvTeEQi2RIfEkMH6jQQmsJSmaKRY1p/MIrR4a6hU/d/o6PYUHXsM9PW
	 GnhTvlJ3/JeNw7KcvhwcIuCvT2FY3Nc9ogIs20SbMiyONC6B5rKM46RnJK1WFTrPxy
	 xdmgGThbAbtmpsqcYaPdhGrarGCQk3+cvqrOH8gFBj6Ne5JMReHamAjsuWE1lyNOA6
	 Le9ZBiT978Bf+aX/WeG4cDkl4ZL9n7d7cGTD17/blU6szGe20P+5ybFzKnlNJUBMK1
	 Spi8OvDOBWWG8x0ns5QV6e/1mxvpl0hKvQMMZ1SuAre9MBxWStfmW0XvqkzPUI+6OD
	 Ic7ReP3SsNuuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD2C3A78A6F;
	Fri, 31 Oct 2025 00:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] selftests: drv-net: replace the nsim ring
 test
 with a drv-net one
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176187121774.4089032.7067379874112472585.git-patchwork-notify@kernel.org>
Date: Fri, 31 Oct 2025 00:40:17 +0000
References: <20251029164930.2923448-1-kuba@kernel.org>
In-Reply-To: <20251029164930.2923448-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, andrew@lunn.ch,
 shuah@kernel.org, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Oct 2025 09:49:30 -0700 you wrote:
> We are trying to move away from netdevsim-only tests and towards
> tests which can be run both against netdevsim and real drivers.
> 
> Replace the simple bash script we have for checking ethtool -g/-G
> on netdevsim with a Python test tweaking those params as well
> as channel count.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] selftests: drv-net: replace the nsim ring test with a drv-net one
    https://git.kernel.org/netdev/net-next/c/ecca75ae5ae6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



