Return-Path: <linux-kselftest+bounces-26909-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85978A3AC5B
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 00:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B8AE3AB7DC
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 23:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5DD1DCB09;
	Tue, 18 Feb 2025 23:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWjnjjE6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA5A1D61B1;
	Tue, 18 Feb 2025 23:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739920204; cv=none; b=c9t28L6GAfnisSru6oAfil5l3J7scH15b8PwS0cQEeEaTERjIBLW98HLm6G8emBhzkRz8Aacn/+v3D8FLqwsoxhGs0V6kd8L5tWnt0H0QWV9P7+q4JVvAZCNRqcQ6vgGmttuOIyHKVtobBpGkW/aWeGs/NkecCrWonpG0F/OeNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739920204; c=relaxed/simple;
	bh=G0gJEYl8XkYWl55XF29TIA+jeJYaG+qPI/N7IHDFyco=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D44x+nBFo+SJPvPloOTAQXp88Y54YIxbdpcJBQ5uVukD6pSywRsx7jmsweTqxZ5oSV95qgyBNptzEakftDA0qsi2v/jF64fs6MpWbg2FTI24IAZP77a392UzlJrnRTBTo8LSXZxRDivUToNPSulQ6pITPGDU+XfRobe7plyTJCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWjnjjE6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB802C4CEE2;
	Tue, 18 Feb 2025 23:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739920203;
	bh=G0gJEYl8XkYWl55XF29TIA+jeJYaG+qPI/N7IHDFyco=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JWjnjjE6b1we6u+ZXKysajBCcQQ9LgtkOE3q/kktMQKurPsu+AZl+ykWgJpRE5tKL
	 g4pngJsXiKBKJ/YpR9Pi5Wc4g822wfcaDOnIhFrz5+zMBenEtFExJZEohor/55p820
	 LFD/o71O+AvDabrWQgv4jHtfDx7iGHJfXsjk15AYnvCqDUQqcO7oxuZvk/ASCWHECY
	 GAiLNUyW+BMW/tLe5lSIq8uLpK3CxFymMunWwO/xr16MUCgT0UV7ZsFKRHZcliYfmS
	 vMRwSiG3h9w8ENls6v2QCu701jv7cjxZNCcGN7HU7bWYzR9Kp0xP0i1lrhiZgFtohT
	 plmU7KLr8yFMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71604380AAE9;
	Tue, 18 Feb 2025 23:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/6] selftests/bpf: Migrate
 test_xdp_redirect_multi.sh to test_progs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173992023426.60439.8671131684601738339.git-patchwork-notify@kernel.org>
Date: Tue, 18 Feb 2025 23:10:34 +0000
References: <20250212-redirect-multi-v5-0-fd0d39fca6e6@bootlin.com>
In-Reply-To: <20250212-redirect-multi-v5-0-fd0d39fca6e6@bootlin.com>
To: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
Cc: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org,
 alexis.lothore@bootlin.com, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 12 Feb 2025 12:11:08 +0100 you wrote:
> Hi all,
> 
> This patch series continues the work to migrate the *.sh tests into
> prog_tests framework.
> 
> test_xdp_redirect_multi.sh tests the XDP redirections done through
> bpf_redirect_map().
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/6] selftests/bpf: test_xdp_veth: Create struct net_configuration
    https://git.kernel.org/bpf/bpf-next/c/6bdac0e317e9
  - [bpf-next,v5,2/6] selftests/bpf: test_xdp_veth: Use a dedicated namespace
    https://git.kernel.org/bpf/bpf-next/c/19a9484c1bbc
  - [bpf-next,v5,3/6] selftests/bpf: Optionally select broadcasting flags
    https://git.kernel.org/bpf/bpf-next/c/09c8bb1fae15
  - [bpf-next,v5,4/6] selftests/bpf: test_xdp_veth: Add XDP broadcast redirection tests
    https://git.kernel.org/bpf/bpf-next/c/1e7e6345429c
  - [bpf-next,v5,5/6] selftests/bpf: test_xdp_veth: Add XDP program on egress test
    https://git.kernel.org/bpf/bpf-next/c/a93bfd824d95
  - [bpf-next,v5,6/6] selftests/bpf: Remove test_xdp_redirect_multi.sh
    https://git.kernel.org/bpf/bpf-next/c/e06f5bfd937d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



