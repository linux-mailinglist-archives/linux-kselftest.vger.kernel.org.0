Return-Path: <linux-kselftest+bounces-14692-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5E2945609
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 03:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB7D01C22D1D
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 01:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B06B14006;
	Fri,  2 Aug 2024 01:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BleUUNCp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F7212E71;
	Fri,  2 Aug 2024 01:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722562833; cv=none; b=OjdBWxrnlj1kBu0cT/u1YpGM+i9a7WPZsf525NLT3iWGt8flRFuRXfiOHQ6GanKX2RC8dzb9PKGSiyOsDEfHKryF3ESpEMb385rwmC9AapNN/E25j6Lm2XwTumaRdVTNtD2wzRbjIpWCJoHPTuo84GSmtA8NuJiVVfzSugfQT+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722562833; c=relaxed/simple;
	bh=xYpZjisZm/f+NRI59T0R2ycx0HtLFJvMti3jCCvGcao=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lam9/7afdNV0Yrz9rQy05ssR8vySYqjO5DUPLUBgc/y0Uu2cIowmgcxwxijyMps6BMywFW/T1Gb1kSNEvHZJSvgSuDESbO6S//5NasRQeqHY/tamkAU5cGy7txpf0+siOLJC1m/5IpLP8BvoQERH4Xowy6keTCbl40C9NhLJxNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BleUUNCp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70137C4AF0A;
	Fri,  2 Aug 2024 01:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722562832;
	bh=xYpZjisZm/f+NRI59T0R2ycx0HtLFJvMti3jCCvGcao=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BleUUNCpCd1yI6z6E/F9Z7d047NL3xN3dtKxncFEEN354CTO8xa1evWVSceCkn5KS
	 1Hqc20G3mNGKTOZzCFKZiCj7Nx9C4AsmXZxLhUkt626N2hMlliwaubCVN1L/XgPLy2
	 l+gAvlz9t1wnI1GC8HWylkLNimAbe8/FOOlZFqO6HBJoGvH7aKuqggdvybXWJyk57a
	 +z3ux64+VeUmbzsxj6EIuLroBNdyrharesVwQ0LowARTrO+iJCeCx7tewk2tT8B4js
	 t731V2LAiikbU0BozfFDH77BR1v5X3pfzZKnqeHXu7OiAjbm+Pwlb4rTtnWh15/ZdF
	 xLFafnlaZ98Zg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5DB3BD0C60A;
	Fri,  2 Aug 2024 01:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/7] mptcp: fix endpoints with 'signal' and 'subflow'
 flags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172256283237.5499.17809617500066693516.git-patchwork-notify@kernel.org>
Date: Fri, 02 Aug 2024 01:40:32 +0000
References: <20240731-upstream-net-20240731-mptcp-endp-subflow-signal-v1-0-c8a9b036493b@kernel.org>
In-Reply-To: <20240731-upstream-net-20240731-mptcp-endp-subflow-signal-v1-0-c8a9b036493b@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shuah@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 31 Jul 2024 13:05:52 +0200 you wrote:
> When looking at improving the user experience around the MPTCP endpoints
> setup, I noticed that setting an endpoint with both the 'signal' and the
> 'subflow' flags -- as it has been done in the past by users according to
> bug reports we got -- was resulting on only announcing the endpoint, but
> not using it to create subflows: the 'subflow' flag was then ignored.
> 
> My initial thought was to modify IPRoute2 to warn the user when the two
> flags were set, but it doesn't sound normal to ignore one of them. I
> then looked at modifying the kernel not to allow having the two flags
> set, but when discussing about that with Mat, we thought it was maybe
> not ideal to do that, as there might be use-cases, we might break some
> configs. Then I saw it was working before v5.17. So instead, I fixed the
> support on the kernel side (patch 5) using Paolo's suggestion. This also
> includes a fix on the options side (patch 1: for v5.11+), an explicit
> deny of some options combinations (patch 2: for v5.18+), and some
> refactoring (patches 3 and 4) to ease the inclusion of the patch 5.
> 
> [...]

Here is the summary with links:
  - [net,1/7] mptcp: fully established after ADD_ADDR echo on MPJ
    https://git.kernel.org/netdev/net/c/d67c5649c154
  - [net,2/7] mptcp: pm: deny endp with signal + subflow + port
    https://git.kernel.org/netdev/net/c/8af1f11865f2
  - [net,3/7] mptcp: pm: reduce indentation blocks
    https://git.kernel.org/netdev/net/c/c95eb32ced82
  - [net,4/7] mptcp: pm: don't try to create sf if alloc failed
    https://git.kernel.org/netdev/net/c/cd7c957f936f
  - [net,5/7] mptcp: pm: do not ignore 'subflow' if 'signal' flag is also set
    https://git.kernel.org/netdev/net/c/85df533a787b
  - [net,6/7] selftests: mptcp: join: ability to invert ADD_ADDR check
    https://git.kernel.org/netdev/net/c/bec1f3b119eb
  - [net,7/7] selftests: mptcp: join: test both signal & subflow
    https://git.kernel.org/netdev/net/c/4d2868b5d191

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



