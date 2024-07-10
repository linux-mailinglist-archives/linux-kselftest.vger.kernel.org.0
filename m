Return-Path: <linux-kselftest+bounces-13497-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A54B292D8A8
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 21:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606BB283A8D
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 19:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78418195FE6;
	Wed, 10 Jul 2024 19:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vs65YbH8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2E5194C64;
	Wed, 10 Jul 2024 19:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720638039; cv=none; b=Czf5pnzzuTHkPCwrCcnweEBI8b2QKm7b4kL/jvFywH4LgXw9DH1vMqvIbI/uv0/pzGhXmURTs9731i37ta3MgfVl23g1vbgDPk1iF1pA0//d+tUVN2LQge3Fg0ZIoWqRli/DFvsX1+AZUMvbw2YeRpr27qz8iNeSYE+vaehOigE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720638039; c=relaxed/simple;
	bh=Z5F4OCP3L1vLRXRXUv9k4MCjSQFcUbqWAtRby/3MMgI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JWBxRx/FyCc3PJmvSoig+rYpRk9b2pRNCOnms6nXwro9dbodlsrRl7SgkICDunAv5oWC0rmUF7k4d/929ciePLjLUydIHOx4e6C8Je+ZDgA2tfkjrk5TZgYiWJsnAE0uWMsv152KAT5d7QJ9+RHwTPOWSSa4cXMaharlrIyIm5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vs65YbH8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3B9BC32786;
	Wed, 10 Jul 2024 19:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720638038;
	bh=Z5F4OCP3L1vLRXRXUv9k4MCjSQFcUbqWAtRby/3MMgI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Vs65YbH8wwGat+eGC+hVHb9rIUv+nlom1QdRD1eFaSVom1wzenQiTchKqBMEm1vtg
	 B9lwXoo/eS0HhrG8WS7IgGb0xeuhlLHljwvh5cHeOnqVY9Q2yM6up1/qQKEBgi6a56
	 L20hm+B27oETg/ZNK2lGequrdgM3WWPoCZYgdCpvgdkPIj2t0cyoNced/AGU821tel
	 /C6O1wWFYe65XZAGfQczIBE8nsOTjZbscRaSWUIq1fLtkfdhTzqvyjFdxffgAmFeTb
	 r3ESPQkvxC/Bgtkhs4XNLeMcSuKshHD5/qwk/itlFz8YTVTuEQHGXb/DfX4edctBic
	 Yee1D8BB1YHcg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BC719C4332E;
	Wed, 10 Jul 2024 19:00:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v11 0/9] use network helpers, part 8
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172063803876.15275.14385138929518529684.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jul 2024 19:00:38 +0000
References: <cover.1720515893.git.tanggeliang@kylinos.cn>
In-Reply-To: <cover.1720515893.git.tanggeliang@kylinos.cn>
To: Geliang Tang <geliang@kernel.org>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 tanggeliang@kylinos.cn, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue,  9 Jul 2024 17:16:16 +0800 you wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> v11:
>  - new patches 2, 4, 6.
>  - drop expect_errno from network_helper_opts as Eduard and Martin
>    suggested.
>  - drop sockmap_ktls patches from this set.
>  - add a new helper connect_fd_to_addr_str.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v11,1/9] selftests/bpf: Add backlog for network_helper_opts
    https://git.kernel.org/bpf/bpf-next/c/a3016a27cea8
  - [bpf-next,v11,2/9] selftests/bpf: Add ASSERT_OK_FD macro
    https://git.kernel.org/bpf/bpf-next/c/7046345d48ad
  - [bpf-next,v11,3/9] selftests/bpf: Close fd in error path in drop_on_reuseport
    https://git.kernel.org/bpf/bpf-next/c/adae187ebedc
  - [bpf-next,v11,4/9] selftests/bpf: Use start_server_str in sk_lookup
    https://git.kernel.org/bpf/bpf-next/c/14fc6fcd35e7
  - [bpf-next,v11,5/9] selftests/bpf: Use start_server_addr in sk_lookup
    https://git.kernel.org/bpf/bpf-next/c/d9810c43f660
  - [bpf-next,v11,6/9] selftests/bpf: Use connect_fd_to_fd in sk_lookup
    https://git.kernel.org/bpf/bpf-next/c/9004054b1629
  - [bpf-next,v11,7/9] selftests/bpf: Add connect_fd_to_addr_str helper
    (no matching commit)
  - [bpf-next,v11,8/9] selftests/bpf: Use connect_fd_to_addr_str in sk_lookup
    (no matching commit)
  - [bpf-next,v11,9/9] selftests/bpf: Drop make_socket in sk_lookup
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



