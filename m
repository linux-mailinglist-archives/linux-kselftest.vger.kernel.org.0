Return-Path: <linux-kselftest+bounces-36707-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A49F6AFB7E5
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 17:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF37E1896D64
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 15:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B49213E77;
	Mon,  7 Jul 2025 15:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFybv8Az"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A4520FAAB;
	Mon,  7 Jul 2025 15:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751903387; cv=none; b=JwdBkIMreRN/iDYiJ+5PGvmpSkRbISp5gS5SLF8+pKOpMoYwhXL2PzVzOvOh87Ajpe8pyliw7DxFqu8VJqvagHg17bgLFoMB9RakPbBr8sJRyedEOFDfhXn7M2i4c0ULpxTZQeK9/ELD3A8LNRAsJ125j0TmMteAu/hueSaPffU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751903387; c=relaxed/simple;
	bh=Imu1lpiI8R0ZjE21tznUcN/1InDVfhQOA2tHcHgZxXQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t5UOYttzNM+JbIYBv+kTdbu/ubL881ytaRzGXmwUdXQYwyWwevNk9a/gQM6Sb/EEECCexeAx6ovA2TBdR2B1a9nOqyMu8Gd3gkCRmxge7MDatZB1bZJWTXDJaHFWHejG8J+dr72lTp5FeTHkZ0ex5t3PtlxtHRYBzJ9oE3rcFHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFybv8Az; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10DADC4CEE3;
	Mon,  7 Jul 2025 15:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751903387;
	bh=Imu1lpiI8R0ZjE21tznUcN/1InDVfhQOA2tHcHgZxXQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WFybv8Azeg/aFZ8WeLtpFAieG77Ybo6Cr/pOH4Yq2fRrPiL1vOB/scUPEyvcZ0MON
	 AjF3vJuHnpz7ZYE5I1Xnxy52T9eL4VEyuyJE6JsoY72GEEJgc8S4P0g8rfIChI3CoC
	 qh8hSnYaA5ygp85ZBMvpKQPf4R5smbx9zy2kqjRHRPnhUelc/dmnTeNevzSq7Bl+Es
	 hY2pBhC6TjB9INfYwi/KXVGwhcPNKTow0YEn/a9prsH3puennW3nUb0Qw6HZT0gFhD
	 lcWVVVtaXulJGHY3n+4GoYyFBDgQHNdM0WaGoZTQcQTJeseODhgS0gm++0ziOqTEef
	 QS+zVMS8HFOhA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713EE383BA25;
	Mon,  7 Jul 2025 15:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/2] bpf: Fix and test aux usage after
 do_check_insn()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175190341018.3340086.4902525368986616519.git-patchwork-notify@kernel.org>
Date: Mon, 07 Jul 2025 15:50:10 +0000
References: <20250705190908.1756862-1-luis.gerhorst@fau.de>
In-Reply-To: <20250705190908.1756862-1-luis.gerhorst@fau.de>
To: Luis Gerhorst <luis.gerhorst@fau.de>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, memxor@gmail.com, yepeilin@google.com, skb99@linux.ibm.com,
 vmalik@redhat.com, isolodrai@meta.com, dxu@dxuuu.xyz, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 paul.chaignon@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat,  5 Jul 2025 21:09:06 +0200 you wrote:
> Fix cur_aux()->nospec_result test after do_check_insn() referring to the
> to-be-analyzed (potentially unsafe) instruction, not the
> already-analyzed (safe) instruction. This might allow a unsafe insn to
> slip through on a speculative path. Create some tests from the
> reproducer [1].
> 
> Commit d6f1c85f2253 ("bpf: Fall back to nospec for Spectre v1") should
> not be in any stable kernel yet, therefore bpf-next should suffice.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] bpf: Fix aux usage after do_check_insn()
    https://git.kernel.org/bpf/bpf-next/c/dadb59104c64
  - [bpf-next,v3,2/2] selftests/bpf: Add Spectre v4 tests
    https://git.kernel.org/bpf/bpf-next/c/92974cef83b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



