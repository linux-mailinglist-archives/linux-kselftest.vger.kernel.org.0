Return-Path: <linux-kselftest+bounces-4470-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA4D84FD0B
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 20:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4141B2AA0D
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 19:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DBD84A3E;
	Fri,  9 Feb 2024 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdoPaL12"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9F384A2E;
	Fri,  9 Feb 2024 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707507630; cv=none; b=rzgjabh/QWpS38fOWYdRWo/D5psOvRZUTJ7wcoWA7LjEAf3hu7X1dqTqtUxh1cQwLIlWL7OhFcnDnXGcRFi5MRYaPASy/HoxPE+ApdAqbYlVKabmo2xVb+8wMCrj2zriAONEjnVBta1D3kywPTKp2u9gAYcgAgM9LX2QinneRQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707507630; c=relaxed/simple;
	bh=qPrS0ioU3i6TaKBKVtWxqyS9Eqimis227UIgink+pKU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mQLeLLbYS1FVhwbn1gO1kLhjiiQoMhLG1CFbhdephLgGBfLwzKBVQpjcxvHzgulDuRvTmSBgT31YcAHIbNfYe4vAT1IrzBghLPYmctNBNOuqZoF8mr+dQrfaI87UtZOv41MvUVgWS6mrFpQTb9kIs4sSjmKZrCFpoutzAlfkwtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdoPaL12; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EAF66C433C7;
	Fri,  9 Feb 2024 19:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707507630;
	bh=qPrS0ioU3i6TaKBKVtWxqyS9Eqimis227UIgink+pKU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PdoPaL12CaT7lmTrzyWhbq5aleoc1+KCJK9JALNsQVpdlzrJS3+4a0/yjGt7p5r9m
	 lYmgoBttQ7umRpdpXKScz1jhTUsgXLWdqkOzHP9LLaLZgX/+pTpfYZMSulbPlB9M/B
	 9pnxh9/6me45fJznfIxWP3JBJM6bfSviEmTj5ce6p8mdCuHdEsDuPKumyjUVzwfElT
	 Q9kwkbJAyAj8eq/RW9xC5B2JwnTybIkpXlcm4CpufO6Njv3K9XY1Htq3Fcn2D8NiZP
	 0YShKx6jlpi3Sw5I4CwVBelSgEqsODm2TCjKapoJbvj+laGm9KvoYMbBt3/Y2Tl+Xa
	 TWNWD5b2RhbBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CF713E2F2FC;
	Fri,  9 Feb 2024 19:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] selftests: forwarding: Various fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170750762984.32352.12717080902255833557.git-patchwork-notify@kernel.org>
Date: Fri, 09 Feb 2024 19:40:29 +0000
References: <20240208155529.1199729-1-idosch@nvidia.com>
In-Reply-To: <20240208155529.1199729-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 shuah@kernel.org, petrm@nvidia.com, razor@blackwall.org, liuhangbin@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 8 Feb 2024 17:55:25 +0200 you wrote:
> Fix various problems in the forwarding selftests so that they will pass
> in the netdev CI instead of being ignored. See commit messages for
> details.
> 
> Ido Schimmel (4):
>   selftests: forwarding: Fix layer 2 miss test flakiness
>   selftests: forwarding: Fix bridge MDB test flakiness
>   selftests: forwarding: Suppress grep warnings
>   selftests: forwarding: Fix bridge locked port test flakiness
> 
> [...]

Here is the summary with links:
  - [net,1/4] selftests: forwarding: Fix layer 2 miss test flakiness
    https://git.kernel.org/netdev/net/c/93590849a05e
  - [net,2/4] selftests: forwarding: Fix bridge MDB test flakiness
    https://git.kernel.org/netdev/net/c/7399e2ce4d42
  - [net,3/4] selftests: forwarding: Suppress grep warnings
    https://git.kernel.org/netdev/net/c/dd6b34589441
  - [net,4/4] selftests: forwarding: Fix bridge locked port test flakiness
    https://git.kernel.org/netdev/net/c/f97f1fcc9690

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



