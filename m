Return-Path: <linux-kselftest+bounces-7386-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4634789BD84
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 12:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF4E4B2248B
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 10:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E928A5FBAF;
	Mon,  8 Apr 2024 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lF+gfVx5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8DD5FB8C;
	Mon,  8 Apr 2024 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712573427; cv=none; b=iqWB96Mz1aGBDFXaK7jocStNzo/w7CT6YYMXNJDT25GeBuZzTGiN1bkQrAKc7fBI9deOcgYTdK9OUkWNu9CxIsRWmbd6Yp0mIdzBRJGehLv5m3Jb6QlhswKK7zDvRl68TCqAW46OL3RIpeL/66YaMXo2Kya57tkDk+UYgslJ044=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712573427; c=relaxed/simple;
	bh=nYFUGgAe6JEVlDZJ6H84eYG+or3I6A2rmoi4NbVi+bI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uAqObldMwYDlVmEfZghci+7nVWm5CHQOKekAzggX1heyDfw8RHvG7rQGtKZly2BmdK/SBNrO9aNRenw6aqZZZO5QkFXFxd6tpyAFcFyna6swBXRme+SBJmz6D0ALQ2di809YT3sOwaNnNYQqcmbxL0X0eufnKeF9mrZo+75h0q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lF+gfVx5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59F8FC43390;
	Mon,  8 Apr 2024 10:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712573427;
	bh=nYFUGgAe6JEVlDZJ6H84eYG+or3I6A2rmoi4NbVi+bI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lF+gfVx5Xe5MBpI46z/YyX7D21uLo+a7niU+ciALzFZlXk1VuxEcy+gUTsK+5Xr7I
	 +2l+SxHn5orr/1jNoX+kvvS5wa36FSR6zidqSdjhmgQ/pLcDAiFmN+ODq/FbSccbDt
	 5TCFK79Okj8S7xGkrB2Tw9A3wgpLjK0wF3O9/jdKi6m1+gXGuLh6d6gOlc9LfFHaqg
	 9Nan/GwBMi2xMYBBi90FYioR/fqDqnvcigrRKs6aIHkf9rrb0AnpCg6DaxpNVRaTr4
	 Gx+7PPfWLi9cfSqACjlxoZlCPyGe9Y4ZiNyCgONmL9cL2YcHV+avtOOhmNmTXWWTfC
	 ed58pRA18nPkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 50FB3C54BD6;
	Mon,  8 Apr 2024 10:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/5] selftests: net: groundwork for YNL-based
 tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171257342732.21044.16185402025320251923.git-patchwork-notify@kernel.org>
Date: Mon, 08 Apr 2024 10:50:27 +0000
References: <20240405024526.2752998-1-kuba@kernel.org>
In-Reply-To: <20240405024526.2752998-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, sdf@google.com, donald.hunter@gmail.com,
 linux-kselftest@vger.kernel.org, petrm@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  4 Apr 2024 19:45:21 -0700 you wrote:
> Currently the options for writing networking tests are C, bash or
> some mix of the two. YAML/Netlink gives us the ability to easily
> interface with Netlink in higher level laguages. In particular,
> there is a Python library already available in tree, under tools/net.
> Add the scaffolding which allows writing tests using this library.
> 
> The "scaffolding" is needed because the library lives under
> tools/net and uses YAML files from under Documentation/.
> So we need a small amount of glue code to find those things
> and add them to TEST_FILES.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/5] selftests: net: add scaffolding for Netlink tests in Python
    https://git.kernel.org/netdev/net-next/c/b86761ff6374
  - [net-next,v3,2/5] selftests: nl_netdev: add a trivial Netlink netdev test
    https://git.kernel.org/netdev/net-next/c/796c8c7fd257
  - [net-next,v3,3/5] netdevsim: report stats by default, like a real device
    https://git.kernel.org/netdev/net-next/c/f216306bfb60
  - [net-next,v3,4/5] selftests: drivers: add scaffolding for Netlink tests in Python
    https://git.kernel.org/netdev/net-next/c/b4db9f840283
  - [net-next,v3,5/5] testing: net-drv: add a driver test for stats reporting
    https://git.kernel.org/netdev/net-next/c/f0e6c86e4bab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



