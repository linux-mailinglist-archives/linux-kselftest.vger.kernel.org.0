Return-Path: <linux-kselftest+bounces-45589-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 452F0C5A3E3
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 22:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC38E4E8CBD
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 21:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA9E324B14;
	Thu, 13 Nov 2025 21:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIHr7e5x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB020244670;
	Thu, 13 Nov 2025 21:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763070042; cv=none; b=c5WSygSL7hTN0bW6sKIQkb/8lQ9iPdX1sJDak/wN29Bquo2RXoH7WxQqWTpfWA/8n0P6XxaQhRQD+ATyX0baQ7lUan96dH8q79zmBEw6zcFrcn4Ek27Z1SvrEW/psg2ojyXdjTBjvnNz0tQgPCHqypJ3+1WZxoU03Tz2xtcjmQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763070042; c=relaxed/simple;
	bh=CvzcH2D9TtcpWhWA42+if0rgeOPmOZeRHXxaeTWupCI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OLfrjq+RB4h+3UuXsQbyQagJJTl+nuqMhIQAGgKY/4prebv1MQO6wEISI+7l/qr7F702LsA1JMV2RKb19j6Lam1ombxyixnMHr2OzepxpDJp5rtMds8PekK5F+mA2yOfLP7t8EuLu1AbHDPcVEvYWerR0VixY9KCnTcJ15ZUDFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIHr7e5x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30EBFC2BCB1;
	Thu, 13 Nov 2025 21:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763070042;
	bh=CvzcH2D9TtcpWhWA42+if0rgeOPmOZeRHXxaeTWupCI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MIHr7e5x0wHu/EVCxWB6ZOTBFZbIwJ4yI4RHXYOsqUntu1d/lXhiKkqNK6pIKIbil
	 GicAcvRKwvPNhzvxtOInTYm7iBk1YqVvLQ5H8luIrN71owBQ2lV9Bi53M20wLKjHcG
	 vUfWE14KH6pCuDYoeldL/0ruHUGHsQdKAuyDL6SaUDpvCybWJzLKDFHHOb80aGnnH5
	 VMCWqGOzvO78Z6Y11RSgcBIbdAThilnl94w3YYG3XP2/qU0daIDQ+4NmolHBXlNPwb
	 xyMV3LdsF4fEIatjcy0/XQ6R8r0peUlpaNOqprMOnWIopeoPn+OpODwPkWl4zJxsZv
	 9bdm2zURDYFTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FAA3A549BD;
	Thu, 13 Nov 2025 21:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5 0/3] mptcp: Fix conflicts between MPTCP and sockmap
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176307001100.1015375.9798268991526020883.git-patchwork-notify@kernel.org>
Date: Thu, 13 Nov 2025 21:40:11 +0000
References: <20251111060307.194196-1-jiayuan.chen@linux.dev>
In-Reply-To: <20251111060307.194196-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: mptcp@lists.linux.dev, matttbe@kernel.org, martineau@kernel.org,
 geliang@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, cpaasch@apple.com,
 fw@strlen.de, peter.krystad@linux.intel.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue, 11 Nov 2025 14:02:49 +0800 you wrote:
> Overall, we encountered a warning [1] that can be triggered by running the
> selftest I provided.
> 
> sockmap works by replacing sk_data_ready, recvmsg, sendmsg operations and
> implementing fast socket-level forwarding logic:
> 1. Users can obtain file descriptors through userspace socket()/accept()
>    interfaces, then call BPF syscall to perform these replacements.
> 2. Users can also use the bpf_sock_hash_update helper (in sockops programs)
>    to replace handlers when TCP connections enter ESTABLISHED state
>   (BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB/BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB)
> 
> [...]

Here is the summary with links:
  - [net,v5,1/3] mptcp: disallow MPTCP subflows from sockmap
    https://git.kernel.org/bpf/bpf/c/fbade4bd08ba
  - [net,v5,2/3] net,mptcp: fix proto fallback detection with BPF
    https://git.kernel.org/bpf/bpf/c/c77b3b79a92e
  - [net,v5,3/3] selftests/bpf: Add mptcp test with sockmap
    https://git.kernel.org/bpf/bpf/c/cb730e4ac1b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



