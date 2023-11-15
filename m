Return-Path: <linux-kselftest+bounces-123-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FC97EBC97
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 05:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70EC2B20B34
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 04:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01F0A55;
	Wed, 15 Nov 2023 04:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlNe+6br"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3BB3C22;
	Wed, 15 Nov 2023 04:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B384C433C9;
	Wed, 15 Nov 2023 04:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700022024;
	bh=PlKEtWmd15CNYGGTl7+gaJVldxfItHtqkbBfnLkwDr8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nlNe+6br2hBhMsvxlJ0TKBCUjShxd7Ej6tQHty8s6knL/tdLzTKn7YspdkcDQeiZX
	 FNgHeB7gALUYms1cJMqfWPSKqWcMd7FYQwv4OWL+uTgo2SaCEFBum5/fzGJ2bVZVuo
	 exvcdBxK1zMfOH84h4n1Rv2XRlMLfof1qeurKl3G5aEHSDcorfbkvHPiG7EAD/YrvY
	 bYvlAy9GsmtZojYqlWT9+4sajzQOQYgBOJsjA1FVT2KC2XQa4QT5ajyyezvJmSTEqe
	 HTb2KAp9/Vh9AjhL7MHpyWPjEJ6zh9XHAAq106AR0BvJ9SO8Y7QYs0HtjOPVy4cDeD
	 jJVvQfaEp0BjA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E323BEA7DA0;
	Wed, 15 Nov 2023 04:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] mptcp: misc. fixes for v6.7
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170002202392.25123.5567569112552838973.git-patchwork-notify@kernel.org>
Date: Wed, 15 Nov 2023 04:20:23 +0000
References: <20231114-upstream-net-20231113-mptcp-misc-fixes-6-7-rc2-v1-0-7b9cd6a7b7f4@kernel.org>
In-Reply-To: <20231114-upstream-net-20231113-mptcp-misc-fixes-6-7-rc2-v1-0-7b9cd6a7b7f4@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 alexanderduyck@fb.com, geliang.tang@suse.com, psonparo@redhat.com,
 shuah@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, cpaasch@apple.com, stable@vger.kernel.org,
 syzbot+9dfbaedb6e6baca57a32@syzkaller.appspotmail.com, xmu@redhat.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Nov 2023 00:16:12 +0100 you wrote:
> Here are a few fixes related to MPTCP:
> 
> - Patch 1 limits GSO max size to ~64K when MPTCP is being used due to a
>   spec limit. 'gso_max_size' can exceed the max value supported by MPTCP
>   since v5.19.
> 
> - Patch 2 fixes a possible NULL pointer dereference on close that can
>   happen since v6.7-rc1.
> 
> [...]

Here is the summary with links:
  - [net,1/5] mptcp: deal with large GSO size
    https://git.kernel.org/netdev/net/c/9fce92f050f4
  - [net,2/5] mptcp: fix possible NULL pointer dereference on close
    https://git.kernel.org/netdev/net/c/d109a7767273
  - [net,3/5] mptcp: add validity check for sending RM_ADDR
    https://git.kernel.org/netdev/net/c/8df220b29282
  - [net,4/5] mptcp: fix setsockopt(IP_TOS) subflow locking
    https://git.kernel.org/netdev/net/c/7679d34f97b7
  - [net,5/5] selftests: mptcp: fix fastclose with csum failure
    https://git.kernel.org/netdev/net/c/7cefbe5e1dac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



