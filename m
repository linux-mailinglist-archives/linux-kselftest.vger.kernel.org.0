Return-Path: <linux-kselftest+bounces-6514-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 117528876F1
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Mar 2024 04:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90C66B22D4D
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Mar 2024 03:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDA01A38DD;
	Sat, 23 Mar 2024 03:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyNmmE3Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2410523C;
	Sat, 23 Mar 2024 03:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711165828; cv=none; b=pLPKzTUvDrhdv49tUI98edmDBbc/cC7UOl0ECL3aFJ3EdLmSsRluSjYNvWGBiR2QuFIK9t42fqDRSADBhjmI4LeQpyyqXXEGiBYZbtwPN/1qoSco94MxuNdILKEEzOwG+T/6ybiA7PohXUQwcIkT4E2jDqen0MtSsNs8ky+CZhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711165828; c=relaxed/simple;
	bh=fQZr7dBehfmrOIawq98+s5MJvTkXg40tRESjio07WSE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QFiYjxJyHRxPHzsqBzVkY7oWNjm0Yk0PCo7SnXMd/TpDrx22hLKWxaxIbRUjHiIqKPFNuw+ZvrbFA+B+2S+n/+m0Tr3T3DVNGc418t6JTYngt6Z1C1MpAcWnv4yTeZusAt8s9oSzdf9I4qGdE9wrk5Hs1xM/Hi2eAdx9bf4/Qbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyNmmE3Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39BCAC433A6;
	Sat, 23 Mar 2024 03:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711165828;
	bh=fQZr7dBehfmrOIawq98+s5MJvTkXg40tRESjio07WSE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oyNmmE3QR9MfTweO0/f+KrZXHz7wqMlD3wbxOr9wqEmGQ4Dn6z9xoRB0ZpvEq2xgQ
	 cfBHhBMb1sintyXg+DvR7ywdhVqmiaJAzq2YkqudMaSU8uVeoE1BaGSE4oKCIkUh0J
	 jouqxnV34QhajUCvvIJDSZ7wVgQ1vsSLmI7ov8hQLbC9x+OX0uaLpLiz4YQWGiCcdD
	 LeFfGWEaILRMtmQBcSm+nKP1DsGhLGrpIOH0eHuEctFmjhehf2DvdYx7t6qDFJ/cQt
	 pClBgwvdhbJGCCAyKkq6NYx6QpjDwmAxIyRsD1NQkNMlf9AExlfdjh1P3Qka++ACjY
	 Fft8ZxaxWpWhA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 25702D8BCE7;
	Sat, 23 Mar 2024 03:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] selftests/bpf: verifier_arena: fix mmap address for arm64
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171116582814.31313.2028286774074620264.git-patchwork-notify@kernel.org>
Date: Sat, 23 Mar 2024 03:50:28 +0000
References: <20240322133552.70681-1-puranjay12@gmail.com>
In-Reply-To: <20240322133552.70681-1-puranjay12@gmail.com>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 22 Mar 2024 13:35:52 +0000 you wrote:
> The arena_list selftest uses (1ull << 32) in the mmap address
> computation for arm64. Use the same in the verifier_arena selftest.
> 
> This makes the selftest pass for arm64 on the CI[1].
> 
> [1] https://github.com/kernel-patches/bpf/pull/6622
> 
> [...]

Here is the summary with links:
  - [bpf] selftests/bpf: verifier_arena: fix mmap address for arm64
    https://git.kernel.org/bpf/bpf/c/fa3550dca8f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



