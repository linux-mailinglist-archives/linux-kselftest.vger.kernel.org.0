Return-Path: <linux-kselftest+bounces-15795-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A24F795907F
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 00:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D55171C208D1
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 22:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8041C8FAB;
	Tue, 20 Aug 2024 22:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8CPE58u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18D83A8D2;
	Tue, 20 Aug 2024 22:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724193035; cv=none; b=GEW823XSQSEkWkgGMwmkbJXQ99a2aYnrNuL6wGo67iNmJ1lN06BHpvef0qDvVOweYmUwv5s6+qEpmHrpAWW+Bwrgh9JeJG7SFd1QVG8ZabiDDE2OlWWI3qXSagxDIdoZ5IOhngcYP4UXeV8vpH5FCdeBCvglQ3lDQzQbriiTIHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724193035; c=relaxed/simple;
	bh=OafcNw8/JtSF8qeW2Gwmej7hjpv13TKhj/26pNitPzI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=vEbV9pdq14jnfKVW61yK9OjyNp9HaTtCp+uzj4zkn9PVzfS/pwKYIwL36+kC8OdwliSrcM4zRHr7JaT5To72t9/tXAFDNd+EIicnyZaPDddD6B1vFXMvS4TwEfPm5orQ8SVc9/Scui0Ad/uLTH+xziEJyDJxf5Zd9VmeT87O1qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8CPE58u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B66C4AF10;
	Tue, 20 Aug 2024 22:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724193035;
	bh=OafcNw8/JtSF8qeW2Gwmej7hjpv13TKhj/26pNitPzI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k8CPE58u5isYcfdqZ68oo3fAU3jLWOIEN7CCcGHYIO3LFpfKA9h5UNn0Q1k36PlLo
	 boJ+thl9Y+kW8QQWxBLRSCMmkT1o4pdWDCVjfbbd0Cw5qYlcU8uXUopgzaEAjqp71L
	 +y+moRhJDSHE795wQyf6i6X5M+7Ll8ozE0vqLTbCIJb2BUA+UtW5Jz+0sCyAwPYDrj
	 3EveOqwPTseoIOvp7X/ysFiPQ7QIz/gmVqGKXR5AooA4WZtYbhAIqCWw5hy7qrYBWt
	 wjIsQN3vI82AAvic/XxEvY1G7EwY5zVp81ChWE1Yo63Q6N+HzmL6jAkmJNuDQ6keju
	 lwOoPsjytRsnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F463804CAE;
	Tue, 20 Aug 2024 22:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: net/forwarding: spawn sh inside vrf to
 speed up ping loop
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172419303375.1256151.2518519355159442997.git-patchwork-notify@kernel.org>
Date: Tue, 20 Aug 2024 22:30:33 +0000
References: <20240817203659.712085-1-kuba@kernel.org>
In-Reply-To: <20240817203659.712085-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, idosch@nvidia.com,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 17 Aug 2024 13:36:59 -0700 you wrote:
> Looking at timestamped output of netdev CI reveals that
> most of the time in forwarding tests for custom route
> hashing is spent on a single case, namely the test which
> uses ping (mausezahn does not support flow labels).
> 
> On a non-debug kernel we spend 714 of 730 total test
> runtime (97%) on this test case. While having flow label
> support in a traffic gen tool / mausezahn would be best,
> we can significantly speed up the loop by putting ip vrf exec
> outside of the iteration.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: net/forwarding: spawn sh inside vrf to speed up ping loop
    https://git.kernel.org/netdev/net-next/c/555e5531635a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



