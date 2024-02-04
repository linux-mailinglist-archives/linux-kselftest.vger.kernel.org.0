Return-Path: <linux-kselftest+bounces-4119-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA57848E22
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Feb 2024 14:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F23481C22746
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Feb 2024 13:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB63A225A4;
	Sun,  4 Feb 2024 13:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXaosBf1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C152B224DF;
	Sun,  4 Feb 2024 13:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707054026; cv=none; b=rGxuLk5jD6seNCO7s1PcwAJ7mi4bPpLSKo4ySr9sruNrirorG6nO0rD4nhTjDsxWd+ORUVJAZAOH+fG30i/c+0vlylY+X44YlMrMRIbi8/cV5Gi1YFcs9AGlCc4iNJz4UkM6IIzPC4qAusCi7fjsFUyH+eCO3ZVVtFk/A0JWmnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707054026; c=relaxed/simple;
	bh=OJjL0eHrtB3aaiQK3MnXRIjcVA/y6SezjGXj0aLGYJY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ITFMd0tdvLx0xSMl0g2S6nyELr664IfJ5atTL7XRfpS9ze4B+olGnP8B8hwZbsvLUK7LUfBKHSINee0yqofblXVtJzL66sSEMRsLtUA0PIg0TxspQQVEHZCRv7+5lQXxPVqExeuGwgOmMgIwRKJt5Eoz+ucLRFYVRLympUa4SIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXaosBf1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 641C8C43609;
	Sun,  4 Feb 2024 13:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707054026;
	bh=OJjL0eHrtB3aaiQK3MnXRIjcVA/y6SezjGXj0aLGYJY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WXaosBf1Oe6aEN0iK9D/hmV2qpokGxJUwI6+N8HwpR3TLRzDT4L2xp6sp4DU19yF3
	 D9JP7JegzrUiRLZundstUsmHOgDRpGH5ObDKU3AgGR/dSCVDibkdk+vl+zuWOEB6nv
	 ylfTXkgRbzbp/FgvQWH+GtEN0FD6dwNe3xsb35Ek8tc7RIUspXFyuIenthjh7P/Jfs
	 Ku714ycxyn8Zen9dT5S98v8xCInXZVzn9o+Osd66xAjVINdQVTHzHzV8U099PyCbaF
	 R8vD/5eRdemWEMjZGBbnVWqe5/3QSehPyYGssJ22xz3ED4XxyknFBf91+Y5gjW0xdY
	 vK3UhPRBMV8UA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4B197E2F2EF;
	Sun,  4 Feb 2024 13:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: netdevsim: stop using ifconfig
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170705402630.16095.15168853521199745138.git-patchwork-notify@kernel.org>
Date: Sun, 04 Feb 2024 13:40:26 +0000
References: <20240202001154.414386-1-kuba@kernel.org>
In-Reply-To: <20240202001154.414386-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, horms@kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  1 Feb 2024 16:11:54 -0800 you wrote:
> Paolo points out that ifconfig is legacy and we should not use it.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: horms@kernel.org
> CC: linux-kselftest@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: netdevsim: stop using ifconfig
    https://git.kernel.org/netdev/net-next/c/e35ba5811714

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



