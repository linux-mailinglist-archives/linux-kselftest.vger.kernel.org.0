Return-Path: <linux-kselftest+bounces-3078-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FD082F114
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 16:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98E6F1C23576
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 15:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513FA1BF43;
	Tue, 16 Jan 2024 15:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKTjPLVy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D4E1C2AC;
	Tue, 16 Jan 2024 15:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3577C43390;
	Tue, 16 Jan 2024 15:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705417825;
	bh=mSr98lR4INmhtPkYRjcJH/JNnUo/5xOgX03o2Vhas4A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bKTjPLVyz98VZuCRkbi11N0HpOqeyVdjBuomZJacAzO5pR7dslzICYzk6v7/QkXle
	 /Zl/EsgIXo0coyEbUbpXB7Q5GwEhtUlx1Pw1ek0SxIkRsPgilSx7eTqvsCXP1m0qBN
	 SwVFI2Y+0CkGc+7LXq5UDx4xSGzZ4uevDIgNanKI/wUvZHC6E7XWicMqgJmHHCX3bk
	 OdPMwkpjhDOl5lbv0T5Rj331Xtgh3bFLzJp6dguhiePApMm5FF+zUfZZEU6x3UfE9E
	 vpbKwDmRPHDPgFM9WF6OTfv2sRta6Pj6wbp472DJcJZ1j6+IbTzb9ocRyPwKgKnFLd
	 awGVd/2rj0Sgg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D92AFD8C984;
	Tue, 16 Jan 2024 15:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: bonding: add missing build configs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170541782488.27924.3496922518125230270.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jan 2024 15:10:24 +0000
References: <20240116020201.1883023-1-kuba@kernel.org>
In-Reply-To: <20240116020201.1883023-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, j.vosburgh@gmail.com, andy@greyhouse.net,
 shuah@kernel.org, bpoirier@nvidia.com, jon.toppins+linux@gmail.com,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 15 Jan 2024 18:02:01 -0800 you wrote:
> bonding tests also try to create bridge, veth and dummy
> interfaces. These are not currently listed in config.
> 
> Fixes: bbb774d921e2 ("net: Add tests for bonding and team address list management")
> Fixes: c078290a2b76 ("selftests: include bonding tests into the kselftest infra")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] selftests: bonding: add missing build configs
    https://git.kernel.org/netdev/net/c/03fb8565c880

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



