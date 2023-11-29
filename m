Return-Path: <linux-kselftest+bounces-848-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CB57FE407
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 00:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85BCA1C209FB
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 23:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C574F40C05;
	Wed, 29 Nov 2023 23:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDfFq5Ay"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41D83B286;
	Wed, 29 Nov 2023 23:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A5C9C433CD;
	Wed, 29 Nov 2023 23:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701299427;
	bh=X0xsaihZLxbejZhUDUE+jix1RNEYoieNhSk1OdYX2S0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UDfFq5AyYTvbiyOBou/Q7jWiGqGqBqvDZUVwp8hCgpGbCJmQ10ZG8BREhvd47Wkgm
	 d2kt4b9CBOM1HVufQOBPcgPgCb6h4DCO0kqQOzQ+nGblvvQH7UEiPyna56SW1F94y8
	 dCO+b5KbhMIGjJiYyNPANrYQiNlgHxmyG/V0V0ZP6LUk/YxWWZ/WTwdMXQ5poX8Til
	 7yYRrL8zbvlxxmEJpyeVdbfduwybo8hxUnqESPEA5YZwbTW6AJj8vDodSmENJuDVxM
	 +R5xzfF2QcSN8jJFdS67B6fBD0dzB95b+ZB1u8TgtnkZjDr4nir1QvDDhx/vqDauat
	 RR9MHzZrcz4Fg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4AE62DFAA81;
	Wed, 29 Nov 2023 23:10:27 +0000 (UTC)
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
 <170129942730.25575.6015278555494225443.git-patchwork-notify@kernel.org>
Date: Wed, 29 Nov 2023 23:10:27 +0000
References: <20231129222424.910148-1-pctammela@mojatatu.com>
In-Reply-To: <20231129222424.910148-1-pctammela@mojatatu.com>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

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
    (no matching commit)
  - [net-next,2/4] selftests: tc-testing: remove spurious './' from Makefile
    (no matching commit)
  - [net-next,3/4] selftests: tc-testing: rename concurrency.json to flower.json
    https://git.kernel.org/bpf/bpf-next/c/b5145153a7f3
  - [net-next,4/4] selftests: tc-testing: remove filters/tests.json
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



