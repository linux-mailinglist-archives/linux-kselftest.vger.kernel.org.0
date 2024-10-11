Return-Path: <linux-kselftest+bounces-19572-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B96599AF12
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 01:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1EB3286ED1
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 23:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACF91E7642;
	Fri, 11 Oct 2024 23:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5kDCBCA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8231E6DDD;
	Fri, 11 Oct 2024 23:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728688236; cv=none; b=SG3c58yvP0eaXdQWFrA/iMcfxRPeezMPwuQ2mGlhqivP2hTKkzD1rYQU1c5puX6Snz3NER9U4D9YkTSqbUFq5kKGCGWwQHoOzlRZ2AU6YE6CSz8VauYt5/G92qFBavoRBF5z1VlXbZE9Vl6jWjCqbWQUr7f4p3cejZw9teLtk9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728688236; c=relaxed/simple;
	bh=0ipEl/xozdmBLGShV6uOpVDxybg/hjHgi3Kudb4Tt5w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qg70aommlhw3L1T6Q6PPwBMJR7J8WhjahEgE9SJJOOnIXr0xYUKBO4EAQRy4DzT8MUxY30MnMmgY9hrOJ/1V/RppuFB9rfGAJGgFrWnELqeR+cJRqNIF43f7cTJlJdvsFiW4b+xgp8spVgp43HBS0DW5A1/RmS6HpIzWq4XOlak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5kDCBCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A91DC4CEE5;
	Fri, 11 Oct 2024 23:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728688236;
	bh=0ipEl/xozdmBLGShV6uOpVDxybg/hjHgi3Kudb4Tt5w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g5kDCBCAcXeUeb2C0UZKaNHXpjQdtb4RxofS3nCKUI0ViYbduD5VK6BYrJo+RX8oK
	 9m8sAPHqfZVrGmithBfYVo2/Gy9bhVO//OdRoa+/F4afFNtLN1yK7EGs/wrETv21+6
	 aP+bY8ST0D7LydhNyzTdAPwZDejJmiOIAR+XiCSKJPAoHT7YWt20aFjHo9Lhcj8RSV
	 g0B4STiHUzM3OdGuZp8quBIiZBU/bQefMmGhQOK3N85i2fYYPfm8T0AN2Sp/P1gG6a
	 Q09cEn4XcYLFFVXWQNgN9omsFcPuKO4H7P1+VMes5CsBPGDpzOxOGVIFNFGE05s2Rs
	 eTVY2XfPfZjzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB21D38363CB;
	Fri, 11 Oct 2024 23:10:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] selftests: drivers: net: fix name not defined
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172868824050.3022673.6364802476859924447.git-patchwork-notify@kernel.org>
Date: Fri, 11 Oct 2024 23:10:40 +0000
References: <20241010183034.24739-1-alessandro.zanni87@gmail.com>
In-Reply-To: <20241010183034.24739-1-alessandro.zanni87@gmail.com>
To: Alessandro Zanni <alessandro.zanni87@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, petrm@nvidia.com, sdf@fomichev.me,
 martin.lau@kernel.org, dw@davidwei.uk, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, anupnewsmail@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Oct 2024 20:30:30 +0200 you wrote:
> This fix solves this error, when calling kselftest with targets
> "drivers/net":
> 
> File "tools/testing/selftests/net/lib/py/nsim.py", line 64, in __init__
>   if e.errno == errno.ENOSPC:
> NameError: name 'errno' is not defined
> 
> [...]

Here is the summary with links:
  - [v2] selftests: drivers: net: fix name not defined
    https://git.kernel.org/netdev/net/c/174714f0e505

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



