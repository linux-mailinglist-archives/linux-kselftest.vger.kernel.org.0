Return-Path: <linux-kselftest+bounces-23913-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9142AA01608
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Jan 2025 18:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FBC71637BA
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Jan 2025 17:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1171C5F31;
	Sat,  4 Jan 2025 17:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POtR+4Ov"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A461CCB4B;
	Sat,  4 Jan 2025 17:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736010012; cv=none; b=mypQl0V9ITOg7yQ3gSLLuzpkSCbqPnvGLwYz77yFIu2E6tdxmHyrzbSRezyaB4aOnSV5kweR3ztYXi4m4eDfwA2ZWv7qvrNFuK/1q5m2ExUKc90PnA3jE7VCb9oc47WRv5dbW0tI8d/X3o3PoLX8Nt4/FiDhOQ+RyGu3pe361F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736010012; c=relaxed/simple;
	bh=bPraCC+bgEAm/jheHxfJI082nXX0861z1zf4a7pt3Pg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NOO9sjkCNJapQxPdy+o3fuaD277jDsOu1vVEMzzXXJGFQkFOKIuU7pRIy2/M+fNct99wP20+QPzcJfSONDWixLnJnmvzjPSGhOyBYJIcu1t2rxbxnzopQTaDGTX8GcepAFLdLKYPMLMjjJejZy7ZzIs5wYOKvA9VRtQ/L1aUhPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POtR+4Ov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5471C4CED1;
	Sat,  4 Jan 2025 17:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736010011;
	bh=bPraCC+bgEAm/jheHxfJI082nXX0861z1zf4a7pt3Pg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=POtR+4Ovx+acmwN715Nw57kdG68NjIeMHrsyjoIhbtz6n5Zq8cYelghErDvh22ewT
	 +59IkPlKz58lHlfYfmLvwoSGI90DFt3IUmb4a+3u3l54Jle7O/ThZ7zRapthTt7Bcv
	 WfQ4DSOejjZQTlVNMGQtmLo/Eud1K/WxcMpmCq/sV/QPcG3p5MEftXQG4R7OSAu2af
	 HN8vHPRVYeEaYwDlXa/oz6jiAOJhOXraFyyEKmf0ezaQOgPsH/16aGAkQ7FQHiDaov
	 K6+yPXH+Ksax4qqR2PO3/guGPzMXTY3qTQWeRVOZhpYe3NM+EVWk/3aCVO0T8RlAai
	 SCnrml3FUHx/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF28380A96F;
	Sat,  4 Jan 2025 17:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: tc-testing: reduce rshift value
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173601003258.2470506.15418875241946232841.git-patchwork-notify@kernel.org>
Date: Sat, 04 Jan 2025 17:00:32 +0000
References: <20250103182458.1213486-1-kuba@kernel.org>
In-Reply-To: <20250103182458.1213486-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: edumazet@google.com, netdev@vger.kernel.org, davem@davemloft.net,
 pabeni@redhat.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, shuah@kernel.org, karansanghvi98@gmail.com,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  3 Jan 2025 10:24:58 -0800 you wrote:
> After previous change rshift >= 32 is no longer allowed.
> Modify the test to use 31, the test doesn't seem to send
> any traffic so the exact value shouldn't matter.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: jhs@mojatatu.com
> CC: xiyou.wangcong@gmail.com
> CC: jiri@resnulli.us
> CC: shuah@kernel.org
> CC: karansanghvi98@gmail.com
> CC: linux-kselftest@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - [net] selftests: tc-testing: reduce rshift value
    https://git.kernel.org/netdev/net/c/e95274dfe864

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



