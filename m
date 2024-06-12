Return-Path: <linux-kselftest+bounces-11731-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA3E904943
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 05:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E070285C06
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 03:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D25F514;
	Wed, 12 Jun 2024 03:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXtI/rnI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959E32D60C;
	Wed, 12 Jun 2024 03:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718161238; cv=none; b=G7h6qmdqkTTNPdKYzR5oyKnXUru59bugaomz6xAyWChabsPgJRSise71y3AhjdbEDZB5ev2hRAC9xq3hkBxtRIKzvAdGqg/9oxfjJAke3QofqkIz0ChaRGS7xsBDoiU0mMTCZncIjIuvy5gb7gkUKwZabF4oLoyLM7RLHBmimlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718161238; c=relaxed/simple;
	bh=J/kQkK84KQJAkIFQhoiCtHTv4yGPIAirFnvd3aW3x2Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z8p7BhrjtcL+nrHSo5LEoXvtoOqHT1+A6PEHMNBJy1m4muDilMQcIGo7I2AOau4m8daw7ZLl+zmVpIEk5eXamW9xzIMvm0WyWz+WXj4w5j3hzzxNMBJvd/VUtzaTDGfgU2aE2APIWQh0lcLLajTAVyzMF538VdDqdVDCLrGQzHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXtI/rnI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71BCCC32786;
	Wed, 12 Jun 2024 03:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718161238;
	bh=J/kQkK84KQJAkIFQhoiCtHTv4yGPIAirFnvd3aW3x2Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SXtI/rnIth8j9oQDxbtTNNpSDTVyRo+yikew61JFqkGM+8i73aXqcSL2ukTqWHDeJ
	 gQPEUPk8JQljrLwi0Kr+ZkWDir80ErunONy/7gFX9F3wfZ/q9KD09hp9du1X5ULZyE
	 +mBwDDae6qMLsTXQsCpPTGw2CW1Yhqpu44crupj9nZXmQAntGHNo/qc0n6nCY4WGPw
	 5Uu1zfZ4I9kRM5qIj0mRbrLBfBWk7n/haowc/UkR4R95M4WS3cNeGOCjpj4U5UfqXR
	 gvAGukxWrcKdsPTKyjDsANM9682YMuP2scfeT2VvdA3/GTGPXF/jlJQ0M0IWTaFrrP
	 3+ip3ZYHe4Szg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 636AAC54BB2;
	Wed, 12 Jun 2024 03:00:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6] selftests: mptcp: use net/lib.sh to manage
 netns
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171816123840.11889.13593974623249727089.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jun 2024 03:00:38 +0000
References: <20240607-upstream-net-next-20240607-selftests-mptcp-net-lib-v1-0-e36986faac94@kernel.org>
In-Reply-To: <20240607-upstream-net-next-20240607-selftests-mptcp-net-lib-v1-0-e36986faac94@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, martineau@kernel.org,
 geliang@kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, tanggeliang@kylinos.cn

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 07 Jun 2024 18:31:01 +0200 you wrote:
> The goal of this series is to use helpers from net/lib.sh with MPTCP
> selftests.
> 
> - Patches 1 to 4 are some clean-ups and preparation in net/lib.sh:
> 
>   - Patch 1 simplifies the code handling errexit by ignoring possible
>     errors instead of disabling errexit temporary.
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] selftests: net: lib: ignore possible errors
    https://git.kernel.org/netdev/net-next/c/7e0620bc6a5e
  - [net-next,2/6] selftests: net: lib: remove ns from list after clean-up
    https://git.kernel.org/netdev/net-next/c/92fe5670271a
  - [net-next,3/6] selftests: net: lib: do not set ns var as readonly
    https://git.kernel.org/netdev/net-next/c/577db6bd5750
  - [net-next,4/6] selftests: net: lib: remove 'ns' var in setup_ns
    https://git.kernel.org/netdev/net-next/c/f8a2d2f874b7
  - [net-next,5/6] selftests: mptcp: lib: use setup/cleanup_ns helpers
    https://git.kernel.org/netdev/net-next/c/f265d3119a29
  - [net-next,6/6] selftests: mptcp: lib: use wait_local_port_listen helper
    https://git.kernel.org/netdev/net-next/c/1af3bc912eac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



