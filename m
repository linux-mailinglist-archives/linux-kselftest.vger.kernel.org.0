Return-Path: <linux-kselftest+bounces-40498-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB61B3EEEB
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 21:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE85B1B22219
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 19:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEAB2673AF;
	Mon,  1 Sep 2025 19:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8QW6LJW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B602C265296;
	Mon,  1 Sep 2025 19:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756756201; cv=none; b=JxxtYNd4YlEWfwWqtlk7iRyW6D8pydX/Cn2a28QwyYpeOB4z9e+YvAvqCkg5vanDNSMEK9n3uKLBQ+PSYPY0O9pLtWsd3+V5UyREXof9IY+Se9BsMFZgesGdal5L4Rvf9xCPJ5i/WYPOCkovYX7gPSPuxujddgrvjvXw1j+DXaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756756201; c=relaxed/simple;
	bh=PH5C9EiZfSyUfFA7TKYuIcM8KcPn1PtOBL90zzIyN9w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kgnrOCjoTJbUwgKbRu0EmYiW0ZyRbBSLYr0BXY1Y6uuUhspN2v6vqeIi2BEf6Cr0G3qLkcFoQR2AeBjD2zgvHXge8iJ5DVGETqzFcyIeEgxLpLKr1fmDZZI2Zx0hjKFimmR/Nchq84qR5Q7malVdcAE6FIXI6BaIPCuU+kBiBHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8QW6LJW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC26C4CEF8;
	Mon,  1 Sep 2025 19:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756756200;
	bh=PH5C9EiZfSyUfFA7TKYuIcM8KcPn1PtOBL90zzIyN9w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M8QW6LJW9LYuEQalpWIfEPkeFYH1wO8QhfKNQ5OeuqKndGsZXGHj8JBNh+RLDeQK8
	 98ZjkRudFfzr2GhI2xl7MHFA6WgJMlOai+bzzgMKvXk45Scey/e/RwEAB7rM03U8zp
	 ohZgJH1p2TcThROmklvgpAAIIMS4OSOC2EqbM49uz5JiKmp/yKFFM6amBaR8r227oB
	 NWL/AvF/hh++yKl/iK0KY1OQDvrOFaoGLdIWHz8yreLIo4pEvioWphWCvhI9kRl11P
	 PviWs5u+MptUPzo6OYLwTrUlQnuyXOhJmpqezy4Y4oGEIiRg2LPmaTzLluN7n+jJbW
	 JTZOs6Zpn2MBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34076383BF4E;
	Mon,  1 Sep 2025 19:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: drv-net: csum: fix interface name for
 remote
 host
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175675620600.3865350.17841786952688569650.git-patchwork-notify@kernel.org>
Date: Mon, 01 Sep 2025 19:50:06 +0000
References: <20250830183842.688935-1-kuba@kernel.org>
In-Reply-To: <20250830183842.688935-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 willemb@google.com, linux-kselftest@vger.kernel.org, petrm@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 30 Aug 2025 11:38:42 -0700 you wrote:
> Use cfg.remote_ifname for arguments of remote command.
> Without this UDP tests fail in NIPA where local interface
> is called enp1s0 and remote enp0s4.
> 
> Fixes: 1d0dc857b5d8 ("selftests: drv-net: add checksum tests")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] selftests: drv-net: csum: fix interface name for remote host
    https://git.kernel.org/netdev/net/c/49c2502b5946

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



