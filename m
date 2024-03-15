Return-Path: <linux-kselftest+bounces-6345-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA5587CE6A
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 15:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D38A2822F2
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 14:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9C3364CB;
	Fri, 15 Mar 2024 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpcZqi5h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98D42CCAD;
	Fri, 15 Mar 2024 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710511228; cv=none; b=a7GI6JioNlon1OSTqjSzMj8488dPbZmne9JPXaQNcoPN3qei6Nzm//cZ+xwh3W3L6+rQvIL6SrhCPrIuujMjlotv2voIyUnWODAzLYGvhu6u+9+rU7I+viqljS7LX29mmBnyjbEaqLdWmDtIcCkIcSMY8bEjV33uvMNirPgKNPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710511228; c=relaxed/simple;
	bh=AZP6LgRFwKHqKWfDp056pqDc5aEgznPPgS6hov1CARs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GLailLB1rNhitlD13BX0giyM8JhtUlrGgPQX5E6rbvKlz9LUEcZrJVOaNemyfeZfq0PQpUwUDgKMONzcG/xOm77f8zTvoctLDmt13D7o99tAxylEhAfJz24S2L/cqHwpf+dG6tdDKuroDKTBkX9As4cnB5nhTSJw/VQYYeM1gBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpcZqi5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FC6FC433C7;
	Fri, 15 Mar 2024 14:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710511228;
	bh=AZP6LgRFwKHqKWfDp056pqDc5aEgznPPgS6hov1CARs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bpcZqi5h2xKg9WGd3wHnKTicXVOHAwHlqxER/SAyh93746/4H90uMwFGkQ4r6tT6B
	 JbosKofCC2xGaLvWs39IMg9R6Emv+Mcl659aVK1Qm2KXEeEyNbxCX7sFZwu3+eVwkU
	 /8/yOeSWgAmg6CwCSFm2tQyloAbRZeP8Ios123DUWRDGHc7Yk0NCdGAKpR8shTJvV9
	 fKE4vxW3+pgil8g6hApi2sdYf+WhB4C+GZVn+1Wc8qkQkDh8tNwjkVFWeqbVjVzudT
	 gYO1wg40KIM9pWDT+cMjjG02Jq/Z+K599JbBo66jYz+W6jTDZx48DVM4wWSEGAXyXu
	 NEJoW8vQaVLUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0AA9FD84BA8;
	Fri, 15 Mar 2024 14:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] selftests/bpf: Remove second semicolon
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171051122803.31092.15319627583349442995.git-patchwork-notify@kernel.org>
Date: Fri, 15 Mar 2024 14:00:28 +0000
References: <20240315092654.2431062-1-colin.i.king@gmail.com>
In-Reply-To: <20240315092654.2431062-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 15 Mar 2024 09:26:54 +0000 you wrote:
> There are statements with two semicolons. Remove the second one, it
> is redundant.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  tools/testing/selftests/bpf/benchs/bench_local_storage_create.c | 2 +-
>  tools/testing/selftests/bpf/progs/iters.c                       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [next] selftests/bpf: Remove second semicolon
    https://git.kernel.org/bpf/bpf-next/c/4c8644f86c85

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



