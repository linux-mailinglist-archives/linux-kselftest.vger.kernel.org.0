Return-Path: <linux-kselftest+bounces-41549-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3790AB58A6E
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 03:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E80834E27B3
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 01:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717881E0DE8;
	Tue, 16 Sep 2025 01:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLAERM0M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB9A186E40;
	Tue, 16 Sep 2025 01:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984408; cv=none; b=JcIwLeK3ATwH+anTkBrLTyDF+ya3WyKTvlfPnWHxNNQ1YdWGN0q4qYwj59Wu+yBkG47h1LJnpKgCqvkKpR/j2AtTcTxotnO5j95oECrdXcumxGcAq3EC/Tha6+r4qI3rq0zGlvS8aIcYJOCukpp/lUJWuT20NQwfBxZYXJ4yGGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984408; c=relaxed/simple;
	bh=Z88VASYVxdx6xG49v2u2rQo1F9hpTspTj9jbOjJ9CIc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mEXbGMAW9Dtj6YkrZttmwOIJJx5txkZQlis1ucbJGpsv91pYyOri6Dyx4nWQuRNLhXFrFvNfWN3aK7/7p20GuNW+Sx/4Xp/M4QZQ2l1Z8dApf4WeH0AufQxN6tWv8mfff5vkupstvPiVzAc9ZuTmkiNrdAs9GSp3rOAScgUX3xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLAERM0M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DFCC4CEF5;
	Tue, 16 Sep 2025 01:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984408;
	bh=Z88VASYVxdx6xG49v2u2rQo1F9hpTspTj9jbOjJ9CIc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XLAERM0MkaMMgfG8YuQ+ZPUONxMaOkXmp5+X3y+DcC5rLN9weV1kWV6gRK0MMPlqS
	 AYO/JggADaC1UHeBdQZ50VeyGwA0gYI851Pr68IMqxfvYMDU7C4WMNS0jK8Pqe3AQq
	 9Jah/tE452pXhGtsKYEjQJSvDHPIYaJ52c6V9tv1/36R9KmD+RJrwI6YnDAeKluGwR
	 oNrWw79Uq8/W9hKLdRJQbt+B7f0tnymow20gdgt5ZWiAS16oov5Vsi4iyC9tTUlZJ0
	 OiNdsuLyP0wRJnIJF0+FDkqX6vc3ZSt/pDFhu3BTbfwl6NUL9vxXY8F00NVxZjde3x
	 I1n5zCEriY1rQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDED39D0C18;
	Tue, 16 Sep 2025 01:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 net 1/2] bonding: set random address only when slaves
 already exist
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175798440950.551080.8670014333406837115.git-patchwork-notify@kernel.org>
Date: Tue, 16 Sep 2025 01:00:09 +0000
References: <20250910024336.400253-1-liuhangbin@gmail.com>
In-Reply-To: <20250910024336.400253-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 qren@redhat.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Sep 2025 02:43:34 +0000 you wrote:
> After commit 5c3bf6cba791 ("bonding: assign random address if device
> address is same as bond"), bonding will erroneously randomize the MAC
> address of the first interface added to the bond if fail_over_mac =
> follow.
> 
> Correct this by additionally testing for the bond being empty before
> randomizing the MAC.
> 
> [...]

Here is the summary with links:
  - [PATCHv2,net,1/2] bonding: set random address only when slaves already exist
    https://git.kernel.org/netdev/net/c/35ae4e86292e
  - [PATCHv2,net,2/2] selftests: bonding: add fail_over_mac testing
    https://git.kernel.org/netdev/net/c/71379e1c95af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



