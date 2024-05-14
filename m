Return-Path: <linux-kselftest+bounces-10189-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA76D8C5ABC
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 20:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68D6B2827E1
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 18:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61451802C1;
	Tue, 14 May 2024 18:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6rsfQLa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F831802B2;
	Tue, 14 May 2024 18:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715709636; cv=none; b=kAYZxzceAO8vo6zF40QXa/VP3ESVsXBiCEnM04gncUe6wHFxpvh2nTylsfDOMkktUEOudF6p6JskrpyX5819jqZcCWbDnVIvSnsefdI1tuxXb1JN4DeCSfJI1dU02di3cudcrpix4u/vJPu02kv8cnZe03QYIfwNc0yra7odBXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715709636; c=relaxed/simple;
	bh=VQIiP/ULV3ej9x8OPdwxC7vHy/YqFVmnai8YLVfl3uk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iZGk7q7g/dMT+6bvXoJkqPkjXfQfWaBnzDwfJdHOMZ2erQ+LQRBlMqOVVUrAw1M5HoVGZnT1wztT8yCtIIxchRdKAeZannGNdS+Wp4TPvPPxzTgw6jUQSr3P3r8HGAlJjMbryS7WSAMGUKdzkqX1YACXY402kO0QyJbY9el37pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6rsfQLa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5009EC32782;
	Tue, 14 May 2024 18:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715709636;
	bh=VQIiP/ULV3ej9x8OPdwxC7vHy/YqFVmnai8YLVfl3uk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J6rsfQLa9j1B7DjGqy7DRYhyN+zHUK1oczc30GkzdJI2flUqYIf/TkNht6KgLZCHR
	 kmf1lGswDsa5mmENJdAmsDuLble3tyQNdoHO0ZNXzTfYG1T7T3OZDBGeVUNlMcnhep
	 0bE1J0Gf/fYCdYgayHXn4E4bbm5FdGz36rHNj+9AgxLcg9s9EvUiuIKpUJnmeXuK1r
	 FOnBiBMaYsVhUWvL0mshiMTHlvz5STOY8pu2Qd7pHOIE9cWw6bA5/rtoZJjnsfkVIV
	 YEN8CmV/jt7OW85VOs4tIQALAp/gtz6GXuiChOP6FF9oH9EIBwN3Rs3apxibTVaYIo
	 JqbIOlecojepw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3F2FBC3274D;
	Tue, 14 May 2024 18:00:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: gro: fix napi_gro_cb zeroed alignment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171570963625.9672.5064644858637576524.git-patchwork-notify@kernel.org>
Date: Tue, 14 May 2024 18:00:36 +0000
References: <fca08735-c245-49e5-af72-82900634f144@gmail.com>
In-Reply-To: <fca08735-c245-49e5-af72-82900634f144@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>
Cc: kuba@kernel.org, geert@linux-m68k.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, willemdebruijn.kernel@gmail.com,
 dsahern@kernel.org, alexander.duyck@gmail.com, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 May 2024 19:06:15 +0200 you wrote:
> Add 2 byte padding to napi_gro_cb struct to ensure zeroed member is
> aligned after flush_id member was removed in the original commit.
> 
> Fixes: 4b0ebbca3e16 ("net: gro: move L3 flush checks to tcp_gro_receive and udp_gro_receive_segment")
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> 
> [...]

Here is the summary with links:
  - net: gro: fix napi_gro_cb zeroed alignment
    https://git.kernel.org/netdev/net-next/c/386f0cffae46

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



