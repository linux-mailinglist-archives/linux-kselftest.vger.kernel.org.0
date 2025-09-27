Return-Path: <linux-kselftest+bounces-42517-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D96BA57CE
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 03:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A109628169
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 01:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353FF202F65;
	Sat, 27 Sep 2025 01:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vN8dFQ7h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFE01FFC6D;
	Sat, 27 Sep 2025 01:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758936049; cv=none; b=IHRF74lwJnmask4+NW7UCyJyGtkwM9LzJolu0o6VCqXWDf3M8okY5Arr934VUOICF+RdRshdtb+ipmy3m/9NQqRyWSEnO/KYdz+tAm3czh6BiDO9XjhS8ZeoBIXh24jWJTRLjGrgjGMg/Zg/3zQ4zGQX9Z1MF2NsLw9DvIiYQOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758936049; c=relaxed/simple;
	bh=YI/M+HsdXEwETaLU7IawZKln2r+BsOiS9wzV2k6cq8s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fk/U/S4i5055grn0X/Zl99ka7GOXBkD1wuNM0F+L5QwbkyrR+KhM+k9SHpkPQKV4yFn6SGv5lTHXFFXlze2X4/zM94ZZXGQq4J+hn5L0mKSX1KOhiCPMsbhdshryE+Rt/NDIsSL5r5jJCRbcYB/GeNBzSFXj+o+y/gvIJv86thA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vN8dFQ7h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE8AC4CEF4;
	Sat, 27 Sep 2025 01:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758936048;
	bh=YI/M+HsdXEwETaLU7IawZKln2r+BsOiS9wzV2k6cq8s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vN8dFQ7hACVkYxuig2+pz5x/I0RQyYbL+csPOxqKBCUnaZdV1dBjhGC74qgcin3Pb
	 wSYNua2DAgHRovs5OCmzBeBgr9c/e+tCc+hIMhR3gD3+lt8F9jwLrSpi3M3iXBqwhx
	 Eka47r948EmAke16qOzb4ZosmXFrnBzlVjTu4z8SuTvxt3zDqDl94voZp8neIeLvGr
	 +ceDpRi32y+is4a4y3gB2AO4GPIO7ePk75NCVwijBbURP+uLdHQgtZy0N+bOaxmaTr
	 l5QdLcSGHG6dCGZkEyBgACNVxGilg3RslfJAFSSuIqYu2gNYIAVm0SqW/QwOvFgj/j
	 ALY7ubOKNjx/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D8C39D0C3F;
	Sat, 27 Sep 2025 01:20:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/13] selftests: Mark auto-deferring functions
 clearly
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175893604399.115459.16652616612941464675.git-patchwork-notify@kernel.org>
Date: Sat, 27 Sep 2025 01:20:43 +0000
References: <cover.1758821127.git.petrm@nvidia.com>
In-Reply-To: <cover.1758821127.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, horms@kernel.org,
 idosch@nvidia.com, razor@blackwall.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 25 Sep 2025 19:31:43 +0200 you wrote:
> selftests/net/lib.sh contains a suite of iproute2 wrappers that
> automatically schedule the corresponding cleanup through defer. The fact
> they do so is however not immediately obvious, one needs to know which
> functions are handling the deferral behind the scenes, and which expect the
> caller to handle cleanups themselves.
> 
> A convention for these auto-deferring functions would help both writing and
> patch review. This patchset does so by marking these functions with an adf_
> prefix. We already have a few such functions: forwarding/lib.sh has
> adf_mcd_start() and a few selftests add private helpers that conform to
> this convention.
> 
> [...]

Here is the summary with links:
  - [net-next,01/13] selftests: net: lib: Rename ip_link_add() to adf_*
    https://git.kernel.org/netdev/net-next/c/191c4912f9c3
  - [net-next,02/13] selftests: net: lib: Rename ip_link_set_master() to adf_*
    https://git.kernel.org/netdev/net-next/c/c3cbd21fe18e
  - [net-next,03/13] selftests: net: lib: Rename ip_link_set_addr() to adf_*
    https://git.kernel.org/netdev/net-next/c/beb98a347762
  - [net-next,04/13] selftests: net: lib: Rename ip_link_set_up() to adf_*
    https://git.kernel.org/netdev/net-next/c/34d3f8b75e2b
  - [net-next,05/13] selftests: net: lib: Rename ip_link_set_down() to adf_*
    https://git.kernel.org/netdev/net-next/c/a55f9fb3432e
  - [net-next,06/13] selftests: net: lib: Rename ip_addr_add() to adf_*
    https://git.kernel.org/netdev/net-next/c/773603d6db30
  - [net-next,07/13] selftests: net: lib: Rename ip_route_add() to adf_*
    https://git.kernel.org/netdev/net-next/c/d85bcf6505d2
  - [net-next,08/13] selftests: net: lib: Rename bridge_vlan_add() to adf_*
    https://git.kernel.org/netdev/net-next/c/b628dfcd54cb
  - [net-next,09/13] selftests: net: vlan_bridge_binding: Rename dfr_set_binding_*() to adf_*
    https://git.kernel.org/netdev/net-next/c/14b72996ae80
  - [net-next,10/13] selftests: forwarding: lib: Add an autodefer variant of vrf_prepare()
    https://git.kernel.org/netdev/net-next/c/02aabe00b2e1
  - [net-next,11/13] selftests: forwarding: lib: Add an autodefer variant of simple_if_init()
    https://git.kernel.org/netdev/net-next/c/f53748d56d10
  - [net-next,12/13] selftests: forwarding: lib: Add an autodefer variant of forwarding_enable()
    https://git.kernel.org/netdev/net-next/c/040a6cbead5d
  - [net-next,13/13] selftests: forwarding: README: Mention defer, adf_
    https://git.kernel.org/netdev/net-next/c/fca6ff9191bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



