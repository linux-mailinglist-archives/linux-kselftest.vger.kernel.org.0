Return-Path: <linux-kselftest+bounces-37355-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFFBB05D02
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 15:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 161227BE1AF
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 13:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD572EBB8D;
	Tue, 15 Jul 2025 13:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFo353tJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2A32E7F3C;
	Tue, 15 Jul 2025 13:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586186; cv=none; b=AC7XZtBShQAkvlSWD9zsZ9xmaD1vMFLlkkXcd/zl6WirouNadi9F7riKZa64ER8trx0uHtqHMNglJUveyUatr86GO7G6aVm2ERsRPoW282iXHL3aSBq/pN+2rDM5diMZGv3lILRJvNLPGwzLXojaF7gsiz+HtFMcfs7s7A+dJjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586186; c=relaxed/simple;
	bh=zGU0LcwmTAnL029F6vzgvGMlUoaM+RD55WK6CDtweko=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I68JR2CcifUr5h6WrY9FvWOSnFAp4SLRTCWKlZhaU+zS19J0ijhU0HB19fmDB1kpYSGesi4956XhwFGrEh26z8QL5cPN9KQ3DQLiiQfnsn8qYr1j0KhlNBv4aiXfpnBr51wHb/u60UnwJs/NUJ2WGKeDZT7Eek6PUxZJL/PIvhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFo353tJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC753C4CEE3;
	Tue, 15 Jul 2025 13:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752586185;
	bh=zGU0LcwmTAnL029F6vzgvGMlUoaM+RD55WK6CDtweko=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PFo353tJ/UldlBJuOwuH/i5Nx3LbtpCHVfJk9ehteoQ/KohwjYZP8MraL03yTghmm
	 LRv7eKXC8eAhi8Xmn1ttJkJxll+JhFJ37LfMFdahbwcsbCQSpABTSnQuUb8wKgf6ES
	 1oV/hnQX7cVcrm1sMBhRRHfv8NgJPknWomhSsXi520RqZE1w+pBjpGyWNr1OuEYo/p
	 n5yg+QNksi/xfXNDwUgVs2lgF4J/ec/eIr7K3Is8sulD4lKB4Wgbe5bTBngU08MPyy
	 tM/cXv96vKc1va9BgaViWdl8cgFAZG1BudwRzLtua/DfXyc8fxJmWTZTB7aJ4c0x7v
	 yaPUeDHBV8EkA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD1A383BA03;
	Tue, 15 Jul 2025 13:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: net: increase inter-packet timeout in
 udpgro.sh
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175258620651.421913.3791564351416618105.git-patchwork-notify@kernel.org>
Date: Tue, 15 Jul 2025 13:30:06 +0000
References: 
 <b0370c06ddb3235debf642c17de0284b2cd3c652.1752163107.git.pabeni@redhat.com>
In-Reply-To: 
 <b0370c06ddb3235debf642c17de0284b2cd3c652.1752163107.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 10 Jul 2025 18:04:50 +0200 you wrote:
> The mentioned test is not very stable when running on top of
> debug kernel build. Increase the inter-packet timeout to allow
> more slack in such environments.
> 
> Fixes: 3327a9c46352 ("selftests: add functionals test for UDP GRO")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> 
> [...]

Here is the summary with links:
  - [net] selftests: net: increase inter-packet timeout in udpgro.sh
    https://git.kernel.org/netdev/net/c/0e9418961f89

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



