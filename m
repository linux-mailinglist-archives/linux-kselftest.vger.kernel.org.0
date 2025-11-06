Return-Path: <linux-kselftest+bounces-45000-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A547CC3C1F0
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 16:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 52C0D3519B4
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 15:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B1130275A;
	Thu,  6 Nov 2025 15:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1mQ7r4O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F6F30101B;
	Thu,  6 Nov 2025 15:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762443648; cv=none; b=jHUbD5YDQX3aXnBkDy9e8QNv3QWpeiQw5vd8wkmHJeO3fhxgPXYj/v96Axrmq41MS5qwiI/z5vTAXkA7jRdWGXaH80ZeRnw+FUv4VPE1YyR01myr5gNXdbNs8DxdZWG4uax9AlIlI4cAp1usO4+fz/mgFmf07F2drjFRN2/i2mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762443648; c=relaxed/simple;
	bh=lrPzPfGNyVAqfZaif/Tyyi9kZPFSDZdXNdnxdNGxMGQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QGevnjsU+f1A1dOO+MnL8zZiqTRzZIZNckw2EnTwWCOZXt5bBKWODoeJAlayLFd/3mHMfp45jLsI63xi2Dr/2aPa98DryAn7uWtJdx+EBeq+uf7FtV9axcFyq/ayE0AC6LTfQ7p6gwk0I1M5fcIZcy//ICzq3cGJb1KzyE4eAn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1mQ7r4O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFD9C4CEF7;
	Thu,  6 Nov 2025 15:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762443647;
	bh=lrPzPfGNyVAqfZaif/Tyyi9kZPFSDZdXNdnxdNGxMGQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b1mQ7r4OrrhZowNkXI2wxEjJGwXRstE0sv4WUrUJSKcVhuWBHv4dEIOBmdj/sSXiA
	 +HeWeET+rLbDRGicTgkRN17l7A3DGLgvhepf9j28zYdlCs/6b6PYnujq0EoNbz0B0O
	 r3+Fqs9tGBwVG28Ueef0HhZI2ojXLhKgeHm+u/9ldRT5lMDkwzCwd4pPAcQnFiQXwB
	 xWAKtG8dwyv2LTrfuKyNaeZKUy67vZodIxKTAldOPUt29hj+vdCEgejsn4hKufn2fc
	 pw8La7jjt7XIFzPFJ2yRs8KdVq1OyGGvs35HRj20LwPgRYV2RQPoVy4zjPHkzw9M5N
	 IoG5iTW8dIPMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDFE39EF947;
	Thu,  6 Nov 2025 15:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bonding: fix NULL pointer dereference in
 actor_port_prio
 setting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176244362024.255671.15103494288395926377.git-patchwork-notify@kernel.org>
Date: Thu, 06 Nov 2025 15:40:20 +0000
References: <20251105072620.164841-1-liuhangbin@gmail.com>
In-Reply-To: <20251105072620.164841-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kselftest@vger.kernel.org, liali@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  5 Nov 2025 07:26:20 +0000 you wrote:
> Liang reported an issue where setting a slave’s actor_port_prio to
> predefined values such as 0, 255, or 65535 would cause a system crash.
> 
> The problem occurs because in bond_opt_parse(), when the provided value
> matches a predefined table entry, the function returns that table entry,
> which does not contain slave information. Later, in
> bond_option_actor_port_prio_set(), calling bond_slave_get_rtnl() leads
> to a NULL pointer dereference.
> 
> [...]

Here is the summary with links:
  - [net] bonding: fix NULL pointer dereference in actor_port_prio setting
    https://git.kernel.org/netdev/net/c/067bf016e99a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



