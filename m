Return-Path: <linux-kselftest+bounces-39462-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CA9B2F0B5
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 10:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BA6216B6A3
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 08:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2622E9ED3;
	Thu, 21 Aug 2025 08:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fF9ZpMSo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513CB24DCF9;
	Thu, 21 Aug 2025 08:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763801; cv=none; b=kwyFZTUwQUTHTy7igo3p3fKD61PGOgJgIsqqah18ji4Hf3CemVZtUJuUYd1g+B/a+E3/bEMR4W0OvBzweK/29JuLiE78c8x2JB9ktBjeOa73KbRKF3rrX0CT6TotwpQE4HaV015MTnR2/N9FJBQE44dUnyaYJZuWf/d4SUxWfa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763801; c=relaxed/simple;
	bh=JTwfKpBvDGRdZMUNc8jbFUqaSP/8RCqhY4B96jP75UY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gpKfyrUllCUhGAuV6DYKG64uqJaF8KMLDwYxSiN1Yu+PLTsIyGXpisuXYi+jmPfu4pelrh+pDdj5cwJwfVJWQ18WVR97zQa6K+qz+3ML1VzCIGCCSGn4VFUjA/mTG+jDln/2/Ic1qUPY7qLpssGeEy2aqhJ3nn6fwX34nnKL4eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fF9ZpMSo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D00C4CEED;
	Thu, 21 Aug 2025 08:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755763800;
	bh=JTwfKpBvDGRdZMUNc8jbFUqaSP/8RCqhY4B96jP75UY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fF9ZpMSoqnk1ii8Ql2z7EQS0OpKt5fmv8/NwmK8zxfD+E7RyjhUgUQXsog0037Gws
	 Hj9GLuP7IFAOR1ZSTnjbnVJEyO8NMnjg6wC97sHEzP/1FuFckTUzrvVmx0CyhkE3C9
	 QwSX2WJKibz3YyL19TzaPU74VlgQwv5WCSxpswvj9XoasytUVnh8hfdqb8Z6RRL3NG
	 /Xzfi0DBjMiJXCOD9BflFeYs6wmSvXqZK5G3mdu5497hUvMEId6+bEUr9Y7X3qNcPT
	 TyMjo2lBcvpDiXwrS9Lqn80VxbVsbO9N4hArwuugOhpsRoSuyV8g5clg+kCErGhSQx
	 Byqvwb7sbB+og==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E44383BF5B;
	Thu, 21 Aug 2025 08:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv3 net 0/3] bonding: fix negotiation flapping in 802.3ad
 passive mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175576381025.930404.21342253142481307.git-patchwork-notify@kernel.org>
Date: Thu, 21 Aug 2025 08:10:10 +0000
References: <20250815062000.22220-1-liuhangbin@gmail.com>
In-Reply-To: <20250815062000.22220-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 razor@blackwall.org, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 15 Aug 2025 06:19:57 +0000 you wrote:
> This patch fixes unstable LACP negotiation when bonding is configured in
> passive mode (`lacp_active=off`).
> 
> Previously, the actor would stop sending LACPDUs after initial negotiation
> succeeded, leading to the partner timing out and restarting the negotiation
> cycle. This resulted in continuous LACP state flapping.
> 
> [...]

Here is the summary with links:
  - [PATCHv3,net,1/3] bonding: update LACP activity flag after setting lacp_active
    https://git.kernel.org/netdev/net/c/b64d035f77b1
  - [PATCHv3,net,2/3] bonding: send LACPDUs periodically in passive mode after receiving partner's LACPDU
    https://git.kernel.org/netdev/net/c/0599640a21e9
  - [PATCHv3,net,3/3] selftests: bonding: add test for passive LACP mode
    https://git.kernel.org/netdev/net/c/87951b566446

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



