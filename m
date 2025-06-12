Return-Path: <linux-kselftest+bounces-34778-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8C8AD649E
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 02:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ED1F3AC3E2
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 00:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5042A45948;
	Thu, 12 Jun 2025 00:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APAOw6/a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA4E182D0;
	Thu, 12 Jun 2025 00:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749688801; cv=none; b=i0UbWdWkrkOQOdhSX2FbtCwZa2jWCI/UKMP+8mGW/SSFohcut4CUKFIFZJ/mD/LRc8SLauQehr/sU8jinNbE+HAZJ4goSzeHAdnaz4DqTD7bFy/SyYFh8PVulZDYIJXJhPhnCyLe/0HWKotDyBWOUhIcud7qwJzudaJO7/wkicg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749688801; c=relaxed/simple;
	bh=jpj01HFrpsqQ9KoLARSa3nYvj53bpFwNKRQ3OKEk8As=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Nh4UeYKiquZoIbF0n/Lx2Krny19yEbOOfJQhiFicxgxqUKMpJKd6oF7+SUyIdYB+Qu2BsNpAjUTex3aBaX0QmH3qRzPQrdhLjOjEW5NcJduYaFo9mp+P8dnTjPDoVG8tl3EHJVOS7yELaXkrt++P4tEOSFwapvd4PhV4pFBKtu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APAOw6/a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61D1C4CEE3;
	Thu, 12 Jun 2025 00:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749688800;
	bh=jpj01HFrpsqQ9KoLARSa3nYvj53bpFwNKRQ3OKEk8As=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=APAOw6/aLgn4GH1zi0JCsdqyqGgxnYvd2c3XYJyK8H42HsA8b2XK0h9PyTuORr8rS
	 xrsz+w2cIGCRMxmANmtxU2i4QHYofyh3pDGp0SgDQvm77ZC+tvpyojsGTrcjp578Ad
	 veA2m+LNcdQbMeyvU2BdE9zpvruzDOJwGJdjRdafK1659VGtsCn2N7bZb4Apv3RHSD
	 7JBNOQBNKJ0vAiWCipa/554cQeMscB0/o//c7iF47hFWDAt1zy76d+xpEhN5h40gfn
	 2JkXZuqGaSFaWW5bJNxW2pM/I4TYEWxrIzY/KPG+0gWnbO6pbCFMfgyT1bEZv2xctX
	 OHFJjGTYVr4Dw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADAB3822D1A;
	Thu, 12 Jun 2025 00:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 1/2] net: clear the dst when changing skb protocol
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174968883075.3549461.11849610540706113890.git-patchwork-notify@kernel.org>
Date: Thu, 12 Jun 2025 00:40:30 +0000
References: <20250610001245.1981782-1-kuba@kernel.org>
In-Reply-To: <20250610001245.1981782-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 willemdebruijn.kernel@gmail.com, maze@google.com, daniel@iogearbox.net,
 stable@vger.kernel.org, martin.lau@linux.dev, john.fastabend@gmail.com,
 eddyz87@gmail.com, sdf@fomichev.me, haoluo@google.com, willemb@google.com,
 william.xuanziyang@huawei.com, alan.maguire@oracle.com, bpf@vger.kernel.org,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, yonghong.song@linux.dev

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Jun 2025 17:12:44 -0700 you wrote:
> A not-so-careful NAT46 BPF program can crash the kernel
> if it indiscriminately flips ingress packets from v4 to v6:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>     ip6_rcv_core (net/ipv6/ip6_input.c:190:20)
>     ipv6_rcv (net/ipv6/ip6_input.c:306:8)
>     process_backlog (net/core/dev.c:6186:4)
>     napi_poll (net/core/dev.c:6906:9)
>     net_rx_action (net/core/dev.c:7028:13)
>     do_softirq (kernel/softirq.c:462:3)
>     netif_rx (net/core/dev.c:5326:3)
>     dev_loopback_xmit (net/core/dev.c:4015:2)
>     ip_mc_finish_output (net/ipv4/ip_output.c:363:8)
>     NF_HOOK (./include/linux/netfilter.h:314:9)
>     ip_mc_output (net/ipv4/ip_output.c:400:5)
>     dst_output (./include/net/dst.h:459:9)
>     ip_local_out (net/ipv4/ip_output.c:130:9)
>     ip_send_skb (net/ipv4/ip_output.c:1496:8)
>     udp_send_skb (net/ipv4/udp.c:1040:8)
>     udp_sendmsg (net/ipv4/udp.c:1328:10)
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] net: clear the dst when changing skb protocol
    https://git.kernel.org/netdev/net/c/ba9db6f907ac
  - [net,v3,2/2] selftests: net: add test case for NAT46 looping back dst
    https://git.kernel.org/netdev/net/c/567766954b2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



