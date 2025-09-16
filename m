Return-Path: <linux-kselftest+bounces-41554-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E47B58B2F
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 03:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD5AA1B24004
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 01:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CB121FF48;
	Tue, 16 Sep 2025 01:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWVE2bSo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C6B1E379B;
	Tue, 16 Sep 2025 01:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757986218; cv=none; b=lXi1WxfaxwRz09wrFHDI5g19TEUfvdmQIpriqU7LqQpHYsz/+i69Zro3YUc7XGlSxbGShb2FRmieAHM08wl1Aa0pXMzVITCab609n8gp/t1Y+VNC+K+RbopHSFMsdhtvwpoDOygNfUbINluYhxTEzMK33ptpfduTbegiI0Aocr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757986218; c=relaxed/simple;
	bh=1jnjci6bRhFdax2eDMvwFKReYb8NK6G/YWbEbRNYPws=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K8seL0Wf+eTgk76UdFkEDZY/rZUxyZViY5EMXoWxQ9dVUSQ6jKBWJWrBSzKLrK4GN9o4o8LSUoykW2Jt3B7CfHUnIprs4SDUc8LR+Qqs+rtbL3CShK6TNYJQfpn9OOvM7txAmNOGJCdbmlyy8DyPflWypKwvIoFNsx97vUM55vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWVE2bSo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5604EC4CEF5;
	Tue, 16 Sep 2025 01:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757986218;
	bh=1jnjci6bRhFdax2eDMvwFKReYb8NK6G/YWbEbRNYPws=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eWVE2bSohiSHV3vMPcRpuwIz2Sm3XZ+538RHT1I1DIgAJ/bZqr1CdnKPoxgQhymdm
	 rGd38Q2MwelfeJiqrux0Z4sijvEyXHqIy+5AI9RYgHQofPOfVw/0ud1MriqdXhm6yB
	 6YJQBHY+sZ9kiv2rer+95ty42g1JaIaW1NhzPm+7ag/SUDA3yDlZsX2mR9B+rfE4a3
	 DPMpHjok7GtRx7JaIFbbXRo/As6HQCRAZZAdDtY1wt2pRVtyv5mz2+TEOtWcuVpeNN
	 Vy4XN9yjbxrRzSFgtwulDBo/tKAAEvVSRVSjvdrAmnvSS1sPLbMZhUntS1WcrZPLcp
	 XIxhEDEdg58yw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE3539D0C17;
	Tue, 16 Sep 2025 01:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] selftests: mptcp: avoid spurious errors on TCP
 disconnect
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175798621949.559370.15168394018432640770.git-patchwork-notify@kernel.org>
Date: Tue, 16 Sep 2025 01:30:19 +0000
References: <20250912-net-mptcp-fix-sft-connect-v1-0-d40e77cbbf02@kernel.org>
In-Reply-To: <20250912-net-mptcp-fix-sft-connect-v1-0-d40e77cbbf02@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Sep 2025 14:25:49 +0200 you wrote:
> This series should fix the recent instabilities seen by MPTCP and NIPA
> CIs where the 'mptcp_connect.sh' tests fail regularly when running the
> 'disconnect' subtests with "plain" TCP sockets, e.g.
> 
>   # INFO: disconnect
>   # 63 ns1 MPTCP -> ns1 (10.0.1.1:20001      ) MPTCP     (duration   996ms) [ OK ]
>   # 64 ns1 MPTCP -> ns1 (10.0.1.1:20002      ) TCP       (duration   851ms) [ OK ]
>   # 65 ns1 TCP   -> ns1 (10.0.1.1:20003      ) MPTCP     Unexpected revents: POLLERR/POLLNVAL(19)
>   # (duration   896ms) [FAIL] file received by server does not match (in, out):
>   # -rw-r--r-- 1 root root 11112852 Aug 19 09:16 /tmp/tmp.hlJe5DoMoq.disconnect
>   # Trailing bytes are:
>   # /{ga 6@=#.8:-rw------- 1 root root 10085368 Aug 19 09:16 /tmp/tmp.blClunilxx
>   # Trailing bytes are:
>   # /{ga 6@=#.8:66 ns1 MPTCP -> ns1 (dead:beef:1::1:20004) MPTCP     (duration   987ms) [ OK ]
>   # 67 ns1 MPTCP -> ns1 (dead:beef:1::1:20005) TCP       (duration   911ms) [ OK ]
>   # 68 ns1 TCP   -> ns1 (dead:beef:1::1:20006) MPTCP     (duration   980ms) [ OK ]
>   # [FAIL] Tests of the full disconnection have failed
> 
> [...]

Here is the summary with links:
  - [net,1/5] mptcp: propagate shutdown to subflows when possible
    https://git.kernel.org/netdev/net/c/f755be0b1ff4
  - [net,2/5] selftests: mptcp: connect: catch IO errors on listen side
    https://git.kernel.org/netdev/net/c/14e22b43df25
  - [net,3/5] selftests: mptcp: avoid spurious errors on TCP disconnect
    https://git.kernel.org/netdev/net/c/8708c5d8b3fb
  - [net,4/5] selftests: mptcp: print trailing bytes with od
    https://git.kernel.org/netdev/net/c/a17c5aa3a323
  - [net,5/5] selftests: mptcp: connect: print pcap prefix
    https://git.kernel.org/netdev/net/c/cf74e0aa0eb0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



