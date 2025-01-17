Return-Path: <linux-kselftest+bounces-24692-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF24A147EC
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 03:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F63188E360
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 02:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D901F5604;
	Fri, 17 Jan 2025 02:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEtCYlrq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823CB17084F;
	Fri, 17 Jan 2025 02:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737079815; cv=none; b=dCJbidnQ3t/EAiWY4/x9uehaG8UorfiT/DCc/B+8/sDNp3JYnJryr/xD5hev1SR2Ew8iODr3ID3W2qd8mA6C2L2Fx6js7egZTcFsuRd8QrgRc/JkPjJm/Xd2ehDVFTYtvEtChkhULSYd2wOdgSujeyemc2tfvEamP9upRPOK8K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737079815; c=relaxed/simple;
	bh=N/1lM3FdjEbzOdwCyPUvi4IKptb+2FDKY0HBnjtFmY4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Wio0HSHKlhM+G5cswHuF1vtQl/oPDCkJAowUNvyakqTfSjPdOBRzTatlMO2Uabk8PXZ5ckfzLJRP1nCCBD5vTH8OZ66A9/qT7OU2q+Mx9AZI3PvuG7XcNh6yefKjzaHyYKpoaCEqvpkzRnP/rL/2dBAZe6ChpO4QjSuViAt6VIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEtCYlrq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14880C4CED6;
	Fri, 17 Jan 2025 02:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737079815;
	bh=N/1lM3FdjEbzOdwCyPUvi4IKptb+2FDKY0HBnjtFmY4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eEtCYlrq0PEPpVp8K6+/MUygSIkLX4CXLsIF30sIc6GjtKiRtqgFLchMdHuRcF8y6
	 53cruj8mUfRc3FXRr6kuP+nd/U9Sc2pYiAoYVtbTd07wPqbzO2iCmp5CWCPeuWFDOz
	 0/yx5mGyyWuYBbRSMbTDF/zaR9gZFZ8cKcz0dA9ZTUURKqp3nSIwB/uQLwZcYsevRX
	 3pLQPrUsyKQ/94QfyPU1OUf0lPiIXjpXFSvMp8u6nSTACpXdyGNVx33KN6cFQPHNiS
	 krf71cllGQEKbXtlONHwRlPJsQjdFFSFvWB9c968bfmjqpa0LLiOAgDSM1XpseZSE9
	 LCPO+auHHBk6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71662380AA63;
	Fri, 17 Jan 2025 02:10:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v7 0/5] Support eliding map lookup nullness
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173707983824.1659522.18019002875638405637.git-patchwork-notify@kernel.org>
Date: Fri, 17 Jan 2025 02:10:38 +0000
References: <cover.1736886479.git.dxu@dxuuu.xyz>
In-Reply-To: <cover.1736886479.git.dxu@dxuuu.xyz>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 memxor@gmail.com, daniel@iogearbox.net, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, eddyz87@gmail.com, andrii@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 14 Jan 2025 13:28:41 -0700 you wrote:
> This patch allows progs to elide a null check on statically known map
> lookup keys. In other words, if the verifier can statically prove that
> the lookup will be in-bounds, allow the prog to drop the null check.
> 
> This is useful for two reasons:
> 
> 1. Large numbers of nullness checks (especially when they cannot fail)
>    unnecessarily pushes prog towards BPF_COMPLEXITY_LIMIT_JMP_SEQ.
> 2. It forms a tighter contract between programmer and verifier.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v7,1/5] bpf: verifier: Add missing newline on verbose() call
    https://git.kernel.org/bpf/bpf-next/c/b8a81b5dd645
  - [bpf-next,v7,2/5] bpf: tcp: Mark bpf_load_hdr_opt() arg2 as read-write
    https://git.kernel.org/bpf/bpf-next/c/8ac412a33611
  - [bpf-next,v7,3/5] bpf: verifier: Refactor helper access type tracking
    https://git.kernel.org/bpf/bpf-next/c/37cce22dbd51
  - [bpf-next,v7,4/5] bpf: verifier: Support eliding map lookup nullness
    https://git.kernel.org/bpf/bpf-next/c/d2102f2f5d75
  - [bpf-next,v7,5/5] bpf: selftests: verifier: Add nullness elision tests
    https://git.kernel.org/bpf/bpf-next/c/f932a8e4824b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



