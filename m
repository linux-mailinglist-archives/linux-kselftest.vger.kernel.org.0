Return-Path: <linux-kselftest+bounces-22959-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF0F9E7DC4
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Dec 2024 02:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 608F51883A9D
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Dec 2024 01:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32687A935;
	Sat,  7 Dec 2024 01:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ye3E6p+p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0578AC2C9;
	Sat,  7 Dec 2024 01:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733535617; cv=none; b=hp4yBeiu2CqLQWVbUpx9OxcLdfsBf3dqAHbBvGmPidY7zKTkqOkf2J99ZwA9zV7V0O2vFafGfXgoEaslkrEZxaRPLDibMd7WisyKV3juzJVuyLj6ataEeGiPlAKXVsfm96S42PdCQJJSqJH3T80Z3lZYRTv6wq2lgCJpZyUtyoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733535617; c=relaxed/simple;
	bh=cpuCrCGDAlMFmRWt4pthFMMyyEO+/k8luPU73jnEclA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YXy7MpuAqi2YGYnY/oRf2Mjwstj7sk+l/41fX+CXU7iymlh8TYPol8vyylYvzpEKq8ULFQogBpwHFFUGGIRQVjriRKDLB6sNDmqUacXL/zNJ7TdcAR4ZdFdMs4w+1fru4s7Qkoa/hJnJqZ5qzfPCSqNLwa4QMgBxGGjHYtwa9Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ye3E6p+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77CE6C4CED1;
	Sat,  7 Dec 2024 01:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733535616;
	bh=cpuCrCGDAlMFmRWt4pthFMMyyEO+/k8luPU73jnEclA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ye3E6p+pMERvoVx66VzDfCP+9xzPdovDQl0JxpCwrw+zg1ecCDL85fJKv5lybicf5
	 Bbhpem0mt9Ws596dn33a+9HOCSPUu961MnBnWpW8N8FZ15ZMAgRwXagVSnppPfRaXF
	 muk4KI3HwGqkSygjINHY9yKR8X7LB6I4mrRKXyG8IM5qKXJ1wbqfZeIX2LQNJbaGxa
	 DjmsNsrNwCRHhQTdkhSTZ5pVrw8953S6lvgKRFcOGzxA+Demxw8eGF1OCXNg8guOH+
	 XQrar8gLBbr1w53yJCXBwlBW9SC4QjpIpihUS4C3OcdmYfqYRYfxxs4neC36Xx44hW
	 zHvnzdBiygbzg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AFF34380A95C;
	Sat,  7 Dec 2024 01:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] selftests: mlxsw: Add few fixes for sharedbuffer test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173353563151.2868165.5316465937506870618.git-patchwork-notify@kernel.org>
Date: Sat, 07 Dec 2024 01:40:31 +0000
References: <cover.1733414773.git.petrm@nvidia.com>
In-Reply-To: <cover.1733414773.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 idosch@nvidia.com, danieller@nvidia.com, jiri@resnulli.us, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 5 Dec 2024 17:35:58 +0100 you wrote:
> Danielle Ratson writes:
> 
> Currently, the sharedbuffer test fails sometimes because it is reading a
> maximum occupancy that is larger than expected on some different cases.
> 
> This is happening because the test assumes that the packet it is sending
> is the only packet being passed to the device.
> 
> [...]

Here is the summary with links:
  - [net,1/3] selftests: mlxsw: sharedbuffer: Remove h1 ingress test case
    https://git.kernel.org/netdev/net/c/cf3515c55690
  - [net,2/3] selftests: mlxsw: sharedbuffer: Remove duplicate test cases
    https://git.kernel.org/netdev/net/c/6c46ad4d1bb2
  - [net,3/3] selftests: mlxsw: sharedbuffer: Ensure no extra packets are counted
    https://git.kernel.org/netdev/net/c/5f2c7ab15fd8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



