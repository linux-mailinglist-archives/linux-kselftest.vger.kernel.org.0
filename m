Return-Path: <linux-kselftest+bounces-4717-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D4B8558E9
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 03:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CCACB22ABE
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 02:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8D11C02;
	Thu, 15 Feb 2024 02:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qEMtrqAh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86181864;
	Thu, 15 Feb 2024 02:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707963026; cv=none; b=jAG+PGx3d2ESikaBF7v7pQHjn5kIFRosRGT/PLl4EJwkYlSOWwTRZdozddsywS5Iwpv66jsbr6gW4BJvzgp53Bs9DRAftbOI2d+QCvEEPJ+bY6rqqAINzWkMwEYtNKC07G2lqNGy7q1D5Zikgc4LLh7g2Lvf5lRlmegncl1JCcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707963026; c=relaxed/simple;
	bh=TRpMoCvwfFbxonJFRlBlF9/A9UNFCFWTdjIEOaC59A8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RtXnl0UR9dzIxHA3uz/Zkxdl1CBCalmgiQHHGLMuCoXKVJRYM0naUZgvxTyxI8FUdvz6CAPRVtSOniKQT3LOit8GeBwS1SNEoltynZffZT+qmECDb7aYi3SdH3+GEbtKHyIrcbpmOsZjEgl/un3x4ThdVAmrMbRfFotrIKCitus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qEMtrqAh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54EE0C43394;
	Thu, 15 Feb 2024 02:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707963026;
	bh=TRpMoCvwfFbxonJFRlBlF9/A9UNFCFWTdjIEOaC59A8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qEMtrqAhJawIL0Xzk29yMX12P7BMc4yxeMOFiXTX0tOgVeff0hjXO7LZDI+09OIi0
	 zB8zmKy0Ohfs58bWd3YIjOZzZsueSGwHlFFMTvxONCHu6yqkVpuJZi03tdOlxmNl4L
	 Qiwvmel3m2MjbHp8/180lVx1h6bQQKbmrgkrnjPDkVyxjQkhZCS/wtS+47Em+UlxjZ
	 99od5+X3gDqZOcf9C3bIpcBY4n+eVXCOa3VPrI9VwqMWRV9+NIoTrNMgBuRxnlt808
	 LFgGKQD1UGYkI0/1c4EW+lTrEG9uE80sd8vwcT73lVM3sqee6V0Cq5luTq7V1CkvX5
	 TF80URCcrrNrQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 37D8BD84BC1;
	Thu, 15 Feb 2024 02:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: tls: increase the wait in
 poll_partial_rec_async
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170796302621.4642.14716044906778450294.git-patchwork-notify@kernel.org>
Date: Thu, 15 Feb 2024 02:10:26 +0000
References: <20240213142055.395564-1-kuba@kernel.org>
In-Reply-To: <20240213142055.395564-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Feb 2024 06:20:55 -0800 you wrote:
> Test runners on debug kernels occasionally fail with:
> 
>  # #  RUN           tls_err.13_aes_gcm.poll_partial_rec_async ...
>  # # tls.c:1883:poll_partial_rec_async:Expected poll(&pfd, 1, 5) (0) == 1 (1)
>  # # tls.c:1870:poll_partial_rec_async:Expected status (256) == 0 (0)
>  # # poll_partial_rec_async: Test failed at step #17
>  # #          FAIL  tls_err.13_aes_gcm.poll_partial_rec_async
>  # not ok 699 tls_err.13_aes_gcm.poll_partial_rec_async
>  # # FAILED: 698 / 699 tests passed.
> 
> [...]

Here is the summary with links:
  - [net] selftests: tls: increase the wait in poll_partial_rec_async
    https://git.kernel.org/netdev/net/c/2ec197fda25f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



