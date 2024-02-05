Return-Path: <linux-kselftest+bounces-4141-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 720E2849A92
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 13:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05C851F21047
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 12:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0912B1BC2C;
	Mon,  5 Feb 2024 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1Vss1F9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F631CA85;
	Mon,  5 Feb 2024 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136829; cv=none; b=Dsikja/MPjM9Qonx0joc7YUkSMKblqs8PKSiBbPjA1UFD4cmyfami8uVOFLj5/4TbYMJ14iJwptzTAjytNMP3SwMo02rXQeSlyP+pZ8w+ZR5c+zEI7X9+yqjstp4z+BA1r3mzWWBMCFEfVmcs3gtjaSs+bDIOUIIqIWBI0vdBRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136829; c=relaxed/simple;
	bh=u4tS5clHE+e08A6mkZJOrtdyQrh51E8hndBbKgehUbA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j7wsCm4HALwjBVJEQ45TR1nYiEsJ8gOLdbjjtFFmUgXsscS4o7v+DcH+213r7rr0wXWhlWJ5VXQadT1MD7CSMbdulbqBqdFws8W2z2Xne2TYyeJNsTnDGyrgScw5T4JB3tFvrOt83zxb+PpASn7Y9/kMOBpGYI+eQsTjpM4Sr6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1Vss1F9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43F6EC433F1;
	Mon,  5 Feb 2024 12:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707136829;
	bh=u4tS5clHE+e08A6mkZJOrtdyQrh51E8hndBbKgehUbA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q1Vss1F9q02fB7xeXPSn0BOUZvuTCXA0isQ7PGB5tksQJdmEWIEZRUc86Cpjz9wOR
	 jbKK+IzfgPdqh3L6w9DlgPdAKLNOjBnkgiNHtRVhXZzvj+DcyXdvsRl84yM9n+7k+d
	 K7uAHjWxcKtbcsRwOfcKfS2z694XQlbZ0imfDmRygyacMU5kKT4DsnEWcVBP36Wcg3
	 BbtD4N0wUYN2xejKTaUB+bAfOHIkS+9kht9sNWBFz3rJFS/DaG2OZUWzgipGuWLqgD
	 jXe80b/cE2DEHtMrCUGyWoP9IKG7C8MuI55eAK9XDWR+YmWqYaPmbLzvt1AwTFBf7g
	 pjCMgVXJjFLoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F016E2F2ED;
	Mon,  5 Feb 2024 12:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: net: let big_tcp test cope with slow env
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170713682912.8022.5562954961086961719.git-patchwork-notify@kernel.org>
Date: Mon, 05 Feb 2024 12:40:29 +0000
References: <f011968fee563eeaaa82bf94e760e9f612eee356.1706889875.git.pabeni@redhat.com>
In-Reply-To: <f011968fee563eeaaa82bf94e760e9f612eee356.1706889875.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, shuah@kernel.org, lucien.xin@gmail.com,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  2 Feb 2024 17:06:59 +0100 you wrote:
> In very slow environments, most big TCP cases including
> segmentation and reassembly of big TCP packets have a good
> chance to fail: by default the TCP client uses write size
> well below 64K. If the host is low enough autocorking is
> unable to build real big TCP packets.
> 
> Address the issue using much larger write operations.
> 
> [...]

Here is the summary with links:
  - [net] selftests: net: let big_tcp test cope with slow env
    https://git.kernel.org/netdev/net/c/a19747c3b9bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



