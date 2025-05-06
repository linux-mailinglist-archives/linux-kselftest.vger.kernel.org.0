Return-Path: <linux-kselftest+bounces-32492-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED24AABECF
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 11:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC1B452111F
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 09:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE77627AC4A;
	Tue,  6 May 2025 09:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/P3/SzQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988CF27AC39;
	Tue,  6 May 2025 09:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746522589; cv=none; b=jGdjGRHYwdQcN9m2o0D1CrUVbMM9GsbwecSryD7Is7EN5gzFfYh/G3Bl0V3Zj7ow6N+9ceDsLbeZJAD2TX25nYapOLaouT53cGb7GIlxSvc9We54jiiK+0KppCwA10oKUfOKAYBnFP6pRCRGLZKXc5vMme4HKQkMwEsi45zVpr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746522589; c=relaxed/simple;
	bh=IBLkt51Dqj+Vf4R1YuGGgimLITou/R1H7/TssLq0RZQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PqM4F2V+nrA6BhzDuSHyWAm4Y7Kw0Hars6i/fh4/s4nn3zE9Pl0otKapSDfdgIuqtEJiIPRY4PGRLoHDxV96rDX5x5b10+VDyH1C0fpRjoTc/IG6NZtmo7H1u7i7+1Ny6dxs29bsm8obA9uLHlR7mBCd/tFo/kY8XBN2KuE4SnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/P3/SzQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1A5C4CEE4;
	Tue,  6 May 2025 09:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746522589;
	bh=IBLkt51Dqj+Vf4R1YuGGgimLITou/R1H7/TssLq0RZQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U/P3/SzQ9WFqJg7GUSCU1ZVtqUaQJQvYlPprT5WD9Iy/ID6bhk9wYk8gcY794F32/
	 //ZcxEzsIb95ZB2+YzPPx+qtP9zhxTJTSEjfsehOHSqmJ//U+GgXh72iK6pIsb5MPb
	 ZXfyErnkW0APWhnZP26f6MHf3HVrUMfW3aeonCO9uLfX07ZEcVr4aZn2/1fKZLkCGn
	 7uXVrDVW88OU8M89fMPOGtUtu1GshQ1HL/Lu6WQbL5RTRsp00qwO8eZj57nn4T0c8Y
	 1x4NJdDCa1niL7Qo9u1tSHzI6rEldE4X8jOmZYD5MFDpt3NTCHhh/QQuuHmEJI3YU1
	 XZSkKwbMte+9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70AF13822D64;
	Tue,  6 May 2025 09:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] selftests: net: exit cleanly on SIGTERM / timeout
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174652262825.1103429.14575554229344854706.git-patchwork-notify@kernel.org>
Date: Tue, 06 May 2025 09:10:28 +0000
References: <20250503011856.46308-1-kuba@kernel.org>
In-Reply-To: <20250503011856.46308-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 ecree.xilinx@gmail.com, petrm@nvidia.com, willemb@google.com,
 sdf@fomichev.me, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  2 May 2025 18:18:56 -0700 you wrote:
> ksft runner sends 2 SIGTERMs in a row if a test runs out of time.
> Handle this in a similar way we handle SIGINT - cleanup and stop
> running further tests.
> 
> Because we get 2 signals we need a bit of logic to ignore
> the subsequent one, they come immediately one after the other
> (due to commit 9616cb34b08e ("kselftest/runner.sh: Propagate SIGTERM
> to runner child")).
> 
> [...]

Here is the summary with links:
  - [net-next,v3] selftests: net: exit cleanly on SIGTERM / timeout
    https://git.kernel.org/netdev/net-next/c/8f0ae19346ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



