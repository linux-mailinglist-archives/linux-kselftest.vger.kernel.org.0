Return-Path: <linux-kselftest+bounces-4468-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF9F84FCDF
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 20:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2B43B24AB9
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 19:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB0984A47;
	Fri,  9 Feb 2024 19:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KelTs+iV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314CB82867;
	Fri,  9 Feb 2024 19:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707507028; cv=none; b=GQfzJC1s+ThC7zKi0UWlvInvcu3Oq9JPPp8r0GMcSI8Qj5IUTiLgJyl4AIsrW7i1CeX0GeL/xcZAD10jidg5JeLqxotEYMSYGQFpse3jMqYyvjK54/nnfYS+eJgP8xyZoTJ1ydDVxnFmx7IPAQ0oZ6LS+91fBsf8Ns6uCDocVPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707507028; c=relaxed/simple;
	bh=eXbUW+uiJDPt3EYlQ/sZ/nO0bB1DOBphU9kLXEXuTPw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZPzPFZmim3oaVz26SZxPVsMz9q4hUyAd5yrakNM1fSpBldERyXdffHrKDvh0MBI0YQytYOgGieRbdjchuwwdj8c4mv3Mlrc0lot+UGHFe99rjeBv8fM708bhOEXaD59p4mVUuprT2tQBnfV2dZHcgyMdUAn76ntEJkcPPBuOjCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KelTs+iV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2E87C43390;
	Fri,  9 Feb 2024 19:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707507028;
	bh=eXbUW+uiJDPt3EYlQ/sZ/nO0bB1DOBphU9kLXEXuTPw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KelTs+iVPViojOF6thdMBJhnb9PM9cV3H/uHallhT9wTxfXOahCo10Y7hKNOSgqkc
	 xCt+wHYsCmUtPfWpHUyOfK7VILB4GoTMww6W2YBEdRvXOssZRrsWoEOKbztODRdJc8
	 dhDU4VScSep4/VE8ijCb9o44sD+ynzG1cMgE+EWsSxPdMIHZOGWuohqYhY7zYv7+Sb
	 rmxbe/lMk5qTxxbsOwOmptrZrE/e1Pr3saZkZFYEUYiiY4+x1MUluY7R/OH6/CUGaj
	 Rc6NiPL/SmVEs1ofnyZbrc7WglLJSIqNuyTadrccT70zfzxZQFFy1uL36PKLHMrQp4
	 oHJ+sQHyDo1Nw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D9FE7C41677;
	Fri,  9 Feb 2024 19:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: forwarding: Add missing multicast routing
 config entries
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170750702787.24922.16288763737309895104.git-patchwork-notify@kernel.org>
Date: Fri, 09 Feb 2024 19:30:27 +0000
References: <20240208165538.1303021-1-idosch@nvidia.com>
In-Reply-To: <20240208165538.1303021-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 shuah@kernel.org, petrm@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 8 Feb 2024 18:55:38 +0200 you wrote:
> The two tests that make use of multicast routig (router.sh and
> router_multicast.sh) are currently failing in the netdev CI because the
> kernel is missing multicast routing support.
> 
> Fix by adding the required config entries.
> 
> Fixes: 6d4efada3b82 ("selftests: forwarding: Add multicast routing test")
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: forwarding: Add missing multicast routing config entries
    https://git.kernel.org/netdev/net-next/c/f0ddf15f0a74

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



