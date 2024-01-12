Return-Path: <linux-kselftest+bounces-2881-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEEA82B8AC
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 01:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63C991C24D7D
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 00:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A00EBD;
	Fri, 12 Jan 2024 00:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s37k4LPo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C893A51;
	Fri, 12 Jan 2024 00:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2E97C43390;
	Fri, 12 Jan 2024 00:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705020025;
	bh=Pe69cV68ZbKdlXaX6tPFs9FZpMkP5r1bd8cAtLk6wMk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s37k4LPoYdLB59SirtXCv2+Z4D0gXhSOIZXopJafjyH+zKVGPyfHHgDYZwgsNqjfI
	 ObcqVhCTg6ZZgV9/08kqL7DOO4gssuh80z4cime8QVmOaeLW3Vi1w7VdJYGnSvUvB7
	 54fjJoi7aOs4YO8yrEwzwJj3vl69/MY/DfZth5bNXOhxUFqxpqq609JA6o6ZIAy82q
	 +YSbtRCOi/382G6P190Y1kBWhJvHN/tBbEpbcTfH+OVj6n//2F2hfxmqqruqgpnCOV
	 rpLhi6WSF6mRxf1e6biaMobJYqh7J3jVeB0I8KMdcWw8BoWch5Rt13TPjExbCxvtmh
	 XrstD7s+G0w2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CAC63D8C974;
	Fri, 12 Jan 2024 00:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/net/tcp-ao: Use LDLIBS instead of LDFLAGS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170502002582.17549.11892138227072738598.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jan 2024 00:40:25 +0000
References: <20240110-tcp_ao-selftests-makefile-v1-1-aa07d043f052@arista.com>
In-Reply-To: <20240110-tcp_ao-selftests-makefile-v1-1-aa07d043f052@arista.com>
To: Dmitry Safonov <dima@arista.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, lkp@intel.com,
 0x7f454c46@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Jan 2024 21:34:10 +0000 you wrote:
> The rules to link selftests are:
> 
> > $(OUTPUT)/%_ipv4: %.c
> > 	$(LINK.c) $^ $(LDLIBS) -o $@
> >
> > $(OUTPUT)/%_ipv6: %.c
> > 	$(LINK.c) -DIPV6_TEST $^ $(LDLIBS) -o $@
> 
> [...]

Here is the summary with links:
  - selftests/net/tcp-ao: Use LDLIBS instead of LDFLAGS
    https://git.kernel.org/netdev/net/c/e689a8769698

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



