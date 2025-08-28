Return-Path: <linux-kselftest+bounces-40234-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 176DEB3AE98
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 01:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DAE8987078
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 23:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5512E1751;
	Thu, 28 Aug 2025 23:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFOa59f7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C192E03F2;
	Thu, 28 Aug 2025 23:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756425011; cv=none; b=PxKsXf3zfr1uEeppjJ77uStOohrZJW+vYqJurzADVI2Fcpdl1J2o3UgiXv+lj1FBPd9vrCEMphzvnzF4KwngBQsbeiPl1f7qo10D0TRBKxAEr2eurdXUehf4gCDVSKks8zhgucvfaws7J78dzV6leTo2AF87s5N0jRLiSe/X+Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756425011; c=relaxed/simple;
	bh=hEvMwcHaMYxbctp+pq/7lchD2/F1IewpZFnz5o5psRs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JnV5hV922ffnWv1bADbA6QrSPnj4je4DpFUPOPH9Ygfm2NFrNupjLHhkCL51YwxE/fliVU61HyK7Yhfg9KAvYGR8WPq8ByQu7pynaDwkdSCPR2ScbD4MjjcU8oXc2KPS/OfzWnPxhhbIe68EGPtBS5q4tDQWlcIgCi0eR+iExvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFOa59f7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2E2C4CEEB;
	Thu, 28 Aug 2025 23:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756425010;
	bh=hEvMwcHaMYxbctp+pq/7lchD2/F1IewpZFnz5o5psRs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JFOa59f7aZ1YDdd4mtzu4pKJz0KEVBY0XURRBJxwigqPHdi0bViRNJlQWqvcAvBdx
	 Qprb9zzms1GHfHLY2/KZY2+T0FUqvqWEjTuBY5ylILBqyXMuK2Lo51DJQoxAY54tKG
	 vb8GoIfyprgFCu/mw0J/0TeDEU6rgOCJXkqsvL1JOQ2O3swU3Gl0lzbDbycDrMBwg6
	 Qe76lUfFnie3R+Y07QOrKiOR1LCCnHmEr/qQ9d/msZOcoHyNAffSs4xISurl2Af7UX
	 cyGId69dvO4RGiMmnrB+ezFiYLi1cpPplxU2EPQsjfsJRImEXGsQhF9P+A6CCHDpqP
	 i3jujxc/GR0zQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACF3383BF75;
	Thu, 28 Aug 2025 23:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: drv-net: rss_ctx: fix the queue count
 check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175642501750.1650971.7067943520017959776.git-patchwork-notify@kernel.org>
Date: Thu, 28 Aug 2025 23:50:17 +0000
References: <20250827173558.3259072-1-kuba@kernel.org>
In-Reply-To: <20250827173558.3259072-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 ecree.xilinx@gmail.com, gal@nvidia.com, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 Aug 2025 10:35:58 -0700 you wrote:
> Commit 0d6ccfe6b319 ("selftests: drv-net: rss_ctx: check for all-zero keys")
> added a skip exception if NIC has fewer than 3 queues enabled,
> but it's just constructing the object, it's not actually rising
> this exception.
> 
> Before:
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: drv-net: rss_ctx: fix the queue count check
    https://git.kernel.org/netdev/net-next/c/c158b5a570a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



