Return-Path: <linux-kselftest+bounces-39344-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6732BB2D0E2
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 03:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F31C71C24AA1
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 01:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3E61A5B8F;
	Wed, 20 Aug 2025 01:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCh3g2DR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FD71922D3;
	Wed, 20 Aug 2025 01:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755651608; cv=none; b=Mwet6RnBB7SpU2XB1esMZZtG+9TYaHh8lMxR33RwZdgby51R6ZOmCaKPi2PyBQkpepP0ZlQoCUD6p+Co97+E7HgQnyJ1lZ7EoWDrpKdypSkg0GITp6BmFqUU0tdzCin31RDQuzihRWMNtT3MIsdc8J1J1MqRhMnKqL+46GIRrpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755651608; c=relaxed/simple;
	bh=TSQ7wgGxH8wjkIC7287Maz3A/+sq9Ck5XiaO2CCdP7k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PawzAHSdSEiZsAnmWwiW+OLIcAoDIQmyzTGJVnPQqe8hQ2jMA0Q+OCn8MMIUIgC5avHJARoidHaLh9zGOEVMgKJDvcwK1iTP/NZHc7kFMCQvYahnIpFvjEy/t66kQZlrsOU4tBl6fIHKlP8gvkEzNOoi8728ALO9g1xV+XPbRK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCh3g2DR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49994C4CEF1;
	Wed, 20 Aug 2025 01:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755651608;
	bh=TSQ7wgGxH8wjkIC7287Maz3A/+sq9Ck5XiaO2CCdP7k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MCh3g2DRB6b2+o3kW1J3+9FUWvsRb5LJX00BJBdV3prABHh0oxgWI1/MqK1QoCNEE
	 FOgM4U+JoZkXkZIi7g6gfa3z+49zsRnvIWCSb5I97k6tcACs1ocpu3TZSrXIsYu0Op
	 3wTLAtthUm2nPHiECkmjet1CnzO+mouUnL6qKn3OM/GdwuWD7EDF+SYY96q7CJ9SoJ
	 UlsM03X8KoeoEw+skhHAo0BR4/03W8syvQ9ST6yhq8uB5UDfla2ccwKNQjc11+YvD9
	 hE5Tb9qr/pvh1meJtmvUI+JeCEuskj6IIps8lSWEvLf70INM5lMPNMCfHRMypTl7WN
	 SCs4fs0ig9PMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33ABF383BF58;
	Wed, 20 Aug 2025 01:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: drv-net: tso: increase the retransmit
 threshold
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175565161774.3748899.1626697623111633858.git-patchwork-notify@kernel.org>
Date: Wed, 20 Aug 2025 01:00:17 +0000
References: <20250815224100.363438-1-kuba@kernel.org>
In-Reply-To: <20250815224100.363438-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 willemb@google.com, daniel.zahka@gmail.com, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 15 Aug 2025 15:41:00 -0700 you wrote:
> We see quite a few flakes during the TSO test against virtualized
> devices in NIPA. There's often 10-30 retransmissions during the
> test. Sometimes as many as 100. Set the retransmission threshold
> at 1/4th of the wire frame target.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: drv-net: tso: increase the retransmit threshold
    https://git.kernel.org/netdev/net-next/c/eddc821f98af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



