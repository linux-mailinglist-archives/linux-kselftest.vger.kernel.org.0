Return-Path: <linux-kselftest+bounces-43450-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BAFBEC124
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 02:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A3B1742B22
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 00:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5170313E2A;
	Sat, 18 Oct 2025 00:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYbBSHoQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1AE31064A;
	Sat, 18 Oct 2025 00:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760745639; cv=none; b=rgMBF9qeyaAvukzVjaViNy88tUMbxNTAf+eatnlmFov1uQJpeB4/vf/xrVU4J7URFOyK3OCu8DY3YhXqH6eA7zTCspd45I/eE4LoGBacuJuUX4GhUsDjB1DjVoJR7UtV/KlcJqQBy2b0wHxQaL6cMFhKa4GVUhNCyn/PhGVU7L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760745639; c=relaxed/simple;
	bh=8ZvuZrQVPSxHoFtZ/1i1cwTjbmSetActwbtDF2PaMeg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KN/vvT1Fvw291NW66aZDxolN4cIXzRCEjQSXWI41zpRItoQR6tC6pZ0KXVGIsJyta7HBQNr9uddAL6bP9ZUTgI6vupHFkirfPV0Stzkze+1GqS+/fhUTgCAdEpOuwuuVwgcqnDAr5Nd0jJqVcyUsIETF5MP4FRRv8LbJySlBfho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYbBSHoQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89909C4CEF9;
	Sat, 18 Oct 2025 00:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760745639;
	bh=8ZvuZrQVPSxHoFtZ/1i1cwTjbmSetActwbtDF2PaMeg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pYbBSHoQ2cbBhAjuXvBnHAIR6ajDQOLlEQ0j6kron5LjYEmcrCx0E5On0Ws47ufts
	 U7ElOocnA45poDerwGedwzb5b9MHCkVV1D90++43nuhuD394d/I01QzijdzwyYm3fm
	 kc8u4Ezf3evOkbtp11XgjiVklYh7cDq1qxqiY3TCOB53F8nkORNljkSKTAMVRbZBw1
	 VOqF7jyA9Smdn4DEsnNIyrhOjDmGo3mesZjhPVisANffCcerEyfjTiSNU2Ji82f1J2
	 4Wqb1QwUPvRCLTg/F5W2qURq8tFc+ufI2zBe6HrFKF9xrmAqZYOituI6Vu2LShXMzn
	 WOCfB4jDQN03g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D6B39EFA61;
	Sat, 18 Oct 2025 00:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests/net: io_uring: fix unknown errnum
 values
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176074562274.2830883.3126379856280488535.git-patchwork-notify@kernel.org>
Date: Sat, 18 Oct 2025 00:00:22 +0000
References: <20251016182538.3790567-1-cmllamas@google.com>
In-Reply-To: <20251016182538.3790567-1-cmllamas@google.com>
To: Carlos Llamas <cmllamas@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 kernel-team@android.com, linux-kernel@vger.kernel.org,
 asml.silence@gmail.com, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Oct 2025 18:25:37 +0000 you wrote:
> The io_uring functions return negative error values, but error() expects
> these to be positive to properly match them to an errno string. Fix this
> to make sure the correct error descriptions are displayed upon failure.
> 
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>  .../selftests/net/io_uring_zerocopy_tx.c      | 24 +++++++++----------
>  1 file changed, 12 insertions(+), 12 deletions(-)

Here is the summary with links:
  - [net-next] selftests/net: io_uring: fix unknown errnum values
    https://git.kernel.org/netdev/net-next/c/f578ff4c5388

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



