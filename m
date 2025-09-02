Return-Path: <linux-kselftest+bounces-40661-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B121B410A9
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 01:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1C7C561E2E
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 23:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF8B271476;
	Tue,  2 Sep 2025 23:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUROLZMU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D241DE8BB;
	Tue,  2 Sep 2025 23:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756855202; cv=none; b=YCZly+e7XuSdGpchu2F9He8MNnpCwkiKwQXzlT0oiawq4FPz9/sVPWPC5zEPN8eTc5oMiXNM3ouEjn/gvyli35Hd20UxzrnUtuZ0aD3iIqiRgImaZpLqn0H/4XT7YLMSq4drX5k257dKWXi/TOfpRcSfrzQHD7C8XtS5JkIxemU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756855202; c=relaxed/simple;
	bh=1DJ+UxYOhm/OoZBjaAXpBZb+jZro24NfI7DF3OztwTI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rU1RcCJERS7yh0loGczNvVL6KunIIzt36bVII1D0Cg10TZ5q1D3nS0ySHIrMOfeRW3OECYmTJKp8pv2OESy6sKj1QWQnnCBZdjEw5LcVCkt7N54aUlHYXFe1yoyGldbNuPMyOal/0KNIkqMkONbHDksnrgDO1xpxhY+PdKHDBV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUROLZMU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7FDDC4CEED;
	Tue,  2 Sep 2025 23:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756855201;
	bh=1DJ+UxYOhm/OoZBjaAXpBZb+jZro24NfI7DF3OztwTI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FUROLZMUbskvt0CJ5qPMJumuDaU8fF9ZL4hGTXJexH/es1fuW6vwP7w6UE+AAcPCC
	 5W35w1UX5T0nXd7h0hwMSmGz/ee1UYNEcuOPMhuY7Fo4YZG+TqVxST3YMtxXDfQknp
	 eMcyoApHAHSUZ3WPrs97FzRwheqrxnBj29T75Z+xzjwEqAZJREkYyO3sPO/10t9cNN
	 gK9X5OPOsvkZWThy/oD65dvydny30FA/fAgUc5ZhiqBFnEOHT3YnPb26DECZIxem5J
	 7cB7KhkqeTVV0iD1Eq3U/blT5zmGg2wYVqNQkuIw5F80ICLkXur6nidVTjHu6v1Psn
	 kdbXASWOz8Tnw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E62383BF64;
	Tue,  2 Sep 2025 23:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] selftests: drv-net: adjust tests before
 defaulting to shell=False
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175685520725.465776.17556955800938973609.git-patchwork-notify@kernel.org>
Date: Tue, 02 Sep 2025 23:20:07 +0000
References: <20250830184317.696121-1-kuba@kernel.org>
In-Reply-To: <20250830184317.696121-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, joe@dama.to,
 leitao@debian.org, sdf@fomichev.me, linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 30 Aug 2025 11:43:16 -0700 you wrote:
> Clean up tests which expect shell=True without explicitly passing
> that param to cmd(). There seems to be only one such case, and
> in fact it's better converted to a direct write.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/drivers/net/napi_threaded.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net-next,1/2] selftests: drv-net: adjust tests before defaulting to shell=False
    https://git.kernel.org/netdev/net-next/c/c2e5108649ab
  - [net-next,2/2] selftests: net: py: don't default to shell=True
    https://git.kernel.org/netdev/net-next/c/bc1a767f695d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



