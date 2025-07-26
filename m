Return-Path: <linux-kselftest+bounces-38020-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FCDB12BEB
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Jul 2025 20:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 088BC17949F
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Jul 2025 18:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F2028B3EE;
	Sat, 26 Jul 2025 18:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3e0DEyI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2053528AB10;
	Sat, 26 Jul 2025 18:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753555214; cv=none; b=pcm3yGFIJGX5o+hnNQK0TG7deJT72dPC6dm8Y5xIyoDfIzoy59L1zM0zhGR0UMxf7UeBm70AP5VgzBp555tE2RLJApB0gZP9gsxHBXIh3pJuh0GxFZKKAtPZHOtYYpdK9rhJyU+xi1Qy17GrQdB+esuxRIHc1e1CjQvrzLHXcsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753555214; c=relaxed/simple;
	bh=PTwOYw/TnQVS+TDJZ29TMUnrkDrgTTGYnJZvwHIiays=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ResyekjIlTxhWrf4D7zv7FWnpMjGHHJeLBPNgzgwDzIFu/I4M8lsfa9usO9Qw/JEaVAwwbSS7URFyt7wwxpCcbs2WSYf5fILc15GizorHzlTtpmLkJFPbZu4/cjUgapD2t0su2g2wpQyY7Qc+ZJkFSQ4Jk/Nex0QA/bhWvIPSdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3e0DEyI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00018C4CEED;
	Sat, 26 Jul 2025 18:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753555214;
	bh=PTwOYw/TnQVS+TDJZ29TMUnrkDrgTTGYnJZvwHIiays=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J3e0DEyIGGi4yKuOtkLuJYvyUh3DTEwSyKO9o16PSDnM+GkbRKnZIx8gQxfR9i+l7
	 VwUNQYXwquxj6PyVHpk6LOcsU0tpsiDp5JCX4WwVR1zBcFRBsH5/1M1IEAWHpaCb5g
	 NICMWcAYQnRASNPC+x2Prb+eyQbqBZPivkIAtL1q4ZIPMYXhSUTsIpcy51a1ciWfFD
	 M/0S0GXX/trS9j2nXucWbLGjJjd5eWQErW5CmLroj7vHm7y6tHbZ9GjnuEY+N/s2a4
	 N7+ifdH+lXIcIQ9UaSMmz10Cy2bd63I6Xve9pjNyn2hYsCrfzHOavXruFhivf6LzNh
	 8a8QQiYE9I+Ow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CEB383BF4E;
	Sat, 26 Jul 2025 18:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] selftests: rtnetlink.sh: remove esp4_offload after
 test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175355523100.3664802.5808444086302389218.git-patchwork-notify@kernel.org>
Date: Sat, 26 Jul 2025 18:40:31 +0000
References: 
 <6d3a1d777c4de4eb0ca94ced9e77be8d48c5b12f.1753415428.git.xmu@redhat.com>
In-Reply-To: 
 <6d3a1d777c4de4eb0ca94ced9e77be8d48c5b12f.1753415428.git.xmu@redhat.com>
To: Xiumei Mu <xmu@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, horms@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, lxin@redhat.com, sd@queasysnail.net,
 sln@onemain.com, liuhangbin@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Jul 2025 11:50:28 +0800 you wrote:
> The esp4_offload module, loaded during IPsec offload tests, should
> be reset to its default settings after testing.
> Otherwise, leaving it enabled could unintentionally affect subsequence
> test cases by keeping offload active.
> 
> Without this fix:
> $ lsmod | grep offload; ./rtnetlink.sh -t kci_test_ipsec_offload ; lsmod | grep offload;
> PASS: ipsec_offload
> esp4_offload           12288  0
> esp4                   32768  1 esp4_offload
> 
> [...]

Here is the summary with links:
  - [net,v2] selftests: rtnetlink.sh: remove esp4_offload after test
    https://git.kernel.org/netdev/net-next/c/5b32321fdaf3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



