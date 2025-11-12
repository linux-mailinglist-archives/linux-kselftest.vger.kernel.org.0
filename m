Return-Path: <linux-kselftest+bounces-45418-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97297C52D56
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 15:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 517DD3BEDD5
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 14:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BE0299923;
	Wed, 12 Nov 2025 14:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zw3KNHAH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C334728EA72;
	Wed, 12 Nov 2025 14:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762957853; cv=none; b=JzGiDOXYUFuizzjF/cwczO/KYFrk39EfqAC7/2mR/H5nEOe+Ze1dgKYIGJBWGQNab5CSsjsU+m5MYGefR3d71i5Dq33qq5LFEHnPynNO0dHgIQ/2HAcGV3d9b9/PVT4GW/hUwCpeey/XRm6aiSUlHIMkpmrR6wdBDEGQAOdGY+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762957853; c=relaxed/simple;
	bh=3FdEcwj+ciRZ8JLvFj+7/W5I/4n2XvOT5a4rfWWWSgM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Nv67An4dXY7O8nc0R/Q45iIodWIx5r2E9/ikXbzgY9lrdDGaSLyzp41kg3qzB1obFfneWPFB+w6o7Ds/ADlmhJkGa8tQdsGv/LCv+d430pXzIEctNy7A2kDBdn0Xzgb9wdZibC8s3y1hY4MhKVV7GwUoRIxbadaB9sFfp5Lg07o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zw3KNHAH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DAEEC4CEF1;
	Wed, 12 Nov 2025 14:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762957853;
	bh=3FdEcwj+ciRZ8JLvFj+7/W5I/4n2XvOT5a4rfWWWSgM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Zw3KNHAHR3J0yx23pvDVWB57sQhigyEJZfMon6Jp8dGp8VYWsZWnNkyxW+ThgW3OI
	 Hq8DpZl+yE0/OqBIIM9lMC7xb1PwGhGGqipQFpNVV1b3typq2qughB3EW0QRPlldHo
	 x+QI5meXx0yLt19prhVvYCYzrCrGbvVUf/pthYi5yl4eyeI4H2fqkxqMRY6mIJkSCj
	 Mewk8rKtHmydxRObOXrurw/311ZVLOu8ml7Tx8QwSlSC3mXu8f2JFtg3XSkJbAc451
	 6H1gKvdt6WyU1wL9hcJSI6SSdVFAnRKFs1dMozj2IhIT0oJt6daTEZNN6OnoahP931
	 j6WAqYiAw9iKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3409C39EF952;
	Wed, 12 Nov 2025 14:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 00/12] selftests/vsock: refactor and improve
 vmtest infrastructure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176295782301.29085.14486251281449214538.git-patchwork-notify@kernel.org>
Date: Wed, 12 Nov 2025 14:30:23 +0000
References: 
 <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
In-Reply-To: 
 <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: sgarzare@redhat.com, shuah@kernel.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, horms@kernel.org, bobbyeshleman@meta.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 08 Nov 2025 08:00:51 -0800 you wrote:
> Hey all,
> 
> This patch series refactors the vsock selftest VM infrastructure to
> improve test run times, improve logging, and prepare for future tests
> which make heavy usage of these refactored functions and have new
> requirements such as simultaneous QEMU processes.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,01/12] selftests/vsock: improve logging in vmtest.sh
    https://git.kernel.org/netdev/net-next/c/d9cac93cd1be
  - [net-next,v4,02/12] selftests/vsock: make wait_for_listener() work even if pipefail is on
    https://git.kernel.org/netdev/net-next/c/2ed3ce7efbd2
  - [net-next,v4,03/12] selftests/vsock: reuse logic for vsock_test through wrapper functions
    https://git.kernel.org/netdev/net-next/c/4f76ff14d3d9
  - [net-next,v4,04/12] selftests/vsock: avoid multi-VM pidfile collisions with QEMU
    https://git.kernel.org/netdev/net-next/c/ac8997e943bc
  - [net-next,v4,05/12] selftests/vsock: do not unconditionally die if qemu fails
    https://git.kernel.org/netdev/net-next/c/c7df4adc0679
  - [net-next,v4,06/12] selftests/vsock: speed up tests by reducing the QEMU pidfile timeout
    https://git.kernel.org/netdev/net-next/c/9e2ad0bc3640
  - [net-next,v4,07/12] selftests/vsock: add check_result() for pass/fail counting
    https://git.kernel.org/netdev/net-next/c/7fea50dff988
  - [net-next,v4,08/12] selftests/vsock: identify and execute tests that can re-use VM
    https://git.kernel.org/netdev/net-next/c/d13fb04a4bf0
  - [net-next,v4,09/12] selftests/vsock: add BUILD=0 definition
    https://git.kernel.org/netdev/net-next/c/592e3d14cecf
  - [net-next,v4,10/12] selftests/vsock: add 1.37 to tested virtme-ng versions
    https://git.kernel.org/netdev/net-next/c/67422ef38f8c
  - [net-next,v4,11/12] selftests/vsock: add vsock_loopback module loading
    https://git.kernel.org/netdev/net-next/c/338c5ddf4c88
  - [net-next,v4,12/12] selftests/vsock: disable shellcheck SC2317 and SC2119
    https://git.kernel.org/netdev/net-next/c/99f932c90509

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



