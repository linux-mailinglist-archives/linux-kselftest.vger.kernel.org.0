Return-Path: <linux-kselftest+bounces-41555-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEA2B58B3C
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 03:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B4C52148F
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 01:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115DE22A4E1;
	Tue, 16 Sep 2025 01:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ld9WzxZF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D796B212548;
	Tue, 16 Sep 2025 01:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757986244; cv=none; b=oE5WQ3UaE0Lv/m/efqAgYiNaw8S8R/wCK7vFJcznJBxC0SdDGOo1wh661Ofp+O2vgC9D+aeK9lRGtv4e6fNmYN1RdaiZPSvTx8LlC3915e+/KsHedc85u6OV+r72dWujEqVM54i5WJTm65IPUiskp0Yp7xbjo6l/CinQYqLPANg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757986244; c=relaxed/simple;
	bh=68sRZCFswwOtjhT2kR6BYfselTfqpsn4AzbOTm1I//U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ngz0G46A9U2db59mZZ4LZAI2hVHsH+svCFziOtA72j1NBkoC8VbyCMloUHQiyv/skCokUf4sVCNniQf6d/lZTJu+7ireRc/OZpRJnWWbcAJtVpQwOj9znd+s8h0pgSTeDN1CGX9mrMyXyJ9t3ZzJWKKFKKxV3vy04o8BYVdSQwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ld9WzxZF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AEB3C4CEF5;
	Tue, 16 Sep 2025 01:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757986243;
	bh=68sRZCFswwOtjhT2kR6BYfselTfqpsn4AzbOTm1I//U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ld9WzxZFDW3z1uoUxIyp+0uLVP0G9TLM9tRu7jHzt3rewiHYBGEoGyL66q4hEmOAx
	 ecKMjusQjEiUWPY/9n/d7rzeKzrE8VSG0i4qmlKAw0i8Fng4u4mKxdzPA9O+CAx7Dm
	 q8awZLD1VGsAoES5zojg0IwLQrA75y9AyIC9c7VYspxav/yLcPZWY5DRg3lHXWF+2K
	 f0IGEOEHy1pgak+ZXqmOXXAmnrMGfuZ/pL0exeL4TVR/pvOz/DcQRanegZvhRIN+DN
	 mImlTPmCMMYvZXrUod5445cTDu/vRShZgKquVxC+6LDnm5sPRQ251R/HJcoGrlQtQY
	 Oml5SEmPkYrhg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC6A39D0C17;
	Tue, 16 Sep 2025 01:30:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] mptcp: misc minor cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175798624448.559370.16684538865002815832.git-patchwork-notify@kernel.org>
Date: Tue, 16 Sep 2025 01:30:44 +0000
References: 
 <20250912-net-next-mptcp-minor-fixes-6-18-v1-0-99d179b483ad@kernel.org>
In-Reply-To: 
 <20250912-net-next-mptcp-minor-fixes-6-18-v1-0-99d179b483ad@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 donald.hunter@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Sep 2025 18:36:46 +0200 you wrote:
> Here are some small unrelated cleanups collected when working on some
> fixes recently.
> 
> - Patches 1 & 2: close file descriptors in exit paths in the selftests.
> 
> - Patch 3: fix a wrong type (int i/o u32) when parsing netlink message.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] selftests: mptcp: close server file descriptors
    https://git.kernel.org/netdev/net-next/c/dab86ee688ae
  - [net-next,2/3] selftests: mptcp: close server IPC descriptors
    https://git.kernel.org/netdev/net-next/c/e3241506a471
  - [net-next,3/3] mptcp: pm: netlink: fix if-idx type
    https://git.kernel.org/netdev/net-next/c/3f9a22be374b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



