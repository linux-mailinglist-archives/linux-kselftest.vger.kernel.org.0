Return-Path: <linux-kselftest+bounces-1427-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0804080A310
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Dec 2023 13:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84EBDB20B12
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Dec 2023 12:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9281C294;
	Fri,  8 Dec 2023 12:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0Mm75HZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79CE1BDFD;
	Fri,  8 Dec 2023 12:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54FDEC433C9;
	Fri,  8 Dec 2023 12:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702038026;
	bh=cL4G09FMM87FyW6qx9cfGc3SyCcZ7hGoUTZkQ/Jyhwc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o0Mm75HZaLPa7B8w7uwRvona9U6iSN0xdICbD73DfMBt4z5wdpMQoSqo+1HHXL/mc
	 2MmDHbwMAU0ioadIuu8Jh9Pwssnh7xm6ZLkpDSX+T0WMBEksUrPXHDhwZcLwBgjZAk
	 iXCZvxzH6VppHmSrxddnlq3pQHiuJnz6YzB0zmJSkIo4RiZsWMGnG7n1Ie8HoLGiqm
	 /ULFP3ItYamI40aTRHmHyh0GVKQ1DQbRs6of36zBkD+/5QZm+1IeinD74LmCwku6Tw
	 ccvhX121fSyo9kFmmad+obR53xkbSiyZb7EiUw2BocVuZyGWAElEmLsMjA3gWb5p8K
	 ye7BC0m7juWbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3B711C04E32;
	Fri,  8 Dec 2023 12:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/9] Convert net selftests to run in unique namespace
 (Part 2)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170203802623.6196.5009719464522054541.git-patchwork-notify@kernel.org>
Date: Fri, 08 Dec 2023 12:20:26 +0000
References: <20231206070801.1691247-1-liuhangbin@gmail.com>
In-Reply-To: <20231206070801.1691247-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, shuah@kernel.org, dsahern@kernel.org,
 linux-kselftest@vger.kernel.org, po-hsu.lin@canonical.com, gnault@redhat.com,
 petrm@nvidia.com, idosch@nvidia.com, razor@blackwall.org,
 vladimir@nikishkin.pw, roopa@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  6 Dec 2023 15:07:52 +0800 you wrote:
> Here is the 2nd part of converting net selftests to run in unique namespace.
> This part converts all bridge, vxlan, vrf tests.
> 
> Here is the part 1 link:
> https://lore.kernel.org/netdev/20231202020110.362433-1-liuhangbin@gmail.com
> 
> Hangbin Liu (9):
>   selftests/net: convert test_bridge_backup_port.sh to run it in unique
>     namespace
>   selftests/net: convert test_bridge_neigh_suppress.sh to run it in
>     unique namespace
>   selftests/net: convert test_vxlan_mdb.sh to run it in unique namespace
>   selftests/net: convert test_vxlan_nolocalbypass.sh to run it in unique
>     namespace
>   selftests/net: convert test_vxlan_under_vrf.sh to run it in unique
>     namespace
>   selftests/net: convert test_vxlan_vnifiltering.sh to run it in unique
>     namespace
>   selftests/net: convert vrf_route_leaking.sh to run it in unique
>     namespace
>   selftests/net: convert vrf_strict_mode_test.sh to run it in unique
>     namespace
>   selftests/net: convert vrf-xfrm-tests.sh to run it in unique namespace
> 
> [...]

Here is the summary with links:
  - [net-next,1/9] selftests/net: convert test_bridge_backup_port.sh to run it in unique namespace
    https://git.kernel.org/netdev/net-next/c/4624a78c18c6
  - [net-next,2/9] selftests/net: convert test_bridge_neigh_suppress.sh to run it in unique namespace
    https://git.kernel.org/netdev/net-next/c/312abe3d93a3
  - [net-next,3/9] selftests/net: convert test_vxlan_mdb.sh to run it in unique namespace
    https://git.kernel.org/netdev/net-next/c/a8258e64ca74
  - [net-next,4/9] selftests/net: convert test_vxlan_nolocalbypass.sh to run it in unique namespace
    https://git.kernel.org/netdev/net-next/c/d79e907b425d
  - [net-next,5/9] selftests/net: convert test_vxlan_under_vrf.sh to run it in unique namespace
    https://git.kernel.org/netdev/net-next/c/d6aab1f63297
  - [net-next,6/9] selftests/net: convert test_vxlan_vnifiltering.sh to run it in unique namespace
    https://git.kernel.org/netdev/net-next/c/5ece8371747d
  - [net-next,7/9] selftests/net: convert vrf_route_leaking.sh to run it in unique namespace
    https://git.kernel.org/netdev/net-next/c/bedc99abcaf8
  - [net-next,8/9] selftests/net: convert vrf_strict_mode_test.sh to run it in unique namespace
    https://git.kernel.org/netdev/net-next/c/51f64acbe36e
  - [net-next,9/9] selftests/net: convert vrf-xfrm-tests.sh to run it in unique namespace
    https://git.kernel.org/netdev/net-next/c/61b12ebe439a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



