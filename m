Return-Path: <linux-kselftest+bounces-32473-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B12AAAB843
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 08:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6253E3AF16D
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 06:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0199513C816;
	Tue,  6 May 2025 01:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRHDhXNd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D7E7260A;
	Tue,  6 May 2025 00:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746489652; cv=none; b=FkJJ7gXB5Xs7G93Kn+XI4ANLMnOO2915iJ79d7Lp6ziIzeugdvHitRIq0qu6367L4dCB++raaLUvlqDF1crtZzXuo6AIuWR7DXTX3l5fDIR6l3LV0Ig7PMB25qFpu9dtcD5S2f2A+tXOZRRjoO1/RL7ZjUJvsd95xngXEfKemSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746489652; c=relaxed/simple;
	bh=CaP6yASIRa//2KTQtwqAOTv5UeCAUs9+VGcQFdJ3f+A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ga0GG+ML2LTpM9vNAl5uS4ie/jdgJSHjsvYRK5GJMc2afoPWdr43IJgrSV8xsHSqRmgzPKYVjSciAlyUM7SU+ht2owSWju+Jatao3J1N8MhSdSAyvGGCLd2EtOE3VXQeX6A/nnMHVvjrNUV/9hIxecktqUSs0wqIK3XqhrJA844=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRHDhXNd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCE6C4CEE4;
	Tue,  6 May 2025 00:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746489652;
	bh=CaP6yASIRa//2KTQtwqAOTv5UeCAUs9+VGcQFdJ3f+A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nRHDhXNdcRxyHurkyHxRMR3KnCbTW/1o509RQoPlrMn/J4tv/mxLzMoJXKPBBAmy+
	 4U2lkQxlpmXJ1tAGIOfYK8mgeZgNF5j9l/dqLLpH7xMmrFqtbiAvP4B/xYF/qewCzU
	 Nro5WhI/gg/F1X1FGftPc4ZqKp/BNAd2LCrADgICsGrdtS1f3iOzp9KqO4V5dWL1qm
	 N7z7SWNj7xS/6Lx98gGheNqzd0Sb2BpRljUoqw2G2gSa2LU5pqWR6S2f6XlhRJskry
	 hmfWaTAQm6qzWfsVk+OZmi6tmQzEl65J2YxqiXC4hSXlYk2pE8532cEOfMNZXou5JL
	 YArV76efxD8Mw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BEA380CFD9;
	Tue,  6 May 2025 00:01:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/7] selftests: mptcp: increase code coverage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174648969104.970984.3012582895759124945.git-patchwork-notify@kernel.org>
Date: Tue, 06 May 2025 00:01:31 +0000
References: <20250502-net-next-mptcp-sft-inc-cover-v1-0-68eec95898fb@kernel.org>
In-Reply-To: <20250502-net-next-mptcp-sft-inc-cover-v1-0-68eec95898fb@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 yangang@kylinos.cn

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 02 May 2025 14:29:20 +0200 you wrote:
> Here are various patches slightly improving MPTCP code coverage:
> 
> - Patch 1: avoid a harmless 'grep: write error' warning.
> 
> - Patch 2: use getaddrinfo() with IPPROTO_MPTCP in more places.
> 
> - Patch 3-6: prepare and add support to get info for a specific subflow
>   when giving the 5-tuple.
> 
> [...]

Here is the summary with links:
  - [net-next,1/7] selftests: mptcp: info: hide 'grep: write error' warnings
    https://git.kernel.org/netdev/net-next/c/6d0eb15c6501
  - [net-next,2/7] selftests: mptcp: sockopt: use IPPROTO_MPTCP for getaddrinfo
    https://git.kernel.org/netdev/net-next/c/dd367e81b79a
  - [net-next,3/7] selftests: mptcp: add struct params in mptcp_diag
    https://git.kernel.org/netdev/net-next/c/cd732d5110a2
  - [net-next,4/7] selftests: mptcp: refactor send_query parameters for code clarity
    https://git.kernel.org/netdev/net-next/c/3fea468dca4f
  - [net-next,5/7] selftests: mptcp: refactor NLMSG handling with 'proto'
    https://git.kernel.org/netdev/net-next/c/caa6811ccaed
  - [net-next,6/7] selftests: mptcp: add helpers to get subflow_info
    https://git.kernel.org/netdev/net-next/c/c7ac7452df70
  - [net-next,7/7] selftests: mptcp: add chk_sublfow in diag.sh
    https://git.kernel.org/netdev/net-next/c/110f8f77fd8d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



