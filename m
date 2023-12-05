Return-Path: <linux-kselftest+bounces-1135-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BB7805429
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 13:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3FFF1C20ABE
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 12:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B2C5C065;
	Tue,  5 Dec 2023 12:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQZZwwqY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AE45C8E5;
	Tue,  5 Dec 2023 12:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E27FC433C7;
	Tue,  5 Dec 2023 12:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701779427;
	bh=i2NjnPcjqzZPfpDlTdN9FbnXNpUmLP4BhyFhxi61hTI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sQZZwwqYttz2wavoQ9qX/uZoPMoHoakl9mOSJ7GMyJk0jTlfnGNqin+aG6twhaw7F
	 ebR9+zzyxIL+O0rw80tEH8kilo4RIE/mKBXjWQMz+tEZRYaol8B8qsPLxrDlRfi3OY
	 Iw3TRTuGqT5nklQaPOoP8vzluPLNpYl0aqx3++FcdO+8fMQqwymNvC2I5xsNn3743J
	 fq0ha7qfYRni/9m9gdfUj2Xpsm3z791kNQDt3CKhQg+mHlrykdEk0CfrdMbbE29t12
	 QlEP2bvXGRa+cjtLCHTBqttjECdv0jRQPUULj+DZGzTp6V09vrRNz/ClkMggGrfbB1
	 g3n3fgEIdjvVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 45E65C40C5E;
	Tue,  5 Dec 2023 12:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv3 net-next 00/14] Conver net selftests to run in unique
 namespace (Part 1)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170177942728.20095.16452209434695767397.git-patchwork-notify@kernel.org>
Date: Tue, 05 Dec 2023 12:30:27 +0000
References: <20231202020110.362433-1-liuhangbin@gmail.com>
In-Reply-To: <20231202020110.362433-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, shuah@kernel.org, dsahern@kernel.org,
 linux-kselftest@vger.kernel.org, po-hsu.lin@canonical.com, gnault@redhat.com,
 petrm@nvidia.com, prestwoj@gmail.com, jhpark1013@gmail.com,
 idosch@nvidia.com, justin.iurman@uliege.be, lucien.xin@gmail.com,
 jchapman@katalix.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat,  2 Dec 2023 10:00:56 +0800 you wrote:
> As Guillaume pointed, many selftests create namespaces with very common
> names (like "client" or "server") or even (partially) run directly in init_net.
> This makes these tests prone to failure if another namespace with the same
> name already exists. It also makes it impossible to run several instances
> of these tests in parallel.
> 
> This patch set intend to conver all the net selftests to run in unique namespace,
> so we can update the selftest freamwork to run all tests in it's own namespace
> in parallel. After update, we only need to wait for the test which need
> longest time.
> 
> [...]

Here is the summary with links:
  - [PATCHv3,net-next,01/14] selftests/net: add lib.sh
    https://git.kernel.org/netdev/net-next/c/25ae948b4478
  - [PATCHv3,net-next,02/14] selftests/net: convert arp_ndisc_evict_nocarrier.sh to run it in unique namespace
    https://git.kernel.org/netdev/net-next/c/64227511ad57
  - [PATCHv3,net-next,03/14] selftests/net: specify the interface when do arping
    https://git.kernel.org/netdev/net-next/c/7f770d28f2e5
  - [PATCHv3,net-next,04/14] selftests/net: convert arp_ndisc_untracked_subnets.sh to run it in unique namespace
    https://git.kernel.org/netdev/net-next/c/3a0f3367006f
  - [PATCHv3,net-next,05/14] selftests/net: convert cmsg tests to make them run in unique namespace
    https://git.kernel.org/netdev/net-next/c/7c16d485fec5
  - [PATCHv3,net-next,06/14] selftests/net: convert drop_monitor_tests.sh to run it in unique namespace
    https://git.kernel.org/netdev/net-next/c/0d8b488792e4
  - [PATCHv3,net-next,07/14] selftests/net: convert traceroute.sh to run it in unique namespace
    https://git.kernel.org/netdev/net-next/c/baf37f213c88
  - [PATCHv3,net-next,08/14] selftests/net: convert icmp_redirect.sh to run it in unique namespace
    https://git.kernel.org/netdev/net-next/c/c1516b3563ac
  - [PATCHv3,net-next,09/14] sleftests/net: convert icmp.sh to run it in unique namespace
    https://git.kernel.org/netdev/net-next/c/80b74bd33421
  - [PATCHv3,net-next,10/14] selftests/net: convert ioam6.sh to run it in unique namespace
    https://git.kernel.org/netdev/net-next/c/2ab1ee827e97
  - [PATCHv3,net-next,11/14] selftests/net: convert l2tp.sh to run it in unique namespace
    https://git.kernel.org/netdev/net-next/c/4affb17c0d0e
  - [PATCHv3,net-next,12/14] selftests/net: convert ndisc_unsolicited_na_test.sh to run it in unique namespace
    https://git.kernel.org/netdev/net-next/c/3e05fc0c56bb
  - [PATCHv3,net-next,13/14] selftests/net: convert sctp_vrf.sh to run it in unique namespace
    https://git.kernel.org/netdev/net-next/c/90e271f65ee4
  - [PATCHv3,net-next,14/14] selftests/net: convert unicast_extensions.sh to run it in unique namespace
    https://git.kernel.org/netdev/net-next/c/0f4765d0b48d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



