Return-Path: <linux-kselftest+bounces-29699-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7902BA6E38F
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 20:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99AC43AD358
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 19:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BDE1A83ED;
	Mon, 24 Mar 2025 19:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilZ8o2cv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B43A1A5B8B;
	Mon, 24 Mar 2025 19:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742844602; cv=none; b=PzKyWBXG5NZmce/cQwfPaz5hXqIILKBK8BSdxREViEnSHaVjW+kkMnEDRuC36KIA5jAF30usd3lMNEUwPhyNAqce2XAPuhOmkV26X8eadwBvOz1eld4vSNikcJHKw8Jle7u1jw9cS4Vir4ncrEou2Flcd8l9QBpORZm7A9WjDjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742844602; c=relaxed/simple;
	bh=TbSqYbCYGbS4Mj9Mnrm/o9gdU4W3fvZqouwvEPGgNZ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R5gYa0k95SyfgTCdoTpEa6bUA7oOMR/Vmn5VNBjUk3FW3bMbquMXfFjS5J6At3qZSJwwf8GudxJ2VTZz3yDUwyDkY0HaZuNJsZwHnBxnaYhTco5OLuQNAXNyR3K9gZXYq5DRxMgM/X4WjN9cV+e+HnaUGNmhPUvvyA6a6FqXJLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilZ8o2cv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81147C4CEDD;
	Mon, 24 Mar 2025 19:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742844601;
	bh=TbSqYbCYGbS4Mj9Mnrm/o9gdU4W3fvZqouwvEPGgNZ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ilZ8o2cv4ov5XDEhv8P27LSkg5BWPM+PlfUmjXB1UEhK/tUqNGKH5vk7BvnxsWWOb
	 58Q7c45LIWfFKL/gYnNvILwKWQZA2c/zL7Mj0YNRzROg9x5s0wKHSLgwIEmTzQZMxo
	 94/aNAysNXn52HC4nf1fV/wIYpr1jumX9sqUWQJ+WD+68VHoVqhnbXvtWsOiIgpGI3
	 qDhyg5se43eypB66X+5QBhhpTR7HqvYHmDzshFeluLJYzxea5oeTLX5LcCNCNHa5Pv
	 dYZB8xxQBdV6Kwypf3gmVEbPk9p8ti1Jr0sX/aFKjrI3vXCXkoy0nzIbCfnr0hfAeu
	 RgLI3SOTX4HAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF0D380664D;
	Mon, 24 Mar 2025 19:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: drv-net: rss_ctx: Don't assume
 indirection table is present
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174284463777.4144910.15829984579184745582.git-patchwork-notify@kernel.org>
Date: Mon, 24 Mar 2025 19:30:37 +0000
References: <20250318112426.386651-1-gal@nvidia.com>
In-Reply-To: <20250318112426.386651-1-gal@nvidia.com>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, noren@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Mar 2025 13:24:26 +0200 you wrote:
> The test_rss_context_dump() test assumes the indirection table is always
> supported, which is not true for all drivers, e.g., virtio_net when
> VIRTIO_NET_F_RSS is disabled.
> 
> Skip the check if 'indir' is not present.
> 
> Reviewed-by: Nimrod Oren <noren@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: drv-net: rss_ctx: Don't assume indirection table is present
    https://git.kernel.org/netdev/net-next/c/c61209eeb0b3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



