Return-Path: <linux-kselftest+bounces-39025-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7CCB27448
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 02:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B791F189F682
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 00:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B1715ECD7;
	Fri, 15 Aug 2025 00:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRUoj0OO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D547A13957E;
	Fri, 15 Aug 2025 00:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755219015; cv=none; b=kldl5lvPeB4zeLAa4st8bSQgn37c4ggZnfTdEhpuVfhDGXXXBllV/NA224OdO1m1KkkkwpobGKdsF6YhBFvunYQ2dCfdw/KidYEtghV6I+xfcYBP3YWyqaahNouwUZcgNrbLcDvu7+9IKsKIQ78Q0AArjRsZmmP5xO7YEj5mlj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755219015; c=relaxed/simple;
	bh=Ir0LlXy5gpHEXiw2yKFnGGk3vvtK8APW1bJBk2QSfmM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kGWkfXFA4/W/JFFV0rW+fz1gam8O/QQG+EtRQcKFpWpwn/yAH7q7J2HxzilB0k7EZnbRQIB4HL58/oJ0rTt9FMZ+9t1sSfff/Um3GECoCh0PuPOk94TocGoZaYiazJbvPeLWHE5oguUc773KZA8Qa5Bc4VEqsqxAJEWiuISjV7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRUoj0OO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45CBC4CEF5;
	Fri, 15 Aug 2025 00:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755219015;
	bh=Ir0LlXy5gpHEXiw2yKFnGGk3vvtK8APW1bJBk2QSfmM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sRUoj0OOItiwiGQKbh/swSLZg7mYgdcvbbW2A37H9wAbVU1qpSJ9vL9zgFKrBXhn7
	 pHnoVA/YINqOE8+hgZNm+d9we0SYZKoFHK1O5Hhhsdz1Mf8AvSBv/bvANI5CLVZcxl
	 5PkYeskFLIZJQcuWCkmFIriUtnY+ABdAAW0UTarigJ6tjUVPRpn5zeNSzPJVvPKrNR
	 EyGDUhBOCed11P0F5wtiwIWWVFsvahzVZn9huaMQnfUdmGpWcOJwBQO7UXSsKSdhmU
	 CO0EOCxCXCu+1fK6gCXC4HuYuWH39xKkvU5llfuHln7M4FjCCiKOMGxD9pyVHDIpbM
	 Kn2e1sora0Fdg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C5739D0C3E;
	Fri, 15 Aug 2025 00:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] selftests: drv-net: wait for carrier
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175521902674.500228.5816047536590617644.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 00:50:26 +0000
References: <20250812142054.750282-1-kuba@kernel.org>
In-Reply-To: <20250812142054.750282-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 willemb@google.com, petrm@nvidia.com, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Aug 2025 07:20:54 -0700 you wrote:
> On fast machines the tests run in quick succession so even
> when tests clean up after themselves the carrier may need
> some time to come back.
> 
> Specifically in NIPA when ping.py runs right after netpoll_basic.py
> the first ping command fails.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] selftests: drv-net: wait for carrier
    https://git.kernel.org/netdev/net-next/c/f09fc24dd9a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



