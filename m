Return-Path: <linux-kselftest+bounces-3940-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC1F845D71
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 17:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06B121F2668C
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 16:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CF56ADE;
	Thu,  1 Feb 2024 16:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXE1TQq3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659DB4C6C;
	Thu,  1 Feb 2024 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706805627; cv=none; b=D1335DDx1JnP4s194Lr1JUdXGkzJqmddN5BAjYNcXYUqfec2fodql7h4E5Zvqzqe6Ab2NQXpUbyZLxT78CLQO8Ow34rllCYZoxpfJl3YiMY2MG30LgMPz3Jm8dz79xlmSdeRcAJJ0hOqC21SE6MEvywUQvVN2w6rmJuBXEp2fwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706805627; c=relaxed/simple;
	bh=jDmEcTXg8weHMq5EaQcf5aXeHE0ur3f1vgDtVNQUMu0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NxH3Vas7CLN+83XZojaxxy7SXRqkxYB3awv9qXXWV2+jRJ8PnaSDAbse56AbGVRFShurXJNbVy4h9lGnjIG+hiJ6jPZ/O8aeWZT3pYB14nKHm61yXFDT9rQb11wPv4PxfiDWV4HurcMliFGkLVUQQpsWST06E7QFLPg7aJ7ZxYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXE1TQq3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4C4BC43390;
	Thu,  1 Feb 2024 16:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706805626;
	bh=jDmEcTXg8weHMq5EaQcf5aXeHE0ur3f1vgDtVNQUMu0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WXE1TQq3NqvTfG0JFjZwb3JP5hSpQUNvEhJRePfEjUduwoO0jcfy+aBR5kSkIGtAm
	 1u80kmWe3D8uYErV+LQiXSpnoDcLI/S56vjlZAyquv0MmJSTqv/MvZ5GDqBAcrO6Vx
	 8w5+/6YDd3NKODSvAIMyljL0pzA5zVWWWKW18ZaHYdlBU35z/84hEEKWQE1JUwDdeP
	 Nxpr9ygSpg7x/QaviChKjD51lZN0jIA1jTXpZIkqApPmdj11r2fg+XpGVa5L7/KZgj
	 A1Yupwmxw18C81mPp9qrkcLTV8guZv65shYBoaxV29C+v3NDZUqjMletLEdwcnDdTV
	 qdMPT3FIprDnA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B876BD8C978;
	Thu,  1 Feb 2024 16:40:26 +0000 (UTC)
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
 <170680562675.32005.13912206823084426465.git-patchwork-notify@kernel.org>
Date: Thu, 01 Feb 2024 16:40:26 +0000
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

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

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
    https://git.kernel.org/netdev/net/c/7b6fb3050d8f
  - [net,2/5] selftests: bonding: Check initial state
    https://git.kernel.org/netdev/net/c/8cc063ae1b3d
  - [net,3/5] selftests: net: Remove executable bits from library scripts
    (no matching commit)
  - [net,4/5] selftests: net: List helper scripts in TEST_FILES Makefile variable
    https://git.kernel.org/netdev/net/c/06efafd8608d
  - [net,5/5] selftests: forwarding: List helper scripts in TEST_FILES Makefile variable
    https://git.kernel.org/netdev/net/c/96cd5ac4c0e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



