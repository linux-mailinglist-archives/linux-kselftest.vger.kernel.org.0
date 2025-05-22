Return-Path: <linux-kselftest+bounces-33526-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB77BAC168B
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 00:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 257057AC604
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 22:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2801526FA56;
	Thu, 22 May 2025 22:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4xUTCq9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BBE26B968;
	Thu, 22 May 2025 22:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747952405; cv=none; b=Y0kquuKIzWS1run+edeYATE7HnzPAm6TEfhidP9yHuuYCYzJJMlD/B5aLY7t+qJiiB7FPRp25cJburLoxjMpklRjKG2aJbObOnSF+QeLI4bsGXRMGwWbuitO6EfFO2siskivDkKaJnGjuwbspiHdL4d2c+7KM+I6IxNvvPWV/4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747952405; c=relaxed/simple;
	bh=PwYK2yYeLn+Oou4JsY36nhUzSuMSbtdBTpEgutARMqk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pDcVfhYbY9+WFb1dG6AaVgX9rrRTfbQ9qjk1MSvp6sAwPCGoyR/ONxZtb6vdM9p1M+wOyuNDeOsI1/YFNVE01Icu4rAKrXG0uNuYYAB30v7YjmVY0WFFZ5zs5GfkyGUnAz5+YwKRi8KMupxf3+ZLiGLgbWy5q1XwG79PEwbD4bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4xUTCq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C3AC4CEE4;
	Thu, 22 May 2025 22:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747952404;
	bh=PwYK2yYeLn+Oou4JsY36nhUzSuMSbtdBTpEgutARMqk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K4xUTCq9L/f9q5t09qgMqOhjW5B9jn5+55XxG9/AMRiIqFkYHzxhV4oFCeiUiMKPC
	 kx3Hpcidc5gISWI/zx9uppOssfDkoeehyil5/XSUt112fb+MgMdHm76l64JoJSy6u0
	 0w97zpTGtqzQ8iu3lqyTwVNfGMsR3nwzQLXxKLsQ9Ehfu7OsEHBjlMdwFbtNEbMdHV
	 KuCvubzaJk1ZUolnsd1nvgojSyQ0TQcNmjLHbcU6oVYq5bkOMnrwPVwlhteE0RmpKc
	 j3NTofxXCTBysNbk9VgJAcmoXf8sxJYBTKNwe2UCljHYBViESGbJBLTlSFPAWBl2lh
	 oT4KAhx3sMsqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E2C3805D89;
	Thu, 22 May 2025 22:20:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/8] selftests/bpf: Test sockmap/sockhash
 redirection
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174795244025.3035914.3223968241025374027.git-patchwork-notify@kernel.org>
Date: Thu, 22 May 2025 22:20:40 +0000
References: <20250515-selftests-sockmap-redir-v3-0-a1ea723f7e7e@rbox.co>
In-Reply-To: <20250515-selftests-sockmap-redir-v3-0-a1ea723f7e7e@rbox.co>
To: Michal Luczaj <mhal@rbox.co>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, jakub@cloudflare.com, mrpre@163.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu, 15 May 2025 00:15:23 +0200 you wrote:
> John, this revision introduces one more patch: "selftests/bpf: Introduce
> verdict programs for sockmap_redir". I've kept you cross-series Acked-by. I
> hope it's ok.
> 
> Jiayuan, I haven't heard back from you regarding [*], so I've kept things
> unchanged for now. Please let me know what you think.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/8] selftests/bpf: Support af_unix SOCK_DGRAM socket pair creation
    https://git.kernel.org/bpf/bpf-next/c/fb1131d5e181
  - [bpf-next,v3,2/8] selftests/bpf: Add socket_kind_to_str() to socket_helpers
    https://git.kernel.org/bpf/bpf-next/c/d87857946ded
  - [bpf-next,v3,3/8] selftests/bpf: Add u32()/u64() to sockmap_helpers
    https://git.kernel.org/bpf/bpf-next/c/b57482b0fe8e
  - [bpf-next,v3,4/8] selftests/bpf: Introduce verdict programs for sockmap_redir
    https://git.kernel.org/bpf/bpf-next/c/f266905bb3d8
  - [bpf-next,v3,5/8] selftests/bpf: Add selftest for sockmap/hashmap redirection
    https://git.kernel.org/bpf/bpf-next/c/f0709263a07e
  - [bpf-next,v3,6/8] selftests/bpf: sockmap_listen cleanup: Drop af_vsock redir tests
    https://git.kernel.org/bpf/bpf-next/c/9266e49d608c
  - [bpf-next,v3,7/8] selftests/bpf: sockmap_listen cleanup: Drop af_unix redir tests
    https://git.kernel.org/bpf/bpf-next/c/f3de1cf621f7
  - [bpf-next,v3,8/8] selftests/bpf: sockmap_listen cleanup: Drop af_inet SOCK_DGRAM redir tests
    https://git.kernel.org/bpf/bpf-next/c/c04eeeb2af8e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



