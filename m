Return-Path: <linux-kselftest+bounces-34373-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8909ACF2C3
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 17:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 739687AD114
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 15:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652EE2750F6;
	Thu,  5 Jun 2025 15:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OssPjkgo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9922749F0;
	Thu,  5 Jun 2025 15:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749136210; cv=none; b=rXBsqcwGxwjVOUSs6YFuuV/hMMRL2ApjWkG8/vJJOt/0iHzB5i0xD/lozDX5DVTnzE59rkbz+P9BwGPlShK2VeVEXM3gontENVZLxA+XmBaLErgKlY0DOGPpGmuvwanGMV1bB94DjSrTQp/MGnSQCZef5ftq1PKYwdPxalBMeNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749136210; c=relaxed/simple;
	bh=OfLy6jGI7f0blh85XVHcD8J07UN2sYgq/BQpKK/N+C4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Nt58hEK0eYHCOBLsVbebhZRBxkDX93szKj7qqCPyR57y5gZ1o60JYcMe50NmpgGsGQJh/slXKwNXUd4ftcjf8Oj+h8aUHrE4tYZpHAz+jaR9zAy1Zdri9Ey5rBAEMyNBKBFF/kPfKNosQHbWQ9WsHBj27mAjOM7S/MJKEm5vIk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OssPjkgo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4C8C4CEE7;
	Thu,  5 Jun 2025 15:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749136209;
	bh=OfLy6jGI7f0blh85XVHcD8J07UN2sYgq/BQpKK/N+C4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OssPjkgoi39YIpBV2eHUUEF0CJG29l8lCP2yB9DHy6JWeSMnmAwBBqMcBl1gvuSD/
	 AUvPAQloXmPAmh4b2YKkkyGZ+R2iGE+5EVJZKm4ZvHaRENOLqaVoR2jzY8PRzxY85Y
	 3iiwPVnRGXsY/oyXTyj6VXHrgsGRoJAhhOd60dxtWeotnh8z3SdYanYCdsmja0bMFg
	 M/AwLDQdTHpIAPS+TVHkvmS8tQ7h9WpUMGVxXCiTcRYdMTvvYD8Y9+dKRjbd64xX0M
	 fuFY/9ID2gF1eT9FS500KtggXWw3ZyLX55EU4jnqRsFL/fmk9rMp3ul+nTui/Jpoxo
	 V/ivdnrxEh0Sg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD1B38111D8;
	Thu,  5 Jun 2025 15:10:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: drv-net: tso: fix the GRE device name
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174913624124.3108661.5105009483442193446.git-patchwork-notify@kernel.org>
Date: Thu, 05 Jun 2025 15:10:41 +0000
References: <20250604012031.891242-1-kuba@kernel.org>
In-Reply-To: <20250604012031.891242-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 willemb@google.com, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Jun 2025 18:20:31 -0700 you wrote:
> The device type for IPv4 GRE is "gre" not "ipgre",
> unlike for IPv6 which uses "ip6gre".
> 
> Not sure how I missed this when writing the test, perhaps
> because all HW I have access to is on an IPv6-only network.
> 
> Fixes: 0d0f4174f6c8 ("selftests: drv-net: add a simple TSO test")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] selftests: drv-net: tso: fix the GRE device name
    https://git.kernel.org/netdev/net/c/c68804c934e3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



