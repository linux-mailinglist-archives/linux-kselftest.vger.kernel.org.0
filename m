Return-Path: <linux-kselftest+bounces-32889-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38ACEAB48BC
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 03:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E122E8C3D24
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 01:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E29118A6A9;
	Tue, 13 May 2025 01:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxM2OpZa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B59D18801A;
	Tue, 13 May 2025 01:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747099204; cv=none; b=t/Ur1COhyAwgcbXxztanGBOjuy+DoLDU7K3Qlvz1LCf27e5HPTJ1fiYn49VAQ0jQjvyWZV9q5kZ7y2UMglavBLlFd0noIilCXvnX1hE+4KH7hNlXwdvD2Pm+CbWxY77vJZnOroy9LT/GEnYdmEAb3S5R8z99XQadiozreNlN3ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747099204; c=relaxed/simple;
	bh=sslyGTU85f2eU24gI1dxVCSsgVSNmlvtO/AEU8RERzQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=obJB6pBUbKBZbVWYz2JAncfz1NCobJVYL07C67J7RBTiIoCRxyoF4MuCxTu+2gRvkAjnYCT/1S0YYNAAuTepBqqlx5YR4qozM+CraBcxyN7vvhFYvnm6sXhhVyxkdSMNbdDuuWTiyXgi73F91XVx2s8KZqDTyzcXg5T66uHoNhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxM2OpZa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091DFC4CEF0;
	Tue, 13 May 2025 01:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747099204;
	bh=sslyGTU85f2eU24gI1dxVCSsgVSNmlvtO/AEU8RERzQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mxM2OpZaul2K7xqeHDEAMMXW8aAyPjLdLGp3SXFyngTT1gTM9jH1NaTckRErMYeBt
	 7P9D3swsq1jscR9BxMlPvP6+t40G8vHpQY3Sxz7aAr2pfSsLelPz3wR5qXyvlh05MQ
	 Rxf8VlFurdNKu7lXCm/qpoRluHQD/Bp6JF/tpWnyBRWqR6mVIJmhfIIx9xKjh1/ATc
	 dpXpE+x7iLgD7qusREZN6GaQZphRzMJjxrihY+kplCSL+kC1sUdadl+MYeammiqROY
	 8yamFeuI9M84+jMamd0QhbYpVncqSJTTdCynowqDQPvEQoW6BCXhMhMX58QMrlFmAL
	 qTHI8fcEc3BhA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD1639D60BA;
	Tue, 13 May 2025 01:20:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 net-next 0/6] selftests: net: configure rp_filter in
 setup_ns
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174709924174.1134434.13855187594239481377.git-patchwork-notify@kernel.org>
Date: Tue, 13 May 2025 01:20:41 +0000
References: <20250508081910.84216-1-liuhangbin@gmail.com>
In-Reply-To: <20250508081910.84216-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 pablo@netfilter.org, kadlec@netfilter.org, andrea.mayer@uniroma2.it,
 paolo.lungaroni@uniroma2.it, linux-kselftest@vger.kernel.org,
 mptcp@lists.linux.dev, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  8 May 2025 08:19:04 +0000 you wrote:
> Some distributions enable rp_filter globally by default, which can interfere
> with various test cases. To address this, many tests explicitly disable
> rp_filter within their scripts.
> 
> To avoid duplication and ensure consistent behavior across tests, this patch
> moves the rp_filter configuration into setup_ns, applied immediately after a
> new namespace is created. This change ensures that all namespace-based tests
> inherit the appropriate rp_filter settings, simplifying individual test
> scripts and improving maintainability.
> 
> [...]

Here is the summary with links:
  - [PATCHv2,net-next,1/6] selftests: net: disable rp_filter after namespace initialization
    https://git.kernel.org/netdev/net-next/c/ce17831f8e97
  - [PATCHv2,net-next,2/6] selftests: net: remove redundant rp_filter configuration
    https://git.kernel.org/netdev/net-next/c/50ad88d57631
  - [PATCHv2,net-next,3/6] selftests: net: use setup_ns for bareudp testing
    https://git.kernel.org/netdev/net-next/c/69ea46e7d00e
  - [PATCHv2,net-next,4/6] selftests: net: use setup_ns for SRv6 tests and remove rp_filter configuration
    https://git.kernel.org/netdev/net-next/c/3f68f59e9593
  - [PATCHv2,net-next,5/6] selftests: netfilter: remove rp_filter configuration
    https://git.kernel.org/netdev/net-next/c/7c8b89ec506e
  - [PATCHv2,net-next,6/6] selftests: mptcp: remove rp_filter configuration
    https://git.kernel.org/netdev/net-next/c/b83d98c1db29

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



