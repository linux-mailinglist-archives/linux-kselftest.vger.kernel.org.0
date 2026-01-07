Return-Path: <linux-kselftest+bounces-48357-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74186CFB879
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 02:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 494383014A35
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 01:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F326D1ADC7E;
	Wed,  7 Jan 2026 01:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxTID2Jd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E9B3FCC;
	Wed,  7 Jan 2026 01:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767747812; cv=none; b=eJ/NpLwG9ySaL+lp2jDsCKCHtASOqoM4ERTBQZeCyd89829krZ2NGTrFlv0RoD/Sq2tNHRwR7zbOK9cgvR5yy5wUDiC9JCf9mgs0PZZ4gHvJ1IKecheX/Xvn7//Osu6GQ7sIBWAdHbxPl1mJqSNPJBlvjuxwhDn3YM/uzMHzYqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767747812; c=relaxed/simple;
	bh=c1rolDN2Yj09CHlsIfQy1dPNZ8uTH0A1b9+PJOHWIwk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IAwt4Q20PGskTo6HqJ4NSKSbVcdo7NHzR/hrf5+mYJDjazNpA2IpaeCi0JVaSZTh1xltt97SHN23WfyuXPedY1ZjCm7MaDqvJsbBrTGZxl/gsOQFK0GzIAlDkfBrZ37kScsTSLnzOGcpV9W3vR0HCbNR0dB3B4bsUdwRRn4QSq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxTID2Jd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433AEC116C6;
	Wed,  7 Jan 2026 01:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767747812;
	bh=c1rolDN2Yj09CHlsIfQy1dPNZ8uTH0A1b9+PJOHWIwk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hxTID2JdXhgvWXcXZNZGtoCjJxro91kun/NryeW8iN+XzgktymDcSm6B7iDx0chAB
	 E84n3JCndT5ZWiii5D/639H9eOyQA2qA33f5ds8sGtQzXL1GBs+bSRi6XjJNV04EJ9
	 FKyf7wKDpx5b7fQdcZfptJ8YDl6PxVOWFX0vHu8SPfvKHPEkXzfwX2xLTHi0O3g5z2
	 j38TRseJTN22XHTVP612II6PZaSKuIwYG0FG4tiBN3iytf+BOn1pmFx0ZT0zxcOMqe
	 JLDVoscWxtyCnfMlpyPNQTlnaiQMwF7QpeQJwx01ELElC8+dQLNIxcjmIMhhmg2y4X
	 g0KZpbYAHLldA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2A2F380CEF5;
	Wed,  7 Jan 2026 01:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] ipv6: preserve insertion order for same-scope
 addresses
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176774760977.2183630.3799089848817482368.git-patchwork-notify@kernel.org>
Date: Wed, 07 Jan 2026 01:00:09 +0000
References: <20260104032357.38555-1-yuhuang@redhat.com>
In-Reply-To: <20260104032357.38555-1-yuhuang@redhat.com>
To: Yumei Huang <yuhuang@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, sbrivio@redhat.com,
 david@gibson.dropbear.id.au, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 justin.iurman@uliege.be, shuah@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  4 Jan 2026 11:23:57 +0800 you wrote:
> IPv6 addresses with the same scope are returned in reverse insertion
> order, unlike IPv4. For example, when adding a -> b -> c, the list is
> reported as c -> b -> a, while IPv4 preserves the original order.
> 
> This behavior causes:
> 
> a. When using `ip -6 a save` and `ip -6 a restore`, addresses are restored
>    in the opposite order from which they were saved. See example below
>    showing addresses added as 1::1, 1::2, 1::3 but displayed and saved
>    in reverse order.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] ipv6: preserve insertion order for same-scope addresses
    https://git.kernel.org/netdev/net-next/c/cb3de96eea66

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



