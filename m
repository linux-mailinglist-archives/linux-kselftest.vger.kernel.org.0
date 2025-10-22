Return-Path: <linux-kselftest+bounces-43727-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C221EBF9874
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 02:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 79D9C4E9D33
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 00:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F31112DDA1;
	Wed, 22 Oct 2025 00:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwdH/bcZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED40DA944;
	Wed, 22 Oct 2025 00:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761094240; cv=none; b=hIEJnog6BvBtPi9CLqORmALwigJRaLPUw2mJuyci70Uky3Y1lIIGwBH/I+R6cDE7Uo3jzHLlNU7ayKsmTo/7FC5DdWJXJskM1BJaU6nrio49+ODdbjez0oUqGFb/ULXv7uMzPJic85PQeHwqj8Nt9VQasKo0ZpafisxFOSttQaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761094240; c=relaxed/simple;
	bh=uyeq1nQagIkGtivTdpHLo9/uLR6OX6m79fgpchqEuQs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W56ntb4BsKqajBcEaqiTZpF5oAUzasRs6NjKwKA4FXNRz51MU+NburziRzIBgoWikCR2jRrcyJ+T7MQ2IGCjgVbw7zenac3xJ9VvlVLw0yRYVV/ISt9mTnFLTmov2Ra7zzYOcvQxwLQmmmVmkxBNEn7kor3rOdZLvE953K+JtQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwdH/bcZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72253C4CEF1;
	Wed, 22 Oct 2025 00:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761094239;
	bh=uyeq1nQagIkGtivTdpHLo9/uLR6OX6m79fgpchqEuQs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZwdH/bcZx+g6wRU/JpSjieaQe1E1IsgBAk7XfFZ1YdiUfVoP4nAlTA/P2j5pySkjT
	 1Lhrb2P59x5hQwJ9xB9XXJOYzGLdju93T4DZ+hCLGPB6cxGhGzx9zmjOm0ESzUGVFi
	 Ynh/sdZlab3BBP49LOZPBuW/P3VkISgzTuHx5Bz7WHKlYw/pOYMIg9H12B5Z7SSOr5
	 4q1dZ3hpzTySlAeE0pjVkq8YYbBiffU6oVDANzhvSRcTq2oEfDMFe9wQ8YuEA2nPXU
	 TkFvB32Qx5I+A/pM+0Yooclm8iHBcv4K6gouP2q1h+2qVvsNpoYyh24UhLeXOyHLfR
	 eswwyVRjsHHFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADF23A55FA6;
	Wed, 22 Oct 2025 00:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] mptcp: handle late ADD_ADDR + selftests skip
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176109422076.1291118.8078163870194117369.git-patchwork-notify@kernel.org>
Date: Wed, 22 Oct 2025 00:50:20 +0000
References: 
 <20251020-net-mptcp-c-flag-late-add-addr-v1-0-8207030cb0e8@kernel.org>
In-Reply-To: 
 <20251020-net-mptcp-c-flag-late-add-addr-v1-0-8207030cb0e8@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 20 Oct 2025 22:53:25 +0200 you wrote:
> Here are a few independent fixes related to MPTCP and its selftests:
> 
> - Patch 1: correctly handle ADD_ADDR being received after the switch to
>   'fully-established'. A fix for another recent fix backported up to
>   v5.14.
> 
> - Patches 2-5: properly mark some MPTCP Join subtests as 'skipped' if
>   the tested kernel doesn't support the feature being validated. Some
>   fixes for up to v5.13, v5.18, v6.11 and v6.18-rc1 respectively.
> 
> [...]

Here is the summary with links:
  - [net,1/5] mptcp: pm: in-kernel: C-flag: handle late ADD_ADDR
    https://git.kernel.org/netdev/net/c/e84cb860ac3c
  - [net,2/5] selftests: mptcp: join: mark 'flush re-add' as skipped if not supported
    https://git.kernel.org/netdev/net/c/d68460bc31f9
  - [net,3/5] selftests: mptcp: join: mark implicit tests as skipped if not supported
    https://git.kernel.org/netdev/net/c/973f80d715bd
  - [net,4/5] selftests: mptcp: join: mark 'delete re-add signal' as skipped if not supported
    https://git.kernel.org/netdev/net/c/c3496c052ac3
  - [net,5/5] selftests: mptcp: join: mark laminar tests as skipped if not supported
    https://git.kernel.org/netdev/net/c/a9649dfbe552

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



