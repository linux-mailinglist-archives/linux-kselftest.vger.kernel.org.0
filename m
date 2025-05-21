Return-Path: <linux-kselftest+bounces-33442-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A56ABE8E5
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 03:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766C43B6E29
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 01:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2634F156C63;
	Wed, 21 May 2025 01:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVPK8R68"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC115155A25;
	Wed, 21 May 2025 01:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747790414; cv=none; b=Sv42qm9pUtJcSFWVW+nMG/iyQx71jmfBxfK818zVoiFU+BXVx3DmjXAyvMHk5H/ZDkzgw4UgZ+j8dRTfsJ+4kh3q3wZo6DK3V7xiOozI8j6C0YTp75tJ0VYocU78m54ZgzCVphmrSiP3Rp5MC0WI5ZCWI3sH0m9gt7AcyhjSAwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747790414; c=relaxed/simple;
	bh=DE3Ma9IeBeU/CcL8Y+HQg49sDZd//VTDF1VKBTyPgzY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jfyjzocXCdBmT8OVjz8Q7pfOQtjlkbZkXnQ74yENwKRCcbc3aFChmatSSIJXp4LWIXKm+yfJFwpON4Qg4NQ1rH/KBoRZfnzX0FYlkr3MQAH1zZHYGFU3zJicX7dFuErXw+kh4zdxSHq/sZlHERroEAWuL56CiZI46+7y8p4W2XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVPK8R68; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58CDFC4CEE9;
	Wed, 21 May 2025 01:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747790413;
	bh=DE3Ma9IeBeU/CcL8Y+HQg49sDZd//VTDF1VKBTyPgzY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pVPK8R683hVFnhNI3TVh8bJnKwideVH2ASuvfSxxfjb45p7MDGhqwnkAx80A5PwN7
	 pqRlALypYKLselFb4GbOIOG0O06rfxYw9yVHSccA3vX3JgB9Drid/8fFi5ZdiIdjJZ
	 z8ojjbk6WOcXfdTk8QmZYe3t+4ZiaeWTrOLr9OGKnKbc5p45GJfevR0YN+0avtQ1qM
	 hamynUg4Z6ODCnboRXU1tOFFSiOCVNFokbwkpgi5tEya3SWpjHZ6Sb7SLcpKfp1KkJ
	 Ff5k4BZzIY40cn5GUQrc2fSxTj+SiOdqvG4P2v1g8iI8NIDortcoXSZjnpTNsX5rPM
	 kCMU+hs9YZaZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BBD380AAD0;
	Wed, 21 May 2025 01:20:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests: net: Fix spellings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174779044899.1526198.112152498755013860.git-patchwork-notify@kernel.org>
Date: Wed, 21 May 2025 01:20:48 +0000
References: <20250517032535.1176351-1-sumanth.gavini@yahoo.com>
In-Reply-To: <20250517032535.1176351-1-sumanth.gavini@yahoo.com>
To: Sumanth Gavini <sumanth.gavini@yahoo.com>
Cc: andrea.mayer@uniroma2.it, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 May 2025 20:25:33 -0700 you wrote:
> Fix "withouth" to "without"
> Fix "instaces" to "instances"
> 
> Signed-off-by: Sumanth Gavini <sumanth.gavini@yahoo.com>
> ---
>  tools/testing/selftests/net/srv6_end_flavors_test.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - selftests: net: Fix spellings
    https://git.kernel.org/netdev/net-next/c/6a7e8b5d6328

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



