Return-Path: <linux-kselftest+bounces-30454-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3A3A834B3
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 01:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CFB2447090
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 23:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD9D221712;
	Wed,  9 Apr 2025 23:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klWj6whD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1482206B1;
	Wed,  9 Apr 2025 23:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744242017; cv=none; b=O5NdSybGsrnUMUpV2mWNubxRvPcI6xs+7hI039WWseHKwoy642zlUa8cKeuZg0b+gSdKjYnX66MmNjH+Pphlo0iSdbFX04EUeO/SglF0bfrB3u2eYwZgxnx9lA9SJrP0GdNjEaGv2JRetGwaeSGlxtR68CW6gUx00WqJWsE64sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744242017; c=relaxed/simple;
	bh=5C33hRKzWhmgnHA9UF7i2n/JVhuMRJzbpgRhNGUgMmw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pH0ayP2gqgWMWY2LoS0aU1sGjvfFvxhsotyADHLhEx9LUBskjwBDBamyGxssAWilrJBSiS0bwEa87eAuw6hh9w6AW7uq7qkRELUoo+If1nJ8vjNARhjwVrIgu0R5SIGBpHACjWrm7XA7B4cRPmONU3mo7neWsA6Do1cnYd/S2kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klWj6whD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED450C4CEE9;
	Wed,  9 Apr 2025 23:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744242017;
	bh=5C33hRKzWhmgnHA9UF7i2n/JVhuMRJzbpgRhNGUgMmw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=klWj6whDD0eTlTqmx6mm7vObewHuL1Q2/AYh7zULKhpoExE8x4u5W2dwVBGVYTfSx
	 o2DSPyyclR9DcecVBlqumY5W/8zEOolpdHNZx7fcHsxqfbxC+bHZRv/8qD/tStX7vG
	 lqXjYgiba0f5hi0GoQhJL8VsaQko7JLB0oX6TK+STVvlOqpw1OpdEK8WJTIWHghX2r
	 XGkwhKVqf7nFj8Y6GUhK051ohlKiGHpn+X8IjaOMbgr6APyMtol9kP5oumJc/OMq9M
	 2p+yo2bNk9OiwWBS13QbCisd0WMwGs4bAZchX1uy0hE69KyeO4xChD26BgThk0MEd+
	 wK3Ky3WTwRF0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF1338111DC;
	Wed,  9 Apr 2025 23:40:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: Fix bpf_nf selftest failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174424205428.3077267.2317045972591110565.git-patchwork-notify@kernel.org>
Date: Wed, 09 Apr 2025 23:40:54 +0000
References: <20250409095633.33653-1-skb99@linux.ibm.com>
In-Reply-To: <20250409095633.33653-1-skb99@linux.ibm.com>
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, ast@kernel.org, hbathini@linux.ibm.com,
 andrii@kernel.org, daniel@iogearbox.net, mykolal@fb.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  9 Apr 2025 15:26:33 +0530 you wrote:
> For systems with missing iptables-legacy tool, this selftest fails.
> 
> Add check to find if iptables-legacy tool is available and skip the
> test if the tool is missing.
> 
> Fixes: de9c8d848d90 ("selftests/bpf: S/iptables/iptables-legacy/ in the bpf_nf and xdp_synproxy test")
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> 
> [...]

Here is the summary with links:
  - selftests/bpf: Fix bpf_nf selftest failure
    https://git.kernel.org/bpf/bpf-next/c/967e8def1100

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



