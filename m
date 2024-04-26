Return-Path: <linux-kselftest+bounces-8963-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D67858B42A7
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Apr 2024 01:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 140C01C20DFA
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 23:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B96C3B782;
	Fri, 26 Apr 2024 23:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZR9W46S8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FD43987B;
	Fri, 26 Apr 2024 23:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714173629; cv=none; b=OS27Pl8aGWYPp3c3ndfYHjONIcGYm+3wpDWdIXhOPn2koIFyzk0evo9j4rTJzDNoTkfZcw1UMaUhbD8vpoFPEEMicIhfua87WfwsfzM3kZMer28enOybghaVLddB1RvLGY7rhtxYK4+AhmjTtXLL65fTnpx7kw7Pr5CB0EuDR/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714173629; c=relaxed/simple;
	bh=4y3un6ZRqwb+UCVBbKv8v3i/JFdMcz6sCg5DTCVmAgY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Oy149nqtfU8k+wsatgfZUA+Xp4TNROZZoHrYnhNCxULs2wJR07ILTlk1bS5AEihbaYSdLue64Y6AYpQzuBUhENWjS8ms7RgihzBTbj45niU1BPhSs0lDzCU22JJc5m4G1BN/684Jh2gFgfwmEs5YqGjejXYa5egmJ6BfrbbnV7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZR9W46S8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95DC4C113CD;
	Fri, 26 Apr 2024 23:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714173628;
	bh=4y3un6ZRqwb+UCVBbKv8v3i/JFdMcz6sCg5DTCVmAgY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZR9W46S8XtEoLsAs1lejcPu7DZ/SWzAb+3Du8JSqqUVPDrSKDzifF8e6EnKbkmVQw
	 0FAKT8RTIKJojxjUg6bush8FwokQ6S/90Yc9sPVujVqF+WIrC7f/cytZ+RzxDjFJWy
	 /CDBQkqFV9ujliMk5OPsEUdCJm/9k2FzdhJtjLUETL+vntTYdmwRthkIZ9Q+Nz1g8H
	 a8axLzLAN6uzhtFEoBTsoRh+kF7QT8LDLKUZVMrwXnTPlV3KI2mtyQTKEtz1yB/TZH
	 x0iPQUrKDyI0iFC81S0DD6Gb2hR38ZimFo69zrnbGOgWW3q1VHnQPqoRS0DJD6+uD4
	 saTDcuUSflKxg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A8C7C433F2;
	Fri, 26 Apr 2024 23:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] selftests: drv-net: round some sharp edges
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171417362856.13639.7931748739054253694.git-patchwork-notify@kernel.org>
Date: Fri, 26 Apr 2024 23:20:28 +0000
References: <20240425222341.309778-1-kuba@kernel.org>
In-Reply-To: <20240425222341.309778-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, linux-kselftest@vger.kernel.org,
 willemdebruijn.kernel@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 25 Apr 2024 15:23:38 -0700 you wrote:
> I had to explain how to run the driver tests twice already.
> Improve the README so we can just point to it.
> Improve the config validation.
> 
> v2:
>  - use split() in patch 2
>  - more validation in last patch
> v1: https://lore.kernel.org/r/20240424221444.4194069-1-kuba@kernel.org/
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] selftests: drv-net: extend the README with more info and example
    https://git.kernel.org/netdev/net-next/c/f8ac9b0fab33
  - [net-next,v2,2/3] selftests: drv-net: reimplement the config parser
    https://git.kernel.org/netdev/net-next/c/64ed7d819061
  - [net-next,v2,3/3] selftests: drv-net: validate the environment
    https://git.kernel.org/netdev/net-next/c/340ab206ce5c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



