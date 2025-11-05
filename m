Return-Path: <linux-kselftest+bounces-44783-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EC8C33AAE
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 02:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 626B618C5871
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 01:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A783A2571C5;
	Wed,  5 Nov 2025 01:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ticfRB0Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A9422F772;
	Wed,  5 Nov 2025 01:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762306250; cv=none; b=SYBjTke2cRPP9yYi9HNNPP/jEfcEDVaAqXYt+E8qNwpPMytThqFGrv6fE9BMlYcTBURrTTo76e2AGUEQtOjl06DV2pIeEWzDn2jhczmSl+IOBhPw/nTEhAOI9xWddVM//S0Yqk0rAxCX5FLgMsVvkAPCOaB64N4Q1lA+9yn15VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762306250; c=relaxed/simple;
	bh=vbSRopPRVbXInA0i1dBWh1lx3JnCNcqmOjpHZG+iyAs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WBLzr3poUxzAb+lTwiEtfbrdg7BqI/hnrRq9efgZLZFGrehd0BANjwplFVVaRB3lyydz207x+5VMjvmTm8OamuyNm0JIKdjhYM50HXWHvc+suP2rCA4rSyJY4LGXybkvHj+rKzXkn0RUQSKPCWMfCJCogaHPzfMybY0nyY1J5k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ticfRB0Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8EBDC4CEF7;
	Wed,  5 Nov 2025 01:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762306250;
	bh=vbSRopPRVbXInA0i1dBWh1lx3JnCNcqmOjpHZG+iyAs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ticfRB0ZT4sGSeD7ZTq9el29wpQcAgciwH9E9If9QrlHvq7M4WaT4a/vGWqjcArI2
	 LnVkFuP6KOySdJ/aavL/E6B/IZNmA+353hmndsZ1a83UPamV3KD8LRtOdYQuwSqi8z
	 oWpLCCfWryWh17z7c0iHchlc8dhRdXfTTy8S/gIWR6EiajbMFuSRD9trUlW+tLz/CA
	 Hhi01mAx7FMCkCSWJEqtn+53W2SNocvhksziVzj1xdlPMyjIOK5amRVoFUfpePJ9GT
	 rEaSFTKTzdmVy9dY5OAs5vK4CpeG6QcE0iEraHMWMXqq1kmcdFsVjkHzOSlWD4veJP
	 5xPiQ7PtxxIfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADB5380AA54;
	Wed,  5 Nov 2025 01:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] mptcp: pm: in-kernel: fullmesh endp nb +
 bind
 cases
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176230622373.3052151.5249584300932527660.git-patchwork-notify@kernel.org>
Date: Wed, 05 Nov 2025 01:30:23 +0000
References: 
 <20251101-net-next-mptcp-fm-endp-nb-bind-v1-0-b4166772d6bb@kernel.org>
In-Reply-To: 
 <20251101-net-next-mptcp-fm-endp-nb-bind-v1-0-b4166772d6bb@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 01 Nov 2025 18:56:50 +0100 you wrote:
> Here is a small optimisation for the in-kernel PM, joined by a small
> behavioural change to avoid confusions, and followed by a few more
> tests.
> 
> - Patch 1: record fullmesh endpoints numbers, not to iterate over all
>   endpoints to check if one is marked as fullmesh.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] mptcp: pm: in-kernel: record fullmesh endp nb
    https://git.kernel.org/netdev/net-next/c/f88191c7f361
  - [net-next,2/4] mptcp: pm: in kernel: only use fullmesh endp if any
    https://git.kernel.org/netdev/net-next/c/e461e8a799a2
  - [net-next,3/4] selftests: mptcp: join: do_transfer: reduce code dup
    https://git.kernel.org/netdev/net-next/c/4a6220a453c8
  - [net-next,4/4] selftests: mptcp: join: validate extra bind cases
    https://git.kernel.org/netdev/net-next/c/5c59df126bae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



