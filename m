Return-Path: <linux-kselftest+bounces-45827-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF39C6726D
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 04:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id A33BE29EC4
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 03:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175C427C842;
	Tue, 18 Nov 2025 03:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ip1NAZZz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89A125FA3B;
	Tue, 18 Nov 2025 03:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763436652; cv=none; b=kmScCqxGN2rv9EZlioEhc7mbIHzzFGxANkHyeF7LP2TcvYRR9j/BUAlkpaGjqni2nF8BFRh872Bn2c5dtcZWxkx5JC6dIkMoTE9jEbi8c1n+p0flpGHABfp/9t35tEbu6qkSBfe1JN2i91XWEsaNtofWrBNnoyObSvLJ9P3pJ3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763436652; c=relaxed/simple;
	bh=9IQbd8otsWx/NLOteqfx77+b7+0TOLqPx5TP71Itk+g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kBdmpNzPUmP9h+RegMYFI66AxErpdjXcQSCbJw4baodYMg4QDNhtpluMbh/Qpw1kUviVBQHNewFnnK2afD7KzbdhYYdRTCYqSoS3vNDsCI0/460uINdgcT/imiZ6IydrO65ORmTCMx7osfqb72TfOLvGgghB5d0N/XMqqXblVFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ip1NAZZz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF434C19423;
	Tue, 18 Nov 2025 03:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763436650;
	bh=9IQbd8otsWx/NLOteqfx77+b7+0TOLqPx5TP71Itk+g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ip1NAZZzeE5hlscLVRBZa1yumu/C0SsEr1sNGjpj02RhDcUvHZtguM/6JHR/BW7TS
	 tLK0lZhvgAjWI6RPsMws251+jCyWyM+MuGNUUDwx/xwgUXHwavPJgkndCO9MpjhO35
	 GSEkiUwR0QZHESdEXfQM9O8/YT9My+Z4Wkd2UpDwMjkf9SUR8DUvTB9MCtauGc9+jO
	 Qx+G952v4D/wujUR2gVDXDM6lg73n9s9gjQvycKpJ12w6QqicKvcSpshJZM2jWQe4o
	 4noXrvbgjvpZWUx2TV5qVoMsoLoWzJtfmzk3C8TKkwhqxtOmudkKJI6h1015IGw2S8
	 WjjS2eU36aLtQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1BB3809A1D;
	Tue, 18 Nov 2025 03:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/8] selftests: mptcp: counter cache & stats
 before timeout
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176343661550.3571105.15960190212229018882.git-patchwork-notify@kernel.org>
Date: Tue, 18 Nov 2025 03:30:15 +0000
References: 
 <20251114-net-next-mptcp-sft-count-cache-stats-timeout-v1-0-863cb04e1b7b@kernel.org>
In-Reply-To: 
 <20251114-net-next-mptcp-sft-count-cache-stats-timeout-v1-0-863cb04e1b7b@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 14 Nov 2025 19:12:04 +0100 you wrote:
> Here are a bunch of small improvements to the MPTCP selftests:
> 
> - Patch 1: move code to mptcp_lib.sh to prepare the new features.
> 
> - Patch 2: simplify mptcp_lib_pr_err_stats helper use.
> 
> - Patch 3: remove unused last column from nstat output.
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] selftests: mptcp: lib: introduce 'nstat_{init,get}'
    https://git.kernel.org/netdev/net-next/c/d3305c016a6a
  - [net-next,2/8] selftests: mptcp: lib: remove stats files args
    https://git.kernel.org/netdev/net-next/c/a89fc262b626
  - [net-next,3/8] selftests: mptcp: lib: stats: remove nstat rate columns
    https://git.kernel.org/netdev/net-next/c/2e6daf6b9bc8
  - [net-next,4/8] selftests: mptcp: join: dump stats from history
    https://git.kernel.org/netdev/net-next/c/658e53141780
  - [net-next,5/8] selftests: mptcp: lib: get counters from nstat history
    https://git.kernel.org/netdev/net-next/c/71388a9f331d
  - [net-next,6/8] selftests: mptcp: connect: avoid double packet traces
    https://git.kernel.org/netdev/net-next/c/8c1fe0a50051
  - [net-next,7/8] selftests: mptcp: wait for port instead of sleep
    https://git.kernel.org/netdev/net-next/c/39348f5f2f13
  - [net-next,8/8] selftests: mptcp: get stats just before timing out
    https://git.kernel.org/netdev/net-next/c/eea2f44870d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



