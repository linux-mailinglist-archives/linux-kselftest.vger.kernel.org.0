Return-Path: <linux-kselftest+bounces-38813-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EE1B23DE7
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 03:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD055171216
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 01:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319511A0730;
	Wed, 13 Aug 2025 01:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5u/pW/6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABBD199223;
	Wed, 13 Aug 2025 01:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755049801; cv=none; b=DZUksdQwyBwbWx8TU722FU7CHkqsAEU/sg58girgqUylovHtNNzopK55ybVgN0kuh46nKn8hBACk6qcLZh6wNz074cYB+jhqtZixMkXmBHd7Ub5jTRCaBuGpgv4ENvtEOJItbTqIZqdicjkMEUkxo42bv1Fcz9Zvnvh8aVa4axs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755049801; c=relaxed/simple;
	bh=thS487217M/sNTjjEZeEmvhEmjMz1WQ6005iILVDRkw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ttDs62QD7RscWZZYWgO6N2zcYVVqaSfhfR4KWz/4rTzZCWDApqVOshZ71mw8I/ZeR8+WwytOpW+qZgEUwaz4MVvjUYhzv7jNgmthj6Po81y6LXm0AHXnDLXqbcHUw/NXAd6FRfcRpIwJX5LMKZ/U7th8zfQl4MRN3oxg5Gzgiyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5u/pW/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DCFC4CEF0;
	Wed, 13 Aug 2025 01:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755049800;
	bh=thS487217M/sNTjjEZeEmvhEmjMz1WQ6005iILVDRkw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a5u/pW/6rBfMqBgKKtSNbo7mMf3oGX/gzUbj+JhK8lO9Oah9WIpAz0YPC1soP81GY
	 Kwdq2qrCrLPK1ckWfXidz4wF1IaCQOitba/B/PO1t/T254Fr0frHyoPYqi5DcVvhUq
	 Nngbc8mBiYia54zBJq2t7wrZ632igfDLxyleS46UN+PERGbXjpBjzVcC+aBMyjEK/m
	 OGwYdFHNrSkroqD3jUBWVzP22TZTFwO03CQzG/dLNto9er0Jpt1R7moP9E5vMGa1eM
	 nz24FysbULae+MkO+twypq+bfz0MWIT3IESnjjQEYNQ51CqiKwl5S8zvvbwxLUSj06
	 dN2d0MpycmWAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E7739D0C2E;
	Wed, 13 Aug 2025 01:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] selftests: drv-net: improve zerocopy tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175504981224.2920300.10464807998196064238.git-patchwork-notify@kernel.org>
Date: Wed, 13 Aug 2025 01:50:12 +0000
References: <20250811231334.561137-1-kuba@kernel.org>
In-Reply-To: <20250811231334.561137-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 sdf@fomichev.me, almasrymina@google.com, noren@nvidia.com,
 linux-kselftest@vger.kernel.org, ap420073@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 11 Aug 2025 16:13:29 -0700 you wrote:
> A few tweaks to the devmem test to make it more "NIPA-compatible".
> We still need a fix to make sure that the test sets hds threshold
> to 0. Taehee is presumably already/still working on that:
> https://lore.kernel.org/20250702104249.1665034-1-ap420073@gmail.com
> so I'm not including my version.
> 
>   # ./tools/testing/selftests/drivers/net/hw/devmem.py
>   TAP version 13
>   1..3
>   ok 1 devmem.check_rx
>   ok 2 devmem.check_tx
>   ok 3 devmem.check_tx_chunks
>   # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] selftests: drv-net: add configs for zerocopy Rx
    https://git.kernel.org/netdev/net-next/c/27e5b560a86e
  - [net-next,2/5] selftests: drv-net: devmem: remove sudo from system() calls
    https://git.kernel.org/netdev/net-next/c/a94e9cf79cee
  - [net-next,3/5] selftests: drv-net: devmem: add / correct the IPv6 support
    https://git.kernel.org/netdev/net-next/c/424e96de3023
  - [net-next,4/5] selftests: net: terminate bkg() commands on exception
    https://git.kernel.org/netdev/net-next/c/6e9a12f85a75
  - [net-next,5/5] selftests: drv-net: devmem: flip the direction of Tx tests
    https://git.kernel.org/netdev/net-next/c/c378c497f3fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



