Return-Path: <linux-kselftest+bounces-37902-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 465FAB0FE89
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 03:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 347961C24710
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 02:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACB118DF80;
	Thu, 24 Jul 2025 01:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrkglKWS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E466322083;
	Thu, 24 Jul 2025 01:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753322389; cv=none; b=moKYKrmuzfAR77GdyAyjkcnlBdpgIlI6koqedRfvNZB4Di0G/FYAUTiyUY2bwhQ/peHyXdqxoZ8Ua98uXIzvHoPP3m0GX99hkzxn8gOvuKqdrMhis7NUqSLHkKwcvmVccPTen2G3fkYICTGICdFzZqfaLVNJ3BQ2cDVlU7NOByw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753322389; c=relaxed/simple;
	bh=iq5CH8K8C8zcL3HR6D56HsxHbCaj+9J0/wtg7KuJsYI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=miySSVJKDC55AkahBdzVQp4Q1ZgSjM6DCnpe7QEbH1KIo6ExMUzLUtmwoF6Zfu4VX99LPgXO/3xPTlyINT8w+Xm/Ta14svXlhKL5ImSum+OkCvZGj9/+5RU0swWiO1Xys733ADxjooiNk0DS0vxrKJtxor3ErPi5qf9uTeSRgR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrkglKWS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CDB5C4CEE7;
	Thu, 24 Jul 2025 01:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753322388;
	bh=iq5CH8K8C8zcL3HR6D56HsxHbCaj+9J0/wtg7KuJsYI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lrkglKWSGbZ5UFjp297dKNAvgCT1GKRsyCuDQ4J7XBougrjjt6y2GZVPsQrlL/KWN
	 TIgHFMnUdz56hZ6791XQ4UrmR8hwugDA2lkCaX/f2HKZO/wHhuwP1s5kp2c92v72dT
	 05F3sTIrzt42wh0SIm6qvy9iIsh6ScdRgY3REvV9a73ZlgT2b1H4S5J959ESiZEBwY
	 6VYwZmJTloDujU5gcRNpchRapMkV8nAocJoHchcuAirlLdjzz7HQ4SLz1wDFUfFe3P
	 kHXKNtkezTb40I9xYrzytgWOom5/hw/OehNUxSFHYLhZlei3/t8ZWRck1juAWTQBrF
	 h+fFSiD2eFs+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDF3383BF4E;
	Thu, 24 Jul 2025 02:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] selftests: drv-net: wait for iperf client to stop
 sending
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175332240625.1844642.3670476932711392299.git-patchwork-notify@kernel.org>
Date: Thu, 24 Jul 2025 02:00:06 +0000
References: <20250722122655.3194442-1-noren@nvidia.com>
In-Reply-To: <20250722122655.3194442-1-noren@nvidia.com>
To: Nimrod Oren <noren@nvidia.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, willemb@google.com,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, gal@nvidia.com,
 cjubran@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Jul 2025 15:26:55 +0300 you wrote:
> A few packets may still be sent out during the termination of iperf
> processes. These late packets cause failures in rss_ctx.py when they
> arrive on queues expected to be empty.
> 
> Example failure observed:
> 
>   Check failed 2 != 0 traffic on inactive queues (context 1):
>     [0, 0, 1, 1, 386385, 397196, 0, 0, 0, 0, ...]
> 
> [...]

Here is the summary with links:
  - [net,v2] selftests: drv-net: wait for iperf client to stop sending
    https://git.kernel.org/netdev/net/c/869413825088

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



