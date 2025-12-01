Return-Path: <linux-kselftest+bounces-46849-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BE7C99247
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 22:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7452A3A3706
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 21:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD55226ED4E;
	Mon,  1 Dec 2025 21:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkYAjxhh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859972080C8;
	Mon,  1 Dec 2025 21:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764623593; cv=none; b=UEDyo9mXXMREBB7Aca0wPIbWGqEa7LYxxXvp0Oa6vea1lNOcOE7BRLrlSdJkvqA7lYYpw6VlATiP1QiUEGGrLrXF8JLZa5UjlQaVahmBD7RbZSB4vJXBJ37Frnda87t6EEnSRAuLo2Rx5LapwPsHihv3FletrfleyXOBspWq7fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764623593; c=relaxed/simple;
	bh=F84Wp9ZacxJuA8nQ5UNgVTWn176hOYaZrODhvvrM8q0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VDMTB95rNtTPCWT19Fb6PHYwzQfh+xe7o/uxjCfHLAsUy2mQqFxLLQwAKPTnY4ASnS1aLf2f7Tw/oGDvwu5/Y0hL1S+1SZEq9cpvehAtmbDPPrDdpywHqUbjbDPpKxD8cgD45BqKuSQq+Wgjifz4WHlbYjf2FBuf2ey526SRUbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LkYAjxhh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2BEC4CEF1;
	Mon,  1 Dec 2025 21:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764623591;
	bh=F84Wp9ZacxJuA8nQ5UNgVTWn176hOYaZrODhvvrM8q0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LkYAjxhhzXd/1XiJ+h9Fk+LYNuLW+MqWnYbI7kVdOL5gmYMCeADgHqxKxJaVHceXs
	 nqYEYzaBvAlcqiD8hOCsSNvULZ7ceAZNoMXJDhpV76/kjknXxZS6k3WTLNUCm/wtgH
	 t8AgTb4IevI08z4xjzBFXxj06q9wr5H50gKUsr/VoeEnNg1kilqXZ5+Gcmv+ekp5pS
	 Cr6b2bfMRU8AmnQwg8gvttA6/r1LDCsf7iCGqw8WoBMzrlaxd0CRPdeuTQ8mxzmX9D
	 7OhigDpHi2e3PqVDzsJ2jrAI4l2XsayqSYaI+GPM8R6DHSNji+JJlXxB9orF/cZYpi
	 jWB8Md6taFgIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2DF9381196A;
	Mon,  1 Dec 2025 21:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: net: add a hint about
 MACAddressPolicy=persistent
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176462341180.2539359.6028588116142220492.git-patchwork-notify@kernel.org>
Date: Mon, 01 Dec 2025 21:10:11 +0000
References: <20251127194556.2409574-1-kuba@kernel.org>
In-Reply-To: <20251127194556.2409574-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Nov 2025 11:45:56 -0800 you wrote:
> New NIPA installation had been reporting a few flaky tests.
> arp_ndisc_evict_nocarrier is most flaky of them all.
> I suspect that the flakiness is due to udev swapping the MAC
> addresses on the interfaces. Extend the message in
> arp_ndisc_evict_nocarrier to hint at this potential issue.
> Having the neigh get fail right after ping is rather unusual,
> unless udev changes the MAC addr causing a flush in the meantime.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: net: add a hint about MACAddressPolicy=persistent
    https://git.kernel.org/netdev/net-next/c/aadff9f76639

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



