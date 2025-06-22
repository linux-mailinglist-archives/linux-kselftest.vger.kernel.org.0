Return-Path: <linux-kselftest+bounces-35572-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 564A5AE30D1
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Jun 2025 18:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B6FC18908EB
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Jun 2025 16:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A81B1E7C2E;
	Sun, 22 Jun 2025 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtX+iamq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA882AE8E;
	Sun, 22 Jun 2025 16:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750610379; cv=none; b=Gh/8EFrOh7fDy429kWIqJ0ZKKzniAIB72l1iUgzaJDu0ZMl6WH+wLTiBliQMolJ8DUZHW+xVSelDOCc7UYLsusgLEkz4uYQ+XBjbLJEVic6efNSbVw0ynZFHFF/jiQy4JyW04yMrMrNcRd9CkyLBc8Ti1rXru8S+874Ekc+GA3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750610379; c=relaxed/simple;
	bh=Yv/mApgcCWydCfdP4MhYzR45djsXJkpQGZFnebaZxdc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tX6pAI9aVY7sxLm58q9yiHCa8EhcpLulpcEqsdqfzoLEAq0EBeLsFNW+t5nnoB+PZ9B2ciaO9giwkgXMCjugq2thdC2y5AJZzNaE7CIUNh2DV77VokOdEngudp0q3Dcd69WiplTLzE3z578NyekGo8I5usWPThJMR4ONNfVV73s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtX+iamq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D4CC4CEF0;
	Sun, 22 Jun 2025 16:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750610378;
	bh=Yv/mApgcCWydCfdP4MhYzR45djsXJkpQGZFnebaZxdc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WtX+iamqBwDTniwNUoT8VSTRjQ9UyQ3aDlkobvB8rRr/3j4kvbug3cRuZ4iajM0Rb
	 tehto8QZo2cUo/Nfve6obcude81hldowLdZm6aQoQclNXYw5zlOOyfpwDE0TSSZsie
	 2r56XD7MH9dJGkPW/Jsh1JnFQoBzmWMgTMwKvNcJdKzSr7lh0bT/xVNBHX25JdkZIj
	 BMe3cQIqYoeW0vYs9ZtbRoo4YplvWV6TLxLI1JuDINIgfhTlAp8aRTL84Io4b/5sye
	 QWNGI/KVgsPa5h+Ceu922qLlpnLs7ii6Xqe+XSGctz2X3yAehPCu9tWQtniFBtvjg6
	 5rKODgqnh2xsA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B9239FEB77;
	Sun, 22 Jun 2025 16:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next,
 v2] selftest: add selftest for anycast notifications
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175061040601.2101917.2619105539091495642.git-patchwork-notify@kernel.org>
Date: Sun, 22 Jun 2025 16:40:06 +0000
References: <20250619035116.3761921-1-yuyanghuang@google.com>
In-Reply-To: <20250619035116.3761921-1-yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, maze@google.com, lorenzo@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 19 Jun 2025 12:51:16 +0900 you wrote:
> This commit adds a new kernel selftest to verify RTNLGRP_IPV6_ACADDR
> notifications. The test works by adding/removing a dummy interface,
> enabling packet forwarding, and then confirming that user space can
> correctly receive anycast notifications.
> 
> The test relies on the iproute2 version to be 6.13+.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] selftest: add selftest for anycast notifications
    https://git.kernel.org/netdev/net-next/c/14966a8df77e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



