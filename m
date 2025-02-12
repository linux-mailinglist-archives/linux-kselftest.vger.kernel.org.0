Return-Path: <linux-kselftest+bounces-26437-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF94A31A7C
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 01:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5E21887038
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 00:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D946BB673;
	Wed, 12 Feb 2025 00:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6RGxGFK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84D227181C;
	Wed, 12 Feb 2025 00:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739320207; cv=none; b=rUN4rfjnXfcn9+QjkvYYWCpgNubppeY88m61hbFwBU/qbmm9ddgjfg8fJj9xR4ckQANJSvuzVMNX4mMdwXZm/E8sBCTRE3qIRFEeHdOviNkhhViqp7GKOx4rlKqZgSznMZBaA2iMCIlftndLVufvW7ylzgB83g6chuy2Yix3Xmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739320207; c=relaxed/simple;
	bh=dMzq6zSBRNR6RjeYLAiK6Rcfp8YuSbUOBigfnfCdrhk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lFYR/zg8vUIQCQZGo53bFtDb0zJpj6eRYc0SYWypGCduuKX/0CAhOzbgDuaIGlRYjd5aEcymwy7rkU/kibMDSKxP8XzFO0QjnwtmdIsn92Izp3lQFWfOuNn9+ycnHYDIv03J+IesOBXcVBej3QDQM741kdswZvJc4k34DpzcgSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6RGxGFK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24DB1C4CEDD;
	Wed, 12 Feb 2025 00:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739320207;
	bh=dMzq6zSBRNR6RjeYLAiK6Rcfp8YuSbUOBigfnfCdrhk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P6RGxGFKAcbQzR7pSf3wzEzgfQBduIfLIIpb5tl+ETbS/iEChoXdta312ZUehbDWD
	 NHrD91FTqoNLGfeUD4m1wAaFlQsKsymDItWGSGryPMdFn4xO7pofIgbzm0iYO0eilg
	 IlJDPkgtRnN6QGLvAauhN+wCOuyPEcEKe8c2TfClOYXo+ibLZtv0PmH5ZJ29kNHuTU
	 Zc8lbQ3nTRePKcQRLthkjsIhUSEmdQL42NhwABmfcL3idSPrwJh2AbjL/J32syS67d
	 C5bE+rYSbqtJDTuDVrMZaz9qAzWew53vyK+s9FFBg9SiT+KvEQLepOfJwG+Bf7ITUA
	 P/EIzS6x5YNeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33ECE380AA7A;
	Wed, 12 Feb 2025 00:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] blackhole_dev: convert self-test to KUnit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173932023585.48583.1865548185343075920.git-patchwork-notify@kernel.org>
Date: Wed, 12 Feb 2025 00:30:35 +0000
References: <20250208-blackholedev-kunit-convert-v2-1-182db9bd56ec@gmail.com>
In-Reply-To: <20250208-blackholedev-kunit-convert-v2-1-182db9bd56ec@gmail.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: akpm@linux-foundation.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 nathan@kernel.org, ndesaulniers@google.com, morbo@google.com,
 justinstitt@google.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 08 Feb 2025 14:26:43 -0500 you wrote:
> Convert this very simple smoke test to a KUnit test.
> 
> Add a missing `htons` call that was spotted[0] by kernel test robot
> <lkp@intel.com> after initial conversion to KUnit.
> 
> Link: https://lore.kernel.org/oe-kbuild-all/202502090223.qCYMBjWT-lkp@intel.com/ [0]
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> 
> [...]

Here is the summary with links:
  - [v2] blackhole_dev: convert self-test to KUnit
    https://git.kernel.org/netdev/net-next/c/b341f6fd45ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



