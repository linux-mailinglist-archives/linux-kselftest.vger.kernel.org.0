Return-Path: <linux-kselftest+bounces-17176-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D130F96C898
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 22:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31901B2079C
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 20:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C719154BE0;
	Wed,  4 Sep 2024 20:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYnTW1ev"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7133E62A02;
	Wed,  4 Sep 2024 20:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481832; cv=none; b=oNNGM6M+BZcvavoXflHjEKw6KXT3CIYhCDzduSFtyXQmpoVTynCUHi6XsmLF+qNt+X2WP/Tnz1pfjjAmKAPcnbUAHfgQ8yLwHUmvotQpHkGPbgpkMLUCLABEoA6SQmlBbAk5Q6RMA6gE5fKOy8dEfzwp6vbJ2+y3meKOzbLyFnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481832; c=relaxed/simple;
	bh=2FeNiLbsQe/94HyRbvl5xiOZZe5KxKxfYZU0jFSsaPA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rNGGeADtmzoC0QPRAoMPNTyh0UD5j0Vjkngzl9Sf/xNkvHzQrhsU6jF9+j5+tPBsADjb/bG59Uu8uFIdyDdKcR5UbGAfzj3rmt8MJUl8FpK+K7+furUQLNyM5Yd0FNQymJr0zCi7eFTMKnLb47NE8ZCl8mPbg6UqDnYzN11+gfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYnTW1ev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92F9C4CECA;
	Wed,  4 Sep 2024 20:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725481832;
	bh=2FeNiLbsQe/94HyRbvl5xiOZZe5KxKxfYZU0jFSsaPA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pYnTW1evBmUFfQLOcu9bV6tMSxDPPri++QwMWq2Zqnto2cF4X58zsd5rSoeKbFoEU
	 N8VgmhFZoCisgrVozJnlDFy4wU1UuKE4EHnlXaApry33kK2CIpiJVCWNzZD9w/jC0d
	 j+8avtmXDZafDrhzq2s2FVNZ2vF3tVwwwQJ/a/AiGmtT6fdCA+4WVljb0uToEGgJLG
	 /mwylo/tnKrqSVp2M6OpHWW6gfp4Vb0hbjbOSick+pEnlJ1pcmkBiOXM6xLypjdem2
	 BTn2Rbplg2hfiZ78GrBwDZg7AL8yyxOzDDwveyHcFXA9dfgHwtLvlHFvlxk7PWdxP+
	 wqAiK1TSLIzbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB11E3822D30;
	Wed,  4 Sep 2024 20:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests: bpf: Replace sizeof(arr)/sizeof(arr[0]) with
 ARRAY_SIZE
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172548183250.1158691.8977955400396448785.git-patchwork-notify@kernel.org>
Date: Wed, 04 Sep 2024 20:30:32 +0000
References: <20240903072559.292607-1-yangfeng59949@163.com>
In-Reply-To: <20240903072559.292607-1-yangfeng59949@163.com>
To: yangfeng <yangfeng59949@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue,  3 Sep 2024 15:25:59 +0800 you wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
> 
> The ARRAY_SIZE macro is more compact and more formal in linux source.
> 
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> ---
>  tools/testing/selftests/bpf/prog_tests/fexit_stress.c        | 3 ++-
>  tools/testing/selftests/bpf/prog_tests/log_buf.c             | 5 +++--
>  .../testing/selftests/bpf/prog_tests/module_fentry_shadow.c  | 3 ++-
>  .../bpf/prog_tests/raw_tp_writable_reject_nbd_invalid.c      | 3 ++-
>  .../selftests/bpf/prog_tests/raw_tp_writable_test_run.c      | 5 +++--
>  tools/testing/selftests/bpf/prog_tests/tc_opts.c             | 2 +-
>  tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c | 3 ++-
>  tools/testing/selftests/bpf/progs/syscall.c                  | 3 ++-
>  tools/testing/selftests/bpf/progs/test_rdonly_maps.c         | 3 ++-
>  tools/testing/selftests/bpf/progs/verifier_bits_iter.c       | 2 +-
>  10 files changed, 20 insertions(+), 12 deletions(-)

Here is the summary with links:
  - selftests: bpf: Replace sizeof(arr)/sizeof(arr[0]) with ARRAY_SIZE
    https://git.kernel.org/bpf/bpf-next/c/23457b37ec3f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



