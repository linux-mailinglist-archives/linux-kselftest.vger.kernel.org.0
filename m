Return-Path: <linux-kselftest+bounces-4239-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAD684CBC1
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 14:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEFA128BC47
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 13:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE4F77628;
	Wed,  7 Feb 2024 13:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMukImZR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C224E76C9F;
	Wed,  7 Feb 2024 13:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707313228; cv=none; b=gElYO2MaZ+k1AVS9aef1Hd07Z5rQwjzJQ5tD6stKXszxhG/1eTSze0dhqkR8e7eXGj7Bd1X3q8zPBVXs9VkmyPJLS0aJIAzx5GgD1s5mQqPAl0YWtDAFP431+GWjeWdScBKJBTZjQWizEuUX5OM3f50a/o2dvH2FVkC1nuYUvnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707313228; c=relaxed/simple;
	bh=LvVlef94cjdkKJuYaffe22CzwkONG1ZlGJaA1L3iZas=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LcOfXlu3xN5L4CxgBrD0ri/LrwVEZbIYzEZSHHRmnynABfQhSgr9d10mGiHDy2sOhiS50UpkvRSQRQGNUm1K//g5iXpUbiZodlvJztTW3C7NXz829ZUrmoqvvm3lrLu9QguOJrqyNOf6dOwrF45s786cfLRe+w1JKXsHirBQZZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMukImZR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30743C43394;
	Wed,  7 Feb 2024 13:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707313228;
	bh=LvVlef94cjdkKJuYaffe22CzwkONG1ZlGJaA1L3iZas=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WMukImZRfAvhOZjCq7nsbNIgbXS3mBx09yivvJwt98NvGLbGe/3drkQiAEk6g4TmN
	 /g54DN+YHcF3OeODpbYwT1TSvf3UGnbJdiRQHY1BTWlVRDHLbhzvZj6rLDV2Xfy0oc
	 alE7FNx/0LrAzBbX1xdKX3PMTDHu4dGfv8EWnYHCtIrYZ5X7Id7TPi1Mu8fF54ppwX
	 aIStVW/YMwn9s3TSEzfJcQvSXkPrLo/yikyqZnyZRi6LjPdZQRiPCCDNAtOQKDY7Wu
	 DhfdaRV+o3eefXb1eI5BE4s6+xW1W0o0ohjCdVAaEia+wDcCEGfVP1fMeFw/s/4JbI
	 6GBWsvTlKl4gw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0A58DD8C978;
	Wed,  7 Feb 2024 13:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: cmsg_ipv6: repeat the exact packet
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170731322803.18214.2912029828173820399.git-patchwork-notify@kernel.org>
Date: Wed, 07 Feb 2024 13:40:28 +0000
References: <20240204165618.1489880-1-kuba@kernel.org>
In-Reply-To: <20240204165618.1489880-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun,  4 Feb 2024 08:56:18 -0800 you wrote:
> cmsg_ipv6 test requests tcpdump to capture 4 packets,
> and sends until tcpdump quits. Only the first packet
> is "real", however, and the rest are basic UDP packets.
> So if tcpdump doesn't start in time it will miss
> the real packet and only capture the UDP ones.
> 
> This makes the test fail on slow machine (no KVM or with
> debug enabled) 100% of the time, while it passes in fast
> environments.
> 
> [...]

Here is the summary with links:
  - [net] selftests: cmsg_ipv6: repeat the exact packet
    https://git.kernel.org/netdev/net/c/4b00d0c513da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



