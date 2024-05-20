Return-Path: <linux-kselftest+bounces-10421-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C98968C9B83
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 12:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E4431F21733
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 10:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4EB51034;
	Mon, 20 May 2024 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubHyfK+7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854944E1CE;
	Mon, 20 May 2024 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716201627; cv=none; b=r7YgowKyhdFKQJ/+gOp9TjQUmjc7havktJsE4xcVvQDf3TOrG+JwKeN/Ybwg3dU8jLQdiYVWhnW1ZjdeD+fQ/CI4+OtiWp25BRiHBlwE5YChL+dJI6npFMtFKqH1fjSp8kOnO+u+weODCOuXryUWlVk8IhxTgJZ6ziwamNH06Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716201627; c=relaxed/simple;
	bh=Fn72sRJbBTtdMcN9t4cwebE1WPTps7u8azEPLXa+oRA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UiIHo/RQdl9hLyJ6p5m9O1+5Tit2uJLUFcJHra0S/DyEdEFX3Up1+uB1RA9YXvB0q1jYEMd4gzlWs29yGKAbjOCJKV48E+Jyyw4WAxqRHbU6Q6YUwx/X3H89ygf5XHsquPM6MQn3Kc2jD8NbLdWuGf7uuO7/uxCc4vUp3bFvtHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubHyfK+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07CBAC4AF08;
	Mon, 20 May 2024 10:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716201627;
	bh=Fn72sRJbBTtdMcN9t4cwebE1WPTps7u8azEPLXa+oRA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ubHyfK+7hSHxNl/rlgm3Gna53O3gfbf/NzOPvlHzmfF8bRQTsTmMh3WPC5zFDiqQu
	 4gYvoC7zFfx28uxe99sWGviZWnfXuDMkjhiKjWPkwOG4yz2dYy2gKuNXene1BChc39
	 Mwj9J0iGns+TTaB00dBPy1J9O8NP2g2lYlUDbSrW20kytTFHtRYZNlctweidIeyBZQ
	 PpReZStCQIS6yghGHd03MVvOlZMFtEwHlenuIXwOSRsAfnyqyCJXJAGB9H7/Uyl7m/
	 XARwO2kcOgzODwbA0t30FMqThs6DWd7pynukSN6BRk971ssaXwO9PAeKZnGulLJKgL
	 ij9GtL3jAju6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E3321CF21D8;
	Mon, 20 May 2024 10:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] selftests: net: kill smcrouted in the cleanup logic in
 amt.sh
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171620162692.11269.9908896463327696163.git-patchwork-notify@kernel.org>
Date: Mon, 20 May 2024 10:40:26 +0000
References: <20240518132052.1293474-1-ap420073@gmail.com>
In-Reply-To: <20240518132052.1293474-1-ap420073@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 18 May 2024 13:20:52 +0000 you wrote:
> The amt.sh requires smcrouted for multicasting routing.
> So, it starts smcrouted before forwarding tests.
> It must be stopped after all tests, but it isn't.
> 
> To fix this issue, it kills smcrouted in the cleanup logic.
> 
> Fixes: c08e8baea78e ("selftests: add amt interface selftest script")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net,v3] selftests: net: kill smcrouted in the cleanup logic in amt.sh
    https://git.kernel.org/netdev/net/c/cc563e749810

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



