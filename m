Return-Path: <linux-kselftest+bounces-45032-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E5EC3DD9A
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 00:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD0293A63B7
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 23:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087D5283CA3;
	Thu,  6 Nov 2025 23:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSuJPQf6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC361DA0E1;
	Thu,  6 Nov 2025 23:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762471836; cv=none; b=tefDzR2zii+d6l804uISCwPfpUBsdpQ7MUGF9OAF6YaOOvCmkbQqVwIqWQPweI1nsGB0CeQxy9n+9Gfa8UPT9Tx77FeXdpVm69o+HICJ8CCvJrt7aTCEDYNR1/ODeu+V65da3dq/WPe1f4xmfq/PJwRa1t9e8DaXzc1VduwnJRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762471836; c=relaxed/simple;
	bh=K0QqZFj7HrX+67e5nOLplrYmM3BGYMERFJGJPgw7I68=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BCMGCs2XWS+Hnh8O3jO3cIozoUFF8l8iSWJxW+mEN+VsByzL1EUkxFeUSWu7UKbQXz/lD8vbaHyJwmYr48p+bWIRjwZpCAJnXQuSWxhLncL6oFlHwiLjo+ii2+DcV2mdGNzzZdwmQc1/IO6QE7btr//9YEmnpDLBPmq9HCo4Ifs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSuJPQf6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA70C4CEF7;
	Thu,  6 Nov 2025 23:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762471836;
	bh=K0QqZFj7HrX+67e5nOLplrYmM3BGYMERFJGJPgw7I68=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nSuJPQf6h4YGFcp0/EV9HH9sh/elgl9hDJCtz9hzJBZPggP8SW4B4HEYzAIEjihyl
	 r4MrGiJNb1u+cjP9oeRTTlYv4XaNDG9oPI1Zdvq5VE+MU1voZMWypHFW9wkmeThCfR
	 Ww7VkFLNhKGp2q47nnk56FCmxQeBxXh368SOyH6hHYp0aQzfmbnxUwtqZYbv6PDXJp
	 mDMd83GN5d18kj4Fwg9qVMj78W588EZA1J9ySamJP8y0Jr+d53oZ5HQRdjICuDCe6l
	 zn958iLMI4RfJeB3/JHHAaVa+rTl6sPvOgbYFZmg2MWArnGxq+KFsg0Vo+Fh6LUsue
	 LvN52Be9EpotA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340BB39EF971;
	Thu,  6 Nov 2025 23:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] selftests/bpf: enfoce SO_REUSEADDR in basic
 test servers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176247180900.389669.9670015362478703792.git-patchwork-notify@kernel.org>
Date: Thu, 06 Nov 2025 23:30:09 +0000
References: <20251105-start-server-soreuseaddr-v1-0-1bbd9c1f8d65@bootlin.com>
In-Reply-To: <20251105-start-server-soreuseaddr-v1-0-1bbd9c1f8d65@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29_=3Calexis=2Elothore=40bo?=@codeaurora.org,
	=?utf-8?q?otlin=2Ecom=3E?=@codeaurora.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 ebpf@linuxfoundation.org, bastien.curutchet@bootlin.com,
 thomas.petazzoni@bootlin.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 05 Nov 2025 09:22:47 +0100 you wrote:
> Hello,
> This small series is another follow-up to [1], in which I misunderstood
> Martin's initial feedback (see [2]). I proposed to make tc-tunnel apply
> SO_REUSEPORT once server is brought up. This series updates
> start_server_addr to really apply Martin's proposal after his
> clarification [3]
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] selftests/bpf: systematically add SO_REUSEADDR in start_server_addr
    https://git.kernel.org/bpf/bpf-next/c/38e36514fcb0
  - [bpf-next,2/2] selftests/bpf: use start_server_str rather than start_reuseport_server in tc_tunnel
    https://git.kernel.org/bpf/bpf-next/c/5b7d6c91986e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



