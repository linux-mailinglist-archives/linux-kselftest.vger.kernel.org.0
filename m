Return-Path: <linux-kselftest+bounces-15621-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E53C956638
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 11:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A700B1F25852
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 09:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB14915AADA;
	Mon, 19 Aug 2024 09:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNrAlp2j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB64811CBD;
	Mon, 19 Aug 2024 09:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724058068; cv=none; b=X3aIqLLXE1Mdw43+5S2WdYGdy8/xIissHsdFcw8BlSETsRByMbCzILw1PZ2FS++vJPqtV+VSZidDomHz0VaTCysjpcJbFa8EveEjIbKNDp/SxizHb78YgDWlQNTplcLWI+PEz1Eb8BL7l4qbtYqrrbTc5HWv2BiCLJLSeMgndRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724058068; c=relaxed/simple;
	bh=hlYGzbYibEJQWLYe9ahyc6Ds7J5K8SzGSxmE5yOvVM4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BM5TahbCgMWlh0LlwZTSY09KNwlvSIvMbiS8HYlBVIJep9u113Ft56LTCqXgvBL8qvUW9Myr/VfItJjqDCfOcXCsvbJBb++lsKpr4rqYz+L2pZZwzbPiqKMCyZEH2hlXN4xwyMkDFRT6DyQ2WzuEs6wEexpa3LpWRJMktJJtJ2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNrAlp2j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49EDCC4AF0C;
	Mon, 19 Aug 2024 09:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724058068;
	bh=hlYGzbYibEJQWLYe9ahyc6Ds7J5K8SzGSxmE5yOvVM4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qNrAlp2j+V81DUjGXghqoCKdznpmi2ws8Ax7l0tf+ULAu5u1iCc1spBu3C9va2sNY
	 JJxDqsCCQ+5vSZeTBjv4XvD7ZFVAJ4sMf6VjUbP0UERnDHcCtYT+yjzxN4YTQZb2o0
	 74RBudiUXoWBX6fK5jp/mPbual/xWwS3Ro+ae+fXyLjfpmh7fHTayrPmBIdz2IcsBn
	 kCONmyA3HZwc/iI27q+CfZpeW7rWHW6E57geDNPCmXkj+jg1Noo+7+yaWnPxqht7wF
	 LBbKtxBMt2Jv5dmVyjoyzSXMnNYj6Z42hwjV+GkRPbTH/DsrGxE/IDiSPgpNLksyZM
	 DVOJsCOS6/MOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE583823097;
	Mon, 19 Aug 2024 09:01:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 net 0/2] selftests: Fix udpgro failures
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172405806778.469464.5030792856738166757.git-patchwork-notify@kernel.org>
Date: Mon, 19 Aug 2024 09:01:07 +0000
References: <20240815075951.189059-1-liuhangbin@gmail.com>
In-Reply-To: <20240815075951.189059-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 toke@redhat.com, ignat@cloudflare.com, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 15 Aug 2024 15:59:49 +0800 you wrote:
> There are 2 issues for the current udpgro test. The first one is the testing
> doesn't record all the failures, which may report pass but the test actually
> failed. e.g.
> https://netdev-3.bots.linux.dev/vmksft-net/results/725661/45-udpgro-sh/stdout
> 
> The other one is after commit d7db7775ea2e ("net: veth: do not manipulate
> GRO when using XDP"), there is no need to load xdp program to enable GRO
> on veth device.
> 
> [...]

Here is the summary with links:
  - [PATCHv2,net,1/2] selftests: udpgro: report error when receive failed
    https://git.kernel.org/netdev/net/c/7167395a4be7
  - [PATCHv2,net,2/2] selftests: udpgro: no need to load xdp for gro
    https://git.kernel.org/netdev/net/c/d7818402b1d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



