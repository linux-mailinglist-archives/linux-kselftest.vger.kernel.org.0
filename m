Return-Path: <linux-kselftest+bounces-15579-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E54BC9554E9
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Aug 2024 04:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21D611C21EF6
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Aug 2024 02:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF7B2D052;
	Sat, 17 Aug 2024 02:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9kRZ9bc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1546A22334;
	Sat, 17 Aug 2024 02:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723861832; cv=none; b=eeCNsi/lDM+pIVBoQOxvAzLN110Glzf7+r5f0yYYfzlnEbZW1pwHVmbuh6ikOlHqYI19X7UIfGaizK6qjAEXT+A5tB+ADLGW2AF1Fn5BbDtW0bTrMxYaERRik2IPYaaoqIeM7k7LCUCZSdxQe7zCPDkScuo29x5VBmp+p4XEtwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723861832; c=relaxed/simple;
	bh=qEThM5wF/4hXYp0I9Q099Fdvz7PJmrPy1tt3ujM2jGA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oa5K5I/dz9VLiKYFZ8LwWK7xTAqjWbPRcA3tCxvtd1DpKPiA8SJM1E1EzQBAuCq+NsysyMGLkJjVgv9/Nyl5yDfQyRNur5LJoK0qb6ldNMsoalBFDGcA9f97PlKHoQz9wn3ttLhwzrIgfiLojJdS1R3VCKuRw/P8Fowtgvb7G4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9kRZ9bc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8BBC4AF0E;
	Sat, 17 Aug 2024 02:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723861831;
	bh=qEThM5wF/4hXYp0I9Q099Fdvz7PJmrPy1tt3ujM2jGA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u9kRZ9bc+aOfTtwWIrnGmoXB0eNbts4Cmnylp3kS1ikRNkbZd2eCMYnjU+HrnrDQp
	 EZj892mOUWA1cMhkihqNXUKG6vl/EYDyzuEB6/D85IwfW2gGHaQHq0g7eBuyAbjsTW
	 v3aL4KAayKD6d5xfp9sy85s4YEr3dXfqDoZOYoT5slEoCmJRXbgMVPo1DjSp5dacAi
	 wUTo2ZNxso2+upSUviRQSQ1EleGLfsoJQSMwzmPowypY6try5NcoCiJeb+mUvq/wTM
	 N6s6v8sAodwFpkmxz7YQY3AJxueH718qsAYl6nKI10WATvwXBqBkDoJCKsBB+AoBG7
	 vREGSLTtOlXpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BAD38231F8;
	Sat, 17 Aug 2024 02:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tc-testing: don't access non-existent variable on
 exception
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172386183098.3680864.16675070900562568693.git-patchwork-notify@kernel.org>
Date: Sat, 17 Aug 2024 02:30:30 +0000
References: <20240815-tdc-test-ordinal-v1-1-0255c122a427@kernel.org>
In-Reply-To: <20240815-tdc-test-ordinal-v1-1-0255c122a427@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 shuah@kernel.org, lucasb@mojatatu.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 Aug 2024 16:37:13 +0100 you wrote:
> Since commit 255c1c7279ab ("tc-testing: Allow test cases to be skipped")
> the variable test_ordinal doesn't exist in call_pre_case().
> So it should not be accessed when an exception occurs.
> 
> This resolves the following splat:
> 
>   ...
>   During handling of the above exception, another exception occurred:
> 
> [...]

Here is the summary with links:
  - [net] tc-testing: don't access non-existent variable on exception
    https://git.kernel.org/netdev/net/c/a0c9fe5eecc9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



