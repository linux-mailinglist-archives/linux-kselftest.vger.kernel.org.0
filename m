Return-Path: <linux-kselftest+bounces-33444-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0942ABE8F2
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 03:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8073F1B6867C
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 01:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDF218D63A;
	Wed, 21 May 2025 01:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrVP50T0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DB018C002;
	Wed, 21 May 2025 01:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747790419; cv=none; b=HR5s4THO+OVEvB/1KvHoG+7lG0h09tpKrFFOoVDK9jJAgsHwH6fRNO1XTOmhvdus1hbw34ApRtPWfYUJ0Sp98klJQHrYly7NjTwDfttnpGibrPLMIM5jxmwhUv5c+Uc82L3dLdTUJZQnR19h8B5RiilRcp2lIeih+5luLYF3p20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747790419; c=relaxed/simple;
	bh=LNS1vEUuMVV9aSljVz0rghhANekQi0j1/WToBCW6RQ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mEqMF//lvPI1MLf6uQor8QWEYTAm+o4pgaZpsx03d1y/p0Nv/NauydBBJ8xh+u0MIvt4oDWl1epKlK+ZmOlplNmIsVgjjS4EO12l33EDr94aukI+kcFySUmiQKAhiK24tVGs5TQfahzcAKsGlV9au1tDJlSET6xgP3e/jnRBsOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrVP50T0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9895CC4CEE9;
	Wed, 21 May 2025 01:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747790418;
	bh=LNS1vEUuMVV9aSljVz0rghhANekQi0j1/WToBCW6RQ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VrVP50T03j67dvpY5M1u1w72AT0KYlLtXNvrKQ8eF+PvrrsCDTqfxAfBsGLGlgvRt
	 93a/XykLLi0ribvvQqHql/zDQQXKRJW4XPDE8q2ObdXIN5HzajpUWTbl8T8DTLC5tO
	 8sRs+P12V73cGx61qDbKlEGaZU60nrxcFu8xWqkjgFArCOhWYoXznus1jkWUg7cgeB
	 Pa3PLTmLumbsK8MEkzGB6kAgODaqyvWc6f/jUHMAPdJdL5bo8aCRX73BOwH2jtHBH7
	 CnPFZsHbAYajehsjm/U6fbIFKD99A1NMJibxvWAmYml3V5kIDGtQexw20NE8mCiNoY
	 gaLLGzBg2AoIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDC1380AAD0;
	Wed, 21 May 2025 01:20:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] selftests: net: validate team flags propagation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174779045449.1526198.4318547635095706511.git-patchwork-notify@kernel.org>
Date: Wed, 21 May 2025 01:20:54 +0000
References: <20250516232205.539266-1-stfomichev@gmail.com>
In-Reply-To: <20250516232205.539266-1-stfomichev@gmail.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 jiri@resnulli.us, shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 May 2025 16:22:05 -0700 you wrote:
> Cover three recent cases:
> 1. missing ops locking for the lowers during netdev_sync_lower_features
> 2. missing locking for dev_set_promiscuity (plus netdev_ops_assert_locked
>    with a comment on why/when it's needed)
> 3. rcu lock during team_change_rx_flags
> 
> Verified that each one triggers when the respective fix is reverted.
> Not sure about the placement, but since it all relies on teaming,
> added to the teaming directory.
> 
> [...]

Here is the summary with links:
  - [net,v2] selftests: net: validate team flags propagation
    https://git.kernel.org/netdev/net-next/c/f792709e0baa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



