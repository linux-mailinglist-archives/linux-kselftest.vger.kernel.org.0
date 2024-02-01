Return-Path: <linux-kselftest+bounces-3941-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 732F7845D6C
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 17:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 299F228FE75
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 16:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5349B7E109;
	Thu,  1 Feb 2024 16:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l066YR/X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E294C7B;
	Thu,  1 Feb 2024 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706805627; cv=none; b=GLcGYVUl9rkLI0w57QT9fual823muEcDHoiwDUB8FM1sMiIg4HfnxQi1rxtIR/md49ewfZtYSKAvh2sQz2ehypWrzP7q55SAOLJJ1pjzAzlGfXVMM5qJszbvmjFKISHiWW5GxbtS0afxDPHXEfZGi3SPByLpQGX29CKLl+j5r9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706805627; c=relaxed/simple;
	bh=ll8sBgYOXedzdUswchcPND/GwQYLEsPHBUuqyOCb+eg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X+3+1J9b1JnzmiqNMpAjYG4opQFPZwj7sHv7g68GaIHCsZYzKAqFUTwQ0OAMCs8v9H18UOtn/artzKNEIhYLxniHrYv41fDqUQX/+U4cbrMRalRowa8YAOAHqwj/NVLJxRkdEsFJI99INYG/ErCDr9v1/CzxOs4SMXHpa5PBAss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l066YR/X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB4DFC433C7;
	Thu,  1 Feb 2024 16:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706805626;
	bh=ll8sBgYOXedzdUswchcPND/GwQYLEsPHBUuqyOCb+eg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l066YR/X/cSDIJ22J3K9QiXUiH1G5PPImDG4KfZNNXGBic0IeoruLs/Mozn8ShKzV
	 guZKC4qPWe2Xqw30j9Ilvf8QURqRjxhG65qEXzw2DsQBQ4TP0GGqjC5H/q1uQ9HP7B
	 BlefLZGtdSAUj5kAWh+UUVZGnjQc+0OKI1sfEblna7wIjrGEqTo2cIVwRCDnU5qbre
	 Ib2k7R3N+clL5RshOkQ7Ter0xXIMpELkcyQm+JIBKcKveq1u/iNi13SwJT/zwSgrbw
	 KLA8bkBY121ah83V9llravoJsJtrQ6SzSt5mfxOOOqiAb4qD+tS6Glmio0++Bn9lKZ
	 HzJwsN9lc50Cw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C460CE3237E;
	Thu,  1 Feb 2024 16:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: net: add missing config for NF_TARGET_TTL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170680562680.32005.8471290057184064325.git-patchwork-notify@kernel.org>
Date: Thu, 01 Feb 2024 16:40:26 +0000
References: <20240131165605.4051645-1-kuba@kernel.org>
In-Reply-To: <20240131165605.4051645-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, ap420073@gmail.com,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 31 Jan 2024 08:56:05 -0800 you wrote:
> amt test uses the TTL iptables module:
> 
>   ip netns exec "${RELAY}" iptables -t mangle -I PREROUTING \
>   	-d 239.0.0.1 -j TTL --ttl-set 2
> 
> Fixes: c08e8baea78e ("selftests: add amt interface selftest script")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] selftests: net: add missing config for NF_TARGET_TTL
    https://git.kernel.org/netdev/net/c/1939f738c73d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



