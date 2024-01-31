Return-Path: <linux-kselftest+bounces-3879-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E668448B0
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 21:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B76E2847C4
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 20:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08F83FE2E;
	Wed, 31 Jan 2024 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2uVbYHm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900B73FB1E;
	Wed, 31 Jan 2024 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706732429; cv=none; b=kxmt7KKeMn0gxIgfhcXzC9wmyQ1+V/Vcjx2z19LcoRJ/RkQTrD7rGWxTTfrhwhjieI1DeuS6Zvso8vInLFe5AgPR/dR91vL+wDuiHgEY39fp3/G9el7KZ49dNN2tl9fTz4NX6cZ195R3nuGnojHAyce2VTt+gqkaFIrNVV894qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706732429; c=relaxed/simple;
	bh=5n2GPaqqGywO7Qry4eYZWTM4oFGQUDmGZmFT4fN7rrA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V5tk5twx4UxIbCwcBA7Dtjb6dijhsYCcR6BOXxpBk74eKp1vPXTq55COUdt2Vv3sQJ29/ijPYfm/d/4EnZ/XZHyob+wsuSGj6GtEHq82HCpGz/L/uQ5G4tUQhq3XdOj4lB4SN+YNpsJWMzFqBwP+yVnKr0ZUlfZFNipfpvn9flY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2uVbYHm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1644BC43399;
	Wed, 31 Jan 2024 20:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706732429;
	bh=5n2GPaqqGywO7Qry4eYZWTM4oFGQUDmGZmFT4fN7rrA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=j2uVbYHmJ0BNlBHTdgUBgToOHPf+Qp4+Unj1DhM4x0CdZn1Tp36nyKi13zJ4NsBIr
	 //0kQJg6fwsnmWQYfnR2CZSUXvSIpo3/iGgYh/XaFnVL1jU0DTgM8QBNto5qWBWVDS
	 vcqbDp7/vd0zLOGyh5KfD4vVhxPymWXNSaVHEQnaHcADHr+VtdaF38ZzDPzu6o8zPU
	 fWEGnzHYcE7+2/JhZaS3ZIov8rGKSfUD63SwZdSAHH3lFpglQsA/0G3nIPMWrFeXm3
	 9frtgxX17A8LyAlpcuY9DlRurZmEwHMKebMLzPTzZHfIKjiacmWjriWBzUTbkx54sG
	 53m66RsqvuGaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F2F56DC99E4;
	Wed, 31 Jan 2024 20:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/3] Annotate kfuncs in .BTF_ids section
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170673242899.4502.6917209613478941432.git-patchwork-notify@kernel.org>
Date: Wed, 31 Jan 2024 20:20:28 +0000
References: <cover.1706491398.git.dxu@dxuuu.xyz>
In-Reply-To: <cover.1706491398.git.dxu@dxuuu.xyz>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: linux-trace-kernel@vger.kernel.org, coreteam@netfilter.org,
 bpf@vger.kernel.org, linux-input@vger.kernel.org, cgroups@vger.kernel.org,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 fsverity@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, netfilter-devel@vger.kernel.org,
 alexei.starovoitov@gmail.com, olsajiri@gmail.com, quentin@isovalent.com,
 alan.maguire@oracle.com, memxor@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 28 Jan 2024 18:24:05 -0700 you wrote:
> === Description ===
> 
> This is a bpf-treewide change that annotates all kfuncs as such inside
> .BTF_ids. This annotation eventually allows us to automatically generate
> kfunc prototypes from bpftool.
> 
> We store this metadata inside a yet-unused flags field inside struct
> btf_id_set8 (thanks Kumar!). pahole will be taught where to look.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/3] bpf: btf: Support flags for BTF_SET8 sets
    https://git.kernel.org/bpf/bpf-next/c/79b47344bbc5
  - [bpf-next,v4,2/3] bpf: btf: Add BTF_KFUNCS_START/END macro pair
    https://git.kernel.org/bpf/bpf-next/c/2747e0ee57c2
  - [bpf-next,v4,3/3] bpf: treewide: Annotate BPF kfuncs in BTF
    https://git.kernel.org/bpf/bpf-next/c/6e7769e6419f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



