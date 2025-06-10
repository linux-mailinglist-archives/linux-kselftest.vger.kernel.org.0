Return-Path: <linux-kselftest+bounces-34626-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC14AD44E4
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 23:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EDB73A6712
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 21:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293B2284B3A;
	Tue, 10 Jun 2025 21:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOks81qF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC081401C;
	Tue, 10 Jun 2025 21:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749591605; cv=none; b=dsoE8qnJtcbKRY2zRiE18qOAs6+lc1BjyrXYw+aekkrpgnKOmqcdC92mMmpJgts/4EI5SaCnTFOkKf/vAFqiGMde9b17i7CiiFhAAMtDslLMJXPYEMOi/Sx/an4RnVZUbNLAK5UQk0FlNu4eI4zp69KHpgPJCI8+4FrP3+wwcWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749591605; c=relaxed/simple;
	bh=SInQPZWVlM9qClkL2l+4evH3wQpA7xfOj8AR4ryIGDE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=vBI5eWrlDOgzNXNyDVKqrlz5xYRwDTKqj0C6h8tbvFoELi2R5XJz9nIjPIXDqGku1v79lM4gHRE0x4w7jKcW1cV8Hv0Rg5GKqZ8KjulHAQGVcka1FG/CLqSqw/a0fzoh+87Aps8Yf5Oj3FPqOKjKUwLMPzV/lJI2BkiqGnNIpbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOks81qF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDEDC4CEED;
	Tue, 10 Jun 2025 21:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749591604;
	bh=SInQPZWVlM9qClkL2l+4evH3wQpA7xfOj8AR4ryIGDE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HOks81qFV1AubezDyY0JRCQQCJw5wvZ+i5xBp66GlwONb8EyPKVF+BWJEjzZqYoJM
	 kJ7UmOPmzwcPKxPWvVLb+t6QepKDJyhUb5m5ky9H2pVTPvmpYaQVNWtOBVfJj8pIFt
	 tepv8s9ejXv+K2hnNDL+iT+I2cqVr03wdj73VAiITruGkqVKtKEkDcNurYGALY4IIu
	 GfuRjp+GUJtuVH3EKHmRttDuNcIvEMjspBQzyWlXmrTmvPRl3P8NKsHdsLTwYlmU/z
	 uE+j07vHg3HVRc5NzpFGvPnEO7ZwloejL68hAyZXWATF/CqLnZsnQA9J+1kMs3WTZi
	 fbNyxHHSFibgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE2938111E3;
	Tue, 10 Jun 2025 21:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/4] netconsole: Optimize console registration
 and improve testing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174959163475.2619474.7924574005472646166.git-patchwork-notify@kernel.org>
Date: Tue, 10 Jun 2025 21:40:34 +0000
References: <20250609-netcons_ext-v3-0-5336fa670326@debian.org>
In-Reply-To: <20250609-netcons_ext-v3-0-5336fa670326@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, tj@kernel.org, akpm@linux-foundation.org,
 shuah@kernel.org, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, gustavold@gmail.com, usamaarif642@gmail.com,
 linux-kselftest@vger.kernel.org, kernel-team@meta.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 09 Jun 2025 02:46:25 -0700 you wrote:
> During performance analysis of console subsystem latency, I discovered that
> netconsole registers console handlers even when no active targets exist.
> These orphaned console handlers are invoked on every printk() call, get
> the lock, iterate through empty target lists, and consume CPU cycles
> without performing any useful work.
> 
> This patch series addresses the inefficiency by:
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/4] netconsole: Only register console drivers when targets are configured
    https://git.kernel.org/netdev/net-next/c/bc0cb64db1c7
  - [net-next,v3,2/4] netconsole: Add automatic console unregistration on target removal
    https://git.kernel.org/netdev/net-next/c/e99d938f8671
  - [net-next,v3,3/4] selftests: netconsole: Do not exit from inside the validation function
    https://git.kernel.org/netdev/net-next/c/69b25dd20c83
  - [net-next,v3,4/4] selftests: netconsole: Add support for basic netconsole target format
    https://git.kernel.org/netdev/net-next/c/224a6e602fb3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



