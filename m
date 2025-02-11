Return-Path: <linux-kselftest+bounces-26347-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 383F9A308CE
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 11:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69912188214E
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 10:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC32A1F755B;
	Tue, 11 Feb 2025 10:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxiXpffB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C2B1F63C1;
	Tue, 11 Feb 2025 10:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739270403; cv=none; b=AxHGnHj8hiSS0h+A4tqghESCjZ4uXOvVxEnQC897pRgSWueYoBW5G2czyqa0C50dvXtYoerSe8mu79l8L8fEa9+kwoW9wANE7KNFGEAHHvCB88sc3MpqwloQ5Kd809Z6rPXp1qLQmdZwUlfEgUaJas0UBtrLou4MYwKqNJzC/4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739270403; c=relaxed/simple;
	bh=Ff1zBfZ0pU7L0UpOaVD2ThNBD30ptoW2WgDq0VC1KV8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WtKy0GBsBlZgYSvhXmz+sB5UMD2Kn+vid74zqks8JVuh4qDE2GPuitrMTsl8uqwLiMDmlD2WgzqFKS1OaGsAuAEBFxZB9HH2Dn3o64SFUWQRoOlZ2J1ybjmx3UoAWiMe+WsX8tZ6b1tuocbytppEmKPNOadoL+8+y2Va4Hy7s3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxiXpffB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BFE0C4CEDD;
	Tue, 11 Feb 2025 10:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739270403;
	bh=Ff1zBfZ0pU7L0UpOaVD2ThNBD30ptoW2WgDq0VC1KV8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MxiXpffBe36XUIgsy+tYMNzVGUE706vGJfxU0b9kGqHIiS9o7W2UADTN6zmhsOz+o
	 hQ7TtGOIlq6g35sCs/1HrCYI4S5hhsqfv56+8PrtQpmY0LmNjisn61JIQngdCRzURx
	 NsWKoqwGx6t8jXc4vVvVR0Y48OuPZBqIZJ4rbPXGieIr2CCnBJNI6vDbueiWHcoZu5
	 qkyITk1c2T8nOjEGac/CNj3806tUVPY83i1GdlwH1tEnBWFi0J4k1MLXkfi5Wl4l01
	 JrtXejrpy8qW0BLLRraL6sXfy26hZlFPWh3n6yLlx4TxDhWaWvJY0f8SuEhPIwSKZb
	 oB53dKhrYff+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB439380AA7A;
	Tue, 11 Feb 2025 10:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next,
 v8 1/2] netlink: support dumping IPv4 multicast addresses
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173927043179.4019065.9891478772940585487.git-patchwork-notify@kernel.org>
Date: Tue, 11 Feb 2025 10:40:31 +0000
References: <20250207110836.2407224-1-yuyanghuang@google.com>
In-Reply-To: <20250207110836.2407224-1-yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 netdev@vger.kernel.org, donald.hunter@gmail.com, shuah@kernel.org,
 razor@blackwall.org, liuhangbin@gmail.com, daniel@iogearbox.net,
 petrm@nvidia.com, linux-kselftest@vger.kernel.org, maze@google.com,
 lorenzo@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  7 Feb 2025 20:08:35 +0900 you wrote:
> Extended RTM_GETMULTICAST to support dumping joined IPv4 multicast
> addresses, in addition to the existing IPv6 functionality. This allows
> userspace applications to retrieve both IPv4 and IPv6 multicast
> addresses through similar netlink command and then monitor future
> changes by registering to RTNLGRP_IPV4_MCADDR and RTNLGRP_IPV6_MCADDR.
> 
> Cc: Maciej Żenczykowski <maze@google.com>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v8,1/2] netlink: support dumping IPv4 multicast addresses
    https://git.kernel.org/netdev/net-next/c/eb4e17a1d915
  - [net-next,v8,2/2] selftests/net: Add selftest for IPv4 RTM_GETMULTICAST support
    https://git.kernel.org/netdev/net-next/c/4f280376e531

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



