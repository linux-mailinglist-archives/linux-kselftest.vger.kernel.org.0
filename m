Return-Path: <linux-kselftest+bounces-34375-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBDFACF2CA
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 17:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BCF37AA70E
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 15:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F30C275868;
	Thu,  5 Jun 2025 15:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJnj0oNE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37682275112;
	Thu,  5 Jun 2025 15:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749136213; cv=none; b=W6mPoWaCQZgxX5tY6cHcG858ivbd7juIvpWXPB7fgofRrcHNIkArEZfYgg1GfwU2U+feN1KD4vYQ0uKBnSij6DiFN0iJSUh2J08bXGC90rNRmACg2hl7jd1fL4h2iYbhHoIX8Ky119uNahv8Gj6lF6/OwkFuTgKPP/g5C/eOXcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749136213; c=relaxed/simple;
	bh=WTNctGjW5BDJIOoYwkYNt0gj+yw8FHuW9DyJZiqCFns=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B9HpEvti9BMRewgp5OX4wH1LwF4SNPllAbS02E++6O76kbxb8WhmE27PGeVYfzHeE3lc8g7m7Ppdw9rSC8xXPGOtcW3JDetSx8IQdSkMtBsNcVFPRAmy5KO3IUSiE2lR2cf+PKET7BKkG0mpj4ReXdes3A7bVP2OfmzyXXgBSaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJnj0oNE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DDF6C4CEE7;
	Thu,  5 Jun 2025 15:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749136212;
	bh=WTNctGjW5BDJIOoYwkYNt0gj+yw8FHuW9DyJZiqCFns=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SJnj0oNEM27+aZvAmC1cGVO3HATIALBVb0PmMVSUDNZDucuhAGiCreRa4V2N2PehO
	 /8VqVhiOsjcVK7Rh5iePvL6qkx5qYWdfEQllQ33BjufVvsGRozytT9+p3cESsc0ft2
	 X+0XWKlV9yUrg+/7G25Tm/o0rIj3czswtv8QEpVMG7xFzrWqnifSW/Ztibx4YGXxVJ
	 G+BIuFi+p41rHnahmVn32o7nW0gOIsPFb6xIzlaBR7Y0/rEJ4QvamS94AsWYxnvx9U
	 SYsmdhbcysy0MrRlzcLXCBqxtD+UEmTDqLzkfMZXbgGqq6anX/TbV+Ql5P+XBFqvf3
	 hrcix1snJdbgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD3838111D8;
	Thu,  5 Jun 2025 15:10:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: drv-net: tso: make bkg() wait for socat to
 quit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174913624424.3108661.7877672940176029417.git-patchwork-notify@kernel.org>
Date: Thu, 05 Jun 2025 15:10:44 +0000
References: <20250604012055.891431-1-kuba@kernel.org>
In-Reply-To: <20250604012055.891431-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 willemb@google.com, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Jun 2025 18:20:55 -0700 you wrote:
> Commit 846742f7e32f ("selftests: drv-net: add a warning for
> bkg + shell + terminate") added a warning for bkg() used
> with terminate=True. The tso test was missed as we didn't
> have it running anywhere in NIPA. Add exit_wait=True, to avoid:
> 
>   # Warning: combining shell and terminate is risky!
>   #          SIGTERM may not reach the child on zsh/ksh!
> 
> [...]

Here is the summary with links:
  - [net] selftests: drv-net: tso: make bkg() wait for socat to quit
    https://git.kernel.org/netdev/net/c/e6854be4d80e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



