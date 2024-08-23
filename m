Return-Path: <linux-kselftest+bounces-16124-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FC595C1C2
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 02:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F5DF1F241F8
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 00:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCBA40BE3;
	Fri, 23 Aug 2024 00:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbGesK9n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8F53D552;
	Fri, 23 Aug 2024 00:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724371235; cv=none; b=GZyW+HTymvDdacpiz3unOVkftNAwyeklwJGNWxMazX1qLzE1UJLf09O3BH7KN5SSr6UYsWb57/il/Jppc+4Hl5NfRC96DhpzucAAiteaQVONEuEpAF7eNdCw+rCvqrB7B+MEzNW3y1szQ0sGa/rWfknNKprCsgm6ujLBtFGx/hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724371235; c=relaxed/simple;
	bh=9Ix57plRkqgGDfoQaVpJVMxYyedi/yo8CIrrk9lXJ4w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NvPpf8LJHPAn8J9FLhhQnFVo3Gx0lKNMZqbt8h5iEj8tr8XdnkRYLtdhk7N6J3xIUOWyhtlM7gRZx/gNYsCk7aiwfa+hoJBojl5BCi/AD7gc47NL4pr8wmQyl7IHBDvkqGVFpnL8hG8/7os+mFDYHZkC2AelzR7guuKsm2VMcU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbGesK9n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E876C32782;
	Fri, 23 Aug 2024 00:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724371235;
	bh=9Ix57plRkqgGDfoQaVpJVMxYyedi/yo8CIrrk9lXJ4w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mbGesK9nfdTJ9aCsyhtJy6SbTDXFMfhoK+tpxCbh4DFwO25gi8xMR2XM5DP6jbF8G
	 PxqddNTQlz6OXTEKZIIi7qOSeZF6arA+O7qvGR88ALXG8TQoeEMbZIjmJGTeoiF1DV
	 onktnK71ZRcSisIlR96JKFUCj08M6LYmcPvHOTqDYRr6jK6NAJokX1wCyVB2Emg4PT
	 O3emWcO2xAF8g6PyPznnSxqTqW+8Z7ADkXwlX2kbt4l/e9S2b469zFTjtzMDRVzQhx
	 l0ni32NFHyN9Uvm8c1O/vt6ddBpY6/339O/IARD+1ZFO5XduQz+gU6QWbjDUrKHRfW
	 4Yb69HrVrOeGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADCB3809A81;
	Fri, 23 Aug 2024 00:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v9 net-next 0/3] Enhance network interface feature testing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172437123474.2508974.8182091606834574738.git-patchwork-notify@kernel.org>
Date: Fri, 23 Aug 2024 00:00:34 +0000
References: <20240821171903.118324-1-jain.abhinav177@gmail.com>
In-Reply-To: <20240821171903.118324-1-jain.abhinav177@gmail.com>
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Aug 2024 22:49:00 +0530 you wrote:
> This small series includes fixes for creation of veth pairs for
> networkless kernels & adds tests for turning the different network
> interface features on and off in selftests/net/netdevice.sh script.
> Tested using vng and compiles for network as well as networkless kernel.
> 
> Changes in v9:
> Removed veth1 to avoid redundant testing as per feedback in v8.
> 
> [...]

Here is the summary with links:
  - [v9,net-next,1/3] selftests: net: Create veth pair for testing in networkless kernel
    https://git.kernel.org/netdev/net-next/c/1820b84f3c61
  - [v9,net-next,2/3] selftests: net: Add on/off checks for non-fixed features of interface
    https://git.kernel.org/netdev/net-next/c/6ce7bdbc0d4b
  - [v9,net-next,3/3] selftests: net: Use XFAIL for operations not supported by the driver
    https://git.kernel.org/netdev/net-next/c/8402a158028f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



