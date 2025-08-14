Return-Path: <linux-kselftest+bounces-38920-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EBFB25875
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 02:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 484A1888754
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 00:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F273813EFE3;
	Thu, 14 Aug 2025 00:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lS4+PQPJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C447913DB9F;
	Thu, 14 Aug 2025 00:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755132003; cv=none; b=XxVFTO/A5Bruc8ZdnonP6rmm19MdznF86B/N+frhQ2iLiEEe57SLCrjqRjHgVoG6Vvv13AozbtHvGsDgwE4xGMuIASUa0lhsxUu6IxBu1gU8D7+y7Pv5BfkkTBJHlCy/2ZYMlJAQmWr6zGpRgkDGmTCaxy/Wahf8xjkALN9xRNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755132003; c=relaxed/simple;
	bh=fbCa9DvJTr1HVtwFEmAjaAJKswFXp50L6Px6ZRDWCIU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lrgDUZNXEo/dMMevPC3ZbHqt0MScdKs1JquuJVE3EMhYKbwWVZej7lGOdWCkySrr9KbyaEHNg0uw4GxF4QCV+JCBhYPoDpd5wEjUGyDpYscWZt/ehVPd1b1k7NakV6fm017wEmx9OEFO2X+kaAYtMJrKE56dMgyv4KhoY2uCA2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lS4+PQPJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A228C4CEEB;
	Thu, 14 Aug 2025 00:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755132003;
	bh=fbCa9DvJTr1HVtwFEmAjaAJKswFXp50L6Px6ZRDWCIU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lS4+PQPJ/sRlNjJhhxVhi442UwyJaWph9jY86rPLwx3lPFYfVz4xBcV1x1BLRYClS
	 dlsWV4H443geRrkSIo9fqlcJtPGu0tb7f+i0tBIZ7A5GfZv0Mg5+6hanVCKZIWzYlR
	 DJTchspB8oXrc1yll/+LYhTrL79d/E/v2Cx3PPkfM+38DORql64oulcJekoil8VOM/
	 45ovdnNNSqE1wNqGwp3mbfM5t0p3BdG4tFPmoBo1BIiffVjLMzK4uowYTGAfgYzVFc
	 uOQPwb3lADkYmuSe/KnJFIsC0QIZDE8aQmWNkGFyJ5M7sTwuJRtAeZRPRPnY+ivfHC
	 ppjLA8wllwh2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B3139D0C37;
	Thu, 14 Aug 2025 00:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] selftests: netconsole: Validate interface
 selection by MAC address
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175513201474.3832372.9360535179895099466.git-patchwork-notify@kernel.org>
Date: Thu, 14 Aug 2025 00:40:14 +0000
References: <20250812-netcons-cmdline-selftest-v2-1-8099fb7afa9e@gmail.com>
In-Reply-To: <20250812-netcons-cmdline-selftest-v2-1-8099fb7afa9e@gmail.com>
To: Andre Carvalho <asantostc@gmail.com>
Cc: leitao@debian.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Aug 2025 20:38:23 +0100 you wrote:
> Extend the existing netconsole cmdline selftest to also validate that
> interface selection can be performed via MAC address.
> 
> The test now validates that netconsole works with both interface name
> and MAC address, improving test coverage.
> 
> Suggested-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Andre Carvalho <asantostc@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] selftests: netconsole: Validate interface selection by MAC address
    https://git.kernel.org/netdev/net-next/c/acfea9361073

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



