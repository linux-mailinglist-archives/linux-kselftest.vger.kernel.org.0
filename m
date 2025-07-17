Return-Path: <linux-kselftest+bounces-37457-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B847B08167
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 02:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 940281C27202
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 00:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BB8481DD;
	Thu, 17 Jul 2025 00:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ar/zduBn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E119460;
	Thu, 17 Jul 2025 00:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752712191; cv=none; b=J3K+fv0n3mjTWDD7J8gwXlpItR2xaTG2brKgLJPmmXV+6VyLu47n3GCWsS71uXTnwLqlQnUy37rAnJ9j5y8Bba3oyhIs5Yafkf2RfLK2GiFOiH5UpkXKxDvkyQA2ZuRFxdlIxM1o3TF07kpy0IWN+UHnNzpCQ06HZDz944vwT+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752712191; c=relaxed/simple;
	bh=gL7Z1M0HVgjTlVZJDpBe179+As3uy4yzCurXcAfgnLk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=POJzkBpkx4uZtML+sv3geixVzSCcm/2CPXWO3SwndVm+NkRUvpMHbBJd+3c0UxI1yHY3y2PDrjkZxIwPfZR8+2ekKvq61F3BSGoY+DFwQtdoIZLi0mJ1BjrV77MuiXPznUtVE4ePJlLQSPyi5E4GxpCRI8bgH16fi4GDFCJBMUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ar/zduBn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859E4C4CEE7;
	Thu, 17 Jul 2025 00:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752712190;
	bh=gL7Z1M0HVgjTlVZJDpBe179+As3uy4yzCurXcAfgnLk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ar/zduBnFZKEUGQAiOS/78L4Wwm/b9XE3n0wqJ0GF535hiYgTcDtIvhW2HA69rLz7
	 D1yawRI/tAt3tB2TjkqAYGocT3+K4ToXf0u215bSmREIkdl8QWVV3wYb49MFpN0TDH
	 B84tPKrQRnRO89MTwP7sRteaHBZAeKX+q4JyZJVH/smNc506KWV2IvC48WSIMFmBlh
	 PkXAia1IV7jB6YwoNcgWKrqnssAE8yHOmNuUX7n89yMf3GvrV2wPqLnKIOvARk+A9k
	 U2f4dzPZ67XvDfHqzM21gMqd4MgAVomiwNhwPZ10koHBLaK/XEuqh7zvx7NwGlT+3W
	 IuieD1wdZJQqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB147383BA38;
	Thu, 17 Jul 2025 00:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 0/3] selftest: net: Add selftest for netpoll
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175271221077.1374954.5388109861761060959.git-patchwork-notify@kernel.org>
Date: Thu, 17 Jul 2025 00:30:10 +0000
References: <20250714-netpoll_test-v7-0-c0220cfaa63e@debian.org>
In-Reply-To: <20250714-netpoll_test-v7-0-c0220cfaa63e@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, horms@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 bpf@vger.kernel.org, kernel-team@meta.com, willemb@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Jul 2025 02:56:47 -0700 you wrote:
> I am submitting a new selftest for the netpoll subsystem specifically
> targeting the case where the RX is polling in the TX path, which is
> a case that we don't have any test in the tree today. This is done when
> netpoll_poll_dev() called, and this test creates a scenario when that is
> probably.
> 
> The test does the following:
> 
> [...]

Here is the summary with links:
  - [net-next,v7,1/3] selftests: drv-net: add helper/wrapper for bpftrace
    https://git.kernel.org/netdev/net-next/c/3c561c547c39
  - [net-next,v7,2/3] selftests: drv-net: Strip '@' prefix from bpftrace map keys
    https://git.kernel.org/netdev/net-next/c/fd2aadcefbac
  - [net-next,v7,3/3] selftests: net: add netpoll basic functionality test
    https://git.kernel.org/netdev/net-next/c/b3019343e4bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



