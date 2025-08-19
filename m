Return-Path: <linux-kselftest+bounces-39266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA28B2B58B
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 02:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D167167A4F
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 00:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63A9189902;
	Tue, 19 Aug 2025 00:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjP8roxh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A710B13D51E;
	Tue, 19 Aug 2025 00:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755564605; cv=none; b=BO42qCoAoHBiYkQSNc6ENvPmsIjz6K9R/QvbkXWcAGg8useyJKc9Rym374cHQY9rdd8d8yb0KdzrfGfb56zjwpOfS1lgZa9bSEw6PnftHVZ3/sCXk6MSW6bBNzgy71mdzfyEpsxtVRjLn/valQ2XmD4olPEVaQhGT/a0MFBQCyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755564605; c=relaxed/simple;
	bh=tTKzEG7zl836WnweAKXGMrMXHoRDuAgoB+5V9lt1V5s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LvmT++V+yJbscXfPddR5iCNl+ZcB59cdy1f8oO+2rdfaXvqcSv340Dq0dHxG1sxNh1woglr30LIbk2eRSYsiNUTkVjLcFpAKDz2JEEmbeHOFtp6MR3vk4oD95Q1+3v6mFHuXCwwsfP5ClxA4NKM0lmE7oSg4S+y3ikCwYbtAS9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjP8roxh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CFEC4CEEB;
	Tue, 19 Aug 2025 00:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755564605;
	bh=tTKzEG7zl836WnweAKXGMrMXHoRDuAgoB+5V9lt1V5s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CjP8roxhSRFFleZTXw0+0Rz4hU5ly8A8OmNCRxXUSKihGqVXpCbmbEopnF2vLXd9E
	 9p9LFtYYkhBd2E+74Gb4yVLiZrfd4OJy/Ih4uM08zsokdGBsqGefyYYceNxdFZmkm5
	 /leufJ/utKPYV+XNqJFzYj6TbEHF25ad4IgPcyDGE6IesI56AkZgv1LtkVpXp76MKt
	 PKCO6aVv+/roD+njL3BTUvxOebaz9INeC3G5prE5LtxKBUokLg4LP/6Pg1WhfGd4h+
	 vgWWFsaoq0InRPiHChBAqhsEZg64BKU9fCxPH/S6xvUXLJ/V7Ah45OxJOTltdr9p5D
	 XqX2EX01VxIgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E25383BF4E;
	Tue, 19 Aug 2025 00:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/8] mptcp: misc fixes for v6.17-rc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175556461525.2964462.14246574540734347809.git-patchwork-notify@kernel.org>
Date: Tue, 19 Aug 2025 00:50:15 +0000
References: 
 <20250815-net-mptcp-misc-fixes-6-17-rc2-v1-0-521fe9957892@kernel.org>
In-Reply-To: 
 <20250815-net-mptcp-misc-fixes-6-17-rc2-v1-0-521fe9957892@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, wujianguo@chinatelecom.cn, shuah@kernel.org,
 corbet@lwn.net, pizhenwei@bytedance.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org, cpaasch@openai.com, stable@vger.kernel.org,
 dreibh@simula.no

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 15 Aug 2025 19:28:18 +0200 you wrote:
> Here are various fixes:
> 
> - Patch 1: Better handling SKB extension allocation failures. A fix for
>   v5.7.
> 
> - Patches 2, 3: Avoid resetting MPTCP limits when flushing MPTCP
>   endpoints. With a validation in the selftests. Fixes for v5.7.
> 
> [...]

Here is the summary with links:
  - [net,1/8] mptcp: drop skb if MPTCP skb extension allocation fails
    https://git.kernel.org/netdev/net/c/ccab04469798
  - [net,2/8] mptcp: pm: kernel: flush: do not reset ADD_ADDR limit
    https://git.kernel.org/netdev/net/c/68fc0f4b0d25
  - [net,3/8] selftests: mptcp: pm: check flush doesn't reset limits
    https://git.kernel.org/netdev/net/c/452690be7de2
  - [net,4/8] mptcp: remove duplicate sk_reset_timer call
    https://git.kernel.org/netdev/net/c/5d13349472ac
  - [net,5/8] mptcp: disable add_addr retransmission when timeout is 0
    https://git.kernel.org/netdev/net/c/f5ce0714623c
  - [net,6/8] selftests: mptcp: disable add_addr retrans in endpoint_tests
    https://git.kernel.org/netdev/net/c/f92199f551e6
  - [net,7/8] selftests: mptcp: connect: fix C23 extension warning
    https://git.kernel.org/netdev/net/c/2eefbed30d46
  - [net,8/8] selftests: mptcp: sockopt: fix C23 extension warning
    https://git.kernel.org/netdev/net/c/3259889fd3c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



