Return-Path: <linux-kselftest+bounces-30460-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F86A8370F
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 05:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9CAE444BD7
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 03:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439661EEA5C;
	Thu, 10 Apr 2025 03:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROdXnBIo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139A01519B9;
	Thu, 10 Apr 2025 03:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744254601; cv=none; b=HeYiPuwiL4AvKJgKOxfKa/BSUy5Kdq4l7qL7zv+Tmxyl1+nLRuPRtdya8tAPZKxVLBHh95JAQTgyBRZgGTFtY6JbxJ0JSl5JjXibh1dXGft6KrIQNTCxVdxQzWlh7JhaCUbXs9qRnhrdk5G9knElnNBOU1Pec92qzbDoxBlq8Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744254601; c=relaxed/simple;
	bh=+x4N2KddczS3M2cHECoSS1dKNDFNd/yQmKExhiectpI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sCX+4wE/iRu/d4NJB7h+h+Xs4nn0sltMjn4g1v0Ht8lOgWnChXlEIoReWPA5hiBl8dv49Xj4hSUlNo1Wkosr/Jdu8uy+WUgKudD6PnE4p8DoL7kFHMUfVJsH36ZpWgjgYYgXZ3HEzUiVlJd+7J358XaBPM7rlMug7GcIydTviss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROdXnBIo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7598DC4CEE2;
	Thu, 10 Apr 2025 03:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744254600;
	bh=+x4N2KddczS3M2cHECoSS1dKNDFNd/yQmKExhiectpI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ROdXnBIoGfSQnZutmUYLq205AAvoPagEkqWsBjdtNeobBK9N/WZAy3lFcwPKHHSK4
	 Fn2pYLli3pLZV+LN1wyzRA58A7t9UJAKjfYyl14FsFbDaJe1Ooks0Ga9By3ZYJugZS
	 3CJm7rs5UFcW4QFaqt/n/u7OSyL3kOqaYyDNJsyp18BsNFttH9Hcjgk3zEW4duOnBe
	 i5DKwzVmXpw/UA4PlOXmuwRcCF7Hw5VItsEzA/Br0RR7eEQeEon82QgnriFVxE9Ou/
	 5jEeq+U2rSQiKj2buqeKYuZJXRW6LFltJ66r5eHCgDqPIwlct2i38l2mZbEtkrjcy+
	 GuHlxsfgQk4cg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2C38F380CEF9;
	Thu, 10 Apr 2025 03:10:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1 0/4] bpf, sockmap: Fix data loss and panic issues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174425463772.3131897.3560283890937950515.git-patchwork-notify@kernel.org>
Date: Thu, 10 Apr 2025 03:10:37 +0000
References: <20250407142234.47591-1-jiayuan.chen@linux.dev>
In-Reply-To: <20250407142234.47591-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, mrpre@163.com, john.fastabend@gmail.com,
 jakub@cloudflare.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 mykolal@fb.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  7 Apr 2025 22:21:19 +0800 you wrote:
> I was writing a benchmark based on sockmap + TCP and discovered several
> issues:
> 
> 1. When EAGAIN occurs, the direction of skb is incorrect, causing data
>    loss when retry.
> 2. When sending partial data, the offset is not recorded, leading to
>    duplicate data being sent when retry.
> 3. An unexpected BUG_ON() judgment in skb_linearize is triggered.
> 4. The memory of psock->ingress_skb is not limited by the socket buffer
>    and memcg.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1,1/4] bpf, sockmap: Fix data lost during EAGAIN retries
    https://git.kernel.org/bpf/bpf-next/c/7683167196bd
  - [bpf-next,v1,2/4] bpf, sockmap: fix duplicated data transmission
    https://git.kernel.org/bpf/bpf-next/c/3b4f14b79428
  - [bpf-next,v1,3/4] bpf, sockmap: Fix panic when calling skb_linearize
    https://git.kernel.org/bpf/bpf-next/c/5ca2e29f6834
  - [bpf-next,v1,4/4] selftest/bpf/benchs: Add benchmark for sockmap usage
    https://git.kernel.org/bpf/bpf-next/c/7b2fa44de5e7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



