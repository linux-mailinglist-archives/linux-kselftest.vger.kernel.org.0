Return-Path: <linux-kselftest+bounces-22961-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFFD9E7DF2
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Dec 2024 03:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B85E916E42F
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Dec 2024 02:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD52913665A;
	Sat,  7 Dec 2024 02:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJAGdEh+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3CF130AF6;
	Sat,  7 Dec 2024 02:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733536830; cv=none; b=CT5oD/jVjI4n5raUBt1fDVpQDXGMdrOxVasjIA1tSZGmKe1wgmRJNgd/sDPmi7Loq4dRXHCE5nhbODk7akemGHxWaV70OuVYsWp3fuiy0At/LvQungVLYzltxZF5WL8GnO6GY6crwQUwqF25QTkdDf9kZ/BReJBK2dnc37OiVpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733536830; c=relaxed/simple;
	bh=5ha6nkkbEeq3rO8ZskOBiwxD1BarT7Ii+yQ8VmzXvhM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Vj67oLwq7jyk31aavpwO09mUN87NK4LM8fTYYqLv6VwTa+3ZKbX0aHjCuMtOE3upzQ3Pck1iUAItLJWTcXkPZBzAmPVI3HtJzUdXU3l/qL5CGbppjtqZqU/mE66WAnrdbCszCnXcHrVFO+0bEcBaiaGQB8iCoFvUI5nKB2dvg/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJAGdEh+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F96C4CEDD;
	Sat,  7 Dec 2024 02:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733536830;
	bh=5ha6nkkbEeq3rO8ZskOBiwxD1BarT7Ii+yQ8VmzXvhM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LJAGdEh+3ahpU2rykg4v7l0fpLrOgFkydvyBi6pQd4ZKxHAd/KfCu+bjEaNjZTw57
	 X0Vwm3aSMB9DTsiw5dCuqaugPUCBngbfCnSjOnA2UFkq62YS+zeM9cYphabbGy1iom
	 i8MUs0qxqztpa3pscMEC+BXvnCih2ZulSV+B32nflnQvc2g+hjwIzGcJENbQVxMz1b
	 hK5Y4/ZjZCPRQNlfmKW9kfGvKLTdjVIxZAm8cxic8aNKexOVWbPGxJN6pRa4x8V11k
	 i0SouNaSZB5CBDvAzUQcoy39/CD6Iezs0GBNRd3RpUQyJabjHDQOwuoRsS/2BQ8Xwt
	 UaqWyQtHg9SrQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C2C380A95C;
	Sat,  7 Dec 2024 02:00:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] selftests: net: cleanup busy_poller.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173353684499.2872036.3731628087494846225.git-patchwork-notify@kernel.org>
Date: Sat, 07 Dec 2024 02:00:44 +0000
References: <20241204163239.294123-1-jdamato@fastly.com>
In-Reply-To: <20241204163239.294123-1-jdamato@fastly.com>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 kuba@kernel.org, mkarsten@uwaterloo.ca, stfomichev@gmail.com,
 davem@davemloft.net, horms@kernel.org, shuah@kernel.org, nathan@kernel.org,
 ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Dec 2024 16:32:39 +0000 you wrote:
> Fix various integer type conversions by using strtoull and a temporary
> variable which is bounds checked before being casted into the
> appropriate cfg_* variable for use by the test program.
> 
> While here:
>   - free the strdup'd cfg string for overall hygenie.
>   - initialize napi_id = 0 in setup_queue to avoid warnings on some
>     compilers.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] selftests: net: cleanup busy_poller.c
    https://git.kernel.org/netdev/net-next/c/48697bdfb65d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



