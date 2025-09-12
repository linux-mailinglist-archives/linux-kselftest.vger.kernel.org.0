Return-Path: <linux-kselftest+bounces-41272-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5AEB53FE7
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 03:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A73A9AA43D3
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 01:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF83B54758;
	Fri, 12 Sep 2025 01:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muUGO9kJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A556E15ECD7;
	Fri, 12 Sep 2025 01:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757640837; cv=none; b=bv0424lVV9yJSoLnSo8tgArvkAGtXzpSNaX0DEV2/uOiIXeIVtdxR9p8rrbSg3Ed4nFu4zkm3PBE1X5pxVbcehCHC+rVUbtyjNepuz8FPMSdNrYo9YyH4TS/Fsx9Z6j9BGBFVJ/qqicpwx3nq7ZdRa5W8sOw5kUVKfFhcdhYkAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757640837; c=relaxed/simple;
	bh=vG0kjAUYKuIhXTyQzMeZYUvyiQzR8Oxef3QN3QE3pHc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mhqk0xvI07EDok9xbxHBK325biNDl2be4LbzmIM/KnnB2ppbiQ/NYrhL86VKI0QcPqhAW2pC/4H2Xik14T/GXe2yUh3YNi8v7Ex5x0gZcVwE66KJe0bi60ATBAvntRuwIcIXUcBTgHVFxCoWmWxp63yJITNs/JsnAIXYVjfK2xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muUGO9kJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335E8C4CEF0;
	Fri, 12 Sep 2025 01:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757640837;
	bh=vG0kjAUYKuIhXTyQzMeZYUvyiQzR8Oxef3QN3QE3pHc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=muUGO9kJFUhSNdq4IJth+6ehIfmg2Vge0aK/Cg1aaECRSx6l9ZBzqFsHCAd3MC5+K
	 bCinEXeoufMu64+bJaxq5kXD8ptG3m6h7gy0/ajteCSoHjvN36fH5XToQPB5Hp7oeU
	 C+rnMsjdQhRf8LxAQXKR1mQt+R1DhjtPyMBKRYr7CyTrbhm80QJ8z5CikkQUaGU/x5
	 OQ/sBVDVPQFzCy5FGoPMpAePqBpj+hFt+uS7Cff5Aw9v46VWfgWXwPC3v8FflWc6zG
	 K2JNyrXSkkA207DeVIy4c/K7N45EJLRRHcZFxwUDcbIsrQaQY6tO71peQqNURfQBhN
	 9kwGXk7o/TEqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEC2383BF69;
	Fri, 12 Sep 2025 01:34:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] selftests: Disable dad for ipv6 in
 fcnal-test.sh
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175764083975.2367774.17529978426990502405.git-patchwork-notify@kernel.org>
Date: Fri, 12 Sep 2025 01:33:59 +0000
References: <20250910025828.38900-1-dsahern@kernel.org>
In-Reply-To: <20250910025828.38900-1-dsahern@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, kuba@kernel.org, linux-kselftest@vger.kernel.org,
 shuah@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Sep 2025 20:58:27 -0600 you wrote:
> Constrained test environment; duplicate address detection is not needed
> and causes races so disable it.
> 
> Signed-off-by: David Ahern <dsahern@kernel.org>
> ---
>  tools/testing/selftests/net/fcnal-test.sh | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - [net-next,1/2] selftests: Disable dad for ipv6 in fcnal-test.sh
    https://git.kernel.org/netdev/net-next/c/53d591730ea3
  - [net-next,2/2] selftests: Replace sleep with slowwait
    https://git.kernel.org/netdev/net-next/c/2f186dd5585c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



