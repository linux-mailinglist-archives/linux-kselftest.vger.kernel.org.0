Return-Path: <linux-kselftest+bounces-42610-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E574BAAE4E
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 03:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7DE3AB449
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 01:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FBB1C5F27;
	Tue, 30 Sep 2025 01:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLbHj/cF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AEF1C01;
	Tue, 30 Sep 2025 01:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759195823; cv=none; b=D1mC+pZQFcEiF+LPz152AJQ0N+jDbJxpI/8fRJHQBzgujz3T7BWNo1UpyDCgv/LmculBtX3fk3NhojXUEkvjQ8QZezCu0domGsYNY4B2vKU/+avahle0TG1jl6gQ+ft4C0qEJ8HI7uaNJ5Aqbjm6KPhM1nEKWwWJlFd7WfhUMSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759195823; c=relaxed/simple;
	bh=+m6a0mJNIZHUGPK68kjgVgfdAf1S+2tcQrltC6ZN/Zw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hTbrzZzvXIybigXUcx0mCC5eNM7YP+xXIq5uk6PDlqLRck4j6dtyFsE7BlnnI1lHT+uSP/jNCa7PHHtQ8mbScKtxMHsdA+Q4TCCER+wARoxSFYuTCTRiCU/XUIf2Qs/Qkj+TfCczUIt+oRxQuX0LQmDQ8pYWYW4sARLTt34UUWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLbHj/cF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8883FC4CEF4;
	Tue, 30 Sep 2025 01:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759195822;
	bh=+m6a0mJNIZHUGPK68kjgVgfdAf1S+2tcQrltC6ZN/Zw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vLbHj/cFj7INjTUa3aDf/2Ntdldg+kPhUcp5L4EtGtLfXP97ig+ADc/redJFuyWHS
	 RI4Vuzrc0txVVy746eWEUL2SGo6ssgwT0bWlDvpqWM1GZ+2aD6sRP9WuKwQb5DhteS
	 +JG2MUxOBKq8cA35OKvGGx5h6v0bw7WLbVKJ4uEVNYF3lVQWYRt6N69sjDsIqsC7nw
	 s94MuiGMVkUj5R/y+DYQ8eM/Zn63cK5SxvrkRGUnjU0mRRzEuPz95UT7ZWoR24FqA5
	 fv94x56hJ8ZxVZk29uzj8tMJeGNhWG99SVpDqnCdjKEls0EUbVaDuOKe0AArz+2h08
	 Veh5r/tzDrQAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3458639D0C1A;
	Tue, 30 Sep 2025 01:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/8] mptcp: receive path improvement
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175919581600.1779167.13357618344128087599.git-patchwork-notify@kernel.org>
Date: Tue, 30 Sep 2025 01:30:16 +0000
References: 
 <20250927-net-next-mptcp-rcv-path-imp-v1-0-5da266aa9c1a@kernel.org>
In-Reply-To: 
 <20250927-net-next-mptcp-rcv-path-imp-v1-0-5da266aa9c1a@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, dsahern@kernel.org,
 shuah@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 27 Sep 2025 11:40:36 +0200 you wrote:
> This series includes several changes to the MPTCP RX path. The main
> goals are improving the RX performances, and increase the long term
> maintainability.
> 
> Some changes reflects recent(ish) improvements introduced in the TCP
> stack: patch 1, 2 and 3 are the MPTCP counter part of SKB deferral free
> and auto-tuning improvements. Note that patch 3 could possibly fix
> additional issues, and overall such patch should protect from similar
> issues to arise in the future.
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] mptcp: leverage skb deferral free
    https://git.kernel.org/netdev/net-next/c/9aa59323f270
  - [net-next,2/8] tcp: make tcp_rcvbuf_grow() accessible to mptcp code
    https://git.kernel.org/netdev/net-next/c/a7556779745c
  - [net-next,3/8] mptcp: rcvbuf auto-tuning improvement
    https://git.kernel.org/netdev/net-next/c/e118cdc34dd1
  - [net-next,4/8] mptcp: introduce the mptcp_init_skb helper
    https://git.kernel.org/netdev/net-next/c/9a0afe0db467
  - [net-next,5/8] mptcp: remove unneeded mptcp_move_skb()
    https://git.kernel.org/netdev/net-next/c/c4ebc4ee4e75
  - [net-next,6/8] mptcp: factor out a basic skb coalesce helper
    https://git.kernel.org/netdev/net-next/c/68c7af988bd1
  - [net-next,7/8] mptcp: minor move_skbs_to_msk() cleanup
    https://git.kernel.org/netdev/net-next/c/59701b187003
  - [net-next,8/8] selftests: mptcp: join: validate new laminar endp
    https://git.kernel.org/netdev/net-next/c/c912f935a5c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



