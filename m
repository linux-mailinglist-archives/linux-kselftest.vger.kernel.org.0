Return-Path: <linux-kselftest+bounces-1993-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BCA814020
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 03:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAC021F211E3
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 02:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3809ADDBA;
	Fri, 15 Dec 2023 02:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKajEIRU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1616E10797;
	Fri, 15 Dec 2023 02:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81BDDC433C9;
	Fri, 15 Dec 2023 02:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702608027;
	bh=CuDA9y2CRS+wMsawD52ockrNDkEjR7Iar2UzEeNZzHs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eKajEIRUuIIxtU4Ng0xKzOWgCoRAH1jI2HvHFv2YkHFLP6DPmxUXjncmM3Jd+wXO8
	 ssVo91I4mwNhkyj2ICBPC/16Utf1XYkXTAmn8lcSdoULW/boFHHfmbzgvpgaT1yVN3
	 G08G8NJp2A2j/BDV8YK/u4pynvhMbgIa7bBOeVMpcFFcMbt/2DLylFIRrWglmtY83c
	 Etz3rlQHkCQoUUL8XOFYjJsPPVpijBj1PatvDFt8cK328e07eLh1kQwTFd7xtLVmyx
	 5q3QMtjBY938xUUXuG0RfugHtl2dqT0+6MK1/8pyXaIDcSvqEmIKNRYJR8DjBaGEyv
	 KzFREKUyhlzdg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6B1B4DD4EF9;
	Fri, 15 Dec 2023 02:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 net-next 00/13] Convert net selftests to run in unique
 namespace (Part 3)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170260802743.18795.8297377482881203534.git-patchwork-notify@kernel.org>
Date: Fri, 15 Dec 2023 02:40:27 +0000
References: <20231213060856.4030084-1-liuhangbin@gmail.com>
In-Reply-To: <20231213060856.4030084-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, shuah@kernel.org, dsahern@kernel.org,
 linux-kselftest@vger.kernel.org, po-hsu.lin@canonical.com,
 andrea.mayer@uniroma2.it, amcohen@nvidia.com, nicolas.dichtel@6wind.com,
 roopa@nvidia.com, idosch@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 Dec 2023 14:08:43 +0800 you wrote:
> Here is the 3rd part of converting net selftests to run in unique namespace.
> This part converts all srv6 and fib tests.
> 
> Note that patch 06 is a fix for testing fib_nexthop_multiprefix.
> 
> Here is the part 1 link:
> https://lore.kernel.org/netdev/20231202020110.362433-1-liuhangbin@gmail.com
> And part 2 link:
> https://lore.kernel.org/netdev/20231206070801.1691247-1-liuhangbin@gmail.com
> 
> [...]

Here is the summary with links:
  - [PATCHv2,net-next,01/13] selftests/net: add variable NS_LIST for lib.sh
    https://git.kernel.org/netdev/net-next/c/b6925b4ed57c
  - [PATCHv2,net-next,02/13] selftests/net: convert srv6_end_dt46_l3vpn_test.sh to run it in unique namespace
    https://git.kernel.org/netdev/net-next/c/59cac2efd378
  - [PATCHv2,net-next,03/13] selftests/net: convert srv6_end_dt4_l3vpn_test.sh to run it in unique namespace
    https://git.kernel.org/netdev/net-next/c/7b2d941c81bc
  - [PATCHv2,net-next,04/13] selftests/net: convert srv6_end_dt6_l3vpn_test.sh to run it in unique namespace
    https://git.kernel.org/netdev/net-next/c/792cd1dbc8a2
  - [PATCHv2,net-next,05/13] selftests/net: convert fcnal-test.sh to run it in unique namespace
    https://git.kernel.org/netdev/net-next/c/779283b7770f
  - [PATCHv2,net-next,06/13] selftests/net: fix grep checking for fib_nexthop_multiprefix
    https://git.kernel.org/netdev/net-next/c/a33e9da34704
  - [PATCHv2,net-next,07/13] selftests/net: convert fib_nexthop_multiprefix to run it in unique namespace
    https://git.kernel.org/netdev/net-next/c/5ae89fe43a4e
  - [PATCHv2,net-next,08/13] selftests/net: convert fib_nexthop_nongw.sh to run it in unique namespace
    https://git.kernel.org/netdev/net-next/c/d2168ea79234
  - [PATCHv2,net-next,09/13] selftests/net: convert fib_nexthops.sh to run it in unique namespace
    https://git.kernel.org/netdev/net-next/c/39333e31672c
  - [PATCHv2,net-next,10/13] selftests/net: convert fib-onlink-tests.sh to run it in unique namespace
    https://git.kernel.org/netdev/net-next/c/3a06833b2adc
  - [PATCHv2,net-next,11/13] selftests/net: convert fib_rule_tests.sh to run it in unique namespace
    https://git.kernel.org/netdev/net-next/c/6c0ee7b4d69d
  - [PATCHv2,net-next,12/13] selftests/net: convert fib_tests.sh to run it in unique namespace
    https://git.kernel.org/netdev/net-next/c/f6fc5b949911
  - [PATCHv2,net-next,13/13] selftests/net: convert fdb_flush.sh to run it in unique namespace
    https://git.kernel.org/netdev/net-next/c/b795db185e32

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



