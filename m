Return-Path: <linux-kselftest+bounces-19850-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 510E99A0DAE
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 17:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9BE6B2566A
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 15:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B2320E011;
	Wed, 16 Oct 2024 15:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noabd1xE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E7854F95;
	Wed, 16 Oct 2024 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729091427; cv=none; b=q8C3Xsb939Clk52YEoM07rhwnyqZaCmEizfMQW6+tDnsnuear/sVWUu/zCsG41iZ+togk1vGxhI2dDQzIWCnhGCyl6V9k1r6jr0lz5vJsvyfJIOx+jQze/X1tFweDSaCoNJgc6QHtGMt2AvXOe65Y5EhPMn9WvgG+JU5qhCf8jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729091427; c=relaxed/simple;
	bh=NTgGD59qf94Xj0J2P9c0n6Kdata3dVUb0roq94UWpPU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O2ImJ+dZXTjQrwvvylN32uqXVp4QRf1ma1H/2NV1njFD6mxso0937fOkqNgiVfCd/KKLZlNHSfyOerh22xkRHLm5+dl/02z7GEytElqQZ11j6p5AefOyV3fzZt7oDRRUQPppxOlvgC/iNwy+OB+/QnfOUizmDLDkHC8VX7X5mBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=noabd1xE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E871DC4CEC5;
	Wed, 16 Oct 2024 15:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729091426;
	bh=NTgGD59qf94Xj0J2P9c0n6Kdata3dVUb0roq94UWpPU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=noabd1xEt62dUzoOmnlBp08TTUQhdvGSGIeAqMo93CNTvaKfJzQcaDfgyOcCZeQ+1
	 O289FTBhdLNmupFNkmVb8piMN66INPzxbCCqdscKs2QM2CWGkRYqs/1OWVxI3UMsTh
	 9BP32y4QC4ki8tytD+iwjVJN1iBovcEr6JMi9XAzIBV1Biak6mIx0xPvP7zA0f5vMg
	 S+x4+EZ6A/TE8G9OMMTZ78Cn2Jq8Tvk1P3gysqHK1d0zHrRl2Lny2Be3SNZT0DUx9T
	 4FOL732vnx2a+tpEvZACyE/Wsa6kOoyz7Cbii5btbjFShiImr8tAHSaCJPxW33PDAi
	 1ctUjk11N6neg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CCC3822D30;
	Wed, 16 Oct 2024 15:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v1 1/2] bpf: fix link info netfilter flags to populate
 defrag flag
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172909143125.1848445.4811107844774285676.git-patchwork-notify@kernel.org>
Date: Wed, 16 Oct 2024 15:10:31 +0000
References: <20241011193252.178997-1-wudevelops@gmail.com>
In-Reply-To: <20241011193252.178997-1-wudevelops@gmail.com>
To: Tyrone Wu <wudevelops@gmail.com>
Cc: bpf@vger.kernel.org, pablo@netfilter.org, kadlec@netfilter.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 riel@surriel.com, shakeel.butt@linux.dev, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com

Hello:

This series was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 11 Oct 2024 19:32:51 +0000 you wrote:
> This patch correctly populates the `bpf_link_info.netfilter.flags` field
> when user passes the `BPF_F_NETFILTER_IP_DEFRAG` flag.
> 
> Fixes: 84601d6ee68a ("bpf: add bpf_link support for BPF_NETFILTER programs")
> Signed-off-by: Tyrone Wu <wudevelops@gmail.com>
> ---
>  net/netfilter/nf_bpf_link.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [bpf,v1,1/2] bpf: fix link info netfilter flags to populate defrag flag
    https://git.kernel.org/bpf/bpf/c/92f3715e1eba
  - [bpf,v1,2/2] selftests/bpf: add asserts for netfilter link info
    https://git.kernel.org/bpf/bpf/c/2aa587fd6659

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



