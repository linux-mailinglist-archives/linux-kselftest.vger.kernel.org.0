Return-Path: <linux-kselftest+bounces-8381-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4D38AA5AF
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 01:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 688EA283E6C
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 23:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0205D76029;
	Thu, 18 Apr 2024 23:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9KQfcbl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AC3757F6;
	Thu, 18 Apr 2024 23:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713482427; cv=none; b=bN0eoioavCT8x4DVQlUAgsVYOCBGHHWyiyJqXB3wM1yB+IIx+4nAS+WngUfr3Rj2+mo3dPt1kRPWSVRdFwI/gqWYtNbQL/xnw4Co6SkVnxxJ8xG9m+YPy8iWygkQyVC6FdMofwfPdJ6I6EthcMt4AS7lcdWIkF8hXZ86O7SgeKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713482427; c=relaxed/simple;
	bh=0Ln18wKzmGwLJy1EExmTx27AZ3IRJljHgPvbneq0Z5s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EmadoKASrB6wWNmYmLCtF/JsFUfYWHnmotcEkJbg+0zj7wvB51j/NkncquiwUPpv0Cu+v56jgrKvLrAYjqDsfRSZmI7VnZsnvNPNK6PUMZYvtYWIaOlJyOdLbS1FDhSopICRRCLU2K5pgaC5NNONUQD3Hn86ohihIcMVL3C/p+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9KQfcbl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D87BC113CC;
	Thu, 18 Apr 2024 23:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713482427;
	bh=0Ln18wKzmGwLJy1EExmTx27AZ3IRJljHgPvbneq0Z5s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l9KQfcblGd2dBmQFb4N7J2hxO6ZlPquMvHBZyIfxiHQ5JfudvlA0LrLQ27TDUEqVX
	 3ZoDS90A8j7Iqcel83NweabnJijea7e64zB2+0Tm1YNXMxkg9Dwzjy7EH04b2eZZUA
	 l880k4wyhcAM+ZZYG0/2m2aoUf4LVZ0pL+WCkqnOkK9TKVZLgsFZNskgo4DhfG/o61
	 AMGLnwCPecUC7dN4dGSetKDMwvMp1L24XePgP51QoFSskKbTc4l/APqVfWnA8PCI1V
	 vCrqLswrPUO4UmpMRSxTZ539xFGb6H3g/c51DlRBS/cYZLjcp5MpzOjupVDvQO6CLR
	 7VL0Q+zp962zw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3DCD4C43619;
	Thu, 18 Apr 2024 23:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/8] selftests: drv-net: support testing with a
 remote system
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171348242724.6056.16713096833623546188.git-patchwork-notify@kernel.org>
Date: Thu, 18 Apr 2024 23:20:27 +0000
References: <20240417231146.2435572-1-kuba@kernel.org>
In-Reply-To: <20240417231146.2435572-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, petrm@nvidia.com,
 linux-kselftest@vger.kernel.org, willemdebruijn.kernel@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Apr 2024 16:11:38 -0700 you wrote:
> Hi!
> 
> Implement support for tests which require access to a remote system /
> endpoint which can generate traffic.
> This series concludes the "groundwork" for upstream driver tests.
> 
> I wanted to support the three models which came up in discussions:
>  - SW testing with netdevsim
>  - "local" testing with two ports on the same system in a loopback
>  - "remote" testing via SSH
> so there is a tiny bit of an abstraction which wraps up how "remote"
> commands are executed. Otherwise hopefully there's nothing surprising.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/8] selftests: net: fix counting totals when some checks fail
    https://git.kernel.org/netdev/net-next/c/655614ea2bd3
  - [net-next,v3,2/8] selftests: net: set the exit code correctly in Python tests
    https://git.kernel.org/netdev/net-next/c/4fa6bd4b33ac
  - [net-next,v3,3/8] selftests: drv-net: define endpoint structures
    (no matching commit)
  - [net-next,v3,4/8] selftests: drv-net: factor out parsing of the env
    (no matching commit)
  - [net-next,v3,5/8] selftests: drv-net: construct environment for running tests which require an endpoint
    (no matching commit)
  - [net-next,v3,6/8] selftests: drv-net: add a trivial ping test
    (no matching commit)
  - [net-next,v3,7/8] selftests: net: support matching cases by name prefix
    (no matching commit)
  - [net-next,v3,8/8] selftests: drv-net: add a TCP ping test case (and useful helpers)
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



