Return-Path: <linux-kselftest+bounces-41039-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C26CB4A7D9
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 11:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 408A27A7897
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 09:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F935284B35;
	Tue,  9 Sep 2025 09:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojklGqLn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE75278772;
	Tue,  9 Sep 2025 09:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409606; cv=none; b=PMC1IogAq1Wf4kj9ytHPkDbfDm4rniUJCGQM6zInU5IzjV1hQJEjdn0VhnbVpcYs1yEQFllss735cI34yAuQFH9SHHf9EVrAaU+vApV27YevZBxXYHJefoiQ49otdFvJgDFHgkhjtP4DGKQhNj5rR+P5VlbPhwUXAHJ/SXOg/fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409606; c=relaxed/simple;
	bh=WfssuOqMXQC41TqaU9sewZ6QWPeMMfn7YgAYo5COuLg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NP5jq0/EzK3mnj31E4CUokfBmSh+obmCAbh9UtNVI25kuefzcH1aufUy5LiwUqsnhRkmhCOiMLuo/QGXmGwGZnOf/4Lq8IVLqN6kG6QMPwTg7l9ETVW6d06QKMfq8okhaxHtQ4xa7q2k9jBaV+iNQh9lwezLKAIkEeVWiFsL05k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojklGqLn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F306C4CEFA;
	Tue,  9 Sep 2025 09:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757409606;
	bh=WfssuOqMXQC41TqaU9sewZ6QWPeMMfn7YgAYo5COuLg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ojklGqLnOKtld3Vibv2Ryw/OuaXWvtntd8XJaCf9ubGxvRuofsDscF+CFuO8johc5
	 OCu/CiTShbbHqgeTt2MK2Ke/QqLIZ2BeQXPdDrdStWgXUtcj9eswhGJBrUVOOS9bQg
	 4alYG1/VyrJ+9y5jeXYKolIw6wd7m+QjOPxTtk7vtpDJcnyy0sD0cUL5viesfbt1Pj
	 nvjomj3kxysy7O20WAFEOMJaNA4ZPqOLDVmyi7OUz7IlOA9nNMOaANZiQIS1gm0/wB
	 8OWco3T3I2Tuyh1wWYPfYJ/eTJtl/kTEOMMCW3mJV+Vc/vhBM8m2bxB7QvWinlaTY9
	 qr2By2ghM41Mw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD37383BF69;
	Tue,  9 Sep 2025 09:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv5 net-next 0/3] bonding: support aggregator selection
 based on
 port priority
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175740960963.593749.1942861170014079998.git-patchwork-notify@kernel.org>
Date: Tue, 09 Sep 2025 09:20:09 +0000
References: <20250902064501.360822-1-liuhangbin@gmail.com>
In-Reply-To: <20250902064501.360822-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, corbet@lwn.net, petrm@nvidia.com,
 amcohen@nvidia.com, vladimir.oltean@nxp.com, stephen@networkplumber.org,
 dsahern@gmail.com, jonas.gorski@gmail.com, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  2 Sep 2025 06:44:58 +0000 you wrote:
> This patchset introduces a new per-port bonding option: `ad_actor_port_prio`.
> 
> It allows users to configure the actor's port priority, which can then be used
> by the bonding driver for aggregator selection based on port priority.
> 
> This provides finer control over LACP aggregator choice, especially in setups
> with multiple eligible aggregators over 2 switches.
> 
> [...]

Here is the summary with links:
  - [PATCHv5,net-next,1/3] bonding: add support for per-port LACP actor priority
    https://git.kernel.org/netdev/net-next/c/6b6dc81ee7e8
  - [PATCHv5,net-next,2/3] bonding: support aggregator selection based on port priority
    https://git.kernel.org/netdev/net-next/c/e5a6643435fa
  - [PATCHv5,net-next,3/3] selftests: bonding: add test for LACP actor port priority
    https://git.kernel.org/netdev/net-next/c/c2377f1763e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



