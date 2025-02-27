Return-Path: <linux-kselftest+bounces-27787-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 472F2A4849F
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 17:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C5BE7A11E0
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 16:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7694B1A9B29;
	Thu, 27 Feb 2025 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMtq2638"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442FF198823;
	Thu, 27 Feb 2025 16:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673200; cv=none; b=Fc7La2vdDInJ1yxx42zbBF/mMyS90P+uq+JVUbU+mJ254wmEt5UW3N9EKCPa+GYAIXoMxcRLBMF9pHTvrRcE7CWJYcA9QIVksIl5x2DiYUtLoxzrQe1nVHoso7AlOEAss2C50OuWueWkhxXJuvT2AqdFoCK7WXh3PK7Q6BE4dEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673200; c=relaxed/simple;
	bh=y/2Nr36NXLKaDCoN5EX8Qk/6K0dQTdt6rNcVkgwm6DI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mogavSuZky0wVMMD0zmk88A8OXsTOIeoGWprEQkiTOoOJuTap6pFzT08HjwlkLaEQuO7pjV6+ijhXTcrGRm7o+yS9KpiALwoQe6ZKFUFsGg7AzzyjQaGFaQXEb7qTwdrXQkVq3EY7PeqlqlMJo0X3MmuYdGcndnr9s9xc46mv8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMtq2638; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89D2C4CEDD;
	Thu, 27 Feb 2025 16:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740673199;
	bh=y/2Nr36NXLKaDCoN5EX8Qk/6K0dQTdt6rNcVkgwm6DI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CMtq2638oo+hngEcmTw3lpKtE1Ao9udiTyUaYD9Fk5U1zOMK5CPffOxsoWZomLbN6
	 MIGAVVskGyLKqBo0tlL+PFtDfie2igvMcG6T/n+tflYep44X8yx4EAQc9gXHmkAq8Q
	 muFLchyyZzpgQ9CFlfGwsv5Ls5xC6rywQk6DGTT4qDBPczWu3stHax7JUH0svMuHQV
	 am+raCymkOcyWstED+Aoa2XGsZuUyjvH6xhtJ+iUWMrDdRsHHTLwUAIGg5kdyS/F4t
	 utQ1WTHBeN5Ev7tFujrhHS0fKDvTgwEezxL6klihaZx7r8hsP2aJjXa9DKiPYoz7kP
	 +zEqm9zUpo6Ng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB3FA380AACB;
	Thu, 27 Feb 2025 16:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1 0/3] Optimize bpf selftest to increase CI success
 rate
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174067323175.1484560.1369764651554494631.git-patchwork-notify@kernel.org>
Date: Thu, 27 Feb 2025 16:20:31 +0000
References: <20250227142646.59711-1-jiayuan.chen@linux.dev>
In-Reply-To: <20250227142646.59711-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, john.fastabend@gmail.com, davem@davemloft.net,
 kuba@kernel.org, andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com,
 ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, hawk@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, mrpre@163.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 27 Feb 2025 22:26:43 +0800 you wrote:
> 1. Optimized some static bound port selftests to avoid port occupation
> when running test_progs -j.
> 2. Optimized the retry logic for test_maps.
> 
> Some Failed CI:
> https://github.com/kernel-patches/bpf/actions/runs/13275542359/job/37064974076
> https://github.com/kernel-patches/bpf/actions/runs/13549227497/job/37868926343
> https://github.com/kernel-patches/bpf/actions/runs/13548089029/job/37865812030
> https://github.com/kernel-patches/bpf/actions/runs/13553536268/job/37883329296
> (Perhaps it's due to the large number of pull requests requiring CI runs?)
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1,1/3] selftests/bpf: Allow auto port binding for cgroup connect
    https://git.kernel.org/bpf/bpf-next/c/27e3162a0364
  - [bpf-next,v1,2/3] selftests/bpf: Allow auto port binding for bpf nf
    https://git.kernel.org/bpf/bpf-next/c/dbe7d46ed109
  - [bpf-next,v1,3/3] selftests/bpf: Fixes for test_maps test
    https://git.kernel.org/bpf/bpf-next/c/09de329523c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



