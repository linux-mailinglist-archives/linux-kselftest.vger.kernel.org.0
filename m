Return-Path: <linux-kselftest+bounces-17559-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6394972640
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 02:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96B4328529F
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 00:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3E13F9F9;
	Tue, 10 Sep 2024 00:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNEMJw/A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2388D381DF;
	Tue, 10 Sep 2024 00:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725928832; cv=none; b=aAF9fbHfaIi8bL05+QveG4cOhbk5E7B5oCYp3QaH4YtktTUx2tIWiYoGr/NQws1P84AsUeA+6/Fa6Cr5mkQ85gJBHFLqc7Z2KVKNFXNTkKEfp8eLM2oj1dYYLqjYUb1KoemQPs7gL8YsxkBXGIu644mcV9VwtFmQ78KdKf4bPwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725928832; c=relaxed/simple;
	bh=L1i6clRPUeyCaQYIh6Hbo8M75ilE4EzsNRgJ/mi+nSM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VBQmuQlv4ss9qWmKX5jC4dn7HI97HTyy2/MuwyVr7yBCsrv7gQcNUMF0Jtf2ek7oshsNp4Y/T6HYIOc0zG3cj0MVLse0Nj7m/j/LXWsU52y9v1XFa2XhpnJVCfqmmB9JlPiMMbXcHnuvNmyA6crgNvntmrBRX6uZJ5cqIS+O5f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNEMJw/A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3138C4CEC6;
	Tue, 10 Sep 2024 00:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725928832;
	bh=L1i6clRPUeyCaQYIh6Hbo8M75ilE4EzsNRgJ/mi+nSM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mNEMJw/Aplx96zp7YnBid/rgcilszB2KfyceAEKSB/DmEJaEet/yrqNK1BewIUiL8
	 WeH1i19wNmLgPhymynwVfO08Mcx58Qv7Xln5mkNnfar1WyG2CP7klm/JvxNemgNUeL
	 iS7n5FNb5ayYYn5BiD8DdySM0+hp3zjoACdnwOLVNSQO/F4gde/Hn2QW0NIAMINlNF
	 G/p/jV92Oqomvk3hCajsqQbFCB7nwloJ/V3nDl12bA5zcdj4nWLtghsmsyb/9k6TsB
	 Ff3WThN6486fHiGEXfzkv1RgrMSbaci3o9oOwSi7XUhveN4S6M4f3dilwbKTznLH6R
	 05dx7usGr9Gew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D253806654;
	Tue, 10 Sep 2024 00:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] selftests/net: add packetdrill
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172592883274.3968469.12523150899951393582.git-patchwork-notify@kernel.org>
Date: Tue, 10 Sep 2024 00:40:32 +0000
References: <20240905231653.2427327-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20240905231653.2427327-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, ncardwell@google.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, fw@strlen.de,
 willemb@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Sep 2024 19:15:50 -0400 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Lay the groundwork to import into kselftests the over 150 packetdrill
> TCP/IP conformance tests on github.com/google/packetdrill.
> 
> 1/2: add kselftest infra for TEST_PROGS that need an interpreter
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] selftests: support interpreted scripts with ksft_runner.sh
    https://git.kernel.org/netdev/net-next/c/dbd61921a6ad
  - [net-next,v2,2/2] selftests/net: integrate packetdrill with ksft
    https://git.kernel.org/netdev/net-next/c/8a405552fd3b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



