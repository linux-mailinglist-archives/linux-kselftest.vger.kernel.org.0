Return-Path: <linux-kselftest+bounces-13336-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B959A92AA99
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 22:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 539EEB21288
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 20:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6562E416;
	Mon,  8 Jul 2024 20:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9tJJy43"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62735A29;
	Mon,  8 Jul 2024 20:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720470630; cv=none; b=r3QbKvPndcgoyVcQYBJu9wo8GOmkr4HWzFkuH4JPRsO7tmTNrRcImb8QLE3lGY2unARTrsn/CZSaRkqc1Qbgoe/nS5cMSoIM5VpVLURvaSVvrBB6DC8nQ8C9sQc/Bvt53Cr6FXPrBcY5e0IMjd7IhG3JJn2oIkryA4IOCli4ob0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720470630; c=relaxed/simple;
	bh=vlNndW/sPiV92dz+5Ual56vbhj+f8JVNkuLU5APUeqA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eTdsG8vSu4/yn8rQaWToyDu0aH0lUG2LIAQHIdGtTgZf/sJWcQdlsC0Va/l1OULnp9XhNzHnXkpnbFdXOi9DAw86V23i437yCVnA1Xp68egFUkgZPRCP6uLb2M+fV53IOQUX77FvYr9Z77BwnHBgCcR5NxBE4lSjJ8oMlx6Nlc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9tJJy43; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE51EC3277B;
	Mon,  8 Jul 2024 20:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720470629;
	bh=vlNndW/sPiV92dz+5Ual56vbhj+f8JVNkuLU5APUeqA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W9tJJy43ysN8anMdtxAm1OZ+y3sRENJiIFNFTk1aioPxfvoUJa7sW57sXl/ydG8AQ
	 w/oEFN8goUgDvzJE5rtGK8/pOhx69aBHIqlgq3Z9sQOiHO11FDhD1vqi6eER7b5lYo
	 +QzSVyo4XZ6C1C+4qLG9z/gwKT50zt6eXY804qe4GU1MLeE6jGKFI/HZzA4CBnGXLg
	 jT1rFwsYQvAIFkaW8FXY3IjM2/7MHBDBSdhlx0/K9cz/2N/wXbM4/ha0v6O2dNBpSJ
	 gMhtWP0tb6GFvhiwk83NdQbam/Pnxey1MxRyrxOXwPOGQ2yiCmSNO+ropUMPzSTo9w
	 vm7bvbw6TfxWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BBC91DF3713;
	Mon,  8 Jul 2024 20:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] selftests/bpf: DENYLIST.aarch64: Remove fexit_sleep
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172047062976.14874.1055573177494489309.git-patchwork-notify@kernel.org>
Date: Mon, 08 Jul 2024 20:30:29 +0000
References: <20240705145009.32340-1-puranjay@kernel.org>
In-Reply-To: <20240705145009.32340-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, puranjay12@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri,  5 Jul 2024 14:50:09 +0000 you wrote:
> fexit_sleep test runs successfully now on the CI so remove it from the
> deny list.
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  tools/testing/selftests/bpf/DENYLIST.aarch64 | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [bpf] selftests/bpf: DENYLIST.aarch64: Remove fexit_sleep
    https://git.kernel.org/bpf/bpf-next/c/90dc946059b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



