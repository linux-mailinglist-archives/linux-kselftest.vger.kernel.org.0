Return-Path: <linux-kselftest+bounces-4573-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0224F8539C2
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 19:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC989B21750
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 18:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF820605C6;
	Tue, 13 Feb 2024 18:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lneCGLnX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97382605C2;
	Tue, 13 Feb 2024 18:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707848428; cv=none; b=K+k5P5g2cHrwrre37Fpc/G6Q9Al9coYCP/oHIaFcfaLkHN8LHhzA9myB7UMiZ2cMWsbMUEFjdE7ibYXNQXiKwlYp8fO04kzKLRaguakUbAIoY2uZD7i9U3kqoDPQJ2UfxwySBM/+Do0F1I+rLmpGjI4BXHbPJIrCyQ4BibaaT+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707848428; c=relaxed/simple;
	bh=D7VWw6OUR63KfFGyZ4wX5dRIQR0q/yLmEzyd5gojiDo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Uk34AA4DAVKLiPkbQSLHsW6YNefd0yAjjYM+IcgspXX5UkvcjcnKZuohM2SAQC7rFMgbRsSKGHqdhoB2MAXVjwLzGwuAYYL86WixcAqCQ8IVNZFuE/XQk2RXXO1JTBqI47rJ51Dh+pWbxjVgbi74zpdR1hZQJFO1EnRnFhadSuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lneCGLnX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FE77C43390;
	Tue, 13 Feb 2024 18:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707848428;
	bh=D7VWw6OUR63KfFGyZ4wX5dRIQR0q/yLmEzyd5gojiDo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lneCGLnX7lv/8OQ519hDCaAoMVrozakbFNDiwwXVWFnH8YEbT+5aIzS5uvyDStbv1
	 ++BACJ+MiKuvJTaeg7VKmGVOYctdGvALajHjXTN8h68PM1+eiXx22zsy7RWxWVgRYi
	 ohenwcydvpMi6jBkKbzz69J0gtrN16ngW5EQcyF6OSOw4/g2E9znLthiDpEOQaEn84
	 +Wzwr5wP87oqU6my727f6xS920Pf6Np3ygOX80F41KfO3WhpRDJeLxvAzbV3HnlFBK
	 VwLGmXhTWb5592a2cReh52dUroNJr5Fh6YlczojcN0Ky5gUOfxRTOqe1/SCTuzFwK9
	 49PvbzHkW3vSw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05B03D84BCF;
	Tue, 13 Feb 2024 18:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] selftests: net: cope with slow env in gro.sh test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170784842801.32476.7295008627532134278.git-patchwork-notify@kernel.org>
Date: Tue, 13 Feb 2024 18:20:28 +0000
References: <97d3ba83f5a2bfeb36f6bc0fb76724eb3dafb608.1707729403.git.pabeni@redhat.com>
In-Reply-To: <97d3ba83f5a2bfeb36f6bc0fb76724eb3dafb608.1707729403.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, shuah@kernel.org, willemb@google.com, lixiaoyan@google.com,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Feb 2024 10:39:41 +0100 you wrote:
> The gro self-tests sends the packets to be aggregated with
> multiple write operations.
> 
> When running is slow environment, it's hard to guarantee that
> the GRO engine will wait for the last packet in an intended
> train.
> 
> [...]

Here is the summary with links:
  - [v3,net] selftests: net: cope with slow env in gro.sh test
    https://git.kernel.org/netdev/net/c/e58779f47e5e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



