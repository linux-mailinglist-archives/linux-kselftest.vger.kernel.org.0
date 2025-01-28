Return-Path: <linux-kselftest+bounces-25302-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636D4A20A8E
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 13:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A46B33A703F
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 12:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DDF1A23B8;
	Tue, 28 Jan 2025 12:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHSHQAqV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2891A239E;
	Tue, 28 Jan 2025 12:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738067404; cv=none; b=DowLJZpXtrZTz0AfWOxnY4Q62qONJLHhE9iv+HwRKViPmtotZg/r8MlWkoc3RKg6B4W9R07lZBCgxZW91Soh8sbJboEuhTOfqoOje/zXjvVebXLdxAhfdHelVLlZt7kVEXYrtLfSy+7x61L3IDj7BnmsdoTfD+3DbwwOnj8XwHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738067404; c=relaxed/simple;
	bh=sZk9JmRVURe+MLafhp0VRKv8PXcPp2BfFLYQ2wZsD2w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rSSNxIZqXPmCEe9H6wdH5E+l5UGf43sWg/vnrInty+QHW6Duf3wLuDe5gQASTgOsMft2tgLRLODUPYXf3e9hSGTI4i3zTyWa6Ncb6Z9KHthacttDcqh5aTnSdoiLk2y5og5VOjLYl1DoE+hzIOhpIsiYyp/GFdnBHlUXlaWf5k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHSHQAqV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA47C4CEDF;
	Tue, 28 Jan 2025 12:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738067403;
	bh=sZk9JmRVURe+MLafhp0VRKv8PXcPp2BfFLYQ2wZsD2w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CHSHQAqVORAndqhtgDhhyNDegrSur9b/qlRUv9+/fn/8oDBAE4E3xzm2TQgL9Dy+S
	 M1COiW0RPwXjuZSZVySBPNlQoB5/THRdrBXEyx7403bmim4EDSR9X7NdG207Jp1AIK
	 Sx0oiUwSsIWIsYog5ClaNPQYJ71LE3YqsE9yy/GzKvIHOq0SUWvBtxKiwO4SQleIyB
	 N9ouPyzai/SZrpvxNbCZd4t2UfSo6yUwVWlC7UmmYL6wb80uDaAZ8QaUoos5SpxZhf
	 6PW0DAcomlBCL1u19/YFzmcSFll5lwCRgP5UuzVLW2x3Jv0b/YmmYWU1PXTdYiuKyB
	 s3Ryk/EGTXEfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 35CC6380AA66;
	Tue, 28 Jan 2025 12:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] bonding: Correctly support GSO ESP offload
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173806742905.3778420.4837023666032645594.git-patchwork-notify@kernel.org>
Date: Tue, 28 Jan 2025 12:30:29 +0000
References: <20250127104147.759658-1-cratiu@nvidia.com>
In-Reply-To: <20250127104147.759658-1-cratiu@nvidia.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, razor@blackwall.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, jianbol@nvidia.com, borisp@nvidia.com, tariqt@nvidia.com,
 linux-kselftest@vger.kernel.org, liuhangbin@gmail.com, liali@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 27 Jan 2025 12:41:47 +0200 you wrote:
> The referenced fix is incomplete. It correctly computes
> bond_dev->gso_partial_features across slaves, but unfortunately
> netdev_fix_features discards gso_partial_features from the feature set
> if NETIF_F_GSO_PARTIAL isn't set in bond_dev->features.
> 
> This is visible with ethtool -k bond0 | grep esp:
> tx-esp-segmentation: off [requested on]
> esp-hw-offload: on
> esp-tx-csum-hw-offload: on
> 
> [...]

Here is the summary with links:
  - [net,v3] bonding: Correctly support GSO ESP offload
    https://git.kernel.org/netdev/net/c/9e6c4e6b605c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



