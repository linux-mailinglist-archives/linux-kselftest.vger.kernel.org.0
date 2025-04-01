Return-Path: <linux-kselftest+bounces-29968-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2436A771BA
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 02:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F28EA3A9C37
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 00:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48B6137923;
	Tue,  1 Apr 2025 00:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o59W/nnN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAD7126C03;
	Tue,  1 Apr 2025 00:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743466218; cv=none; b=ddchGjU58t5Nl/AeEszFruzrbAaDLHNUoh2q96o0X0NIx/608xKR1BaiSsfMPvbY6hP3GOSMiGBJaCmUwW6bdrciyYdMcrSeUoUvIJgIUy9D/rwjf+2ZZd3Kxdlf2ilph9ceKS/7VaG6dlUZLIiA4CBeJWP3OBpbK7jeif7HblU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743466218; c=relaxed/simple;
	bh=5QRTI9bWZpF773xhoyYYNn0i3blXsXsmrnbBr/YFvH0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CrlmVBXAFG+jm4sj6S6irs34d6lUCzKyoHpatMIuGSF+UL4Mh4S+2HwXJEqXlrmmPurFs8IqQnceejZUoKefQ+VeVQqJjCTqPLqbDWQSG/bWqvoCjzFsWAkNZOKfd0+0/IcbsSdlk7b8H8nIM2WHoJLkuQDt3jrkoiSWscVd62c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o59W/nnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4291FC4CEE3;
	Tue,  1 Apr 2025 00:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743466218;
	bh=5QRTI9bWZpF773xhoyYYNn0i3blXsXsmrnbBr/YFvH0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o59W/nnNNK7k07yN+C8ku2/+LBfxtfV2k4ze4LjmpuwsUY0wFQf0cohNMJyC1oMl9
	 ogoRdXXAIl/DNVJECw/+d3iK66ClBYD/ScdJljTA4K9R2otPBetPzjnPZVfPC2wn0o
	 KyZGCMZT1Qa7fWH5h4XcA3rsyqwIc/+QVClGE35wOoHg3Ai/qLNfFS8dUYeXZztuly
	 vI1qgXjnXAty919QgV0XxfeDmtYNF8qzVg48PhnzmE1QtfsEKvMQ5t+xAnvhl+hcxM
	 9s7UrJR6wVagwaQxcD8dJlZwhW8/7fEToGfhgdDViwFpJ15bHnktaeJaoNBYgRI4mw
	 0Wk7875CQCQHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DE8380AA7A;
	Tue,  1 Apr 2025 00:10:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] mptcp: misc. fixes for 6.15-rc0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174346625474.178192.14379060520127760494.git-patchwork-notify@kernel.org>
Date: Tue, 01 Apr 2025 00:10:54 +0000
References: <20250328-net-mptcp-misc-fixes-6-15-v1-0-34161a482a7f@kernel.org>
In-Reply-To: <20250328-net-mptcp-misc-fixes-6-15-v1-0-34161a482a7f@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, fw@strlen.de, shuah@kernel.org, dmytro@shytyi.net,
 yangang@kylinos.cn, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org, liucong2@kylinos.cn

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Mar 2025 15:27:15 +0100 you wrote:
> Here are 4 unrelated patches:
> 
> - Patch 1: fix a NULL pointer when two SYN-ACK for the same request are
>   handled in parallel. A fix for up to v5.9.
> 
> - Patch 2: selftests: fix check for the wrong FD. A fix for up to v5.17.
> 
> [...]

Here is the summary with links:
  - [net,1/4] mptcp: fix NULL pointer in can_accept_new_subflow
    https://git.kernel.org/netdev/net/c/443041deb5ef
  - [net,2/4] selftests: mptcp: fix incorrect fd checks in main_loop
    https://git.kernel.org/netdev/net/c/7335d4ac8129
  - [net,3/4] selftests: mptcp: close fd_in before returning in main_loop
    https://git.kernel.org/netdev/net/c/c183165f87a4
  - [net,4/4] selftests: mptcp: ignore mptcp_diag binary
    https://git.kernel.org/netdev/net/c/b44a4c28228f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



