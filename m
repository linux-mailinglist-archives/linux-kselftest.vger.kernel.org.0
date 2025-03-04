Return-Path: <linux-kselftest+bounces-28210-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 298ADA4E1EB
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 15:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A58F1188AB29
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 14:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEF92620D4;
	Tue,  4 Mar 2025 14:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZLWl/t3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B583E25F98D;
	Tue,  4 Mar 2025 14:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099800; cv=none; b=WAy4rAaCfMy1mBQTC5dFhM5cd1h1quYwIAlGqqkk8EjypyUr27mO1UNC2Y5T2gC/RFcZA7eqEpjFpcDZOUOrV9k0kphBHOKt1sbkGM71AqBt0UE83L1eaL/hnJv76+xdKF+n9lVXfM8V0XwxOhqDfc555nPCZuZlI9CG2eljwZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099800; c=relaxed/simple;
	bh=iHjkyEOwAJNsi2EtZYCaCGQOASUoDIn5YqQ9oOR4Y/U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uqVBk9caYvpJYUr393NcWDS9uOi7Di+l9nqO3bJg4y0CRemWGJdPo2q+pwhieAygVbOkF+tl1N+9zW6bczwp+ZGVu030xU1N1pEsSucwRdqL1ayS0KH/LCOl4x6WciP2qC6MF07obWpCmq62/K1Cy+ERpR+LlBMIsfD6TSAxbYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZLWl/t3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2095AC4CEE5;
	Tue,  4 Mar 2025 14:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741099800;
	bh=iHjkyEOwAJNsi2EtZYCaCGQOASUoDIn5YqQ9oOR4Y/U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qZLWl/t3sC0XsH8r7kXYJJPQzrVYn59BsW3dT+Jh8xz3AxJekxgByK1yF8AlThyNC
	 aXZ6YZ9m8a8Xx6oJd+a64woIcZe354w1tGK0kePdOsIBwOm3CdrjSmuvg0djNZrVHs
	 PVZTGWAOoZZznhfK121kU38QalZy99CRIZxkZIB56k3+syrgfswPpIELunW7wOD3e/
	 imxOT/B4fDSMvK8llM76GIDF8RF8c/9wRyi2wbGS1PRP5AzGRnYOazb/dd0RtRWgZR
	 YeVum9qo19qpbm5nBGJUoYVq+nMrWeJpHoSwv7cPZ7bXU8dc8mvdlf6bLLvVQLgj3d
	 ShoSESDHynL4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D89380AA7F;
	Tue,  4 Mar 2025 14:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/8] netconsole: Add taskname sysdata support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174109983302.170664.16431215519500952572.git-patchwork-notify@kernel.org>
Date: Tue, 04 Mar 2025 14:50:33 +0000
References: <20250228-netcons_current-v2-0-f53ff79a0db2@debian.org>
In-Reply-To: <20250228-netcons_current-v2-0-f53ff79a0db2@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 shuah@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@meta.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 28 Feb 2025 04:50:16 -0800 you wrote:
> This patchset introduces a new feature to the netconsole extradata
> subsystem that enables the inclusion of the current task's name in the
> sysdata output of netconsole messages.
> 
> This enhancement is particularly valuable for large-scale deployments,
> such as Meta's, where netconsole collects messages from millions of
> servers and stores them in a data warehouse for analysis. Engineers
> often rely on these messages to investigate issues and assess kernel
> health.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/8] netconsole: prefix CPU_NR sysdata feature with SYSDATA_
    https://git.kernel.org/netdev/net-next/c/8a683295c226
  - [net-next,v2,2/8] netconsole: Make boolean comparison consistent
    https://git.kernel.org/netdev/net-next/c/efb878fbe8d1
  - [net-next,v2,3/8] netconsole: refactor CPU number formatting into separate function
    https://git.kernel.org/netdev/net-next/c/4d989521a93b
  - [net-next,v2,4/8] netconsole: add taskname to extradata entry count
    https://git.kernel.org/netdev/net-next/c/33e4b29f2b3b
  - [net-next,v2,5/8] netconsole: add configfs controls for taskname sysdata feature
    https://git.kernel.org/netdev/net-next/c/09e877590bc2
  - [net-next,v2,6/8] netconsole: add task name to extra data fields
    https://git.kernel.org/netdev/net-next/c/dd30ae533242
  - [net-next,v2,7/8] netconsole: docs: document the task name feature
    https://git.kernel.org/netdev/net-next/c/7010b619830f
  - [net-next,v2,8/8] netconsole: selftest: add task name append testing
    https://git.kernel.org/netdev/net-next/c/d7a2522426e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



