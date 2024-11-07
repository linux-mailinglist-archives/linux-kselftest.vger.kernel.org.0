Return-Path: <linux-kselftest+bounces-21586-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC639BFC33
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 03:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7502A1F2319B
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 02:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFDB2940D;
	Thu,  7 Nov 2024 02:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3Ih23Ha"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F422219E0;
	Thu,  7 Nov 2024 02:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944824; cv=none; b=rQh48VRiQykRS2B1+uZqZPFzaWjul7pEurDsDIwAHPnddlbzFEj8x1hdIGWrBfnMUXdeUabdUetej1vDIR4S03qiBIA+0BhpbNt+Iy+26y1SkUDU96LksG2+kn1pamS1iof07Fsu09VbTcELufayD6ED5wcLJlbwSsYx4npi7kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944824; c=relaxed/simple;
	bh=6rF5R2V380lUdu8k9hx/gA2xBk7UWXIJ66c9xai8vHU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FNH3xhnPpTdToNhcUpkBMl6YkI5x3ySnfDlNJQ4MqJ9UVOpsrSv+g9J8FC/LpDXabSncUhZq4Ne9jTEJn4O4msg4WFVRRvbuDqhWUk9/062jAxrdB8gdNEFA43WzUxJNgVlk7ukIkjhl83lzMrdPCQY7Wu9RViDoDQGb+l0Hv3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3Ih23Ha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3B8C4CEC6;
	Thu,  7 Nov 2024 02:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730944823;
	bh=6rF5R2V380lUdu8k9hx/gA2xBk7UWXIJ66c9xai8vHU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A3Ih23Ha3qNy/5C58KV3eXG2nOqtuwclAd7NAAJhw47UbfiVEApY/8GBpe0QrG/wB
	 A2+KXL17vwHPZaUMuXQCrEK2nAqD8zyVsxcz4bOJ0fLWAELXSYFSFbBhR5+J9vgRYC
	 IHX7eOuS24Nxa8OV/0hi4ukXM2TH7sm9467B92DO/BtYmk/Ozj4FuT2WN4DqgmBy6F
	 EWF/5xAO386bn7NIIG7kcz0l1QcJ5r8diqbskbWhoWEJf0R2Lqb+p55H9ifNpi/yd1
	 TysY1kPgEmoLDQihoYJswjJQciig3lTZdKR7eoUSRBGsOZ/7He2op1Y2L++P0EauJl
	 JdHO9pKCK1pAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E0B3809A80;
	Thu,  7 Nov 2024 02:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/2] ipv6: fix hangup on device removal
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173094483300.1489169.15053795359586095063.git-patchwork-notify@kernel.org>
Date: Thu, 07 Nov 2024 02:00:33 +0000
References: <cover.1730828007.git.pabeni@redhat.com>
In-Reply-To: <cover.1730828007.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  5 Nov 2024 19:23:49 +0100 you wrote:
> This addresses the infamous unregister_netdevice splat in net selftests;
> the actual fix is carried by the first patch, while the 2nd one
> addresses a related problem in the relevant test that was patially
> hiding the problem.
> 
> Targeting net-next as the issue is quite old and I feel a little lost
> in the fib info/nh jungle.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/2] ipv6: release nexthop on device removal
    https://git.kernel.org/netdev/net-next/c/eb02688c5c45
  - [v2,net-next,2/2] selftests: net: really check for bg process completion
    https://git.kernel.org/netdev/net-next/c/52ed077aa633

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



