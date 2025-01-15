Return-Path: <linux-kselftest+bounces-24605-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CB2A12EA3
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 23:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29703161F75
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 22:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4081DDC34;
	Wed, 15 Jan 2025 22:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pV9eeF5R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354F81DD529;
	Wed, 15 Jan 2025 22:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736981415; cv=none; b=SmrQQf+WE1/cQ6tnk1puCYJbe0dC4R5sgUACHrezqhbliDCvB8KoQJ/iqxwrFdz6F8k+S1ZjNwojlnZc0fO1Z1AoHXALUBNGUPwNoAivrr38Oygd9K8b1rdFcyZVXW+K9hBILWgO5S17Ouzl5fothH9Jq8WF8BxBR02o+jeUfHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736981415; c=relaxed/simple;
	bh=mq8xc3SHUUJFXI2TCpN1+ASPX1uGYdGLnofgYhbYa0s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Rqebz7mBMaKv7WZ8IhLx0W3DnSiNH/Ho9n9Q0chiHu+KJD383/l/Wn8RtnjnG1xkEJ/MOIG4x2yhvQZhmmVjgurTU3aofxjEimnDNSaeeDlfKMYGCYUxePvTkibgvC/+faCnIWZNpBXdcJeOcfAR4QppNlUSQkQ6it3bnJU4CpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pV9eeF5R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096CEC4CEE1;
	Wed, 15 Jan 2025 22:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736981415;
	bh=mq8xc3SHUUJFXI2TCpN1+ASPX1uGYdGLnofgYhbYa0s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pV9eeF5RCKrpNCUHSHdZHrYVfHDl3YLj4y0XOKoGc11BUOpYKOEungCsGdAEBif8N
	 mFatfm0f5QhAccxDyg3NyR/Ig1AnpeQDS6A4Yl3/4aMbaKxvMWByx3R4QvQH5gM2VN
	 zzh8N4TloP00PIRqhwGXwbYFJIjRTTAOSzZSwJIKvCgsP8iFNSF8DIMZpXyGlQt9zJ
	 GKn0bMXJx7hWEt4fTyfBaPkDSO6Koh6u+lUbYMSzJyI9+9unsfXZ8B9BX1R8j2OACc
	 7ki/R474dX/Q+pCW9R4D8+cHuhIvLS/vypnzqK4Ivbpnks24vBuhuG60xGxlxYNZHj
	 09tr7C7uxIokg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E26380AA5F;
	Wed, 15 Jan 2025 22:50:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] selftests/net/forwarding: teamd command not found
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173698143800.903583.1874462341799524644.git-patchwork-notify@kernel.org>
Date: Wed, 15 Jan 2025 22:50:38 +0000
References: <20250114003323.97207-1-alessandro.zanni87@gmail.com>
In-Reply-To: <20250114003323.97207-1-alessandro.zanni87@gmail.com>
To: Alessandro Zanni <alessandro.zanni87@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, liuhangbin@gmail.com,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Jan 2025 01:33:16 +0100 you wrote:
> Running "make kselftest TARGETS=net/forwarding" results in
> multiple ccurrences of the same error:
> - ./lib.sh: line 787: teamd: command not found
> 
> This patch adds the variable $REQUIRE_TEAMD in every test that uses the
> command teamd and checks the $REQUIRE_TEAMD variable in the file "lib.sh"
> to skip the test if the command is not installed.
> 
> [...]

Here is the summary with links:
  - [v2] selftests/net/forwarding: teamd command not found
    https://git.kernel.org/netdev/net-next/c/7a649f39dab7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



