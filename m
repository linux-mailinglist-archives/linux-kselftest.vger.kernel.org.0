Return-Path: <linux-kselftest+bounces-25880-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1B0A29EAF
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 03:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3120188913F
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 02:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6191465B8;
	Thu,  6 Feb 2025 02:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNO2IyE1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DF3144D21;
	Thu,  6 Feb 2025 02:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738808412; cv=none; b=n5Uts3hdEcquwwX1Bh7z7+ndrMuiW2UYefTQP2tjNwu6OUSh7lX54BxkzIp9HLuVOJ0WMPc+BCRK4eOESDdysKIOHWdB4v5wcS5rSFBhuY5mhXvRzrj7AIAMH7QTi6OgTRKfCsOO0oaGr1qotREIWAp9pmWhfMDeSCRwTmqtJbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738808412; c=relaxed/simple;
	bh=Hj1LOvJ0dj5Y8w71536HdLCa6akcQoqgS7HlTzwwf4E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sjTsk8vUzzuSzAPX4Q69+/oL2RrYr75kf5TC5TDvGH40QOJUXT3h1cFJC6celRUZ3tkBmeRGszNF10Gq/DpPEQCPxQYxV2HENeFksVIBbH2V6LH1jdcmEQlGCOr9MorAdCPHVkwQzUxEUeLEurL+wQwFVR5uj7viYL4SxA/yZu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNO2IyE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C31C4CED6;
	Thu,  6 Feb 2025 02:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738808412;
	bh=Hj1LOvJ0dj5Y8w71536HdLCa6akcQoqgS7HlTzwwf4E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PNO2IyE1JbB9I/JjMZSDG9ICsePuArXn2T6n6zgNWaXsOVNPJ8uhuPQd4UslZuQc8
	 5rPNK0lCVD3PtLlp6PUEeH8/4LSYlCMitYoTC560Ewi465H1luBFTrnvZxVLhd+clQ
	 o/Mr4j1476sHv2/7iJhANTi3AOidPxv5cBevsGsi7QNqAJI7aDO+wWKhtrUYPpqIQj
	 zem+eLIJeS2VhfdW/aMaDF7Vbz5y7de5LpN4tmz+nMcBj09arqUp3PLXLw90fCepCe
	 l74lDGL71Bb057CH4ptMNzzv4Izn6bibz58HRYX/wc/egMwRchCLfOVoPseJ+JKnvF
	 yhhYhQQxdo1jA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD34380AAD0;
	Thu,  6 Feb 2025 02:20:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: net: suppress ReST file generation when
 building selftests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173880843976.974883.5017023399702656054.git-patchwork-notify@kernel.org>
Date: Thu, 06 Feb 2025 02:20:39 +0000
References: <20250203214850.1282291-1-kuba@kernel.org>
In-Reply-To: <20250203214850.1282291-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Feb 2025 13:48:50 -0800 you wrote:
> Some selftests need libynl.a. When building it try to skip
> generating the ReST documentation, libynl.a does not depend
> on them.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: donald.hunter@gmail.com
> CC: shuah@kernel.org
> CC: linux-kselftest@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: net: suppress ReST file generation when building selftests
    https://git.kernel.org/netdev/net-next/c/cbecd06a2249

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



