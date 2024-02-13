Return-Path: <linux-kselftest+bounces-4574-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08668853A0B
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 19:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D2FE285854
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 18:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6787D107A6;
	Tue, 13 Feb 2024 18:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1PCUoTY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E48E1D68C;
	Tue, 13 Feb 2024 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707849631; cv=none; b=V/rPdUl7HZQ/kpRhln8w6PxSqdz8qc0EhkpR50J/4J1YKCNJ9dAgtOxGVS2szt+yzaKnz4fe+AOQZWRd38rBM3o2rJug9yFHcoT0Th8Vi/zn3lfsWja3cNSKTojNtFQUqg8C9otT4fa3eayax1XGXZ07ccFPb+/T3GRa8N4o2HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707849631; c=relaxed/simple;
	bh=/brkt/10o2WhSKJ/2y760gmdfKQFAdNKLmOi4GaZU2M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QdkJO8uXX/WhrH1ajeRS+UL6tScQJN8a9BVF6Bd8sY985g8E7q9iJHnXNsNLcIo8OTFrVcTM69w5GCXbI863y25W/K7HBWVb63im92/OEVmKmGn1CSHfcKXN7T5ZSSkfFr+CrgBG+ASz/S8EVjG+yDInjbMeaZhmeVcLYhCOpNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1PCUoTY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A75FAC43394;
	Tue, 13 Feb 2024 18:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707849630;
	bh=/brkt/10o2WhSKJ/2y760gmdfKQFAdNKLmOi4GaZU2M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O1PCUoTYwLZ9u/voRgtfBkKgCmAAwzUl3syE0OasBHIA/qpp2vkcqlhR2/PLrEV/F
	 wMJiNgdRGPHfUCj3yi7PnYzFtUk3qjmaoZ0A843VHkjnrfBnF/21npKW+UCaX85IgR
	 HCjfDgIHFP5AYSTjX5woca4pdH5DBQfIv+EMZpWTiyQTZzq2Wda0f27pSHBQdISJVb
	 CLHLlKyV4qdmk3ugw4pkveEI1S6vT0xgKUjJGeZ5DqTycEOJrhdLs2gIS7vG41KLN1
	 H6nlwJlFaOq0a4tqZS4G4vIJ2qlOT59op+IKgpllwUmsISwXePbwryQeG2rVQxuhcw
	 y8Z0KOenYKvRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8B005D84BCD;
	Tue, 13 Feb 2024 18:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] selftests: net: more pmtu.sh fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170784963056.12108.7582907823224862294.git-patchwork-notify@kernel.org>
Date: Tue, 13 Feb 2024 18:40:30 +0000
References: <cover.1707731086.git.pabeni@redhat.com>
In-Reply-To: <cover.1707731086.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, shuah@kernel.org, willemb@google.com, lkarpins@redhat.com,
 fw@strlen.de, linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Feb 2024 11:19:22 +0100 you wrote:
> The mentioned test is still flaky, unusally enough in 'fast'
> environments.
> 
> Patch 2/2 [try to] address the existing issues, while patch 1/2
> introduces more strict tests for the existing net helpers, to hopefully
> prevent future pain.
> 
> [...]

Here is the summary with links:
  - [net,1/2] selftests: net: more strict check in net_helper
    https://git.kernel.org/netdev/net/c/a71d0908e32f
  - [net,2/2] selftests: net: more pmtu.sh fixes
    https://git.kernel.org/netdev/net/c/20622dc934e1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



