Return-Path: <linux-kselftest+bounces-48376-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2DECFC090
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 06:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50279303C20B
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 05:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5A520C461;
	Wed,  7 Jan 2026 05:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTiwa7a7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E16156CA;
	Wed,  7 Jan 2026 05:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767762220; cv=none; b=G177WWEijCs0o7Q/3tt+mWu+hYzSqzlios7sOmXrfsJ/pOcmVMBeNjAPoh4Zt/pxRFOLDRAbTnotHc8sNVfQja1Z3GtW5DDifvomrhLvemwRMUq+Un7Ub+AE2hsIpmXnuqnThgITXrjfMdHobpyin7yByi+0zxpLxfHPmhARdaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767762220; c=relaxed/simple;
	bh=EpkIaYKG/O/Y7prZYnfs97/0GqH0oV7SxYp1rt3diXs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JbSy24FhmrQD+xKnwcSHTeWwSwC5rzqNtUL7mrXD6vaM2WphmklEoNu/ZI2dafFRQDoy8gJTJTsFNscCQyemqNIiLiCwuMV4pT4tb/POMGIREPLMuDCvw9fn5CQO4BBtptuJNX2WRuYZNKBiChPYwNf+zUn/D9Ba7o5cNpDTX6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTiwa7a7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 603CFC4CEF7;
	Wed,  7 Jan 2026 05:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767762219;
	bh=EpkIaYKG/O/Y7prZYnfs97/0GqH0oV7SxYp1rt3diXs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KTiwa7a7wkpox6DUVk6GMH0EbZ2O5MvLO1dogiXwTiiohryuwjQNxSIgahlNCKFHB
	 b4DuTfSQYLIIDsw5k2LQSNJ3fTBr7t2bohWY5oGC1jiGcqZv3+jOGMnSKND3681uRL
	 EWUDRbOn721DL3zx+tcTQuTtMij+wMCijSLbSdBA8qu8ttGLr49anqDGP/JmzKZj97
	 syRUitg92aed38PzTfnnYnhfpp5T9AjUpsuyfhNcUG/6T7GXmvyDsYWQINBdW2LBYr
	 1rBoo8E94iId0SaGaHS6bofe8R4o/0xeAkOfU8rPqHE/5rJtstoqj6rdn0dp4GxKd6
	 CVEwkklsdm8yg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F29A4380CEFA;
	Wed,  7 Jan 2026 05:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v13 0/7] bpf: Introduce BPF_F_CPU and
 BPF_F_ALL_CPUS
 flags for percpu maps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176776201679.2234404.5069514097125787379.git-patchwork-notify@kernel.org>
Date: Wed, 07 Jan 2026 05:00:16 +0000
References: <20260107022022.12843-1-leon.hwang@linux.dev>
In-Reply-To: <20260107022022.12843-1-leon.hwang@linux.dev>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, jolsa@kernel.org, yonghong.song@linux.dev,
 song@kernel.org, eddyz87@gmail.com, martin.lau@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, shuah@kernel.org, kerneljasonxing@gmail.com,
 willemb@google.com, yatsenko@meta.com, chen.dylane@linux.dev,
 memxor@gmail.com, a.s.protopopov@gmail.com, ameryhung@gmail.com,
 tklauser@distanz.ch, rongtao@cestc.cn, dxu@dxuuu.xyz, deso@posteo.net,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-patches-bot@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  7 Jan 2026 10:20:15 +0800 you wrote:
> This patch set introduces the BPF_F_CPU and BPF_F_ALL_CPUS flags for
> percpu maps, as the requirement of BPF_F_ALL_CPUS flag for percpu_array
> maps was discussed in the thread of
> "[PATCH bpf-next v3 0/4] bpf: Introduce global percpu data"[1].
> 
> The goal of BPF_F_ALL_CPUS flag is to reduce data caching overhead in light
> skeletons by allowing a single value to be reused to update values across all
> CPUs. This avoids the M:N problem where M cached values are used to update a
> map on N CPUs kernel.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v13,1/7] bpf: Introduce BPF_F_CPU and BPF_F_ALL_CPUS flags
    https://git.kernel.org/bpf/bpf-next/c/2b421662c788
  - [bpf-next,v13,2/7] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_array maps
    https://git.kernel.org/bpf/bpf-next/c/8eb76cb03f0f
  - [bpf-next,v13,3/7] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_hash and lru_percpu_hash maps
    https://git.kernel.org/bpf/bpf-next/c/c6936161fd55
  - [bpf-next,v13,4/7] bpf: Copy map value using copy_map_value_long for percpu_cgroup_storage maps
    https://git.kernel.org/bpf/bpf-next/c/8526397c3caf
  - [bpf-next,v13,5/7] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_cgroup_storage maps
    https://git.kernel.org/bpf/bpf-next/c/47c79f05aa0d
  - [bpf-next,v13,6/7] libbpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu maps
    https://git.kernel.org/bpf/bpf-next/c/2546863b4a72
  - [bpf-next,v13,7/7] selftests/bpf: Add cases to test BPF_F_CPU and BPF_F_ALL_CPUS flags
    https://git.kernel.org/bpf/bpf-next/c/07bf7aa58e5e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



