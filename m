Return-Path: <linux-kselftest+bounces-25561-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 044C4A256CA
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 11:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F1BE166F4A
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 10:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0435202C53;
	Mon,  3 Feb 2025 10:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xt7tOQCN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B42202C4E;
	Mon,  3 Feb 2025 10:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738578004; cv=none; b=AMBo8ZyB+LvJ1iYghm/jtI2qiEaxepVDsdpgfcWeIAVC9GzPCUwMlZRruCKdGuRMCKpWQurtQKCFPf9co36lAm60XgCamIqsBxEyUzcwSuYVbHgk5zwsvDWVTxjJbKZQBRyHMuaZub1yfgGVc36Knd4HKDiJpeS6VJ2fih0iRMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738578004; c=relaxed/simple;
	bh=swGdISvDcFg/fvJ8yNHlLKqrsreLfTHP2s0De6F5f90=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nbDgIvHClPF3Ynze2QXj2yRlavEyRgDmOEVuvfINaDkruta9iPJJZ3dmfDTOO5q1hEAXMaGdcHe2C2DCiLNNheCPOC1mFNGSj4qC3Beu0ZLLCpmJMJKMOvuNljCOPMUXXZrBznTMBzvofMDrO+IoMqzE1x+ZtuSs/C0Oaga8+y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xt7tOQCN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA46C4CEE4;
	Mon,  3 Feb 2025 10:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738578004;
	bh=swGdISvDcFg/fvJ8yNHlLKqrsreLfTHP2s0De6F5f90=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xt7tOQCN4Vo4GyNlIq7mkU1m026VPNbHNCqZMs9Pvs6aYm6eNYuNDiUH8Cz6wsOl7
	 s8cmAB+pWOOW6PmMy8sa8iDo5rEG03GlN2os4IwNFHavIbz/nQQrNdu0GkUa6VA6mN
	 Fqrt4Jzc+kPdLeHI9vGnlE3iqMVMN5hz2WMAFp3oU6kHl7WtWSNhGHNXB20silwck5
	 NBrH31BpeahcKC1OhDbqrWm/55hQE3hPkjJ0WoQyvZXmIlftaOL+1FWBwGuDYB7cId
	 r17Gle/9Zgyoon3i7fLdkAovz9fKchKNjClmGaiJFewFFdXFtGgF63c9TxOaSA5yUq
	 It0ExoLEeqG5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34387380AA76;
	Mon,  3 Feb 2025 10:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] udp: gso: do not drop small packets when PMTU reduces
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173857803108.3097404.4630945302894168269.git-patchwork-notify@kernel.org>
Date: Mon, 03 Feb 2025 10:20:31 +0000
References: <Z5yKa7gz72+JEOXr@debian.debian>
In-Reply-To: <Z5yKa7gz72+JEOXr@debian.debian>
To: Yan Zhai <yan@cloudflare.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 johunt@akamai.com, alexander.h.duyck@linux.intel.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@cloudflare.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 31 Jan 2025 00:31:39 -0800 you wrote:
> Commit 4094871db1d6 ("udp: only do GSO if # of segs > 1") avoided GSO
> for small packets. But the kernel currently dismisses GSO requests only
> after checking MTU/PMTU on gso_size. This means any packets, regardless
> of their payload sizes, could be dropped when PMTU becomes smaller than
> requested gso_size. We encountered this issue in production and it
> caused a reliability problem that new QUIC connection cannot be
> established before PMTU cache expired, while non GSO sockets still
> worked fine at the same time.
> 
> [...]

Here is the summary with links:
  - [v3,net] udp: gso: do not drop small packets when PMTU reduces
    https://git.kernel.org/netdev/net/c/235174b2bed8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



