Return-Path: <linux-kselftest+bounces-3645-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2428583E529
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 23:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5747A1C22D51
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 22:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE62250E8;
	Fri, 26 Jan 2024 22:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIZJm56P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9401124215;
	Fri, 26 Jan 2024 22:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307626; cv=none; b=HqqLtb7k5LjNu56jhVuaMdYt8gmZGBiw8+maQA+UJOMiDmBiQX51mGiZRvI9whOelZlRN0UasWVOMzJxMtdGgaIlvNb/sr1Nnd0vMviWYTOJ2ejXJ5f9+bMCkFOAv8P0M1DpnX7C0dnhk/1eolBZTNKzicAC6Oknw5IJDFIlSE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307626; c=relaxed/simple;
	bh=GF3dyQHdeQK7OSaVhuQgsghfdn/H2481COs+XyOqENo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Sa3LogX8kymFsmiXCjBugrp0Jkwo5XO2cq0jxJ9/3Fjlh4zL21yFCo07M5vBUw6JUV0GtugO9zLR6Th7m+tJcIma0QMv6YXg1CBg7QeA3xH+0GpGKKuapztP0l9UTdIC3d2+u9tI4TAWhOWeNEArfNR57Ro2b6UmM2k969MegI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIZJm56P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B12AC433C7;
	Fri, 26 Jan 2024 22:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706307626;
	bh=GF3dyQHdeQK7OSaVhuQgsghfdn/H2481COs+XyOqENo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CIZJm56P8iCYf93mzEmJfIJV2RtmTQL8/L9SRQ1gd+o+BgQkme7pEuXBy2psEgy/y
	 gM9Mgjbs+3yUm3xLJeIB4k2hAp3gqe7sisaZmg5adaYBZxHiHotToSbfiWSbpArdI0
	 souweHnO6v6Lmk5AoVeEGvr3eT8Ad5nh3HyIWCLPxbBYJJItBLZNLj2YUveKxeLnMb
	 o+WhRf9Kc6f51pUjdAHJ7dLAWrIry+Tq2JS76xXEtoziVVHNicma1ht7bvTfCFBiL5
	 B5VfsboxSioKo7wZta9tAq4XwsgBtU6129EIxQIfFNj82pgVDWaq2hSa946zWIMHEt
	 4Nb19qq4IWfqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 12143D8C962;
	Fri, 26 Jan 2024 22:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: net: give more time for GRO aggregation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170630762607.31948.15624424564037897496.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jan 2024 22:20:26 +0000
References: <bffec2beab3a5672dd13ecabe4fad81d2155b367.1706206101.git.pabeni@redhat.com>
In-Reply-To: <bffec2beab3a5672dd13ecabe4fad81d2155b367.1706206101.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 25 Jan 2024 19:09:06 +0100 you wrote:
> The gro.sh test-case relay on the gro_flush_timeout to ensure
> that all the segments belonging to any given batch are properly
> aggregated.
> 
> The other end, the sender is a user-space program transmitting
> each packet with a separate write syscall. A busy host and/or
> stracing the sender program can make the relevant segments reach
> the GRO engine after the flush timeout triggers.
> 
> [...]

Here is the summary with links:
  - [net] selftests: net: give more time for GRO aggregation
    https://git.kernel.org/netdev/net/c/89abe6283753

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



