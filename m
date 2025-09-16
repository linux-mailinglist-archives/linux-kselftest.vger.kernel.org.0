Return-Path: <linux-kselftest+bounces-41556-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C631B58B3B
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 03:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F00B14E287F
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 01:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A381E25A2A2;
	Tue, 16 Sep 2025 01:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pauJ87so"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779692550CA;
	Tue, 16 Sep 2025 01:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757986246; cv=none; b=S5Cd9tN7amsaUOY76977zVNif5pjacisqMWmXbH1/j4DJmotu5Q9kRPfwWcSTS/DVQzUT3jGjgs8zUHAbGL1o5Nu50Bn0MFSJA0637F5OvwrJmx1EjAWGlHVrIBdXjoLgYIdXRQByqc/hYfX5zE/YO8Sfr34rY1hKYLiFdLpShA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757986246; c=relaxed/simple;
	bh=+SKeDVDSk6yv2IQNZHLPqfTmJe440AQ3FS0rE+oAsrs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DJEi8MvLoMJUSnqJjZ6B5VCQ+gaUiAYPfkIszjSXaf1xObdD+Y7XDvcWHR/jkIewYzLmfxGJ8bZ8i3js2zKBNBB3Q9n1rCyH7uxdibCyygIDJHWT2JG5VFeCDyo7pqZV5sCY/DDPe/UHPEr+nRL8Mq0yTuZgkuHMPE4I6ASZx9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pauJ87so; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57889C4CEF1;
	Tue, 16 Sep 2025 01:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757986246;
	bh=+SKeDVDSk6yv2IQNZHLPqfTmJe440AQ3FS0rE+oAsrs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pauJ87so1dt8E2l8iL8sIOT3v1gAQMtPlH4tSKX4iWdM8w45CN3SvFJYrT2h+gI5R
	 RBO3lzCJpz+Sm2nzUyEn/Bh4MjYJU7qUQdyH8Gad3HLeJWVXISc0Iks7o0C1XmaDmf
	 qYEkbqQd7GdObjT0ZHdhSZNT363OYvIiFu0xt707rlEIusOOTdrI0G9Kzo3vSNDzW+
	 3LJv2ZthJmLeiTqpLEJWC+BWErNvzMMtYL/+O1bfl/L75/L2v0kIFbuNbZJgQ8HLFp
	 mMRmJ1oaSSESokh+m6GQ+p+Zqtfg/GyER1+it3I7Nl3UmMIh6/w+M7JGRmRqd3ag1d
	 5fsjCYoL0+nvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD8839D0C17;
	Tue, 16 Sep 2025 01:30:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: ncdevmem: remove sleep on rx
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175798624749.559370.17464902751402604143.git-patchwork-notify@kernel.org>
Date: Tue, 16 Sep 2025 01:30:47 +0000
References: <20250912170611.676110-1-sdf@fomichev.me>
In-Reply-To: <20250912170611.676110-1-sdf@fomichev.me>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, shuah@kernel.org,
 almasrymina@google.com, joe@dama.to, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Sep 2025 10:06:11 -0700 you wrote:
> RX devmem sometimes fails on NIPA:
> 
> https://netdev-3.bots.linux.dev/vmksft-fbnic-qemu-dbg/results/294402/7-devmem-py/
> 
> Both RSS and flow steering are properly installed, but the wait_port_listen
> fails. Try to remove sleep(1) to see if the cause of the failure is
> spending too much time during RX setup. I don't see a good reason to
> have sleep in the first place. If there needs to be a delay between
> installing the rules and receiving the traffic, let's add it to the
> callers (devmem.py) instead.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: ncdevmem: remove sleep on rx
    https://git.kernel.org/netdev/net-next/c/17a0374be98e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



