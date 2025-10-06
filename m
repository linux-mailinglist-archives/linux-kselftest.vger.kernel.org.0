Return-Path: <linux-kselftest+bounces-42787-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CB77ABBF345
	for <lists+linux-kselftest@lfdr.de>; Mon, 06 Oct 2025 22:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7737434B40E
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Oct 2025 20:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C542DEA6E;
	Mon,  6 Oct 2025 20:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQfKCKrA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D3B2DECB2;
	Mon,  6 Oct 2025 20:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759782884; cv=none; b=asjVQUYKG3MAxQf0ufNk1O/ytazhTSrva4mQiEO/7Eq/HSQa51BpMycYDMdxwJnInp42UqfEhoRp+HIEI2uDajNyz87VwFb0fIWmG6Ob2w0L/SIsHMEV5AIM1HHxjfrfIzfxrrfT+8aO9CcoOaedTyqgfbhpwmkv70fhX+AXr2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759782884; c=relaxed/simple;
	bh=ttXlvj3L4PE1ecV6mEqMCDCGc7SQVHuDJ9Y+zrbRy0M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r10iz9fYqNbFq6f55F3EN0SD32JwOHGRp4TYgem2PGuAm/QCy7dGjX5aU1dowBYMJeP9NJGMh6LrMLOoawIgLsKqlsz3i7AWglhuQxW6wgh2inOkWQLmhJ2RhOY/F7ElLYMWPPxUiA8jXDDDi3NYX5Bu5wdQJOZsq4o9E2fakZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQfKCKrA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6650DC4CEF5;
	Mon,  6 Oct 2025 20:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759782884;
	bh=ttXlvj3L4PE1ecV6mEqMCDCGc7SQVHuDJ9Y+zrbRy0M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DQfKCKrAEtnjPBimCrnzV+41gxuZer91/v0CzhK4ca5MyhT/XBVRltoQFG3SUglv5
	 rREV9BjAvO6+tNBbRZyU2SyK4892xST0eypU7L0XtEhxJ333g7T3zpWGZ5ZL3L9hX6
	 oWlgBYdj0WwBUaCInmP1zgq00g3uptiJlEBoX1AYHxq5fMpnV/58PeVOFKFfuHQZd7
	 7DJLg0pa6q856TJxPyeO3nQiiLczVJSVtAFdGQDXzqRxnmalw10GsHwIaVgGvUri1Q
	 rxwXtpAoVldSTFtzXbFX8wfF0pGP1wEl18lpJt3zA4Zl4iL8c/8Kdcb/r7riSj1d3B
	 pp6E5VLjIkFKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B5439D0C1A;
	Mon,  6 Oct 2025 20:34:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] selftests: net: unify the Makefile formats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175978287374.1522677.8202673603942730237.git-patchwork-notify@kernel.org>
Date: Mon, 06 Oct 2025 20:34:33 +0000
References: <20251003210127.1021918-1-kuba@kernel.org>
In-Reply-To: <20251003210127.1021918-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 antonio@openvpn.net, matttbe@kernel.org, allison.henderson@oracle.com,
 shuah@kernel.org, jv@jvosburgh.net, olteanv@gmail.com, jiri@resnulli.us,
 mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, kuniyu@google.com, martineau@kernel.org,
 pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de, petrm@nvidia.com,
 razor@blackwall.org, idosch@nvidia.com, linux-kselftest@vger.kernel.org,
 mptcp@lists.linux.dev, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  3 Oct 2025 14:01:27 -0700 you wrote:
> We get a significant number of conflicts between net and net-next
> because of selftests Makefile changes. People tend to append new
> test cases at the end of the Makefile when there's no clear sort
> order. Sort all networking selftests Makefiles, use the following
> format:
> 
>  VAR_NAME := \
> 	 entry1 \
> 	 entry2 \
> 	 entry3 \
>  # end of VAR_NAME
> 
> [...]

Here is the summary with links:
  - [net,v2] selftests: net: unify the Makefile formats
    https://git.kernel.org/netdev/net/c/f07f91a36090

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



