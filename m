Return-Path: <linux-kselftest+bounces-29581-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4DEA6C222
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 19:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7E40189CD2C
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 18:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C89222E414;
	Fri, 21 Mar 2025 18:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qeEZ7KDc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8721D5AC0;
	Fri, 21 Mar 2025 18:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742580598; cv=none; b=PbLFPenHg263HS62ctkUtO8TuDf7CRrtDbtwCwXlRA2NjyCfq/pFb3PoXy1TG4lV9TFc2qpoYJDRq45gThr9VDm10mz4pxFyvzBhPE7x5KpE6Wua3/Uj68aMy14acLxzw4Qvso7epmOt5Lciul1RaZEJ7+I16uat5NB6h+xgjuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742580598; c=relaxed/simple;
	bh=oVWIbWQyeO1eYdPOvb4GZar6A1uAB/ChS30Nh+3NuNA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Lxe245WFCuu/8/aZhWsH6JJrqqVGbnWIpXHBrztQViTTbebZytC6+VHFIwldSzRm1kk1a7lF87hW4jq2JqTXhxypCshh1em0nst8Zyly9s+79OZ6yW/zCHs8hW4zfy5DxA4VSN4jCX2zV/zfNwy+cIZ5pzB4SsAGDYZu15zdI9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qeEZ7KDc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A63EC4CEE3;
	Fri, 21 Mar 2025 18:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742580597;
	bh=oVWIbWQyeO1eYdPOvb4GZar6A1uAB/ChS30Nh+3NuNA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qeEZ7KDcHzenjrGx3duY7KlkgqpU6/bL75ws1KAkL13dkefppg+FsH94Jr9l/ZiP8
	 U4y6gHeyCFH7cVhnP67VhQ5x11+gdYwnP4Tca8FoIAMpPDY4d5HpmfpJcQy0f6UfXh
	 mLjUiUQzRk9MYcud+VW9wnZW1+su8AC8Mtm35iGAlGUJKJL6cANwJ5VnrG5wkOHoik
	 7Ke+zLJODQljSJKX4z/enzUfuIP0bkOc1tF9HUCzhCYuzpUbvVlMFj1UHL17uK5BqU
	 qHqeeObsqxQ9am/gN1Lxcxai32G84zBVPtrRoyaGEPslRjm0IIxN+SKS5xY/UVH2sL
	 4NVSEZ2EV1/qA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE15F3806659;
	Fri, 21 Mar 2025 18:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6] netconsole: Add support for userdata release
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174258063351.2577757.7447290178394801231.git-patchwork-notify@kernel.org>
Date: Fri, 21 Mar 2025 18:10:33 +0000
References: <20250314-netcons_release-v1-0-07979c4b86af@debian.org>
In-Reply-To: <20250314-netcons_release-v1-0-07979c4b86af@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, horms@kernel.org,
 corbet@lwn.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 chantr4@gmail.com, kernel-team@meta.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 14 Mar 2025 10:58:44 -0700 you wrote:
> I am submitting a series of patches that introduce a new feature for the
> netconsole subsystem, specifically the addition of the 'release' field
> to the sysdata structure. This feature allows the kernel release/version
> to be appended to the userdata dictionary in every message sent,
> enhancing the information available for debugging and monitoring
> purposes.
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] netconsole: introduce 'release' as a new sysdata field
    https://git.kernel.org/netdev/net-next/c/42211e310781
  - [net-next,2/6] netconsole: implement configfs for release_enabled
    https://git.kernel.org/netdev/net-next/c/343f90227070
  - [net-next,3/6] netconsole: add 'sysdata' suffix to related functions
    https://git.kernel.org/netdev/net-next/c/b92c6fc43f4e
  - [net-next,4/6] netconsole: append release to sysdata
    https://git.kernel.org/netdev/net-next/c/cfcc9239e78a
  - [net-next,5/6] selftests: netconsole: Add tests for 'release' feature in sysdata
    https://git.kernel.org/netdev/net-next/c/4b73dc83ed96
  - [net-next,6/6] docs: netconsole: document release feature
    https://git.kernel.org/netdev/net-next/c/56ad890de2cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



