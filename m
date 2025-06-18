Return-Path: <linux-kselftest+bounces-35247-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F856ADE0C3
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 03:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 910C917BCBD
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 01:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99991A9B3D;
	Wed, 18 Jun 2025 01:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1L3nMpP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987611A76DA;
	Wed, 18 Jun 2025 01:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750210845; cv=none; b=eJDCImzaY+1cT87Wpr+0dhJnQXTFirIb5w2l0Ci/sDVcHaoxEH38xXOrbmQC+HIhULQNIKVnUxVBDriE0bjybyQAMp17K9+pFHtqDSWx9vTNB1kjw3D6/jeliQRosVL85vsimjM17V/caLrLkK9yB7X+rxKjR+zAtGyJdnuwwGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750210845; c=relaxed/simple;
	bh=CPDNdYSNL6xVNSl76c7r/hPSIQ5IB5Yq4jCfuT2xYgk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S8na8tAro3+dsPvckOB49WKkHF821C0p6skrxjAufnwFsT/VXNpKR91XDdZTQMNwNBd1Ud9qVFFL5nxIzuZ/L8KvF8EAjLMaVBPfVu0A6LZxCry0k6LdtfeD0Rf7DuCHBabYNCZIcdQLsIKUytfFzH9cV4k3axL1Tz4B9G0DSy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1L3nMpP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76741C4CEE7;
	Wed, 18 Jun 2025 01:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750210845;
	bh=CPDNdYSNL6xVNSl76c7r/hPSIQ5IB5Yq4jCfuT2xYgk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h1L3nMpPhuRC2UGUtItuZYwnT3ikdBj1OHsIzrxq2nlqRcqUiihgCkxg6q+jPfeiA
	 BOBujCzAOdG8e0nbR5vpPcV4XfhBjZA7cKajGlywl4j39yIWhJjJvzjlV2UGbJf62L
	 7tW2BwE88mReVqUYqdictoH0PanzJlrITykHpU45obXjFGjzAhQr97nADE/jIk/SYs
	 rXmAfW9A41qFFmW+S0QGy2oWDzm7RZDCwONoxVJw9cxWm3uk4Two0/w9yG9racllpG
	 y57GzzN04QARqMASKNWN1AOsaRur1thZGPmEph8V/QfGX2ERyBXPEpeN2T6zrK80yA
	 oD3yDFZglgmvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B6239FEB6F;
	Wed, 18 Jun 2025 01:41:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 1/3] netmem: fix netmem comments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175021087398.3761578.7087583906945747084.git-patchwork-notify@kernel.org>
Date: Wed, 18 Jun 2025 01:41:13 +0000
References: <20250615203511.591438-1-almasrymina@google.com>
In-Reply-To: <20250615203511.591438-1-almasrymina@google.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 shuah@kernel.org, sdf@fomichev.me, jdamato@fastly.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 15 Jun 2025 20:35:09 +0000 you wrote:
> Trivial fix to a couple of outdated netmem comments. No code changes,
> just more accurately describing current code.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] netmem: fix netmem comments
    https://git.kernel.org/netdev/net-next/c/0f66b616b87c
  - [net-next,v2,2/3] selftests: devmem: remove unused variable
    https://git.kernel.org/netdev/net-next/c/46cbaef5d816
  - [net-next,v2,3/3] selftests: devmem: add ipv4 support to chunks test
    https://git.kernel.org/netdev/net-next/c/fb7612b6c44b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



