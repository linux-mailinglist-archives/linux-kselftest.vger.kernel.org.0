Return-Path: <linux-kselftest+bounces-9896-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0347A8C17E8
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 22:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EC49B2130D
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 20:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FF68061D;
	Thu,  9 May 2024 20:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1MH4Zea"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD68C2ED;
	Thu,  9 May 2024 20:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715287830; cv=none; b=hkz1mEcG8ZPBDF3LCIsApUNIefAORYUMRjucgIqIhukW9oEJpuz+nAG0LEBl5CnT9wIip2m+nW0Wykd9o7owoS28AUGZHHGZcXFTRVI8P8r1QFQhWGz7T/0St5sci7M2C/dk+jSBoUPBmkNk6WQbRvpYOvLuPvRXZf0b1xyR08o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715287830; c=relaxed/simple;
	bh=I+4WNOHQ2T0LlJSzxc1d1XkR2bEVn55vwUCepHk0L64=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fJgigUtbCcq3lqX64l9gmKWCeHweh8J9buIjIQgIytbIMWsUsvxJs55ZzQx7+YbpgcvUkABhTFE/ESottH1K/bOvKdVNRKGs6KtUItPkN1BqdaJrH8fHIdHq8LI694yPP2I6ybqvhN4tofsmuTSKhYjxSBleZBKioKon7F5rr9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1MH4Zea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DEF94C2BD11;
	Thu,  9 May 2024 20:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715287829;
	bh=I+4WNOHQ2T0LlJSzxc1d1XkR2bEVn55vwUCepHk0L64=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z1MH4ZeaD5ZtYmexTH1wDhBcpt5g9iXKPFFJSUpArgwXLSDNdm6nZLK1mrTwSfCe6
	 pedA/ZCcxzzyBdlr3kypQY3E4ZvWRXMA2N/KskNoq9DSM8G/toGxDbawEY+qkGHZvZ
	 6SnpX0NBb2qicYHrxfty4idTIr4Ngxj8pGk6msyuG+NUQNPETP8kqGzHEjsLkXFmfz
	 7nExEFyayDhQgJtL6JYRe40cow+I9lQbteHbBVSu2MTmZp2Ji6qRlzQ/R5x19ps1IN
	 rkuPMVqRPzi0J4Ng6uKohFemlfIaP1VBLNy5ZV+hsP7m0wZsBQhKmod+azeVMeRpiH
	 xw8Sfy8ej4EAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CDAA4E7C0E0;
	Thu,  9 May 2024 20:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/6] use network helpers, part 4
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171528782983.387.11204190011175475682.git-patchwork-notify@kernel.org>
Date: Thu, 09 May 2024 20:50:29 +0000
References: <cover.1714907662.git.tanggeliang@kylinos.cn>
In-Reply-To: <cover.1714907662.git.tanggeliang@kylinos.cn>
To: Geliang Tang <geliang@kernel.org>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 jakub@cloudflare.com, tanggeliang@kylinos.cn, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Sun,  5 May 2024 19:35:07 +0800 you wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patchset adds post_socket_cb pointer together with 'struct
> post_socket_opts cb_opts' into struct network_helper_opts to make
> start_server_addr() helper more flexible. With these modifications,
> many duplicate codes can be dropped.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/6] selftests/bpf: Add post_socket_cb for network_helper_opts
    https://git.kernel.org/bpf/bpf-next/c/20434d2d896f
  - [bpf-next,2/6] selftests/bpf: Use start_server_addr in sockopt_inherit
    https://git.kernel.org/bpf/bpf-next/c/5166b3e3e30a
  - [bpf-next,3/6] selftests/bpf: Use start_server_addr in test_tcp_check_syncookie
    https://git.kernel.org/bpf/bpf-next/c/49e1fa8dbd81
  - [bpf-next,4/6] selftests/bpf: Use connect_to_fd in sockopt_inherit
    https://git.kernel.org/bpf/bpf-next/c/5059c73eca67
  - [bpf-next,5/6] selftests/bpf: Use connect_to_fd in test_tcp_check_syncookie
    https://git.kernel.org/bpf/bpf-next/c/65a3f0df44dd
  - [bpf-next,6/6] selftests/bpf: Drop get_port in test_tcp_check_syncookie
    https://git.kernel.org/bpf/bpf-next/c/7abbf38cd8ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



