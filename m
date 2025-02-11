Return-Path: <linux-kselftest+bounces-26325-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 547BAA3022E
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 04:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CA173A99D9
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 03:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A73F1D86ED;
	Tue, 11 Feb 2025 03:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqwZxyuy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324551D54CF;
	Tue, 11 Feb 2025 03:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739244616; cv=none; b=XcXZsh/f9Pxp1fsiw9LS4dX3pkVObqVWnitQ3kUswYQIfH9dL+8TFG1p3rFFx5AvDnnm1ltPfv0zjTomvx/yTiOgE5NREQGZDj872eWKWstlSEV690DKB0zmyRYTt2lht7+9chSd0ruzUgr8YMXs8jCzla4aICNqRJq7svjtacI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739244616; c=relaxed/simple;
	bh=oJmFKDd4bcjFgOAT4TRWHq9US7yqqmSZWG+T5dzXL+k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QwSrC9XDV+biT+0+BSJ3Vk/qeZSZ11sf6SOX+e+igYaFZDjFGayVz4ZqpWf4VJQ/HTIe8CaQQE3qR+s3OsV4sxpC5zYSHgV1ifvaF8KUJxMpLVBAePPIjlAdTmiXeePM6Q8ELP2/Nc2IgOFu5KqtUPfZ3IG1ZMU62vom2O7MyJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqwZxyuy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD9DC4CEDF;
	Tue, 11 Feb 2025 03:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739244616;
	bh=oJmFKDd4bcjFgOAT4TRWHq9US7yqqmSZWG+T5dzXL+k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qqwZxyuyAb7K/00T0UvHLnOPRfzJiWwjEji9DW2zbJ3YSSGl+4MXjupJorf78CWlZ
	 8xNNokPG00SjkRlddbzK+n0vYL6YWX1xo0LwDlVSEtmtCn6jE5EYuvUq/CK6ti19+J
	 bTxcWvN3du+C1qzc0dwRHyvfq6ap4MbO+Hx8FD05V1Q2dRT3TmH7n9v3Z2cpVPe8se
	 Tt+C/VpLaVj3TPmQ/p0RTYpzGCo7lifquyvMnEwVYHgqyi2CfLJqsIJHruw/AWUoXk
	 4yfAkIRTnVmLgEHYzcgDrLHmcXCXqraVUzapIlCnsEZAqXAnUcxRgVdi46fjCyP3L+
	 qtPY3AalOzHNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF63380AA7A;
	Tue, 11 Feb 2025 03:30:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] selftests: drv-net: factor out a DrvEnv base
 class
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173924464474.3948401.15014700951334326245.git-patchwork-notify@kernel.org>
Date: Tue, 11 Feb 2025 03:30:44 +0000
References: <20250207184140.1730466-1-kuba@kernel.org>
In-Reply-To: <20250207184140.1730466-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 willemb@google.com, petrm@nvidia.com, sdf@fomichev.me,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  7 Feb 2025 10:41:39 -0800 you wrote:
> We have separate Env classes for local tests and tests with a remote
> endpoint. Make it easier to share the code by creating a base class.
> Make env loading a method of this class.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../selftests/drivers/net/lib/py/env.py       | 59 +++++++++++--------
>  1 file changed, 33 insertions(+), 26 deletions(-)

Here is the summary with links:
  - [net-next,1/2] selftests: drv-net: factor out a DrvEnv base class
    https://git.kernel.org/netdev/net-next/c/29604bc2aaed
  - [net-next,2/2] selftests: drv-net: add helper for path resolution
    https://git.kernel.org/netdev/net-next/c/3337064f4204

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



