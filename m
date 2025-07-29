Return-Path: <linux-kselftest+bounces-38037-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2D6B1467F
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 04:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90EF87A58AF
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 02:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941FA1B4257;
	Tue, 29 Jul 2025 02:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQQt/jmC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653D3D515;
	Tue, 29 Jul 2025 02:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753757396; cv=none; b=YFYvie1SS0+V390p/6quPXGSQVpCEoh3tlXXcVSoWBA12SGxxwgYQeJ1QtTncPu/XskwPpdPMAe1vEV5JV+Ua95xOYV0Y3Mhe6UcABLjXCMQzrHOoIDw7nBpeC9AKIwA2ybfZGz7sVcDLdQep18DuLRSm30A7usdkrdcBmUI51I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753757396; c=relaxed/simple;
	bh=VyqxiQ8NCbZflKQ+Ar/wRSR6zyICjozhyJnBUUSXGpg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SWS0oxNDjfYZnp5Op0naV/f+zrb+x20PDuy+KPgrh2ojh93riDKrxmnXYr4dfjVlJJALCr4pvM3NSiqdyc7Pl7M1/G8YT7UXDu3ULGpLYC0E2Pm+2dDyF52YuVe9NMyNjdEdx+QyGIdtdKPUn8KuRKbEZFFP6XxHFgMUvwFFPgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQQt/jmC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B782FC4CEE7;
	Tue, 29 Jul 2025 02:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753757395;
	bh=VyqxiQ8NCbZflKQ+Ar/wRSR6zyICjozhyJnBUUSXGpg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jQQt/jmC2lSSjHVy8gpZaICFw8DDVPztTqN3xzfeIl+kPStbBDDrpD4isu5xBKIie
	 LWkpAxMGXdTOD/n0hUBvBNq3nDBbt5eGVGFHF+RDKZdbn3UL4inzHHHDc9hdvtALPY
	 GAZly6waGjsm9wOoasx34+cY3NAQyjFrgAp5sRsT76rG0/d7NUYigIqzV4H+EgRbpS
	 S2FKIkHx1Hpoj6WgosKkWUquFO4NtLHtz7lwXIdYKi22A8MLJDe+OQ+mDqNpM+CsiE
	 sTvl+HHCfbimbIbjyyIWPDO9+XxEi7L5ioA2L/3J8s9aSQfD4uLuKih1ZE8N9hv9GL
	 WM1umEDn1lflg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BF5383BF5F;
	Tue, 29 Jul 2025 02:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/4] bpf: Show precise rejected function when
 attaching to __noreturn and deny list functions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175375741226.943141.15535826817540151839.git-patchwork-notify@kernel.org>
Date: Tue, 29 Jul 2025 02:50:12 +0000
References: <20250724151454.499040-1-kafai.wan@linux.dev>
In-Reply-To: <20250724151454.499040-1-kafai.wan@linux.dev>
To: KaFai Wan <kafai.wan@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org,
 laoar.shao@gmail.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, leon.hwang@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 24 Jul 2025 23:14:50 +0800 you wrote:
> Show precise rejected function when attaching fexit/fmod_ret to __noreturn
> functions.
> Add log for attaching tracing programs to functions in deny list.
> Add selftest for attaching tracing programs to functions in deny list.
> Migrate fexit_noreturns case into tracing_failure test suite.
> 
> changes:
> v4:
> - change tracing_deny case attaching function (Yonghong Song)
> - add Acked-by: Yafang Shao and Yonghong Song
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/4] bpf: Show precise rejected function when attaching fexit/fmod_ret to __noreturn functions
    https://git.kernel.org/bpf/bpf-next/c/a5a6b29a700f
  - [bpf-next,v4,2/4] bpf: Add log for attaching tracing programs to functions in deny list
    https://git.kernel.org/bpf/bpf-next/c/863aab3d4dcd
  - [bpf-next,v4,3/4] selftests/bpf: Add selftest for attaching tracing programs to functions in deny list
    https://git.kernel.org/bpf/bpf-next/c/a32f6f17a74d
  - [bpf-next,v4,4/4] selftests/bpf: Migrate fexit_noreturns case into tracing_failure test suite
    https://git.kernel.org/bpf/bpf-next/c/51d3750aba79

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



