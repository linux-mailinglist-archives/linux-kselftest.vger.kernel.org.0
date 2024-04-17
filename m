Return-Path: <linux-kselftest+bounces-8235-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF62E8A7A4A
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 04:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91F251F221C8
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 02:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BD71878;
	Wed, 17 Apr 2024 02:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxyynuCg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03A04685;
	Wed, 17 Apr 2024 02:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713319229; cv=none; b=jchQ6tySnQPDR4ZFgHvaEgUZBEFofp8wcaBk6ExYE9PZbtqIglfQ6b3WuJDnjhxWZHEp9RvSo37ja47+3+Yr324p2wwKItpPugkk5IlGe3S0FUBTpY56pgLwRlyNbIaO3s+HWrLOHompZF0PvhpDf0a64AgotWuhUXzML8noNU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713319229; c=relaxed/simple;
	bh=cC63+XpffDjWWegKYfmvLRokZnNZnA6i1aS2/skGiaI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OnsNzdQB9h7XMDN7uwHfJBtKRqkKLFIS5YD5mxQPHdQCkgrCosk3G3tJNcT2b8XdXyLUmTELBXP4crvZ+w9MdON8/gmochvA6gKi/6cRGrptXpasTZH02bi/kyBb8cfKxd2p/nlTW3zDoMmtcFKZ1rCaFj1/UNOdvhsjIiaF6VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxyynuCg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5041AC2BD11;
	Wed, 17 Apr 2024 02:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713319229;
	bh=cC63+XpffDjWWegKYfmvLRokZnNZnA6i1aS2/skGiaI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KxyynuCgZtU8ijFDCnxNz1eBnIFrxO93wCSnenjxRtTU0OEM3KFhjIdoOE09HgQIl
	 /w7Iwny46gU1FlrbmnWhyw9XHLxIjAss/h39r8a3TpLyP+Jjersggfah6cCSVb9iZg
	 MPG83eys/KUCJj9sapvBdsjF0NVSjWmcqCfQkBKR7NPvk72B71Fm+sYQFZoWEuFB18
	 L6zkrkq/VFfqOfpyZGekHhwi0ekXkZz//HiIgmiTP9afmJdfHilPqss1UMKED3WFX+
	 sQ2mfTB4ugMLvXRCaIGMA5rbYTqKUh7MqF6Fcc8JB4o7jQOq9S26uaFSU5ArR8tpRj
	 C+xH1TmdCbYzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D57DD4F15E;
	Wed, 17 Apr 2024 02:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/6] selftests: drv-net: support testing with a
 remote system
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171331922924.11866.18060730176000410758.git-patchwork-notify@kernel.org>
Date: Wed, 17 Apr 2024 02:00:29 +0000
References: <20240416004556.1618804-1-kuba@kernel.org>
In-Reply-To: <20240416004556.1618804-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, petrm@nvidia.com,
 linux-kselftest@vger.kernel.org, willemdebruijn.kernel@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 15 Apr 2024 17:45:50 -0700 you wrote:
> Hi!
> 
> Implement support for tests which require access to a remote system /
> endpoint which can generate traffic.
> This series concludes the "groundwork" for upstream driver tests.
> 
> I wanted to support the three models which came up in discussions:
>  - SW testing with netdevsim
>  - "local" testing with two ports on the same system in a loopback
>  - "remote" testing via SSH
> so there is a tiny bit of an abstraction which wraps up how "remote"
> commands are executed. Otherwise hopefully there's nothing surprising.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/6] selftests: drv-net: add stdout to the command failed exception
    https://git.kernel.org/netdev/net-next/c/232d79aaa781
  - [net-next,v2,2/6] selftests: drv-net: add config for netdevsim
    https://git.kernel.org/netdev/net-next/c/438ce84bae90
  - [net-next,v2,3/6] selftests: drv-net: define endpoint structures
    (no matching commit)
  - [net-next,v2,4/6] selftests: drv-net: factor out parsing of the env
    (no matching commit)
  - [net-next,v2,5/6] selftests: drv-net: construct environment for running tests which require an endpoint
    (no matching commit)
  - [net-next,v2,6/6] selftests: drv-net: add a trivial ping test
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



