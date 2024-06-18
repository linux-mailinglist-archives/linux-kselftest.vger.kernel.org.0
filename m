Return-Path: <linux-kselftest+bounces-12108-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BB290C113
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 03:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65B38B21362
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 01:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32E4DDA1;
	Tue, 18 Jun 2024 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dm0W0PPO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB8D7484;
	Tue, 18 Jun 2024 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718673029; cv=none; b=mCqt17hazHvhqUbb8WrAZpJr5Sw4Il5ne7ANk3iW0kKSOxGs5vJDY7nlpBlxgXx0cscc0FPe6tYdm4VA3c2JeNCbvBLcMXM0xbkltbu2mDvL+cvnrlf4qf9+WkpPSW7d6NN43mTw0cGTLAW++Hg8WjfJ+YfJq7mBLrfgtSaSTIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718673029; c=relaxed/simple;
	bh=D1Hb9PTjjb5VJ6oESgrq8tW9wsiu/aE2khTnlYXaWHQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fSvvSNNXLHozRMOp6zlpIh/rMwLLzOGulm6mQdUUFy22Ud6X/Llgy89lqJ+lWhStNxDWVZQJY4NaGp7PDIiU1Yma80/pqMjBoaLHTTtpnoBQW34QI9ee4N59rZN7TXGl4rOebIWFwX2KhbWtNbc+TwdmRuMgMxVt3lfTDA0sHGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dm0W0PPO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2BD19C4AF50;
	Tue, 18 Jun 2024 01:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718673029;
	bh=D1Hb9PTjjb5VJ6oESgrq8tW9wsiu/aE2khTnlYXaWHQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Dm0W0PPOSbNyAE9e6HiJUOsT/2bEjg2X06VQQRlCAa7eS06SNL0LCtfUf+oU/suyR
	 A8idcFMHNQEGFW3ArecPQDCLeiug2n4Mb9QAJ++1ZTC39Vf5xohmt2NNlR8gvIqFpz
	 8FzV97ARwgB4Je6hWxJBrbQ6q9Uq3CAlSrD8Dum/7ctZoq9aNK7+gCymw6tAwjyNaP
	 fRNNW6MAuzAq1su1fS+rUjDSH1PnUGafS5c+ADMFzBXiRDhV6/NFhMGQmGM4ZX/Hh9
	 X8huXrfvTUP0ipmDtN9f66V9fKSCJ1wUbGvdroVffARQaLCmEWFF4no6E3VQq0FxKZ
	 xoAVQtLIdKcVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 09E3EC4166F;
	Tue, 18 Jun 2024 01:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: mptcp: userspace_pm: fixed subtest names
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171867302903.10892.3498762068378153326.git-patchwork-notify@kernel.org>
Date: Tue, 18 Jun 2024 01:10:29 +0000
References: <20240614-upstream-net-20240614-selftests-mptcp-uspace-pm-fixed-test-names-v1-1-460ad3edb429@kernel.org>
In-Reply-To: <20240614-upstream-net-20240614-selftests-mptcp-uspace-pm-fixed-test-names-v1-1-460ad3edb429@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shuah@kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 14 Jun 2024 19:15:29 +0200 you wrote:
> It is important to have fixed (sub)test names in TAP, because these
> names are used to identify them. If they are not fixed, tracking cannot
> be done.
> 
> Some subtests from the userspace_pm selftest were using random numbers
> in their names: the client and server address IDs from $RANDOM, and the
> client port number randomly picked by the kernel when creating the
> connection. These values have been replaced by 'client' and 'server'
> words: that's even more helpful than showing random numbers. Note that
> the addresses IDs are incremented and decremented in the test: +1 or -1
> are then displayed in these cases.
> 
> [...]

Here is the summary with links:
  - [net] selftests: mptcp: userspace_pm: fixed subtest names
    https://git.kernel.org/netdev/net/c/e874557fce1b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



