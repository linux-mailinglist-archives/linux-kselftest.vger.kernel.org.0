Return-Path: <linux-kselftest+bounces-46850-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A78A6C9924D
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 22:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 981C54E1E0D
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 21:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42142749C9;
	Mon,  1 Dec 2025 21:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzzxbbfK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8592F78F4A;
	Mon,  1 Dec 2025 21:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764623593; cv=none; b=M6GFWYtwBtXERT+qDTQI1O+mZVbcRIrGLURzqvxV6J1wFY9FTnEcyv6uvNp6JZ4rNlL0dKMRSHxTlgU8iEV+x9Zf74zZVAm/S5As6HCpGjAkqEe7rTpEUmrC70DmO1WnYSFd0VJejXIcs1Un4jWSaXXjNbLQDgRy53BThbUfJaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764623593; c=relaxed/simple;
	bh=liix6GXfbAMaE20RwHi3LqcsJpqnCqXgGGCqZOTyZ3o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bc0ZshtBNmpD12p8XoITEjMxi8vAsCjWVOk4i+w3mcTmtRP7au9qS3ht9TeSds4sbbVBCEFMm/zfe8i6ILatyybqdmfslx/U0DzLT3lI5hp9wwTH5ST+y0pGdgsf3cCajpT6fRmoHHFJYI55Rb4NBkZwD2kFwxS4sWO4Jw2Rftk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzzxbbfK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7B8C116C6;
	Mon,  1 Dec 2025 21:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764623593;
	bh=liix6GXfbAMaE20RwHi3LqcsJpqnCqXgGGCqZOTyZ3o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MzzxbbfKx0FQkmGUZX+VPn+40sIlIvags6+JpnMegqfkE89/uc4lIrl+L6xB2wNeP
	 fG6AOwia5z4D7GcoofdsajfTBta6Gw0dSlEvsI3SppzivFodojn9ks0rg/GS/XUhHl
	 WSm+yvNAm4FdmiVVfn1ji7LSsjuwGm7ojQP6Y4A7Vt735XBQ/Re49fhqf/jGdj5yKH
	 N4Lx7zgRcHA864Zf0U+gvu0HpfrbPqb1JhHN2i77nhi5amS52wvJBem/0r4D+POyfE
	 NK7zCDi+U0AujR/mwBcKGj4g9/mFS6bL1toxMShO+51GlB5ITMYtg75dHUz9qaNXHP
	 ttXU1vdRNefUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3BE81381196A;
	Mon,  1 Dec 2025 21:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: netconsole: remove log noise due to
 socat exit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176462341303.2539359.9995367418686827424.git-patchwork-notify@kernel.org>
Date: Mon, 01 Dec 2025 21:10:13 +0000
References: <20251129-netcons-socat-noise-v1-1-605a0cea8fca@gmail.com>
In-Reply-To: <20251129-netcons-socat-noise-v1-1-605a0cea8fca@gmail.com>
To: Andre Carvalho <asantostc@gmail.com>
Cc: leitao@debian.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 29 Nov 2025 12:24:19 +0000 you wrote:
> This removes some noise that can be distracting while looking at
> selftests by redirecting socat stderr to /dev/null.
> 
> Before this commit, netcons_basic would output:
> 
> Running with target mode: basic (ipv6)
> 2025/11/29 12:08:03 socat[259] W exiting on signal 15
> 2025/11/29 12:08:03 socat[271] W exiting on signal 15
> basic : ipv6 : Test passed
> Running with target mode: basic (ipv4)
> 2025/11/29 12:08:05 socat[329] W exiting on signal 15
> 2025/11/29 12:08:05 socat[322] W exiting on signal 15
> basic : ipv4 : Test passed
> Running with target mode: extended (ipv6)
> 2025/11/29 12:08:08 socat[386] W exiting on signal 15
> 2025/11/29 12:08:08 socat[386] W exiting on signal 15
> 2025/11/29 12:08:08 socat[380] W exiting on signal 15
> extended : ipv6 : Test passed
> Running with target mode: extended (ipv4)
> 2025/11/29 12:08:10 socat[440] W exiting on signal 15
> 2025/11/29 12:08:10 socat[435] W exiting on signal 15
> 2025/11/29 12:08:10 socat[435] W exiting on signal 15
> extended : ipv4 : Test passed
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: netconsole: remove log noise due to socat exit
    https://git.kernel.org/netdev/net-next/c/e3b8cbf40c6e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



