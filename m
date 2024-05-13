Return-Path: <linux-kselftest+bounces-10158-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E8E8C4895
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 23:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B4331F24762
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 21:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560C38248B;
	Mon, 13 May 2024 21:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGlEGCUJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF0080BE3;
	Mon, 13 May 2024 21:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715634031; cv=none; b=ScP0+CRHAmLVAxOBM5RsZitMXhKc50X084zygDBgaVYjm87mbGt6ele8cw9UjEGqaLoiH3QPCv6Peff/0td279P9r9N3keNPnsQ37h/xCpfrNlBwukBrcP64+PCVkgFZAsKs6FQUUyRigQdksL8vfk+qRE8SgZII93WTjfKaTpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715634031; c=relaxed/simple;
	bh=Bl3VxXGVratxwfDnVG4jwWP7nX50ZfRcID+p2155ZIk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JnhMcnp955RVy7WXvkYb0+yRt9/Wuo2cB42Yztl6dtSh/aap0nOuP1HAovOG+NhoKPYLEd0tVIiIrh1dbymlQRKYV5lcSS+qBQQ2PfgDly4SboxF0Emk6kHNJVpvnNsBxsZRTId/B/IHSiO+UJW4KwzJsy4Lg6dkhcfcpoibpYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGlEGCUJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2E7EC4AF08;
	Mon, 13 May 2024 21:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715634030;
	bh=Bl3VxXGVratxwfDnVG4jwWP7nX50ZfRcID+p2155ZIk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bGlEGCUJtsNEDBcijuKqPlAUvovqb9fN/tO3RDbmVKHGHT5I293E+fPyNwqPhqn14
	 PVSZw7T9lXJNJp+OoR0JjWvKVzyQLSZSgLRXN25nIU8077nwJeVxva2RvI1bpQycAz
	 7fSYG/uySRZYrZs+AW6xZtKVPhxaSE218HK2pnHFoystd3PLulMszs89vueN4CreoO
	 DEzXM6uHZgneedpLax8BHrv6GsGO+Qsdd5ZWU9vgAqSicOvxZ/rAMuzQpaG9ytnAWu
	 nDZYtOvbB3T9BCet4aFEj9Qr3oEPMd/3gIhxcHE6Vj7tJMjT6SINFgRhtaS+ZxYIIa
	 Q6+a5ej7VS6AA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B276CC43446;
	Mon, 13 May 2024 21:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftest: epoll_busy_poll: Fix spelling mistake "couldnt" ->
 "couldn't"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171563403072.25832.9322227128298571251.git-patchwork-notify@kernel.org>
Date: Mon, 13 May 2024 21:00:30 +0000
References: <20240510084811.3299685-1-colin.i.king@gmail.com>
In-Reply-To: <20240510084811.3299685-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 10 May 2024 09:48:11 +0100 you wrote:
> There is a spelling mistake in a TH_LOG message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  tools/testing/selftests/net/epoll_busy_poll.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - selftest: epoll_busy_poll: Fix spelling mistake "couldnt" -> "couldn't"
    https://git.kernel.org/netdev/net-next/c/f37dc28ac6e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



