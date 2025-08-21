Return-Path: <linux-kselftest+bounces-39516-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A99B2FDBC
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 17:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1F1C1C26CA2
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 15:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EA92F6188;
	Thu, 21 Aug 2025 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKwM0cHd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4FB2E719C;
	Thu, 21 Aug 2025 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755788405; cv=none; b=km2E4wgvxRuJ4olEd7Z8MHP0Y/XJ+XIeKOLi0y15BYnC5Vy2mI5NADgDwh+8sdyop/4rXN8EUJQr9cT3fGGL2bh3Vjr0NeQH+ijgurtz8I9Qp5p4dDSW702o0tsbRNg4QfbzjCCKb0vhNpnEqLkSMPrtsKUcPaSKl0xlfvuQkHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755788405; c=relaxed/simple;
	bh=VEtsEWyLke6pHvxuCSoaRicQZP8ik1aQraZxnD6VNOI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gHxGz0vBVTvHatyHhUezvR1b1+GGBm9y7Z6gq10z+zZXUPqX8i/yhG9ZAZ8m0i+VYQ1W7iysZzqZw9FB7y4vQlkAsnBobycFZTMcU39wwhZUDhM2hiCq3u+iM6X/Xdi2OPeGn0y9nRIfCyFOjp/ggy6mpPayEPaAO2PnKqBKgUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKwM0cHd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B48C4CEEB;
	Thu, 21 Aug 2025 15:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755788405;
	bh=VEtsEWyLke6pHvxuCSoaRicQZP8ik1aQraZxnD6VNOI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dKwM0cHdxy60EC5yxNY6NLZ/OwpaiUNOXu+J2AjIGQh0JbUj8N4N7r1L/8L6UgBjG
	 dyOjMXvGEGMBQDmzr5uqGbQDLZTe3DRE3qkayuN2HhF+8IUGtcqJr1wFiunEaopKHr
	 QVT3QdHxxPBDdlakRoTT4oFnlqFjw05OMQR+EQClNxgJhXpialCU0hEylRM7RVBCdI
	 Uxj96v0U+e5f6UtsjShni51tqRJQkWOJNaOLUAmhunqc4Xb7kHhnFoCx4OLS+tZsXF
	 9J7WSX8xHDM3uLlLaiVJv77dE0tw29xXwTKvbShg8/lnwa2tv1eb9SHsah4gd9W4Au
	 anR5XsNsAudCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDF7383BF5D;
	Thu, 21 Aug 2025 15:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] tls: fix handling of zero-length records on the
 rx_list
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175578841229.1075387.17185721811161977550.git-patchwork-notify@kernel.org>
Date: Thu, 21 Aug 2025 15:00:12 +0000
References: <20250820021952.143068-1-kuba@kernel.org>
In-Reply-To: <20250820021952.143068-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 sd@queasysnail.net, borisp@nvidia.com, john.fastabend@gmail.com,
 linux-kselftest@vger.kernel.org, ramdhan@starlabs.sg, billy@starlabs.sg

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 19 Aug 2025 19:19:51 -0700 you wrote:
> Each recvmsg() call must process either
>  - only contiguous DATA records (any number of them)
>  - one non-DATA record
> 
> If the next record has different type than what has already been
> processed we break out of the main processing loop. If the record
> has already been decrypted (which may be the case for TLS 1.3 where
> we don't know type until decryption) we queue the pending record
> to the rx_list. Next recvmsg() will pick it up from there.
> 
> [...]

Here is the summary with links:
  - [net,1/2] tls: fix handling of zero-length records on the rx_list
    https://git.kernel.org/netdev/net/c/62708b9452f8
  - [net,2/2] selftests: tls: add tests for zero-length records
    https://git.kernel.org/netdev/net/c/a61a3e961baf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



