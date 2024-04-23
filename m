Return-Path: <linux-kselftest+bounces-8719-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1508AF54E
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 19:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 781661F222D6
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 17:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A1D13E895;
	Tue, 23 Apr 2024 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqn4DvS3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCD613E885;
	Tue, 23 Apr 2024 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713892832; cv=none; b=LO00zMeLMJN/i/JUlHLIuYyXd6WCQaIWHxXxX5UccebICNIDisc+BkJ+TAALnBwZA8hCy0GhIQp45oCYtp0Kj09agzRT+ti4aDOoqokufHlZCdEAuTq4nVgfHRb9tHZN6Hz8vmEfuDh4RDk5LlmU7WGKxew5PTdYzvLm1g18f8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713892832; c=relaxed/simple;
	bh=RLKW8ap87xt18wB0xBumS7Ogzgxj+Up9JGWhBIRW+V4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=luZb/uryBmEMI5wXyeH88RCP96aATvsFZwhU6/lbeAqaWcoseCA0i4+t9jevjbIEQ3mQ72OSH4jguojviOKTUCjeXKV3ilr2ldfXdkH50VzYktP9uHTUiVItd20I5aATGhyaL6xXX/lThWtkE78AMZw5HQxIva0LdsfWlxHcw24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqn4DvS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BBAE6C4AF0A;
	Tue, 23 Apr 2024 17:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713892831;
	bh=RLKW8ap87xt18wB0xBumS7Ogzgxj+Up9JGWhBIRW+V4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iqn4DvS34sGSKeYpjED3/mjRWBSwS/YNv1d+ovVP6T/YdSJsKrryth3gVlqJaSj+s
	 B0cqkuhUADM0zaX5I4Ci+M/JOrVGEyVOJAcW4x/XBXwGajbGsmmYWCdFCsbOMcse7a
	 Lo6XI7rS8RUEWmjHYGxuFR0hIt1qQZNAdf0hJdD7ztwVw20rJboaDCJoScIEQ5y99e
	 l5bDM0tCd5t7ifrDMAFdwFDZWZhEsMMFwuDdRvIhHEHHOhf5XjG+iXXDaaY+kTx6uR
	 WsVxxPY6A2Sn3Wufj2A7yKJEWR5iFXGQsCzOqI9ML2cA8mY/zHQVHBZhCi53w40RpT
	 lRApCYTMVBJyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9EF82C433E9;
	Tue, 23 Apr 2024 17:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] netdev: support dumping a single netdev in
 qstats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171389283164.853.3850902194084440813.git-patchwork-notify@kernel.org>
Date: Tue, 23 Apr 2024 17:20:31 +0000
References: <20240420023543.3300306-1-kuba@kernel.org>
In-Reply-To: <20240420023543.3300306-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, sdf@google.com,
 amritha.nambiar@intel.com, linux-kselftest@vger.kernel.org, dsahern@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 19 Apr 2024 19:35:38 -0700 you wrote:
> I was writing a test for page pool which depended on qstats,
> and got tired of having to filter dumps in user space.
> Add support for dumping stats for a single netdev.
> 
> To get there we first need to add full support for extack
> in dumps (and fix a dump error handling bug in YNL, sent
> separately to the net tree).
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] netdev: support dumping a single netdev in qstats
    https://git.kernel.org/netdev/net-next/c/ce05d0f20368
  - [net-next,2/4] netlink: move extack writing helpers
    https://git.kernel.org/netdev/net-next/c/652332e3f1d6
  - [net-next,3/4] netlink: support all extack types in dumps
    https://git.kernel.org/netdev/net-next/c/8af4f60472fc
  - [net-next,4/4] selftests: drv-net: test dumping qstats per device
    https://git.kernel.org/netdev/net-next/c/237109259283

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



