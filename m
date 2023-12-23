Return-Path: <linux-kselftest+bounces-2408-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F3481D0D0
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Dec 2023 01:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E62C284806
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Dec 2023 00:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0966384;
	Sat, 23 Dec 2023 00:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhm8+48V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A0F15D1;
	Sat, 23 Dec 2023 00:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0DC51C433C7;
	Sat, 23 Dec 2023 00:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703291426;
	bh=hgmAaiMzKBq1y5mt7jfkVG6RaLKmk6mxp8EN9a6nwEA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lhm8+48VF5q8akh34GtbsdCnts87FqB8lM6duk89LsJLBm1RJSYcmqfvnQkv77w1v
	 kebhQK8Twc4/kF1dYSrimDjvDUSJXcnyMGllS7oXySZcKBmtCZ/7c00GM0zc0pbDjH
	 ec/76+Xo0VmFSt5LBn+1eKZFGk6IyVldiznQjQk4OqyP5fHO34YWrsH3Y1QYRiA5Ii
	 KbDJ4xK3ZsTe9FP5pG0IAvU+FWEJsA5n52aFzDn79ObLEQE2913ffeKOdnec4JedE9
	 gbBRg3N7hHMAHHIye6gBqZI+w+tLS8/7hQwUVkgWdD3KoBuOpOJtkMAEvz86SnHwLP
	 HKsRGBoIsYfOQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E8822DD4EE0;
	Sat, 23 Dec 2023 00:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/8] Convert net selftests to run in unique namespace
 (last part)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170329142594.4887.13268245236275835692.git-patchwork-notify@kernel.org>
Date: Sat, 23 Dec 2023 00:30:25 +0000
References: <20231219094856.1740079-1-liuhangbin@gmail.com>
In-Reply-To: <20231219094856.1740079-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, shuah@kernel.org, dsahern@kernel.org,
 linux-kselftest@vger.kernel.org, po-hsu.lin@canonical.com, fw@strlen.de,
 kafai@fb.com, sbrivio@redhat.com, keescook@chromium.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 19 Dec 2023 17:48:48 +0800 you wrote:
> Here is the last part of converting net selftests to run in unique namespace.
> This part converts all left tests. After the conversion, we can run the net
> sleftests in parallel. e.g.
> 
>  # ./run_kselftest.sh -n -t net:reuseport_bpf
>  TAP version 13
>  1..1
>  # selftests: net: reuseport_bpf
>  ok 1 selftests: net: reuseport_bpf
>   mod 10...
>  # Socket 0: 0
>  # Socket 1: 1
>  ...
>  # Socket 4: 19
>  # Testing filter add without bind...
>  # SUCCESS
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] selftests/net: convert gre_gso.sh to run it in unique namespace
    https://git.kernel.org/netdev/net-next/c/b84c2faeb986
  - [net-next,2/8] selftests/net: convert netns-name.sh to run it in unique namespace
    https://git.kernel.org/netdev/net-next/c/f6476dedf08d
  - [net-next,3/8] selftests/net: convert rtnetlink.sh to run it in unique namespace
    https://git.kernel.org/netdev/net-next/c/d3b6b1116127
  - [net-next,4/8] selftests/net: convert stress_reuseport_listen.sh to run it in unique namespace
    https://git.kernel.org/netdev/net-next/c/098f1ce08bbc
  - [net-next,5/8] selftests/net: convert xfrm_policy.sh to run it in unique namespace
    https://git.kernel.org/netdev/net-next/c/976fd1fe4f58
  - [net-next,6/8] selftests/net: use unique netns name for setup_loopback.sh setup_veth.sh
    https://git.kernel.org/netdev/net-next/c/4416c5f53b43
  - [net-next,7/8] selftests/net: convert pmtu.sh to run it in unique namespace
    https://git.kernel.org/netdev/net-next/c/378f082eaf37
  - [net-next,8/8] kselftest/runner.sh: add netns support
    https://git.kernel.org/netdev/net-next/c/9d0b4ad82d61

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



