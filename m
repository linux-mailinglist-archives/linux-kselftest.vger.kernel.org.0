Return-Path: <linux-kselftest+bounces-46717-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EEDC93819
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Nov 2025 05:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 777B9348425
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Nov 2025 04:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C33238C08;
	Sat, 29 Nov 2025 04:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/9L7HA8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2172367BA;
	Sat, 29 Nov 2025 04:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764390798; cv=none; b=FyECSLNWrHyl7FboFm9PUQNaVv39Dr0pmU7KBUOkg60EMHHqh6ylxcRP4InEXeqaNgfuf5maH/UDJlfs0JW/mhB1Qs+9WEbJo//MlGEvmycZBm7oIkOlSPoV+aH45MGcwlz21PQxhzZpH4PegWMJXMAL6lw3bpU7iM3GaFSfLIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764390798; c=relaxed/simple;
	bh=clTjxDlG8Xj4sy8mJZXMgDrKVRNkubxrQtZJAebY+m8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T/qdUoowmiYhGLf6HLW/CQHpyJNRd2pV3Hr3eEKPU/pNavLlywUVn1yKNGtsC4qC75XMdi1umOR+AOygLj1WsMEy+/nHVUVpVMM6+q0xyx3SeCxEQmySfgfwEFi+Empdv8NoohhKWEoBmmNzJEwchCFWZDW0KSLfaBghTc3mY6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/9L7HA8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A00DC116D0;
	Sat, 29 Nov 2025 04:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764390798;
	bh=clTjxDlG8Xj4sy8mJZXMgDrKVRNkubxrQtZJAebY+m8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q/9L7HA8aO029O0e+NkinAllEdxJ5VbQ7qTxL/YakGGddmJ7XzxupejOpsV8L3Mvu
	 v2xeUke/MmoNdCIKQAaGwF2b0tEJQDKJrhVW/ztD5T6G0PikYFUEhl/U1DrZWg23Ap
	 OjFI6fXoF5G8xlW2pqrzCJTpUV2KO0j+T+V2AYCJtz3hFpZS6KRM2d23UqsH6jE647
	 35fmDNnG3WFM2P4HUZtyL0VU/szO9d2xXPoVrvT4nNYQi4fxiCWo/qyAkHhFnG5Acv
	 CA81ZlyEnPcXMa2SItALCx7+1HRyvLg+ehyAntHDe3YlQ4VNY4mAgRh2H//qxrEQwQ
	 AV0TNGD4oofLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2ACE380692B;
	Sat, 29 Nov 2025 04:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: bonding: add delay before each
 xvlan_over_bond
 connectivity check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176439061978.907626.16883243429414698167.git-patchwork-notify@kernel.org>
Date: Sat, 29 Nov 2025 04:30:19 +0000
References: <20251127143310.47740-1-liuhangbin@gmail.com>
In-Reply-To: <20251127143310.47740-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 jv@jvosburgh.net, andrew+netdev@lunn.ch, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Nov 2025 14:33:10 +0000 you wrote:
> Jakub reported increased flakiness in bond_macvlan_ipvlan.sh on regular
> kernel, while the tests consistently pass on a debug kernel. This suggests
> a timing-sensitive issue.
> 
> To mitigate this, introduce a short sleep before each xvlan_over_bond
> connectivity check. The delay helps ensure neighbor and route cache
> have fully converged before verifying connectivity.
> 
> [...]

Here is the summary with links:
  - [net] selftests: bonding: add delay before each xvlan_over_bond connectivity check
    https://git.kernel.org/netdev/net/c/2c28ee720ad1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



