Return-Path: <linux-kselftest+bounces-28733-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73664A5C13E
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 13:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D14D5169511
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 12:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DED2566EE;
	Tue, 11 Mar 2025 12:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHlviE+2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B2225487A;
	Tue, 11 Mar 2025 12:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696198; cv=none; b=Ctwgge7iz+cyCC2e4wI+1xvn/LJLyelHmnIDvp1RTLThtZWz0ZDO24fnVu5KwZ+xC6cFFumIHNRejyt5wq33RTvQsXQhpym1EU0Crx+G1FiZRajfYEiix66cFc8v4FoD3tsBw10if49oG2O+MMLm5z6AQpUKpu43+J5CaSOQ/0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696198; c=relaxed/simple;
	bh=QtZXEnAsq+kpo0B3XWYCNv9iskcf8SuO6bT85S2GaiA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PVbK9WAVu9JfQ+P41Y58ktaHrQTAz1YA7sBHhVe7r2QE2CR14fhuGgP3Hjhumbr8L5VLgVU8Jlkj2XvMj49dBu9l3ZBxU+aQETb4y3Tt2MuZINPvKngDvbXl5d4Fbo8YkK4ksdFr2Gt1q5we+Vu7drc/SJDbjdCshjpbuwVuKLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHlviE+2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112C7C4CEE9;
	Tue, 11 Mar 2025 12:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741696198;
	bh=QtZXEnAsq+kpo0B3XWYCNv9iskcf8SuO6bT85S2GaiA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VHlviE+2/1h3kZo6MwoozbySOwHSmNTBqo9W6wPc9xI93K7Hlh1G56SpYUa1VJmdu
	 U5PtWGkAOdMyUX6Ma81gm+vn3Sb8Bbny0zjVHwDOKGP7W5qk1okmgar+YP/Ysx7QLk
	 u5GXz2t05m9rUzWKhuvckLDx84YroqLQTvXSfNovjNFXN4LesY1gbya98enSy6QGex
	 AvHY3cCWOBgjtwsIO1DXHpRf60I4AvtZismEj3I4X4qsC2CGth0/2VMJw8YZQrvBOL
	 2MDCcPW1JUW8Tdvr/DM9fLT3spewWApZo4x5oOs89n5G6OXpP7Dh8kjEGhrJE8bz5t
	 VwXAk2Dgf+2vQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7123C380AC1C;
	Tue, 11 Mar 2025 12:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv4 net 0/2] bonding: fix incorrect mac address setting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174169623226.66274.17244628271427546125.git-patchwork-notify@kernel.org>
Date: Tue, 11 Mar 2025 12:30:32 +0000
References: <20250306023923.38777-1-liuhangbin@gmail.com>
In-Reply-To: <20250306023923.38777-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 razor@blackwall.org, horms@kernel.org, shuah@kernel.org, cratiu@nvidia.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  6 Mar 2025 02:39:21 +0000 you wrote:
> The mac address on backup slave should be convert from Solicited-Node
> Multicast address, not from bonding unicast target address.
> 
> v4: no change, just repost.
> v3: also fix the mac setting for slave_set_ns_maddr. (Jay)
>     Add function description for slave_set_ns_maddr/slave_set_ns_maddrs (Jay)
> v2: fix patch 01's subject
> 
> [...]

Here is the summary with links:
  - [PATCHv4,net,1/2] bonding: fix incorrect MAC address setting to receive NS messages
    https://git.kernel.org/netdev/net/c/0c5e145a350d
  - [PATCHv4,net,2/2] selftests: bonding: fix incorrect mac address
    https://git.kernel.org/netdev/net/c/9318dc2357b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



