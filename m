Return-Path: <linux-kselftest+bounces-38815-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A963FB23EB6
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 05:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ACD0583503
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 03:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF0128936F;
	Wed, 13 Aug 2025 03:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTUIlxYu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F775289358;
	Wed, 13 Aug 2025 03:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755054070; cv=none; b=Xpph6Fo98C0eGJgJ2D05pYkq1nHqRrKk8c+0VNvbCw4mP+gGPtmmSy76NcjZwKym/jt6RzVK2eUcqzrhJGIEgkm45gF98DueSjN6geukAIHlSIbdyVuHqEBxO/xa8s3gebn72NDtHz6Ov0guW40HJz7+D41416DPbOg4NNHvRO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755054070; c=relaxed/simple;
	bh=g0KpjcXJtz6ln6aB1UZjeZO3yaHEGjn1lQ/ZaIiksKs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kDsHzzM6bYdPP2upR1Fl/9y+bH9V6G/CVW2d/346chKGOavMyD7mZCU4Rc+Uzj+XiDljOX3+ZrZBaB8R2Y+I29inRhlJ46r62NJjLmjzTwjNeN/l5c9rvPbtx+23KgF0I3hRYYoHmM6MWh+Itcj2uhcUXVf2swKKY8t71XRhZAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTUIlxYu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1856CC4CEF0;
	Wed, 13 Aug 2025 03:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755054070;
	bh=g0KpjcXJtz6ln6aB1UZjeZO3yaHEGjn1lQ/ZaIiksKs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BTUIlxYukHrooJMuNxY3oHtv7yWgFbyucbWVSpM7tD4nCvHIE7IecJ0/dmsEyth4u
	 y35A6Koi6ysIneymHY3Bbhud6KgWpKR9/2WIKyagzLx4BykzQ02EylZMuQr5K87sSf
	 JPovpa9Ai4flpIjMPhyu/qU92PK7eyX9jTJSGaXW3iPzlUd+Y3y9JY3uL8Duiv6vZp
	 RN9DtqdKNQVhTnSRHfyaxt0k/q69qPLt4q6SGCrwIFp49OlqWFfrapPxHBvSvtUlCs
	 S5loBIzVZw5hxUophIqs3HYJTdR9tFBCwWcGLP/Z4iEoXdo23aKRTZBBOsMw/WFGuJ
	 gDTVRv0LDs+8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33ABD39D0C2E;
	Wed, 13 Aug 2025 03:01:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 1/2] tls: handle data disappearing from under the
 TLS
 ULP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175505408200.2923440.4502312522998846490.git-patchwork-notify@kernel.org>
Date: Wed, 13 Aug 2025 03:01:22 +0000
References: <20250807232907.600366-1-kuba@kernel.org>
In-Reply-To: <20250807232907.600366-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 borisp@nvidia.com, john.fastabend@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, sd@queasysnail.net, will@willsroot.io,
 savy@syst3mfailure.io

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 Aug 2025 16:29:06 -0700 you wrote:
> TLS expects that it owns the receive queue of the TCP socket.
> This cannot be guaranteed in case the reader of the TCP socket
> entered before the TLS ULP was installed, or uses some non-standard
> read API (eg. zerocopy ones). Replace the WARN_ON() and a buggy
> early exit (which leaves anchor pointing to a freed skb) with real
> error handling. Wipe the parsing state and tell the reader to retry.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] tls: handle data disappearing from under the TLS ULP
    https://git.kernel.org/netdev/net/c/6db015fc4b5d
  - [net,v2,2/2] selftests: tls: test TCP stealing data from under the TLS socket
    https://git.kernel.org/netdev/net/c/d7e82594a45c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



