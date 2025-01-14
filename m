Return-Path: <linux-kselftest+bounces-24527-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0856A11366
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 22:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 824BE3A16A9
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 21:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C95211278;
	Tue, 14 Jan 2025 21:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+b9rxbQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9D426AC3;
	Tue, 14 Jan 2025 21:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736891416; cv=none; b=lciXdYsYGLygAUXZp8Y0Pkvgn3+uhpSOB5Elh/DhEjYsDY1agn17zjA2kpwJxfBaemHybEdpwylG2VBSzDmGjjyumqKn93Y3FvmTlKREypV1XncaoEzJjh3yy8r7euosS11sW4UGUoQ53qU9rSqaJ96r4iutLms5LUQm3XYemBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736891416; c=relaxed/simple;
	bh=n9o5EzyAGrGOU/dkLi1GSw6IOzp5Q2e5sfX8rhM9nwo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Zr4pL+1ULlzbLsP+amTnr83ozVxbsR55TKkpGedmScE43n/7K2DVlKqfttvkEJodu31QiEANs1RBj9C6eLlk3mpt96BHkmzs4zYTRN4JXUvv2TKLppBqM+Y6wzrTXQ6s9e2roaOUsLRYthTKTbv0kpIjFE61F0UAVoTkwexnaNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+b9rxbQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52ECC4CEE3;
	Tue, 14 Jan 2025 21:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736891414;
	bh=n9o5EzyAGrGOU/dkLi1GSw6IOzp5Q2e5sfX8rhM9nwo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W+b9rxbQIFK95J4NaPExaPSOJOsrF+ldKDr+dX8HYSEK7x7me+iF460KSisnA1hqJ
	 hfO30z1oCKr9u4WHVHEoW0NVR/uk73fOtnOXCw63aRAX/9gj9G77pu4foB07gSDaPs
	 yz5OOtQL8OMd5xGpRSmZTrHgZY5cKlibrbWJND1B9M3KfyOh81dFsv01PXwqQZec+3
	 NnkZ07Zm/ceoA79VKiSg3pnrv2RL0jHZyXHVW68OFPS8sCI+p0koEmpxqO5lIKX8oC
	 65Wy45sQhKtrdWJ7oVyTVhktR/bLvn7pZL9AO8aIMoN5qtItt5Lt0eCDCRUV0QP1pU
	 v7LVuoFe9cM5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71462380AA5F;
	Tue, 14 Jan 2025 21:50:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] mptcp: fixes for connect selftest flakes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173689143724.152273.8430157856789895479.git-patchwork-notify@kernel.org>
Date: Tue, 14 Jan 2025 21:50:37 +0000
References: <20250113-net-mptcp-connect-st-flakes-v1-0-0d986ee7b1b6@kernel.org>
In-Reply-To: <20250113-net-mptcp-connect-st-flakes-v1-0-0d986ee7b1b6@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 Jan 2025 16:44:55 +0100 you wrote:
> Last week, Jakub reported [1] that the MPTCP Connect selftest was
> unstable. It looked like it started after the introduction of some fixes
> [2]. After analysis from Paolo, these patches revealed existing bugs,
> that should be fixed by the following patches.
> 
> - Patch 1: Make sure ACK are sent when MPTCP-level window re-opens. In
>   some corner cases, the other peer was not notified when more data
>   could be sent. A fix for v5.11, but depending on a feature introduced
>   in v5.19.
> 
> [...]

Here is the summary with links:
  - [net,1/3] mptcp: be sure to send ack when mptcp-level window re-opens
    https://git.kernel.org/netdev/net/c/2ca06a2f6531
  - [net,2/3] mptcp: fix spurious wake-up on under memory pressure
    https://git.kernel.org/netdev/net/c/e226d9259dc4
  - [net,3/3] selftests: mptcp: avoid spurious errors on disconnect
    https://git.kernel.org/netdev/net/c/218cc166321f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



