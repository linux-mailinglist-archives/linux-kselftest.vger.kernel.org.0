Return-Path: <linux-kselftest+bounces-5884-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B7787145C
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 04:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A9E284C07
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 03:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A5A38F91;
	Tue,  5 Mar 2024 03:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dD4Kbivh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9460D2942A;
	Tue,  5 Mar 2024 03:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709610026; cv=none; b=h5ypQl8iU9v7XIOiPv6x92bZo2at/X7EihcymPGxh9Jx9Ts1GEODS3I4tBPpA41wG83V88oXJdEIKTG1yavnsPmnFghw0xdWeA5UWhj9t7FgzxcJCfgVEXgj6F6cZrXwvsAwNZTPpqBKvrtVdl16Rh6jGxl/VRX3dIjb7jBdIb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709610026; c=relaxed/simple;
	bh=H1PtRc/W4yf4gSpezrRjDoToPdrnhuGKWGPR9ZfJU7w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YpHWK2fKBSrEQeD44HdD975IVV3wpcDMkI2JtojKBJ/0h4/TQjBDDyVhVmX7gCrVHKS9roqwP1zkTRyh6aY/XBsqLLNXGD0r6A3+xGvj0rOuU8f60iX5vVaDxodge38TX8NP/JPZLgsj4tLUDe4K8hCOhrBDcr2emNIb7RtXlvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dD4Kbivh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 224ACC43390;
	Tue,  5 Mar 2024 03:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709610026;
	bh=H1PtRc/W4yf4gSpezrRjDoToPdrnhuGKWGPR9ZfJU7w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dD4KbivhfYEns/iGMSGMIeJG8SiGnvNneFKmq3Wjrp5vvTbswdtmAgu13CcO2oGhV
	 FiiLJBH1oDava2YtDN3hl/RPkdJe39eSXHPICCtSyJ05OzJcmI/ZQNM+PhJu+GjYxb
	 c7TCkS7aK17Ti0bJBhQMGLBkWcr6GIwA2zcbVUZk+2uVN1Ku7RGVbTFGHP6dTxTI18
	 Isq2MkzesbM6Ficul6Ju0uayhBijsCYhW7aOsXCDkV6JdFr4FyH8SzqAsw+Kmfdwwt
	 EzG2ELcBXf/eh9HMfbEEVGQvE6/ZKc/eKc37FTgjfJceL5Wyb3hXgt7sicTytdjO1J
	 LOS4xbdq98D5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0720EC595C4;
	Tue,  5 Mar 2024 03:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: net: Correct couple of spelling mistakes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170961002602.3516.15535602203159521376.git-patchwork-notify@kernel.org>
Date: Tue, 05 Mar 2024 03:40:26 +0000
References: <20240228120701.422264-1-pvkumar5749404@gmail.com>
In-Reply-To: <20240228120701.422264-1-pvkumar5749404@gmail.com>
To: prabhav kumar <pvkumar5749404@gmail.com>
Cc: shuah@kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, petrm@nvidia.com, idosch@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 28 Feb 2024 17:37:01 +0530 you wrote:
> Changes :
> 	- "excercise" is corrected to "exercise" in drivers/net/mlxsw/spectrum-2/tc_flower.sh
> 	- "mutliple" is corrected to "multiple" in drivers/net/netdevsim/ethtool-fec.sh
> 
> Signed-off-by: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
> ---
>  .../testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh | 2 +-
>  tools/testing/selftests/drivers/net/netdevsim/ethtool-fec.sh    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net-next] selftests: net: Correct couple of spelling mistakes
    https://git.kernel.org/netdev/net-next/c/fb0f02308126

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



