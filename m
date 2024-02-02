Return-Path: <linux-kselftest+bounces-4051-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 807A2847B82
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 22:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 323E92906F7
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 21:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD0A81751;
	Fri,  2 Feb 2024 21:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwAyS874"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5F57C0B9;
	Fri,  2 Feb 2024 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706909429; cv=none; b=qPih27I7JBt9U+j4d++yVAJQWy1lJUjbCmusFuh84qC4St7Uj8fvcg0zeOkYwRsC09aSfwJZvHMBgR2RakGaFNbyRbkWxdn5CFGrWZTGF+XbEr33qGHR27KQJHvQQeZi9UrsHJ3uwgVSjEQV1wNb+ALhoGYdvpVuujgViQP4f5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706909429; c=relaxed/simple;
	bh=v56A7tIQPuHlG+irb7rZnIZfGnhBn+AGY94HikYcQ2o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I9M/z9cPyWQdwBWZ/r0ZljTSJz7drPPhDRaXLA6/q6j6DBJaTQvuMeB+HzJhSf1eMK/3UJfaAQfbBVwGE5LRAiRi46I1v9CeTI9gzTIOkDD/2ULAQd9kKWAz7tTh3iVozgaaNMn5e35M890thjLdU1gQ9MyR32HfBpWgRDX3IC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwAyS874; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29586C43390;
	Fri,  2 Feb 2024 21:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706909429;
	bh=v56A7tIQPuHlG+irb7rZnIZfGnhBn+AGY94HikYcQ2o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AwAyS874oIHV5p30xFYq1JV07Z6ZPK5FBkU0ZQtKFL0XmagipQokhxrw1/uWJqHRO
	 UZB9sxaIdMotx8nyZBuazWpxb5O3H75fv41LAxN2PjMshs/FaMxX4UkiXwMvUjXedZ
	 ANvwiSqyLrALh6eYQ6cQ9G5LjlV3nN/MLD2Fg/pKutU02QcQJsFZ1RjQ8cV1HxFspg
	 0VyPGFS5HlnPHwPWohwABxOSksqrgGuQxaAHpLh8/1wdSNXJyMrirwVaZkhOQ+mYzY
	 yGdSX/hD/0Fm3CC2nglrnEdFiLmH8ie1v7v1s/ymgObJNHfIfIegr3gciP+nP6px7h
	 6b6z/kghHMl+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0BDACC04E32;
	Fri,  2 Feb 2024 21:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/6] Improvements for tracking scalars in the BPF
 verifier
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170690942904.20598.1069790224577035855.git-patchwork-notify@kernel.org>
Date: Fri, 02 Feb 2024 21:30:29 +0000
References: <20240127175237.526726-1-maxtram95@gmail.com>
In-Reply-To: <20240127175237.526726-1-maxtram95@gmail.com>
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
by Andrii Nakryiko <andrii@kernel.org>:

On Sat, 27 Jan 2024 19:52:31 +0200 you wrote:
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
  - [bpf-next,v3,1/6] bpf: Track spilled unbounded scalars
    https://git.kernel.org/bpf/bpf-next/c/e67ddd9b1cff
  - [bpf-next,v3,2/6] selftests/bpf: Test tracking spilled unbounded scalars
    https://git.kernel.org/bpf/bpf-next/c/6be503cec6c9
  - [bpf-next,v3,3/6] bpf: Preserve boundaries and track scalars on narrowing fill
    https://git.kernel.org/bpf/bpf-next/c/c1e6148cb4f8
  - [bpf-next,v3,4/6] selftests/bpf: Add test cases for narrowing fill
    https://git.kernel.org/bpf/bpf-next/c/067313a85c6f
  - [bpf-next,v3,5/6] bpf: handle scalar spill vs all MISC in stacksafe()
    https://git.kernel.org/bpf/bpf-next/c/6efbde200bf3
  - [bpf-next,v3,6/6] selftests/bpf: states pruning checks for scalar vs STACK_MISC
    https://git.kernel.org/bpf/bpf-next/c/73a28d9d000e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



