Return-Path: <linux-kselftest+bounces-10817-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C6E8D2B32
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 04:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970561F25300
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 02:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0026615B0F1;
	Wed, 29 May 2024 02:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stLgc4c9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86AE15B0E1;
	Wed, 29 May 2024 02:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716951419; cv=none; b=tGWYINwhmjuNEUZ01FLBtwl9DHEmIGhGxwCeXsY+e5yVy7Nw9tWr21dVltTx+yEHiSQBU4zi6CdyIR78iAz1/KU24THRxkGlPvW0+/aOhPxJlonRemXynvjTMa8sZ/0XZO/05viavH4EKA4rSFX4X+JF8r+9+E/GlcebfSn2Nes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716951419; c=relaxed/simple;
	bh=S5Btife71DgUL3jeAw1NJHV+v5fJxvN8BEX6FGKkdgU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DznpvJVixo6elBE27/tXx//oxnEBDEuBs8YoLlGv6SDzL3HfRoGMErlN767/an0tLHL6SuxDtzeF9NyvWwlziey+4wCc670m/Aq0KD5YOuFit+OBn5LREyoLEaHfde4gVMlZeSMiNvt+HNGkr5UKu1G10OPKBAt4GyQLOWyTSgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stLgc4c9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39192C32789;
	Wed, 29 May 2024 02:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716951419;
	bh=S5Btife71DgUL3jeAw1NJHV+v5fJxvN8BEX6FGKkdgU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=stLgc4c9ZulfUZZg1BNvNqfD2ytgI9Bkrav/OwU3fZvugX0rJjH34WDya2T3M0DMH
	 B8r9J0+C10uBtNnvX33wN/DsTwTSP7U+gTgKprohEeWbqs0qiABqjHYobtpczao+J2
	 V8dS1+u9om3DTAIoBFXtta3kNTzRGjSUXiqKK2PJWHgM/f5rz+ZinSIsuwR6Q1eqoI
	 1hA1d5FltozUCTw4Yzadf+K1VdNMRw4RrZy0THWlotuklBjUJ2YoF/BhZSAtEWVkIh
	 ZTcsQIlNMa6QB/Yqgez4rBBxRohlwj0RPaKNDewdBxAdvxuaOnIQDCxvkc5HJduBAH
	 UHevDawVVeAaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 271A4C4361C;
	Wed, 29 May 2024 02:56:59 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] net/sched: taprio: make q->picos_per_byte available
 to fill_sched_entry()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171695141915.13406.10629530415930321270.git-patchwork-notify@kernel.org>
Date: Wed, 29 May 2024 02:56:59 +0000
References: <20240527153955.553333-1-vladimir.oltean@nxp.com>
In-Reply-To: <20240527153955.553333-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 vinicius.gomes@intel.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, pctammela@mojatatu.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 May 2024 18:39:54 +0300 you wrote:
> In commit b5b73b26b3ca ("taprio: Fix allowing too small intervals"), a
> comparison of user input against length_to_duration(q, ETH_ZLEN) was
> introduced, to avoid RCU stalls due to frequent hrtimers.
> 
> The implementation of length_to_duration() depends on q->picos_per_byte
> being set for the link speed. The blamed commit in the Fixes: tag has
> moved this too late, so the checks introduced above are ineffective.
> The q->picos_per_byte is zero at parse_taprio_schedule() ->
> parse_sched_list() -> parse_sched_entry() -> fill_sched_entry() time.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net/sched: taprio: make q->picos_per_byte available to fill_sched_entry()
    https://git.kernel.org/netdev/net/c/e63413418088
  - [net,2/2] net/sched: taprio: extend minimum interval restriction to entire cycle too
    https://git.kernel.org/netdev/net/c/fb66df20a720

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



