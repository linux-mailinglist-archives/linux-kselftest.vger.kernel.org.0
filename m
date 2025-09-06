Return-Path: <linux-kselftest+bounces-40872-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2FFB467EF
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Sep 2025 03:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 246815C48E8
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Sep 2025 01:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C791547F2;
	Sat,  6 Sep 2025 01:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8KiCZFk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426571DA3D;
	Sat,  6 Sep 2025 01:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757121602; cv=none; b=RQ4l06xrMwyiLeXulNomrNjzMbmjikHj2sONoO3Jx3/PgamBA2TerHLDqOyLf4bji3gIzP6FMeQet+FYhdQAAkbclDfIpCbYNAzhfXZaam8DiKQsOumyieZZRUxSn1WkS8WTFqWjBy59G2kmKWWqrGm4/4WWp7xPqf2PE+a44r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757121602; c=relaxed/simple;
	bh=32sQ5kXXl6y6r6lYgWQ1wAl2U6Mq6Uzz2hHepwk6UGU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u4ci0Ar+/kLQOQoLsOTbeZndSbK8nbo2CVsYsVgWJ3iCE3rJ6hFwUuaBrfQKsMKZlLmdqd0m6JLRF5txhboWDP/l5yyRJ/ekw/chNSC4YixvqLx70871TIHL67YQKmhNrzillRH65gQl2U/ICdeg/PWjlt6zNSbaDUdL87GHvYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8KiCZFk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC30C4CEF1;
	Sat,  6 Sep 2025 01:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757121602;
	bh=32sQ5kXXl6y6r6lYgWQ1wAl2U6Mq6Uzz2hHepwk6UGU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J8KiCZFkvT9y2g6uCQPHgWUKeEjQEaRbVwJi6MI5xDXPP0gDfgxIVOq0CagLjy8gS
	 kSsnvmv9Wau8w7sW9J90f9ujqmfg09MERuNMZNtzbJIklqoYIIxgQqG3YuCHti5sTh
	 pDD4sRex+gi2yzzvgU8SmefFbqxC8Dj9pzWxgJfKfFrdqQPt673SBp9ohq/Y3n8a3r
	 lkRvcWrAX/j/ovBqEQ0mSXY2je79IHYkpT+X9ltBF0PiFqCBnXsKbdjfuZ+CUVkoP8
	 MjWjCMinX6etYNz5NNjFDNX2x8KU6u4JatkGqEbfJEbV58dYTviiYdBgS4/L08FRoL
	 CzkqGYKPvG0dA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id A019E383BF69;
	Sat,  6 Sep 2025 01:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: ncdevmem: don't retry EFAULT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175712160650.2737829.9065045152483294222.git-patchwork-notify@kernel.org>
Date: Sat, 06 Sep 2025 01:20:06 +0000
References: <20250904182710.1586473-1-sdf@fomichev.me>
In-Reply-To: <20250904182710.1586473-1-sdf@fomichev.me>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, shuah@kernel.org,
 almasrymina@google.com, joe@dama.to, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Sep 2025 11:27:10 -0700 you wrote:
> devmem test fails on NIPA. Most likely we get skb(s) with readable
> frags (why?) but the failure manifests as an OOM. The OOM happens
> because ncdevmem spams the following message:
> 
>   recvmsg ret=-1
>   recvmsg: Bad address
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: ncdevmem: don't retry EFAULT
    https://git.kernel.org/netdev/net-next/c/8c0b9ed2401b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



