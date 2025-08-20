Return-Path: <linux-kselftest+bounces-39343-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B7BB2D0DD
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 03:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17A0E7A6089
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 00:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01CE19CD1B;
	Wed, 20 Aug 2025 01:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sccLvxqI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BCE19CC02;
	Wed, 20 Aug 2025 01:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755651605; cv=none; b=tlgS0zkiTsQReoMe/8jatZ4m/OW1VbyjJaWqhdVC2bwoOLZX7iy+x9qbWqKVESQA/jkRkcT22WaLn8XK32k2R4K0sk7qadOVhHvpWiSXPlE7vIW8UYnvQRQeq4egB6xsldn0K7mr958tzPFwl+XqQKX5/1v786jDjz3wnCMaRbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755651605; c=relaxed/simple;
	bh=8b2DEMXa5mVs0tfQK3DZ6J5sGd3evGREuSdLGQHlRJU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oHe5B+i+A3hk0DeNVqk2PSfA12qiPpCLVWowQiDcQs3roSdq9ddNG5AtbZtjsCvtLB/CJY8eknaLlbwHczVzSUqbChhJf8DYJ/TRE2pUQJOxxNGJ2DG1cQupzA6SyMBbIAwf0ECuLpC/Hzpgr6o8OJHAlnt5FcD/9tmFnr5KjPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sccLvxqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6CCC4CEF1;
	Wed, 20 Aug 2025 01:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755651605;
	bh=8b2DEMXa5mVs0tfQK3DZ6J5sGd3evGREuSdLGQHlRJU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sccLvxqIPA8DfO+BHTcmGfqwJsR/2Kvz7K/aa8UrzwRuLeQN5+MS11+O4RV9jFU5D
	 KT22CHAwXYOK84AoC56+FfovxOS6lCAw6eAvCTmFcj61/NwpL4FmRxe6s+AjXDVXJC
	 ybouviZShFku8y/+3M2RaA406mO5TkF1c4vmUSx+RB9vFPuKbxm4chSKeMFyVC/ltK
	 om4ed+cVp8ZbJgY507MZeD8VTmRsjrpK+Y+dPCBtOAPPA5dXjc6Q+YQjoO8cMTKcQa
	 RwlAGRRRj0zCglnpK4Pr9JLh6yHezEXVDhcf5bz676ttizRKZe/vqBy4LeWqDY0w4N
	 kUYYJXUBege4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B8A383BF58;
	Wed, 20 Aug 2025 01:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: drv-net: ncdevmem: make
 configure_channels() support combined channels
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175565161498.3748899.11022758624325376674.git-patchwork-notify@kernel.org>
Date: Wed, 20 Aug 2025 01:00:14 +0000
References: <20250815231513.381652-1-kuba@kernel.org>
In-Reply-To: <20250815231513.381652-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 almasrymina@google.com, sdf@fomichev.me, joe@dama.to,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 15 Aug 2025 16:15:13 -0700 you wrote:
> ncdevmem tests that the kernel correctly rejects attempts
> to deactivate queues with MPs bound.
> 
> Make the configure_channels() test support combined channels.
> Currently it tries to set the queue counts to rx N tx N-1,
> which only makes sense for devices which have IRQs per ring
> type. Most modern devices used combined IRQs/channels with
> both Rx and Tx queues. Since the math is total Rx == combined+Rx
> setting Rx when combined is non-zero will be increasing the total
> queue count, not decreasing as the test intends.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: drv-net: ncdevmem: make configure_channels() support combined channels
    https://git.kernel.org/netdev/net-next/c/51992f99f068

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



