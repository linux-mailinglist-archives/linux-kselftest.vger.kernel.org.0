Return-Path: <linux-kselftest+bounces-17910-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F179776D1
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 04:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C29286148
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 02:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32391D2F72;
	Fri, 13 Sep 2024 02:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxu8W08U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A156F4EE;
	Fri, 13 Sep 2024 02:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726194031; cv=none; b=tuoh9mzsttVG8JhmsZsY4f3ODjDdgNPtmP88+Cn7XKTyEFKNQttQJ/6yb6hSYrmXuEM2Wpz64/OwvrN7hfJp1y8hPhEWTrIJ8Nh+7KGKVBdIr5VElIEYfrJj4CkCLnQsPooX6GK5cJTUyvCdTirVt96mcnrer5tSAIky/A2zBfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726194031; c=relaxed/simple;
	bh=JlnepEJWwGFEskCoWC5TUURVrEs+7zlkqc/cWzfaVwo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hXYjE9QvSURWIAQQCI5WUutPg8OliMnkPT1H7hycHHH68K/6zt/cxdvCmdwuXCnwOvlSqx5vEx+3AguOS+GufOFeNymEya/3fUahaFfISBpa78qlpZ7A5LOwfXzSTXjSsbaErUpyiz2LzqhE6SualuKmIkR7zx4hjdll1CH8d0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxu8W08U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F299AC4CECC;
	Fri, 13 Sep 2024 02:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726194031;
	bh=JlnepEJWwGFEskCoWC5TUURVrEs+7zlkqc/cWzfaVwo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fxu8W08Umlpj9XC8d51CwWl+834y2N5Kd0TNuHb0DtTrcQ7o00kVIoyiS1P4qZI9Q
	 J9rtfqpVl07wz1fZMnm+Fhp4loB6yG0zQ+XAVq3IgNhz8Mqi+DwxQnXJJvUwWHj0KU
	 pAnrcBRtQzYwFaDl50D+bVcZPH67lS0ECRQMmwaZIcGUDEEe22iJ11qL75I6NCMV+K
	 MN7aYvYXNx/Vgs7C/yhQf34cJgs4OaPPq/vv98aScTksjUQxA8PvdP30sGfds4fU4V
	 rcVmuJLHBobZ+u2WkVtH024MP7DPq+Rx540zCOMJm3mStc8oIKVuAmWodRc1hyXtE2
	 FFy+aPk501xfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BB63806644;
	Fri, 13 Sep 2024 02:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] selftests/net: packetdrill: netns and two
 imports
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172619403204.1789147.11951223471330268970.git-patchwork-notify@kernel.org>
Date: Fri, 13 Sep 2024 02:20:32 +0000
References: <20240912005317.1253001-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20240912005317.1253001-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, ncardwell@google.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, matttbe@kernel.org,
 willemb@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Sep 2024 20:52:39 -0400 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> 1/3: run in nets, as discussed, and add missing CONFIGs
> 2/3: import tcp/zerocopy
> 3/3: import tcp/slow_start
> 
> Willem de Bruijn (3):
>   selftests/net: packetdrill: run in netns and expand config
>   selftests/net: packetdrill: import tcp/zerocopy
>   selftests/net: packetdrill: import tcp/slow_start
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] selftests/net: packetdrill: run in netns and expand config
    https://git.kernel.org/netdev/net-next/c/cded7e0479c9
  - [net-next,v2,2/3] selftests/net: packetdrill: import tcp/zerocopy
    https://git.kernel.org/netdev/net-next/c/1e42f73fd3c2
  - [net-next,v2,3/3] selftests/net: packetdrill: import tcp/slow_start
    https://git.kernel.org/netdev/net-next/c/e874be276ee4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



