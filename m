Return-Path: <linux-kselftest+bounces-10160-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 610088C4905
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 23:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F361E1F22655
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 21:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9061D84A2F;
	Mon, 13 May 2024 21:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBZclq8V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598EA83CD7;
	Mon, 13 May 2024 21:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715637031; cv=none; b=bRcRKTPlXaOwuaV19HYQRnBObeJLYamZqsqKbdii4pFL+D3HItzxVCONMKpT1wbtGxjD2jidg12fVZUWgjuE+njrAkDKUjS7v0PNEjLiPbbjRg8FiHVBfc7/m7pt+fZJe6KZRef/67c8eGMSxVXAp2prTHOzLKaCY3+8uonvILc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715637031; c=relaxed/simple;
	bh=hI+GX/zFN5C3JSm074gb0Fm3v0+UFXHKI7nwlokL8rc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DZ1LHnlcj8ot1S4mW4EM8oprNAdHheKzVrovSSzOzlYFQRJYKJbLBnQswru/Zb9v4Lwuv3kadFWz2lYWtqgPbLnDDe7odL4+KZSL7WnucoRGgkUm7ygaav+yOOOZt0zd5/ZOiq/ep/gkZB9lsSk3GpPM6xtyhUI7wAGGek3WleE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBZclq8V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB097C2BD11;
	Mon, 13 May 2024 21:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715637030;
	bh=hI+GX/zFN5C3JSm074gb0Fm3v0+UFXHKI7nwlokL8rc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QBZclq8VcGdRRHEPMuQB8mGeh6ODwpeTVkKhPexqYb2fsXR7kQpVzmn1mi8wIP76d
	 ZgzqZGQu5VvrVU8/8LNjQDpNhyUu27IBqh0nqsPeEiVBfoeJS1uIWkzyzttFg48TGz
	 00g9a7Q21IU3QjQo3CVxxDM17760tEADQbURBL2SFrLQEjNmgUzS9UbV4So/AQYhax
	 FX7Mpg/JYe9HXgc5cBfSf44dzS34kxHXlNCNTqGC1R2Vuw0QsN4ZITbydlFIqtcnCE
	 OCKEPq/HlsMvfCPeHMo2vGKhTs2CEa25B5z5wzc2OwhPKgL45Yti1pB1okBmuM9Rzn
	 HPeyotlpwvYig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A966FC433E9;
	Mon, 13 May 2024 21:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v10 0/3] net: gro: remove network_header use,
 move p->{flush/flush_id} calculations to L4
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171563703068.25518.8674170823657898620.git-patchwork-notify@kernel.org>
Date: Mon, 13 May 2024 21:50:30 +0000
References: <20240509190819.2985-1-richardbgobert@gmail.com>
In-Reply-To: <20240509190819.2985-1-richardbgobert@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, willemdebruijn.kernel@gmail.com, dsahern@kernel.org,
 alexander.duyck@gmail.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 May 2024 21:08:16 +0200 you wrote:
> The cb fields network_offset and inner_network_offset are used instead of
> skb->network_header throughout GRO.
> 
> These fields are then leveraged in the next commit to remove flush_id state
> from napi_gro_cb, and stateful code in {ipv6,inet}_gro_receive which may be
> unnecessarily complicated due to encapsulation support in GRO. These fields
> are checked in L4 instead.
> 
> [...]

Here is the summary with links:
  - [net-next,v10,1/3] net: gro: use cb instead of skb->network_header
    https://git.kernel.org/netdev/net-next/c/186b1ea73ad8
  - [net-next,v10,2/3] net: gro: move L3 flush checks to tcp_gro_receive and udp_gro_receive_segment
    https://git.kernel.org/netdev/net-next/c/4b0ebbca3e16
  - [net-next,v10,3/3] selftests/net: add flush id selftests
    https://git.kernel.org/netdev/net-next/c/bc21faefbe58

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



