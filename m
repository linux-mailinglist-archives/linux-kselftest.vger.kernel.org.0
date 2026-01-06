Return-Path: <linux-kselftest+bounces-48237-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FB2CF6169
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 01:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6B9D530090FA
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 00:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086891D8E01;
	Tue,  6 Jan 2026 00:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEB+B/41"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE13219E99F;
	Tue,  6 Jan 2026 00:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767659614; cv=none; b=nUlsukA993dqv7jOB0zKvbbA/eILzDZadSeigtIqBvkJRqQEpMxFc6ilkkHw+V3MMZm5OaofO8KFQA4kpIXi4HHCGZpvWFT+Pc5ixy8HJnQYYPba+SAfi94YqRN3912SrnnlZKGDfeJDCD9AUaohJWiFK4DF4Nxe3cJ/CdbsCFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767659614; c=relaxed/simple;
	bh=16Eb/9DJD1sJo4gf8iw24X+kBRSpVoHIjwW3cwI9fDE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jTDvbv6H0XzdWHAure1+90MNAascFCvtcYfjZD8t3o7vm9kAgg9KHcDwmb+Yth1jbPpEy2Ezf1+51noR2DXdDsqw4Bjd8BfFIJgjr6LzPfYKsZuNJ3ahElr6P4Xrlk5DfIQyLpWMmYZBtngqYclbhHhgkUNJMY6Tf0u2tBGxDno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEB+B/41; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C01BC116D0;
	Tue,  6 Jan 2026 00:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767659614;
	bh=16Eb/9DJD1sJo4gf8iw24X+kBRSpVoHIjwW3cwI9fDE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eEB+B/415Y8ACEAap9gTDx+96bm6WbKmeUgNiJAu4aFJfUGVBclPlSoQoW+Vrg95f
	 UeXjB41utJeEJa0UAyRibrJGo5R+ysRm9Mrt6zVRymInq0U+36OJt8n3/sw+Yj72Xt
	 dXCj5/pygorQE6nSIK7xfTFlB5rJJBQwwfuR/XkElgNCzZUXSqjMvtFFBZJvjmo8v2
	 9xuI3cLUfygxw5k3sTN6Lo/ryU+UdxQww+H1D01o5f1ByYiwJcQ00dPqTSPkN5Ul3l
	 fZpChYQY6Ap+7duLe5kMu7SaC+nZN4grQCZ1ApTovSiXvdJaYbU3B0hewiqYAtPBJe
	 tT383SXU4yOEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5AE5380A966;
	Tue,  6 Jan 2026 00:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] selftests: mptcp: Mark xerror and die_perror
 __noreturn
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176765941227.1341185.12449283509632090674.git-patchwork-notify@kernel.org>
Date: Tue, 06 Jan 2026 00:30:12 +0000
References: <20260101172840.90186-1-ankitkhushwaha.linux@gmail.com>
In-Reply-To: <20260101172840.90186-1-ankitkhushwaha.linux@gmail.com>
To: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Cc: matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  1 Jan 2026 22:58:40 +0530 you wrote:
> Compiler reports potential uses of uninitialized variables in
> mptcp_connect.c when xerror() is called from failure paths.
> 
> mptcp_connect.c:1262:11: warning: variable 'raw_addr' is used
>       uninitialized whenever 'if' condition is false
>       [-Wsometimes-uninitialized]
> 
> [...]

Here is the summary with links:
  - [net,v3] selftests: mptcp: Mark xerror and die_perror __noreturn
    https://git.kernel.org/netdev/net/c/2fa98059fd5a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



