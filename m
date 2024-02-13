Return-Path: <linux-kselftest+bounces-4542-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4F58526DE
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 02:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B195D1C25486
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 01:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2822C28DCF;
	Tue, 13 Feb 2024 01:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAXRztj5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFB123BB;
	Tue, 13 Feb 2024 01:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707786626; cv=none; b=QXEt1grjWEQuHDIJ9M9TwwKI/QgQcil5BQV6TAaHAI+JmXiGQlnT5O3hqocG+lVi3KuFcPuYvIfFSgiCxB2PrIkE1f0hRzWjyPiyeTbtNVHsJF9b9o3NZou3jHCYNFUplDy0WlUUhmwMxwjs9G6Wpx4BE0XOTRtBYf/hZPj8ypI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707786626; c=relaxed/simple;
	bh=l2ZGGv/18ZoTqeFXJtdQeBC6J2Sob8IHyJGeCIkvq10=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nUatxaHqGeUkc+aOkGhSB3TwTBj5UVmp2TQRjyGKVqIu+x4srVCj/1+YIPgalRZikrY/2+h3r1FddbDaib40xQtsg1/XeB8eyWBbM+ru08ns7l5Sv6S1t634dZf5M4ro7eYr9OTw6T66R7MCV96q0NYJWCb+qXyEdQxRaFH4a90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pAXRztj5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6D99C43399;
	Tue, 13 Feb 2024 01:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707786625;
	bh=l2ZGGv/18ZoTqeFXJtdQeBC6J2Sob8IHyJGeCIkvq10=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pAXRztj58dBFe4cZLYjifdmkayS9xynM3JtWJG0voC0AD4O67VB1gS1BgiQXWZ09U
	 LiS7szWL3RlDeTGAD1YJqS1cEcXz/nSQCt6u8jC/eufbZb2QrjcIMzyxmWL5PgtBai
	 drYhN5SszBaK40hJ4q2y0xho55uSgWno5pidAT4Ix6i6xE7wnA6/F66C0IZR6u0/NO
	 PnIljJGxzQEh0PDKRnWiKsa2w8J2Wtf4VUtvS2LA3jWD+MGHG4SZBu5Y6de71jzUJO
	 JMBe6N84ZvunzaJkbrMxlYFKEyUq1Pj32wGPHD4Zv43gLfOTFDrjHHsOQNil7itiN+
	 mbocsIMXNPhaA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F39DC4166E;
	Tue, 13 Feb 2024 01:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: net: ip_local_port_range: define IPPROTO_MPTCP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170778662564.1111.991367114536257318.git-patchwork-notify@kernel.org>
Date: Tue, 13 Feb 2024 01:10:25 +0000
References: <20240209132512.254520-1-max@internet.ru>
In-Reply-To: <20240209132512.254520-1-max@internet.ru>
To: Maxim Galaganov <max@internet.ru>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, martineau@kernel.org,
 matttbe@kernel.org, lkft@linaro.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  9 Feb 2024 16:25:11 +0300 you wrote:
> Older glibc's netinet/in.h may leave IPPROTO_MPTCP undefined when
> building ip_local_port_range.c, that leads to "error: use of undeclared
> identifier 'IPPROTO_MPTCP'".
> 
> Define IPPROTO_MPTCP in such cases, just like in other MPTCP selftests.
> 
> Fixes: 122db5e3634b ("selftests/net: add MPTCP coverage for IP_LOCAL_PORT_RANGE")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/netdev/CA+G9fYvGO5q4o_Td_kyQgYieXWKw6ktMa-Q0sBu6S-0y3w2aEQ@mail.gmail.com/
> Signed-off-by: Maxim Galaganov <max@internet.ru>
> 
> [...]

Here is the summary with links:
  - [net] selftests: net: ip_local_port_range: define IPPROTO_MPTCP
    https://git.kernel.org/netdev/net/c/c2b3ec36b422

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



