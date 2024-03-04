Return-Path: <linux-kselftest+bounces-5827-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FDC870252
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 14:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A40EB253AE
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 13:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47773EA72;
	Mon,  4 Mar 2024 13:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1I+27uC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD8D3D56F;
	Mon,  4 Mar 2024 13:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709557827; cv=none; b=MZVr+bkvlhDBww8x9CaZ4XUv6Elih8PWYQv6r/nTwk4qhEhQ9Z4rE7xMlzTPrGvFlA9s08svtXJWhyjEnL4PBhR/CvY2SHa/S7KjDxF/pWX42/3bDuABh69J9C206040nRRatmx92RcaXZa4q0mOTLlw2BdvJ5QpCNevUDLlCYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709557827; c=relaxed/simple;
	bh=hw4Gqt3vjAvxSv1jDywKuk8d0eCO75njkS+iC0MpSVQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GkTEYo9NG+8q9Zjxma6MAsZfGNaIAuz6vnRlqeK62DWxHIviWjgHjYZ5K7dGgasiFCHC118BzwkIsaEgO3bDvlhpIAarcljoFDHUw+D/VeFod/yM/zc9Gt2M/oAzbq5wjHlU3PPYghkENcV8szfvZ9m9ymw1n6xLFAMncDnjow0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1I+27uC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28062C433F1;
	Mon,  4 Mar 2024 13:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709557827;
	bh=hw4Gqt3vjAvxSv1jDywKuk8d0eCO75njkS+iC0MpSVQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p1I+27uCg+UnZGTG5/QKyJQZXj6zj9996/hgV10W5W9cz0jEcSVjBb7A3Fa+0N96P
	 w/df89psaXmwe4n3Crn0RbrIvjjl1MVw0xyTP1Ku+KmV3Wlstueoo3l8wsS7zzJNqk
	 sJDyYOvOrk3Vi/FvfKDTXK616rK+aWLTNim1f9oUwAbKInjx4Tzxqrx/MmbdH6zxGu
	 WIafyyeh1qj7wVAJk9y2n4Rh2EfzGjo5sLn5PdiXV55Z/jZSmKxOojIQvqHZL9ozI6
	 4yHfHm9zf4JKfZtfNP/J6/1OmAMmS0OryMB1cui2kwx+9gVIPqM/niutao4nobkK8E
	 rcXDr8pcn0d3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 08D51C595C4;
	Mon,  4 Mar 2024 13:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] selftests: mptcp: fixes for diag.sh
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170955782703.9155.1922263393925918208.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 13:10:27 +0000
References: <20240301-upstream-net-20240301-selftests-mptcp-diag-exit-timeout-v1-0-07cb2fa15c06@kernel.org>
In-Reply-To: <20240301-upstream-net-20240301-selftests-mptcp-diag-exit-timeout-v1-0-07cb2fa15c06@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shuah@kernel.org, horms@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 tanggeliang@kylinos.cn, stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 01 Mar 2024 18:11:21 +0100 you wrote:
> Here are two patches fixing issues in MPTCP diag.sh kselftest:
> 
> - Patch 1 makes sure the exit code is '1' in case of error, and not the
>   test ID, not to return an exit code that would be wrongly interpreted
>   by the ksefltests framework, e.g. '4' means 'skip'.
> 
> - Patch 2 avoids waiting for unnecessary conditions, which can cause
>   timeouts in some very slow environments.
> 
> [...]

Here is the summary with links:
  - [net,1/2] selftests: mptcp: diag: return KSFT_FAIL not test_cnt
    https://git.kernel.org/netdev/net/c/45bcc0346561
  - [net,2/2] selftests: mptcp: diag: avoid extra waiting
    https://git.kernel.org/netdev/net/c/f05d2283d111

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



