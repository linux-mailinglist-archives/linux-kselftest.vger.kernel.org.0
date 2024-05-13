Return-Path: <linux-kselftest+bounces-10157-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 530498C4894
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 23:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4F65B233AC
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 21:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438E381AD2;
	Mon, 13 May 2024 21:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMhYaVwy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF4481728;
	Mon, 13 May 2024 21:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715634031; cv=none; b=F2CJURS+shGlceJZNKlabZf/S1x1RUduOgiUvmTxoobGSuXZoC0vVddRb0sI+8zZGJ0HfOqKbooagI7mSRb5w1+EIvcDVTdBvDIM9ibMyIM40atloU91DXDw5uc7kxo+lIZrO712i1zmP5Tog5xomwRbsemINtiGJRb1qrJoYOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715634031; c=relaxed/simple;
	bh=AHti9WMco4TBD2ovLAkZ1dlZj/jQzVAwmdojftBCjsw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XuKyrYne0ZOoFtzheCYFNj5+yp1C5DU3u2itchD8sUcag3zZhHLxu6hjq15rf2tlE4aTNgW8cstgxr3rpOUWAwayuMICCn9RF3Ql4QhYRj+6uvCK77v4Jhz3N4kPjrKgiHZdYZklthmY/V5Ro680uJkjxMTWpE8qSy0tloQfikg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMhYaVwy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B778DC4AF07;
	Mon, 13 May 2024 21:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715634030;
	bh=AHti9WMco4TBD2ovLAkZ1dlZj/jQzVAwmdojftBCjsw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CMhYaVwyEqfHlhMbMp0FoEm2XpbhnKUDJKqRd3WDU4ALP0tSaXAHmfCJZDFIeQz93
	 QIwUrqQ8UEG8QmLoWJMvmEiAOhwdWyn14GeZcV4JY8S8bw/0NCm3QxiDmQsIQgxQ2N
	 PdBmeZRLr5KpEATLxdgQJKuBUQtb0f45g60ZyRTmU7JJA3gF3+ulbAp3JVg6AyvIkr
	 Zp3AduIrRfFRmBHscXXHeJHVQpwOdyIkkQJSnV952nGq1O0n2HO+cTGi/UZWRnqv8n
	 i1oGlQ348QiW5hkimxAfY85KLEDrdKDTYIIS76YRsur5PptvuEXFb0F2ZOvcXqJaHJ
	 gq++sTCDQ0hFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A8D94C433E9;
	Mon, 13 May 2024 21:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: net: use upstream mtools
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171563403068.25832.3366829095151395846.git-patchwork-notify@kernel.org>
Date: Mon, 13 May 2024 21:00:30 +0000
References: <20240510112856.1262901-1-vladimir.oltean@nxp.com>
In-Reply-To: <20240510112856.1262901-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, petrm@nvidia.com,
 bpoirier@nvidia.com, liuhangbin@gmail.com, idosch@nvidia.com,
 jiri@resnulli.us, linux-kselftest@vger.kernel.org, troglobit@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 10 May 2024 14:28:56 +0300 you wrote:
> Joachim kindly merged the IPv6 support in
> https://github.com/troglobit/mtools/pull/2, so we can just use his
> version now. A few more fixes subsequently came in for IPv6, so even
> better.
> 
> Check that the deployed mtools version is 3.0 or above. Note that the
> version check breaks compatibility with my fork where I didn't bump the
> version, but I assume that won't be a problem.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: net: use upstream mtools
    https://git.kernel.org/netdev/net-next/c/cfc2eefd40f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



