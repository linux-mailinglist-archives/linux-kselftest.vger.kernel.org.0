Return-Path: <linux-kselftest+bounces-31470-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EC0A99C89
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 02:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9B37194064C
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 00:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BFF380;
	Thu, 24 Apr 2025 00:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctKKuGrI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA871361;
	Thu, 24 Apr 2025 00:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745453397; cv=none; b=goUEcnApvb68YQTvFppbSUVoxY+QpE1aeRMizigaMsKBR3jfdw5DesNm6w0jcI1CKFPa0zCBCucwsCozbiMlBJYHCmPBCTsmlp8GsGY7SPGnKsCxOIgbG0YAIelQNwcTjJyexXXIPhVX8OHZ7DBmBMm64RmiCam2iHvXPdhcIc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745453397; c=relaxed/simple;
	bh=mTmkH8qWCLHZGcbfpRW4Dg5HQwFy7i7bs6ZQ1w+1Jn4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NWOmNx4j+AD3thY47cV0rUFgExctN+4Cq68F/nPBePXRcSu7QYEN0OZtZKAHLnfrPN6RNaY9QLbDX4Jt1AYr0DCF4dIM3KHzUKqfqfT559jdIZfgKokAsE+8TSSCCmAD+We/DM4WSBDYSXCGRBP2yAxHyemuvMBVMIKN4hq40ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctKKuGrI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1283C4CEE2;
	Thu, 24 Apr 2025 00:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745453396;
	bh=mTmkH8qWCLHZGcbfpRW4Dg5HQwFy7i7bs6ZQ1w+1Jn4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ctKKuGrI4Q1bR10O81yZ9AhOT6YE7ouBx6SbAlqZdipVgcqXeOW3gWRGF1gIdfeDo
	 aIYDB0H8xEH3hWa96WYCm+dj6ECQvq/uBxzw+aWl4egYN790Pf2BIxaLXXpq8vZyE2
	 Su/3Mr1JWnggl0BKDOpqwuQRvR61Ot2Zb9AsGCmv4N66q1gp1ScGkj+05h+2MqvMtG
	 g06wPWMASGqVAEht9kkhNmBj84uqmyEaTSMkuLum6lpyfmUdcXSr+z84dFFUtkcS0T
	 wemFj2mevtzCS/vvG/jLCogcR+WDIOd5OyE98IDDOoEYfOvOksOlgL2qpleC0urT2O
	 vvn+etnlLD5uA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C95380CED9;
	Thu, 24 Apr 2025 00:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] mptcp: pm: Defer freeing userspace pm entries
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174545343523.2807189.6550009726360059159.git-patchwork-notify@kernel.org>
Date: Thu, 24 Apr 2025 00:10:35 +0000
References: <20250421-net-mptcp-pm-defer-freeing-v1-0-e731dc6e86b9@kernel.org>
In-Reply-To: <20250421-net-mptcp-pm-defer-freeing-v1-0-e731dc6e86b9@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, yangang@kylinos.cn,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Apr 2025 19:07:12 +0200 you wrote:
> Here are two unrelated fixes for MPTCP:
> 
> - Patch 1: free userspace PM entry with RCU helpers. A fix for v6.14.
> 
> - Patch 2: avoid a warning when running diag.sh selftest. A fix for
>   v6.15-rc1.
> 
> [...]

Here is the summary with links:
  - [net,1/2] mptcp: pm: Defer freeing of MPTCP userspace path manager entries
    https://git.kernel.org/netdev/net/c/13b4ece33cf9
  - [net,2/2] selftests: mptcp: diag: use mptcp_lib_get_info_value
    https://git.kernel.org/netdev/net/c/ce72fea219c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



