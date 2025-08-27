Return-Path: <linux-kselftest+bounces-40021-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10643B37665
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 03:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0C881B6579C
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 01:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9C71F4C84;
	Wed, 27 Aug 2025 01:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAixDron"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058611EFFB4;
	Wed, 27 Aug 2025 01:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756256424; cv=none; b=toPhZVXIFxGQWBhbZzqjJki88f+xyJT9SJP6DMuq38RwzxOIRYEZOdlCr5msyXmeqPOIU2cLpUsjP61aTEoKFzyWhnkYh7qcjx7RWR/vAYsXMYmfsXVIIHcsDMPSHAfZmrTHSvSMPWEt2UWCCZ8buymY5thqAzQCEA7knlPnBNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756256424; c=relaxed/simple;
	bh=dMRyajv5D5WXeZrLK4TnDs/tGOSSDjsyobh+0/b+B7I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YHHShq6+AnDpVJlJHhiIWFjeY+yI1vlHZjb+KShhm52NkCr2kTnNJOf1KUskjKs1qui18qQDvHYbAne6Qe13NFid5oXEg8xXJAI+5bJzxpD2I3YaOhgkWvtIdTNvid46lCBU30uVG+r+zVkIT6ai8A1z4qO5404XrxgJLdz/Zls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAixDron; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964D9C4CEF1;
	Wed, 27 Aug 2025 01:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756256423;
	bh=dMRyajv5D5WXeZrLK4TnDs/tGOSSDjsyobh+0/b+B7I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kAixDronErtNrLzwpwl2v+NMHS7/n6GZ5OG4RWM22M8PPyK0QcH426JtA8lXX9BFm
	 kWMq54a5K8H1+e/BqTr3d1DKvJmxqQ+1tmBdiMOWAfgdnbyH8CKa8RF/9WsZHdp+bY
	 CximZafaZYnkFXxzc/dC626uH9sdDoCVUcCtdpTBwy6rlKP1mQd051SLs53SwEE3Py
	 thXr+uW3cfliI+cZFs3b8IpaWrX5GNfPu5avi/oIvs8S2dMcHLq6ZxBj0qu7Z8QFV6
	 eL2PeZ+RAM5teiDn9IuEdQg6EqHlAPnnq91ZlBc8+GZtD7fN3DZzhDTwYTQDqLUhPL
	 ulfF2MTbkTIDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D93383BF70;
	Wed, 27 Aug 2025 01:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] selftests: drv-net: hds: restore hds settings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175625643100.155051.6031494927174129098.git-patchwork-notify@kernel.org>
Date: Wed, 27 Aug 2025 01:00:31 +0000
References: <20250825175939.2249165-1-kuba@kernel.org>
In-Reply-To: <20250825175939.2249165-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 Aug 2025 10:59:39 -0700 you wrote:
> The test currently modifies the HDS settings and doesn't restore them.
> This may cause subsequent tests to fail (or pass when they should not).
> Add defer()ed reset handling.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - fix type hints for older Python
> v1: https://lore.kernel.org/20250822195735.1673744-1-kuba@kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next,v2] selftests: drv-net: hds: restore hds settings
    https://git.kernel.org/netdev/net-next/c/ee3ae27721fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



