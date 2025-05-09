Return-Path: <linux-kselftest+bounces-32769-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CFBAB1C7E
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 20:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA128B24111
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 18:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3EC241689;
	Fri,  9 May 2025 18:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OubpBByX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A95A241122;
	Fri,  9 May 2025 18:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746815992; cv=none; b=uZUyXofDm7fLXlt3Jo3UBZ4MAC2kdMTKWif7qV8MVxPStgpm2YtOGju+QSNpNCa6WXLkLecrFKmWjYiORJL58TgjJJbTnhE2fvQ0KZIGQSR5ErwJMf5UeDTorp9//MVm7qS5xBhDaIjyNqvRtTvwqGCOlWyn0MvTnfYD2Z961Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746815992; c=relaxed/simple;
	bh=Wz4glreSt8DlgIrM5HvJHSb+qrAyVPEKF6wXqMPedMQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XUTUBZly+Y59W2z3LhXDeCrYb/6FkLstX1sgtge08shJV6susFXv3Hwzf3MstwHQu4FOH7yzN7PaDJjk5GI6rjV44wHLNlp/8QhX69exrml5Y3SKcHEHx0VNngPF4fnvPezDZuMjQzGSU3QX1newPst93rSMYy8FAuiG1TCnbvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OubpBByX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A65C4CEE4;
	Fri,  9 May 2025 18:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746815991;
	bh=Wz4glreSt8DlgIrM5HvJHSb+qrAyVPEKF6wXqMPedMQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OubpBByXk3rxJnekSB6DqSDgiFfKLhWsBxZh0t1IZ2Pfr50qJu2Nq3RMnlOgR3obn
	 T+tUkNTYQdvQn4il0XqegaKDa0YOAYslfjRz+fdINWnhDl/c6TP+bpquW/nIinjqvv
	 6nvWLogb/LAzmEdxv3+rCzk3z+vqyRiQpFwK7ewGA+9TBly/HIIMouhFsYiL+QsLbU
	 IMP8XwXoUyPisDHs1ZE67QVTv8OO3Np+b06XC1tNbqRBlqMltRKlQ6Vpgc55nf6En+
	 AwHPBoZZlLsuLktnkZy/zaPBr67dbDqQtru0wDZ7JeA3kh/wmGZmPhg1NusYS7MqrM
	 lnKxF1tllRmNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34071380DBCB;
	Fri,  9 May 2025 18:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 00/11] bpf: Mitigate Spectre v1 using barriers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174681603001.3715348.12288999798860158953.git-patchwork-notify@kernel.org>
Date: Fri, 09 May 2025 18:40:30 +0000
References: <20250501073603.1402960-1-luis.gerhorst@fau.de>
In-Reply-To: <20250501073603.1402960-1-luis.gerhorst@fau.de>
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

On Thu,  1 May 2025 09:35:51 +0200 you wrote:
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
  - [bpf-next,v3,01/11] selftests/bpf: Fix caps for __xlated/jited_unpriv
    https://git.kernel.org/bpf/bpf-next/c/cf15cdc0f0f3
  - [bpf-next,v3,02/11] bpf: Move insn if/else into do_check_insn()
    (no matching commit)
  - [bpf-next,v3,03/11] bpf: Return -EFAULT on misconfigurations
    (no matching commit)
  - [bpf-next,v3,04/11] bpf: Return -EFAULT on internal errors
    (no matching commit)
  - [bpf-next,v3,05/11] bpf, arm64, powerpc: Add bpf_jit_bypass_spec_v1/v4()
    (no matching commit)
  - [bpf-next,v3,06/11] bpf, arm64, powerpc: Change nospec to include v1 barrier
    (no matching commit)
  - [bpf-next,v3,07/11] bpf: Rename sanitize_stack_spill to nospec_result
    (no matching commit)
  - [bpf-next,v3,08/11] bpf: Fall back to nospec for Spectre v1
    (no matching commit)
  - [bpf-next,v3,09/11] selftests/bpf: Add test for Spectre v1 mitigation
    (no matching commit)
  - [bpf-next,v3,10/11] bpf: Allow nospec-protected var-offset stack access
    (no matching commit)
  - [bpf-next,v3,11/11] bpf: Fall back to nospec for sanitization-failures
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



