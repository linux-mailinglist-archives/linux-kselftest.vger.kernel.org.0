Return-Path: <linux-kselftest+bounces-23739-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B067B9FB419
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Dec 2024 19:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF63118855A8
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Dec 2024 18:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6DA1CBEAC;
	Mon, 23 Dec 2024 18:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2AUJZUY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A901CBE95;
	Mon, 23 Dec 2024 18:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734979235; cv=none; b=gqNYcxBd+AtQHCfI3EC2OmwQcbgd8zcat+v0M4DNv4QkUA0TubYpzEByuawEf+3kEo4DWuKrBlxZCn/CWW5xwYQypUooXmYpeWbA2wUi976MYykyL0cKb9FAPeZHhLOJfQPZUx6Iwts+flZVY0W0dtb4Hvyj3WqmfRRvd95EgB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734979235; c=relaxed/simple;
	bh=xlwCSKeqG/PSH+pI0nVyzi2+G2SFi0aYhf+kRkaf1n0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KeyWtUvi558qIcdL6J9oEa0Rwpebg7uA9k2UralgsxUoBNRp0UvN2nPzZRtrjwpGDCH3zgFoYFQ1JU8L44dvHWcDJCS7h5DO8687lB+X0aBF77XYCONPYXZDEIALzt4+g+94PQK+T0+jnS1w5x6Wxk4KXOA1tRfjxpdMI+h+iYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2AUJZUY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FABDC4CED4;
	Mon, 23 Dec 2024 18:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734979235;
	bh=xlwCSKeqG/PSH+pI0nVyzi2+G2SFi0aYhf+kRkaf1n0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S2AUJZUYPV5lgCOipPHlCaqeaKNuaEkvSW0uwYjJwSgEticbeGWjSg+Y5JrnNgXmp
	 R4vjzBsEVV3xLv/QJssfuG/Sp3ZCDJJ+SEC8gmY6ZyRAMNOl0+rCVPwKa05mOjrZ0a
	 sA+bDz1dzgC7p5slhZgFOS9xSkwiGZDzz6KJXBXQbbVtlSv+trZ9qCGSQUsz6/STmm
	 eB/ZP6Gx7Mb0HOh9BvEwtgYdD8rqct5HQb8kayjaVhtCL5awhAEQYPRPCLCP3txsvc
	 eNuBVHUJH98Wc+FmLTJnLe9SphPWgudjtlB8C1n0eW6/tFj3GNRQVSFuZUXfHbHjRB
	 VSOlk6erFjYEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD093805DB2;
	Mon, 23 Dec 2024 18:40:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: drv-net: assume stats refresh is 0 if no
 ethtool -c support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173497925350.3927205.15548996926035826833.git-patchwork-notify@kernel.org>
Date: Mon, 23 Dec 2024 18:40:53 +0000
References: <20241220003116.1458863-1-kuba@kernel.org>
In-Reply-To: <20241220003116.1458863-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, willemb@google.com, petrm@nvidia.com,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Dec 2024 16:31:16 -0800 you wrote:
> Tests using HW stats wait for them to stabilize, using data from
> ethtool -c as the delay. Not all drivers implement ethtool -c
> so handle the errors gracefully.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: willemb@google.com
> CC: petrm@nvidia.com
> CC: linux-kselftest@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: drv-net: assume stats refresh is 0 if no ethtool -c support
    https://git.kernel.org/netdev/net-next/c/f288c7a1ba26

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



