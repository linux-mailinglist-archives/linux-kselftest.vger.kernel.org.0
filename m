Return-Path: <linux-kselftest+bounces-38747-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FC6B21B95
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 05:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01C63681988
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 03:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7672E5B21;
	Tue, 12 Aug 2025 03:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJ+G3nwX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7C62E5B1D;
	Tue, 12 Aug 2025 03:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754968815; cv=none; b=tc0Hjm7n/yHqzcZyNiZ2WrnPs2G4Qv/9dvimGKO3Lh5dQN/xA54kLWoYphBoSrYQluwCOSRFD+GNAwYmUq+DOlxqQZh4Kj+EFFuK7bUBpL4jkVZ5ts8Rk7qdJxfpUAM0pqJSBCs1d/ILnYGXyJbdJtO+qc3QC+ZBT0KjjwMhWjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754968815; c=relaxed/simple;
	bh=/wZ5J2aHm0wr+JulREeL2jKH/HWt7HxPuCfjCYFvJ18=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YgpmFRPNNZyuykKfZgmD0eqta9d8IlZTR9bGsWyhTP2Bk1ReqDuC7M5dv+qf+P+ResF30dhpfwdnQgS+FJgF7maJCS5kxFTp6yhzztf+cXIzaaMev3crqLLjctVw5K4WAYNs9bhV9wkS7/AlYzt3eECi0VIlNFrCZXNtRWAVo+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJ+G3nwX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D9AC4CEF5;
	Tue, 12 Aug 2025 03:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754968813;
	bh=/wZ5J2aHm0wr+JulREeL2jKH/HWt7HxPuCfjCYFvJ18=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jJ+G3nwXooveQfIhJ6EdKc0pV2wa5PzX3iES0RJoDvonQbjX5L0J5dURuyHGtzSgO
	 KdhpPhoYeYvPYO8XwMZzYJfON319GXYNUXFqNbDexmB2Qo8OMkrFfOZNaoZvSNZVbC
	 chFditxAcqMHsEqG5fqCDHtVq0idBGhnCU2ARxm1V0MqpvaHl8FxMzPa5XyPtBCXCF
	 9lo+1b3c5LPpGUHTExHUidcKP9TN7Ih/iQWr20MaDo1D1BXv/OttFegYONl4dgNEZL
	 uy5kwU5dwdeRH1z8hVhxFmA+i3ZJBZqPCkpiwBNzc9MdYH5XZLVWjd+ykK/+DLv/uy
	 nODQDTYkaNlAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33ABA383BF51;
	Tue, 12 Aug 2025 03:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] selftests/net: Ensure assert() triggers in
 psock_tpacket.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175496882574.1990527.2336308877381188320.git-patchwork-notify@kernel.org>
Date: Tue, 12 Aug 2025 03:20:25 +0000
References: <20250809062013.2407822-1-wakel@google.com>
In-Reply-To: <20250809062013.2407822-1-wakel@google.com>
To: Wake Liu <wakel@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, horms@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  9 Aug 2025 14:20:13 +0800 you wrote:
> The get_next_frame() function in psock_tpacket.c was missing a return
> statement in its default switch case, leading to a compiler warning.
> 
> This was caused by a `bug_on(1)` call, which is defined as an
> `assert()`, being compiled out because NDEBUG is defined during the
> build.
> 
> [...]

Here is the summary with links:
  - [v2] selftests/net: Ensure assert() triggers in psock_tpacket.c
    https://git.kernel.org/netdev/net-next/c/bc4c0a48bdad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



