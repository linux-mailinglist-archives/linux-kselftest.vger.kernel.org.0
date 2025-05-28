Return-Path: <linux-kselftest+bounces-33913-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAF7AC5F97
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 04:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2708C4C304D
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 02:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B641E377F;
	Wed, 28 May 2025 02:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hR9nGtMS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBD51C5D4B;
	Wed, 28 May 2025 02:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748399418; cv=none; b=L3immMBKuBmTj7RxzVkoOMH924MJM/A82WarLA8GS/Ct/X4YDA65t3kbjENHdfDc4WdiY9MJzDDb15Xih9uEtp0y+ZYOzImzuobtN1M/CwNkF4oke4xrKokhgOR4u5+mfrufu8Dz6YR1dRr1pdzXDWKVt6iS6r3VIugskTVwN2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748399418; c=relaxed/simple;
	bh=BWCthmiI/S2MepvgN2bdm2wAp5bX/8wGlKNy+opLH+U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iPmwk9z6y6KbYHSZjZolqF4/VUWBgSEn6U6p4shKmLosSaBqKi6CYq+9G7tTysU9kylBcXgIv/w3lSZPCEfdbwSy9D6CnqJr59IrlL/9VRngxrr+hJAYarhg95CniAgyxt4Xg+li9EaUqGoyWGNl5TKo2o3vruChOKBl7YSidSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hR9nGtMS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63605C4CEE9;
	Wed, 28 May 2025 02:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748399417;
	bh=BWCthmiI/S2MepvgN2bdm2wAp5bX/8wGlKNy+opLH+U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hR9nGtMSbjWhXxGLl5Kab7PjG50Wkd8+gcZLY1aGEA66MWPgVyxSb7njj9WWn2PDw
	 XUaeGN1ZQHRibQum7KJR0A4FVXW23bA6c+VPDaFyuLJw+vK7OQ3rbwyS992ULTthbC
	 jXkAH5niCg09K/FKTYoJC0OVtrKUQaQWeXl9sqJKQgiiCMqmM4uYYcChRyeqJVudV7
	 UqWKo04HJLnJ/6X0ePU6HilOnSdChZX3mwTqtlkpC08+k573trmVeJA5DlHMHpoZRh
	 38d7ENzOgJeOo3uMlRXhPEJx0t3B6l/FfqGqaOTpTpNCaXm42BY0KIdQ1mzwmy0WOw
	 kfA8Y4IoSNr5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDC23822D1A;
	Wed, 28 May 2025 02:30:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/8] Devmem TCP minor cleanups and ksft
 improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174839945148.1866481.123828149281878670.git-patchwork-notify@kernel.org>
Date: Wed, 28 May 2025 02:30:51 +0000
References: <20250523230524.1107879-1-almasrymina@google.com>
In-Reply-To: <20250523230524.1107879-1-almasrymina@google.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, hawk@kernel.org,
 ilias.apalodimas@linaro.org, ncardwell@google.com, kuniyu@amazon.com,
 dsahern@kernel.org, andrew+netdev@lunn.ch, shuah@kernel.org, sdf@fomichev.me,
 ap420073@gmail.com, praan@google.com, shivajikant@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 May 2025 23:05:16 +0000 you wrote:
> v2: https://lore.kernel.org/netdev/20250519023517.4062941-1-almasrymina@google.com/
> 
> Changelog:
> - Collect acks and tested-bys (Thanks!)
> - Drop the patch that removed ksft_disruptive. That seems to not have
>   any relation to behavior when test fails.
> - Address comments.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/8] net: devmem: move list_add to net_devmem_bind_dmabuf.
    https://git.kernel.org/netdev/net-next/c/88e47c93b3a2
  - [net-next,v2,2/8] page_pool: fix ugly page_pool formatting
    https://git.kernel.org/netdev/net-next/c/170ebc60b79a
  - [net-next,v2,3/8] net: devmem: preserve sockc_err
    https://git.kernel.org/netdev/net-next/c/85cea17d15c9
  - [net-next,v2,4/8] net: devmem: ksft: add ipv4 support
    https://git.kernel.org/netdev/net-next/c/12d31142e63a
  - [net-next,v2,5/8] net: devmem: ksft: add exit_wait to make rx test pass
    https://git.kernel.org/netdev/net-next/c/57605ae8e1b6
  - [net-next,v2,6/8] net: devmem: ksft: add 5 tuple FS support
    https://git.kernel.org/netdev/net-next/c/243d47a5e1e4
  - [net-next,v2,7/8] net: devmem: ksft: upgrade rx test to send 1K data
    https://git.kernel.org/netdev/net-next/c/baa18bc5353f
  - [net-next,v2,8/8] net: devmem: ncdevmem: remove unused variable
    https://git.kernel.org/netdev/net-next/c/affffcbb8726

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



