Return-Path: <linux-kselftest+bounces-23979-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B45A03C56
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 11:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19C3A7A220A
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 10:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C551E5710;
	Tue,  7 Jan 2025 10:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrYsx8+2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF9C1E47BA;
	Tue,  7 Jan 2025 10:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736245811; cv=none; b=BNaQMyT/9Ppo8cpfISsyPj3RSM3IvPt2dnrBeNktzQvHhRQffC0HlRtRq92RtcqMHtHbieExqrghHNsw9JTLkxkdsAS/19CfFDVveXzcyeQ900VmjTzBU07nXRDIYP+n+l1RDHjVsA0LmEQyStxVB1LFTvpAOjNqIlHCiccS1uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736245811; c=relaxed/simple;
	bh=fL0phPG037MSb692iBA3aaSqJDdk15YlxKrFEH1LtfQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uaDI8xExEunEeWwC6kHTZyz/g2C3RDGD9PhhWyZ+iknmmxhjtD61S1bUVV9MvaOA4pmovUfUIVhpX077Yr0hQdvv05VTFYgQrz4t6lHA6wy2iJPAWEM2Ny+3isJYwOZRbPHKlFrRgIgZe7GRYTafMCM3/XBF56o9qGZKLme5dkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrYsx8+2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34ABC4CED6;
	Tue,  7 Jan 2025 10:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736245811;
	bh=fL0phPG037MSb692iBA3aaSqJDdk15YlxKrFEH1LtfQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TrYsx8+2Zmn8Awnbsfyxdet6K4WibPdDZhi4ebxV4wXYwlFHey3Wy0xyXjELMbHil
	 +DmINuazjdXEuuxsfa6DLqOMA5VZad7MEDb/9jE1KOLYAVAoUInA+mFBeZURJ2lGnJ
	 +xEqyIKrCwgC/jGL96r8qE3B8bgj1lkMIni8f91MC5lL5n4kFdB0f2OT7Cdt/lfmnh
	 zY06NhBIP3T3B7AXGRu6v91jHrKk61TddjkHBggtAoa0A6okpY+FC/DOZBdX9vPKsG
	 jy4P4j+Xv9gNW1tYbwkQ3JIxyWiO9r95cEPD9do0c5bDM27TdJBHaXSF87rC1Bcraq
	 80PwzMi50NxOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710C3380A97E;
	Tue,  7 Jan 2025 10:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests/net: packetdrill: report benign debug
 flakes as xfail
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173624583226.4099602.7245527834877718325.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jan 2025 10:30:32 +0000
References: <20250103113142.129251-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20250103113142.129251-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, sohamch@google.com, willemb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  3 Jan 2025 06:31:14 -0500 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> A few recently added packetdrill tests that are known time sensitive
> (e.g., because testing timestamping) occasionally fail in debug mode:
> https://netdev.bots.linux.dev/contest.html?executor=vmksft-packetdrill-dbg
> 
> These failures are well understood. Correctness of the tests is
> verified in non-debug mode. Continue running in debug mode also, to
> keep coverage with debug instrumentation.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests/net: packetdrill: report benign debug flakes as xfail
    https://git.kernel.org/netdev/net-next/c/912d6f669725

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



