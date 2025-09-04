Return-Path: <linux-kselftest+bounces-40789-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CD1B44253
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 18:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13D7E7B8221
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 16:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277712F83C4;
	Thu,  4 Sep 2025 16:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ezc+eqS+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5F82F548E;
	Thu,  4 Sep 2025 16:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757002212; cv=none; b=GT5X9GjxC3uxeUO0rpaIhQREnYA6xWar8eKzA+D9bZEqEq7IMJMVa8qHyto9Bd1NivifAhB5lLGckAMR9YICTvsNdQXRE/h/EdckjmxgdnziRhEWDHAgcH1Pr2zVvaYMZcdvSv82PNIvHakR4+1+fmbUiW3XJ8wcDr8hrHQe+tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757002212; c=relaxed/simple;
	bh=GGym9Lxf6iE9ulUma7yXlr7vjN+hD4oUGuaYIy7oBm8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I9VbyLbhATfb8xDTNk4rY2wcn3RhDGBNvmBBj3Z8BFiMzUB/kBCObHLWH46lDkh+EuoOlciQsHh+XXJypqJIw2FoqaCLMvK56RKSIGQhdjCQ/vah9PvW8pmpPxJy8VwNWVWfLZfTHL5pKd3RNw2POnn+KB1+qQ6WW8wKqYF1jHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ezc+eqS+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64EF8C4CEF0;
	Thu,  4 Sep 2025 16:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757002211;
	bh=GGym9Lxf6iE9ulUma7yXlr7vjN+hD4oUGuaYIy7oBm8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ezc+eqS+HgvEw7RiUcLHz0jxhRNDV3b1TFX7eSTUEnsAIv8DFV6VjvQNeAno3tuzq
	 oXJ/LgIRrjse1haeb5bcE8G7oS8LMpas5E8vDjJOKheXnxYArG4/GQkHx2/mpDS5ox
	 yVCy/Kafe2QxaGIslm0C9uKVxT6XYssHw39imuwndi92bwutkKkoJfsR89gZ+xsQ6m
	 o0QWlPVjYuvSxHlmB9sZkZ2VqHYZ6gUMhdx5nAVVWCJj+Ylexk/Z/pqA8oSTJeCTL/
	 piITn9fPaFIPIwjx2NaF/1jr8t/ooFoKDsvIPVEyFMJe5glePdjO0gfc39Na7FpX6L
	 6LLwfaz87qoAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71095383BF69;
	Thu,  4 Sep 2025 16:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND bpf-next v3 0/3] selftests/bpf: benchmark all
 symbols
 for kprobe-multi
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175700221625.1866840.605670175098866606.git-patchwork-notify@kernel.org>
Date: Thu, 04 Sep 2025 16:10:16 +0000
References: <20250904021011.14069-1-dongml2@chinatelecom.cn>
In-Reply-To: <20250904021011.14069-1-dongml2@chinatelecom.cn>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: andrii@kernel.org, olsajiri@gmail.com, eddyz87@gmail.com, mykolal@fb.com,
 ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 yikai.lin@vivo.com, memxor@gmail.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  4 Sep 2025 10:10:08 +0800 you wrote:
> Add the benchmark testcase "kprobe-multi-all", which will hook all the
> kernel functions during the testing.
> 
> This series is separated out from [1].
> 
> Changes since V2:
> * add some comment to attach_ksyms_all, which notes that don't run the
>   testing on a debug kernel
> 
> [...]

Here is the summary with links:
  - [RESEND,bpf-next,v3,1/3] selftests/bpf: move get_ksyms and get_addrs to trace_helpers.c
    https://git.kernel.org/bpf/bpf-next/c/8bad31edf549
  - [RESEND,bpf-next,v3,2/3] selftests/bpf: skip recursive functions for kprobe_multi
    https://git.kernel.org/bpf/bpf-next/c/adf6b57ce46c
  - [RESEND,bpf-next,v3,3/3] selftests/bpf: add benchmark testing for kprobe-multi-all
    https://git.kernel.org/bpf/bpf-next/c/a85d888768ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



