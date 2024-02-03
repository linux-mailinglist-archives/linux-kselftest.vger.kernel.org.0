Return-Path: <linux-kselftest+bounces-4072-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B799B8483FA
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Feb 2024 06:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72DF92888C9
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Feb 2024 05:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9017B10976;
	Sat,  3 Feb 2024 05:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/Xa6Svi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E6710A1D;
	Sat,  3 Feb 2024 05:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706937645; cv=none; b=eNXvZVMLN8fxElgqkRO1BzydvJo2rtz3CQsqF4df++R6ePS8drmEtidm5hrvfvIoLsdF3mmEOJD7d/ivTa/RL7qtHlrK1DQXOcwC2olykNYs+V5EmHPsEA59BlOdNWlIWYJbL7xOvqnRQxWOoukImhoiehDZjusfloO32H+weCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706937645; c=relaxed/simple;
	bh=pqbZTAs+vlWGPLgMDqzlV7FAZwrItEBXoml8WxxL6kk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=utQUvXyuz5NKphwoi8Zo+hrxKgXQTZ5jcWG/LV7T7nCz9b8LllR7L1BP4LtooY72OxhmHu83vtoJqxr2rLGswFXJJoH9kMrsxOfQaJZ7XCsx3WN/RtfYgbSzRLElYhuiqAgPEonuycMLBMm/ghXwp4O7boZiTcIaT2zByMp4GlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/Xa6Svi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7E97C433F1;
	Sat,  3 Feb 2024 05:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706937644;
	bh=pqbZTAs+vlWGPLgMDqzlV7FAZwrItEBXoml8WxxL6kk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h/Xa6SvilFWmqtE+r6NQnIepvtx0h7ItZ/0k9dKlXdAi3f8RC5KL5MTaYFC3lQhtW
	 Cr/9S+wUjhqACW7QQRwkKQIibb7YDL6fLOAC1XPJOmzxfSastGMi1tfQ5x2LCODg+n
	 +6bmd3NwvG7u69ZcU/nl7NqCMLwdpzVMkhfALndrOHMgCiYoh2MLXSckHLVKO61R8L
	 /H8/9cCqLC7h7AwLU39wAFyOmpZw+AOMLTR495Dy0dkJB22QBMv25fRZe70iUF3HWy
	 gO+hT8dsoBTWFZtS0DTwQfjHbmyapUC9pGVzl6uMq5uWUmQjuChj8UIRQdi1XeIiIg
	 u79bifBZBPZkA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BFA98D8C970;
	Sat,  3 Feb 2024 05:20:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/4] selftests: net: more fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170693764478.3207.14841087288211010690.git-patchwork-notify@kernel.org>
Date: Sat, 03 Feb 2024 05:20:44 +0000
References: <cover.1706812005.git.pabeni@redhat.com>
In-Reply-To: <cover.1706812005.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, shuah@kernel.org, willemb@google.com, fw@strlen.de,
 dsahern@gmail.com, linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  1 Feb 2024 19:42:37 +0100 you wrote:
> Another small bunch of fixes, addressing issues outlined by the
> netdev CI.
> 
> The first 2 patches are just rebased.
> 
> The following 2 are new fixes, for even more problems that surfaced
> meanwhile.
> 
> [...]

Here is the summary with links:
  - [v2,net,1/4] selftests: net: cut more slack for gro fwd tests.
    https://git.kernel.org/netdev/net/c/cb9f4a30fb85
  - [v2,net,2/4] selftests: net: fix setup_ns usage in rtnetlink.sh
    https://git.kernel.org/netdev/net/c/d75df7526477
  - [v2,net,3/4] selftests: net: fix tcp listener handling in pmtu.sh
    https://git.kernel.org/netdev/net/c/e71e016ad0f6
  - [v2,net,4/4] selftests: net: avoid just another constant wait
    https://git.kernel.org/netdev/net/c/691bb4e49c98

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



