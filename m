Return-Path: <linux-kselftest+bounces-2451-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E29C981EA5A
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 23:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C496228332A
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 22:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FC2525E;
	Tue, 26 Dec 2023 22:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8OOMrMZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A6A5250;
	Tue, 26 Dec 2023 22:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6948C433C9;
	Tue, 26 Dec 2023 22:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703630424;
	bh=t7Azjows6a4NudAwFasVutuu3ZSXugHqZpvg/vQupZc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F8OOMrMZQGGkH81i5df0nHGftbOQDJVEAKb7h6LP/qJoTLvXbzKER+k1mHuX+YvGY
	 fGVNCVAvEu1bpRVlgdpVZMR40XZBr06aQQ8F8EWjWRfojb5kcegjcX07jsH29G8JLb
	 j5C3fHXQiS0kvCGuuYdG04eZUwXFXivizYewXR9ZNDY6SgNQlq9zAeqQRUxdOczrLC
	 RA5FcUAW4Obt0yRFn5TwL+c7TayE8Kjze7Fl04+rkib6ommYoauqqbkmbit8hsbf3f
	 Cp+sO4SDRN9MAagAPj0hqjWVk6otsm7FnHJD2WerJ0WHKU7nvbX20Q4anfmx1MAl4O
	 hNEpVNxlaeNjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC014E333D7;
	Tue, 26 Dec 2023 22:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] mptcp: cleanup and support more ephemeral
 ports sockopts
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170363042382.9770.13227130852306828650.git-patchwork-notify@kernel.org>
Date: Tue, 26 Dec 2023 22:40:23 +0000
References: <20231219-upstream-net-next-20231219-mptcp-sockopts-ephemeral-ports-v1-0-2b13bedfcaf8@kernel.org>
In-Reply-To: <20231219-upstream-net-next-20231219-mptcp-sockopts-ephemeral-ports-v1-0-2b13bedfcaf8@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, dcaratti@redhat.com, max@internet.ru

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 19 Dec 2023 22:31:03 +0100 you wrote:
> Patch 1 is a cleanup one: mptcp_is_tcpsk() helper was modifying sock_ops
> in some cases which is unexpected with that name.
> 
> Patch 2 to 4 add support for two socket options: IP_LOCAL_PORT_RANGE and
> IP_BIND_ADDRESS_NO_PORT. The first one is a preparation patch, the
> second one adds the support while the last one modifies an existing
> selftest to validate the new features.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] mptcp: don't overwrite sock_ops in mptcp_is_tcpsk()
    https://git.kernel.org/netdev/net-next/c/8e2b8a9fa512
  - [net-next,2/4] mptcp: rename mptcp_setsockopt_sol_ip_set_transparent()
    https://git.kernel.org/netdev/net-next/c/57d3117ca80f
  - [net-next,3/4] mptcp: sockopt: support IP_LOCAL_PORT_RANGE and IP_BIND_ADDRESS_NO_PORT
    https://git.kernel.org/netdev/net-next/c/c85636a29264
  - [net-next,4/4] selftests/net: add MPTCP coverage for IP_LOCAL_PORT_RANGE
    https://git.kernel.org/netdev/net-next/c/122db5e3634b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



