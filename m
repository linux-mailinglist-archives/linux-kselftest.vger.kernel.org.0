Return-Path: <linux-kselftest+bounces-21837-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAEF9C4B89
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 02:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1AB4B20C81
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 01:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08E91F7564;
	Tue, 12 Nov 2024 01:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldKFr+7m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D2E5234;
	Tue, 12 Nov 2024 01:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731373822; cv=none; b=muco9LA+v0V7X8HwcTA3SGCMrQSty3tyuuS6lptglJKH4V1ZE1ADFGzqSHoilgj72haZohWAqW8SVQgTHkRjP9LOpGbboMpU71LiZBLS5JgFQdPRm0lk3GiCRHFMxIRhDKE3o2rnKKb4GZxCLlM/zerBGKDYrzz6Fywt/Vt4U9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731373822; c=relaxed/simple;
	bh=6iXWIIYzs6Fz0/pkTPNNDbrXf39SPg/gliWgmM5jfNY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QBFqkHSME2UNFeWEzea6wtqPVNxpWV1dZ8m+oEYb+Ov3/z9HZ6SkdDMiqVtQX031qzkMLPP6r8lN7+D275Ir+7kwB15Lh6IlkjszD5ueUMzA33PE/uZ+GWTpFeEjSp3Pyj2F2sjGwRTF/uKVEbbhqe1UgKSMPgp0In+z04nNV3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldKFr+7m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB62C4CECF;
	Tue, 12 Nov 2024 01:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731373822;
	bh=6iXWIIYzs6Fz0/pkTPNNDbrXf39SPg/gliWgmM5jfNY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ldKFr+7mn6+9pfbea/baC0+HmKUyUu6Fqjtgiwyd2XTSRMxQ19EtGcw8ucFsMdEd2
	 il1S0SznFiFzKa0MHWzeRPW+EPDO+c7NA9DPiTaUxQPQfa0Cb84h29LFLh5/SJv1fS
	 RXJdUVnyuMdK1Ta406YST4lvSBKqiGE0eBBfUKSX5DwQkLjmTOdHJuPr/P8RIrO3ne
	 r7dvv4Y2a6aO8+PS94szVtEwQP1Mvk6lW0mY5ZP3mimRb/nNKgkI6By6DugtM0Nx5y
	 DuLgxfMda/Q1lDtxtS+TelF2FbAiJ+/eIfxmKYEHxm/41uXwXQYG3uB2Glwmoo81V0
	 B/GQ1hvXIWJ/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 714583809A80;
	Tue, 12 Nov 2024 01:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8 00/12] selftests: ncdevmem: Add ncdevmem to ksft
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173137383227.35889.14781733163627286738.git-patchwork-notify@kernel.org>
Date: Tue, 12 Nov 2024 01:10:32 +0000
References: <20241107181211.3934153-1-sdf@fomichev.me>
In-Reply-To: <20241107181211.3934153-1-sdf@fomichev.me>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch, shuah@kernel.org,
 horms@kernel.org, almasrymina@google.com, willemb@google.com,
 petrm@nvidia.com, jdamato@fastly.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 Nov 2024 10:11:59 -0800 you wrote:
> The goal of the series is to simplify and make it possible to use
> ncdevmem in an automated way from the ksft python wrapper.
> 
> ncdevmem is slowly mutated into a state where it uses stdout
> to print the payload and the python wrapper is added to
> make sure the arrived payload matches the expected one.
> 
> [...]

Here is the summary with links:
  - [net-next,v8,01/12] selftests: ncdevmem: Redirect all non-payload output to stderr
    https://git.kernel.org/netdev/net-next/c/6891f0b523e1
  - [net-next,v8,02/12] selftests: ncdevmem: Separate out dmabuf provider
    https://git.kernel.org/netdev/net-next/c/8b9049af8066
  - [net-next,v8,03/12] selftests: ncdevmem: Unify error handling
    https://git.kernel.org/netdev/net-next/c/bfccbaac1b45
  - [net-next,v8,04/12] selftests: ncdevmem: Make client_ip optional
    https://git.kernel.org/netdev/net-next/c/0ebd75f5f239
  - [net-next,v8,05/12] selftests: ncdevmem: Remove default arguments
    https://git.kernel.org/netdev/net-next/c/d3ca35c64d48
  - [net-next,v8,06/12] selftests: ncdevmem: Switch to AF_INET6
    https://git.kernel.org/netdev/net-next/c/933056357a8c
  - [net-next,v8,07/12] selftests: ncdevmem: Properly reset flow steering
    https://git.kernel.org/netdev/net-next/c/e3c09623a53b
  - [net-next,v8,08/12] selftests: ncdevmem: Use YNL to enable TCP header split
    https://git.kernel.org/netdev/net-next/c/798d822e5d34
  - [net-next,v8,09/12] selftests: ncdevmem: Remove hard-coded queue numbers
    https://git.kernel.org/netdev/net-next/c/d4ef05d21131
  - [net-next,v8,10/12] selftests: ncdevmem: Run selftest when none of the -s or -c has been provided
    https://git.kernel.org/netdev/net-next/c/77f870a00016
  - [net-next,v8,11/12] selftests: ncdevmem: Move ncdevmem under drivers/net/hw
    (no matching commit)
  - [net-next,v8,12/12] selftests: ncdevmem: Add automated test
    https://git.kernel.org/netdev/net-next/c/80230864b7b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



