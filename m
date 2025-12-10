Return-Path: <linux-kselftest+bounces-47365-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9ADCB28C3
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 10:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 156CF3158F1F
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 09:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA7B314B6D;
	Wed, 10 Dec 2025 09:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IiLX5FwA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6C7314A62;
	Wed, 10 Dec 2025 09:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765358603; cv=none; b=qd+0zW6kEwEyj++CFr3toqGAzwtUf17bxOxyO4OITYp0uFkEfx24yIcnBeW9vLCHyzbeII0cXR1KbSc/L/xruRPxP/mvh8oyWMByO9YH9Ok9FkqOZo9wPp+/1ZVfQ408UtJWaL1Enepi+R2vmkICTGoBKm5LKywyNGCbv8QAv1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765358603; c=relaxed/simple;
	bh=AnmOm/BEDS2iivTNjVgQh9F4qy4ZIOS+wOCvnIHvGfs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Vm4dL41SALEtiL05T/d80Dn3Kdw0hSrJtlGk25s9oFDdf+qYWPHcgBSdMdteIFcyB6iGaodp+OGrnV6lPli8c3vVWMEfZ6Bnbw04JE7j9tbFRYQmHr75qxnvO3U0u9LqBymSSPVbrUkNT7eAXftd9je8XmkkoZm19omeWHeVpGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IiLX5FwA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89705C4CEF1;
	Wed, 10 Dec 2025 09:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765358603;
	bh=AnmOm/BEDS2iivTNjVgQh9F4qy4ZIOS+wOCvnIHvGfs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IiLX5FwABfsYDL5fy6YEQaZNvqG2Wpo5Lz1mCcZ3rrywL5Flyo74qR6TGr7phaP+K
	 YwAHLewWa+PfngQ/YbppE5zw6t/1mzuQ31bh2XIZSL+prrB8FKjlDNOm4xKmKoe8Xz
	 Fcv/psdmihxW7R8vwpNv4kKzu8OKWV+K3LMR/rya6lWdZcLY2JhnW0Pwj5GXO+dZGn
	 TCYT47xQmVgktqmWS4D44CIWu2bFH8FmMI98yFu0+idr3Fdv/Ocrx+mXZ+g7ggTBUF
	 5hJaDe8s5puuo1+0lyd+DCHJt1y5d1trRSTbItsPW3nlSfKEwygtTxlZLiaVV7+P/W
	 iCZevkrRSaDiQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 786AC3809A18;
	Wed, 10 Dec 2025 09:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] selftests: tls: fix warning of uninitialized
 variable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176535841802.523551.13219087665647345862.git-patchwork-notify@kernel.org>
Date: Wed, 10 Dec 2025 09:20:18 +0000
References: <20251205163242.14615-1-ankitkhushwaha.linux@gmail.com>
In-Reply-To: <20251205163242.14615-1-ankitkhushwaha.linux@gmail.com>
To: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, sd@queasysnail.net, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  5 Dec 2025 22:02:42 +0530 you wrote:
> In 'poll_partial_rec_async' a uninitialized char variable 'token' with
> is used for write/read instruction to synchronize between threads
> via a pipe.
> 
> tls.c:2833:26: warning: variable 'token' is uninitialized
>       		   when passed as a const pointer argument
> 
> [...]

Here is the summary with links:
  - [net-next,v2] selftests: tls: fix warning of uninitialized variable
    https://git.kernel.org/netdev/net/c/9580f6d47dd6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



