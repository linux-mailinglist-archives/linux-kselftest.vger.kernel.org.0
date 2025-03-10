Return-Path: <linux-kselftest+bounces-28672-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECC3A5A513
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 21:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D92A188E84C
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 20:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1B51DED78;
	Mon, 10 Mar 2025 20:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpqwZOLP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EEE1DE3BA;
	Mon, 10 Mar 2025 20:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639201; cv=none; b=KGY6Crsy6mpZ4Tbb7QOwINwGGPruRQADrQh+i+pqEps6nL6o5ryssWgTXAa1Ww4pMOf/6QBIgAeZuL4dH8vxdu9118FyxdQK/VhLslJmQn8ZEFeFsx/5rAFSbVF+Tl2W60rAcmp3RobCxs/yOtNiIqCE2QEToZZGXZZiN12pI6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639201; c=relaxed/simple;
	bh=G9DkTCeHEhdEwyEoMNohfDp4nVi246G5RQiaeC1u7uQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lc6ATZt4zZ7CrYhPEaF1tcVtVhhZbjLeaq2Vl9oTLnxhC64ykSh3FYjjcSvNse8583OpVNKE9EEYW8dB3JFoYbNg6D9vkdMhNRemOdwTOLlbYq2hAIrCRsMLNKj9eCslUctQDYMIHhVnZjZWRoOQjJn7cciFVxYCQ8GDfgDOmkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpqwZOLP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71736C4CEE5;
	Mon, 10 Mar 2025 20:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741639200;
	bh=G9DkTCeHEhdEwyEoMNohfDp4nVi246G5RQiaeC1u7uQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JpqwZOLP+MIaNnV3l8renxit9VEXM1moLwF5dSasmYATFsgCSBXKMXgk+c1XLNgAW
	 pEM5+uB7gcL13aD1Er89LHnRNCahZ/ifrwGGV2iC3OEfdNcf0u8r9UfFrVlxVHy/pE
	 9F0yWCk51PDtyQzjMDjAbqyEq2Uoszw50APZhsQ3P8bmPFJqh+MtFjkNHEThRo4vax
	 9E7wM9QQCxZg8fVpgUiJuqTBdMGXCYjXJzr15kwFWXZuja/oURmettOLREoNbRQCpo
	 2MYBml7WI+w62+HBVLhkNMWCc0EEYIdWkSt2LYf1q791ias0G6HcBvBD/5oQP/6S3J
	 qSJfHe/RlD1Jg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF7E380AACB;
	Mon, 10 Mar 2025 20:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net 0/8] eth: bnxt: fix several bugs in the bnxt module
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174163923453.3688527.11877711780518308439.git-patchwork-notify@kernel.org>
Date: Mon, 10 Mar 2025 20:40:34 +0000
References: <20250309134219.91670-1-ap420073@gmail.com>
In-Reply-To: <20250309134219.91670-1-ap420073@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, horms@kernel.org, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 almasrymina@google.com, asml.silence@gmail.com, willemb@google.com,
 kaiyuanz@google.com, skhawaja@google.com, sdf@fomichev.me,
 gospo@broadcom.com, somnath.kotur@broadcom.com, dw@davidwei.uk,
 amritha.nambiar@intel.com, xuanzhuo@linux.alibaba.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  9 Mar 2025 13:42:11 +0000 you wrote:
> The first fixes setting incorrect skb->truesize.
> When xdp-mb prog returns XDP_PASS, skb is allocated and initialized.
> Currently, The truesize is calculated as BNXT_RX_PAGE_SIZE *
> sinfo->nr_frags, but sinfo->nr_frags is flushed by napi_build_skb().
> So, it stores sinfo before calling napi_build_skb() and then use it
> for calculate truesize.
> 
> [...]

Here is the summary with links:
  - [v3,net,1/8] eth: bnxt: fix truesize for mb-xdp-pass case
    https://git.kernel.org/netdev/net/c/9f7b2aa5034e
  - [v3,net,2/8] eth: bnxt: return fail if interface is down in bnxt_queue_mem_alloc()
    https://git.kernel.org/netdev/net/c/ca2456e07395
  - [v3,net,3/8] eth: bnxt: do not use BNXT_VNIC_NTUPLE unconditionally in queue restart logic
    https://git.kernel.org/netdev/net/c/661958552eda
  - [v3,net,4/8] eth: bnxt: do not update checksum in bnxt_xdp_build_skb()
    https://git.kernel.org/netdev/net/c/c03e7d05aa0e
  - [v3,net,5/8] eth: bnxt: fix kernel panic in the bnxt_get_queue_stats{rx | tx}
    https://git.kernel.org/netdev/net/c/f09af5fdfbd9
  - [v3,net,6/8] eth: bnxt: fix memory leak in queue reset
    https://git.kernel.org/netdev/net/c/87dd2850835d
  - [v3,net,7/8] net: devmem: do not WARN conditionally after netdev_rx_queue_restart()
    https://git.kernel.org/netdev/net/c/a70f891e0fa0
  - [v3,net,8/8] selftests: drv-net: add xdp cases for ping.py
    https://git.kernel.org/netdev/net/c/75cc19c8ff89

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



