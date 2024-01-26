Return-Path: <linux-kselftest+bounces-3607-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3320283D155
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 01:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B86E2B23AC8
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 00:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4409315CC;
	Fri, 26 Jan 2024 00:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMqNmdLM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5C115BF;
	Fri, 26 Jan 2024 00:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706227828; cv=none; b=RRmawgBhWg+cBg0TGRNbmZQWnq3LCo6MBPqBe+qeyEeVKPF/uC+bP5utLq8trELsYFocflJ5o7N4UdGPHI2pLprTzTOT1IjYpf2g357KXTqm2uKVltk9WayLkjULYxlMd2uX8AGTQYzN2/oVweI+mAfkwEIpwVTf6ii2se7dG3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706227828; c=relaxed/simple;
	bh=g2kIsacExsFZNdtBmY6Ox9rhaUrKdhN0+ei5RS38wrA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FSleqcudlaR7AdBgn2A75NF1Ike3h6FSJ+u67pI5F8J98dSBA22QY0YcAfFZVX9C3QUmRgVXcBExWQkvaT9/pKgL42EtiINikmonQ2gmddXnyrN1JQ6YK+ZmAk6M2QoL5a68upHUry4qwbpUmcwEFT1raKRzwwFrsc7B6U7ziXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMqNmdLM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9350BC433A6;
	Fri, 26 Jan 2024 00:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706227827;
	bh=g2kIsacExsFZNdtBmY6Ox9rhaUrKdhN0+ei5RS38wrA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iMqNmdLMCKZaMYX5YHl6Ws0oTbPFQVzkyyGaFk2MTxfeoVsS1TqU/38CBMDwI6oIl
	 exnStWi7QdhOfyuTakJdg2uGQaAYkEevqqZWVnoyTY4PshccyyFC0MWhdsjsMj41av
	 qQWan7KhepQUxKQCqnAwRS0nVPxTWCSVVDCcPAxWXm+OH7AS8amHe90IM3Tf1GTWsX
	 GaO7HRhewLhVRv2HFtT8j4mGuivE3K2l9ODF1noYkjndK1Uruxx+mjJtwwtBd4sv/Q
	 E7wkWbaMzAZ+mKko9tOMKAmFkz1qX67PzH+/2LYoHwxUl0n2wDrNeZCvIUAosBezwV
	 DnJV5NW8BOTJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71E08DFF767;
	Fri, 26 Jan 2024 00:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] selftests: net: a few fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170622782746.1412.1033321023460506337.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jan 2024 00:10:27 +0000
References: <cover.1706131762.git.pabeni@redhat.com>
In-Reply-To: <cover.1706131762.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, shuah@kernel.org, willemb@google.com, lkarpins@redhat.com,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Jan 2024 22:33:19 +0100 you wrote:
> This series address self-tests failures for udp gro-related tests.
> 
> The first patch addresses the main problem I observe locally - the XDP
> program required by such tests, xdp_dummy, is currently build in the
> ebpf self-tests directory, not available if/when the user targets net
> only. Arguably is more a refactor than a fix, but still targeting net
> to hopefully
> 
> [...]

Here is the summary with links:
  - [net,1/3] selftests: net: remove dependency on ebpf tests
    https://git.kernel.org/netdev/net/c/98cb12eb52a7
  - [net,2/3] selftests: net: included needed helper in the install targets
    https://git.kernel.org/netdev/net/c/f5173fe3e13b
  - [net,3/3] selftests: net: explicitly wait for listener ready
    https://git.kernel.org/netdev/net/c/4acffb66630a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



