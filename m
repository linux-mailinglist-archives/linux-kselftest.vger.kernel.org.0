Return-Path: <linux-kselftest+bounces-41091-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 414B3B50AF4
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 04:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5005E1BC719A
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 02:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1355238C2A;
	Wed, 10 Sep 2025 02:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKKsildu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5F3200C2;
	Wed, 10 Sep 2025 02:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757470807; cv=none; b=HxsA1xz4zUphSHkDt/cbazWU3tNBbMaaBh9Vwnm6wCAjYL5zPLPFXwh/9SLnXRyGyKI8ymu6CJswsv8NhTqbGXIEDaLAw0vB+OkEAwDt++dUuO8fTKFILTCtdCzNeij+5P8YfWI/4NCIiDVDdYB+n4LL0kOsPoD95nh74knRTaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757470807; c=relaxed/simple;
	bh=dIL5T/VhrMyP+D+xxxmzNfI252wmfOv3usV7QGTLrY0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rIDQOBXXKSE3oHTN57GpIlBnb6jneNgk2Ixg+/iadXM1B0sNB0UHU+0nYwXm6wr7g8cFaSbPLaSzQkBTMRHIDohUpgq1W6fZU+AuDWCuZ/ehybNYokAek7lFg9BNdZyEGlxOt3kVOnT1VbasR1b82mmINQSE4C1MliA+3+NEjT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKKsildu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B02EC4CEF4;
	Wed, 10 Sep 2025 02:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757470807;
	bh=dIL5T/VhrMyP+D+xxxmzNfI252wmfOv3usV7QGTLrY0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DKKsildunjBuorqMDrDI7xVFFgvS7AvRsE/H9FOcIl6I7Rvp9Dk7wievMK9/osc/o
	 h3Q3BQnD79NY3IVowhKlxhCN8L2SMlYCfAkINp2WeQ6jmecptDYLJCwaJp8lPP6Qik
	 muD9YdTNr1aUjIE4mW5S9GnW0H+6NV0uCU/bGOLBB1oFCQPn0yqQdWQeUPlvTW2408
	 dQyRoAX5nSvnClv8Y/dc0sbydgMGBGxVZCCeIHDtnpPw21wR1g+fIzFAFzRJsshP1B
	 6SAleUdXYMi/jJd1kWz70J0rQOjI+pgJ9d+5bsfmkwTSfjYwllRhV5yZz7uNqEIDpQ
	 erHNKOR/mJnpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C37383BF69;
	Wed, 10 Sep 2025 02:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] mptcp: make ADD_ADDR retransmission timeout
 adaptive
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175747081026.879618.4585653911597992298.git-patchwork-notify@kernel.org>
Date: Wed, 10 Sep 2025 02:20:10 +0000
References: 
 <20250907-net-next-mptcp-add_addr-retrans-adapt-v1-0-824cc805772b@kernel.org>
In-Reply-To: 
 <20250907-net-next-mptcp-add_addr-retrans-adapt-v1-0-824cc805772b@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, corbet@lwn.net, shuah@kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, cpaasch@openai.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 07 Sep 2025 17:32:41 +0200 you wrote:
> Currently, the MPTCP ADD_ADDR notifications are retransmitted after a
> fixed timeout controlled by the net.mptcp.add_addr_timeout sysctl knob,
> if the corresponding "echo" packets are not received before. This can be
> too slow (or too quick), especially with a too cautious default value
> set to 2 minutes.
> 
> - Patch 1: make ADD_ADDR retransmission timeout adaptive, using the
>   TCP's retransmission timeout. The corresponding sysctl knob is now
>   used as a maximum value.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] mptcp: make ADD_ADDR retransmission timeout adaptive
    https://git.kernel.org/netdev/net-next/c/30549eebc4d8
  - [net-next,2/3] selftests: mptcp: join: tolerate more ADD_ADDR
    https://git.kernel.org/netdev/net-next/c/63c31d42cf6f
  - [net-next,3/3] selftests: mptcp: join: allow more time to send ADD_ADDR
    https://git.kernel.org/netdev/net-next/c/e2cda6343bfe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



