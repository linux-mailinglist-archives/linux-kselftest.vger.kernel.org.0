Return-Path: <linux-kselftest+bounces-3920-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 686A98450A5
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 06:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1927628F0C8
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 05:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124413C487;
	Thu,  1 Feb 2024 05:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OImwbE51"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7DE3C478;
	Thu,  1 Feb 2024 05:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706764826; cv=none; b=Rt5ecl4es8gZF8OwWIlT9Mb+qX3AkKx4uCSoIrHu+VV4rDVJfGAWTzRrRI9ycRnBp5dyY9uRZE6H+RRHKtWn6359sfGc1b66sryOkZ2fyoWYcPQJ8oW4dCMfVt3PX+9dBn/c0J6paoQJRv5QbLLJNzYs/seR3YSLD5Z9PFlmjNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706764826; c=relaxed/simple;
	bh=Xrl1S/KSzdhstY3QZ086GSIfQy2B8O1HOVrY5nbEFUM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LsnZWwQ4syOpJWb7sRtPK3sBFhO90VN46FupD3I5VPymODocLg9VaKepYi9bei0tQP+nCxM3BNNjxDISwvnKbg8f/Q1aT8zNs1MuY1oDa7RfqJbsA63YXCuxFXdITaQ6Dgvb0wgv7VbISckbvs2S5OCa2NQO/UalCgTMzv1tv9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OImwbE51; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59DD1C43390;
	Thu,  1 Feb 2024 05:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706764825;
	bh=Xrl1S/KSzdhstY3QZ086GSIfQy2B8O1HOVrY5nbEFUM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OImwbE51iPhWYXkBQveZKo9t6PTimzG4k6mz4P3BYeb7Saar5X0bnvXB/haN4iH7n
	 l9rjnDeAgEejjocfeao1mK/30tZ6uSlebaW1+2S+gLHub6a/XTNXT4sumVD4lYD3Z4
	 0nzNypgHAbvkLeuomXGiu3f94jETjgt1xnwwRQCKhPSnk12BCZ2CZVA3udwaLXOdt3
	 fxfc8vkSieZqm/99hKOy70nWj0pHijHTm7PnRxQSuqpGwH9BssN7WsTvtRJnm7uQdF
	 BZrjNVn4W3UVnvy+vjyQkqxaSkQJIosIxrMuv/QViEXocxXZhuQ0hRo86BKvJ7/gk8
	 5HI4S1P02Svyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3ECFFDC99E5;
	Thu,  1 Feb 2024 05:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] selftests: net: a few pmtu.sh fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170676482525.24744.1244628672807352889.git-patchwork-notify@kernel.org>
Date: Thu, 01 Feb 2024 05:20:25 +0000
References: <cover.1706635101.git.pabeni@redhat.com>
In-Reply-To: <cover.1706635101.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, shuah@kernel.org, dsahern@kernel.org, gnault@redhat.com,
 vadim.fedorenko@linux.dev, fw@strlen.de, linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 30 Jan 2024 18:47:15 +0100 you wrote:
> This series try to address CI failures for the pmtu.sh tests. It
> does _not_ attempt to enable all the currently skipped cases, to
> avoid adding more entropy.
> 
> Tested with:
> 
> make -C tools/testing/selftests/ TARGETS=net install
> vng --build  --config tools/testing/selftests/net/config
> vng --run . --user root -- \
> 	./tools/testing/selftests/kselftest_install/run_kselftest.sh \
> 	-t net:pmtu.sh
> 
> [...]

Here is the summary with links:
  - [net,1/3] selftests: net: add missing config for pmtu.sh tests
    https://git.kernel.org/netdev/net/c/f7c25d8e17dd
  - [net,2/3] selftests: net: fix available tunnels detection
    https://git.kernel.org/netdev/net/c/e4e4b6d568d2
  - [net,3/3] selftests: net: don't access /dev/stdout in pmtu.sh
    https://git.kernel.org/netdev/net/c/bc0970d5ac1d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



