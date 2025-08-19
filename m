Return-Path: <linux-kselftest+bounces-39308-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D51B2C632
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 15:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0823218881D1
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 13:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C728322DD7;
	Tue, 19 Aug 2025 13:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2v9mycW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E122EB840;
	Tue, 19 Aug 2025 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755611397; cv=none; b=WOHT2OzncoohcXVPIWEyNDjHQV9qWaRBlmvY1goGDkL3xwt02VCzpCRkRuRJAILHX5xrgsWxPoeKwicy3z06Kzf7JAtbdHv2vpSJ8M0XnPfotJ5kc5RM16PIMA+56svDk+xs2/sCtVvhht0NQIQ6vi4E1u+iX+icHaMGfRtGrbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755611397; c=relaxed/simple;
	bh=bwSJIpDMd+dk7uoh8ddEpgbwmP8HUHHCuZD8V9NxiXA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ir1pb2QgdIlkVJrCWQ2BQi9j0KghWthyso80DheQYzAKX2dEHtQJrHhQdzqRr4xSwUGUEVYIIQTpxylpSOpsZCSZZSSI1JePUSnT3c0oTH+D1f3UsRi9zwY81zRImDGbCDAnzb4h30WXncxHmiWUw176SBNvgRUQAl43PezQtYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2v9mycW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98FAEC4CEF1;
	Tue, 19 Aug 2025 13:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755611396;
	bh=bwSJIpDMd+dk7uoh8ddEpgbwmP8HUHHCuZD8V9NxiXA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E2v9mycW2KKBOj0CEW+N6HPpzt0rhcYA8g/SV1zXAGf5DmXjwYW7RWiyiP/cP/O4/
	 4xMb+vhAjWs/e0rt3P2oXv5AuCHMstRZrhyEireya5w8IC4eldFz73G5iORiJ6if53
	 ZqXqyHzWv+TbGXfEJk1PIPZLDSuyR9bmReO1KDNSNg90tl0rdiGumJSIO9MTRaJBf5
	 aTjJ5BB9O2vJ+LVCjesgF8hspOpJUxacBIbSoUI0bhEMGzUGgfCuYHM81bUNrOTp9h
	 nv8h6tkrRivJ2i+0ycAuvZig7MLv2eeFFt4RqZ7jW6uAnpPIfZHLQm/Xdf8tn5T3QT
	 ptXqr8p8UwL2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0B7383BF58;
	Tue, 19 Aug 2025 13:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: drv-net: test the napi init state
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175561140650.3559326.15526882228510657581.git-patchwork-notify@kernel.org>
Date: Tue, 19 Aug 2025 13:50:06 +0000
References: <20250815013314.2237512-1-kuba@kernel.org>
In-Reply-To: <20250815013314.2237512-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, joe@dama.to,
 shuah@kernel.org, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 14 Aug 2025 18:33:14 -0700 you wrote:
> Test that threaded state (in the persistent NAPI config) gets updated
> even when NAPI with given ID is not allocated at the time.
> 
> This test is validating commit ccba9f6baa90 ("net: update NAPI threaded
> config even for disabled NAPIs").
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: drv-net: test the napi init state
    https://git.kernel.org/netdev/net-next/c/0283b8f134e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



