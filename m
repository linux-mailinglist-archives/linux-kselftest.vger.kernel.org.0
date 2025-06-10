Return-Path: <linux-kselftest+bounces-34538-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA5FAD2D47
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 07:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 397903B251B
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 05:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B4E25C83D;
	Tue, 10 Jun 2025 05:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVrYpges"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477CD380;
	Tue, 10 Jun 2025 05:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749533409; cv=none; b=sZ8fEd4V4fZ4bsVt2lahAxD05LzKVpJBqaQZp4aK8c8k0/PW3de9g30+yeGDb8zM2YyTTAInrVX6B1BCWdeUY9GFkj6PiVDeDAu1yVPnUSCkRPVsFk+q9V1aubTkZOdl48hRsFeE1ln5A9UTXPlqF2nYaF4vbof6b42xdtAc4EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749533409; c=relaxed/simple;
	bh=AirqLxaAn1XDcww7YIT/2rzH+IYyH+8RkAxc6uGReYs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jMSQKMn0ADly4fIv59ycvAFXaRxLR/yGqzq5dll00KlU+V39Hyu59U+Xt+hfIdUKmxW2oF4zzRAd4SXbM0eR3bWXg5UdK2KCMkmV1fU722XX+UJOUtLpAJT7kiCmA9bPBsUO3DoI2ZuQi5rKvIDpD0iaRig5wlvkao55Koc3+rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVrYpges; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5CF0C4CEEF;
	Tue, 10 Jun 2025 05:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749533408;
	bh=AirqLxaAn1XDcww7YIT/2rzH+IYyH+8RkAxc6uGReYs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KVrYpgesvClwcE62Y4eoV7SPMtyy0KeY1N9kYJS6gk6L+ykyW0g4V/rmMlRwsHekm
	 e5b/s6tAKzy+VIsxLBLkGQDD6LY1mkeIUKS9+BKAOVk1QV5Iu9Xl8/ymgkykmhyiIi
	 qCF8YFGPF3nAqDWaBMaSQmhtnCIlJT1fZ6h7VLeMUv9/GR3IQL13mRFA8cv1/skCSI
	 v1ObDw7MhTmaj9QOP+rsMT8ne4vhAbSuSm9bE2EYkO0jwY5H4lS+68vnt9mThfMih0
	 AsujfctxEEua0TUSrPFraj3Ycg0QWLUnMJAMP896nShsL1RmqIy95R7nJ42gITAAHS
	 T2NuytqPyee7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C0C3822D49;
	Tue, 10 Jun 2025 05:30:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/9] bpf: Mitigate Spectre v1 using barriers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174953343925.1751142.14175959764771904757.git-patchwork-notify@kernel.org>
Date: Tue, 10 Jun 2025 05:30:39 +0000
References: <20250603205800.334980-1-luis.gerhorst@fau.de>
In-Reply-To: <20250603205800.334980-1-luis.gerhorst@fau.de>
To: Luis Gerhorst <luis.gerhorst@fau.de>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, puranjay@kernel.org,
 xukuohai@huaweicloud.com, catalin.marinas@arm.com, will@kernel.org,
 hbathini@linux.ibm.com, christophe.leroy@csgroup.eu, naveen@kernel.org,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, mykolal@fb.com,
 shuah@kernel.org, henriette.herzog@rub.de, skb99@linux.ibm.com,
 cupertino.miranda@oracle.com, mrpre@163.com, m.shachnai@gmail.com,
 dimitar.kanaliev@siteground.com, shung-hsi.yu@suse.com, dxu@dxuuu.xyz,
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  3 Jun 2025 22:57:51 +0200 you wrote:
> This improves the expressiveness of unprivileged BPF by inserting
> speculation barriers instead of rejecting the programs.
> 
> The approach was previously presented at LPC'24 [1] and RAID'24 [2].
> 
> To mitigate the Spectre v1 (PHT) vulnerability, the kernel rejects
> potentially-dangerous unprivileged BPF programs as of
> commit 9183671af6db ("bpf: Fix leakage under speculation on mispredicted
> branches"). In [2], we have analyzed 364 object files from open source
> projects (Linux Samples and Selftests, BCC, Loxilb, Cilium, libbpf
> Examples, Parca, and Prevail) and found that this affects 31% to 54% of
> programs.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/9] bpf: Move insn if/else into do_check_insn()
    https://git.kernel.org/bpf/bpf-next/c/8b7df50fd40d
  - [bpf-next,v4,2/9] bpf: Return -EFAULT on misconfigurations
    https://git.kernel.org/bpf/bpf-next/c/fd508bde5d64
  - [bpf-next,v4,3/9] bpf: Return -EFAULT on internal errors
    https://git.kernel.org/bpf/bpf-next/c/6b84d7895d78
  - [bpf-next,v4,4/9] bpf, arm64, powerpc: Add bpf_jit_bypass_spec_v1/v4()
    https://git.kernel.org/bpf/bpf-next/c/03c68a0f8c68
  - [bpf-next,v4,5/9] bpf, arm64, powerpc: Change nospec to include v1 barrier
    https://git.kernel.org/bpf/bpf-next/c/dff883d9e93a
  - [bpf-next,v4,6/9] bpf: Rename sanitize_stack_spill to nospec_result
    https://git.kernel.org/bpf/bpf-next/c/9124a4508007
  - [bpf-next,v4,7/9] bpf: Fall back to nospec for Spectre v1
    https://git.kernel.org/bpf/bpf-next/c/d6f1c85f2253
  - [bpf-next,v4,8/9] selftests/bpf: Add test for Spectre v1 mitigation
    https://git.kernel.org/bpf/bpf-next/c/4a8765d9a527
  - [bpf-next,v4,9/9] bpf: Fall back to nospec for sanitization-failures
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



