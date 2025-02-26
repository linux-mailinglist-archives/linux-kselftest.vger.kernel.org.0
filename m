Return-Path: <linux-kselftest+bounces-27553-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E69BA453C3
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 04:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A138419C06C7
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 03:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F1A229B21;
	Wed, 26 Feb 2025 03:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7tlNj3N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18359229B12;
	Wed, 26 Feb 2025 03:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740539412; cv=none; b=E35QGh1pJDiKNmIZxamRDKnphNRIlqN+YleZdXz9IomJLUWmfmI3Bz+Ccw4+WdeXMqZLQ0pwwn6Bjlzka7WQyczTtzTL4hmiCNaXnI15lk1Lx7cGIfT3DQuntCMuZObIEyO0uPrmU+F+Ahv4E0GWy6lMyNbMaDDPcZTwlmyBdnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740539412; c=relaxed/simple;
	bh=c39mrclS0V+0BVpyk6yDt+AQpKerru3hI8irQvMlhCY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j2jRLzM/69bsB5iU5R2TVwO6qL2FX9sc2lQg1eZK/k4NeVUKDp8cPB9lYvIbTQ04hcMyK7nlp8ZiQfTmg4gAD8vdtDX08xYIDf9z6Beto7CpVBtHyYswhbYisdkB1p8vGHZoCyU+6aYOj+EjH0+Au1wUr3mP5K8NSbDIlc5jKPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7tlNj3N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83766C4CEE4;
	Wed, 26 Feb 2025 03:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740539411;
	bh=c39mrclS0V+0BVpyk6yDt+AQpKerru3hI8irQvMlhCY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P7tlNj3NbK/8AINMbYu4NaylCpL/yTRRaBVSM6jw29TnuklclCbC+Y6Dw2TyrF6p7
	 skcpgWtMYvwDXRZi7GYCEVCmNNqONJa+kuEwdVog+zMMKuNfWsn5z7vkvnWX5gKtrH
	 rHO4c7nJFo0PLhuEg5Krwhq54on9sMh4BVyEUBB+ZrA1FcC6I8Tp8iTHQJfST3GG8R
	 viMCTBSaYgHW0qWJ1noQrkDlnwx57+J43x8VRrD4Kqj3KjYL/4vJAf+qkRspoZdO3k
	 IaR72vLvJwPylLjv/u7f1jwcid27q5o8r/yZp9ZOim1BPtid0IjO8Io3c80xQHDspj
	 /zWItXLqt/uQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DE3380CFDD;
	Wed, 26 Feb 2025 03:10:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests/net: ensure mptcp is enabled in netns
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174053944306.217003.5568434997521679150.git-patchwork-notify@kernel.org>
Date: Wed, 26 Feb 2025 03:10:43 +0000
References: <20250224094013.13159-1-liuhangbin@gmail.com>
In-Reply-To: <20250224094013.13159-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 dcaratti@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Feb 2025 09:40:13 +0000 you wrote:
> Some distributions may not enable MPTCP by default. All other MPTCP tests
> source mptcp_lib.sh to ensure MPTCP is enabled before testing. However,
> the ip_local_port_range test is the only one that does not include this
> step.
> 
> Let's also ensure MPTCP is enabled in netns for ip_local_port_range so
> that it passes on all distributions.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests/net: ensure mptcp is enabled in netns
    https://git.kernel.org/netdev/net-next/c/0f58804080e3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



