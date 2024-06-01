Return-Path: <linux-kselftest+bounces-11088-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EC28D72B0
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Jun 2024 01:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7783C1C20AE4
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Jun 2024 23:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600E643AB4;
	Sat,  1 Jun 2024 23:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pti8llGT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D841C680;
	Sat,  1 Jun 2024 23:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717284030; cv=none; b=gSsDgoqKtsiUsG/Sg3fKywlhwLQhIPqUv88AIGHYVh/cWmresHz84DrcvDh2jOT1rcMB4XwRh5wd37h3xgU2sCLsjjSXMDI21bwgnlSw0ElBRIPPtJMFw9rY/w2HYffLiXu6pG6wHiJfSgrRcm9X/bMU2jPywviqtc+Xr1DZio0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717284030; c=relaxed/simple;
	bh=TnMNRk/w6PSirdgEmK2klgbQv1j+5PdUI5UdJVn345Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QcOYU9nfyJCL7WpxLMhWCcldjPQbeufyI4me4DUfyjGQQZ29YHJD5dNKJRvCIbGFspW6ZhFXwjyfij0EXWki7ycFJv5OB+2IWGOPLwPNn1zX1KrjcfmlEWldpIbWdX2MVHi+dYPRDpVK1OJP4BWihNvphvMPO7J+sn39KMNRrmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pti8llGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B73ABC4AF07;
	Sat,  1 Jun 2024 23:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717284029;
	bh=TnMNRk/w6PSirdgEmK2klgbQv1j+5PdUI5UdJVn345Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pti8llGT78EU3LOCGKz7Eb8J3EE86loJoSKMl0aiYWbqVZ4ds+FBuH53M2OZKuJ3f
	 XG+RGThkQm2fupVZXDGWnSp0M/TymCA2T8++SBka6HZZKK08A98vG0V/DjTs8q8/9z
	 mqB7kRzIGR3Elwz1ZC/GiPmzXAq7YOq+9ATYVP3Yepv3zuvdl0ZPRGPHgT2RQuxf9F
	 qL8KTg9nUV+IvMDxbPXAVDjNSYlnmCq+BorkX1Wnt9sslyf+qRmoqhR+/OHf/rOiVL
	 Cqkw+bIKJFuRPL/oV0kMCRiVlT4AJGBXskaWclEgvBpmVJHqEa4rnyyh/npbyhLiAD
	 zoHQNPb9v6xag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A97E9DEA717;
	Sat,  1 Jun 2024 23:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net: visibility of memory limits in netns
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171728402968.13922.4485290889430995702.git-patchwork-notify@kernel.org>
Date: Sat, 01 Jun 2024 23:20:29 +0000
References: <20240530232722.45255-1-technoboy85@gmail.com>
In-Reply-To: <20240530232722.45255-1-technoboy85@gmail.com>
To: Matteo Croce <technoboy85@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, shakeel.butt@linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 teknoraver@meta.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 31 May 2024 01:27:20 +0200 you wrote:
> From: Matteo Croce <teknoraver@meta.com>
> 
> Some programs need to know the size of the network buffers to operate
> correctly, export the following sysctls read-only in network namespaces:
> 
> - net.core.rmem_default
> - net.core.rmem_max
> - net.core.wmem_default
> - net.core.wmem_max
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: make net.core.{r,w}mem_{default,max} namespaced
    https://git.kernel.org/netdev/net-next/c/19249c0724f2
  - [net-next,v2,2/2] selftests: net: tests net.core.{r,w}mem_{default,max} sysctls in a netns
    https://git.kernel.org/netdev/net-next/c/5b5233fb81bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



