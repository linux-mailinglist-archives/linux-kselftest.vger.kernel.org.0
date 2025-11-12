Return-Path: <linux-kselftest+bounces-45370-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A895FC5049A
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 03:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD4934EA5E0
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 02:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1E5296BD2;
	Wed, 12 Nov 2025 02:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AotoBcY4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8592127F4F5;
	Wed, 12 Nov 2025 02:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762912844; cv=none; b=mT+dj3m9XaE9yy/3Q21XR4PDKr7EVAiZuETtrY16X2pVNEmcQqRmdEOGDCg15p+z23zfBCcLKnIOkPVPz3pJD1UGsjwy3CRQti5Nyh//49CTZxdf7tgOtET0w3iNTBhZatKLH9oxH1YdrUDFnaFACktlCFSRygtm77OxM+I3dJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762912844; c=relaxed/simple;
	bh=XdsqchhmGoFR89yJXh5BrLRPg9oo7WDQ7HA8Mm5p5ko=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tCjRz9Td9nx6Ol1BZlA8ftbiLYof3d3EQshe8VciZpOr7FQyjvA5oNc/vM+sIU4OBBO0mHWAc1q36xOGDefbMnFA/sxDxiZ9waHjDUpl8AitEQ5ugVXHNLIKlz4JQgp9DJz1mbUo0xh9vI8mOxV8Dm9pvEIafIu3dbn+upc+Kc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AotoBcY4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07324C113D0;
	Wed, 12 Nov 2025 02:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762912844;
	bh=XdsqchhmGoFR89yJXh5BrLRPg9oo7WDQ7HA8Mm5p5ko=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AotoBcY499NUpQYjMcABVOsQ8685hDeM2RO/dgqm/e3u5JQBO4DpoLlo2kqPVXrHw
	 IFEVg9gyeQRAokblZeFjricNzlSfbHwRnxApsjwDzOjOxBFAf4UpwomW7WCFvM1wXX
	 sCNZK2M5b8qlO2V7PzNHmNppNpsMCFUAp75fvHByidkY4bAFBhhkeox8HWrlZSbTSy
	 bPVOtymAa8B0RDdVZOvpM+Ura4L+RiI1rrgfqdO7Z763KrnA3epgy+R90XAkg/Vjmx
	 FwBDKgm/G/emaviaoTKqa7oh7WvUrydne/c4sA5z2W+vjwU1GhtktPRDTnTYgqcfZ+
	 0YhrITjdIPKDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EA8380DBCD;
	Wed, 12 Nov 2025 02:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/6] selftests: mptcp: join: fix some flaky tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176291281400.3632748.6310646970595796010.git-patchwork-notify@kernel.org>
Date: Wed, 12 Nov 2025 02:00:14 +0000
References: 
 <20251110-net-mptcp-sft-join-unstable-v1-0-a4332c714e10@kernel.org>
In-Reply-To: 
 <20251110-net-mptcp-sft-join-unstable-v1-0-a4332c714e10@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 10 Nov 2025 19:23:39 +0100 you wrote:
> When looking at the recent CI results on NIPA and MPTCP CIs, a few MPTCP
> Join tests are marked as unstable. Here are some fixes for that.
> 
> - Patch 1: a small fix for mptcp_connect.sh, printing a note as
>   initially intended. For >=v5.13.
> 
> - Patch 2: avoid unexpected reset when closing subflows. For >= 5.13.
> 
> [...]

Here is the summary with links:
  - [net,1/6] selftests: mptcp: connect: fix fallback note due to OoO
    https://git.kernel.org/netdev/net/c/63c643aa7b72
  - [net,2/6] selftests: mptcp: join: rm: set backup flag
    https://git.kernel.org/netdev/net/c/aea73bae662a
  - [net,3/6] selftests: mptcp: join: endpoints: longer transfer
    https://git.kernel.org/netdev/net/c/6457595db987
  - [net,4/6] selftests: mptcp: join: userspace: longer transfer
    https://git.kernel.org/netdev/net/c/290493078b96
  - [net,5/6] selftests: mptcp: connect: trunc: read all recv data
    https://git.kernel.org/netdev/net/c/ee79980f7a42
  - [net,6/6] selftests: mptcp: join: properly kill background tasks
    https://git.kernel.org/netdev/net/c/852b644acbce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



