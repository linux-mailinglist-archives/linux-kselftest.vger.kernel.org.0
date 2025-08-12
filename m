Return-Path: <linux-kselftest+bounces-38774-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACBBB22752
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 14:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4BFE424B88
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 12:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BF7241695;
	Tue, 12 Aug 2025 12:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrjswFvg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8602023B627;
	Tue, 12 Aug 2025 12:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755002997; cv=none; b=izgtHVrkqJODRWLs5irbkQBJBy6xqM1Owx3PEoWm/0J4abhEKbwxxbK2komYAc0JrOCeeMAvU3jpOZIIW6gWUm7MoOyET315gNw93RBgL98MTLrcmgDVw6Fr8hZX14EYDxSsP/xi+4zFkwoY7UZOdG25EmUmPigMw9liJBMUkUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755002997; c=relaxed/simple;
	bh=Nk4whJ5SoSsOyfK2QcCuuglYmx020EoIg8mxiYrIlrY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M/929esgBY3N9Jxm5ZgaxjQ4AYCdDI++5QYsy1sAyvYrNa6VlWVAk64LV56n4F++62CnvRABCXFvePZvRGy9n9nRRW2fwQoh6npyP/4oJD+QSIeFxZzFcl3yhCSl99dYYl4LqEJlyi18KxmP5nZnaMVAno7t4VtutsmYZuu2H1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rrjswFvg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6041AC4CEF0;
	Tue, 12 Aug 2025 12:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755002997;
	bh=Nk4whJ5SoSsOyfK2QcCuuglYmx020EoIg8mxiYrIlrY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rrjswFvgsiFra5U09HZUe3KGJKS8HuUMBodHQxUk4ofbzeUgkJYmGKoRJo8qKImw/
	 FD+IRFMUJusGtDhb5O7VG8yOZzuQMW/3n6tp1XweTiYNrEGHY71pAHKJu6oE4nSZMi
	 pfKXvW1XpEaxbdNJHWwfQLFft26xqJm3kzBpn3+7pNOf1Q+jNs2k8oBQoPp57etlbP
	 IjgP7D/4rgTeyxc3IdMen/JnGBuylZif8fpjeE/HMDgRVkI0llWKpkXwHv27z+X9bZ
	 F3IEbhq1hLva7+rNx/3/VCbm+iZelMp1hjw1pSol3npZ3lurlGnAd38qo2L7X0zOJC
	 46d3NJqLGqSkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD6E383BF51;
	Tue, 12 Aug 2025 12:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/3] net: prevent deadlocks and mis-configuration
 with
 per-NAPI threaded config
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175500300950.2603176.10461428129643934621.git-patchwork-notify@kernel.org>
Date: Tue, 12 Aug 2025 12:50:09 +0000
References: <20250809001205.1147153-1-kuba@kernel.org>
In-Reply-To: <20250809001205.1147153-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 willemdebruijn.kernel@gmail.com, skhawaja@google.com, joe@dama.to,
 sdf@fomichev.me, shuah@kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  8 Aug 2025 17:12:02 -0700 you wrote:
> Running the test added with a recent fix on a driver with persistent
> NAPI config leads to a deadlock. The deadlock is fixed by patch 3,
> patch 2 is I think a more fundamental problem with the way we
> implemented the config.
> 
> I hope the fix makes sense, my own thinking is definitely colored
> by my preference (IOW how the per-queue config RFC was implemented).
> 
> [...]

Here is the summary with links:
  - [net,v2,1/3] selftests: drv-net: don't assume device has only 2 queues
    https://git.kernel.org/netdev/net/c/bda053d64457
  - [net,v2,2/3] net: update NAPI threaded config even for disabled NAPIs
    https://git.kernel.org/netdev/net/c/ccba9f6baa90
  - [net,v2,3/3] net: prevent deadlocks when enabling NAPIs with mixed kthread config
    https://git.kernel.org/netdev/net/c/b3fc08ab9a56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



