Return-Path: <linux-kselftest+bounces-41076-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3251B508FF
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 00:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3DAD462E71
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 22:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03914272E7B;
	Tue,  9 Sep 2025 22:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gq9t+LIL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9CC27280F;
	Tue,  9 Sep 2025 22:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757458203; cv=none; b=pHkSaycML1oXmHLH5Km+tBGlBO95xRpfG0FfcQdjxmJeSRCV0/JAbmioFIPSxaGYUILtILalnyqDrAZh/xMvSxUiQqCR5EDC1DpJFckYPbvH6KOZSiKxWt4g9NHFhpC5PmjIBgLBch8Vdb8icItSZVienJXcEZsjiYzwRV910u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757458203; c=relaxed/simple;
	bh=piMGZyay2tIxwSnI8y0GyVywuYnemy82IaupNskq4ic=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kJPP3xuo/V+4NXPkPEJUy6xl5BFOlD1tpvce3ckRWgLIDk5H0oll9Ocyj9LMEfrUmIKmB4F5PYAkxedxQyAplMu6ZYQb0jslTptAysiQlp0swgb0xNpt9sbIvAMFJ7FVxzqTvqXD9NTPIRBOmfmvamYy4z3rEMTMul+yA92BagE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gq9t+LIL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475FAC4CEF4;
	Tue,  9 Sep 2025 22:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757458203;
	bh=piMGZyay2tIxwSnI8y0GyVywuYnemy82IaupNskq4ic=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Gq9t+LILtXhEae+7sDbeBvtn2qWTqZ0a9ty8gHMgusPW7mlwfthiQZCFGUKd2U9Qs
	 nZVLWt1angQc9ynMiK99v99T0H1luGaEYA69WTC5T940ZhjqDtJhm8+oKeuzKxw89l
	 aDFCmWcE8E4Qo34pelYvlZvmAvmIdcpcF8FoOjJVvzdpRI00UsOufmbP/nSgWebO4X
	 vqROQX31R/NmMk8GOuVufObuske+s8Zo/c1W+PcKKb+/amPhxY+Mh2USbF/dcitQf+
	 k90XphGmrR29ehWlzMTo+3SbgxkLH1mDMTFiO1DnCrpA7trOYGoI1Hu63o7SoU4Fe/
	 a/arE2fT7UxZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE17383BF69;
	Tue,  9 Sep 2025 22:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] selftests: net: run groups from fcnal-test in
 parallel
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175745820652.839238.279600605404397825.git-patchwork-notify@kernel.org>
Date: Tue, 09 Sep 2025 22:50:06 +0000
References: <20250908201021.270681-1-kuba@kernel.org>
In-Reply-To: <20250908201021.270681-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, dsahern@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Sep 2025 13:10:21 -0700 you wrote:
> fcnal-test.sh takes almost hour and a half to finish.
> The tests are already grouped into ipv4, ipv6 and other.
> Run those groups separately.
> 
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] selftests: net: run groups from fcnal-test in parallel
    https://git.kernel.org/netdev/net-next/c/a12fd5c31b78

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



