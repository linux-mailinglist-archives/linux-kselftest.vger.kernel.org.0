Return-Path: <linux-kselftest+bounces-2248-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DB4819655
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 02:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DE591C2571E
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 01:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2399D5CBB;
	Wed, 20 Dec 2023 01:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwG44T51"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B4AFC06;
	Wed, 20 Dec 2023 01:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5BFF5C433CA;
	Wed, 20 Dec 2023 01:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703035825;
	bh=ZrNoIh29HSTlJOYdA5duZSg9G5/8jsY1BPip+euLb+U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JwG44T515OOs2PbyRLEZiKieywVD6225ABxcba+1ehwDyy2cBP+3J+6h/lq3wnvoz
	 /DXxsKKqlrAEiKmM3D3hkWFM17ys5Nh8Ea+PtSVfkcb/9F6MTqyji5Zi/uENWLX8sR
	 /BgEemUIHlqb2kiVBbaobqEw0THYujxtXvXhFUnbHH0Gv7bnsB9aPLVIT0yGFv1f+F
	 ICEwCq+nTqf7EQSGjLTugtSCGciGDZli+ipM2AGRp4IZ5TU1N5MWqweQsOi/fRkx2Y
	 /iAq3Mxz8dOKbgMbpLnKttLkOLCor2su5v3u6LdDwHyZwyZZ/FP5w4kcEUsW0UTQWR
	 UkBhPrjwNLyWA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3E8E5C561EE;
	Wed, 20 Dec 2023 01:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/4] bpf: support to track BPF_JNE
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170303582525.28294.7293109481883503225.git-patchwork-notify@kernel.org>
Date: Wed, 20 Dec 2023 01:30:25 +0000
References: <20231219134800.1550388-1-menglong8.dong@gmail.com>
In-Reply-To: <20231219134800.1550388-1-menglong8.dong@gmail.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 alexei.starovoitov@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, martin.lau@linux.dev, song@kernel.org,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 mykolal@fb.com, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 19 Dec 2023 21:47:56 +0800 you wrote:
> For now, the reg bounds is not handled for BPF_JNE case, which can cause
> the failure of following case:
> 
>   /* The type of "a" is u32 */
>   if (a > 0 && a < 100) {
>     /* the range of the register for a is [0, 99], not [1, 99],
>      * and will cause the following error:
>      *
>      *   invalid zero-sized read
>      *
>      * as a can be 0.
>      */
>     bpf_skb_store_bytes(skb, xx, xx, a, 0);
>   }
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/4] bpf: make the verifier tracks the "not equal" for regs
    https://git.kernel.org/bpf/bpf-next/c/d028f87517d6
  - [bpf-next,v5,2/4] selftests/bpf: remove reduplicated s32 casting in "crafted_cases"
    https://git.kernel.org/bpf/bpf-next/c/1de584832375
  - [bpf-next,v5,3/4] selftests/bpf: activate the OP_NE logic in range_cond()
    https://git.kernel.org/bpf/bpf-next/c/31d9cc96b1e3
  - [bpf-next,v5,4/4] selftests/bpf: add testcase to verifier_bounds.c for BPF_JNE
    https://git.kernel.org/bpf/bpf-next/c/463ea64eb008

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



