Return-Path: <linux-kselftest+bounces-26181-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB8BA2F0F6
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 16:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9B541884F52
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 15:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030D020485F;
	Mon, 10 Feb 2025 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJj2g6s1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BAA1F8BAA;
	Mon, 10 Feb 2025 15:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739200207; cv=none; b=JP2GKVdPSMwonYvHqSZfqqKar6XTqM8h1JwEcePmEHSAnxkvXe2hfOG6U+wunYOO2z3Hj+xIxYkgBuF2LX1CwIFdsnFbC7LkuFCM6dddwHeeLDvDIIvIKDgboKAG1pdgXa8QXYeHB1fhAePBVXzieQmsv4d2xUaHG4W34IzH+tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739200207; c=relaxed/simple;
	bh=5v/Hlf0nYjNMcNjSA0QajG/0QZb2RxzbH+I0PIjVBQU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UyFJieb/bjckTOQDdCVyXvyRByuX0w71UwZouzPHzVywUAfrkkcQGtPhh6WLzidLCYkX2hLLe2xIM70kngkGkpq2yK6hgWeiqqTOLaSMca6YMY69BJPuifxlH5DYZcMkDUB9k6ZGc2It0VuPf6sXXNZ3AjfWykgyJoYsWl5RVhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJj2g6s1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F44EC4CED1;
	Mon, 10 Feb 2025 15:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739200207;
	bh=5v/Hlf0nYjNMcNjSA0QajG/0QZb2RxzbH+I0PIjVBQU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PJj2g6s1gJcgAhmj3IrAKN+6L/oPlWDj7XCTsngX8DkIzWo/RSpvPJsY1omiEGfmZ
	 Rnzisb7R4srB+WBHLZQk/2B7qkioco0MHeMay+6cXtDatBmJSqWKWtDWLtn0IU/6+B
	 EQBLiCdvp4GGYj3zSt9flHdDI1EqK6JvJiY078p4E0tQuoJiJ3gf6cYlI5sUFc/AOt
	 zvwB2wPNm2V4uPjGRxDQca6GAcqk0RY5+VDygapssAKwTlB33L+owGv1IS3ml4oHw6
	 Gk8cdN4LJCxPtagw/OXGxZrGfcJJUWMl1zyzzKCmx7NVLRQPwXbRCRZKgBzxc1AtKi
	 hTRN4qoe5aszA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ECA19380AA66;
	Mon, 10 Feb 2025 15:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/8] netconsole: Add support for CPU population
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173920023581.3788663.11102897546048751137.git-patchwork-notify@kernel.org>
Date: Mon, 10 Feb 2025 15:10:35 +0000
References: <20250206-netcon_cpu-v5-0-859b23cc3826@debian.org>
In-Reply-To: <20250206-netcon_cpu-v5-0-859b23cc3826@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 shuah@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 rdunlap@infradead.org, kernel-team@meta.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 06 Feb 2025 03:05:51 -0800 you wrote:
> The current implementation of netconsole sends all log messages in
> parallel, which can lead to an intermixed and interleaved output on the
> receiving side. This makes it challenging to demultiplex the messages
> and attribute them to their originating CPUs.
> 
> As a result, users and developers often struggle to effectively analyze
> and debug the parallel log output received through netconsole.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/8] netconsole: consolidate send buffers into netconsole_target struct
    https://git.kernel.org/netdev/net-next/c/1c1377d7b60c
  - [net-next,v5,2/8] netconsole: Rename userdata to extradata
    https://git.kernel.org/netdev/net-next/c/4205f6495eea
  - [net-next,v5,3/8] netconsole: Helper to count number of used entries
    https://git.kernel.org/netdev/net-next/c/563fe939a81a
  - [net-next,v5,4/8] netconsole: Introduce configfs helpers for sysdata features
    https://git.kernel.org/netdev/net-next/c/364f67837e86
  - [net-next,v5,5/8] netconsole: Include sysdata in extradata entry count
    https://git.kernel.org/netdev/net-next/c/2bae25b16aea
  - [net-next,v5,6/8] netconsole: add support for sysdata and CPU population
    https://git.kernel.org/netdev/net-next/c/ec15bc46c63c
  - [net-next,v5,7/8] netconsole: selftest: test for sysdata CPU
    https://git.kernel.org/netdev/net-next/c/12fd83ca44d8
  - [net-next,v5,8/8] netconsole: docs: Add documentation for CPU number auto-population
    https://git.kernel.org/netdev/net-next/c/a7aec70a9092

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



