Return-Path: <linux-kselftest+bounces-38013-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7AEB126CB
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Jul 2025 00:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E3ED564183
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 22:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABC92609D4;
	Fri, 25 Jul 2025 22:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0lwcTR+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D361D2609C5;
	Fri, 25 Jul 2025 22:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753481847; cv=none; b=gB2z9C4c7JYmGeePYKJ6gK2Y/25YQrkKjNsVaay0Fua04KBmHpmDiOoWxP9oMKDsL5xdTGXornPizxbkSjlQnLREnb7iftBr7aXQOuubVU6Ndz42P4MIbWnn00tFONJJA1xltaqN2kS9Ev2Zc1C9dE5eT/YN6Z65tP0n15cU1Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753481847; c=relaxed/simple;
	bh=kaC7o/gIzpWspfu84JeA/waO2WFmJ19AtYM2TPHc+W4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JhoC1xEv58pDAOES/a3hvUE/JtHp3Md0I2ZZNZy6L4gTMk6/SdPD0IpZZX9c30cAVIhd+HIvzmxXV0Z1ZBd55OmfisVBICtaPs2ipo9l6ml53ovUbBEYfZQPXjyio2TBfsrRVWayept/qUr8yY36iEVF1o+fXA57QaeuUwt6auc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0lwcTR+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E35C4CEF8;
	Fri, 25 Jul 2025 22:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753481847;
	bh=kaC7o/gIzpWspfu84JeA/waO2WFmJ19AtYM2TPHc+W4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N0lwcTR+lh5n+gA3u1ficpm7dB+K6lC265MdUKyGDB53c1EnDAWeS2Vv5EfYoQN4i
	 ubGPpPBrF6kj6aDF1JO+YeQumlXXvtc2IGY0QVfZsGy/ZJpYpLZ3hywPKol4PrAmRG
	 6lzdiYnrqNKxwGpI8mN6zruCnvf0kIENqlwhCdWMsuj1jtuJjev0AdnP05KSG/XJyV
	 2o489JX3VPYNWYLnqET56w1tofM2I+03BK6opTW7WrC8tlhUA2GMavL8G7t3UW4FU2
	 Zyjfz+4x6TEbmyPJ3hn0/4k56z5qGZz/rtjw2NuN0O23CX3SaAjTqnslbY+Q55llix
	 9JtJJY68RQo3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C42383BF5B;
	Fri, 25 Jul 2025 22:17:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7] ipv6: add `force_forwarding` sysctl to enable
 per-interface forwarding
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175348186474.3265195.6030564834693464068.git-patchwork-notify@kernel.org>
Date: Fri, 25 Jul 2025 22:17:44 +0000
References: <20250722081847.132632-1-g.goller@proxmox.com>
In-Reply-To: <20250722081847.132632-1-g.goller@proxmox.com>
To: Gabriel Goller <g.goller@proxmox.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, dsahern@kernel.org,
 shuah@kernel.org, nicolas.dichtel@6wind.com, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Jul 2025 10:18:45 +0200 you wrote:
> It is currently impossible to enable ipv6 forwarding on a per-interface
> basis like in ipv4. To enable forwarding on an ipv6 interface we need to
> enable it on all interfaces and disable it on the other interfaces using
> a netfilter rule. This is especially cumbersome if you have lots of
> interfaces and only want to enable forwarding on a few. According to the
> sysctl docs [0] the `net.ipv6.conf.all.forwarding` enables forwarding
> for all interfaces, while the interface-specific
> `net.ipv6.conf.<interface>.forwarding` configures the interface
> Host/Router configuration.
> 
> [...]

Here is the summary with links:
  - [net-next,v7] ipv6: add `force_forwarding` sysctl to enable per-interface forwarding
    https://git.kernel.org/netdev/net-next/c/f24987ef6959

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



