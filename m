Return-Path: <linux-kselftest+bounces-24092-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E447A06C9B
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 05:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE58F3A51D9
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 04:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B430F16DEA9;
	Thu,  9 Jan 2025 04:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJ+vgLj9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6471459EA;
	Thu,  9 Jan 2025 04:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736395211; cv=none; b=h4v6fDe064jYXCky1aFQeHi93MXxi1BDzyg53VsHE0h4W1xnVrmh1ljFGMTro01tkqOXdBlwxxoyIfyWFxBr7ndVWJB80eimZfSygVDu2t/2S/dhKrovVzoRnOF+5mDEgQ+ca292zxTeRJi2dnshJI4k9s/BhJCQXmAo2nBmW9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736395211; c=relaxed/simple;
	bh=cy+lm0+t2abaTB3qODLm04gs7nYlxuCOvM6DUO8st9I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IuKgWNKpA/eKbI6lAF6YTex3QRmFTzwWaIqNfRohtwq82iG3BFgRqtuyQbAWV4EMuMV15VvpEGvS82rdonxQKCP7DaeO5NKvo782EaRHxZvwumCkT6KkGaJJEzpIPYZ7xjzDZV7fRHVviHP9/Xu+A3U/Hyq7cXUfZBSjCTfd0M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJ+vgLj9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19F8C4CED2;
	Thu,  9 Jan 2025 04:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736395210;
	bh=cy+lm0+t2abaTB3qODLm04gs7nYlxuCOvM6DUO8st9I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aJ+vgLj9nBL5LsCxG1kejY0N2E6aoc/JINcDVp1UQLTQ3vW0Iz/PEcuMKRTshBVWa
	 thOh+H8ma3/F8kAfZppC/+gNqgAcEOgP1dn+jZexgmDuk1znDpjf0Ptaq6UVfRXOlh
	 je8rnqfV612Uo8c/4lxRBWjJNABnN8tBJvszdgayKrfWt8FeBiv41vaffBKM1650Ym
	 6aweD7FkcFMkeB2AK2WAn0n+GLP8FiL0du03D0zSFl+ELYv3Ad1Qp4B7jJzMLE6OeO
	 gZ/SGZmNDIgk7lFxhMLY6mJVhiQJiGDgjkEii8v/azjJBTspIJVLeAGNHtVYFaRpJF
	 JxtLMJombIBwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 715EE380A965;
	Thu,  9 Jan 2025 04:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] selftests: drv-net: test drivers sleeping in
 ndo_get_stats64
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173639523196.866749.901434967406481517.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jan 2025 04:00:31 +0000
References: <20250107022932.2087744-1-kuba@kernel.org>
In-Reply-To: <20250107022932.2087744-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, petrm@nvidia.com, willemb@google.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  6 Jan 2025 18:29:32 -0800 you wrote:
> Most of our tests use rtnetlink to read device stats, so they
> don't expose the drivers much to paths in which device stats
> are read under RCU. Add tests which hammer profcs reads to
> make sure drivers:
>  - don't sleep while reporting stats,
>  - can handle parallel reads,
>  - can handle device going down while reading.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] selftests: drv-net: test drivers sleeping in ndo_get_stats64
    https://git.kernel.org/netdev/net-next/c/31eae6d99587

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



