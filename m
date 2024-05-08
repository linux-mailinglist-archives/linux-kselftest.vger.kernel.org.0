Return-Path: <linux-kselftest+bounces-9711-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A27EA8C003D
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 16:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5765C1F2143D
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 14:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEB685642;
	Wed,  8 May 2024 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVwnFpQ5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F351928F1;
	Wed,  8 May 2024 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715179230; cv=none; b=OHSsI+U2lfhjQ3T5Kq8Es/oQHsIcKNbd3JTceudMwEc6uNy5hXnJYSDaqd263Ij71zozgqCLOnTzd2VECmkcDPLx//k32KuWdtddzGy7pGTI98hLuBE/CrmMrAcoaWoXTufAggwXsIY3K56wsKxmQElQWc2208tuoylmP8iQib4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715179230; c=relaxed/simple;
	bh=Bkx6FWlp2DtvQNhk5Xcm+cIqHi4cks4+7dMl2zLdsqA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XNLWImwt0jTmTwqvm+Zerwb21Q2x9GwKTI/Jld45oc0XhJTY2AXpvjVkKpxb6TfWYCz2X7hHFwaYkJbL+zrJm83qz0Tn85GSNdl6PRLD3ExyWAeCQVa3NU2hsDgN8rcVutkCfIzlD0mPQUERtm7xwKBn9QhlC/JRzFIx9y3Sdkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVwnFpQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9866FC2BD11;
	Wed,  8 May 2024 14:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715179229;
	bh=Bkx6FWlp2DtvQNhk5Xcm+cIqHi4cks4+7dMl2zLdsqA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cVwnFpQ5UuDl+wGGEYVYSxolkjz3TMhot8tCSDlTgo8CJuPbvlWOsD8WJGAyJxQrw
	 IjLIEFNxHrFVDAtWNb7kyEV+InGT6Lfh8G1ZyQnYwNvxO2jk8uAyYaOieXvcfgh7XI
	 2W0ye6O+xJs0tn+KbBnawB3rJBTmjD/eHSwJdu41S8EnD3vlwtx0YvFwvFlfQOeOKH
	 8cPsV5Xr1u4B3WdGmk9lOGJR0yGT/L3YOWPZZfZgGZAB1ioVedt5/Gxaa18CkpTJ2Z
	 DaPf3lyP8KKAtn27b8c5FW8CEreVeNLdUP5hYqNlBU+baUUM7rFXAXPcZmL0kYwd07
	 e4zcoCgUFOwNQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 83575C43332;
	Wed,  8 May 2024 14:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf, arm64: Add support for lse atomics in bpf_arena
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171517922953.31960.16793215002778434121.git-patchwork-notify@kernel.org>
Date: Wed, 08 May 2024 14:40:29 +0000
References: <20240426161116.441-1-puranjay@kernel.org>
In-Reply-To: <20240426161116.441-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, zlim.lnx@gmail.com,
 catalin.marinas@arm.com, will@kernel.org, mykolal@fb.com, shuah@kernel.org,
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 puranjay12@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 26 Apr 2024 16:11:16 +0000 you wrote:
> When LSE atomics are available, BPF atomic instructions are implemented
> as single ARM64 atomic instructions, therefore it is easy to enable
> these in bpf_arena using the currently available exception handling
> setup.
> 
> LL_SC atomics use loops and therefore would need more work to enable in
> bpf_arena.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf, arm64: Add support for lse atomics in bpf_arena
    https://git.kernel.org/bpf/bpf-next/c/e612b5c1d3ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



