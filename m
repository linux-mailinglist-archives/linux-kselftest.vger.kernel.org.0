Return-Path: <linux-kselftest+bounces-16472-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 162EE96196C
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 23:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D367B218CD
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 21:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CF71D3657;
	Tue, 27 Aug 2024 21:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzcyDIPF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA06D13B293;
	Tue, 27 Aug 2024 21:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724795432; cv=none; b=QQIV+ubI45Whx5qvxsQwNNwYnPMnSfD4s20JVPMdAbiREBeSPa2iV6dVHrjFOMpzCr0p4icHJkIgXHyVRs7EfTrYJYmaqvrWnSzJ0ehACaJRqmcBwV5hfpnoqKKgtifAfDUCAYCHokz8la9hNqx5557FAiBwWMptITQ7F6rI7N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724795432; c=relaxed/simple;
	bh=4rYQNT0gECDd1fmElnBYuODs3dX24OZbqJmLg4YI/Ok=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ihBRwh1UevykbZMM9XuTy0dr1hcTmIS/3LAE3nKLL397jJpZdn4evumNXGKl//deJ/iLHDsvHzEmlxs/gzmLbZkKk04sZYkukYtB3fSsxMUYtUdSJnOrH7qocFqLmsADBH7egDtzj3WNQ6ydtx+ietheZ42iIdD0VhSJrUGGS9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzcyDIPF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E98C4AF10;
	Tue, 27 Aug 2024 21:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724795432;
	bh=4rYQNT0gECDd1fmElnBYuODs3dX24OZbqJmLg4YI/Ok=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AzcyDIPFfuvxlKrbgceuxjGIj/h0BoY41XPHWlE3pzBTjD45pod+tU+KvQxRSO15D
	 JxOb3RpJy/37ubScM3QMNFhGTUw4xuypB+dr11OfTpo3RbbzIc/s0mzvyxLXk0bmMv
	 ItxiSWGJ3qqLefQi8OhpRzHwAh9XlPUFZzPmCDN6wJHWl9VY3cbX0BsqA1ZwZmbWJH
	 ViXBuvf2hU5fBO2QYpBV4ObxPcDFaool3l7nlNuCHfdVkzB8YGqN3HuHZ2ClLfgwVw
	 WsRPV5s2Gu7cCEhJB/dJ5i2Sncp16dCCpIFB9G3SjLyCs0VQg5grHb7FKi9WJ9p0lq
	 22ea6eU3G2+Fg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70ED83822D6D;
	Tue, 27 Aug 2024 21:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] mptcp: close subflow when receiving TCP+FIN and
 misc.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172479543227.771722.4715567676668885065.git-patchwork-notify@kernel.org>
Date: Tue, 27 Aug 2024 21:50:32 +0000
References: <20240826-net-mptcp-close-extra-sf-fin-v1-0-905199fe1172@kernel.org>
In-Reply-To: <20240826-net-mptcp-close-extra-sf-fin-v1-0-905199fe1172@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 fw@strlen.de, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Aug 2024 19:11:17 +0200 you wrote:
> Here are different fixes:
> 
> Patch 1 closes the subflow after having received a FIN, instead of
> leaving it half-closed until the end of the MPTCP connection. A fix for
> v5.12.
> 
> Patch 2 validates the previous patch.
> 
> [...]

Here is the summary with links:
  - [net,1/4] mptcp: close subflow when receiving TCP+FIN
    https://git.kernel.org/netdev/net/c/f09b0ad55a11
  - [net,2/4] selftests: mptcp: join: cannot rm sf if closed
    https://git.kernel.org/netdev/net/c/e93681afcb96
  - [net,3/4] mptcp: sched: check both backup in retrans
    https://git.kernel.org/netdev/net/c/2a1f596ebb23
  - [net,4/4] mptcp: pr_debug: add missing \n at the end
    https://git.kernel.org/netdev/net/c/cb41b195e634

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



