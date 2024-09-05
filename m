Return-Path: <linux-kselftest+bounces-17336-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEE296E5A9
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 00:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 886581F240E5
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 22:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1280D1B2EE8;
	Thu,  5 Sep 2024 22:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEtlwGH/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0C019EEC8;
	Thu,  5 Sep 2024 22:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725574237; cv=none; b=qG/y6+aCbDFIlodnqBA6zoZ0r0dMgdwaefw4tJaMPrg+yMsN3j3c/BTZdJdz6Wqr2mAr5s8Ody27YpidQhg1jtGmssan6LOuJ9/Mv7y6V+npPY4xxPYRDwKUMB5Mb6wdaBFMeukPEa/EgJeM/OD45xffpWMO5NxneOLLv0xj29M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725574237; c=relaxed/simple;
	bh=p5VMs64NJzqCs9tiHDeAgq9x7XJTzxC7nHOkCZ5q1u8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WO1Jt6yPUlB/grux4Y0YmMTgO+/6yqRFxlPOZo2JX0uo3aNOo3y/Q3yIbyGkLYhg6J7NomOy3lnZbu+8zonmxdEc715lUs/dd2tBEpUcnUNlPNlNSXPVf8gRcTWx0XW1CvIBr9FUGkPwLlBAfuaNFxMxnv09JOyUO8nf7jnIBHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEtlwGH/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2F3C4CEC7;
	Thu,  5 Sep 2024 22:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725574236;
	bh=p5VMs64NJzqCs9tiHDeAgq9x7XJTzxC7nHOkCZ5q1u8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FEtlwGH/ceZt2U4TtpoTHhrd3h/DFtmxG77DkzG00yCOB/R2dAp2cKIqEASw9iNvx
	 04N6hLJl/mNxQ2Izkfu+BpMPU2OxzyqhSLXWVN3bzKhmBsUWM3XvlLVQQ49A3N4CDt
	 oY2s37V55jy2x/X4xJf0JlroPtdWYC+gFQFzLHw5KVv1tJeN9n/eVy7jLZWBUD3JaY
	 BbhlM5D9GVGz8O5byfUH9inkL6ZlHra9DOp6ZQ61VHRlapp31LqtGAcynVG63pXUnQ
	 2jJXIhylSnvzBJcQ9TpHmU9k/J0kYFN262ORD4fRi1XUP9nA8/ad2D4VczvV9SDZYt
	 1rV7GnVmYnj/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E8F3806654;
	Thu,  5 Sep 2024 22:10:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: net: enable bind tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172557423699.1859883.10700910912228977828.git-patchwork-notify@kernel.org>
Date: Thu, 05 Sep 2024 22:10:36 +0000
References: <5a009b26cf5fb1ad1512d89c61b37e2fac702323.1725430322.git.jamie.bainbridge@gmail.com>
In-Reply-To: <5a009b26cf5fb1ad1512d89c61b37e2fac702323.1725430322.git.jamie.bainbridge@gmail.com>
To: Jamie Bainbridge <jamie.bainbridge@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, kuniyu@amazon.com,
 joannelkoong@gmail.com, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Sep 2024 16:12:26 +1000 you wrote:
> bind_wildcard is compiled but not run, bind_timewait is not compiled.
> 
> These two tests complete in a very short time, use the test harness
> properly, and seem reasonable to enable.
> 
> The author of the tests confirmed via email that these were
> intended to be run.
> 
> [...]

Here is the summary with links:
  - [net] selftests: net: enable bind tests
    https://git.kernel.org/netdev/net/c/e4af74a53b7a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



