Return-Path: <linux-kselftest+bounces-21836-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 207929C4B6D
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 02:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1301F236AC
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 01:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F392D204940;
	Tue, 12 Nov 2024 01:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6/rJx87"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F9E204933;
	Tue, 12 Nov 2024 01:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731373224; cv=none; b=DiCfknQW1qp6tX6+gY4SkSQ5jguWy2/Ick6iQsrb75Rk0hyuuGQLWpmvkU8nDdhFAA8VvjTZgFOaWne0rM4HL8PeSN3NCqcd7HjDKlxifH57OTLHhL8RKG8UlXiasTsyXhnXBzLV8XRgan0fPgzPjAozPpikIoEfESAZjbDtN+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731373224; c=relaxed/simple;
	bh=f6WJXrTRDikhQIj250Wnzzvx7X2r/wsegb+H7jPT+kI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OYD6mIivpk8dlC9VHOVrw2L9YibwrUi48LoK7oNEy/zPMfmwKBRG3k8oClg2qT64AIzKmoMiqAsf9lYkBDxDCQ3WDJ51q91SXIx6VMeiFu/MVpov3Ac05hGvTWKF99hO+VFy33TFOwrLuyxAsxHHFp0BOx/sYeKY3b8V11oMlBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6/rJx87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2983BC4CECF;
	Tue, 12 Nov 2024 01:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731373224;
	bh=f6WJXrTRDikhQIj250Wnzzvx7X2r/wsegb+H7jPT+kI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h6/rJx871zpDPJ/Ca+zhF31lB5gWaSHsaGBByy/qf9lBzMVz/FA54LKkzkyQaJzAA
	 /WVvk2D3IVfWM3SxynRcoJE76y/cmj05JlJOKdSb4g6aJVKJTyF6kx7jUFrSXmJ6Xj
	 f2Sn7mBMusNAIx5bkndiAOcbe0ppwU2FA+NN/AHisv+0FcTeM3XdFSPcY7TCwb/QWD
	 6SrlUl/zhqqW8lrliuzaaDNeW/9s95UQHj2CeB7oakRaDVUx5kh42Zpaql3QWJ0GO0
	 C9LaOGiNlkgzDumvtaaNjrPy6rUTojDbeUGuCGzG2Xq8+n3bDL+VNpM6HAIsmLEAvK
	 sLKRGur/fWJgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713313809A80;
	Tue, 12 Nov 2024 01:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/4] Introduce VLAN support in HSR
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173137323399.33228.10298561607881644376.git-patchwork-notify@kernel.org>
Date: Tue, 12 Nov 2024 01:00:33 +0000
References: <20241106091710.3308519-1-danishanwar@ti.com>
In-Reply-To: <20241106091710.3308519-1-danishanwar@ti.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: geliang@kernel.org, liuhangbin@gmail.com, jiri@resnulli.us,
 w-kwok2@ti.com, aleksander.lobakin@intel.com, lukma@denx.de,
 jan.kiszka@siemens.com, diogo.ivo@siemens.com, shuah@kernel.org,
 horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com, vigneshr@ti.com,
 rogerq@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 6 Nov 2024 14:47:06 +0530 you wrote:
> This series adds VLAN support to HSR framework.
> This series also adds VLAN support to HSR mode of ICSSG Ethernet driver.
> 
> Changes from v2 to v3:
> *) Modified hsr_ndo_vlan_rx_add_vid() to handle arbitrary HSR_PT_SLAVE_A,
> HSR_PT_SLAVE_B order and skip INTERLINK port in patch 2/4 as suggested by
> Paolo Abeni <pabeni@redhat.com>
> *) Removed handling of HSR_PT_MASTER in hsr_ndo_vlan_rx_kill_vid() as MASTER
> and INTERLINK port will be ignored anyway in the default switch case as
> suggested by Paolo Abeni <pabeni@redhat.com>
> *) Modified the selftest in patch 4/4 to use vlan by default. The test will
> check the exposed feature `vlan-challenged` and if vlan is not supported, skip
> the vlan test as suggested by Paolo Abeni <pabeni@redhat.com>. Test logs can be
> found at [1]
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/4] net: hsr: Add VLAN support
    https://git.kernel.org/netdev/net-next/c/d977d7eb09fe
  - [net-next,v3,2/4] net: hsr: Add VLAN CTAG filter support
    https://git.kernel.org/netdev/net-next/c/1a8a63a5305e
  - [net-next,v3,3/4] net: ti: icssg-prueth: Add VLAN support for HSR mode
    https://git.kernel.org/netdev/net-next/c/e6bf1f7aea4d
  - [net-next,v3,4/4] selftests: hsr: Add test for VLAN
    https://git.kernel.org/netdev/net-next/c/75e3f12fa51b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



