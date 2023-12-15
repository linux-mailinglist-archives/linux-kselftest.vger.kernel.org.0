Return-Path: <linux-kselftest+bounces-1977-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B432813F30
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 02:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B8471F22C40
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 01:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8C1650;
	Fri, 15 Dec 2023 01:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUx7byr3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3235E36F;
	Fri, 15 Dec 2023 01:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96382C433C9;
	Fri, 15 Dec 2023 01:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702603825;
	bh=jtcofboF/4WRkBgEMaFOO3hoqYqlP2cYDQy7vfXOtb8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kUx7byr3SsEs7Wq7NG9IdkE4P24QeqVM8UaxMNJ3Um/2ZdvgPDRJTkVijgaFP+6Cf
	 CWbnMgzaPZLVUn/zXczIfIG6JSBab/BbR2NVbjev1y/KUAZSeZyqX8rJafM2mQxTCR
	 ojn7f08mMdE3/Kw3gi0OIGY4mE9umTwFxFGaRjja2iIeSwT4EpePMm4nin19j6HQtc
	 +sjAO54gLZaEwLENIhc14PMXWwK5QrMtEl4AmKSb8eW7sK/TTRxg0blO3/dWKgT+ZA
	 IVLOQvPZGcXRPgyDoU+GRCFXJ4Wi7gyXHw5OYU0WTapy9u0sqreDyxPzC3qlLZ807d
	 sg5TT3ADD3XoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78E95DD4EFA;
	Fri, 15 Dec 2023 01:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6 0/5] Add bpf_xdp_get_xfrm_state() kfunc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170260382549.15017.6886623501178455100.git-patchwork-notify@kernel.org>
Date: Fri, 15 Dec 2023 01:30:25 +0000
References: <cover.1702593901.git.dxu@dxuuu.xyz>
In-Reply-To: <cover.1702593901.git.dxu@dxuuu.xyz>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 steffen.klassert@secunet.com, antony.antony@secunet.com,
 alexei.starovoitov@gmail.com, yonghong.song@linux.dev, eddyz87@gmail.com,
 eyal.birger@gmail.com, devel@linux-ipsec.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 14 Dec 2023 15:49:01 -0700 you wrote:
> This patchset adds two kfunc helpers, bpf_xdp_get_xfrm_state() and
> bpf_xdp_xfrm_state_release() that wrap xfrm_state_lookup() and
> xfrm_state_put(). The intent is to support software RSS (via XDP) for
> the ongoing/upcoming ipsec pcpu work [0]. Recent experiments performed
> on (hopefully) reproducible AWS testbeds indicate that single tunnel
> pcpu ipsec can reach line rate on 100G ENA nics.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6,1/5] bpf: xfrm: Add bpf_xdp_get_xfrm_state() kfunc
    https://git.kernel.org/bpf/bpf-next/c/8f0ec8c68175
  - [bpf-next,v6,2/5] bpf: selftests: test_tunnel: Setup fresh topology for each subtest
    https://git.kernel.org/bpf/bpf-next/c/77a7a8220f0d
  - [bpf-next,v6,3/5] bpf: selftests: test_tunnel: Use vmlinux.h declarations
    https://git.kernel.org/bpf/bpf-next/c/02b4e126e6a5
  - [bpf-next,v6,4/5] bpf: selftests: Move xfrm tunnel test to test_progs
    https://git.kernel.org/bpf/bpf-next/c/e7adc8291a9e
  - [bpf-next,v6,5/5] bpf: xfrm: Add selftest for bpf_xdp_get_xfrm_state()
    https://git.kernel.org/bpf/bpf-next/c/2cd07b0eb08c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



