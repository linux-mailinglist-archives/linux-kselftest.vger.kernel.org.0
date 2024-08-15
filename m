Return-Path: <linux-kselftest+bounces-15382-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EE5952865
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 05:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D5001F22763
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 03:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43453374C4;
	Thu, 15 Aug 2024 03:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiRvobvL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0878018643;
	Thu, 15 Aug 2024 03:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723693829; cv=none; b=BTnjPtBfR1psQheoJGOLbYLVwBQqUchw/MmQNIYbWdfIXLPGig8QnRcRcGVwSSzPc4WVnSq5yqp1MTJIGYT0jOolPLnjHPIb+YzCAPlolmYJZLEnBrjpkzeSIHAqivjibPL+1W+TiWyVQaZJMRE5HxMdflWjTntJ2aRsPFXRNmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723693829; c=relaxed/simple;
	bh=J1mr68Ndm47tfmuv/900nP4IO+3XkStaqp3lUvTsP1c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rq9TNfuu0BQ/oeCSOCsrtdpEuuys9UUbTHnS3Le8W1rkM032iQYARkJ7rsC/CZ+UAyh07HC5wzH/k60lS5C2mFwxLZhRCvTaBmBovob6DVH1TSxYlT1Xt0wotGHRjyEZx1jZDIJlXAM3WqFI4rysbhOj09tHWEtgwjOhmezA6IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiRvobvL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8335EC4AF0D;
	Thu, 15 Aug 2024 03:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723693828;
	bh=J1mr68Ndm47tfmuv/900nP4IO+3XkStaqp3lUvTsP1c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kiRvobvLGZS9ri5r1Jx0Oxb51uYgAStK+GJHCjwCWwU0xDyegUtAeFcJFGwynZlOt
	 xqGA+vEl5TcBCYFM5xxfGADzz9wET+tp7qxg5FP6J+rffN0lelz+UzExr8W5px+/U1
	 SBN+nWmwDKMNevc5BDdGY3uT9PBLIsuC8FNCKK+WgK7WzJHu4TUWwybH4sKhvaJCxc
	 SF8XQAeB+DGRSuWKAvbg/qWBBC7x3b0eb1YCPqipOoqV6b1SQyjG+HgTLiD5o/qEW8
	 MBal01IoK9JE/FqDirLdFkRwvjjxEX9XLmQ9maIsf/UBnK2OLpcav8RnGcZTMrUdMw
	 R78WZDmuYXSeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD673810934;
	Thu, 15 Aug 2024 03:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] selftest: af_unix: Fix kselftest compilation warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172369382776.2458412.15213146302105693209.git-patchwork-notify@kernel.org>
Date: Thu, 15 Aug 2024 03:50:27 +0000
References: <20240814080743.1156166-1-jain.abhinav177@gmail.com>
In-Reply-To: <20240814080743.1156166-1-jain.abhinav177@gmail.com>
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com, kuniyu@amazon.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Aug 2024 13:37:43 +0530 you wrote:
> Change expected_buf from (const void *) to (const char *)
> in function __recvpair().
> This change fixes the below warnings during test compilation:
> 
> ```
> In file included from msg_oob.c:14:
> msg_oob.c: In function ‘__recvpair’:
> 
> [...]

Here is the summary with links:
  - [net,v3] selftest: af_unix: Fix kselftest compilation warnings
    https://git.kernel.org/netdev/net/c/6c569b77f030

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



