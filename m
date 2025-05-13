Return-Path: <linux-kselftest+bounces-32890-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA354AB48BF
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 03:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63F591B41B4B
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 01:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485151990D9;
	Tue, 13 May 2025 01:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rzh5l60g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D5B198E77;
	Tue, 13 May 2025 01:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747099206; cv=none; b=iJaq3+d5eDkwi6IqLvUl2W9M37bHAVWtHy+tM0/kE9kdrLZ0AujhcYJCnQbPCkeJoMfPJJ3AygLNqIh2sfyQZmmoPFsPNX95C53GxeggkTLobghF/DfruRit/dcZOyAEoxx83kKJiyH8LpLcKOakbJCChRz90/hGm6TqE/n+sm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747099206; c=relaxed/simple;
	bh=FC8z1wi1K6dK2m+JyJM5vOOZeOE332L5EbCrdvDc+R4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hEGt0Ocbg7iYpCrdxJPhhMjSbCuudBSrb2CQIv8eu7Exn69Jfnpou/JKhc/IPSl6co0D6Z3N8S1+ukTdEmMDr9u+yf4moN4ZlWmd8qfrr+An0HBWHo7qG8dPEIp50YiMOKIzf4TxJ6y6QPTpgnB2tx4+nPCrAD+ve/50adY+zIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rzh5l60g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8077EC4CEE7;
	Tue, 13 May 2025 01:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747099205;
	bh=FC8z1wi1K6dK2m+JyJM5vOOZeOE332L5EbCrdvDc+R4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Rzh5l60gEACP/jt67kQF1cuMCYYuCzuozE8OkbRYBih9C9G8Sy2Up2CzDAq/6DSSH
	 R+9WM3DT5oYsiv4/Q0Npei9cPzTYNJiXtswfLnmrO64/JhSLgOGzdW48fdDleOc3sM
	 ogdNqL010uZ7Ct7zbQ7G229Guouo6TiWNNXVEJITomJ2mzRf9AwBabMOTYM6PQ16nR
	 fi6zvDGc/AfRMs+bbDHcsn1/6iNVv9BOnhhbLz9JNmqTLZGph8xieTEbnO1aF+mdWt
	 Zyk0w5YnfcDsKdKoo/FHYGOXQcMPpM4PoZHk5sx13232+95L26SV2VQtylKHkbliDf
	 DhXYyUFX4fWyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B5739D60BA;
	Tue, 13 May 2025 01:20:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: drv-net: ping: make sure the ping test
 restores checksum offload
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174709924300.1134434.16948489646200403450.git-patchwork-notify@kernel.org>
Date: Tue, 13 May 2025 01:20:43 +0000
References: <20250508214005.1518013-1-kuba@kernel.org>
In-Reply-To: <20250508214005.1518013-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  8 May 2025 14:40:05 -0700 you wrote:
> The ping test flips checksum offload on and off.
> Make sure the original value is restored if test fails.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: linux-kselftest@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: drv-net: ping: make sure the ping test restores checksum offload
    https://git.kernel.org/netdev/net-next/c/ef5224ed25e0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



