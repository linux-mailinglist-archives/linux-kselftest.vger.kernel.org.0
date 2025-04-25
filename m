Return-Path: <linux-kselftest+bounces-31653-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E61A9D100
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 21:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E23DE7B9DCD
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 19:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D632521D5B5;
	Fri, 25 Apr 2025 19:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3/z+2s+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A819E219A8B;
	Fri, 25 Apr 2025 19:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745607670; cv=none; b=GmDMFJP3zP+nqx8iWOYtNatvm7kUhANdqeGHNIKiOA82AdTo4VpBq6r/iSpdu54V1pzs8aiv2XGYHTHQg2fN9tBAiWQcvhsX+4FDdXn0NbOmWG9eKVGLt3Yk6YDwBTdHG25Tp/+zJctHYqBg40uEm4NEVbiLaBH3oSa96WUkwhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745607670; c=relaxed/simple;
	bh=zEJkmpbvZvMfw1LHSSnEfJBbh/CNo4aDg7dQ8Kbg9bU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aD9l/lf/C4QeU30iAtbt16S2HwCLlcaib54t42K0VDGGxmoi6bELsiyH1jZI10WVWRmN2rEEOB1RGNpAxxiZA0IcBzl5pX9pkk6Eh5y2lyxd4w0aDGpSwget6JMB5VDZt78BhqGuXqplQypMb/KrO/o++nnC0qx9fRBZRKh4Urc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3/z+2s+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10689C4CEE4;
	Fri, 25 Apr 2025 19:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745607670;
	bh=zEJkmpbvZvMfw1LHSSnEfJBbh/CNo4aDg7dQ8Kbg9bU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W3/z+2s+DsnwvwKSoAA3jYv86RyOPW+V+U6SEvW7rQ8xCrLAuoIx+EegtAPkIiI/Z
	 1R0CEogz6waoRAGIgxP7c5/ineU7ceejZtntxrZzgLsAYPchHrQKTUc85arujY2rai
	 12Lk0UCSJX4fAgpnRaLmYv0aPrO2A2krLt/OLG5/MZ8+iquRYGB/UCJCLTLCISBMtD
	 3mlC5G6gzqv1MzhNI5N9r1eiPegcfoH5CRLV+243zG1PmQJjTnHgKez7CHoBYriYqB
	 qLxzUAo6P8yGvxGgdj89DEuUYUInTTBzBF3d7I4LdbSho9VbOdC1JUDcp+gP1Ho7a0
	 8OvOLgXQzDy/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB085380CFD7;
	Fri, 25 Apr 2025 19:01:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/3] Fix netdevim to correctly mark NAPI IDs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174560770848.3803904.9642940432562935459.git-patchwork-notify@kernel.org>
Date: Fri, 25 Apr 2025 19:01:48 +0000
References: <20250424002746.16891-1-jdamato@fastly.com>
In-Reply-To: <20250424002746.16891-1-jdamato@fastly.com>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, shaw.leon@gmail.com,
 pabeni@redhat.com, ast@kernel.org, andrew+netdev@lunn.ch,
 bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 edumazet@google.com, hawk@kernel.org, john.fastabend@gmail.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 shuah@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Apr 2025 00:27:30 +0000 you wrote:
> Greetings:
> 
> Welcome to v4.
> 
> This series fixes netdevsim to correctly set the NAPI ID on the skb.
> This is helpful for writing tests around features that use
> SO_INCOMING_NAPI_ID.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/3] netdevsim: Mark NAPI ID on skb in nsim_rcv
    https://git.kernel.org/netdev/net-next/c/f71c549b26a3
  - [net-next,v4,2/3] selftests: drv-net: Factor out ksft C helpers
    (no matching commit)
  - [net-next,v4,3/3] selftests: drv-net: Test that NAPI ID is non-zero
    https://git.kernel.org/netdev/net-next/c/2593a0a1446a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



