Return-Path: <linux-kselftest+bounces-10161-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 314088C49E8
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 01:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A99BA1F21C22
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 23:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1A184FD2;
	Mon, 13 May 2024 23:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7mL5KpV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF9684E08;
	Mon, 13 May 2024 23:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715641829; cv=none; b=T8k1tVfDlv67AYMPt3gmItT+Maq8mVJxsKGWV5psrpgEvdQxzVuJybSf/Tov4FDOf0wnZgPYtw7C4j4tkzS4SH/4hU2NMEtQtDroBbIaPRwbFUPkQR3760jSdMZXY0Hdv48aE0p4o1F3bc+WoPNbeJGh8AtyRUwb8+U9yjH19+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715641829; c=relaxed/simple;
	bh=1yzhIq4eTcJuUqwKHSzQMlzBz5BnslKWlNDp52610XI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iJLnY6baGjmu0kXXSJLJi8zx4Xz0X3pYkWN3vJoRsZ1xv8VT+J+/udbl7ZlkOtIomdWhq2jlsWyw7Ivc32SDFPx31HCaE6grgZwG+cYb02JHLzd9v036myZHQmfkP/ltp9G8An94U+e5Ekn+oggKAsK4Di48n2hrwivBoGfhwLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7mL5KpV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36AA4C32786;
	Mon, 13 May 2024 23:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715641829;
	bh=1yzhIq4eTcJuUqwKHSzQMlzBz5BnslKWlNDp52610XI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u7mL5KpVbKQMoEdCqQeTD72LIT/9VWC6GclztPN670RlZ9zYiINTxNDi2jtKDASmU
	 EUgtectCNbt+LHubBPw4eo1iKvhJzc3B5OyRHXwdDB09ZoJdjmMKSGVnDT3uJWWPxf
	 3VhSSFMnpTbyNybRT3BV/JOj9b2DEyG/RCORq4eWI+QqdHvyqSTo1BjpDlfJ+hFgA8
	 E76l/4CODYpkrPBPn0S9JmaeQPz7e2zy3fDOot5cKcYfyrL8M7YGry+cpwgbJnIKfV
	 XPWLzO5BgF7YsDVzGA9Rrkh8mG3AbFmph1kPZgFqiTRDW83CU4TrfHTi0htCyf8QJ0
	 0jTsMxj5BBvGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2383BC43445;
	Mon, 13 May 2024 23:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] test: hsr: Extend the hsr_redbox.sh to have more SAN
 devices connected
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171564182914.6706.16647604861165136957.git-patchwork-notify@kernel.org>
Date: Mon, 13 May 2024 23:10:29 +0000
References: <20240510143710.3916631-1-lukma@denx.de>
In-Reply-To: <20240510143710.3916631-1-lukma@denx.de>
To: Lukasz Majewski <lukma@denx.de>
Cc: kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, horms@kernel.org, casper.casan@gmail.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 10 May 2024 16:37:10 +0200 you wrote:
> After this change the single SAN device (ns3eth1) is now replaced with
> two SAN devices - respectively ns4eth1 and ns5eth1.
> 
> It is possible to extend this script to have more SAN devices connected
> by adding them to ns3br1 bridge.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> 
> [...]

Here is the summary with links:
  - [net-next] test: hsr: Extend the hsr_redbox.sh to have more SAN devices connected
    https://git.kernel.org/netdev/net-next/c/eafbf0574e05

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



