Return-Path: <linux-kselftest+bounces-6091-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B86875D71
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 06:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3FE31C21BC1
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 05:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D783A36103;
	Fri,  8 Mar 2024 05:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEDDpfAm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F692E84A;
	Fri,  8 Mar 2024 05:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709874641; cv=none; b=ZMHbo6CnvOWxIM5DOnRXNrkdOQSfoSeLCUzpGkYjRr7wafMuqf/RUokOpPnMsHoP2yW7ZN86/BoD7roDDtB1qgfxu7BJ429yaZ0MTbQbSY3jCYKZque9ngtE/WJ6XnLcHfbIgRbFs9sLtkslArI/UdgmDEsGRSHyTZbQGvmg43s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709874641; c=relaxed/simple;
	bh=qZ78qFcl7k/7Rui8/PriB7iG4Q9wj8DC4UpF5qtA0mw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nxV3A1QZyWNyCXkyvDWkk0HOrjfxwLlUDwBmyMbefIpRwDvywBoIu1h6GonSoj2TluJ4VNTKaRSSS4gCWTQNh3sduV2rJ1Kea566Dm6z8XuhcOzMY0ikufQPw3RE6cXnunpJMUUt6YQk6dM1N4WBTQgMBtAR3U2GyjixyKNtNE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEDDpfAm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08DDBC433C7;
	Fri,  8 Mar 2024 05:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709874641;
	bh=qZ78qFcl7k/7Rui8/PriB7iG4Q9wj8DC4UpF5qtA0mw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QEDDpfAmkMZuKRZyTm4mrVksO27WpBKsiFh7LsqkKIaKdDWI4GYmuufTV+KTvjtHi
	 Iea/e3A7Czdd8+Cv6KuffnXufXQHW0xo9FlHBvgHtsJzG3Ev4HXyt4bVbTqH1BXp7/
	 3efQ9pAyF4SCgdD8hlSDornNLIZs/4j218zkr2iwvlynjCinLSc74shbN3/8mt2h/q
	 RNLw5JwDDQknhnYSx9Xq7JuELdGBi/eLPKyiNlxXGTOWtCjtgxKwnykqsXL9CkKtoc
	 XA7c38Gy5KrlQ8bsmPhEOaumrkBSgCRBmS1JNmTDEpie1xenN1QrHn1u3PZjEINhXe
	 jwObybiUodWiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DE45BD84BDB;
	Fri,  8 Mar 2024 05:10:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/12] selftests: mptcp: share code and fix
 shellcheck warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170987464090.14945.15081894796160593216.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 05:10:40 +0000
References: <20240306-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v2-0-bc79e6e5e6a0@kernel.org>
In-Reply-To: <20240306-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v2-0-bc79e6e5e6a0@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shuah@kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, pablo@netfilter.org, tanggeliang@kylinos.cn

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 06 Mar 2024 10:42:49 +0100 you wrote:
> This series cleans MPTCP selftests code.
> 
> Patch 1 stops using 'iptables-legacy' if available, but uses 'iptables',
> which is likely 'iptables-nft' behind.
> 
> Patches 2, 4 and 6 move duplicated code to mptcp_lib.sh. Patch 3 is a
> preparation for patch 4, and patch 5 adds generic actions at the
> creation and deletion of netns.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/12] selftests: mptcp: stop forcing iptables-legacy
    https://git.kernel.org/netdev/net-next/c/7c2eac649054
  - [net-next,v2,02/12] selftests: mptcp: add mptcp_lib_check_tools helper
    https://git.kernel.org/netdev/net-next/c/3fb8c33ef4b9
  - [net-next,v2,03/12] selftests: mptcp: add local variables rndh
    https://git.kernel.org/netdev/net-next/c/4214aac14e51
  - [net-next,v2,04/12] selftests: mptcp: add mptcp_lib_ns_init/exit helpers
    https://git.kernel.org/netdev/net-next/c/3a0f9bed3c28
  - [net-next,v2,05/12] selftests: mptcp: more operations in ns_init/exit
    https://git.kernel.org/netdev/net-next/c/df8d3ba55b4f
  - [net-next,v2,06/12] selftests: mptcp: add mptcp_lib_events helper
    https://git.kernel.org/netdev/net-next/c/35bc143a8514
  - [net-next,v2,07/12] selftests: mptcp: diag: fix shellcheck warnings
    https://git.kernel.org/netdev/net-next/c/97633aa74d93
  - [net-next,v2,08/12] selftests: mptcp: connect: fix shellcheck warnings
    https://git.kernel.org/netdev/net-next/c/e3aae1098f10
  - [net-next,v2,09/12] selftests: mptcp: sockopt: fix shellcheck warnings
    https://git.kernel.org/netdev/net-next/c/5751c291349d
  - [net-next,v2,10/12] selftests: mptcp: pm netlink: fix shellcheck warnings
    https://git.kernel.org/netdev/net-next/c/21781b42f2f3
  - [net-next,v2,11/12] selftests: mptcp: simult flows: fix shellcheck warnings
    https://git.kernel.org/netdev/net-next/c/2aebd3579d90
  - [net-next,v2,12/12] selftests: userspace pm: avoid relaunching pm events
    https://git.kernel.org/netdev/net-next/c/c66fb480a330

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



