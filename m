Return-Path: <linux-kselftest+bounces-8124-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F538A682E
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 12:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 049BA1C21141
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 10:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B38127B5D;
	Tue, 16 Apr 2024 10:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I82zqbij"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D14B127B53;
	Tue, 16 Apr 2024 10:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262831; cv=none; b=Nyop0+GTHwvZIkj8SknYQ/a4nYIxXUn/6S7MemN5CDZUXjEN6h5i+uHOMa+mHZBHo4xXQkQFsZp9EKt45Pakmkp+vcu93c6+/F/Njg2cA7oaDlguBYRFW51g5N6dxaPjIIiadu7MIypmyaqSFIuSa8+z5HKswSi3H0gQsaSz/0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262831; c=relaxed/simple;
	bh=ZWd4Fk7pDPaUXV93txZAyYs8FqljZ0m8jGhjscm7ARE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m32nIb/VgJVd0skL2YNmRg/+u7nkuzYNylRJWZyY5aJFFnbx7JPfDmywvCkHO7UE3rFUcB9LcSRG/KwmPro+A6/9Bnrjb0oo0QhnSYsk6bs/qvYihTP7Ji/t37YLK7UhS68JKqYi2GDyO+G8aBih1lqqAsnOEvCceEc2M8On0lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I82zqbij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3C16C2BD10;
	Tue, 16 Apr 2024 10:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713262830;
	bh=ZWd4Fk7pDPaUXV93txZAyYs8FqljZ0m8jGhjscm7ARE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I82zqbijscyJzp0DgjzBzLDx60ri1oSESIMAaCFv2zZURjuXlREXdbTQFfi1P5y9D
	 AwjPsQz9jf+rmm7fj3uuSQk70Q6VC7O6ZaE5qrQkPrXry4ZVf86Q/WVhihAdIHA5qY
	 tJ52XXYQXKu/mCaRZI9QhYN0H0pP1ot+VnaRa4pL5ufYE53/YqFvIuiyhFG9WB7Fns
	 qPLO/2+LESDNnsMg+X4tsaXi8tejpH6MWmnxIhQvprC0VXR3GIqLKU53vjUsDWJ2gp
	 WqGnx8iwBs4+nI+sG+VDkI/58nqp+Sbap4MoGWXHdEbM1jKtFvCsOLAwFvz9MCsmQE
	 UTiiRCqQ7XWAg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9722DC395EC;
	Tue, 16 Apr 2024 10:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/10] selftests: Assortment of fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171326283060.2031.5276766960350052331.git-patchwork-notify@kernel.org>
Date: Tue, 16 Apr 2024 10:20:30 +0000
References: <cover.1712940759.git.petrm@nvidia.com>
In-Reply-To: <cover.1712940759.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, idosch@nvidia.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 12 Apr 2024 19:03:03 +0200 you wrote:
> This is a loose follow-up to the Kernel CI patchset posted recently. It
> contains various fixes that were supposed to be part of said patchset, but
> didn't fit due to its size. The latter 4 patches were written independently
> of the CI effort, but again didn't fit in their intended patchsets.
> 
> - Patch #1 unifies code of two very similar looking functions, busywait()
>   and slowwait().
> 
> [...]

Here is the summary with links:
  - [net-next,01/10] selftests: net: Unify code of busywait() and slowwait()
    https://git.kernel.org/netdev/net-next/c/a4022a332f43
  - [net-next,02/10] selftests: forwarding: lib.sh: Validate NETIFS
    https://git.kernel.org/netdev/net-next/c/2291752fae3d
  - [net-next,03/10] selftests: forwarding: bail_on_lldpad() should SKIP
    https://git.kernel.org/netdev/net-next/c/492976136bb9
  - [net-next,04/10] selftests: drivers: hw: Fix ethtool_rmon
    https://git.kernel.org/netdev/net-next/c/042db639bf33
  - [net-next,05/10] selftests: drivers: hw: ethtool.sh: Adjust output
    https://git.kernel.org/netdev/net-next/c/f359d44a4e83
  - [net-next,06/10] selftests: drivers: hw: Include tc_common.sh in hw_stats_l3
    https://git.kernel.org/netdev/net-next/c/bfc42940682b
  - [net-next,07/10] selftests: mlxsw: ethtool_lanes: Wait for lanes parameter dump explicitly
    https://git.kernel.org/netdev/net-next/c/8d612ed4b554
  - [net-next,08/10] selftests: forwarding: router_mpath_nh: Add a diagram
    https://git.kernel.org/netdev/net-next/c/ba7d1e99b193
  - [net-next,09/10] selftests: forwarding: router_mpath_nh_res: Add a diagram
    https://git.kernel.org/netdev/net-next/c/b51a94b2d59d
  - [net-next,10/10] selftests: forwarding: router_nh: Add a diagram
    https://git.kernel.org/netdev/net-next/c/74ddac073cfe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



