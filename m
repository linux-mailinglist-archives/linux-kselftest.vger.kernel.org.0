Return-Path: <linux-kselftest+bounces-9173-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE128B83AA
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 02:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4A5B1C21835
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 00:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B59625;
	Wed,  1 May 2024 00:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqjNezTT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA85D173;
	Wed,  1 May 2024 00:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714522833; cv=none; b=BYmVyZWIwKo/SQyonUWxPt5epeiPGqEIx4RM7UoCSqZ2aEbFGTClEWXqC37CYAvB1atBSpvVpC0DQm2CKGRReEaAlzo4z/wPTmIZmk5l+eDQkr7k0G/ewNuccFaIU9Q31MaoQPWUNHk0RbL1gO36+sTgTKIlxUZ+PSuZFoUMmF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714522833; c=relaxed/simple;
	bh=gDDyF4thys5vT1cvoD3fCo9ZfFeoOtVacgT7X3yUIIY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hvZDsTk+j7/wfV1m108g4J0gXPGsJFQp2DqRw83WY4khahD6SnPBumrJsVEUSrSigDuSFVGmIyGO2r3Y+7hcXvYrnhXhI+zV7h5TO3EcI3ACFQyJFI+L0BDtB3/eJ/Feg6KZ3Myv+fhHFytj9d6mifLRxFxD7yTiqt9Hzn+GdCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqjNezTT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56B0DC32789;
	Wed,  1 May 2024 00:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714522832;
	bh=gDDyF4thys5vT1cvoD3fCo9ZfFeoOtVacgT7X3yUIIY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HqjNezTTnsf9Ofty5qWOQsjtlSX0JOoP8U3+rLx/C1ql4xyRIUUMvupyKIMLXlTiX
	 09xh1H6QC54zAj8gJhR1WgQPlU5Nxh4v+mgZK5o64PmvGeVmMAzE4INyodQwdxgLMs
	 /Dji10QM8bnPPIxXz/oURg6JCbQnjPD+UwbBUYzB4VRiLBewKQY8QCqwU7xZS8RssC
	 fQ7sOntfkesdh3JBS4jSGxWRta0+A43CS8cYPloSTzpZRdo8Hb4DFdxn13N2mfwnuW
	 b2EzxsnRJ8LpKuhkB76zljuPhjpZ3H6d3Oj/IEWZ89AI/6uOsM4GimIt2E0WH9MhXI
	 DHMIEvk/joLgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43C81C43443;
	Wed,  1 May 2024 00:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/6] use network helpers, part 3
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171452283227.11120.9713834737904487159.git-patchwork-notify@kernel.org>
Date: Wed, 01 May 2024 00:20:32 +0000
References: <cover.1714014697.git.tanggeliang@kylinos.cn>
In-Reply-To: <cover.1714014697.git.tanggeliang@kylinos.cn>
To: Geliang Tang <geliang@kernel.org>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 tanggeliang@kylinos.cn, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu, 25 Apr 2024 11:23:40 +0800 you wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patchset adds opts argument for __start_server, and adds setsockopt
> pointer together with optval and optlen into struct network_helper_opts
> to make start_server_addr helper more flexible. With these modifications,
> many duplicate codes can be dropped.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/6] selftests/bpf: Add opts argument for __start_server
    https://git.kernel.org/bpf/bpf-next/c/95b88500b97c
  - [bpf-next,2/6] selftests/bpf: Make start_mptcp_server static
    https://git.kernel.org/bpf/bpf-next/c/044032ee6c4e
  - [bpf-next,3/6] selftests/bpf: Drop start_server_proto helper
    https://git.kernel.org/bpf/bpf-next/c/8405e6980f21
  - [bpf-next,4/6] selftests/bpf: Add setsockopt for network_helper_opts
    (no matching commit)
  - [bpf-next,5/6] selftests/bpf: Use start_server_addr in sockopt_inherit
    (no matching commit)
  - [bpf-next,6/6] selftests/bpf: Use start_server_addr in test_tcp_check_syncookie
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



