Return-Path: <linux-kselftest+bounces-33886-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DF1AC59AB
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 20:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B491E188EC8F
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 18:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063C227F747;
	Tue, 27 May 2025 17:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggt6+u75"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE31F1D6DC5;
	Tue, 27 May 2025 17:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748368798; cv=none; b=kWsH9BH8M87gsqvGuZKjtlLcaZlvV48PVOkMVzW1dBQDLnDxZuGl24vNjwc76ygMYc7tU5iSfDyQYc4slzb/pk889jUh/7pDH7FLYcO+BtYg+GPGU74L7N4k8LeFZss+x9489CyfqGtUlOzHO1HIkGT9AbrWxmIYzD6YP69hBCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748368798; c=relaxed/simple;
	bh=tGyF8P4S3EbpCGhv5Z7+NumLX4kyyVCYj56OYjztRUc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ic4wpnEZfcmDIY/inx16WITDLkGkNkzim1/WD6KafNqEf5st0Lff5g2UYfzTYg5H7vrONh4VonPv59SsHw7RnZj3CRu3JfGHMTUy3y32UKh3dgoXSkT71sQxkA4Pd3m1YwbWpcMQok9pghWMUE04UGuiTymrdSIuDZYiuM6xXs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggt6+u75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828BBC4CEE9;
	Tue, 27 May 2025 17:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748368798;
	bh=tGyF8P4S3EbpCGhv5Z7+NumLX4kyyVCYj56OYjztRUc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ggt6+u75DuvvhATXL/Ewb/Tq5FV0I1Sxv6il87g5pmcWFTwGMNBYEIz0F+RpIpq2L
	 y5xDFiwe5FhVeBpkceQMQDA11szxUtqBezuC4ejM7PnpXXCsvb/leNkeqUCU2jyP+L
	 iCzGf9c30L1bTSveU3ZRMPLosVFHfbFNftZUkyWSFKCOrqpO+AsoItqhbJYktg9BPe
	 XRpxjQziE+o8xnvHVP8IjsEfpwzKrvJi+Q0lDl1yoCFm69wfQApAUbYYYr2KkM4ovI
	 f1XcwM6CypG/fOxjpYJsYlGkXCYiKKwY5NoWZgzMzSjIosmKx9ZvbILKzeTX9Ha16t
	 X7BNVlEMOv7pg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB29F380AAE2;
	Tue, 27 May 2025 18:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/2] bpf, arm64: support up to 12 arguments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174836883250.1728518.5524041990135634472.git-patchwork-notify@kernel.org>
Date: Tue, 27 May 2025 18:00:32 +0000
References: <20250527-many_args_arm64-v3-0-3faf7bb8e4a2@bootlin.com>
In-Reply-To: <20250527-many_args_arm64-v3-0-3faf7bb8e4a2@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29_=3Calexis=2Elothore=40bo?=@codeaurora.org,
	=?utf-8?q?otlin=2Ecom=3E?=@codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, puranjay@kernel.org,
 xukuohai@huaweicloud.com, catalin.marinas@arm.com, will@kernel.org,
 mykolal@fb.com, shuah@kernel.org, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, revest@chromium.org,
 bastien.curutchet@bootlin.com, ebpf@linuxfoundation.org,
 thomas.petazzoni@bootlin.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 xukuohai@huawei.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 27 May 2025 12:06:02 +0200 you wrote:
> Hello,
> 
> this is the v2 of the many args series for arm64, being itself a revival
> of Xu Kuhoai's work to enable larger arguments count for BPF programs on
> ARM64 ([1]).
> 
> The discussions in v1 shed some light on some issues around specific
> cases, for example with functions passing struct on stack with custom
> packing/alignment attributes: those cases can not be properly detected
> with the current BTF info. So this new revision aims to separate
> concerns with a simpler implementation, just accepting additional args
> on stack if we can make sure about the alignment constraints (and so,
> refusing attachment to functions passing structs on stacks). I then
> checked if the specific alignment constraints could be checked with
> larger scalar types rather than structs, but it appears that this use
> case is in fact rejected at the verifier level (see a9b59159d338 ("bpf:
> Do not allow btf_ctx_access with __int128 types")). So in the end the
> specific alignment corner cases raised in [1] can not really happen in
> the kernel in its current state. This new revision still brings support
> for the standard cases as a first step, it will then be possible to
> iterate on top of it to add the more specific cases like struct passed
> on stack and larger types.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] bpf, arm64: Support up to 12 function arguments
    https://git.kernel.org/bpf/bpf-next/c/9014cf56f13d
  - [bpf-next,v3,2/2] selftests/bpf: enable many-args tests for arm64
    https://git.kernel.org/bpf/bpf-next/c/149ead9d7e3d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



