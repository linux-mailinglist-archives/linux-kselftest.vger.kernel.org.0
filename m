Return-Path: <linux-kselftest+bounces-2667-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DEB8257F0
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 17:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F11C1F215B8
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 16:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D68731725;
	Fri,  5 Jan 2024 16:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urC9BfQr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186F22E85B;
	Fri,  5 Jan 2024 16:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9447DC433D9;
	Fri,  5 Jan 2024 16:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704471625;
	bh=yVeKmEcClyi5B8/xFJ+u1/QIebKfkfq7DhyuYiRjrFQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=urC9BfQrFSeJInf4JacBUekwPYgA1d+coWqMWOD46hMO8oiI439sszRZhlG6NuSk8
	 ROHU8i6u6WAEV4Phbk7XYGhjmweEB0lo8yTHBMbAyl1fzSeAVPUKWzKHc3UMIEDRBS
	 497GfZA+acmlYL/nTYO3S/SWnl++eTU85GRdSPm6yJ29e9SU+5oBMZwiqugn5Npe/9
	 Nsnh2xxAJbmbBmDDP8MlbU4T2FUUU4Ss+6a5a9R4HeVx2CUUC02BHIoiN4GlP0/edt
	 yPNtEtagKys3+PDWd6Bynq9qfli1MOinGJLincUh3DCdRU9g1m0NSjzLjN2mVk4r2t
	 jfyyg73sg5T7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7F325DCB6D8;
	Fri,  5 Jan 2024 16:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/3] net: gro: reduce extension header parsing
 overhead
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170447162551.14252.7658609133386405696.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jan 2024 16:20:25 +0000
References: <ac6fb684-c00e-449c-92c3-99358a927ade@gmail.com>
In-Reply-To: <ac6fb684-c00e-449c-92c3-99358a927ade@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 3 Jan 2024 15:36:41 +0100 you wrote:
> This series attempts to reduce the parsing overhead of IPv6 extension
> headers in GRO and GSO, by removing extension header specific code and
> enabling the frag0 fast path.
> 
> The following changes were made:
>  - Removed some unnecessary HBH conditionals by adding HBH offload
>    to inet6_offloads
>  - Added a utility function to support frag0 fast path in ipv6_gro_receive
>  - Added selftests for IPv6 packets with extension headers in GRO
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] net: gso: add HBH extension header offload support
    https://git.kernel.org/netdev/net-next/c/f2e3fc2158e6
  - [net-next,v3,2/3] net: gro: parse ipv6 ext headers without frag0 invalidation
    https://git.kernel.org/netdev/net-next/c/dff0b0161ad5
  - [net-next,v3,3/3] selftests/net: fix GRO coalesce test and add ext header coalesce tests
    https://git.kernel.org/netdev/net-next/c/4e321d590cec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



