Return-Path: <linux-kselftest+bounces-41080-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A51CB50940
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 01:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 385843A53EA
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 23:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91E8287503;
	Tue,  9 Sep 2025 23:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYxyEDCM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9024B265614;
	Tue,  9 Sep 2025 23:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757460603; cv=none; b=CEoa7cIyT6J/x1VLxOCjTAG7ODWr0uJQivnC07SbR0GYJw2ZoMWt07ffVKBuToRnYJ79xBfihEcQdNjyXRtILepEbKm6rR/HjixeQ1xBNQ+ZSO9WG1sJgNDEw9dcM0FC9Qmj7vtF/MDlau7nkuITOYG5UyHld789oX5GRsLGSa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757460603; c=relaxed/simple;
	bh=4/MGIuFybo9yf04oPalxaEqnWmAnznYLG84Ew5PiGnk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WsVhvaR+onA4LbM85/eLr04eXdZa9oSEOI9FngN3SA9055h9eVtGTCTAz+jKolX4h5ZcfiwmJ85umoOS4YWu3Sw4ZoxoRyviniIwfJDZZ8WaH4/EESwISr9knmkNZnrO8HReGSFk/05dlR2ZAU4+KlnT52PNWSVhFH/QFZj0Ygg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYxyEDCM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F622C4CEF4;
	Tue,  9 Sep 2025 23:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757460603;
	bh=4/MGIuFybo9yf04oPalxaEqnWmAnznYLG84Ew5PiGnk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TYxyEDCMCCNJrnDflShIo3rZn17tIV4mq2Ds07O+gnFSZBlAfhSCHy5aqAYN/SFRn
	 3+CfJzJY1wEonp1DS6xshdEcYbx67LOL14uGpFJ5u1bad98RRVy52QU0OPgVC9Uj3a
	 iUStTbNuAbapd8cNQuppKtWg/Oi6Ri6AY0g865YfVvpOHetlvJfuBS9lN3NmXRQqVb
	 Fu6uYPPBxMclu/yN6n9uQYF4t/yOtWhmRXtzquVeOpzJDKfzwilXAkKpnDweCSDARh
	 wHypWBISN1vdGAJr/u634FvWg8oiKanF7cWbyateFACZ9TL8ikpItAW+MnVlZ9x4+8
	 x2+pVSq2eCGeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B57383BF69;
	Tue,  9 Sep 2025 23:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: net: speed up pmtu.sh by avoiding
 unnecessary cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175746060628.846036.1509076796270513891.git-patchwork-notify@kernel.org>
Date: Tue, 09 Sep 2025 23:30:06 +0000
References: <20250906214535.3204785-1-kuba@kernel.org>
In-Reply-To: <20250906214535.3204785-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  6 Sep 2025 14:45:35 -0700 you wrote:
> The pmtu test takes nearly an hour when run on a debug kernel
> (10min on a normal kernel, so the debug slow down is quite significant).
> NIPA tries to ensure all results are delivered by a certain deadline
> so this prevents it from retrying the test in case of a flake.
> 
> Looks like one of the slowest operations in the test is calling out
> to ./openvswitch/ovs-dpctl.py to remove potential leftover OvS interfaces.
> Check whether the interfaces exist in the first place in sysfs,
> since it can be done directly in bash it is very fast.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: net: speed up pmtu.sh by avoiding unnecessary cleanup
    https://git.kernel.org/netdev/net-next/c/1c0353a6df82

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



