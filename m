Return-Path: <linux-kselftest+bounces-948-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0A88004BD
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 08:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66F6CB2122E
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 07:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D4D156E8;
	Fri,  1 Dec 2023 07:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtrdFlOR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D7A154B8;
	Fri,  1 Dec 2023 07:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18430C433C8;
	Fri,  1 Dec 2023 07:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701415826;
	bh=qrlzEsCKGvbySwOgzUXn+fQC104W7Fca0fsYXvPARZE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dtrdFlORFi6zU4bbhPY7cQrO/XelkBvLfsiMz8rWDOveuRP54FB6D5FkNDMf/6vn0
	 4IWh8OeLLU2NXJKz2/OqBjKV7DvG4QxLU7qgHefoMY10pXdzQxVlt763PPkl3K12vg
	 QjLRRkZglUHYuXG5Xgh4R6b+Yd12IiumcCkYk+gf7ssQUXqQli8A9mq713Pwa1PEvA
	 PnOV8P/n1kESGbIr1TWn65rXQ5vVBel0HUwSnWLVmK5CNPnp9Jm3xNWdILkZaenXvo
	 /jIX8kTYZM60t0b6rMFooa6y3o2C87eVdJcuFwFVZqUqTSRc5V2Zc5PBXVCVt9Zl6l
	 62HS5KkyxEIaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0647CC4166E;
	Fri,  1 Dec 2023 07:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] selftests: tc-testing: more tdc updates
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170141582602.8625.17576360369152020465.git-patchwork-notify@kernel.org>
Date: Fri, 01 Dec 2023 07:30:26 +0000
References: <20231129222424.910148-1-pctammela@mojatatu.com>
In-Reply-To: <20231129222424.910148-1-pctammela@mojatatu.com>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Nov 2023 19:24:20 -0300 you wrote:
> Follow-up on a feedback from Jakub and random cleanups from related
> net/sched patches
> 
> Pedro Tammela (4):
>   selftests: tc-testing: remove spurious nsPlugin usage
>   selftests: tc-testing: remove spurious './' from Makefile
>   selftests: tc-testing: rename concurrency.json to flower.json
>   selftests: tc-testing: remove filters/tests.json
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] selftests: tc-testing: remove spurious nsPlugin usage
    https://git.kernel.org/netdev/net-next/c/f7580f00cc6e
  - [net-next,2/4] selftests: tc-testing: remove spurious './' from Makefile
    https://git.kernel.org/netdev/net-next/c/74f7e7eeb1d2
  - [net-next,3/4] selftests: tc-testing: rename concurrency.json to flower.json
    https://git.kernel.org/netdev/net-next/c/7de8b2efafeb
  - [net-next,4/4] selftests: tc-testing: remove filters/tests.json
    https://git.kernel.org/netdev/net-next/c/0fbb5a54f941

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



