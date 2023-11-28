Return-Path: <linux-kselftest+bounces-689-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 974177FB009
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 03:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8AC51C20DFC
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 02:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C07F566E;
	Tue, 28 Nov 2023 02:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNNJ1vf6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA0F53AB;
	Tue, 28 Nov 2023 02:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3F0CC433C9;
	Tue, 28 Nov 2023 02:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701138029;
	bh=MX6JF8VCP5UU3YcF6Y4EjwlyajsBhh+XjE1CTILOLXQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FNNJ1vf6t987kHONgBTEzFgvYj5QQoLMajTnl31KH6EaWn+OkdpzUcnOaZAxaHAv8
	 sOtN5P0yEeOWYRP2rQ46n24IJAWTchCG9uSGUXKbYWbhTta9TBSjDLOS0V4Dt0EzFS
	 OuoITDCA8Wh/R71TY0SX0CqtvfpZbgppWZa29xjsFOOCPY94SwPkCmTUUWmDBMnruI
	 m1R/ON4TELgRrNdAA5bzfaE91gfrbZu56eb9NOVoaxK40lVV4Yqf2C5p84sv345M2X
	 JoXgWp8VL6f1pADh8ZSjybBWDtjrGDI/HEihbH8E95e8CbWFnuH57w1igz9IZvXx4I
	 ZEXVo3sWfuL6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DEFDCE11F68;
	Tue, 28 Nov 2023 02:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] selftests: tc-testing: updates and cleanups for
 tdc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170113802890.29254.11697314055682451731.git-patchwork-notify@kernel.org>
Date: Tue, 28 Nov 2023 02:20:28 +0000
References: <20231124154248.315470-1-pctammela@mojatatu.com>
In-Reply-To: <20231124154248.315470-1-pctammela@mojatatu.com>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 llvm@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 24 Nov 2023 12:42:43 -0300 you wrote:
> Address the recommendations from the previous series and cleanup some
> leftovers.
> 
> Pedro Tammela (5):
>   selftests: tc-testing: remove buildebpf plugin
>   selftests: tc-testing: remove unnecessary time.sleep
>   selftests: tc-testing: prefix iproute2 functions with "ipr2"
>   selftests: tc-testing: cleanup on Ctrl-C
>   selftests: tc-testing: remove unused import
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] selftests: tc-testing: remove buildebpf plugin
    https://git.kernel.org/netdev/net-next/c/a79d8ba734bd
  - [net-next,2/5] selftests: tc-testing: remove unnecessary time.sleep
    https://git.kernel.org/netdev/net-next/c/8059e68b9928
  - [net-next,3/5] selftests: tc-testing: prefix iproute2 functions with "ipr2"
    https://git.kernel.org/netdev/net-next/c/56e16bc69bb7
  - [net-next,4/5] selftests: tc-testing: cleanup on Ctrl-C
    https://git.kernel.org/netdev/net-next/c/501679f5d4a4
  - [net-next,5/5] selftests: tc-testing: remove unused import
    https://git.kernel.org/netdev/net-next/c/ed346fccfc40

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



