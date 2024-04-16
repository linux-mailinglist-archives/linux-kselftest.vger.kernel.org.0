Return-Path: <linux-kselftest+bounces-8130-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D537F8A69C6
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 13:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F8CA1F21784
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 11:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C99129E70;
	Tue, 16 Apr 2024 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Px1vSt9E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ADD129A66;
	Tue, 16 Apr 2024 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713267629; cv=none; b=hF4EXSh+ecuxhjqM3Wvw3PGeA/TtkDRX8uRrdZqZz8qesKf8BXmh7URQGVpPZ6e77ATt0XymmH8FytogAgxCdqqXwh/qO24WLXowfVIby8JqXnL+iKpid2zKEz6UQGg7I/t7wxSApN75Rx2l+HvqmnxDo4dVpm1nezXE/S2/9p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713267629; c=relaxed/simple;
	bh=UdRR0mB2QT3+hsLGPtI/LkIMzDYr8tdeCDqvAmojMSM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TsOOo8XSyXuV0YVu4ZfNuNtFEUA3K2XT6Blj9iCYv/ZR6KuTCZZkHe5oGjxWCB2Bjr3pUsZ2dnH/bAlP+i5FHlkgtrlHv9JqfrNPsShHR+ikii5TOdkTh7qR7Td5gFIvubeCdcVe0R+NxasHVYEVa///AJmo5EIKh2t2WQ8G7W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Px1vSt9E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B2A7C4AF08;
	Tue, 16 Apr 2024 11:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713267629;
	bh=UdRR0mB2QT3+hsLGPtI/LkIMzDYr8tdeCDqvAmojMSM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Px1vSt9EH4OKZzZJpf5JPCvJotPZfQD6zcRdJO+XYSOAxe9pvCK3qFpVYJIwjZHCt
	 61siUijVIFojzZlHupM37D5cfhQklquMrCahdf8DMNUk4jsqvpt5otmsxdlARCaPRW
	 5V60LYgbD5sWJy4V+9lEkPaanxQTZjR7dl/1ejwHnouxBE8U20OgjnY9oYf8EL04RN
	 BXnaE50Y/NW77MC3YCUWDXGJnebOjOqPUjLL0vnS7uf84gL6nJ6WcpM69ax13Gy6CI
	 r3QBY//at+gIyTJubCS/KEYdX3XQLIeiZWrkXCQ15fmgACl1/EA4DFlGvt7l9zPnXr
	 ufBfGU/vkIi3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F3E5DD4F145;
	Tue, 16 Apr 2024 11:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] selftests/net/tcp_ao: A bunch of fixes for TCP-AO
 selftests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171326762899.16449.16473756279480443179.git-patchwork-notify@kernel.org>
Date: Tue, 16 Apr 2024 11:40:28 +0000
References: <20240413-tcp-ao-selftests-fixes-v1-0-f9c41c96949d@gmail.com>
In-Reply-To: <20240413-tcp-ao-selftests-fixes-v1-0-f9c41c96949d@gmail.com>
To: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 0x7f454c46@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 13 Apr 2024 02:42:51 +0100 you wrote:
> Started as addressing the flakiness issues in rst_ipv*, that affect
> netdev dashboard.
> 
> Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
> ---
> Dmitry Safonov (4):
>       selftests/tcp_ao: Make RST tests less flaky
>       selftests/tcp_ao: Zero-init tcp_ao_info_opt
>       selftests/tcp_ao: Fix fscanf() call for format-security
>       selftests/tcp_ao: Printing fixes to confirm with format-security
> 
> [...]

Here is the summary with links:
  - [net,1/4] selftests/tcp_ao: Make RST tests less flaky
    https://git.kernel.org/netdev/net/c/4225dfa4535f
  - [net,2/4] selftests/tcp_ao: Zero-init tcp_ao_info_opt
    https://git.kernel.org/netdev/net/c/b089b3bead53
  - [net,3/4] selftests/tcp_ao: Fix fscanf() call for format-security
    https://git.kernel.org/netdev/net/c/beb78cd1329d
  - [net,4/4] selftests/tcp_ao: Printing fixes to confirm with format-security
    https://git.kernel.org/netdev/net/c/b476c93654d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



