Return-Path: <linux-kselftest+bounces-40607-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D8FB406A7
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 16:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FBD21A83595
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 14:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E8930CD95;
	Tue,  2 Sep 2025 14:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBjHnTcO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB0F30C602;
	Tue,  2 Sep 2025 14:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823164; cv=none; b=lUu7+n3mYEMDV/9VBFz+hzVXtQKoqIZ+eWL9RwqMRr4xK5hY+0NqkSUQtUoFiXM/+0mto/UsvCYTsANW9KdGrAgVvGtOpUu087mOglcmjHjSIQDf1Z6K+XuId98kKSsm20T8RiG1UmoK8l9b2Cp7YqsoG80O6C9ECPVATrH9UXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823164; c=relaxed/simple;
	bh=yC3X/rbpLUHBzjvdFH/dG7SKcqAMP+qwP/dQVlBJmq8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UVozP4t3dJ8DZ7R0ay+u8e1OXj1vlXEKEpJIgTpZUNaspLb3yRe6zBGt18x4Tqxh2QoPhvK/3EG4ilPRxQmg0pt6A7dhX4w28zCsO7HzpL2htw1HDsAI70wzM8xPk/TzoNJMTRcpVrr7tcYwrIwh8b/E0jpLdz10oE1TMMoz9dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBjHnTcO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2EA2C4CEED;
	Tue,  2 Sep 2025 14:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756823162;
	bh=yC3X/rbpLUHBzjvdFH/dG7SKcqAMP+qwP/dQVlBJmq8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oBjHnTcO3SH/oS+J8ib4SMwHHYgkhcb0L2Sx3Qbmf13xTVQLvNnbUyywiCirxrDQV
	 vA7CNIqs4kpgCjbe2YBBf1qM3wfFGm6RVD0gTfDRlQeyMEwleHfErvneWdr6QK2mtk
	 22HiQ4QulBvFj8T9uayWMni5BAsOt+t1fQ1/okMtDsGBVZq+J22is5XWIoJkPk0+w1
	 wFhnx1E9tcX/cc2qDxM8Bg/aoqaSmDu2gISEWcd1UxSvRKFvgS6Rw9e+taytL4aoav
	 WPdFFOJFMY9pU3nID/u+hSKWOGib25w/BRacWymVHY9BPkYpP+gIU7vuKVXbD/27s8
	 VODEAXAS1uWIA==
Date: Tue, 2 Sep 2025 07:26:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, Geliang
 Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, Eric Biggers
 <ebiggers@kernel.org>, Christoph Paasch <cpaasch@openai.com>, Gang Yan
 <yangang@kylinos.cn>
Subject: Re: [PATCH net-next 0/6] mptcp: misc. features for v6.18
Message-ID: <20250902072600.2a9be439@kernel.org>
In-Reply-To: <20250901-net-next-mptcp-misc-feat-6-18-v1-0-80ae80d2b903@kernel.org>
References: <20250901-net-next-mptcp-misc-feat-6-18-v1-0-80ae80d2b903@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 01 Sep 2025 11:39:09 +0200 Matthieu Baerts (NGI0) wrote:
> This series contains 4 independent new features:
> 
> - Patch 1: use HMAC-SHA256 library instead of open-coded HMAC.
> 
> - Patches 2-3: make ADD_ADDR retransmission timeout adaptive + simplify
>   selftests.
> 
> - Patch 4: selftests: check for unexpected fallback counter increments.
> 
> - Patches 5-6: record subflows in RPS table, for aRFS support.

I don't see why, but kmemleak started to hit this with the join test
2 branches ago :\ Have you seen any kmemleak issues on your side?
We also see occasional leaked skb in driver tests which makes no sense.

unreferenced object 0xffff8880029d3340 (size 3016):
  comm "softirq", pid 0, jiffies 4297316940
  hex dump (first 32 bytes):
    0a 00 01 02 0a 00 01 01 00 00 00 00 9e b8 7d 27  ..............}'
    0a 00 07 41 00 00 00 00 00 00 00 00 00 00 00 00  ...A............
  backtrace (crc 3653d88c):
    kmem_cache_alloc_noprof+0x284/0x330
    sk_prot_alloc.constprop.0+0x4e/0x1b0
    sk_clone_lock+0x4b/0x10d0
    mptcp_sk_clone_init+0x2e/0x10d0
    subflow_syn_recv_sock+0x9d1/0x1680
    tcp_check_req+0x3a4/0x1910
    tcp_v4_rcv+0x1004/0x30a0
    ip_protocol_deliver_rcu+0x82/0x350
    ip_local_deliver_finish+0x35d/0x620
    ip_local_deliver+0x19c/0x470
    ip_rcv+0xc2/0x370
    __netif_receive_skb_one_core+0x108/0x180
    process_backlog+0x3c1/0x13e0
    __napi_poll.constprop.0+0x9f/0x460
    net_rx_action+0x54f/0xda0
    handle_softirqs+0x215/0x610

