Return-Path: <linux-kselftest+bounces-35363-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F6FAE0778
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 15:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D7BC3A3259
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 13:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3901927147B;
	Thu, 19 Jun 2025 13:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCZmKa5u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1A1271468;
	Thu, 19 Jun 2025 13:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750339788; cv=none; b=VgonP7NcmkWpZpN0aLQnTHGrb9gZwsAgWlEw1sR+0Tl8h6FXLUxNYPtcCtxGWcscE/NFk4keGiyXuW5wGSIrN5TRi8EKSn+2HYCGib8WmXg/CxBtgYeLzkWk+uMxYWsauQe2PU1rWyPHm7HA08AoCa8TwI70Yl2R89eSfifY7Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750339788; c=relaxed/simple;
	bh=ZRIQfL/YN5apetZg38YOcJCe0FJwnPiaAQ0Z5F6t1sY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uC4rdOcZpA2slU85/wck8mWx8fQ+Nsz/QRa8Kp0Oh7DiNuhy7GBBt5p75mXuDoMq8Q7bnzJBedfjyZN2zh63nKQLuQwREGjd6wiwasLKgegHrfuYL0Mb8j5s0LWXZyqXwp+Z6EY5fvW4+vLtjUfnCVnPX/qEZLh6rDT63MoPq9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCZmKa5u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6EB2C4CEEA;
	Thu, 19 Jun 2025 13:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750339787;
	bh=ZRIQfL/YN5apetZg38YOcJCe0FJwnPiaAQ0Z5F6t1sY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YCZmKa5uRgMTygLP9tObQcUeVqL4+JqhiTAYdbw4ll+cPJj1KAlBUbp//J6mdC2QZ
	 noItdVwJ3Mw2/F8d6fbzsNHHy7zLzMcnnIi1jt43qFn1ny2/hhpWPR82mnf6id8WZI
	 Dx+eCcTgNMmLYux0JZHutesUxZs/BZd3OdWcV8fhvgT+qfAed42LlYPM4MEd8ZpPM4
	 TfZm6q1pXDArgjWEZQK8DTKHXCoiuQARJULA0DhhbJPQG7WeA5/CK872vyQRbOxxpo
	 8geClHQk/rUlH6MnMGEtzM++NSr08C91N6a0uDTAdIllTxw9K0Faca1T95XRjQ9z31
	 KrBfkU5054aRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C7B3806649;
	Thu, 19 Jun 2025 13:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] selftests: net: use slowwait to make sure
 setup
 finished
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175033981599.865029.10714129256471908570.git-patchwork-notify@kernel.org>
Date: Thu, 19 Jun 2025 13:30:15 +0000
References: <20250617105101.433718-1-liuhangbin@gmail.com>
In-Reply-To: <20250617105101.433718-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 17 Jun 2025 10:50:58 +0000 you wrote:
> The two updated tests sometimes failed because the network setup hadn't
> completed. Used slowwait to ensure the setup finished and the tests
> always passed. I ran both tests 50 times, and all of them passed.
> 
> Hangbin Liu (2):
>   selftests: net: use slowwait to stabilize vrf_route_leaking test
>   selftests: net: use slowwait to make sure IPv6 setup finished
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] selftests: net: use slowwait to stabilize vrf_route_leaking test
    https://git.kernel.org/netdev/net-next/c/d83a58067592
  - [net-next,2/2] selftests: net: use slowwait to make sure IPv6 setup finished
    https://git.kernel.org/netdev/net-next/c/948670361c0c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



