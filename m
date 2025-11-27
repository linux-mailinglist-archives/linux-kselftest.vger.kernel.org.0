Return-Path: <linux-kselftest+bounces-46597-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D38AC8C6CD
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 01:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BCB13B3031
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 00:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB17A1EB5C2;
	Thu, 27 Nov 2025 00:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GM/q5umk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0ED14B977;
	Thu, 27 Nov 2025 00:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764203445; cv=none; b=X7MAhRl1XQ7JPEOn1yQJnZisUz34xeeFSEDXsL0vem8cI/E4q1rkarq2V+bFwF79Z6Jon6UQJoZA2YHgXkVs49iySv8puE/9IITl1L7wUonPMGNr3iAIfrVIJ9JcUkkgyHFm0K/OQkzGD1fhWQWrBP2+SveQ7BLPtpYPK2Z7ZVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764203445; c=relaxed/simple;
	bh=V0196ynFBYC1b+wV/oNiVxE5CbD62NKpfYCvkobiNeY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GBGQc45HMnTV2gbfmoM/dTgtV/rvqda0Mx3V+zHFel6kDn2snfAN0SJaJeBJ2eq5qU9K6g+0cQaYb1+B3QpFqW09y+a1W7Lk2Po2T1d8tV09ORgvdDW8jbIe4aA9roOBHCX0qtG0O84Vd14f8AvQWAQ3BAT7xTAyCwy9ydvGITY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GM/q5umk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5C1C4CEF7;
	Thu, 27 Nov 2025 00:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764203445;
	bh=V0196ynFBYC1b+wV/oNiVxE5CbD62NKpfYCvkobiNeY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GM/q5umkGDaeAwuOnTZduVPolSNnD4H4euUHKX2elkgGH3FRZ8FAgjUjLTP5kY5I8
	 +9hWMp7KsVt7jWrGJeYewuxxRO+2Cj7PTidgZK6BF24nptvavURLwnUc4oyYeiE0G8
	 tCd8UE2h4soqyMWHS1NETugwF5DlTQd1CgTQuBn61dIO1CcueYdFB/ttxO2bTRB5Jv
	 salNytaEh3FrhlyhoDWPRVT21hp3KtB9Uh1pbuQ5eSkAW3JetW/nMD+o6HV8rE+JWd
	 rbPO7FwIenY6CYzTTk3vrRLj4WpB2ALY4Shd16kxx5WW4vJYChNztpt9o5aHrbSxbQ
	 PaSWTYLplTFSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF37380CEF6;
	Thu, 27 Nov 2025 00:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] selftests/net: initialize char variable to
 null
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176420340676.1898314.13893932035551539532.git-patchwork-notify@kernel.org>
Date: Thu, 27 Nov 2025 00:30:06 +0000
References: <20251125165302.20079-1-ankitkhushwaha.linux@gmail.com>
In-Reply-To: <20251125165302.20079-1-ankitkhushwaha.linux@gmail.com>
To: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Cc: willemdebruijn.kernel@gmail.com, kernelxing@tencent.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Nov 2025 22:23:02 +0530 you wrote:
> char variable in 'so_txtime.c' & 'txtimestamp.c' were left uninitilized
> when switch default case taken. which raises following warning.
> 
> 	txtimestamp.c:240:2: warning: variable 'tsname' is used uninitialized
> 	whenever switch default is taken [-Wsometimes-uninitialized]
> 
> 	so_txtime.c:210:3: warning: variable 'reason' is used uninitialized
> 	whenever switch default is taken [-Wsometimes-uninitialized]
> 
> [...]

Here is the summary with links:
  - [net-next,v2] selftests/net: initialize char variable to null
    https://git.kernel.org/netdev/net-next/c/af7273cc7ae0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



