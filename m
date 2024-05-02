Return-Path: <linux-kselftest+bounces-9291-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0769C8BA327
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 00:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31BD31C20D33
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 22:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2228F5C;
	Thu,  2 May 2024 22:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2C0cDBi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F20E57CB0;
	Thu,  2 May 2024 22:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714689033; cv=none; b=jcZ+Q3NDwCPBzxB1wIuJGTtH11rHtbQtrQdIn7QS+HU5rAwu+CKlr8YOU+PhYGq3suyxdN4Ntj/P6dFFA/mZb6THQYWkWWmXbAifi3Iv31q3wSQ9WUvHa+wmVdBr7tAaLyvtWvQhFk+hHEou6GlzFTUgTSqrg0I1qTaocCIitGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714689033; c=relaxed/simple;
	bh=QZGnUvdVwR89BvjmFjqMdwIjaQH+8xIMyYMoMePP4qM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z1tS6wTqUIXPG8+dY1s8t8GUdQth8Z56lF0lkTV9IUlKtcoIL44eWOWglf/bFd7NxxLMnqRi7uLHTvGff5ztnuY/3/BSKFYD9M0rKC2f0RvdCu7FazOkAxN7AzvMYTdqKtExS+nfO26miTumpGwmvmikQKiO3Y3HRF8WiaKKFaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2C0cDBi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0B82C4AF18;
	Thu,  2 May 2024 22:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714689032;
	bh=QZGnUvdVwR89BvjmFjqMdwIjaQH+8xIMyYMoMePP4qM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k2C0cDBiv4f40modWgR6rLBycWufOT9Z+0MCrNeg6WlDK8y+GaeaTPIwoQd3TFI0g
	 K/Uc5woZdWxrvK6s/6sHROcASWVNxQ6aa+SrPolJDCyzdGXAEEqbVMozKyIO9KML5Y
	 4UPM9UeeT5dfmZs+9ml2bVdFZWTh3Ykpn2/Rs/yOHORKPkA3zcZT07cPL4qtXFZigL
	 4vMHfQZmIbaXFyW5+BFhCIqup6CjHU1x7+vsZXIISsuYR93vlYrry3kK0lkJurhgxM
	 umMid5GiThtvlmn0U5OSeB3FVXw221UvU2xXgTrkBLA6w7Q2kDe07auSXLP2dserOO
	 uWhJvaPyF8G+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DA514C43337;
	Thu,  2 May 2024 22:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next 0/6] selftests/bpf: Add sockaddr tests for kernel
 networking
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171468903188.9823.10683400427580146706.git-patchwork-notify@kernel.org>
Date: Thu, 02 May 2024 22:30:31 +0000
References: <20240429214529.2644801-1-jrife@google.com>
In-Reply-To: <20240429214529.2644801-1-jrife@google.com>
To: Jordan Rife <jrife@google.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, thinker.li@gmail.com, asavkov@redhat.com,
 davemarchevsky@fb.com, imagedong@tencent.com, dxu@dxuuu.xyz,
 void@manifault.com, daan.j.demeyer@gmail.com, bentiss@kernel.org,
 houtao1@huawei.com, willemdebruijn.kernel@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon, 29 Apr 2024 16:45:17 -0500 you wrote:
> This patch series adds test coverage for BPF sockaddr hooks and their
> interactions with kernel socket functions (i.e. kernel_bind(),
> kernel_connect(), kernel_sendmsg(), sock_sendmsg(),
> kernel_getpeername(), and kernel_getsockname()) while also rounding out
> IPv4 and IPv6 sockaddr hook coverage in prog_tests/sock_addr.c.
> 
> As with v1 of this patch series, we add regression coverage for the
> issues addressed by these patches,
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next,1/6] selftests/bpf: Fix bind program for big endian systems
    https://git.kernel.org/bpf/bpf-next/c/8e667a065daa
  - [v3,bpf-next,2/6] selftests/bpf: Implement socket kfuncs for bpf_testmod
    https://git.kernel.org/bpf/bpf-next/c/bbb1cfdd0224
  - [v3,bpf-next,3/6] selftests/bpf: Implement BPF programs for kernel socket operations
    https://git.kernel.org/bpf/bpf-next/c/15b6671efa50
  - [v3,bpf-next,4/6] selftests/bpf: Move IPv4 and IPv6 sockaddr test cases
    https://git.kernel.org/bpf/bpf-next/c/8a9d22b8aeb2
  - [v3,bpf-next,5/6] selftests/bpf: Make sock configurable for each test case
    https://git.kernel.org/bpf/bpf-next/c/524e05ac4e14
  - [v3,bpf-next,6/6] selftests/bpf: Add kernel socket operation tests
    https://git.kernel.org/bpf/bpf-next/c/e0c8a7e7526f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



