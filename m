Return-Path: <linux-kselftest+bounces-2565-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D483A821C93
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 14:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863A81F22B21
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 13:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188F2FC00;
	Tue,  2 Jan 2024 13:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkcYUec3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E793CFBF8;
	Tue,  2 Jan 2024 13:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7AF1FC433C7;
	Tue,  2 Jan 2024 13:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704202228;
	bh=K9JcRmV8/t3li0JpOvM7C9MUh83KIAuq7YYQ80apTPQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jkcYUec3NDMLFG2LNozfG1EOKlu3QnQwIYf7LTQK4+TAgr3CZ8WLfJYTbWmpziE2n
	 6QrlUfL7pRbXi02BGaTKD+Oup1UJiagEAjTUQ6u9xs+2PidaMg0VxAk/GEK5L1bYuE
	 v08DKbTkl7vsWQW93ly80z2qAZxDsMGVaaR+TZf91B96OkfnGgli1GDl4ux+7ib6lv
	 P6yKs17VmKN87i9+W8Cst/OQJCy5jUAW8dtCJjO0DlZZPQt6zW3iBNN3tEjhrwr6KO
	 zAVZYg4+sK1AyE5GLh++hi5QzNffK5Qtt0Qv1UMJqUbtP1Vmp2yxV4OYEkGpaNzEPD
	 HFftmtUYfTT2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 66802C395F8;
	Tue,  2 Jan 2024 13:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] selftest/net: Some more TCP-AO selftest
 post-merge fixups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170420222841.17440.2782571129678540998.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jan 2024 13:30:28 +0000
References: <20231222-selftests-tcp-ao-fixups-v1-0-39c73817c372@arista.com>
In-Reply-To: <20231222-selftests-tcp-ao-fixups-v1-0-39c73817c372@arista.com>
To: Dmitry Safonov <dima@arista.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 0x7f454c46@gmail.com, liuhangbin@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 22 Dec 2023 01:59:05 +0000 you wrote:
> Note that there's another post-merge fix for TCP-AO selftests, but that
> doesn't conflict with these, so I don't resend that:
> 
> https://lore.kernel.org/all/20231219-b4-tcp-ao-selftests-out-of-tree-v1-1-0fff92d26eac@arista.com/T/#u
> 
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] selftest/tcp-ao: Set routes in a proper VRF table id
    https://git.kernel.org/netdev/net-next/c/72cd9f8d5a99
  - [net-next,2/2] selftest/tcp-ao: Work on namespace-ified sysctl_optmem_max
    https://git.kernel.org/netdev/net-next/c/80057b2080a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



