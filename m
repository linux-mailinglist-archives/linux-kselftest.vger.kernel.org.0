Return-Path: <linux-kselftest+bounces-2884-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0994E82B9CD
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 04:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 300361C236B0
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 03:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28A3139A;
	Fri, 12 Jan 2024 03:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="my31i/Z4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5A3136B;
	Fri, 12 Jan 2024 03:00:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8E72C433C7;
	Fri, 12 Jan 2024 03:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705028447;
	bh=zXeYoAgg1Gny/6BTNUuxDse5agMCghbKe4l+4jpUdX0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=my31i/Z4TsqIpo+UxhKr4Mar/ykDjndLkCJNNFzc+3f9fAGZer0iCEY87ygReLLWb
	 RH9KtNbiZcUJwxpc5ckkSxJXe31YUPLSj9KPhgNwV0jTirHUlFo6jJ6Jqt8jykdciH
	 lta4Chs7UW5bT7BmvoB9z34BkQSwPk2CX2hAvvEy1ecalGfBArro7BuhixKNYsP4uj
	 a5k7tLeYTYNLi2TBZigD8IbA9UPbQzd7PqCT3QDGYuO4DG4/t/tAMtgUv0AcOnPS9R
	 sI9pBPJ5EP76OBudEQMzpHuGCuEHboTKBdrD6kzvKG310b5vnRfyLAcquBKdyvlJx+
	 Iu5qK1OYSkC2g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0605D8C96E;
	Fri, 12 Jan 2024 03:00:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 00/15] Improvements for tracking scalars in the
 BPF verifier
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170502844684.24601.17326225284234857035.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jan 2024 03:00:46 +0000
References: <20240108205209.838365-1-maxtram95@gmail.com>
In-Reply-To: <20240108205209.838365-1-maxtram95@gmail.com>
To: Maxim Mikityanskiy <maxtram95@gmail.com>
Cc: eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, shung-hsi.yu@suse.com, john.fastabend@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 mykolal@fb.com, shuah@kernel.org, davem@davemloft.net, kuba@kernel.org,
 hawk@kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, maxim@isovalent.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  8 Jan 2024 22:51:54 +0200 you wrote:
> From: Maxim Mikityanskiy <maxim@isovalent.com>
> 
> The goal of this series is to extend the verifier's capabilities of
> tracking scalars when they are spilled to stack, especially when the
> spill or fill is narrowing. It also contains a fix by Eduard for
> infinite loop detection and a state pruning optimization by Eduard that
> compensates for a verification complexity regression introduced by
> tracking unbounded scalars. These improvements reduce the surface of
> false rejections that I saw while working on Cilium codebase.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,01/15] selftests/bpf: Fix the u64_offset_to_skb_data test
    https://git.kernel.org/bpf/bpf-next/c/02fb00d34de1
  - [bpf-next,v2,02/15] bpf: make infinite loop detection in is_state_visited() exact
    https://git.kernel.org/bpf/bpf-next/c/3a96c705f48a
  - [bpf-next,v2,03/15] selftests/bpf: check if imprecise stack spills confuse infinite loop detection
    https://git.kernel.org/bpf/bpf-next/c/723909ae6496
  - [bpf-next,v2,04/15] bpf: Make bpf_for_each_spilled_reg consider narrow spills
    https://git.kernel.org/bpf/bpf-next/c/0e00a9551c61
  - [bpf-next,v2,05/15] selftests/bpf: Add a test case for 32-bit spill tracking
    https://git.kernel.org/bpf/bpf-next/c/221dffec93e8
  - [bpf-next,v2,06/15] bpf: Add the assign_scalar_id_before_mov function
    https://git.kernel.org/bpf/bpf-next/c/85b6e9d75c8e
  - [bpf-next,v2,07/15] bpf: Add the get_reg_width function
    https://git.kernel.org/bpf/bpf-next/c/b08973e4d9c4
  - [bpf-next,v2,08/15] bpf: Assign ID to scalars on spill
    https://git.kernel.org/bpf/bpf-next/c/26b560765e67
  - [bpf-next,v2,09/15] selftests/bpf: Test assigning ID to scalars on spill
    https://git.kernel.org/bpf/bpf-next/c/5a052eb509e9
  - [bpf-next,v2,10/15] bpf: Track spilled unbounded scalars
    https://git.kernel.org/bpf/bpf-next/c/53ac20c9e0dd
  - [bpf-next,v2,11/15] selftests/bpf: Test tracking spilled unbounded scalars
    https://git.kernel.org/bpf/bpf-next/c/9ba80a06cabb
  - [bpf-next,v2,12/15] bpf: Preserve boundaries and track scalars on narrowing fill
    (no matching commit)
  - [bpf-next,v2,13/15] selftests/bpf: Add test cases for narrowing fill
    (no matching commit)
  - [bpf-next,v2,14/15] bpf: Optimize state pruning for spilled scalars
    (no matching commit)
  - [bpf-next,v2,15/15] selftests/bpf: states pruning checks for scalar vs STACK_{MISC,ZERO}
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



