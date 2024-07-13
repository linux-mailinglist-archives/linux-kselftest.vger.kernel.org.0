Return-Path: <linux-kselftest+bounces-13710-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7A79307DD
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Jul 2024 00:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0343D282F58
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Jul 2024 22:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE5514D42C;
	Sat, 13 Jul 2024 22:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ok+2a01S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B5D17C73;
	Sat, 13 Jul 2024 22:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720911030; cv=none; b=q3obwmKRJmmNxN8eMoSRxZEzZDT8JIHQCf/9UQonm9U2lYHOO1MHOHQT+2q7Nti7tJXNU3kNqgKf9nFs+qafblPW7E+pMw2n+XKt/KTVqAtqIZWsHe8iOCDnyZH0graYrOtb5tN+fzxsk5hLWsMi1j3ja8/k/V+RcGn3fMJdcyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720911030; c=relaxed/simple;
	bh=4ZD2k3HqYFMh9Zx8t635quwPpactl8kZkIhOMFfnor4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RsLAMMnbRva/y0Vo4o9SfpSf5t/4yJElhkaVJPlNnub8aJE/dYfLD9nsgoCa+TTksDQaJ+GKZPthOmUooZgx4CXZ6/cUglknBJEWz6xRO6UwotQBzLecT6Gvs/+K3V9o7hNqeGpn58O1gCr43Keq+qNIT+nc5RL/zXR9wDI7qak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ok+2a01S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE766C4AF09;
	Sat, 13 Jul 2024 22:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720911030;
	bh=4ZD2k3HqYFMh9Zx8t635quwPpactl8kZkIhOMFfnor4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ok+2a01SVBm0UNqpq3H18bmKBk3+xqcdHLF4i9EOc0M5WOOgsliI7QacyafHnEFOc
	 7tmnsNSkpC2jXXEEF/CeqR4Mu6rSvxv1qY1Y4MOPfBPEe363AoNOQROq9a4SCWKGZ3
	 owcAJTlAsWm/NqXm9tPzqjCw00mIEZwsXXV6ABn4/tG1buvciIqknS0L5Z02P+/x40
	 opvYh/aW8xYNT5vx5Jy+x8zJ76QT3Ed6eLsmbD6kRoQ/fz0396p3wkU0MIo/SFJbsH
	 0OvMM2Timw/QPiqEugrITh1F9YeOZ0vRtHJs+PF4YFCvE85s7rEkcFuWcT9IQCdG1J
	 L6/G0I1CfVbXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DCB61C43153;
	Sat, 13 Jul 2024 22:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: mptcp: lib: fix shellcheck errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172091102990.32137.18125000818095821222.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jul 2024 22:50:29 +0000
References: <20240712-upstream-net-next-20240712-selftests-mptcp-fix-shellcheck-v1-1-1cb7180db40a@kernel.org>
In-Reply-To: <20240712-upstream-net-next-20240712-selftests-mptcp-fix-shellcheck-v1-1-1cb7180db40a@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shuah@kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Jul 2024 12:00:15 +0200 you wrote:
> It looks like we missed these two errors recently:
> 
>   - SC2068: Double quote array expansions to avoid re-splitting elements.
>   - SC2145: Argument mixes string and array. Use * or separate argument.
> 
> Two simple fixes, it is not supposed to change the behaviour as the
> variable names should not have any spaces in their names. Still, better
> to fix them to easily spot new issues.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: mptcp: lib: fix shellcheck errors
    https://git.kernel.org/netdev/net-next/c/464b99e77b3d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



