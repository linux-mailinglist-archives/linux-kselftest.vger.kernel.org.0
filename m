Return-Path: <linux-kselftest+bounces-10285-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2E98C732F
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 10:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A3A32826F7
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 08:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378AD142E8A;
	Thu, 16 May 2024 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agqJcXh7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F169142912;
	Thu, 16 May 2024 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715849430; cv=none; b=hM3VddFtRFkhzWP1oPCEmZzBT4UD2s0S4fGbyXiQTyJTHw90ZFPf1M7RmcYNIxM5iw8Ng5hADMd6QwKhw72+mXk/cjzrWE9m3sOX0MIuQkUAJfYZnYBhmp0sUsulyQexyux7YNg+Th0CqokwJBnAtyPyqC4OUtaSkP9yGC0PWiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715849430; c=relaxed/simple;
	bh=rnCoh93EUQthmvVxvZngyEUgDC/OhUZEWsUgwdQcNRk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VCSWetberUx6TXFiKeDSN/iUAtl/TLYgxsruScKsm+1dY/AfdDo/2cJ+/sWQUqDSdP96HqlgQkdmErO/dhTjxm0eubyOZUwb/uXaCnttpRnXcGPMV6a9M79jDZTeu5g496zjA9sADcw64BOY4R57FYuMqK3FF5yZFj1GZrYVk4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agqJcXh7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC930C4AF07;
	Thu, 16 May 2024 08:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715849429;
	bh=rnCoh93EUQthmvVxvZngyEUgDC/OhUZEWsUgwdQcNRk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=agqJcXh7E+bg5cFBtfsRP0utcLfOB6JwSedGz4O6VzDImyej0oKo426YzuPOSEPm+
	 OrGPltK6zHUz7wRcXmvKok8Ex8IdXWWsSt/wvgwbaVVMEYLn53pgRMTcd1bmQnPoYJ
	 UYS1KkoCLKtARgEb3LsCY4vyh3en9f7L5xvC4PPU17vxQ2SD6GUqaruUefJ0NdvK1D
	 MqHWce0id3odWqFnXZ68ylawSDoFzIG5rEJRcnJmbPzzNKKssP358ynrPK2qJMHRMY
	 uBAvwtxsyIP1XJ5mJPPKfyBMi3WnS5JgS0ErNl8CpTplXX0HQAMGK7gkWd2+orOJ0m
	 k/nJfrWXRoGRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C886C54BDC;
	Thu, 16 May 2024 08:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests/net/lib: no need to record ns name if it
 already exist
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171584942963.27746.3846748759530805820.git-patchwork-notify@kernel.org>
Date: Thu, 16 May 2024 08:50:29 +0000
References: <20240514023400.1293236-1-liuhangbin@gmail.com>
In-Reply-To: <20240514023400.1293236-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, petrm@nvidia.com,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 14 May 2024 10:33:59 +0800 you wrote:
> There is no need to add the name to ns_list again if the netns already
> recoreded.
> 
> Fixes: 25ae948b4478 ("selftests/net: add lib.sh")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  tools/testing/selftests/net/lib.sh | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net] selftests/net/lib: no need to record ns name if it already exist
    https://git.kernel.org/netdev/net/c/83e93942796d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



