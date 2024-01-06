Return-Path: <linux-kselftest+bounces-2676-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 314EA825E23
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jan 2024 04:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C58D28523E
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jan 2024 03:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A225615D2;
	Sat,  6 Jan 2024 03:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9iyPffV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8307015B3;
	Sat,  6 Jan 2024 03:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E07BBC433CA;
	Sat,  6 Jan 2024 03:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704512424;
	bh=2P77gXMExC4+ok/oXeXbJBfafiaFvn1P8vtxtltoOLU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f9iyPffVlE71ivuzm1pYw4gfDzxOAfmgNTVlZ4eJahH4OE5iKhgM+1fPEr5YY/IN+
	 8+/wPHM832OeL0pinziPfcsJosAPS3ASW5ZT2OzMjDUCQ+M5UGPE4v5hnswkG+GTV3
	 YRCj2lFeAjBRYxq4qLHrAfQI7ISjGK/h5VYi2Dl8TNY9KatKeIJ+JwC7UqkMjlVC27
	 Um+/FdJGFhwAjTTkeQJstwR181vjsnPXZDWBbNVPClwQPqWlKbit2f/TMsytfLxIei
	 SjN1nBKQHcdemPcMfdHoO1StaRwHr0wbnJvJHuc63wejGEPqsjipmFhsSca5krL7KF
	 vzSL6cPLaCluw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9DA1C4167E;
	Sat,  6 Jan 2024 03:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: forwarding: Avoid failures to source
 net/lib.sh
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170451242475.27125.13463385961455618313.git-patchwork-notify@kernel.org>
Date: Sat, 06 Jan 2024 03:40:24 +0000
References: <20240104141109.100672-1-bpoirier@nvidia.com>
In-Reply-To: <20240104141109.100672-1-bpoirier@nvidia.com>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, petrm@nvidia.com,
 razor@blackwall.org, liuhangbin@gmail.com, vladimir.oltean@nxp.com,
 idosch@nvidia.com, tobias@waldekranz.com, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Jan 2024 09:11:09 -0500 you wrote:
> The expression "source ../lib.sh" added to net/forwarding/lib.sh in commit
> 25ae948b4478 ("selftests/net: add lib.sh") does not work for tests outside
> net/forwarding which source net/forwarding/lib.sh (1). It also does not
> work in some cases where only a subset of tests are exported (2).
> 
> Avoid the problems mentioned above by replacing the faulty expression with
> a copy of the content from net/lib.sh which is used by files under
> net/forwarding.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: forwarding: Avoid failures to source net/lib.sh
    https://git.kernel.org/netdev/net-next/c/2114e83381d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



