Return-Path: <linux-kselftest+bounces-22646-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A169DF382
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Nov 2024 23:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68166162878
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Nov 2024 22:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E476E1ACDED;
	Sat, 30 Nov 2024 22:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3OnSnMb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36E51ABECB;
	Sat, 30 Nov 2024 22:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733005217; cv=none; b=GBFSTYh/o18Hx6I/PbIck2PP6zSCHUGVad9uqwDU4UPhqQghKImOcCWNFuwRTWqTEugl0kSJ5gI9NQ8AiZlgtgfuBVFpnGUmQ4Fj8gl/iqdq6ZNNB0TUqFDtM1hfyytIyQIls2Q8G2kpMDbDFbOWaJE9V3rZ+Nivu3s6iP8IOuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733005217; c=relaxed/simple;
	bh=zP5GkgptoDq+IpFjIrNPxUyK2+r01cx9H5UxpWRq+/8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W7mQcsDWtSarHbzZerC67pwS1rVm6LNhpxQsQgDp1+4ySmTk2g1drLO4ITgnxgJ6JlId4im30SidMFCxhQOh3JvnvoiloNnf63z1BZimKKqf8oKUMq4lFgAcFS/gCRv2yv03bEi1ChLOCL+kfeFSEatogrZrgz2PBzaj+AxyQeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3OnSnMb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C52CC4CED4;
	Sat, 30 Nov 2024 22:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733005217;
	bh=zP5GkgptoDq+IpFjIrNPxUyK2+r01cx9H5UxpWRq+/8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A3OnSnMbralCzxVcipFzN1Ai21Wv2V4e+3hv2VPqrzeIhxNxk3tZ71DWyyzi5/DGj
	 2B3KPd1TS2CR2DyGMu2f6cdiEMHo+nYYUhBofEeA+ljZBcPCv7g8dLcE+ir2MLYZlx
	 UFsB9VLNprxvDCUFK71htMNUjwKocHcS6ycSMeX6oWzSQiMx+H5p5nRdGHQlxPEaDt
	 U5OvnTaUa0HjQBauoRAcVV3flJ6jExkah5IXtqXOwjHwLXVtZQc1mlzt3PukU4flph
	 0KyjvsulO71jzDJZb/1SUBeftWTN0WAHZXOIdinKHI/kotUJ85/xvRDW3b/DAAL75t
	 fIs3we7XJ7HSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EEA380A944;
	Sat, 30 Nov 2024 22:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2] bnxt: Fix failure to report RSS context in ntuple
 rule
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173300523098.2492979.671614887548460741.git-patchwork-notify@kernel.org>
Date: Sat, 30 Nov 2024 22:20:30 +0000
References: <cover.1732748253.git.dxu@dxuuu.xyz>
In-Reply-To: <cover.1732748253.git.dxu@dxuuu.xyz>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: pavan.chebbi@broadcom.com, netdev@vger.kernel.org,
 kalesh-anakkur.purayil@broadcom.com, linux-kselftest@vger.kernel.org,
 michael.chan@broadcom.com, linux-kernel@vger.kernel.org, kuba@kernel.org,
 martin.lau@linux.dev, ecree.xilinx@gmail.com, kernel-team@meta.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 Nov 2024 15:58:28 -0700 you wrote:
> This patchset fixes a bug where bnxt driver was failing to report that
> an ntuple rule is redirecting to an RSS context. First commit is the
> fix, then second commit extends selftests to detect if other/new drivers
> are compliant with ntuple/rss_ctx API.
> 
> === Changelog ===
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] bnxt_en: ethtool: Supply ntuple rss context action
    https://git.kernel.org/netdev/net/c/be75cda92a65
  - [net,v3,2/2] selftests: drv-net: rss_ctx: Add test for ntuple rule
    https://git.kernel.org/netdev/net/c/7078d43b2374

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



