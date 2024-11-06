Return-Path: <linux-kselftest+bounces-21541-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 094439BF1F2
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 16:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F4728573A
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 15:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386BF202F8A;
	Wed,  6 Nov 2024 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+yU+/IB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E65E190075;
	Wed,  6 Nov 2024 15:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730907857; cv=none; b=a7NsTpEYOwhC2W1fguOnrwAsdRcBHpzSVejl4QjGXwPXMHS9XcDQvY7d5c0N9FbarRIMTbiWbpbsr4PuEzWWwtUB+hkTTW7Qq5AvD+m8jt4Y8/jkK+D6U0TWRCQoYREGUJDloxDEOJXekGaT68gScn5HfyvEB5Ucc0YPVZ396rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730907857; c=relaxed/simple;
	bh=Bx4JkFHVZSmn8w135/s9Lbbn2e0M+Sl2v/1UF8aZwbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BXZQ5aKbeR8U22UsVMIHMUZbHe0FSgMAy7VhxCu9o24f3Pkxlg7StTk0RmH1McPrX3xUl2EGp7kfhvtZsqycjcFoIyQ9oxUZtY2T0XeWUoy/txFTSm+PJFhwnRMr4tPqj3Z+wdbMnOFopRvRodC/JSu3n8Eu2vicHsm6gK6gV5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+yU+/IB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A32BC4CEC6;
	Wed,  6 Nov 2024 15:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730907856;
	bh=Bx4JkFHVZSmn8w135/s9Lbbn2e0M+Sl2v/1UF8aZwbs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i+yU+/IBVwPw4XL+Pw0OVFG4Hf1tsRVAvA2R5xoY9JiAjKcKaR0FJDuswKRRLu02N
	 sB88X7BPQbHC64PDQuMZhoDTvIFZFUlsBzUWB61l/cVmJOM6O8dwHLGG/6k5Raaljf
	 wK2slo/i69vGaijJ1qb73fSKwPWyo3Fz1MUJbtu+O8iPmJp0L6GgZ8a0vkMUG6tWVG
	 VT+XKGzyw1SVFjXuxEc4UYGQmBIhfZFYyKcuHhY9Wx1SoYCNvdDsuiN0nF++sT0jN5
	 YNSGGyO1HbylbdGVIsgOIvCVtmKcVo/05mB4EZkpu8CpdsNO8e2goLRgH4kx2CK3eB
	 9jNXVoLV/UZuA==
Message-ID: <843b0fd9-0c71-423e-a1a3-bc10e6f987ec@kernel.org>
Date: Wed, 6 Nov 2024 08:44:15 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8] net: ipv4: Cache pmtu for all packet paths if
 multipath enabled
Content-Language: en-US
To: Vladimir Vdovin <deliran@verdict.gg>, netdev@vger.kernel.org,
 davem@davemloft.net, idosch@idosch.org
Cc: edumazet@google.com, linux-kselftest@vger.kernel.org, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, horms@kernel.org, gnault@redhat.com
References: <20241106133012.289861-1-deliran@verdict.gg>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20241106133012.289861-1-deliran@verdict.gg>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/24 6:30 AM, Vladimir Vdovin wrote:
> Check number of paths by fib_info_num_path(),
> and update_or_create_fnhe() for every path.
> Problem is that pmtu is cached only for the oif
> that has received icmp message "need to frag",
> other oifs will still try to use "default" iface mtu.
> 
> An example topology showing the problem:
> 
>                     |  host1
>                 +---------+
>                 |  dummy0 | 10.179.20.18/32  mtu9000
>                 +---------+
>         +-----------+----------------+
>     +---------+                     +---------+
>     | ens17f0 |  10.179.2.141/31    | ens17f1 |  10.179.2.13/31
>     +---------+                     +---------+
>         |    (all here have mtu 9000)    |
>     +------+                         +------+
>     | ro1  |  10.179.2.140/31        | ro2  |  10.179.2.12/31
>     +------+                         +------+
>         |                                |
> ---------+------------+-------------------+------
>                         |
>                     +-----+
>                     | ro3 | 10.10.10.10  mtu1500
>                     +-----+
>                         |
>     ========================================
>                 some networks
>     ========================================
>                         |
>                     +-----+
>                     | eth0| 10.10.30.30  mtu9000
>                     +-----+
>                         |  host2
> 
> host1 have enabled multipath and
> sysctl net.ipv4.fib_multipath_hash_policy = 1:
> 
> default proto static src 10.179.20.18
>         nexthop via 10.179.2.12 dev ens17f1 weight 1
>         nexthop via 10.179.2.140 dev ens17f0 weight 1
> 
> When host1 tries to do pmtud from 10.179.20.18/32 to host2,
> host1 receives at ens17f1 iface an icmp packet from ro3 that ro3 mtu=1500.
> And host1 caches it in nexthop exceptions cache.
> 
> Problem is that it is cached only for the iface that has received icmp,
> and there is no way that ro3 will send icmp msg to host1 via another path.
> 
> Host1 now have this routes to host2:
> 
> ip r g 10.10.30.30 sport 30000 dport 443
> 10.10.30.30 via 10.179.2.12 dev ens17f1 src 10.179.20.18 uid 0
>     cache expires 521sec mtu 1500
> 
> ip r g 10.10.30.30 sport 30033 dport 443
> 10.10.30.30 via 10.179.2.140 dev ens17f0 src 10.179.20.18 uid 0
>     cache
> 
> So when host1 tries again to reach host2 with mtu>1500,
> if packet flow is lucky enough to be hashed with oif=ens17f1 its ok,
> if oif=ens17f0 it blackholes and still gets icmp msgs from ro3 to ens17f1,
> until lucky day when ro3 will send it through another flow to ens17f0.
> 
> Signed-off-by: Vladimir Vdovin <deliran@verdict.gg>
> ---
> V8:
>   selftests in pmtu.sh:
>     - Change var names from "dummy" to "host"
>     - Fix errors caused by incorrect iface arguments pass
>     - Add src addr to setup_multipath_new
>     - Change multipath* func order
>     - Change route_get_dst_exception() && route_get_dst_pmtu_from_exception()
>       and arguments pass where they are used
>       as Ido suggested in https://lore.kernel.org/all/ZykH_fdcMBdFgXix@shredder/
> 
> V7:
>   selftest in pmtu.sh:
>     - add setup_multipath() with old and new nh tests
>     - add global "dummy_v4" addr variables
>     - add documentation
>     - remove dummy netdev usage in mp nh test
>     - remove useless sysctl opts in mp nh test
> 
> V6:
>   - make commit message cleaner
> 
> V5:
>   - make self test cleaner
> 
> V4:
>   - fix selftest, do route lookup before checking cached exceptions
> 
> V3:
>   - add selftest
>   - fix compile error
> 
> V2:
>   - fix fib_info_num_path parameter pass
> ---
>  net/ipv4/route.c                    |  13 +++
>  tools/testing/selftests/net/pmtu.sh | 119 ++++++++++++++++++++++++----
>  2 files changed, 115 insertions(+), 17 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


