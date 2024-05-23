Return-Path: <linux-kselftest+bounces-10614-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1999D8CCE40
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 10:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BC77B2131F
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 08:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7858C13B5A1;
	Thu, 23 May 2024 08:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVDeRR1C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4702B46AF;
	Thu, 23 May 2024 08:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716453630; cv=none; b=TAVTkOXFJIZCJuIoq9oOGCs3mD0MAAwlh6yW7dM3+qeLm1LCNhDqGCzhmRPAPGy048xEenr/wCWPlFtVNPdUqTlFgkvPhr9NBmp4cXn+ElfHS1E9EmZJ0eDcXNcLAUGEwF+LgaaGZNWHkuM1u5Ud/SAsvnOlxS2aOu5pi7zJYk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716453630; c=relaxed/simple;
	bh=kbHhwAWP8Z7bFGTHzEbqc6OzFN7pcvsE+U/vqmsMpMA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WBEtRTDKM6tqOPIzj/JUPkMGVLBQN6lOF9Jat5soJF29XfdKUBg3kVUbZW5bHOduGiB5s+iDYBpxfyQlWcmqRdzXmOJglfzODbgXAqiD2W8Z5GO5eE4FNtocB/CzaP5MAL6/8gYeO+v8rnMun05AAG0+T3paURTLCbod28P63Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVDeRR1C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD53AC3277B;
	Thu, 23 May 2024 08:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716453629;
	bh=kbHhwAWP8Z7bFGTHzEbqc6OzFN7pcvsE+U/vqmsMpMA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LVDeRR1CfwixVECxR4GHdQdWvSI79ZUvumNKnX1BXsQaCUHDBTmEOQLPiggQogAZf
	 2HaoAcu+Xz/0lVHac/aOCEyZcUegpy/1eSRZJYJx7C/4VCwlrv9AyhqSxIpzYm8Osh
	 9Be2Cr/+oMhNxoD2p5zrdg0Qvj9ua4ys7xxrcITSKDU1ffvxNjUokh79S8Hxr/b3hQ
	 zupTeXqiHY1/jHRwJfn8Fwcg1Z7KP1gaNTUzEZasYezRdJsS1ntgBbmjZL3tqdE65d
	 SjxoeWz+pZbmc8wVYSM7ECzLY6n/GIgbauVJtmRHVHq4ieMRsrPnojEGl4ZzphFDC+
	 HX94QnvcF9nlg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BF51CC54BB3;
	Thu, 23 May 2024 08:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] testing: net-drv: use stats64 for testing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171645362977.5739.7006263152240239033.git-patchwork-notify@kernel.org>
Date: Thu, 23 May 2024 08:40:29 +0000
References: <20240520235850.190041-1-jdamato@fastly.com>
In-Reply-To: <20240520235850.190041-1-jdamato@fastly.com>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, nalramli@fastly.com,
 shuah@kernel.org, kuba@kernel.org, davem@davemloft.net,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 20 May 2024 23:58:43 +0000 you wrote:
> Testing a network device that has large numbers of bytes/packets may
> overflow. Using stats64 when comparing fixes this problem.
> 
> I tripped on this while iterating on a qstats patch for mlx5. See below
> for confirmation without my added code that this is a bug.
> 
> Before this patch (with added debugging output):
> 
> [...]

Here is the summary with links:
  - [net] testing: net-drv: use stats64 for testing
    https://git.kernel.org/netdev/net/c/a61a459f5822

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



