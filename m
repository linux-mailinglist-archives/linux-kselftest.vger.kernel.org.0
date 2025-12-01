Return-Path: <linux-kselftest+bounces-46851-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88622C9925F
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 22:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5A4B3A57A6
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 21:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77447287253;
	Mon,  1 Dec 2025 21:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqZmczoi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAF2286418;
	Mon,  1 Dec 2025 21:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764623596; cv=none; b=jzzcaThWTcw844neJBiKCk7UjdnnJF09oeIerqfs34JZKBYlGIFAWiRjXtn5Hhxme/LBwEhGi0qTEtZW0CI2ORuxPNjRmGUofv7mpUbu6onp3J3/rQprxSj55HIhQJWUOFax+ci2NNy2VPWFtfjOXDvU0Zxs1Y8aZ8n+g946oHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764623596; c=relaxed/simple;
	bh=tY1DXM8ZSq3IEqnZKUV4mOlLDuSi5609HpoHw/gSg+g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AwHuGglFKTaUX0Nomxi3OGrkNlfk0xELkwDlerQqz7QgNuxeboUtdcTeptyMuxeR5gDJcgiTTQqfC2fF94Z5WKKMetMTVDrO0X+X8CjiuqKxeiyJ0J2Zkvd/Z6BhKGRaz/309N+X9SFQcDctFSsQuLkmlB6NUY4Y6YZtlwsjw+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqZmczoi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C05C116C6;
	Mon,  1 Dec 2025 21:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764623595;
	bh=tY1DXM8ZSq3IEqnZKUV4mOlLDuSi5609HpoHw/gSg+g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZqZmczoiNdlJzsE/PTYGXlG7cmbnJOdmZRLP6clOSHNqnbNbEohDoPIJkrVDQIvHP
	 paVbD9yBI5bfO4PchxbPxy2fcjKfAIykzlrvhRxIx6zmI2xyM0qIS+P9/XZdl1Yudw
	 9gbD0Yl9mgKMfuP6U9nT3wJsvCm68R64m5Kv2OXg/Z3q+F+ZC9xi+mXw0Oo1edaZ5D
	 wp2OzRxlg/APPeH3vIRzn2IGDXBD4tfvoi/Gwdh+Gnrhq4Y9XOFuaFQU8zS+0yJr3j
	 hbgErjqxdhNlu8M+HVBzfDeUaRO4LqSiB3JjFG5rV+aXgA5/NxpYkjesOlCAEHRJ63
	 I4qiUkXkz5Ung==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2775381196A;
	Mon,  1 Dec 2025 21:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: net: py: handle interrupt during
 cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176462341577.2539359.474015232966302072.git-patchwork-notify@kernel.org>
Date: Mon, 01 Dec 2025 21:10:15 +0000
References: <20251128004846.2602687-1-kuba@kernel.org>
In-Reply-To: <20251128004846.2602687-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 willemb@google.com, petrm@nvidia.com, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Nov 2025 16:48:46 -0800 you wrote:
> Following up on the old discussion [1]. Let the BaseExceptions out of
> defer()'ed cleanup. And handle it in the main loop. This allows us to
> exit the tests if user hit Ctrl-C during defer().
> 
> Link: https://lore.kernel.org/20251119063228.3adfd743@kernel.org # [1]
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: net: py: handle interrupt during cleanup
    https://git.kernel.org/netdev/net-next/c/4b1639cac04c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



