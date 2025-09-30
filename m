Return-Path: <linux-kselftest+bounces-42635-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C571BAD103
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 15:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0722A3A5031
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 13:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6683F222585;
	Tue, 30 Sep 2025 13:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cm8u4toS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDB1EEBB;
	Tue, 30 Sep 2025 13:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759239022; cv=none; b=TJGGwzlW9PA2XgJxP0ZvTNu82CUMOikxxo54cGxRTYLfe7uWZH1zjTTPyaHosk2aMsgmV+sYMjF4YXRjpL7QKzZijPE90J2swEiONoos6ZmyqAvTcEXSMncf6E0UticitDqpjKMFH/WTt7DDR67PPz15S3k8OyzjsuLZReK8fps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759239022; c=relaxed/simple;
	bh=81/cPNGBUSltshRql5ZlxfxYOk61TAeLA/O0bn/c1No=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l525CslpqyWxXX2pS39tZ4O1lBzYc7rvIVr6ANJvG+KoZJSk9hekcw6RkxKvih86fDZNV/n4zgyopc+6+wapiVkd6UwlAsfhGWbCJotWw755K/BhDiB4dK97YW3m3zRiyIcyH6MXgO+pzis6VdeR988RJHjBxtXD1k2adCdofN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cm8u4toS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13642C4CEF0;
	Tue, 30 Sep 2025 13:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759239022;
	bh=81/cPNGBUSltshRql5ZlxfxYOk61TAeLA/O0bn/c1No=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Cm8u4toS+svxnMmwYbZK9Py7jdNaihC1ddw5Gh+wQnnwemsf79qgTsd1gmfmFDt1F
	 O5W/SueIyrr2wuUsc26qL3yJf3HTp0AggU5qW98lfDOv6uaaxLruyVOwMG/OMc+UE8
	 aEvjsy7LKu6bO5z31oQ/UDgbl3JzREf3fXBHbg7fXlVDcmIbG7LVh3n0SnQ0aX99Mw
	 qeSA788zZsCa/9NCTntSmuhp4QO7AQVzEvR7e0fYkFN6XzPTTum+Js8G7Sqz2v4fde
	 F1UI+wikwt9RfjSDdEpTZhFdIRtk6oqP9G3hueDeOHPWJWNzgjnCrY+5tUE2OnjsD5
	 NiDRfbSc8YNVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7167639D0C1A;
	Tue, 30 Sep 2025 13:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/8] psp: add a kselftest suite and netdevsim
 implementation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175923901526.1987398.4750488839413075076.git-patchwork-notify@kernel.org>
Date: Tue, 30 Sep 2025 13:30:15 +0000
References: <20250927225420.1443468-1-kuba@kernel.org>
In-Reply-To: <20250927225420.1443468-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, petrm@nvidia.com,
 willemb@google.com, shuah@kernel.org, daniel.zahka@gmail.com,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 27 Sep 2025 15:54:12 -0700 you wrote:
> Add a basic test suite for drivers that support PSP. Also, add a PSP
> implementation in the netdevsim driver.
> 
> The netdevsim implementation does encapsulation and decapsulation of
> PSP packets, but no crypto.
> 
> The tests cover the basic usage of the uapi, and demonstrate key
> exchange and connection setup. The tests and netdevsim support IPv4
> and IPv6. Here is an example run on a system with a CX7 NIC.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/8] netdevsim: a basic test PSP implementation
    https://git.kernel.org/netdev/net-next/c/f857478d6206
  - [net-next,v3,2/8] selftests: drv-net: base device access API test
    https://git.kernel.org/netdev/net-next/c/8a5f956a9fb7
  - [net-next,v3,3/8] selftests: drv-net: add PSP responder
    (no matching commit)
  - [net-next,v3,4/8] selftests: drv-net: psp: add basic data transfer and key rotation tests
    https://git.kernel.org/netdev/net-next/c/8f90dc6e417a
  - [net-next,v3,5/8] selftests: drv-net: psp: add association tests
    https://git.kernel.org/netdev/net-next/c/81b89085319b
  - [net-next,v3,6/8] selftests: drv-net: psp: add connection breaking tests
    https://git.kernel.org/netdev/net-next/c/2748087cf12d
  - [net-next,v3,7/8] selftests: drv-net: psp: add test for auto-adjusting TCP MSS
    https://git.kernel.org/netdev/net-next/c/81236c74dba6
  - [net-next,v3,8/8] selftests: drv-net: psp: add tests for destroying devices
    https://git.kernel.org/netdev/net-next/c/b3820e0e6c12

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



