Return-Path: <linux-kselftest+bounces-45158-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DACC4252E
	for <lists+linux-kselftest@lfdr.de>; Sat, 08 Nov 2025 03:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 442001893462
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Nov 2025 02:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15972BEFEE;
	Sat,  8 Nov 2025 02:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmFbtETn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB2428643C;
	Sat,  8 Nov 2025 02:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762570234; cv=none; b=INb7e5f41uIFovlvwB7yvh68135FXHzMhvmUvTg1KyvZpbN8DAbB9iAojxJA8/CkL6t7C02LqISCtHIUPASFo7NnHLAmiUnsGF3z/tsDP18Lx7ei79Bf4mX2rJkhaqumEzKFxpkQwPJXNQkWFjdlXyUEgGm7sh+fY0spSCkoEok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762570234; c=relaxed/simple;
	bh=4ohIBlkylXEyUHoKskGwKTxWOcBS7L+1Kr1tFDrKoyI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GCyViHA+bbXCwwRs+ph9zaPc3aqOri0CTiOObGeQAsyaVmlU4paiyLDNDQsOpmuzAhPiHyBRrSPL+4Ok5gymP0tOQ5lxlougxR2N4Gs1Et5ENiVKHA34SjhDh9sloAqdeVoA6ENPzFM0itzxjLoqcflVuW7UX3upz0FZu2cjWNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmFbtETn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3C9C4CEF5;
	Sat,  8 Nov 2025 02:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762570234;
	bh=4ohIBlkylXEyUHoKskGwKTxWOcBS7L+1Kr1tFDrKoyI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NmFbtETniDhTFLVgmSh+eaVOXfNlAj9BLXpWvZbexWx5kbF4AQexlWic1P46G6A83
	 LXdvhZEzcbIBckhU9pVcXMfCiwDCY8baITBM730P2riGOf/WPS7AUOXhHnfWzspNy7
	 YETpy59A7/7h4eRwYt4OCaFaIPLHoErFspqo0K59h0arKe1+wIlWOuCD2+IGYipTvR
	 CvUWGQu6QULBM4jMuXA/whHJSV6O42CEfPmZQchPD7wPxcGPa/T0JZUEAqTMcRjnUN
	 wa9DMSY4bdGmxV6EicS95e88KG4Lbhd+aReApkNs2E8g+z8KREvRZ8Asml84SbThO0
	 yEwNn5LfZUvvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710DF3A40FCA;
	Sat,  8 Nov 2025 02:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] selftests: net: local_termination: Wait for
 interfaces
 to come up
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176257020625.1230661.9266574979799210382.git-patchwork-notify@kernel.org>
Date: Sat, 08 Nov 2025 02:50:06 +0000
References: <20251106161213.459501-1-alexander.sverdlin@siemens.com>
In-Reply-To: <20251106161213.459501-1-alexander.sverdlin@siemens.com>
To: Sverdlin@codeaurora.org,
	Alexander <alexander.sverdlin@siemens.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, vladimir.oltean@nxp.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Nov 2025 17:12:09 +0100 you wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> It seems that most of the tests prepare the interfaces once before the test
> run (setup_prepare()), rely on setup_wait() to wait for link and only then
> run the test(s).
> 
> local_termination brings the physical interfaces down and up during test
> run but never wait for them to come up. If the auto-negotiation takes
> some seconds, first test packets are being lost, which leads to
> false-negative test results.
> 
> [...]

Here is the summary with links:
  - [net,v3] selftests: net: local_termination: Wait for interfaces to come up
    https://git.kernel.org/netdev/net/c/57531b341644

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



