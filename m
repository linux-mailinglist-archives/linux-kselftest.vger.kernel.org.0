Return-Path: <linux-kselftest+bounces-19077-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE5F991267
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 00:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B0C61F221A7
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 22:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2701B4F14;
	Fri,  4 Oct 2024 22:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3b0Cftk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D364B1AE001;
	Fri,  4 Oct 2024 22:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728081627; cv=none; b=RD0ig5Q1og9F7nIHf+zU2fVTMPap7TzeWqwgQtr2Mq9MR/QstXnscShIYolifcL++39NU8tkUWJtctcslBK91u1VTe/ZY4xRgSwz3AOGuE+CPDnYQM8cr1B3JegV3TT/Y4TORXSG4//88bFDJFE5Y5HQhVpeUmhkkOKFk/Ik6H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728081627; c=relaxed/simple;
	bh=E0cl1MWQFMnLMnbueXFD6n62tk4McIYl3BA6y8VOzA4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sJrbh8sxJPo7p7X/VI4LTHYFNKvSFo8jxW8T/4FDDV8mskqHAFyDHT9Bgduw//Qedp4KxzQkO5CX7C+rK+rxNh3gbPv8+5o201keiWx18LqVDiX9R5FFSVgUke6UDKITuTC7QGfskZ3SJ3DftsZ/DUtdRyPglYzt1O1ZQyKf02c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3b0Cftk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6143EC4CEC6;
	Fri,  4 Oct 2024 22:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728081627;
	bh=E0cl1MWQFMnLMnbueXFD6n62tk4McIYl3BA6y8VOzA4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d3b0Cftkfv9Qm7kQzjNsCJtEOqsnb+QHqpauQYSPZl65bMYwmYSJLlPidryorh5oR
	 WHmiOEGXC8d8ggu2/swvl2GwobjXwC1IOhN7Uf5DjZEv2eRLY3b2jFw6vPrde6kWDL
	 rT6NTtla7rcF/8ASnttP1odP1N+C4Kjt9o209M0O4kv4gV+k97p8AnM25K1FG/22hN
	 xnpjlE7yo7pZyN7CNmv2gQxxI9u3Lia1a6PuPHKfR4swYcVgfThSEPtI7jgFGEzndg
	 9B1XMVsGjLTFCFlNGoXUaZcwN5AG+vd07YWFcZVKGYG/TOQq2gmieGarHbx3SsdfhM
	 iNLiIXd4ZmWqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 341FA39F76FF;
	Fri,  4 Oct 2024 22:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] selftests: net: no_forwarding: fix VID for $swp2 in
 one_bridge_two_pvids() test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172808163101.2763206.11735139173851211123.git-patchwork-notify@kernel.org>
Date: Fri, 04 Oct 2024 22:40:31 +0000
References: <20241002051016.849-1-kac.ludwinski@icloud.com>
In-Reply-To: <20241002051016.849-1-kac.ludwinski@icloud.com>
To: Kacper Ludwinski <kac.ludwinski@icloud.com>
Cc: davem@davemloft.net, kuba@kernel.org, vladimir.oltean@nxp.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, petrm@nvidia.com,
 horms@kernel.org, edumazet@google.com, shuah@kernel.org,
 liuhangbin@gmail.com, skhan@linuxfoundation.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Oct 2024 14:10:16 +0900 you wrote:
> Currently, the second bridge command overwrites the first one.
> Fix this by adding this VID to the interface behind $swp2.
> 
> The one_bridge_two_pvids() test intends to check that there is no
> leakage of traffic between bridge ports which have a single VLAN - the
> PVID VLAN.
> 
> [...]

Here is the summary with links:
  - [net,v5] selftests: net: no_forwarding: fix VID for $swp2 in one_bridge_two_pvids() test
    https://git.kernel.org/netdev/net/c/9f49d14ec41c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



