Return-Path: <linux-kselftest+bounces-26820-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 287D5A39053
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 02:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98C53189651F
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 01:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125A31598F4;
	Tue, 18 Feb 2025 01:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WA4GVv0W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE0A1581E5;
	Tue, 18 Feb 2025 01:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739841623; cv=none; b=BBJPU0KUff6OALpEVpph7B8/t1suz48nkqugL1kvewWz3EsiRNXK/EoGOgRZViYfNZygfkHCfagq0d0nwwnrOrN2Rpd2/yn4pNIIinsoArN/3/1SHUiCkEfYHUnmVaJVgANrLVHfGZ5++DBN6M/z05Muw93q000Yyku6gN0pnL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739841623; c=relaxed/simple;
	bh=VTd07HBUgh46I+5T+oMUa+K0VhIrDwJkwlf4iWFOi9o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kBPk770ClDSa9EPrRQj37YFlEgFHRuKRMgaDoDN4XoBwS0pxVaKLRhy3Oz4we5gGrMWdIdJ/ZV7y+TeE0oxLVDIHrTvDZm7ExZlDx2Tyl3nATiqYn6Mm7rVf6AAwayDyFEruZYSiMaEhcNWQoi6S7ofRBi1AKxar4yxX5t4mEpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WA4GVv0W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDDFEC4CEE4;
	Tue, 18 Feb 2025 01:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739841622;
	bh=VTd07HBUgh46I+5T+oMUa+K0VhIrDwJkwlf4iWFOi9o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WA4GVv0WFGBbmcHmEghrN7pG73Uf526ezMIoPsQ49lB0SeoVm7mHbAh4wMNrKc5AF
	 HDU22TgLD5ea7IjzdrUKnu5337Tc3KMr1zexniwTjHoqyHNzltgWle6tSSWazgwTVg
	 s3cH8zR3aPFYEHjTqkymz2/0F3RzbDS35ftXEaNkA1tR4a3cPCXroI8yqDmZnLKWA+
	 ozd/q+kwbREIN9K+QgNlj6YHY+3DXFGftDzO7aWRrbCkxl6ROJK7aq4r08fbOIpXY2
	 oFIG82vIIGY8W75onlJKRVetiCN4k+WL759RGEh0gXuYtQmWiC2z8T09nUFAXgX57J
	 4UBXeBowVGXrQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3409D380AAD5;
	Tue, 18 Feb 2025 01:20:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] selftests: net: add support for testing
 SO_RCVMARK and SO_RCVPRIORITY
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173984165275.3591662.2450574356094790999.git-patchwork-notify@kernel.org>
Date: Tue, 18 Feb 2025 01:20:52 +0000
References: <20250214205828.48503-1-annaemesenyiri@gmail.com>
In-Reply-To: <20250214205828.48503-1-annaemesenyiri@gmail.com>
To: Anna Emese Nyiri <annaemesenyiri@gmail.com>
Cc: netdev@vger.kernel.org, fejes@inf.elte.hu, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, willemb@google.com, idosch@idosch.org,
 horms@kernel.org, davem@davemloft.net, shuah@kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 14 Feb 2025 21:58:28 +0100 you wrote:
> Introduce tests to verify the correct functionality of the SO_RCVMARK and
> SO_RCVPRIORITY socket options.
> 
> Key changes include:
> 
> - so_rcv_listener.c: Implements a receiver application to test the correct
> behavior of the SO_RCVMARK and SO_RCVPRIORITY options.
> - test_so_rcv.sh: Provides a shell script to automate testing for these options.
> - Makefile: Integrates test_so_rcv.sh into the kernel selftests.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] selftests: net: add support for testing SO_RCVMARK and SO_RCVPRIORITY
    https://git.kernel.org/netdev/net-next/c/c935af429ec2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



