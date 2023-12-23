Return-Path: <linux-kselftest+bounces-2410-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F6681D0E8
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Dec 2023 02:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13ADB1C224D4
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Dec 2023 01:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47282645;
	Sat, 23 Dec 2023 01:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxnIR1Oj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243431368;
	Sat, 23 Dec 2023 01:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91B11C433C9;
	Sat, 23 Dec 2023 01:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703293827;
	bh=u75DN3s2OPwUPSX6ZbFKV/tG2RZIBlNRA4FZBD+I1Ss=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jxnIR1OjSuNcMTMGFa7J8mOHMZygrB+UlmEmoyhNTuHvsJpDWOvSByleDRIpLShdu
	 mIetg5OIUzjZON1o9+7fpdulGJ5VTf/jqc9hBk5WW7uDVwh9E8aWcNxWp8NRKSVPqb
	 SCOT8mQFVIeb2uuHi0B3QBYeYzgjczTf94yHEqeIEdrpDZFIXh0rfRpdWB5b0ok0/g
	 I/91kbDCgE8zDaAzuwv5vINa9o3+g09CwaoZrm+YvclbkrR4RuGnxO4fMSXGXVoWyd
	 z/4aME7Ue0G/Kgt8VhpZA4rr5cz6DcyE0A59tcpo5kw6EmMkaOHGA6ECtV4Rcxfu/3
	 SUcVPc7Nse6pQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78D8BC41620;
	Sat, 23 Dec 2023 01:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v11 00/10] net: ethernet: am65-cpsw: Add mqprio,
 frame preemption & coalescing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170329382749.26300.2655743385787592194.git-patchwork-notify@kernel.org>
Date: Sat, 23 Dec 2023 01:10:27 +0000
References: <20231219105805.80617-1-rogerq@kernel.org>
In-Reply-To: <20231219105805.80617-1-rogerq@kernel.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, vladimir.oltean@nxp.com,
 s-vadapalli@ti.com, r-gunasekaran@ti.com, vigneshr@ti.com, srk@ti.com,
 horms@kernel.org, p-varis@ti.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 19 Dec 2023 12:57:55 +0200 you wrote:
> Hi,
> 
> This series adds mqprio qdisc offload in channel mode,
> Frame Preemption MAC merge support and RX/TX coalesing
> for AM65 CPSW driver.
> 
> In v11 following changes were made
> - Fix patch "net: ethernet: ti: am65-cpsw: add mqprio qdisc offload in channel mode"
> by including units.h
> 
> [...]

Here is the summary with links:
  - [net-next,v11,01/10] selftests: forwarding: ethtool_mm: support devices with higher rx-min-frag-size
    https://git.kernel.org/netdev/net-next/c/2491d66ae66c
  - [net-next,v11,02/10] selftests: forwarding: ethtool_mm: fall back to aggregate if device does not report pMAC stats
    https://git.kernel.org/netdev/net-next/c/c8659bd9d1c0
  - [net-next,v11,03/10] net: ethernet: am65-cpsw: Build am65-cpsw-qos only if required
    https://git.kernel.org/netdev/net-next/c/c92b1321bbf3
  - [net-next,v11,04/10] net: ethernet: am65-cpsw: Rename TI_AM65_CPSW_TAS to TI_AM65_CPSW_QOS
    https://git.kernel.org/netdev/net-next/c/d0f9535b3182
  - [net-next,v11,05/10] net: ethernet: am65-cpsw: cleanup TAPRIO handling
    https://git.kernel.org/netdev/net-next/c/5db81bdc486d
  - [net-next,v11,06/10] net: ethernet: ti: am65-cpsw: Move code to avoid forward declaration
    https://git.kernel.org/netdev/net-next/c/1374841ad477
  - [net-next,v11,07/10] net: ethernet: am65-cpsw: Move register definitions to header file
    https://git.kernel.org/netdev/net-next/c/8f5a75610698
  - [net-next,v11,08/10] net: ethernet: ti: am65-cpsw: add mqprio qdisc offload in channel mode
    https://git.kernel.org/netdev/net-next/c/bc8d62e16ec2
  - [net-next,v11,09/10] net: ethernet: ti: am65-cpsw-qos: Add Frame Preemption MAC Merge support
    https://git.kernel.org/netdev/net-next/c/49a2eb906824
  - [net-next,v11,10/10] net: ethernet: ti: am65-cpsw: add sw tx/rx irq coalescing based on hrtimers
    https://git.kernel.org/netdev/net-next/c/e4918f9d4882

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



