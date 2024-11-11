Return-Path: <linux-kselftest+bounces-21829-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0589C48FB
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 23:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 509D7284158
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 22:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E90155A30;
	Mon, 11 Nov 2024 22:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCX0EexL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073F51B95B;
	Mon, 11 Nov 2024 22:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731363625; cv=none; b=Q4BWmE0XvsJPzlYeyyZPngbbGIjpGwoiKQqlMziWeKvQYsN4YAtnGXaKO08fWr8/p5sYFqEqnGl131tqP38AB39ZAnHHO1nmasSKeSXGRDDCAQoS6u2V9RNAH65/pnToIMvj6PhntWIERg8tL3uQZgVsxHcsrdTqZp8EZDu40gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731363625; c=relaxed/simple;
	bh=buaQcOhcqT1zG75US2aLARZ9JGOUYuvmMopOyRJZVDs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Bh1DGM96HZT//WZKelmLhpcqdTQng8JjEb0YRWH5bd0rMHj1fluDAqEI/D/m3JecXOgzkYDzyNirshw+46Hq1sjoQiAolbSl1riBIgC3cNsXgTOg7L2MBdIpxszL9e00t87s2csU4lbJ8t7/XYcapSGO/NFtAeRGME2NmpAPb1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCX0EexL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC002C4CECF;
	Mon, 11 Nov 2024 22:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731363624;
	bh=buaQcOhcqT1zG75US2aLARZ9JGOUYuvmMopOyRJZVDs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hCX0EexL52aEZs527ISOmjgai5gVIQpbI+vkGo+aL/aLUkLWVm27nK5R66eKZm0Lo
	 SPB//ppkL4V20RsP3uXQCTjdtjFtSjzvoivBx3chsQq4Wk6w816r9KEB6mMVrpBO04
	 noRpZkqrJpJL71hdQ9k6JlqyAdCe4t92g0pQ5I/A7DHL+M70Xf7CA8kEcITO6DyMZO
	 S1QxxwbEeI9l5RJUl1sXubyn9Wi85hRT6YqZtoPgu6jdZXo1nK8NiAB3lMI3PlWfy3
	 tLYSVDIbRCPY27PKt+NB70CZQ5hOMHIwtG2bDwepOFoifQEE2pN4gQLgdqZYP6WC1+
	 gyhRw9u3MOhTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADDD3809A80;
	Mon, 11 Nov 2024 22:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/8] macsec: inherit lower device's features and TSO
 limits when offloading
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173136363475.4189866.5123674671690080387.git-patchwork-notify@kernel.org>
Date: Mon, 11 Nov 2024 22:20:34 +0000
References: <cover.1730929545.git.sd@queasysnail.net>
In-Reply-To: <cover.1730929545.git.sd@queasysnail.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 Nov 2024 00:13:26 +0100 you wrote:
> When macsec is offloaded to a NIC, we can take advantage of some of
> its features, mainly TSO and checksumming. This increases performance
> significantly. Some features cannot be inherited, because they require
> additional ops that aren't provided by the macsec netdevice.
> 
> We also need to inherit TSO limits from the lower device, like
> VLAN/macvlan devices do.
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] netdevsim: add more hw_features
    https://git.kernel.org/netdev/net-next/c/494bd83bb519
  - [net-next,2/8] selftests: netdevsim: add a test checking ethtool features
    https://git.kernel.org/netdev/net-next/c/0189270117c3
  - [net-next,3/8] macsec: add some of the lower device's features when offloading
    https://git.kernel.org/netdev/net-next/c/bd97c29f7e9e
  - [net-next,4/8] macsec: clean up local variables in macsec_notify
    https://git.kernel.org/netdev/net-next/c/f29d24a2106a
  - [net-next,5/8] macsec: inherit lower device's TSO limits when offloading
    https://git.kernel.org/netdev/net-next/c/de187a390838
  - [net-next,6/8] selftests: move macsec offload tests from net/rtnetlink to drivers/net/netdvesim
    https://git.kernel.org/netdev/net-next/c/415b7cef1c73
  - [net-next,7/8] selftests: netdevsim: add test toggling macsec offload
    https://git.kernel.org/netdev/net-next/c/29084ea5d0e8
  - [net-next,8/8] selftests: netdevsim: add ethtool features to macsec offload tests
    https://git.kernel.org/netdev/net-next/c/0f8800eb67ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



