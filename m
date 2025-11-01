Return-Path: <linux-kselftest+bounces-44563-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5802C27501
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 01:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A5281A203A8
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 00:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883E2218AB9;
	Sat,  1 Nov 2025 00:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CT/gqRHY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C662214A9B;
	Sat,  1 Nov 2025 00:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761958235; cv=none; b=U+oOI999VfwN7KMwip6xOkE9VmwtyR5hAPRhHIIeyvQEWqzyzq6lMPnP25T4we/lsi8PNC/wKVzahMGowY/CMoVh98Qt9iPzOiQBOBocbtGjPra3fK42d4JiHf2E0+0O+qsdhhZT9MoqEeNUUOy+JUj59SGBVUZTjKTETrUbaF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761958235; c=relaxed/simple;
	bh=mxnF0wr4BqX8APrMyeKsRyrXXgrLHbvMSo0RkdsUCqA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jztqWvu05KzCz+T2JXow28ds3Mh2OHM/thJbYmVZB506GyUN5jWymk2y1QAs9e0UZKpCzRDPM+3OVU7i6UTg29vrKSEvW7h2wFhA1a+as7r9fU8HnWtSdxY19/x1m+MbTczfUs4SV7YrONYGIi/U1guPMB4b3uwfUOY37jE7Ud0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CT/gqRHY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8E6C4CEE7;
	Sat,  1 Nov 2025 00:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761958235;
	bh=mxnF0wr4BqX8APrMyeKsRyrXXgrLHbvMSo0RkdsUCqA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CT/gqRHY16P9OmBQQCuRNSNQyCPLbwL4JdHo2g6VHaw+eAd+o5lJNYmw2Yx2wPyqp
	 iheMQkaEYW+qnulq2WvNpP1kCmvQmiCyQVIcxsEbiti6aknrEZxwStZMiVPY7NYKxa
	 /iO6I/SnZ1ofN1aH2r83FgqRCCsZ8GIfTyQYxElqnEwOM/8Uk3yQSuRgQqFe4azfhe
	 nre+SZtaTr/PyRzxwMEp/RdIOgg0a/BZPwMO5tt4tgathiRYzbC13+1GHGUtn1b5D+
	 aQtebHgwC4hRyy0/q9jHkN3GIYSQyHffZhBCcnYHnV5zawLJl7tazmVjCqPmSxQsOq
	 OvXj1Qi7cCUeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F303809A00;
	Sat,  1 Nov 2025 00:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] selftests: netdevsim: Fix ethtool-coalesce.sh fail
 by
 installing ethtool-common.sh
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176195821124.682052.16276710639901642661.git-patchwork-notify@kernel.org>
Date: Sat, 01 Nov 2025 00:50:11 +0000
References: <20251030040340.3258110-1-wangliang74@huawei.com>
In-Reply-To: <20251030040340.3258110-1-wangliang74@huawei.com>
To: Wang Liang <wangliang74@huawei.com>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, shuah@kernel.org,
 acardace@redhat.com, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Oct 2025 12:03:40 +0800 you wrote:
> The script "ethtool-common.sh" is not installed in INSTALL_PATH, and
> triggers some errors when I try to run the test
> 'drivers/net/netdevsim/ethtool-coalesce.sh':
> 
>   TAP version 13
>   1..1
>   # timeout set to 600
>   # selftests: drivers/net/netdevsim: ethtool-coalesce.sh
>   # ./ethtool-coalesce.sh: line 4: ethtool-common.sh: No such file or directory
>   # ./ethtool-coalesce.sh: line 25: make_netdev: command not found
>   # ethtool: bad command line argument(s)
>   # ./ethtool-coalesce.sh: line 124: check: command not found
>   # ./ethtool-coalesce.sh: line 126: [: -eq: unary operator expected
>   # FAILED /0 checks
>   not ok 1 selftests: drivers/net/netdevsim: ethtool-coalesce.sh # exit=1
> 
> [...]

Here is the summary with links:
  - [net,v2] selftests: netdevsim: Fix ethtool-coalesce.sh fail by installing ethtool-common.sh
    https://git.kernel.org/netdev/net/c/d01f8136d46b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



