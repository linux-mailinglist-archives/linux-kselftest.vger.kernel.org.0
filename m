Return-Path: <linux-kselftest+bounces-18709-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A291098B1C7
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 03:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67FB02830CA
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 01:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344F44A2C;
	Tue,  1 Oct 2024 01:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tF3MYIUC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC67015CB;
	Tue,  1 Oct 2024 01:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727746232; cv=none; b=RiM26IuuMTqMOc7pWhZoomR+GdQKMwwyQpQew9He5ekJsWIipd+cLlkGKUn5kRYtXHgrNIPlllI/V5zl/dskSWU3fzHdswJfPcv2JgwKG9exF5R9Tm98G1ZDq9DFF2DyK5SkBZcgaUX9GW5IwIGCdR4KSOiJhVXRPt6Ey+oAWuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727746232; c=relaxed/simple;
	bh=rtHmb6g1Q0NJGhc1TVO6gdpNkDEnxTJWgqIcSjESxus=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qFmd3uX4HJjbM5fmi4CAF/JcS8syQqwwVwTRs9BBLQEFQJtvD5kDXjj/7KPvzpdICvknqsReWKWS4JUMfZI3FGXvQMR5HlJl4G0HjCe6yzVwPGl49vkeY2ftZnpB07T5eW76B2y7qMs3PlKJl5Z8FOIzSNLGZijOAH6ElDaJIv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tF3MYIUC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A85C4CEC7;
	Tue,  1 Oct 2024 01:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727746231;
	bh=rtHmb6g1Q0NJGhc1TVO6gdpNkDEnxTJWgqIcSjESxus=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tF3MYIUCRo4n6/xkl6DmtDNojIZ0Z/4SLJzIZrd6KoHMa57d/1Px+A46VHFIpZrLV
	 ifedK3c8ypf5UAXR0imxuEfhgrdITw95OiBz+0FAwhlqhIwzx13ZP403nnJWfSnB0A
	 LW5L//CFHLndG2yfHWwJP1AOU6PGtXf6icVFoaH7Y84BAQYHKeLz1Mu4GWdr8y1MtC
	 Z/qxTxEy5mBZ6LKV+gE/Y/a4z8sC1nxtCZfy2JzohOYbbJsmy12/RyvpE1oVSMuPQn
	 eKBfXuJZzWwuEgJuItVTCfL2jULzF+UDjCBhRwFqOuou6dbutIGZId8etUYYn7ybSd
	 sFtAp0Yg0vgVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCAD3804CB9;
	Tue,  1 Oct 2024 01:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next/net v7 0/3] selftests/bpf: new MPTCP subflow
 subtest
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172774623351.4036978.717715429937152047.git-patchwork-notify@kernel.org>
Date: Tue, 01 Oct 2024 01:30:33 +0000
References: <20240926-upstream-bpf-next-20240506-mptcp-subflow-test-v7-0-d26029e15cdd@kernel.org>
In-Reply-To: <20240926-upstream-bpf-next-20240506-mptcp-subflow-test-v7-0-d26029e15cdd@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, martin.lau@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (net)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu, 26 Sep 2024 19:30:21 +0200 you wrote:
> In this series from Geliang, modifying MPTCP BPF selftests, we have:
> 
> - A new MPTCP subflow BPF program setting socket options per subflow: it
>   looks better to have this old test program in the BPF selftests to
>   track regressions and to serve as example.
> 
>   Note: Nicolas is no longer working at Tessares, but he did this work
>   while working for them, and his email address is no longer available.
> 
> [...]

Here is the summary with links:
  - [bpf-next/net,v7,1/3] selftests/bpf: Add mptcp subflow example
    https://git.kernel.org/bpf/bpf-next/c/83752e12896a
  - [bpf-next/net,v7,2/3] selftests/bpf: Add getsockopt to inspect mptcp subflow
    https://git.kernel.org/bpf/bpf-next/c/cd19b885106e
  - [bpf-next/net,v7,3/3] selftests/bpf: Add mptcp subflow subtest
    https://git.kernel.org/bpf/bpf-next/c/9b85f11efa02

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



