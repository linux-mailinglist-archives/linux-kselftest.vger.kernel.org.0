Return-Path: <linux-kselftest+bounces-12394-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5467791191D
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 05:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D64C82842FB
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 03:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B143184E0D;
	Fri, 21 Jun 2024 03:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Us43F5UP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846392904;
	Fri, 21 Jun 2024 03:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718941831; cv=none; b=VGi3KjMaXQ2suDkwXwoMQly4K/KWA1PFmVDsPAiVN1lqsk+Jw7NAwaV6WY2dSkZ1O2gnGvPOtZhb0dD9eKWMUQAE4IRnPwFOdOICm7CKpBgD82fW304GBh80uR9aswA2GD7p7dmD79CcbtljuwzAEZwJl9mvD7+ngtZl1D8HwKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718941831; c=relaxed/simple;
	bh=Kj43b90q4hs4uUk/svMfiuEafvubhYopRgGw9yCLfmg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZKDDByTAwld4g0/PFM1CjZozFMS1D3RQWlgq3WTINcKD3UMur2gsBf9dw38s+NHjm0yVAkincQx7kFJy8EglJAWylS1bABKTgAU3GytCuBHibyKeXXdNJBAUaEVZIqcM2B6TB7igV7klOHRrVQvpGsFedsvnl5KsmiRmirKayo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Us43F5UP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C69FCC4AF07;
	Fri, 21 Jun 2024 03:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718941830;
	bh=Kj43b90q4hs4uUk/svMfiuEafvubhYopRgGw9yCLfmg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Us43F5UPlsMQQrw2QntXmHyxpxqV1Bw6Hf4xfJ80uEt57aMEGQyvMNQkYe6h2n6dl
	 jbTJezE0R6ab5Bj2iiN9zPsXI5q1VU0xH3k9mpcB+8sSS6IzvKykMBINPzquqQgkR9
	 0N7iEwosBzS/zdGqAi/1qhaCqaxVm+0Zt1gHEm0Kg/EDQihonkbshNdzIMeK9ZyHRX
	 7tl7m6UMQkBhxeCnJuXitUQKTJSFNHa97ol1FrDtBHOYqn+K+8hBdiufM7s1xPACkM
	 NMhGKaoeh9W7Wx2rjzYBTQ/fLCZpn6YCmcZJ0CMbfGqoXOdZCUFTDboPgKDDH4bMMS
	 a7OE2Mz7/tnfw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A8943CF3B9A;
	Fri, 21 Jun 2024 03:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6 0/6] use network helpers, part 7
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171894183068.10505.4717563449095144066.git-patchwork-notify@kernel.org>
Date: Fri, 21 Jun 2024 03:50:30 +0000
References: <cover.1718932493.git.tanggeliang@kylinos.cn>
In-Reply-To: <cover.1718932493.git.tanggeliang@kylinos.cn>
To: Geliang Tang <geliang@kernel.org>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 tanggeliang@kylinos.cn, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 21 Jun 2024 10:15:57 +0800 you wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> v6:
>  - update ASSERT strings in patch 4 as Eduard suggested. (thanks)
> 
> v5:
>  - update patch 1, add getsockopt(SO_PROTOCOL) in connect_to_fd() to
> fix errors reported by CI.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6,1/6] selftests/bpf: Drop type from network_helper_opts
    https://git.kernel.org/bpf/bpf-next/c/34ad6ec97252
  - [bpf-next,v6,2/6] selftests/bpf: Use connect_to_addr in connect_to_fd_opt
    https://git.kernel.org/bpf/bpf-next/c/08a5206240d3
  - [bpf-next,v6,3/6] selftests/bpf: Add client_socket helper
    https://git.kernel.org/bpf/bpf-next/c/bbca57aa378b
  - [bpf-next,v6,4/6] selftests/bpf: Drop noconnect from network_helper_opts
    https://git.kernel.org/bpf/bpf-next/c/7f0d5140a6d6
  - [bpf-next,v6,5/6] selftests/bpf: Use start_server_str in mptcp
    https://git.kernel.org/bpf/bpf-next/c/fb69f71cf585
  - [bpf-next,v6,6/6] selftests/bpf: Use start_server_str in test_tcp_check_syncookie_user
    https://git.kernel.org/bpf/bpf-next/c/8cab7cdcf5ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



