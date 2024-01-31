Return-Path: <linux-kselftest+bounces-3822-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3523D843E36
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 12:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD76CB30D6D
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 11:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2406B6D1D4;
	Wed, 31 Jan 2024 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cijot6a+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC0C6BB26;
	Wed, 31 Jan 2024 11:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706698828; cv=none; b=OjP1AuRAkRnKS5I6jeipHvt/irnjxreomTr/OLHe6ISXMX1RriTP07r7cDIvyo6Lb6qW0eqEjaqPdSe5QRuL4o+tNcmLKGAjv1JufgqMfWT74MMXBQPvG+Fiqwf/BnDBmB3l3HPswii1krVrlXSIEj81ZELeWfinzkIa5jbAzt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706698828; c=relaxed/simple;
	bh=Y5Rf+FC7iGgTxlvyXBhegnW8n75HIKzG+gY7Q2Ogmb8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MXC63KVeoDdqmtXeNxL1SsZoA+uINGUQNgO7sFIRt5fFHSjXpmjDnDm5yCyAuG1kXo1l6w7VAn/fMNbxmIedxdyYtD7b5krzDSxJWVaYBgfQa16kSAZxko6shoEwopu+mBFqT68vMp0xmNGaZQDrzgG4wKvwIickS4tOXWpIILE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cijot6a+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83097C433F1;
	Wed, 31 Jan 2024 11:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706698827;
	bh=Y5Rf+FC7iGgTxlvyXBhegnW8n75HIKzG+gY7Q2Ogmb8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Cijot6a+FLLonzwrLbdJXUAKd3uQlk+gEzp/AQM6tqZ/IoqUypXS8Iu2hj/3u7Un6
	 dz2MJJa4DelUUtwloHDg3fX9y/lCRb+kBnK3eE4VdEsKiCISBabwJkP2hYScY0xDno
	 HJT6L03cLPQiqzHG4vthUSBBc01zTGtaBbTJZtVXt3RUoQWbjgtW1p5556Wy3Xfgmp
	 JAtNdeK9rYIEVd7UJQBlAngH6XXJZOIIswze4MraWbHQ6+NTbbBLGFvzX3XVTPMHcB
	 qML76DdpCe+aCFUimeo1595dzInZusV41OMDkOHtRFGzR7JBhqlPQ2gq9x7Iw17er9
	 nZHFZzTVFhMhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 65684DC99E5;
	Wed, 31 Jan 2024 11:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/6] selftests: Add TEST_INCLUDES directive and
 adjust tests to use it
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170669882741.1676.14282469125058737908.git-patchwork-notify@kernel.org>
Date: Wed, 31 Jan 2024 11:00:27 +0000
References: <20240126232123.769784-1-bpoirier@nvidia.com>
In-Reply-To: <20240126232123.769784-1-bpoirier@nvidia.com>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: netdev@vger.kernel.org, shuah@kernel.org, corbet@lwn.net,
 j.vosburgh@gmail.com, andy@greyhouse.net, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 petrm@nvidia.com, danieller@nvidia.com, razor@blackwall.org,
 idosch@nvidia.com, jnixdorf-oss@avm.de, dcaratti@redhat.com,
 tobias@waldekranz.com, zdoychev@maxlinear.com, liuhangbin@gmail.com,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 26 Jan 2024 18:21:17 -0500 you wrote:
> After commit 25ae948b4478 ("selftests/net: add lib.sh") but before commit
> 2114e83381d3 ("selftests: forwarding: Avoid failures to source
> net/lib.sh"), some net selftests encountered errors when they were being
> exported and run. This was because the new net/lib.sh was not exported
> along with the tests. The errors were crudely avoided by duplicating some
> content between net/lib.sh and net/forwarding/lib.sh in 2114e83381d3.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/6] selftests: Introduce Makefile variable to list shared bash scripts
    https://git.kernel.org/netdev/net-next/c/2a0683be5b4c
  - [net-next,v2,2/6] selftests: bonding: Add net/forwarding/lib.sh to TEST_INCLUDES
    https://git.kernel.org/netdev/net-next/c/6500780cffa7
  - [net-next,v2,3/6] selftests: team: Add shared library scripts to TEST_INCLUDES
    https://git.kernel.org/netdev/net-next/c/975b4a8b68ff
  - [net-next,v2,4/6] selftests: dsa: Replace test symlinks by wrapper script
    https://git.kernel.org/netdev/net-next/c/4a24560ad72f
  - [net-next,v2,5/6] selftests: forwarding: Redefine relative_path variable
    https://git.kernel.org/netdev/net-next/c/9f2af915916b
  - [net-next,v2,6/6] selftests: forwarding: Remove duplicated lib.sh content
    https://git.kernel.org/netdev/net-next/c/521ed1ce94bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



