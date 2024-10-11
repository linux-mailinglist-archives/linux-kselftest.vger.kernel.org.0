Return-Path: <linux-kselftest+bounces-19573-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 388E299AF16
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 01:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CE37B21197
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 23:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103CC1E7C2A;
	Fri, 11 Oct 2024 23:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lt+L3dSC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B911E7674;
	Fri, 11 Oct 2024 23:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728688238; cv=none; b=XVs20Io95fZLhu4RSXz6PoQ/8Y+RDbNrRjJE3K9T6tkIsNSnEEHtrRzgZcMoT+1JSWfVH+6nHuS4LLJpMYAh6HVo3XtWiGxeDuv/u0Vj4JIbrR2zO/wf4rzUM4pxyq/oyUHl/AS6GhEuHmXUx1qi1FbHPSnmKWpts1Vp1F3VCSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728688238; c=relaxed/simple;
	bh=20V2Qty1uA3KvbcnmtuXwnwBbIVYMmTL118AJBKq3Qs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gOQaaG8dE4cZ2OJgwBKkzgepXAx8Rq3t9BhwXzSSIiHIRh5k+uQrk7uTZbX6v6dxpE/dErhhT06LzcmLABFLsf6kzatSCHJbwPeL1Qk8sd/nCkjlh0V375rlEi8U968jLxXyC9yESi6OO3FVCcbath+wERVdTIfO1WkbUU4MgMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lt+L3dSC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643CBC4AF0E;
	Fri, 11 Oct 2024 23:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728688237;
	bh=20V2Qty1uA3KvbcnmtuXwnwBbIVYMmTL118AJBKq3Qs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lt+L3dSCDF9z6NLJUiA1p7u+sWLkmZb3AX6F5GwO4rpkvX/QtTRBV/JAOWDvtlGc+
	 AJLowA6XZ5GAtFxSeBKwOTlNnQf0/MVKZHFPtVU92Ezr0y3G340VXe+wh6DhmXN6fc
	 Ftonn/HkJJWb1h2PJKEZhot+OVXMVFnDNhXNX014Y1O/t9YONL4zFEmCebmggIYfNL
	 N46d8aLTuH1RAq64Wxobq9tW6hw01G6M15qfdtDrn8c8M33CYCXzvkYpoBfj3qMPUX
	 HzRvKndWbDSM1X+SieEu6JpdoxX5Pcw216IS7NcwGoLB5hfdwXsX0IoMbUvCcH5Bli
	 qxK9yida2LB8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34F0938363CB;
	Fri, 11 Oct 2024 23:10:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] selftests: net/rds: add module not found
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172868824202.3022673.8108332355608504547.git-patchwork-notify@kernel.org>
Date: Fri, 11 Oct 2024 23:10:42 +0000
References: <20241010194421.48198-1-alessandro.zanni87@gmail.com>
In-Reply-To: <20241010194421.48198-1-alessandro.zanni87@gmail.com>
To: Alessandro Zanni <alessandro.zanni87@gmail.com>
Cc: allison.henderson@oracle.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 anupnewsmail@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Oct 2024 21:44:17 +0200 you wrote:
> This fix solves this error, when calling kselftest with targets "net/rds":
> 
> The error was found by running tests manually with the command:
> make kselftest TARGETS="net/rds"
> 
> The patch also specifies to import ip() function from the utils module.
> 
> [...]

Here is the summary with links:
  - [v2] selftests: net/rds: add module not found
    https://git.kernel.org/netdev/net/c/6ea8a1c28fd3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



