Return-Path: <linux-kselftest+bounces-26326-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C2EA3022C
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 04:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09F6D1883920
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 03:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA8A1D8A0B;
	Tue, 11 Feb 2025 03:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BX/5ROsq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624451D5CDD;
	Tue, 11 Feb 2025 03:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739244616; cv=none; b=JnLKbPm1h5FyB4IyGbRPp3/bL9xid6K2vpIJRIT6ca9AHOgRi7qSsacPDxHp5UXnx8Ln6dZH4PjhAnSKCxt5C784sa06LYtILD4tMBu/X2BTwlYI3JNASjTsUjivGb1aRDA70BLEv52krOw6SBsbOswZdjRkurdIOltPMlToAmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739244616; c=relaxed/simple;
	bh=PW166DVT5NlNgcQqGNum97/ask5Ug1+sy2d8VvH1NnQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VL3gL8y+TKBFQLYRL7aeZzzHlDjsggmtHHtjE6vQBDzmPj8TKXd8pqgpvnKIgsQbADe1Nd/2AdTRVfn0ocQiHLwT+YETb8WSsPYhEkj85x0lcmAsOg7FPfa95ocitDJMab5g3netZk4ERo/TxzBYzVXlT8jVGi45nFlXTSsCF+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BX/5ROsq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1F6C4CED1;
	Tue, 11 Feb 2025 03:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739244614;
	bh=PW166DVT5NlNgcQqGNum97/ask5Ug1+sy2d8VvH1NnQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BX/5ROsq6QAT86+4eE9EuboTtwK5Y27HlGSVBfMAGKXsmrkoMWRL/eHSmuGHz2FCi
	 0imeQcQXcI1mTGMm8+wGgsV8LKLatn98rzmlmHQpulwjUaWDjVqpGLPkXlRihSgxTM
	 Wsq0on52ETv8dMo66tImSJZ64kX4ACR1Tm1WLS+6wr0JIiVbFnVPsEmTPG5DdalWii
	 9xSuyjOl+XBa2aP665PVsVc72LGsUQUwFHMFJjSn9Knq/epwfT8T2hzc0HlM+7SjbO
	 yNm8a4+4hcfOvZijkevR2LTWucX0V0ishNBAcPPlKM1j9/9wVSBhJ8RHeahsK2CDDG
	 hCKHQ/8nRsifQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD97380AA7A;
	Tue, 11 Feb 2025 03:30:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: drv-net: remove an unnecessary libmnl
 include
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173924464326.3948401.12997926948925895162.git-patchwork-notify@kernel.org>
Date: Tue, 11 Feb 2025 03:30:43 +0000
References: <20250207183119.1721424-1-kuba@kernel.org>
In-Reply-To: <20250207183119.1721424-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 almasrymina@google.com, sdf@fomichev.me, jdamato@fastly.com,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  7 Feb 2025 10:31:19 -0800 you wrote:
> ncdevmem doesn't need libmnl, remove the unnecessary include.
> 
> Since YNL doesn't depend on libmnl either, any more, it's actually
> possible to build selftests without having libmnl installed.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: drv-net: remove an unnecessary libmnl include
    https://git.kernel.org/netdev/net-next/c/a980da54b6a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



