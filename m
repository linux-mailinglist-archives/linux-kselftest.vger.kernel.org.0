Return-Path: <linux-kselftest+bounces-32808-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94785AB203E
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 May 2025 01:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 002274E29DD
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 23:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6E3266561;
	Fri,  9 May 2025 23:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hu14CO4W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AAD265CD4;
	Fri,  9 May 2025 23:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746833394; cv=none; b=kyNHCx872bI7Bb6GPTaUJFF3vNC4WcLwzkKAo/bgQ/plEneauE74aK/BSc2D/P0IYCFq88CL0oYRle1x6Ql+Z6FUd3n+K0fBpmREprABggcU+4Gt0y9xdibUPsCp4KrxT1ssQW2mnsRyRPn0S2pe9WqMYYwmeLJTbvdjXAs0FYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746833394; c=relaxed/simple;
	bh=xvIus1gxPsrl75aTZB0aBMiXFA0+00QVG0j48tv3A7o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sWtW+2Up+0pZ182LRfNwjmbMmCEAQJSDm9Fhjuz+M1z+38muD7x6nSbdowzeLdQZEka9caMUWYWU+9hkt5q64nEf619NC76Rco+uiAUg8K8UPNoB+mlWPavlerRe22z+x5U4/EfEODLCMJq8sQGuQJxL8NAfmJZtN1rEBaGeoAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hu14CO4W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5658DC4CEED;
	Fri,  9 May 2025 23:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746833393;
	bh=xvIus1gxPsrl75aTZB0aBMiXFA0+00QVG0j48tv3A7o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hu14CO4WQjZtuCXVWDz7em0gm++g0Hxexz4Y+T8qGGLoIeqyPipOPb6l5S9GrTu/8
	 bvbwGruj6bixY2ZXD7Lc6Bc06h9NA7J/6AWES4m7KJA6tSmEcxnDoRVhZrmba4G6zP
	 Uqkj5vFJ9Ai+uTVG71Q8SI/re/4v9VAQnM3iQmRblbyc5r4gbq6eoaBIj+6CbvSOZf
	 IbcpX3R8oScU13PRsVATGmALWPVZSlDEwoP8kzgOz4hRmpMxC/V3RWrNO+liDQ0hzv
	 rRVvNJ/eXepHJZZ85mIFBxXxY2krwlI1uelPR5uNwOoSfQq7t9EsKzDG9HL2JAYc1e
	 eiILSyEovSjhA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACE9381091A;
	Fri,  9 May 2025 23:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] tests/ncdevmem: Fix double-free of queue array
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174683343176.3841790.11524144387463205696.git-patchwork-notify@kernel.org>
Date: Fri, 09 May 2025 23:30:31 +0000
References: <20250508084434.1933069-1-cratiu@nvidia.com>
In-Reply-To: <20250508084434.1933069-1-cratiu@nvidia.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, andrew+netdev@lunn.ch, pabeni@redhat.com,
 jdamato@fastly.com, shuah@kernel.org, sdf@fomichev.me,
 almasrymina@google.com, saeedm@nvidia.com, tariqt@nvidia.com,
 dtatulea@nvidia.com, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 8 May 2025 11:44:34 +0300 you wrote:
> netdev_bind_rx takes ownership of the queue array passed as parameter
> and frees it, so a queue array buffer cannot be reused across multiple
> netdev_bind_rx calls.
> 
> This commit fixes that by always passing in a newly created queue array
> to all netdev_bind_rx calls in ncdevmem.
> 
> [...]

Here is the summary with links:
  - [net,v2] tests/ncdevmem: Fix double-free of queue array
    https://git.kernel.org/netdev/net/c/97c4e094a4b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



