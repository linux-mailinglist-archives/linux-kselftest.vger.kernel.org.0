Return-Path: <linux-kselftest+bounces-19245-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CCE99533A
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 17:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0E72285F3D
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 15:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5CD1E0493;
	Tue,  8 Oct 2024 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARYexqvS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8061E00A5;
	Tue,  8 Oct 2024 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728400828; cv=none; b=aSyvjpTeeVKdhTfmZ6fdjR46tN1y0bQRRjYWdVQHyMlxgRXiDb5CEEXkXdfuX1+SiFV2r5rfrI8LkPoydcBLuIecAD1i3z1r2cs1OqH3OSiuo2tr9/Rt5WAszrCcOR4pugvlmtvAuCU1Jxc6SSL1tNLQb1GJBbUi01pbHTxo5Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728400828; c=relaxed/simple;
	bh=v2Z9B6TjiIMq8y9gwsm3nch3CeOSa/j7vLT0b+ja+Ag=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m8CrghFwy+v8WgvnM/sAZp4kh5kueyhToWE33WvMf6LvXgvM3/dK+sU93ib9nMJxD0wsr3I4SOYLEixKHILGtgK2cpyb5WhT1Npcj9alLVzjcoV8FTucUAifa2tFihDsCjhBhsH3hW8OR604J3Rrb1s73zkbiCFR74ORWukyKLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARYexqvS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0B7C4CEC7;
	Tue,  8 Oct 2024 15:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728400828;
	bh=v2Z9B6TjiIMq8y9gwsm3nch3CeOSa/j7vLT0b+ja+Ag=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ARYexqvSs6KnXCvHIetfMnTYaebcRp4fcwSp2TW8d+zkVzi4o5uyMiH7U7Cwbf3s/
	 z82a1Nu722P28jaQco8+r5P8t4yDFLNBvCPlaBvaHNeq+phH3Muz0xkvclLLhjJ80s
	 B31Ha7g90Dy6H+r5wBk6EaZM1IoImG0l6uEahnO4BLsqH+PRcy6rHaW5EMwKpwufUA
	 q/Lfcix+qHtcFOSUWfzChNb1wp9zqeP/A8oA+aeiqhdAn15saYepZPX5z6ZUIn2fuK
	 t7eqM0qctlqF7qV2nwlJxmDHANAwacpUcj5uDD/M/3LEJQcBKpHTWsRr1hA1u7uoZx
	 79RJ2z4PYNW7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7100C3810938;
	Tue,  8 Oct 2024 15:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/3] selftests: net: add missing gitignore and
 EXTRA_CLEAN entries.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172840083226.583850.125705849314077447.git-patchwork-notify@kernel.org>
Date: Tue, 08 Oct 2024 15:20:32 +0000
References: <20241005-net-selftests-gitignore-v2-0-3a0b2876394a@gmail.com>
In-Reply-To: <20241005-net-selftests-gitignore-v2-0-3a0b2876394a@gmail.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, allison.henderson@oracle.com,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 05 Oct 2024 07:29:39 +0200 you wrote:
> This series is a cherry-pick on top of v6.12-rc1 from the one I sent
> for selftests with other patches that were not net-related:
> 
> https://lore.kernel.org/all/20240925-selftests-gitignore-v3-0-9db896474170@gmail.com/
> 
> The patches have not been modified, and the Reviewed-by tags have
> been kept.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/3] selftests: net: add msg_oob to gitignore
    (no matching commit)
  - [net,v2,2/3] selftests: net: rds: add include.sh to EXTRA_CLEAN
    https://git.kernel.org/netdev/net/c/4227b50cff05
  - [net,v2,3/3] selftests: net: rds: add gitignore file for include.sh
    https://git.kernel.org/netdev/net/c/0e43a5a7b253

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



