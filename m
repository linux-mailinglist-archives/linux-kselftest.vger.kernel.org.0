Return-Path: <linux-kselftest+bounces-30277-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE0CA7EC20
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 21:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2290F189CE40
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 19:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEB526139C;
	Mon,  7 Apr 2025 18:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/XWujov"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C107B261395;
	Mon,  7 Apr 2025 18:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744051200; cv=none; b=Tv47GDVq8sR4l07DgWAVW8T9KWprSI6cBdIIai7acLMsx2znWVVAbzBytwUIz4iVQVkzdJrpgmE8kbD/pxPUGnAe8Z5zax5JvaUn6YjbStKA33cZqGJ5P04uwDiPLS7eZf56KMImzbIuI/xcE+HxB1urBKsbYJqLDnRwf7GtnyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744051200; c=relaxed/simple;
	bh=dd/BnSjEQXYZiqtaY2qo82xDxyRpkslguj70Xb5o2Nk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iGYHPrg4p+JAlxgDxhyV+tZkj3NiYOwDLINrJXeq3v/GoVA1clFyWKPuC7RFIX5hSw54kFwS1ltahBPucwiFlcEjYRxtZOKHarmF4YHMowc2qmxdIDyNG+mAe+ND3yKuTkPdBOiR4YpDu8RdeVrg8UWUf2MJacyO1JkEJG1hcNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/XWujov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376CDC4CEDD;
	Mon,  7 Apr 2025 18:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744051200;
	bh=dd/BnSjEQXYZiqtaY2qo82xDxyRpkslguj70Xb5o2Nk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=j/XWujovwR47RiRKIyRzJ6bF3sqR2xkPh6krwb1RzUdGm1e9XQVLIL9ufsWhiIw8w
	 yTe+rUDE8RQpJyptijd10jmwWwyppv1ldPqnBVaZMIQNFiAFEeW504xE54fBBudtnX
	 R/Me4jdLeB0kse0HV8RGglBVDima0sGeTh1zb/dKuEXocA66cjrU5ZJnSjor/FGxCP
	 fLHt0CzxjqzC87lRKzR5A7ql6k2gCAG2l3uj5VxhS96+RHP165Va/8hulhE/qc5ioH
	 EAr356m9OYT1+X+wXkQNgLq+NicMiaIxBy2tnx4Gnch0trlMONyoB+obSqQCDsvC4I
	 ghalRlusbNPCA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0B9380CEEF;
	Mon,  7 Apr 2025 18:40:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/2] fix wrong hds-thresh value setting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174405123750.1227543.18375397673178337819.git-patchwork-notify@kernel.org>
Date: Mon, 07 Apr 2025 18:40:37 +0000
References: <20250404122126.1555648-1-ap420073@gmail.com>
In-Reply-To: <20250404122126.1555648-1-ap420073@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kory.maincent@bootlin.com, willemb@google.com, aleksander.lobakin@intel.com,
 ecree.xilinx@gmail.com, almasrymina@google.com, daniel.zahka@gmail.com,
 jianbol@nvidia.com, gal@nvidia.com, michael.chan@broadcom.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  4 Apr 2025 12:21:24 +0000 you wrote:
> A hds-thresh value is not set correctly if input value is 0.
> The cause is that ethtool_ringparam_get_cfg(), which is a internal
> function that returns ringparameters from both ->get_ringparam() and
> dev->cfg can't return a correct hds-thresh value.
> 
> The first patch fixes ethtool_ringparam_get_cfg() to set hds-thresh
> value correcltly.
> 
> [...]

Here is the summary with links:
  - [v2,net,1/2] net: ethtool: fix ethtool_ringparam_get_cfg() returns a hds_thresh value always as 0.
    https://git.kernel.org/netdev/net/c/216a61d33c07
  - [v2,net,2/2] selftests: drv-net: test random value for hds-thresh
    https://git.kernel.org/netdev/net/c/22d3a63d5321

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



