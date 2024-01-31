Return-Path: <linux-kselftest+bounces-3878-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0358448AD
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 21:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76BDB284673
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 20:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73F63FB35;
	Wed, 31 Jan 2024 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJEp1Zx7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900853EA9B;
	Wed, 31 Jan 2024 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706732429; cv=none; b=X8mko6YbqDZjMm8mJZbLU7/5cM4wNKkN3xcZeNNIQG0J8zIDeR3RuThtWBE6nW6b4frXNMn4z65vbWPLkrth0Fx0sXJJNTfFf/tSiUUMaBWcx6+3563+rtTthmF53pdA5adTKXJ681CD3+lT+uaVNyOVg1aaeUWt6LDnA1E9R18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706732429; c=relaxed/simple;
	bh=9JS572ehXY5lD1Rr9lCtv1vWQRI6/6GWHLraQyEcM5c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LI3lDzR/u6KPu3ArT1R9q/2HRe3rkLQmLaLcVpCYdi529APlT8rh+dlLBUoVjkLdxWw/52r8tYWkZbOzkEbc87I7nc7T+1FFDcfdej0LyTaISSk9O/zFjg6bXcJ/raIP2oie4Uspvef6rwInNp+fMjvz/NAB9vK45ebEKyvHHjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJEp1Zx7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FFD5C433B1;
	Wed, 31 Jan 2024 20:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706732429;
	bh=9JS572ehXY5lD1Rr9lCtv1vWQRI6/6GWHLraQyEcM5c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eJEp1Zx7hxRYbyCpAvIRd5JibQu9nwh5C56aGi8V9VWBKEevvRN3In53n92dW8kXg
	 HkzDQewyoLcoWNhnc18mdgxFv4s1TP2ITNV6jyG94vqNTcGi0kMdUqvWR9THUnnRQj
	 qoxespwdImxaeAKiVEm9+1Dk+Xg3A5AqHBq7eqKMBVplBJYtT/RNsCAnLtHjitjbqF
	 T0rvW//DZD7+Hv2aTh58vuMcDJo1rzfR/pL2QBzC4GZsXmpzNjxbDheS5GxYfNlBMA
	 8ToeLd7uyfpvtGNVaUwM3QM55PsauOPhXPh2gpbE4eZlJ7Dux/k9VKLTTYzgUKZXgn
	 lB5/crR3iCbFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 093A8E3237F;
	Wed, 31 Jan 2024 20:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] selftests: net: More small fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170673242903.4502.18397018894272335280.git-patchwork-notify@kernel.org>
Date: Wed, 31 Jan 2024 20:20:29 +0000
References: <20240131140848.360618-1-bpoirier@nvidia.com>
In-Reply-To: <20240131140848.360618-1-bpoirier@nvidia.com>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: netdev@vger.kernel.org, j.vosburgh@gmail.com, andy@greyhouse.net,
 shuah@kernel.org, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, petrm@nvidia.com, danieller@nvidia.com,
 idosch@nvidia.com, jnixdorf-oss@avm.de, dcaratti@redhat.com,
 vladimir.oltean@nxp.com, tobias@waldekranz.com, lixiaoyan@google.com,
 willemb@google.com, lkarpins@redhat.com, anders.roxell@linaro.org,
 liuhangbin@gmail.com, linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 31 Jan 2024 09:08:43 -0500 you wrote:
> Some small fixes for net selftests which follow from these recent commits:
> dd2d40acdbb2 ("selftests: bonding: Add more missing config options")
> 49078c1b80b6 ("selftests: forwarding: Remove executable bits from lib.sh")
> 
> Benjamin Poirier (5):
>   selftests: team: Add missing config options
>   selftests: bonding: Check initial state
>   selftests: net: Remove executable bits from library scripts
>   selftests: net: List helper scripts in TEST_FILES Makefile variable
>   selftests: forwarding: List helper scripts in TEST_FILES Makefile
>     variable
> 
> [...]

Here is the summary with links:
  - [net,1/5] selftests: team: Add missing config options
    (no matching commit)
  - [net,2/5] selftests: bonding: Check initial state
    (no matching commit)
  - [net,3/5] selftests: net: Remove executable bits from library scripts
    https://git.kernel.org/bpf/bpf-next/c/cd1c194ffe28
  - [net,4/5] selftests: net: List helper scripts in TEST_FILES Makefile variable
    (no matching commit)
  - [net,5/5] selftests: forwarding: List helper scripts in TEST_FILES Makefile variable
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



