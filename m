Return-Path: <linux-kselftest+bounces-34826-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6408AD767C
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 17:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9C6D3BA3EF
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 15:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCF32BDC3D;
	Thu, 12 Jun 2025 15:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrtw9j97"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E951E376C;
	Thu, 12 Jun 2025 15:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749742214; cv=none; b=FJTyPxkbJWZlEJzc7ZiXmOEIkJ5YefoaAvLfSHMb0mD10YGt1b2TmXVA7kCfFU890wsdHGdRFkRW90bIfCdslS24rvj0qXXsL2TL/1cyVX2AZ84lL5fci01Xi41V7P9wN/WYenH6qCLstPiuYiBjOfPhrKbNkNWGlUU2NWZ+VBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749742214; c=relaxed/simple;
	bh=x2aiVu2DBahRLk6YL26ZlTPWmmRNNDwU1Qjz2xLy/+M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gLU3NXyIJHXANNbjQong388rcZtHW9bjDYC16onPAWAwM/rzPNjHB1fJe5tms+9AudCDoHaf2LrUkuBp1x3JdRNSkVDBiu88pg3zgdmYRS9mDeNGI428YsCxmAUZWIfvxYXdVx1xT2X/Jeas+vKTFkHYYgck7KD0vHiqU2k/38k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrtw9j97; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CACC4CEEA;
	Thu, 12 Jun 2025 15:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749742214;
	bh=x2aiVu2DBahRLk6YL26ZlTPWmmRNNDwU1Qjz2xLy/+M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lrtw9j97S77rpx5hYBAubS/Loqbx3sEnQo6zRLQXydS3dcaK8y9lCus9rsOYphkK3
	 uxcB/q9hEokwNR1cyL4mWJZTGaBub2/V16ro9tnF0XCcoy2wddWTC+NZVxIFUo2z3/
	 hl4mhzjDbTQky/V+ket6qCizlOd5SugqyURtkAlyIQxo6sSZMUD/s2Mi2jgHL86rro
	 FTmH17s7kStgU0p9SXhyywhUAf9LbH6GhYqhGRQZDWEvZ4U3aT/qfHPh+uR5Dsfs68
	 LMvd22j6QyYMW16orOn237MJAirDGRrJVUvAg5ViSKvXx5GZhiNxJs64C2Ma17L8PI
	 5pjDMvnhAqG1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B4639EFFCF;
	Thu, 12 Jun 2025 15:30:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2] Fix ntuple rules targeting default RSS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174974224373.4184138.9026629793065246426.git-patchwork-notify@kernel.org>
Date: Thu, 12 Jun 2025 15:30:43 +0000
References: <20250612071958.1696361-1-gal@nvidia.com>
In-Reply-To: <20250612071958.1696361-1-gal@nvidia.com>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 andrew@lunn.ch, horms@kernel.org, shuah@kernel.org, jdamato@fastly.com,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Jun 2025 10:19:56 +0300 you wrote:
> This series addresses a regression in ethtool flow steering where rules
> targeting the default RSS context (context 0) were incorrectly rejected.
> 
> The default RSS context always exists but is not stored in the rss_ctx
> xarray like additional contexts. The current validation logic was
> checking for the existence of context 0 in this array, causing valid
> flow steering rules to be rejected.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] net: ethtool: Don't check if RSS context exists in case of context 0
    https://git.kernel.org/netdev/net/c/d78ebc772c7c
  - [net,v3,2/2] selftests: drv-net: rss_ctx: Add test for ntuple rules targeting default RSS context
    https://git.kernel.org/netdev/net/c/56c5d291e885

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



