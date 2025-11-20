Return-Path: <linux-kselftest+bounces-46060-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 882C2C72246
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 05:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 026C034DB9B
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 04:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A09A2DF146;
	Thu, 20 Nov 2025 04:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2Imk8F6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388BE2264A9;
	Thu, 20 Nov 2025 04:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763611855; cv=none; b=QdPvDor/KSN+y/qvucwHLLLbDh4vPy5+mw1kFhLUAlv0UM8kmYuNhxvpWgaWpcYbmAjHA/MyKPJQd+6zJZwxpTtqKKlIrgNRudeBxjj7hVrV4+yUDijiHVppVjz0C+xZd3hpr6K7XTKleCPA7rVpftkep9DS7SAGeGJXkArElB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763611855; c=relaxed/simple;
	bh=nNkw/HHMttissex3RT39Yy/FGFO9F7e8C5EUg9Ax/Uo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UGYSkAux4H+6jWplV59kmC2YAH8cvvoHFbjvrgpqb+nZcAvlPHJRUVQWrQpYHYM6XRXidNcyzKox0HK1z/i8S9WIiu4Q1n7p4Qpf3dgKqEp9vqDDrIesZQ/LR8a97KF1WbkeVXgmHMMw8WklEjI6wGM4ApaZyPfJ1o9m3/unE+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2Imk8F6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C5AC4CEF1;
	Thu, 20 Nov 2025 04:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763611854;
	bh=nNkw/HHMttissex3RT39Yy/FGFO9F7e8C5EUg9Ax/Uo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F2Imk8F6z3CsyoKSW+n4YscqlO9KPxGSFxWk/ATxEXCOzepoCp2P3nhDdJZLG7hRh
	 kX8JFXweXwbmiweAJL6YC6HJBezQt5V6A+U6bS4JRLzSO38sUHnuDkZUyqPkm1Vbxc
	 IxDZ6/gZSXdovY8mUITzvVEz7stNDZLuauXFPhRmfL6GYMEUyE2x2SvACYTFvA/lik
	 BMl9IXqNtSuMcWZL6fjMwpntSTU0bfIArxoVhJefwlfMf2o4Fw98xR7Iz7cv5z7vB9
	 uN9hg7mAlWPNcek1zzGhsbcNzOUMf8BiCRdEeZsPP4SbEsS9zAiblh7Lzur0OoKB72
	 c0p/djP4gL/Ww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7145439EF974;
	Thu, 20 Nov 2025 04:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 00/11] mptcp: misc fixes for v6.18-rc7
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176361182026.1072863.12495916598448618920.git-patchwork-notify@kernel.org>
Date: Thu, 20 Nov 2025 04:10:20 +0000
References: 
 <20251118-net-mptcp-misc-fixes-6-18-rc6-v1-0-806d3781c95f@kernel.org>
In-Reply-To: 
 <20251118-net-mptcp-misc-fixes-6-18-rc6-v1-0-806d3781c95f@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, fw@strlen.de, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org, yangang@kylinos.cn

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Nov 2025 08:20:18 +0100 you wrote:
> Here are various unrelated fixes:
> 
> - Patch 1: Fix window space computation for fallback connections which
>   can affect ACK generation. A fix for v5.11.
> 
> - Patch 2: Avoid unneeded subflow-level drops due to unsynced received
>   window. A fix for v5.11.
> 
> [...]

Here is the summary with links:
  - [net,01/11] mptcp: fix ack generation for fallback msk
    https://git.kernel.org/netdev/net/c/5e15395f6d9e
  - [net,02/11] mptcp: avoid unneeded subflow-level drops
    https://git.kernel.org/netdev/net/c/4f102d747cad
  - [net,03/11] mptcp: fix premature close in case of fallback
    https://git.kernel.org/netdev/net/c/17393fa7b708
  - [net,04/11] mptcp: do not fallback when OoO is present
    https://git.kernel.org/netdev/net/c/1bba3f219c5e
  - [net,05/11] mptcp: decouple mptcp fastclose from tcp close
    https://git.kernel.org/netdev/net/c/fff0c8799667
  - [net,06/11] mptcp: fix duplicate reset on fastclose
    https://git.kernel.org/netdev/net/c/ae155060247b
  - [net,07/11] selftests: mptcp: join: fastclose: remove flaky marks
    https://git.kernel.org/netdev/net/c/efff6cd53ac5
  - [net,08/11] selftests: mptcp: join: endpoints: longer timeout
    https://git.kernel.org/netdev/net/c/fb13c6bb810c
  - [net,09/11] selftests: mptcp: join: userspace: longer timeout
    https://git.kernel.org/netdev/net/c/0e4ec14dc1ee
  - [net,10/11] mptcp: fix address removal logic in mptcp_pm_nl_rm_addr
    https://git.kernel.org/netdev/net/c/92e239e36d60
  - [net,11/11] selftests: mptcp: add a check for 'add_addr_accepted'
    https://git.kernel.org/netdev/net/c/0eee0fdf9b7b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



