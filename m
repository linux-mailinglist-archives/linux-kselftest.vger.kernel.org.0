Return-Path: <linux-kselftest+bounces-3072-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0301782EE6A
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 12:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 152F71C22735
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 11:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB1A1B955;
	Tue, 16 Jan 2024 11:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdpHhIl3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8EC1B949;
	Tue, 16 Jan 2024 11:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A5D4C43390;
	Tue, 16 Jan 2024 11:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705405825;
	bh=rXHQ7Ku5XplmODPVNkuObZlHEDW9wYYriss4lusEIF8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LdpHhIl3fcNzvGDoQHgsiL50CeRo3KAFBdFLeFo7b7q9esusicXOu395Gqpsp7ZXW
	 3YqgPS5UJyZeCPhAA3awOM25+a1dV1GZo+Tqzz/b7wUcB0t2R5/wKfF6klltLapR/3
	 sxW+B4gPv7YAZw4FUnYommUCcY210sVICxWjfnMS77V5cn5+IWsbS6x9G6oab02t4O
	 qpv3PhPMwstxsPQyMNdHqCHme/HwzxeysoVrF5e9xkjn6uH9gElzjgrc04J1HesSrB
	 bSXZ98xN49xbLBGMQZjFaSCxWrwvjIzP4K0pixPU/ng+iY8CwLwi7icT5BpbstZFhQ
	 ZjopZc+rkLwZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 092B4D8C985;
	Tue, 16 Jan 2024 11:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: netdevsim: sprinkle more udevadm settle
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170540582503.11912.17731327757214995660.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jan 2024 11:50:25 +0000
References: <20240114224726.1210532-1-kuba@kernel.org>
In-Reply-To: <20240114224726.1210532-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, saeedm@nvidia.com,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 14 Jan 2024 14:47:26 -0800 you wrote:
> Number of tests are failing when netdev renaming is active
> on the system. Add udevadm settle in logic determining
> the names.
> 
> Fixes: 242aaf03dc9b ("selftests: add a test for ethtool pause stats")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] selftests: netdevsim: sprinkle more udevadm settle
    https://git.kernel.org/netdev/net/c/2c4ca7977298

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



