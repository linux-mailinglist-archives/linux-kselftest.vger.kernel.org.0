Return-Path: <linux-kselftest+bounces-33443-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A8BABE8EC
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 03:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75D514A3FE6
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 01:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEB817C21B;
	Wed, 21 May 2025 01:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZHmE8Dx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD32417A586;
	Wed, 21 May 2025 01:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747790416; cv=none; b=Rvgak7JIwkhS20w/REcor5HmC8lilRSADPr9e+GcEqF508uazq2aDxBq8Acz8jxAp8s7WKk/dFvfa9cBy3pPVYOHYqtXtMrU3n3jQspXVAhUT8Yize03rAbC+uQbnfYRAn0X3kGIM51ycyfpaqG8qZep+vCZ7n0EuBV4UwNnpuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747790416; c=relaxed/simple;
	bh=l6JuRbFmYACfY6KQAyzsurYTz8i9YitaZrvWgtMs8XQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GcwJF4TwFmZkHQ9rkF9LLbDGhCOnPuo/Ybe4Syw9y58fR3Zcg30D+4BzAju0qsbQkBs/v0aZbPj5p2wX/jMvrnGlkMLXu+lT9mDywnDKY3T/8fSfdA1ZqgATU8uZQIT9wttMbt2VgjVAr5Qo2srNsBxxbKbWZOAcTg71bhZZx/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZHmE8Dx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD0EC4CEED;
	Wed, 21 May 2025 01:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747790416;
	bh=l6JuRbFmYACfY6KQAyzsurYTz8i9YitaZrvWgtMs8XQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fZHmE8DxN3HlVSCLsm4+ZeQXJkdbopEamiOAvoTr8rcOUffVb1qijw8YS2ILxuq2L
	 yUkskjnG/4iGOf6p7bg41wwnHu1BsyHRQd63ZGZmipTigplUjoiI5rS9bOOlJom7/I
	 Gic6vMkLdDcmyT7QOfaXFq8YQE183xAPUg1zMEvN4A0SYuK0ljmyx/iGWGXcU3fQj8
	 OZzbUDqJjywpehKSXxjBlPZCctX22YLeSLR9Va4OwQJyLFHQwpZp/+er61LPird+2t
	 0kI/Y4LQItexdOKXUDwNEQqI0Scerqcz+FDo2mcdDRCwoJue28IJBUl4zZv3EzS1ho
	 c0LsjyP9LGUog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BCC380AAD0;
	Wed, 21 May 2025 01:20:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests: nci: Fix "Electrnoics" to "Electronics"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174779045174.1526198.15563146251440869750.git-patchwork-notify@kernel.org>
Date: Wed, 21 May 2025 01:20:51 +0000
References: <20250517020003.1159640-1-sumanth.gavini@yahoo.com>
In-Reply-To: <20250517020003.1159640-1-sumanth.gavini@yahoo.com>
To: Sumanth Gavini <sumanth.gavini@yahoo.com>
Cc: skhan@linuxfoundation.org, bongsu.jeon@samsung.com, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 May 2025 18:59:37 -0700 you wrote:
> Fix misspelling reported by codespell
> 
> Signed-off-by: Sumanth Gavini <sumanth.gavini@yahoo.com>
> ---
>  tools/testing/selftests/nci/nci_dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - selftests: nci: Fix "Electrnoics" to "Electronics"
    https://git.kernel.org/netdev/net-next/c/20d9b73217c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



