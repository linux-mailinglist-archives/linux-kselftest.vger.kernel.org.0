Return-Path: <linux-kselftest+bounces-8812-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 120CF8B1473
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 22:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4471D1C22CF5
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 20:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB53E1448D9;
	Wed, 24 Apr 2024 20:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPNq2Ftb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8335E1448CD;
	Wed, 24 Apr 2024 20:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713990030; cv=none; b=Od4nzXn10LMAelSwPH7vo6+JsYPoiiKbkIokc2P0HILcTJRi6XxBkBn95nSJuHsBGXrHuMvHyUTNV7qsLdB8g2FKvbw/8d+h/NabSIufwQbYEh5b9BNQzL9G9YkT8lfPD9t3eAVYJwsm956m5KFUxmI4+a9aUV7LB5l4rZ10WmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713990030; c=relaxed/simple;
	bh=fQ856j6SKsN+kE6au+Bq9GV4p9yr8uKrfjo4ykG96kA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gqG5ppvuLKaFKZmSL9tcsEQO0TMLxLKw5SiOOgnGl+9F6NRqCGHCL8cw/EAp0xbjcnyc80IRAI1oX9NoNpchPPsN+8sU+2LS2QBNc4goGkk+MYZ5I5e6VkTuMaj7DgQm8OzZg05/sOYZMlXdpWP3eC+o541+4g6pcv5a/hQYm8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPNq2Ftb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01C84C113CD;
	Wed, 24 Apr 2024 20:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713990030;
	bh=fQ856j6SKsN+kE6au+Bq9GV4p9yr8uKrfjo4ykG96kA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hPNq2FtbAi5G7BroPCcaxKxRI6oezpH2KNKIewqvF31ioCgLdGM0T2/jrem6t/Dro
	 sInhwjBizygBt+Ye9BDDAAlz75n8RBAuQWoy8P0q/Vkw7UPd3V4OS2pfu5au54xw/h
	 xKQKoBkNuAa3j6bc0LShkxSTu1yohJUvPXQsTd8Mbqi/YvPbnO5z7iypjZ+z/mKHBF
	 cEL18Y331uJlIzDlflZfhhwMamyxnIScP2K4Zp4tcKOj5X8KwQBQPEdgm30M/uJjIK
	 cm4c9HklzJCfUh4EDvJK4LffOXIXJdLN4kIKVgHgnM2dE6AALgqmD6mlJFOG70yDux
	 JinBNQxZgzUjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D5157C43614;
	Wed, 24 Apr 2024 20:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/5] use network helpers, part 2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171399002986.15625.12511567689392379761.git-patchwork-notify@kernel.org>
Date: Wed, 24 Apr 2024 20:20:29 +0000
References: <cover.1713868264.git.tanggeliang@kylinos.cn>
In-Reply-To: <cover.1713868264.git.tanggeliang@kylinos.cn>
To: Geliang Tang <geliang@kernel.org>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 tanggeliang@kylinos.cn, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue, 23 Apr 2024 18:35:26 +0800 you wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patchset uses more network helpers in test_sock_addr.c, but
> first of all, patch 2 is needed to make network_helpers.c independent
> of test_progs.c. Then network_helpers.h can be included into
> test_sock_addr.c without compile errors.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/5] selftests/bpf: Fix a fd leak in error paths in open_netns
    https://git.kernel.org/bpf/bpf-next/c/151f74424366
  - [bpf-next,v2,2/5] selftests/bpf: Use log_err in open_netns/close_netns
    https://git.kernel.org/bpf/bpf-next/c/285cffbaa8e6
  - [bpf-next,v2,3/5] selftests/bpf: Use start_server_addr in test_sock_addr
    https://git.kernel.org/bpf/bpf-next/c/e1cdb70d075e
  - [bpf-next,v2,4/5] selftests/bpf: Use connect_to_addr in test_sock_addr
    https://git.kernel.org/bpf/bpf-next/c/c6c407984281
  - [bpf-next,v2,5/5] selftests/bpf: Use make_sockaddr in test_sock_addr
    https://git.kernel.org/bpf/bpf-next/c/e4c68bbaff11

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



