Return-Path: <linux-kselftest+bounces-26847-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F506A399EC
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 12:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05B9D1890194
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 11:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4735423AE7D;
	Tue, 18 Feb 2025 11:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpItD0sM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1346B23958C;
	Tue, 18 Feb 2025 11:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877001; cv=none; b=N+1SbgJhVnftM8q/DQ0fW0GhWmnjakfRGg1CXreIY1Ydv8zk3sEBEAYENG/ozwRXTfoUkgk+3mBm865PDmQgZNnPVOPO7Xoftsy/MJ7+73Gn00dBsMIUuw2TMaYssuBLDH3Ak6I7rsKlHLf24ypeWZr5KiZvIEOEkID1OntRXEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877001; c=relaxed/simple;
	bh=yxYYlJBoiZm+umfoO+u20ai1V04G+CgdbT+PHgCEfM8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nfeMLl1TttbAsdwVCMxX02USOCiUjN6KtxozRbEYvd4L9uD8uHorHzqYL3p5rGkXLZZiYOXlILyFpw6IBLBuP9P/zfaoyb+QqA4lBTR5tG97YXEPeD6XTslFnR068U4IdfCYL/0BxngjbzU3XW55c4RfB+NoPTxkUGF+z8ofIPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpItD0sM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F11C4CEE2;
	Tue, 18 Feb 2025 11:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739877000;
	bh=yxYYlJBoiZm+umfoO+u20ai1V04G+CgdbT+PHgCEfM8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DpItD0sMWHXYQNVy/EjKjs76cbZCsDuh9CDiri4uN4Ds6S+fYWRqlMmR5M1XKVxQf
	 xGHxZ/4gGYHpLsw8+hr8Svn8sjsa0J1xjrxs1FIxiYjBELDBqNvNw9qzzsV1fw25AQ
	 RRc1nJqHGK4nA1t5CJjvNCsxf5fsDrpHaUCEZ/HgNcckkOSIVRcJn9utGI4sOoknH/
	 +PMGrnA2mTjzjSTCw5ko/s5aUumDemFkslTWJAy/jxCPs49cGcDDdpobzn75nQwbcC
	 I+ATTEvyBngsenxjVzg59qPQmPX7PPQ46I8XW7wRP12705bpGpgiwR7/HC5QRRBL4g
	 qF99VaZh4kEEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB759380AA7E;
	Tue, 18 Feb 2025 11:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] sockmap, vsock: For connectible sockets allow only
 connected
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173987703076.4044275.12767164064897444183.git-patchwork-notify@kernel.org>
Date: Tue, 18 Feb 2025 11:10:30 +0000
References: <20250213-vsock-listen-sockmap-nullptr-v1-0-994b7cd2f16b@rbox.co>
In-Reply-To: <20250213-vsock-listen-sockmap-nullptr-v1-0-994b7cd2f16b@rbox.co>
To: Michal Luczaj <mhal@rbox.co>
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, edumazet@google.com,
 kuniyu@amazon.com, pabeni@redhat.com, willemb@google.com,
 davem@davemloft.net, kuba@kernel.org, horms@kernel.org, sgarzare@redhat.com,
 mst@redhat.com, bobby.eshleman@bytedance.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 mykolal@fb.com, shuah@kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 13 Feb 2025 12:58:48 +0100 you wrote:
> Series deals with one more case of vsock surprising BPF/sockmap by being
> inconsistency about (having an) assigned transport.
> 
> KASAN: null-ptr-deref in range [0x0000000000000120-0x0000000000000127]
> CPU: 7 UID: 0 PID: 56 Comm: kworker/7:0 Not tainted 6.14.0-rc1+
> Workqueue: vsock-loopback vsock_loopback_work
> RIP: 0010:vsock_read_skb+0x4b/0x90
> Call Trace:
>  sk_psock_verdict_data_ready+0xa4/0x2e0
>  virtio_transport_recv_pkt+0x1ca8/0x2acc
>  vsock_loopback_work+0x27d/0x3f0
>  process_one_work+0x846/0x1420
>  worker_thread+0x5b3/0xf80
>  kthread+0x35a/0x700
>  ret_from_fork+0x2d/0x70
>  ret_from_fork_asm+0x1a/0x30
> 
> [...]

Here is the summary with links:
  - [net,1/4] sockmap, vsock: For connectible sockets allow only connected
    https://git.kernel.org/netdev/net/c/8fb5bb169d17
  - [net,2/4] vsock/bpf: Warn on socket without transport
    https://git.kernel.org/netdev/net/c/857ae05549ee
  - [net,3/4] selftest/bpf: Adapt vsock_delete_on_close to sockmap rejecting unconnected
    https://git.kernel.org/netdev/net/c/8350695bfb16
  - [net,4/4] selftest/bpf: Add vsock test for sockmap rejecting unconnected
    https://git.kernel.org/netdev/net/c/85928e9c4363

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



