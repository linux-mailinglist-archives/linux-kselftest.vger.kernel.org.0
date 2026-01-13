Return-Path: <linux-kselftest+bounces-48835-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C6BD16782
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 04:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D487A302515F
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 03:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3202E0401;
	Tue, 13 Jan 2026 03:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBRM2nhi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D301EB9FA;
	Tue, 13 Jan 2026 03:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768274613; cv=none; b=Qhrqq7sccbSrAvL72gR/zOreNO3PZlMzsLvjC3Uv1MggLxPlEjmBXzcW47TWcaaCUbPJCGEWjLE+j93ravzW5DysNuc4Y4mg7BK+IRdQFl0LlabIDAZkfcmI0mjfJhegPar64pkEVt2YQpY7Xe0QiVMCP+u7GZ9IdZHQ5/ns4ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768274613; c=relaxed/simple;
	bh=SElF49LXQ3hpsrTW7SDT9hB1fHjz0BDxbIERkUlQVrg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=neSsovJScf2fr8vUVTBEY2t00N5pD9YIEwyMXB4cMjcdtDq3zNtuhybKNcihQys8Xf5cBQnXIjTJvT/vs3YUHGHpxc6NXEYdgLXteriO9NYjQ0nn1DjvF2CdoP2+Wh965v6GZyKFHKRg7q2ImZA2bQk61svECaVs4F3d51hSft8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBRM2nhi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B53C116D0;
	Tue, 13 Jan 2026 03:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768274613;
	bh=SElF49LXQ3hpsrTW7SDT9hB1fHjz0BDxbIERkUlQVrg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UBRM2nhiMnQWuZMoYbHR+Doglf/5krBcquTa2h6497bz49UzvT3Dl1HRrxtpDcZnQ
	 niedU3wEafQFXJPB4pgAF4+Ubk+wF6ZLuDCSj47wfTGvQ4oxiPtop81MSrWBUmN5a3
	 U383EDglSwALWp3g1KTMOrCedZGjGnZT77lvVY+sLQlUkAPLvxZ3VArmqAHeXoOYmb
	 NQczV4O6GoWcGVNFQE6EbIckKEV9OG6fhnxu//4xotHPDzsmiOPx4gGQlWfTy3sz6y
	 CaaS4KYTJIwSQX0r4R/DcA6eh6DW2JVBx4mBB21UoayZAMui1kii4zbKfK9tTLAt5I
	 mHM6AFVM7pEog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B93E380CFE0;
	Tue, 13 Jan 2026 03:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND net-next] selftests/net/ipsec: Fix variable size
 type
 not at the end of struct
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176827440704.1656603.13670649593819877503.git-patchwork-notify@kernel.org>
Date: Tue, 13 Jan 2026 03:20:07 +0000
References: <20260109152201.15668-1-ankitkhushwaha.linux@gmail.com>
In-Reply-To: <20260109152201.15668-1-ankitkhushwaha.linux@gmail.com>
To: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, gustavoars@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  9 Jan 2026 20:52:01 +0530 you wrote:
> The "struct alg" object contains a union of 3 xfrm structures:
> 
> 	union {
> 		struct xfrm_algo;
> 		struct xfrm_algo_aead;
> 		struct xfrm_algo_auth;
> 	}
> 
> [...]

Here is the summary with links:
  - [RESEND,net-next] selftests/net/ipsec: Fix variable size type not at the end of struct
    https://git.kernel.org/netdev/net-next/c/088f35ab9fd4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



