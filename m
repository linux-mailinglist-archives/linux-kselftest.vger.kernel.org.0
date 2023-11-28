Return-Path: <linux-kselftest+bounces-688-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 386DF7FB007
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 03:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68AE51C209BD
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 02:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308DA4C95;
	Tue, 28 Nov 2023 02:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0LM4XkH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEEE20E5;
	Tue, 28 Nov 2023 02:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63764C433CA;
	Tue, 28 Nov 2023 02:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701138026;
	bh=3I0wr31w+/f1akYEnXMNkZuJa16EXtrHK8rMefNBWrk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c0LM4XkHmkfnekEBwIpmyYxIRmOOCQ/6XDNGb5SyAsJsDCCtmBkpGLT06JKHkVCFa
	 R7vIhSO5JZsGPn/tz4lnVZCxR/yxZO3F9uAp1AHqr0dqap9swr7MkUA4X0ZWQ3RU+7
	 IDnC+ux7aCmcxGUCg+Su86Z2BEE26/vgpTX07l6u9/cFwJlCEooPdw40tEg9vKY3oY
	 V8SiWoqDqfXOEaAXQQTR1O9FCQleM2/I1mkw3eBj/bZUT1zAeLipluT7U313yRcmwG
	 4aIM+YqqM/2HVhYe+/ZhLU/CE92L4recmBxH+pFMdC7e7xITBq48v9vRUeK1G4hYxH
	 fXV1drbqnzykg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4A3E3E11F68;
	Tue, 28 Nov 2023 02:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] selftests/net: fix a few small compiler warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170113802629.29254.17417556397332607052.git-patchwork-notify@kernel.org>
Date: Tue, 28 Nov 2023 02:20:26 +0000
References: <20231124171645.1011043-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20231124171645.1011043-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, linux-kselftest@vger.kernel.org,
 willemb@google.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 24 Nov 2023 12:15:18 -0500 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Observed a clang warning when backporting cmsg_sender.
> Ran the same build against all the .c files under selftests/net.
> 
> This is clang-14 with -Wall
> Which is what tools/testing/selftests/net/Makefile also enables.
> 
> [...]

Here is the summary with links:
  - [net,1/4] selftests/net: ipsec: fix constant out of range
    https://git.kernel.org/netdev/net/c/088559815477
  - [net,2/4] selftests/net: fix a char signedness issue
    https://git.kernel.org/netdev/net/c/7b29828c5af6
  - [net,3/4] selftests/net: unix: fix unused variable compiler warning
    https://git.kernel.org/netdev/net/c/59fef379d453
  - [net,4/4] selftests/net: mptcp: fix uninitialized variable warnings
    https://git.kernel.org/netdev/net/c/00a4f8fd9c75

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



