Return-Path: <linux-kselftest+bounces-27124-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDB9A3EA3B
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 02:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2621888BB5
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 01:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3DC70807;
	Fri, 21 Feb 2025 01:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXepqXaR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198761876;
	Fri, 21 Feb 2025 01:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740102010; cv=none; b=sfEAn5Z0Bf6Lg5C30SxrHKeod7X2v9xl3py4VBkm2vLFPkyejQVkIURwqCegpjynZwznIZGmkVR24ieXgs33CzELtqG+4IGKQH2qegveq+NRly4ppqO3Lu9Hh+YRHOs3RpFgb5qGGynO01nXjHNhMmCwrcd0Pz/wDVZD4nqCR5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740102010; c=relaxed/simple;
	bh=btDMxeNfHBPNti2EoCCt/T314QWXygFwMOmYrLNf9ro=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=djo5vOACBqzafSV1s+YdL2Mj3wYJFF+LnQ0SxzfuXuBGz2O0m0QvPAOYdXeyIu5vModFjzeU6uQZPmFJb732Jg74KUE957mhi2O6w+1YqREr3cWEN2nit5oY394768Lp0UYJfn3Uhg6qdtVwXOa+lHEODjZhKd21oRkTBUUJ248=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXepqXaR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72347C4CED1;
	Fri, 21 Feb 2025 01:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740102009;
	bh=btDMxeNfHBPNti2EoCCt/T314QWXygFwMOmYrLNf9ro=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MXepqXaRM4dVPsZFOEB7ouyCJSGm2Meq4q/xIOE+jd15D6NGJv5MlJ11lOtELov26
	 vb6Qo/vCHwGaWuM6j+aECkThrTXqJuj9n4Co8AF/jGKjsrhioPuVmOveu2YTkIbu8Q
	 wk8fBvXTzPE9xVv3mHz9ZKEHZsm4VYbRYMV3C/tftMDf4OyJPnoTk9+/nJmJOcmIN5
	 qTPKkOO8pMG98R/rr+JkAKcE2wHkRz5SR+PgOMhg28NxWpGz07teN/RQ+DsvRHUrxj
	 JHI03CieeTQBe9pXC9MrKEU1Ekw0EKKEd1dz/sbBXjosAXPCXyksjvP1fO+R97RMjj
	 Gwyk8ilUJvQFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71AB6380CEE2;
	Fri, 21 Feb 2025 01:40:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v12 0/5] xsk: TX metadata Launch Time support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174010204026.1539943.5735764109259382582.git-patchwork-notify@kernel.org>
Date: Fri, 21 Feb 2025 01:40:40 +0000
References: <20250216093430.957880-1-yoong.siang.song@intel.com>
In-Reply-To: <20250216093430.957880-1-yoong.siang.song@intel.com>
To: Song Yoong Siang <yoong.siang.song@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, willemb@google.com,
 florian.bezdeka@siemens.com, donald.hunter@gmail.com, corbet@lwn.net,
 bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, andrew+netdev@lunn.ch, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 jdamato@fastly.com, sdf@fomichev.me, xuanzhuo@linux.alibaba.com,
 almasrymina@google.com, danielj@nvidia.com, andrii@kernel.org,
 eddyz87@gmail.com, mykolal@fb.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, shuah@kernel.org, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, mcoquelin.stm32@gmail.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, faizal.abdul.rahim@linux.intel.com,
 yong.liang.choong@linux.intel.com, zdenek.bouska@siemens.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, intel-wired-lan@lists.osuosl.org,
 xdp-hints@xdp-project.net

Hello:

This series was applied to bpf/bpf-next.git (net)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Sun, 16 Feb 2025 17:34:25 +0800 you wrote:
> This series expands the XDP TX metadata framework to allow user
> applications to pass per packet 64-bit launch time directly to the kernel
> driver, requesting launch time hardware offload support. The XDP TX
> metadata framework will not perform any clock conversion or packet
> reordering.
> 
> Please note that the role of Tx metadata is just to pass the launch time,
> not to enable the offload feature. Users will need to enable the launch
> time hardware offload feature of the device by using the respective
> command, such as the tc-etf command.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v12,1/5] xsk: Add launch time hardware offload support to XDP Tx metadata
    https://git.kernel.org/bpf/bpf-next/c/ca4419f15abd
  - [bpf-next,v12,2/5] selftests/bpf: Add launch time request to xdp_hw_metadata
    https://git.kernel.org/bpf/bpf-next/c/6164847e5403
  - [bpf-next,v12,3/5] net: stmmac: Add launch time support to XDP ZC
    https://git.kernel.org/bpf/bpf-next/c/04f64dea1364
  - [bpf-next,v12,4/5] igc: Refactor empty frame insertion for launch time support
    https://git.kernel.org/bpf/bpf-next/c/f9b53bb13923
  - [bpf-next,v12,5/5] igc: Add launch time support to XDP ZC
    https://git.kernel.org/bpf/bpf-next/c/d7c3a7ff7502

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



