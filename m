Return-Path: <linux-kselftest+bounces-30081-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3889DA7B1FA
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 00:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B01D87A76BE
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 22:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1AC1DF721;
	Thu,  3 Apr 2025 22:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghXcijl5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017ED1DE8A5;
	Thu,  3 Apr 2025 22:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743718802; cv=none; b=aNLA/2LMoQVwervVVdt1Gsi/Kp6Ywb4lN6zmc74BpBS+hYGB9fgCSnVua07EfsdAtFFekS6oVBbAe0hTCMvbDoh6u1uoJ33WzGqkT89TRiQ0V0f+XtRh0Mm2eKgvZoUDkhkR5P/lP6MoxjCyya5RACO5NP2Ocx5TrFsESUUPtyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743718802; c=relaxed/simple;
	bh=KCyh8+9JyuYBei8WB62qFtgrhc58EZrZTkUcsFfLPro=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FApOd3AuMHVhsbjZPnYXhwLaNagu+iZUXscLCLmimc/TZl6jHlGuVFICLuhjzYaMusOy9Yh38YqNFLnQBFIMgX2iKba/DYBxz1h/+drz3VOmRZP2y6LFwe5m8FyiiKRH2TlZ7Euy+Ot/T1mpaB65XGHsTq/dOWfPIdL4JiUkA28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghXcijl5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39C8C4CEE3;
	Thu,  3 Apr 2025 22:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743718801;
	bh=KCyh8+9JyuYBei8WB62qFtgrhc58EZrZTkUcsFfLPro=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ghXcijl5DsA64XBakK5GZReIVkouk8DPSuzayMQ+wpewU9xagYbKoS4JehTZ3X51P
	 1b7jUFE3W0DLBngLqDSPY1ve063PZJpbMItOzNrxUvwtkUKNfchRPkkL7xMbW/DdQe
	 G6RbMomFoqRMO1pbdTxuEPSAZcdUm2o8uRcWsECfp0BgMfbeliBc7SkWkLbSsGI8q2
	 UsyIHD+j4j9eU4VCLnnS3VWUZWCEINRs9n4tCeLxS8sxTcvzvWlRMQJgkzkR61eaRH
	 r4CtTYH2ARnzBs4P1M9NioNqKqIc1f9CApRvurFAKT4b6DHPlL0pPtswT2wkgTg2cB
	 i8TFe+Yxo8EkA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEB4380664C;
	Thu,  3 Apr 2025 22:20:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/selftests: Add loopback link local route for
 self-connect
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174371883849.2702664.8391877286405723636.git-patchwork-notify@kernel.org>
Date: Thu, 03 Apr 2025 22:20:38 +0000
References: <20250402-tcp-ao-selfconnect-flake-v1-1-8388d629ef3d@gmail.com>
In-Reply-To: <20250402-tcp-ao-selfconnect-flake-v1-1-8388d629ef3d@gmail.com>
To: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 02 Apr 2025 01:59:31 +0100 you wrote:
> From: Dmitry Safonov <0x7f454c46@gmail.com>
> 
> self-connect-ipv6 got slightly flaky on netdev:
> > # timeout set to 120
> > # selftests: net/tcp_ao: self-connect_ipv6
> > # 1..5
> > # # 708[lib/setup.c:250] rand seed 1742872572
> > # TAP version 13
> > # # 708[lib/proc.c:213]    Snmp6            Ip6OutNoRoutes: 0 => 1
> > # not ok 1 # error 708[self-connect.c:70] failed to connect()
> > # ok 2 No unexpected trace events during the test run
> > # # Planned tests != run tests (5 != 2)
> > # # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:1
> > ok 1 selftests: net/tcp_ao: self-connect_ipv6
> 
> [...]

Here is the summary with links:
  - [net-next] net/selftests: Add loopback link local route for self-connect
    https://git.kernel.org/netdev/net/c/e5ddf19dbc3e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



