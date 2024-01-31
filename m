Return-Path: <linux-kselftest+bounces-3823-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6A2843E30
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 12:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D31171C26167
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 11:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39E16EB66;
	Wed, 31 Jan 2024 11:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwk51JMy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79AB69DFD;
	Wed, 31 Jan 2024 11:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706700024; cv=none; b=Ci48uPKTxj/5Vb8niz3mTsWkdDODYvXklc18Cjo1hFFJKcZPans8fbvrgj23YvxQxIGkKFSqdtEDzNjp1pV17Qn/GY5KF7OcnJxFkhT66/zUEmFFyvvDcWBm+jpilH0Q0z0CqAMCLBI+lHc/2EZzEQexjWSGREkl1pqtP9mgAQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706700024; c=relaxed/simple;
	bh=yhcY0+ogks9SQM6K2SMLIjcNzihlSd+ybaVuvONfrNg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uJ2iSNX5WIsVrxBbx+Yv200str+aTnNrFc5xD1xplZ6SnQkb5Lczkfylv+2xNhjXnYQpmuyFLHlXVjPKSHKCJQfRcCpJZKc5cRseCvxTI45vV4Ws+4sAu7KDE2Dq+275zlwc5mGVQ+E8p2/FunAhKNirPhzNPkJRHknee6t8F7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwk51JMy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 369B0C43390;
	Wed, 31 Jan 2024 11:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706700024;
	bh=yhcY0+ogks9SQM6K2SMLIjcNzihlSd+ybaVuvONfrNg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cwk51JMyHHl5C4E8i8HJ6NaAQyK/wV1CtqkJoSfWxl4gztGS50tT6MI4+K0wFiz3T
	 YPwe74Jw1nygswCSamC0XarwgScQTQ57VPl4FCxIAUUrQSPV/GNQYi5/MK/NgOSvYA
	 uotR2Rd8KOeJUoH3vJyaY0G86YhyraSzGoEAlFORttjRH2IBbcJ9jO5ZZbdBMELwub
	 aXb1mznTMq7R074MdNQu979mAd5f04n9pWuCa94qtNSFLcLBVHrvREmSI2VJf5dI1v
	 guW88ODOQ15vWxJ2nN2K5QC5D24GKTfZkkubPMG+dpYEoDdYsgUB0Ypu/DeApRllKq
	 3DPRjk58aZ0gA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1AF45DC99E5;
	Wed, 31 Jan 2024 11:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests/net: calibrate fq_band_pktlimit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170670002410.15698.15810715135280092442.git-patchwork-notify@kernel.org>
Date: Wed, 31 Jan 2024 11:20:24 +0000
References: <20240127023309.3746523-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20240127023309.3746523-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, linux-kselftest@vger.kernel.org,
 willemb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 26 Jan 2024 21:33:03 -0500 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> This test validates per-band packet limits in FQ. Packets are dropped
> rather than enqueued if the limit for their band is reached.
> 
> This test is timing sensitive. It queues packets in FQ with a future
> delivery time to fill the qdisc.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests/net: calibrate fq_band_pktlimit
    https://git.kernel.org/netdev/net-next/c/57bf3dd2fe91

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



